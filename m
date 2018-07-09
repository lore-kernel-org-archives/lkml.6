Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76670C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367AD20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367AD20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeGIIT0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:19:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754457AbeGIITY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:19:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B15B5ACF5;
        Mon,  9 Jul 2018 08:19:22 +0000 (UTC)
Date:   Mon, 9 Jul 2018 10:19:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180709081920.GD22049@dhcp22.suse.cz>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530905572-817-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-07-18 15:32:45, Waiman Long wrote:
[...]
> A rogue application can potentially create a large number of negative
> dentries in the system consuming most of the memory available if it
> is not under the direct control of a memory controller that enforce
> kernel memory limit.

How does this differ from other untracked allocations for untrusted
tasks in general? E.g. nothing really prevents a task to create a long
chain of unreclaimable dentries and even go to OOM potentially. Negative
dentries should be easily reclaimable on the other hand. So why does the
later needs a special treatment while the first one is ok? There are
quite some resources which allow a non privileged user to consume a lot
of memory and the memory controller is the only reliable way to mitigate
the risk.

> This patchset introduces changes to the dcache subsystem to track and
> optionally limit the number of negative dentries allowed to be created by
> background pruning of excess negative dentries or even kill it after use.
> This capability will help to limit the amount of memory that can be
> consumed by negative dentries.

How are you going to balance that between workload? What prevents a
rogue application to simply consume the limit and force all others in
the system to go slow path?

> Patch 1 tracks the number of negative dentries present in the LRU
> lists and reports it in /proc/sys/fs/dentry-state.

If anything I _think_ vmstat would benefit from this because behavior of
the memory reclaim does depend on the amount of neg. dentries.

> Patch 2 adds a "neg-dentry-pc" sysctl parameter that can be used to to
> specify a soft limit on the number of negative allowed as a percentage
> of total system memory. This parameter is 0 by default which means no
> negative dentry limiting will be performed.

percentage has turned out to be a really wrong unit for many tunables
over time. Even 1% can be just too much on really large machines.

> Patch 3 enables automatic pruning of least recently used negative
> dentries when the total number is close to the preset limit.

Please explain why this cannot be done in a standard dcache shrinking
way. I strongly suspect that you are developing yet another reclaim with
its own sets of tunable and bypassing the existing infrastructure. I
haven't read patches yet but the cover letter doesn't really explain
design much so I am only guessing.
-- 
Michal Hocko
SUSE Labs
