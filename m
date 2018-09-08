Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6320652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E6320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeIHSWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:22:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45326 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:22:14 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w88DaDRg046045;
        Sat, 8 Sep 2018 22:36:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Sat, 08 Sep 2018 22:36:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w88Da7Qe046008
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Sep 2018 22:36:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] mm: memcontrol: print proper OOM header when no eligible
 victim left
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180821160406.22578-1-hannes@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <b94f9964-c785-20c1-34af-e9013770b89a@I-love.SAKURA.ne.jp>
Date:   Sat, 8 Sep 2018 22:36:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821160406.22578-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/22 1:04, Johannes Weiner wrote:
> When the memcg OOM killer runs out of killable tasks, it currently
> prints a WARN with no further OOM context. This has caused some user
> confusion.
> 
> Warnings indicate a kernel problem. In a reported case, however, the
> situation was triggered by a non-sensical memcg configuration (hard
> limit set to 0). But without any VM context this wasn't obvious from
> the report, and it took some back and forth on the mailing list to
> identify what is actually a trivial issue.
> 
> Handle this OOM condition like we handle it in the global OOM killer:
> dump the full OOM context and tell the user we ran out of tasks.
> 
> This way the user can identify misconfigurations easily by themselves
> and rectify the problem - without having to go through the hassle of
> running into an obscure but unsettling warning, finding the
> appropriate kernel mailing list and waiting for a kernel developer to
> remote-analyze that the memcg configuration caused this.
> 
> If users cannot make sense of why the OOM killer was triggered or why
> it failed, they will still report it to the mailing list, we know that
> from experience. So in case there is an actual kernel bug causing
> this, kernel developers will very likely hear about it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c |  2 --
>  mm/oom_kill.c   | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 

Now that above patch went to 4.19-rc3, please apply below one.

From eb2bff2ed308da04785bcf541dd3f748286bfa23 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 8 Sep 2018 22:26:28 +0900
Subject: [PATCH] mm, oom: Don't emit noises for failed SysRq-f.

Due to commit d75da004c708c9fc ("oom: improve oom disable handling") and
commit 3100dab2aa09dc6e ("mm: memcontrol: print proper OOM header when
no eligible victim left"), all

  kworker/0:1 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=-1, oom_score_adj=0
  (...snipped...)
  Out of memory and no killable processes...
  OOM request ignored. No task eligible

lines are printed.
Let's not emit "invoked oom-killer" lines when SysRq-f failed.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/oom_kill.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..92122ef 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1106,8 +1106,10 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-		dump_header(oc, NULL);
-		pr_warn("Out of memory and no killable processes...\n");
+		if (!is_sysrq_oom(oc)) {
+			dump_header(oc, NULL);
+			pr_warn("Out of memory and no killable processes...\n");
+		}
 		/*
 		 * If we got here due to an actual allocation at the
 		 * system level, we cannot survive this and will enter
-- 
1.8.3.1


