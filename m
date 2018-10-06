Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB1C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828F2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyqM/ONM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C828F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJFNjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:39:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32781 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeJFNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:39:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so5652786pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qnV8DRArmfUvLzp0UUNqfnfhu6MUaXj5TH7L72aFZ4=;
        b=LyqM/ONMWuByUdF5KCuMxemWBcqSbmV4xMjT4co9x26kZ5VRiGGX9Y79f+31toduQL
         Id1pi3iZaWz7VmmbBJ+2mh5O4UahP3xtyROSSBGZ9JI3lkraSB+Q8h6oiTYYRnU/pxVQ
         PwRQowIQymmivBKXlRDSUnHKlm86FfjxFj4y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qnV8DRArmfUvLzp0UUNqfnfhu6MUaXj5TH7L72aFZ4=;
        b=dPH2SZ8lWY1KXXRtfuyJybigskpjIMhr16RXSfskxOpOBoceq6x5o+nl34WRX2+1uR
         DbYx4esFebEl5ayLGgMAPH2coLAh/J6hOlwlAxl68NmsC5kT4tAd7sEdqnesWAC5Obdr
         3EmuFzI4j+SD6Lo+lXh8uhn7nIRYHFMmB8GjV3QrWk4NnX0dE93EvKr+aS3XUlSksRyV
         9opzhbkD1lhaZj/vlZFJo3bfREuTzBFDh0khqw/4Qka1NuE7t+48U3MMG2W8GiIsHf+I
         77cZjpCQKsoGI7+zhJ4uSKW8aJDfB3Zk2EvZmMORslsSbrNXVQVeBNeJ16glTT6wFN9V
         RWtw==
X-Gm-Message-State: ABuFfohQHOBtyOwXP0/ImQ4SIpikluhnfKFRqahw8bsvwRDB4eWayHz2
        ckQXXkJnv0dpBoi4KZ/HeIEXIQ==
X-Google-Smtp-Source: ACcGV62c3GNuIbwohL5lC+ab4+zcNb6XPv4VmdqvsFagemTW7SX0znatO0T3m4HJccQazfCVp61eBw==
X-Received: by 2002:a63:7f0e:: with SMTP id a14-v6mr12996392pgd.296.1538807813045;
        Fri, 05 Oct 2018 23:36:53 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a15-v6sm6075237pff.8.2018.10.05.23.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:36:52 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:39:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Propagate EPROBE_DEFER
Message-ID: <20181006063938.GJ12063@builder>
References: <20180920015151.15957-1-bjorn.andersson@linaro.org>
 <a1fdf85cb2e23b173243ba3b43b818bb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1fdf85cb2e23b173243ba3b43b818bb@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Sep 23:50 PDT 2018, Sibi Sankar wrote:

> On 2018-09-20 07:21, Bjorn Andersson wrote:
> > In the case that the interrupts fail to result because of the
> > interrupt-controller not yet being registered the
> > platform_get_irq_byname() call will fail with -EPROBE_DEFER, but passing
> > this into devm_request_threaded_irq() will result in -EINVAL being
> > returned, the driver is therefor not reprobed later.
> > 
> 
> The patch looks fine.
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> 

Thanks for the review Sibi, applied the patch.

Regards,
Bjorn

> > Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource
> > handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/remoteproc/qcom_q6v5.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5.c
> > b/drivers/remoteproc/qcom_q6v5.c
> > index 61a760ee4aac..e9ab90c19304 100644
> > --- a/drivers/remoteproc/qcom_q6v5.c
> > +++ b/drivers/remoteproc/qcom_q6v5.c
> > @@ -198,6 +198,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> > platform_device *pdev,
> >  	}
> > 
> >  	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
> > +	if (q6v5->fatal_irq == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> >  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
> >  					NULL, q6v5_fatal_interrupt,
> >  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > @@ -208,6 +211,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> > platform_device *pdev,
> >  	}
> > 
> >  	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
> > +	if (q6v5->ready_irq == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> >  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
> >  					NULL, q6v5_ready_interrupt,
> >  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > @@ -218,6 +224,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> > platform_device *pdev,
> >  	}
> > 
> >  	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
> > +	if (q6v5->handover_irq == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> >  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
> >  					NULL, q6v5_handover_interrupt,
> >  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > @@ -229,6 +238,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> > platform_device *pdev,
> >  	disable_irq(q6v5->handover_irq);
> > 
> >  	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
> > +	if (q6v5->stop_irq == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> > +
> >  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
> >  					NULL, q6v5_stop_interrupt,
> >  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> 
> -- 
> -- Sibi Sankar --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
