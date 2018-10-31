Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79503C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DC620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeJaWs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:48:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729288AbeJaWs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:48:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89271AF4C;
        Wed, 31 Oct 2018 13:50:50 +0000 (UTC)
Date:   Wed, 31 Oct 2018 14:50:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     ufo19890607@gmail.com
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v15 1/2] Reorganize the oom report in dump_header
Message-ID: <20181031135049.GO32673@dhcp22.suse.cz>
References: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 29-09-18 21:06:26, ufo19890607@gmail.com wrote:
[...]
> Changes since v14:
> - add the dump_oom_summary for the single line output of oom context.
> - fix the null pointer in the dump_header.

I do not remember details about this null ptr but the fix you seemed to
have done is
[...]
> +static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
> +{
> +	/* one line summary of the oom killer context. */
> +	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
> +			oom_constraint_text[oc->constraint],
> +			nodemask_pr_args(oc->nodemask));
> +	cpuset_print_current_mems_allowed();
> +	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
> +		from_kuid(&init_user_ns, task_uid(victim)));
> +}
> +
>  /*
>   * Number of OOM victims in flight
>   */
> @@ -951,6 +960,8 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  
>  	if (__ratelimit(&oom_rs))
>  		dump_header(oc, p);
> +	if (oc)
> +		dump_oom_summary(oc, victim);
>  

this? If yes then this is bogus because oc is never NULL. Besides that,
you used to have this one line summary in dump_header which looks much
better fit to me than oom_kill_process.

-- 
Michal Hocko
SUSE Labs
