Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ABF20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gziQHP9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ABF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeGaSsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:48:50 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38700 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:48:50 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so5369480itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o73kjmIipNhpvnIs2UdndotC3Oh3Vq1qut2skvY3gD4=;
        b=gziQHP9CFyKdLds5MrND6GD5oYiaEmaLl8S6vfkNLSYblvJ4sYlRGL0pvO0EOKVrDl
         xi6uTdFWisk2OUV/SWjMQIhWQQr/iDi4uO5XlRGE5FoBnzoSM0eaQM7/ixRBPabNANRY
         r1CEOeQA+CsvJMpfCZKzuBR2z5Ju3GXN2K+n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o73kjmIipNhpvnIs2UdndotC3Oh3Vq1qut2skvY3gD4=;
        b=t27wkTmnOpITcVXJUOuqJYaQPupexOd3Giuy2KBFlJXjQYUjT1ovxZUX3yzbqU7eCv
         Ho0WCQValZgaihVpxxVlhNXJQwLOml0pHmAfSi2pC2QoQ1Bl+6rFJiP1ijkTDbRHrYTe
         wzKH6BVAX1GLoi/Bk2PoCQ4/+xu3JcTsmsi2saGNph4liWbsNqujZJltzAd8FI92XOn3
         3B+qe+6jnpshSYIFGZ49bEBUY0FACzrR4XXXl/UOGNk6P3jWOifM5r/02vldqabS+uHi
         KBw9uP2I0uvjtpNXPbfbU2RpK/owj6M27XAUr5OoBpp4tEV/R1oA+HgL63cRNDjFUNDF
         7oNg==
X-Gm-Message-State: AOUpUlHBhKYHENhwOMVGADDT/N1FNO26YxHmmNWAQdSPlOjJjKMdTofk
        xBLP+7UKnzLkkzCCIOG/Z36WWg==
X-Google-Smtp-Source: AAOMgpc8vXfW9EaiStOb5ZOivTUqND1BwdRaHNnRfEjNhmPuSEM2SaCMg+4E5QC8evOPuDpryNcYOg==
X-Received: by 2002:a02:8c3c:: with SMTP id l57-v6mr21277427jak.57.1533056855542;
        Tue, 31 Jul 2018 10:07:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a79-v6sm1758607itc.33.2018.07.31.10.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:07:34 -0700 (PDT)
Date:   Tue, 31 Jul 2018 11:07:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v3 02/13] coresight: etb10: Fix handling of perf mode
Message-ID: <20180731170731.GA11692@xps15>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 26, 2018 at 01:54:40PM +0100, Suzuki K Poulose wrote:
> If the ETB is already enabled in sysfs mode, the ETB reports
> success even if a perf mode is requested. Fix this by checking
> the requested mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 306119e..e5808fd 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -148,8 +148,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>  		return -EBUSY;
>  
>  	/* Nothing to do, the tracer is already enabled. */
> -	if (val == CS_MODE_SYSFS)
> -		goto out;
> +	if (val == CS_MODE_SYSFS) {
> +		if (mode == CS_MODE_SYSFS)
> +			goto out;
> +		else
> +			return -EBUSY;
> +	}

How about:

        if (val == CS_MODE_PERF)
                return -EBUSY;
 
+       /* Don't let perf disturb sysFS sessions */
+       if (val == CS_MODE_SYSFS && mode = CS_MODE_PERF)
+               return -EBUSY;
+
        /* Nothing to do, the tracer is already enabled. */
        if (val == CS_MODE_SYSFS)
                goto out;


I just find it more readable that way.

Thanks,
Mathieu

>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  	etb_enable_hw(drvdata);
> -- 
> 2.7.4
> 
