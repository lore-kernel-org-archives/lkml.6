Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E52ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733DF20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733DF20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeGQL53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731256AbeGQL52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:57:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CDD6ADB3;
        Tue, 17 Jul 2018 11:25:16 +0000 (UTC)
Date:   Tue, 17 Jul 2018 13:25:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, linux@endlessm.com,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180717112515.GE7193@dhcp22.suse.cz>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180716155745.10368-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716155745.10368-1-drake@endlessm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-07-18 10:57:45, Daniel Drake wrote:
> Hi Johannes,
> 
> Thanks for your work on psi! 
> 
> We have also been investigating the "thrashing problem" on our Endless
> desktop OS. We have seen that systems can easily get into a state where the
> UI becomes unresponsive to input, and the mouse cursor becomes extremely
> slow or stuck when the system is running out of memory. We are working with
> a full GNOME desktop environment on systems with only 2GB RAM, and
> sometimes no real swap (although zram-swap helps mitigate the problem to
> some extent).
> 
> My analysis so far indicates that when the system is low on memory and hits
> this condition, the system is spending much of the time under
> __alloc_pages_direct_reclaim. "perf trace -F" shows many many page faults
> in executable code while this is going on. I believe the kernel is
> swapping out executable code in order to satisfy memory allocation
> requests, but then that swapped-out code is needed a moment later so it
> gets swapped in again via the page fault handler, and all this activity
> severely starves the system from being able to respond to user input.
> 
> I appreciate the kernel's attempt to keep processes alive, but in the
> desktop case we see that the system rarely recovers from this situation,
> so you have to hard shutdown. In this case we view it as desirable that
> the OOM killer would step in (it is not doing so because direct reclaim
> is not actually failing).

Yes this is really unfortunate. One thing that could help would be to
consider a trashing level during the reclaim (get_scan_count) to simply
forget about LRUs which are constantly refaulting pages back. We already
have the infrastructure for that. We just need to plumb it in.
-- 
Michal Hocko
SUSE Labs
