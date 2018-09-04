Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5061120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5061120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIDSNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:13:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38867 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeIDSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:13:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so4055990wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 06:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7ulNTfv3If66pLg7eDs4djWY29Kp70QE+8oqE/8vKk=;
        b=SXe9emx6dz8NJVnhn/EN3q8dh4ZbMoNUGUhCRhjLuv998nK4WlmtEX+Z5jSoaEpc+O
         x/LiusaPEHctnHkkCpbtY9mCVmcbq3hJwCy7OD4bqYJnQw/6o/HZ378JBNgpDUp6xQpY
         gFHQLZ6hjM5b51ICHgHN9qFQu+dMA1NoubQvzZARyZrosOo0WNZXsGpNxbnPKDX5sex7
         pfgTRRLWrlOMkfK7S48fy9cFVcFB7LHrLDO7sizewbhS0D9lT/QTL084bD9k3E1YIH/p
         NVgwZZGTZgTvwN1ZbXs6Flxo/M6KvvgDcFd1l6JeOTNm/CP4LBcGiB/cV+aKG7WKDSTa
         9Kjg==
X-Gm-Message-State: APzg51DgDPpYo2iulWHfKuuu1bBan23EsbvYD857VrrUjXHFWLeeqzmV
        Vuf2W9VfAE3PX1YZsIDZWRJxGg==
X-Google-Smtp-Source: ANB0VdZLiV8IR/hOn2Yvad2ou8PwC1MJAPqJgPnprlESmxpbLpcIyESxeIsGrjE1LHNpZNIyVBoAlQ==
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr11299279wro.60.1536068872028;
        Tue, 04 Sep 2018 06:47:52 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id y17-v6sm14745782wrh.49.2018.09.04.06.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 06:47:51 -0700 (PDT)
Date:   Tue, 4 Sep 2018 15:47:48 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180904134748.GA4974@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-15-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/08/18 14:53, Patrick Bellasi wrote:
> The number of clamp groups supported is limited and defined at compile
> time. However, a malicious user can currently ask for many different

Even if not malicious.. :-)

> clamp values thus consuming all the available clamp groups.
> 
> Since on properly configured systems we expect only a limited set of
> different clamp values, the previous problem can be mitigated by
> allowing access to clamp groups configuration only to privileged tasks.
> This should still allow a System Management Software to properly
> pre-configure the system.
> 
> Let's restrict the tuning of utilization clamp values, by default, to
> tasks with CAP_SYS_ADMIN capabilities.
> 
> Whenever this should be considered too restrictive and/or not required
> for a specific platforms, a kernel boot option is provided to change
> this default behavior thus allowing non privileged tasks to change their
> utilization clamp values.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> Changes in v4:
>  Others:
>  - new patch added in this version
>  - rebased on v4.19-rc1
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +++
>  kernel/sched/core.c                           | 22 ++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9871e649ffef..481f8214ea9a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4561,6 +4561,9 @@
>  			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
>  			See also Documentation/input/devices/joystick-parport.rst
>  
> +	uclamp_user	[KNL] Enable task-specific utilization clamping tuning
> +			also from tasks without CAP_SYS_ADMIN capability.
> +
>  	udbg-immortal	[PPC] When debugging early kernel crashes that
>  			happen after console_init() and before a proper
>  			console driver takes over, this boot options might
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 222397edb8a7..8341ce580a9a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1510,14 +1510,29 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
>  static inline void free_uclamp_sched_group(struct task_group *tg) { }
>  #endif /* CONFIG_UCLAMP_TASK_GROUP */
>  
> +static bool uclamp_user_allowed __read_mostly;
> +static int __init uclamp_user_allow(char *str)
> +{
> +	uclamp_user_allowed = true;
> +
> +	return 0;
> +}
> +early_param("uclamp_user", uclamp_user_allow);
> +
>  static inline int __setscheduler_uclamp(struct task_struct *p,
> -					const struct sched_attr *attr)
> +					const struct sched_attr *attr,
> +					bool user)

Wondering if you want to fold the check below inside the

 if (user && !capable(CAP_SYS_NICE)) {
   ...
 }

block. It would also save you from adding another parameter to the
function.

>  {
>  	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
>  	int lower_bound, upper_bound;
>  	struct uclamp_se *uc_se;
>  	int result = 0;
>  
> +	if (!capable(CAP_SYS_ADMIN) &&
> +	    user && !uclamp_user_allowed) {
> +		return -EPERM;
> +	}
> +

Best,

- Juri
