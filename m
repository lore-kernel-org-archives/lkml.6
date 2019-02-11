Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C51CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3385220836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfBKUCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:02:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfBKUCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:02:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF3B358E22;
        Mon, 11 Feb 2019 20:02:07 +0000 (UTC)
Received: from sky.random (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 714BD5C21A;
        Mon, 11 Feb 2019 20:02:01 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:02:00 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Restore change_pte optimization to its former
 glory
Message-ID: <20190211200200.GA30128@redhat.com>
References: <20190131183706.20980-1-jglisse@redhat.com>
 <20190201235738.GA12463@redhat.com>
 <20190211190931.GA3908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190931.GA3908@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 11 Feb 2019 20:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:09:31PM -0500, Jerome Glisse wrote:
> Yeah, between do you have any good workload for me to test this ? I
> was thinking of running few same VM and having KSM work on them. Is
> there some way to trigger KVM to fork ? As the other case is breaking
> COW after fork.

KVM can fork on guest pci-hotplug events or network init to run host
scripts and re-init the signals before doing the exec, but it won't
move the needle because all guest memory registered in the MMU
notifier is set as MADV_DONTFORK... so fork() is a noop unless qemu is
also modified not to call MADV_DONTFORK.

Calling if (!fork()) exit(0) from a timer at regular intervals during
qemu runtime after turning off MADV_DONTFORK in qemu would allow to
exercise fork against the KVM MMU Notifier methods.

The optimized change_pte code in copy-on-write code is the same
post-fork or post-KSM merge and fork() itself doesn't use change_pte
while KSM does, so with regard to change_pte it should already provide
a good test coverage to test with only KSM without fork(). It'll cover
the read-write -> readonly transition with same PFN
(write_protect_page), the read-only to read-only changing PFN
(replace_page) as well as the readonly -> read-write transition
changing PFN (wp_page_copy) all three optimized with change_pte. Fork
would not leverage change_pte for the first two cases.
