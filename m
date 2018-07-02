Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE1225C2F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE1225C2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965416AbeGBKRi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:17:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965036AbeGBKRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:17:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF873ADA4;
        Mon,  2 Jul 2018 10:17:34 +0000 (UTC)
Date:   Mon, 2 Jul 2018 12:17:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ufo19890607@gmail.com
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
Message-ID: <20180702101732.GD19043@dhcp22.suse.cz>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-07-18 00:38:58, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The current system wide oom report prints information about the victim
> and the allocation context and restrictions. It, however, doesn't
> provide any information about memory cgroup the victim belongs to. This
> information can be interesting for container users because they can find
> the victim's container much more easily.
> 
> I follow the advices of David Rientjes and Michal Hocko, and refactor
> part of the oom report. After this patch, users can get the memcg's
> path from the oom report and check the certain container more quickly.
> 
> The oom print info after this patch:
> oom-kill:constraint=<constraint>,nodemask=<nodemask>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>

This changelog doesn't correspond to the patch. Also while we were
discussing this off-list, I have suggested to pull the cpuset info into
the single line output.

What about the following?
"
OOM report contains several sections. The first one is the allocation
context that has triggered the OOM. Then we have cpuset context
followed by the stack trace of the OOM path. Followed by the oom
eligible tasks and the information about the chosen oom victim.

One thing that makes parsing more awkward than necessary is that we do
not have a single and easily parsable line about the oom context. This
patch is reorganizing the oom report to
1) who invoked oom and what was the allocation request
	[  126.168182] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0

2) OOM stack trace
	[  126.169806] CPU: 23 PID: 8668 Comm: panic Not tainted 4.18.0-rc2+ #36
	[  126.170494] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
	[  126.171197] Call Trace:
	[  126.171901]  dump_stack+0x5a/0x73
	[  126.172593]  dump_header+0x58/0x2dc
	[  126.173294]  oom_kill_process+0x228/0x420
	[  126.173999]  ? oom_badness+0x2a/0x130
	[  126.174705]  out_of_memory+0x11a/0x4a0
	[  126.175415]  __alloc_pages_slowpath+0x7cc/0xa1e
	[  126.176128]  ? __alloc_pages_slowpath+0x194/0xa1e
	[  126.176853]  ? page_counter_try_charge+0x54/0xc0
	[  126.177580]  __alloc_pages_nodemask+0x277/0x290
	[  126.178319]  alloc_pages_vma+0x73/0x180
	[  126.179058]  do_anonymous_page+0xed/0x5a0
	[  126.179825]  __handle_mm_fault+0xbb3/0xe70
	[  126.180566]  handle_mm_fault+0xfa/0x210
	[  126.181313]  __do_page_fault+0x233/0x4c0
	[  126.182063]  do_page_fault+0x32/0x140
	[  126.182812]  ? page_fault+0x8/0x30
	[  126.183560]  page_fault+0x1e/0x30

3) oom context (contrains and the chosen victim)
	[  126.190619] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,task=panic,pid= 8673,uid=    0

An admin can easily get the full oom context at a single line which
makes parsing much easier.
"
-- 
Michal Hocko
SUSE Labs
