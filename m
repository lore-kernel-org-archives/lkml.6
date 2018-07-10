Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D50C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F44D20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F44D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933694AbeGJO1r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933280AbeGJO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 533DFADEC;
        Tue, 10 Jul 2018 14:27:41 +0000 (UTC)
Date:   Tue, 10 Jul 2018 16:27:40 +0200
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
Message-ID: <20180710142740.GQ14284@dhcp22.suse.cz>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-07-18 12:01:04, Waiman Long wrote:
> On 07/09/2018 04:19 AM, Michal Hocko wrote:
[...]
> > later needs a special treatment while the first one is ok? There are
> > quite some resources which allow a non privileged user to consume a lot
> > of memory and the memory controller is the only reliable way to mitigate
> > the risk.
> 
> Yes, memory controller is the only reliable way to mitigate the risk,
> but not all tasks are under the control of a memory controller with
> kernel memory limit.

But those which you do not trust should. So why do we need yet another
mechanism for the reclaim?

[...]
> >> Patch 1 tracks the number of negative dentries present in the LRU
> >> lists and reports it in /proc/sys/fs/dentry-state.
> > If anything I _think_ vmstat would benefit from this because behavior of
> > the memory reclaim does depend on the amount of neg. dentries.
> >
> >> Patch 2 adds a "neg-dentry-pc" sysctl parameter that can be used to to
> >> specify a soft limit on the number of negative allowed as a percentage
> >> of total system memory. This parameter is 0 by default which means no
> >> negative dentry limiting will be performed.
> > percentage has turned out to be a really wrong unit for many tunables
> > over time. Even 1% can be just too much on really large machines.
> 
> Yes, that is true. Do you have any suggestion of what kind of unit
> should be used? I can scale down the unit to 0.1% of the system memory.
> Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
> corresponds to 200k, etc.

I simply think this is a strange user interface. How much is a
reasonable number? How can any admin figure that out?

> >> Patch 3 enables automatic pruning of least recently used negative
> >> dentries when the total number is close to the preset limit.
> > Please explain why this cannot be done in a standard dcache shrinking
> > way. I strongly suspect that you are developing yet another reclaim with
> > its own sets of tunable and bypassing the existing infrastructure. I
> > haven't read patches yet but the cover letter doesn't really explain
> > design much so I am only guessing.
> 
> The standard dcache shrinking happens when the system is almost running
> out of free memory.

Well, the standard reclaim happens when somebody needs memory. We are
usually quite far away from "almost running out of memory". We do
reclaim fs metadata including dentries so I really do not see why
negative ones should be any special here.

> This new shrinker will be turned on when the number
> of negative dentries is closed to the limit even when there are still
> plenty of free memory left. It will stop when the number of negative
> dentries is lowered to a safe level. The new shrinker is designed to
> impose as little overhead to the currently running tasks. That is not
> true for the standard shrinker which will have a rather significant
> performance impact to the currently running tasks.

Do you have any numbers to back your claim? The memory reclaim is
usually quite lightweight. Especially when we have a lot of clean
fs {meta}data

> I can remove the new shrinker if people really don't want to add a new
> one as long as I can keep the option to kill off newly created negative
> dentries when the limit is exceeded.

Please let's not add yet another memory reclaim mechanism. It will just
backfire sooner or later.
-- 
Michal Hocko
SUSE Labs
