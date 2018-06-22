Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ADAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6930F248B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="escM9mKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6930F248B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeFVUnW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:43:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42920 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeFVUnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:43:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so3993772pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TozW8Iw+mHPHQVkKdSFIQ2YOOO7nPyS5tXIpHiqMxpc=;
        b=escM9mKlWCMnSKNnICmbsoDOweeADPIMqMg2AEfYclM/ONK24NX5pzU7ujf8Pp+ltD
         BdahFHF/AsoVM+Ch7ZIJs7nXWSxaW4xmEMrZPxJp+VMOeaCo5LhNJJrXu3bQYIfrQmXY
         0nqvBHzyNuSbqlRiMnwr7M8A3unvIDsRirn3EBOcZ9qWgYlq/RPxxydX1EKryFzZ9Xmy
         wylKytME1IQig8d7BMFkHfL6BXSR+ekFxlu1VShNsSLMkYABaAvvCpkIPem5HkdCMqaT
         PuFrIL3VUpYeSqp2C1i9DvRX406PeZBqidtsri+pbnN1hqkMcbj3WNyutYG916xI4m4H
         SdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TozW8Iw+mHPHQVkKdSFIQ2YOOO7nPyS5tXIpHiqMxpc=;
        b=QSiWTBs+WLteHxPG4s5tBH+C6yrmiBte3j0n3fQ3/q1aB65ubi6muihC32s7mTkG1D
         ZB5hKflPC8qYK4OZnVQv/KhpylNPP9BxJvGhvFDal3OPzu/35thncjmZed5hxjrTVrgF
         AQLJ3RDI/HofxCBohmlf2c1OAtElq6Kqr+fKq+GDsOrN0D7nr5869+O/NOisCVIrsdsZ
         pgciO0kaJmwIVl+S7KmcAfjEU4TK86FZyXztoe9P1r7o07/GUny9l3kjjZgbPdc4Q5No
         MB/1HCMQwxp8ixI8kBzOqO+px6YkmdMQc9K2/WskyLXYxojCYdLAd3b5y25l0LUDgvV+
         4tUA==
X-Gm-Message-State: APt69E3InrafiORSc+v+1tDvSIqdy662vSUQfIqWbirQP7lag6M4p/H3
        f4Z74SMK53psnJB2X3hvZnjQ9/O/Av4=
X-Google-Smtp-Source: ADUXVKIDggG1bt0ltP2PJNWwQmLDpR1QJVqh7tvHMQ/Y6Dg3H11xPdD/IYJXfP9RUUUXqZlDmwAVRQ==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr3164200plc.310.1529700200658;
        Fri, 22 Jun 2018 13:43:20 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z12-v6sm10215009pgu.57.2018.06.22.13.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 13:43:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fWStr-0000sI-50; Fri, 22 Jun 2018 14:43:19 -0600
Date:   Fri, 22 Jun 2018 14:43:19 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
Message-ID: <20180622204319.GE19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
>  include/linux/tpm.h         |  5 +++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 4e83695af068..2520555b1e17 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> + * tpm_chip_find() - find a TPM chip and get a reference to it
> + */
> +struct tpm_chip *tpm_chip_find(void)

I feel like this should be called 'tpm_default_chip()'

> +{
> +	struct tpm_chip *chip, *res = NULL;
> +	int chip_num = 0;
> +	int chip_prev;
> +
> +	mutex_lock(&idr_lock);
> +
> +	do {
> +		chip_prev = chip_num;
> +		chip = idr_get_next(&dev_nums_idr, &chip_num);
> +		if (chip) {
> +			get_device(&chip->dev);
> +			res = chip;
> +			break;
> +		}
> +	} while (chip_prev != chip_num);
> +
> +	mutex_unlock(&idr_lock);

And what was tpm_chip_find_get should just call this function..

Jason
