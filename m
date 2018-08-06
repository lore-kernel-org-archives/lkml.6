Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E50C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7E21A32
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXjl8eIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE7E21A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbeHFTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:00:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHFTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NvGQhNJMx9wuXGsgGxJ6w/feqMHwYic2rr5nrgRVonU=; b=DXjl8eIyGP0iIgVwLpmyev+xMk
        E/uD9Yp7EiO11DKMdTkwiQpKbe7NTiybY3HB9GESNs44JyhO4oZ0X7liz4RvSKE6qKntL7ILne+26
        nAGLvOqzknJ41Qo5G7ACpDA09gGOjNXstTSLF1W36IrTGO4L7Ksfy2tqOEY1mO22wKAWghNewMy9q
        xK1ERkU08MeQ1KaBhbC0nwDdVgzC1eYkQpEqiR3NQBKx68TiRLrHtD7SpecUdP8KYogViCHQGarAI
        un1c1WArpjXRIe3Y7DdboE7lJnrsHvObJkV4xXvANTtw+NHfN+p0KYvipH52dR8vzdL6+zSZy5zY4
        qWU+n2TA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmii8-0002af-Hf; Mon, 06 Aug 2018 16:50:24 +0000
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d8a3d533-84df-bfc7-96ae-790141be4926@infradead.org>
Date:   Mon, 6 Aug 2018 09:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806163946.28380-2-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/06/2018 09:39 AM, Patrick Bellasi wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..1d45a6877d6f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
>  config GENERIC_SCHED_CLOCK
>  	bool
>  
> +menu "Scheduler features"
> +
> +config UCLAMP_TASK
> +	bool "Enable utilization clamping for RT/FAIR tasks"
> +	depends on CPU_FREQ_GOV_SCHEDUTIL
> +	default false

	default n
but just omit the line completely since "n" is already the default.

> +	help
> +	  This feature enables the scheduler to track the clamped utilization
> +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> +
> +	  When this option is enabled, the user can specify a min and max CPU
> +          bandwidth which is allowed for a task.
> +	  The max bandwidth allows to clamp the maximum frequency a task can
> +	  use, while the min bandwidth allows to define a minimum frequency a
> +          task will always use.

Please clean up the indentation above to use one tab + 2 spaces on all lines.

> +
> +	  If in doubt, say N.
> +
> +endmenu


thanks,
-- 
~Randy
