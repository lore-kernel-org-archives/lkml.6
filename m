Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9BEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60C20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60C20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGQLsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:48:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730000AbeGQLsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:48:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5376CAED8;
        Tue, 17 Jul 2018 11:16:09 +0000 (UTC)
Date:   Tue, 17 Jul 2018 13:16:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ufo19890607@gmail.com
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v14 1/2] Reorganize the oom report in dump_header
Message-ID: <20180717111608.GC7193@dhcp22.suse.cz>
References: <1531825548-27761-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531825548-27761-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-07-18 19:05:47, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> OOM report contains several sections. The first one is the allocation
> context that has triggered the OOM. Then we have cpuset context
> followed by the stack trace of the OOM path. Followed by the oom
> eligible tasks and the information about the chosen oom victim.
> 
> One thing that makes parsing more awkward than necessary is that we do
> not have a single and easily parsable line about the oom context. This
> patch is reorganizing the oom report to
> 1) who invoked oom and what was the allocation request
> 	[  131.751307] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
> 
> 2) OOM stack trace
> 	[  131.752399] CPU: 16 PID: 8581 Comm: panic Not tainted 4.18.0-rc5+ #48
> 	[  131.753154] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
> 	[  131.753806] Call Trace:
> 	[  131.754473]  dump_stack+0x5a/0x73
> 	[  131.755129]  dump_header+0x53/0x2dc
> 	[  131.755775]  oom_kill_process+0x228/0x420
> 	[  131.756430]  ? oom_badness+0x2a/0x130
> 	[  131.757063]  out_of_memory+0x11a/0x4a0
> 	[  131.757710]  __alloc_pages_slowpath+0x7cc/0xa1e
> 	[  131.758392]  ? apic_timer_interrupt+0xa/0x20
> 	[  131.759040]  __alloc_pages_nodemask+0x277/0x290
> 	[  131.759710]  alloc_pages_vma+0x73/0x180
> 	[  131.760388]  do_anonymous_page+0xed/0x5a0
> 	[  131.761067]  __handle_mm_fault+0xbb3/0xe70
> 	[  131.761749]  handle_mm_fault+0xfa/0x210
> 	[  131.762457]  __do_page_fault+0x233/0x4c0
> 	[  131.763136]  do_page_fault+0x32/0x140
> 	[  131.763832]  ? page_fault+0x8/0x30
> 	[  131.764523]  page_fault+0x1e/0x30
> 
> 3) oom context (contrains and the chosen victim).
> 	[  131.771164] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,task=panic,pid=8608,uid=0
> 
> An admin can easily get the full oom context at a single line which
> makes parsing much easier.
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. you can usually keep Acked-by for such a small change. If you are
not sure just ask off list.

> ---
> Changes since v13:
> - remove the spaces for printing pid and uid.
-- 
Michal Hocko
SUSE Labs
