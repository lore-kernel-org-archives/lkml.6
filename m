Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99F3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7938E245E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VarKizSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7938E245E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeGDHjH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:39:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55258 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbeGDHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:39:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so4677811wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lTy4V8Lwl3xjR7p5RL/j9NwUl043bWUGlW2Z5AUu3Qk=;
        b=VarKizSWU3KJKu8AB5gQ68flRXpp7vRu1xnpWOx5gr07mmRH9Td6ylzL2QrCeY+SEV
         bc6LRLyxFzzUCs+XHRuGkdDZfW08eb9+fQZxO5NexiJx+73EC77YrAP+DNrOSRD2xtH4
         KNlC4jSoF3Qsb2qiV+jqkkcwOKKnWuXWJRzdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lTy4V8Lwl3xjR7p5RL/j9NwUl043bWUGlW2Z5AUu3Qk=;
        b=GBv9ZB0JqE0p0Qb1D3jvfQj0WG3kZpMVx5T2O0WulkOBGJuNKBNrn9wlaHJkzPcIG0
         1tX9jZjpI1MSvcSTyKmXdmD6N4QR4qzJhUnqABVABJ+upgAlmeOt9wU2TtVwRj3C8Y48
         9p+yornHQn4BTowUpvwPnAkTKIkiThCRW8nr4yb6eZd30mEukdB+bGNiMYuGzAHtqL2s
         YUsmKr5MOVdyb2NJM41wjVE/JaJDjFamT1+bDL1sNMd/m7c2mX3H4VTOfn0JokFnzQHF
         I9xpS+EZC6cBMyRsrCqdrKV6bpcuiPB8Jw8iKaVQV2gSn/+yV8BGwaML2V3H37l6HebF
         AD5w==
X-Gm-Message-State: APt69E3Zq1CAH1+DFs1KwFDCNKJlxNnMecd8tnDZ6QANema3UB84KuyG
        O9BkPaGESHMD4T/v6P/y4FEASA==
X-Google-Smtp-Source: AAOMgpe35+8gOAs1LPVvDBOs9Y/Y5JTp0YZXkxj1LwXYteGVOW5+lAaeUXDyVr4lhHMlmhSqKE09KA==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr860553wma.123.1530689944316;
        Wed, 04 Jul 2018 00:39:04 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id i95-v6sm4402512wri.63.2018.07.04.00.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:39:03 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:39:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Keep ADC interface on if
 child is wakeup capable
Message-ID: <20180704073901.GM20176@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-4-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> If a child device like touchscreen is wakeup capable, then keep ADC
> interface on, so that a touching resistive screen will generate wakeup
> event to the system.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
