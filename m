Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC81C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3977020700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZN1572GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3977020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeLFHSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:18:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeLFHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:18:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so11338331pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9M27kK/uZ0gwXamkknpQk1BIXkg26HGV3JR2n5+aND4=;
        b=ZN1572GM7u/FWErKk6zNeAdPx3n7e0z3/w+1XpJqJ0aMZAPuD/Q0Y5lU0ofegm+e6c
         glKQkJyTZOvw1R1g/NuK0D6IAU4gIsDvRCY7q/CYYL32KH6kS3anR7hq5coQigNoBFGM
         NenjyrF3gLyxsnWXS8uwFCjQH4KfPy5i2eiMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9M27kK/uZ0gwXamkknpQk1BIXkg26HGV3JR2n5+aND4=;
        b=plr+44e0ZUxbnWm6NldYLx/Ekpjs9V+aBOzf7L3dBvVD2iqX56980vfvVsY53LnMwB
         JBvbqGSfgBBI4jnw4sKscf/yV1vVHtJ6AY3Kj4BBzDpSwsvA92xlYSRKJ/d21MELPEeW
         vMYe3cGskHyLUo7p3KkWiXfynnURucOIsXGSQuxBQt+XHVnDw1uTYOkW0EwIsyqn5tOB
         Jld+cPFByF5hdznhecEbqoFrtAL1Y18cSv05Qf5Tx8t6qMW4D+HmB1Gl5tupMh8twDCb
         dA6areIoZB5hRaQy31w5tfIwNKTtaf22MLWwKORgoXIhmHEyb/MuNI4fyd/q6vv9iC34
         /lCA==
X-Gm-Message-State: AA+aEWaJswH2L0hITzeKRRhjK9qbnPO+HaqUtjio2GZtochHjuPID95Y
        8t8wqBMMtPSwzvmBdPXpvrrOsw==
X-Google-Smtp-Source: AFSGD/WRoHrh1vVDrsVcySsRiIurGpg/WcSSU8p2Z8o0eP7vJDIOH9BTR+nBa3ZSW0ec1jKy2/Ngig==
X-Received: by 2002:a62:d504:: with SMTP id d4mr27322268pfg.38.1544080686019;
        Wed, 05 Dec 2018 23:18:06 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i62sm25770664pge.44.2018.12.05.23.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:18:05 -0800 (PST)
Date:   Wed, 5 Dec 2018 23:16:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/2] remoteproc: sysmon: Wait for shutdown-ack/ind on
 sysmon shutdown
Message-ID: <20181206071608.GA31596@builder>
References: <20181120210209.9029-1-sibis@codeaurora.org>
 <20181120210209.9029-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120210209.9029-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20 Nov 13:02 PST 2018, Sibi Sankar wrote:

> After sending a sysmon shutdown request to the SSCTL service on the
> subsystem, wait for the service to send shutdown-ack interrupt or
> an indication message back.
> 

So we get a reply immediate on the shutdown request, and then some time
later we get either an indication or an interrupt to state that it's
actually complete?

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_sysmon.c | 59 +++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
[..]
> @@ -283,6 +311,14 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
>  		dev_err(sysmon->dev, "shutdown request failed\n");
>  	else
>  		dev_dbg(sysmon->dev, "shutdown request completed\n");
> +
> +	if (sysmon->shutdown_irq > 0) {
> +		ret = wait_for_completion_timeout(&sysmon->shutdown_comp,
> +						  msecs_to_jiffies(5000));

5 * HZ

> +		if (!ret)
> +			dev_err(sysmon->dev,
> +				"timeout waiting for shutdown ack\n");
> +	}
>  }
[..]
> @@ -453,14 +499,25 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
>  
>  	sysmon->dev = rproc->dev.parent;
>  	sysmon->rproc = rproc;
> +	pdev = container_of(sysmon->dev, struct platform_device, dev);
>  
>  	sysmon->name = name;
>  	sysmon->ssctl_instance = ssctl_instance;
>  
>  	init_completion(&sysmon->comp);
> +	init_completion(&sysmon->shutdown_comp);
>  	mutex_init(&sysmon->lock);
>  
> -	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
> +	sysmon->shutdown_irq = platform_get_irq_byname(pdev, "shutdown-ack");

Use of_irq_get_byname() on sysmon->dev instead of relying on the fact
that the remoteproc driver is a platform_device.

Also, check and handle the return value - because an EPROBE_DEFER here
will be turned into a -EINVAL by devm_request_threaded_irq().

> +	ret = devm_request_threaded_irq(sysmon->dev, sysmon->shutdown_irq,
> +					NULL, sysmon_shutdown_interrupt,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"q6v5 shutdown-ack", sysmon);
> +	if (ret)
> +		dev_err(sysmon->dev, "failed to acquire shutdown-ack IRQ\n");

In the event that sysmon->shutdown_irq is != -ENODATA, you should fail
here.

> +
> +	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops,
> +			      qmi_indication_handler);

Regards,
Bjorn
