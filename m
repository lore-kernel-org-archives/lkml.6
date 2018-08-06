Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB56219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB56219A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeHFIOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:14:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725735AbeHFIOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:14:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31790ADC0;
        Mon,  6 Aug 2018 06:06:52 +0000 (UTC)
Date:   Mon, 6 Aug 2018 08:06:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     Wind Yu <yuzhoujian@didichuxing.com>, rientjes@google.com,
        rong.a.chen@intel.com, sfr@canb.auug.org.au,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [LKP] [mm, oom] c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
Message-ID: <20180806060649.GA19540@dhcp22.suse.cz>
References: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com>
 <CAHCio2idn3oh55n7urkRPqkdyo+Y-0Qhg=Vc2VHXy2Wy2q1wiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2idn3oh55n7urkRPqkdyo+Y-0Qhg=Vc2VHXy2Wy2q1wiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-08-18 11:41:50, 禹舟键 wrote:
> Hi Michal and David,
> AFAICS, the null pointer is the task_struct of p in the dump_header.
> Why don't we just add a if before printing the victim task's
> informaiton.

See http://lkml.kernel.org/r/alpine.DEB.2.21.1807301854040.198273@chino.kir.corp.google.com

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -438,14 +438,6 @@ static void dump_header(struct oom_control *oc,
> struct task_struct *p)
> 
>         cpuset_print_current_mems_allowed();
>         mem_cgroup_print_oom_context(oc->memcg, p);
> -       pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
> -               from_kuid(&init_user_ns, task_uid(p)));
> +      if (p)
> +              pr_cont(",task=%s,pid=%d,uid=%d", p->comm, p->pid,
> +                      from_kuid(&init_user_ns, task_uid(p)));
> +     pr_cont("\n");
>         if (is_memcg_oom(oc))
>                 mem_cgroup_print_oom_meminfo(oc->memcg);
> 
> Thanks
> Zhoujian

-- 
Michal Hocko
SUSE Labs
