Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A8C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFE21480
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tha/LZQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BFE21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJFNeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:34:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45960 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeJFNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:34:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so7770671plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNjCvSmE+kUcQZ334grC95fOY8LFdUppsvT0FTY7RKs=;
        b=Tha/LZQchGN+ehurVEXif4p068JTjalMwXRw4RSyrSA7eHysCye8NR5+F59xaBS+fI
         4BzDd/7OwQZFFbLUePuB25ZBrG2T5/XSjPigq0Qrvm+UT9h+QVEghbtRzzEM9tJQchhf
         TBzQVch49keOURud0liRjoTwof9OIZljscZ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNjCvSmE+kUcQZ334grC95fOY8LFdUppsvT0FTY7RKs=;
        b=pAU/pzL01WmkpINdY8nvzLoYfrjMkCSGNI6tL1/c0YwL0cLM8tpTzkVXbgfLgYcs+M
         be+8MhoErPVmS1VAqPmnMaCj+1oe05IwXPVHGsuRlnuyJ88ugEWW1aSAq+apiRo+KTmr
         ZxtrSA33gQleUrI/Ex1zijumnoiHBtvVuFmRVm+IqQqH4Z+cuFYU6HQ9xyLp8XQaJQ+B
         ZVKT5ZA2wT6ImuYWg8BB8wyTaNcFK5zQBdeK3lPgKscVlf0S9nMkoX2iemLxr6rNBPRo
         TLIaboVIzdD293zr4EThfztnl1MM0j28GKKOZLNg/ppTvVJBmZM5BUR27rhnxLZCXChX
         qo2A==
X-Gm-Message-State: ABuFfojHd/WQ9vy5Eez1Mx28iJGd9yVHQ5sCkMIK9WmtOh0AO32IBtDx
        QC4v75hpvFp40ZwCAiqKzzXnnw==
X-Google-Smtp-Source: ACcGV60Kt8rHdRqkfdlgWNoJmTSZ94jIHZPvQJKWLl9NovcHLAvHGabEVnIjMJLrd8UU2Z+Fzp4LDg==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr14791115pld.191.1538807534688;
        Fri, 05 Oct 2018 23:32:14 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j188-v6sm14266234pfg.132.2018.10.05.23.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:32:13 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:35:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Fix a race condition on fatal
 crash
Message-ID: <20181006063500.GH12063@builder>
References: <20181001142500.25457-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001142500.25457-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Oct 07:25 PDT 2018, Sibi Sankar wrote:

> Currently with GLINK_SSR enabled each fatal crash results in servicing
> a crash from wdog as well. This is due to a race that occurs in setting
> the running flag in the shutdown path. Fix this by moving the running
> flag to the end of fatal interrupt handler.
> 
> Crash Logs:
> qcom-q6v5-pil 4080000.remoteproc: fatal error without message
> remoteproc remoteproc0: crash detected in 4080000.remoteproc: type fatal
> 	error
> remoteproc remoteproc0: handling crash #1 in 4080000.remoteproc
> remoteproc remoteproc0: recovering 4080000.remoteproc
> qcom-q6v5-pil 4080000.remoteproc: watchdog without message
> remoteproc remoteproc0: crash detected in 4080000.remoteproc: type watchdog
> remoteproc:glink-edge: intent request timed out
> qcom_glink_ssr remoteproc:glink-edge.glink_ssr.-1.-1: failed to send
> 	cleanup message
> qcom_glink_ssr remoteproc:glink-edge.glink_ssr.-1.-1: timeout waiting
> 	for cleanup done message
> qcom-q6v5-pil 4080000.remoteproc: timed out on wait
> qcom-q6v5-pil 4080000.remoteproc: port failed halt
> remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
> qcom-q6v5-pil 4080000.remoteproc: MBA booted, loading mpss
> remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
> remoteproc remoteproc0: handling crash #2 in 4080000.remoteproc
> remoteproc remoteproc0: recovering 4080000.remoteproc
> qcom-q6v5-pil 4080000.remoteproc: port failed halt
> remoteproc remoteproc0: stopped remote processor 4080000.remoteproc
> qcom-q6v5-pil 4080000.remoteproc: MBA booted, loading mpss
> remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
> 
> [bjorn: move running flag to the end of fatal interrupt handler]

Turned this line into a Suggested-by

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Applied.

Thanks,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index e9ab90c19304..edeb2e43209e 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -84,6 +84,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  	else
>  		dev_err(q6v5->dev, "fatal error without message\n");
>  
> +	q6v5->running = false;
>  	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>  
>  	return IRQ_HANDLED;
> @@ -150,8 +151,6 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
>  {
>  	int ret;
>  
> -	q6v5->running = false;
> -
>  	qcom_smem_state_update_bits(q6v5->state,
>  				    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
