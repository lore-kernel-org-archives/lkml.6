Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4592455E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4592455E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGCLDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752552AbeGCLDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A7A4AFC9;
        Tue,  3 Jul 2018 11:03:43 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:03:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
Message-ID: <20180703110335.GH16767@dhcp22.suse.cz>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
 <20180702101732.GD19043@dhcp22.suse.cz>
 <CAHCio2h1G5UDRv_veWbzRAMtM+NheyVfsghoC3G80BJgOtuW7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2h1G5UDRv_veWbzRAMtM+NheyVfsghoC3G80BJgOtuW7g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 18:57:14, 禹舟键 wrote:
> Hi Michal
> cpuset_print_current_mems_allowed is also invoked by
> warn_alloc(page_alloc.c). So, can I remove the current->comm output in
> the pr_info ?
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d8b12e0d39cd..09b8ef6186c6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2666,9 +2666,9 @@ void cpuset_print_current_mems_allowed(void)
>         rcu_read_lock();
> 
>         cgrp = task_cs(current)->css.cgroup;
> -       pr_info("%s cpuset=", current->comm);
> +       pr_info(",cpuset=");
>         pr_cont_cgroup_name(cgrp);
> -       pr_cont(" mems_allowed=%*pbl\n",
> +       pr_cont(",mems_allowed=%*pbl",
>                 nodemask_pr_args(&current->mems_allowed));

Yes, I think so. Just jam the cpuset info to the allocation context
warning like this

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..6bc7d5d4007a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3416,12 +3416,13 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	pr_warn("%s: %pV, mode:%#x(%pGg), nodemask=%*pbl\n",
+	pr_warn("%s: %pV, mode:%#x(%pGg), nodemask=%*pbl",
 			current->comm, &vaf, gfp_mask, &gfp_mask,
 			nodemask_pr_args(nodemask));
 	va_end(args);
 
 	cpuset_print_current_mems_allowed();
+	pr_cont("\n");
 
 	dump_stack();
 	warn_alloc_show_mem(gfp_mask, nodemask);
-- 
Michal Hocko
SUSE Labs
