Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25983C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4617223E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e55G1Ksg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4617223E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeHJIru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:47:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43695 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeHJIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:47:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so7198409wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FdR6rdke0qLN2sPf5y/eL4/h3v/o2Q1BNuOk1+EvdYo=;
        b=e55G1KsgH1VAY3acbVWBZr48hthMG3Gh67kNxRg0kM1vXagwwnYJgEYA1lJU4dYnZW
         tz2MVaUiP/F/MesJw+yK21Y1a6pWbyjKNr8LCfG+ri8JWtP2c/ibaPr935pPtNzGmDo/
         tco3NcxQGRT3SlkrnePJMpDBdicjziiqYdvAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FdR6rdke0qLN2sPf5y/eL4/h3v/o2Q1BNuOk1+EvdYo=;
        b=CiKcWoMGiPbxneEuS+H5WTgEbb+w1FyBn5Oh/SyaKdlrXpIIIbWPL84GVnlFcvrCwo
         WPhBBKxZnqrSPViXUcKRloT5zZ6ehW4BDUQMXIcxTRUGiAM+Xf+ufFDBIELj1KO1xGe5
         jbIQ3MkHo55Lxb//MWfbkRoF/PwtdLpUlpmvZwK2I0L+nlf+IqbwoWKLkpuvMmQLDsKU
         qryaGyAnyoi/TcqbI5+p2oaYaMKo0RBiX2JU7xN3glcEcwvRbjKPqdR1X+utymi5RSMX
         9rQC4Z82uEYh+qsXqZPQT20DLBn0nw/HFs4IpmjL6xGWKeN6KUt8lx4hfn64MWxKadEu
         GOOA==
X-Gm-Message-State: AOUpUlH21dY+/JeBnH9nXVt2InyBlT3l33B72wM2auZRQYvIU+T9Huos
        qrLltNi6PrQoWf6pniDYKeYmqw==
X-Google-Smtp-Source: AA+uWPz20MxSAtgGmlUjiuxm16DqvRWyWW2ArgLA+WPswAQrat2+NxarEn00pykth8CtgtfD1xN3RA==
X-Received: by 2002:adf:c612:: with SMTP id n18-v6mr3176714wrg.177.1533881965183;
        Thu, 09 Aug 2018 23:19:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id x82-v6sm2075993wmd.11.2018.08.09.23.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 23:19:24 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:19:17 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180810061917.GB11817@leoy-ThinkPad-X240s>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2161372.IsD4PDzmmY@aspire.rjw.lan>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 07:08:34PM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the tick has been stopped already, but the governor has not asked to
> stop it (which it can do sometimes), the idle loop should invoke
> tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> of this case properly.

IMHO, I don't think this patch is on the right way; from the idle loop
side, it needs to provide sane fundamental supports, for example, it
can stop or restart the tick per idle governor's request.  On the
other hand, the idle governors can decide their own policy for how to
use the tick in idle loop.  This patch seems mixes two things and
finally it's possible to couple the implementation between idle loop
and 'menu' governor for sched tick usage.

I still think my patch to restart the tick is valid :)

Thanks,
Leo Yan

> Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -190,7 +190,7 @@ static void cpuidle_idle_call(void)
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick)
> +		if (stop_tick || tick_nohz_tick_stopped())
>  			tick_nohz_idle_stop_tick();
>  		else
>  			tick_nohz_idle_retain_tick();
> 
