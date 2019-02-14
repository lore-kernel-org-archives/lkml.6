Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED853C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A5222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9dhbMbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405923AbfBNRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:47:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46190 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392765AbfBNRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:47:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so3508097pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0t1v1OuKZbxtqvHBYBeHW8maDqWGT55mJUN35OAsXkA=;
        b=j9dhbMbxxkZcqdkzc2916PHF6QFB6wAvgmcouEUSD/NxCOJOlStMkTnoxOIl3GLUzF
         L5OGlo80wAkIVsInv2aAw1EpmgGGLfElnticrZ1JAjbNsHWFaVUAukaf3owSYBB820nx
         O4mm0gr5R6ptEfLsJmoj1Z9ErbKX/wPkiuAtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0t1v1OuKZbxtqvHBYBeHW8maDqWGT55mJUN35OAsXkA=;
        b=jhaC/jxjpCAu6pseRN3vBSqveUJG7aKsaUrgcN/wnBD47iC4P5ojFvg7yJ1LKui8yj
         KfubOLv3oi8MX54JDl7+bC0p/8QXAAmpPGndyyzjV2rlNvGMuF5Ce75jLWRb0cve64Jf
         gzAAACEPGJosTrjvetcj5CcO4aLyzO6QFdQPgctr7bcYPlf+vDfMwlC39oNMa3HSyC5r
         Jy87Ny6oW3/rJg8lR9PYJBpDtYJk3I2yxj5PPUc1jW1aYSdxd7SPRS2IrrhMvbCdxaEb
         1qFHzCcUh53fV2BD6LNQgSQdh2b2sXizVc82KwPZT9Qv0TrHDjXLKeGN4iXgrUfPXk5b
         MMdA==
X-Gm-Message-State: AHQUAuauGaTBTBxoE2eAr1afGc4KEb2QHaBn3cgR3x8dMsN9ybdnT3Pc
        GmBYa4N6ceZ1L75OCAS5yrKwzw==
X-Google-Smtp-Source: AHgI3IZWEP9CSyV2PDgCuvjWk5DM9J2s1yTFsLySDxMvrLiS6K4NOEHy4DMi4WOnXeKrR66xymD7Ig==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr5569509pla.229.1550166441213;
        Thu, 14 Feb 2019 09:47:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b9sm4184559pfi.118.2019.02.14.09.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 09:47:20 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:47:19 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 2/4] PM / devfreq: Handle monitor suspend/resume in the
 devfreq core
Message-ID: <20190214174719.GZ117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-3-mka@chromium.org>
 <CAGTfZH29QQCW4ecXy9VbRd3aTixyjbDgB0EE0YwDcQDZYsSCvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGTfZH29QQCW4ecXy9VbRd3aTixyjbDgB0EE0YwDcQDZYsSCvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:10:00PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> 2019년 2월 14일 (목) 오후 7:16, Matthias Kaehlcke <mka@chromium.org>님이 작성:
> >
> > devfreq expects governors to call devfreq_monitor_suspend/resume()
> > in response to DEVFREQ_GOV_SUSPEND/RESUME events. Since the devfreq
> > core itself generates these events and invokes the governor's event
> > handler the suspend/resume of the load monitoring can be done in the
> > common code.
> >
> > Call devfreq_monitor_suspend/resume() when the governor reports a
> > successful handling of DEVFREQ_GOV_SUSPEND/RESUME and remove these
> > calls from the simpleondemand and tegra governors. Make
> > devfreq_monitor_suspend/resume() static since these functions are now
> > only used by the devfreq core.
> 
> The devfreq core generates the all events including
> DEVFREQ_GOV_START/STOP/INTERVAL.
> It is possible to make 'devfreq_monitor_*()' function as the static
> instead of exported function.
> And call them in devfreq.c as this patch as following:
> 
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -728,6 +728,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>                 goto err_init;
>         }
> 
> +       devfreq_monitor_start(devfreq);
> +
>         list_add(&devfreq->node, &devfreq_list);
> 
>         mutex_unlock(&devfreq_list_lock);
> @@ -760,6 +762,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
>         if (devfreq->governor)
>                 devfreq->governor->event_handler(devfreq,
>                                                  DEVFREQ_GOV_STOP, NULL);
> +       devfreq_monitor_stop(devfreq);
>         device_unregister(&devfreq->dev);
> 
>         return 0;
> @@ -1259,6 +1262,9 @@ static ssize_t polling_interval_store(struct device *dev,
>         df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
>         ret = count;
> 
> +       if (!ret)
> +               devfreq_interval_update(devfreq, (unsigned int *)data);
> +
>         return ret;
>  }
>  static DEVICE_ATTR_RW(polling_interval);
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 79efa1e..515fb85 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct
> devfreq *devfreq,
> 
>         switch (event) {
>         case DEVFREQ_GOV_START:
> -               devfreq_monitor_start(devfreq);
>                 tegra_actmon_enable_interrupts(tegra);
>                 break;
> 
>         case DEVFREQ_GOV_STOP:
>                 tegra_actmon_disable_interrupts(tegra);
> -               devfreq_monitor_stop(devfreq);
>                 break;

indeed, that's similar to "[4/4] PM / devfreq: Handle monitor
start/stop in the devfreq core" of this series.

> Instead,
> 
> If the governor should execute some codes before and after of
> DEVFREQ_GOV_SUSPEND, DEVFREQ_GOV_RESUME,
> it is impossible to change the order between devfreq_monitor_*() function
> and the specific governor in the event_handler callback function of
> each governor.
> 
> For example, if some govenor requires the following sequencue,
> after this patch, it is not possible.
> 
> case DEVFREQ_GOV_SUSPEND:
>         /* execute some code before devfreq_monitor_suspend() */
>         devfreq_monitor_suspend()
>         /* execute some code after devfreq_monitor_suspend() */

I agree that the patch introduces this limitation, however I'm not
convinced it is a problem in practice.

For suspend we'd essentially end up with:

governor_suspend
  governor->suspend

  monitor_suspend
    update_status

    stop polling

What would a governor want to do after polling is stopped? Is there
any real world or halfway reasonable hypothetical example?


And for resume:

governor_resume
  governor->resume

  monitor_resume
    start polling

Same question here, what would the governor realistically want to do
after polling has started that it couldn't have done before?

Cheers

Matthias
