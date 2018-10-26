Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B850C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54F22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54F22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJZUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:36:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43310 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeJZUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:36:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so1038467eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 04:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ufNMSKXsGrw7NLY9abX36SfLrM0GOGrXhLBX2SeJOH0=;
        b=m69N9FXrLTYAE2DfLhQdgsNVigtg+dBSt61NXi/kH4G8gVHgSooqrbNgCxtl2DztHi
         1TWo5FPA4+OmU9ZcYtvkR8aR8er598RoDgMFPwhdkeMeYVFHeRjVmZ9bMTzDVSGtgzc8
         wbXZP+GRrVUvFZdzCI7Layv1+uIWB/YIwYYNWqKlw9KJDMTuSAOgN7iy9EUK729u+B/I
         GjdoS+XEHs3PdCim5d7PsLxvBxxbRlf+6TqxQpkjsArAg0OTqomTb7mUY9hG3CgIzwR8
         Ht2y60HKM4q1vQq0r0Cv3VfBpBcjqx1bKI+eniJMr99WsmPSQNe73aVdALY/4QP7RRgv
         nsfg==
X-Gm-Message-State: AGRZ1gKl5p1GuWmWuF9It3T0zBTQQvPn6VNKA6Gz6XNDu7IRxx4fT6zr
        PBkN3qCDO28bFBYvWhvNKrtIfWLINSc=
X-Google-Smtp-Source: AJdET5eBwRAi9Q+7fymRnffczjKH71mie479RxifLxu4vFUfZWMrmgdXnXq/lhC0KvDobpCWrGjGbA==
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16-v6mr2122735ejh.195.1540555198307;
        Fri, 26 Oct 2018 04:59:58 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i38-v6sm5129198ede.83.2018.10.26.04.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 04:59:57 -0700 (PDT)
Subject: Re: [PATCH v2] libata: Apply NOLPM quirk for SAMSUNG
 MZ7TD256HAFV-000L9
To:     Diego Viola <diego.viola@gmail.com>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20181026015804.4120-1-diego.viola@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6749376c-930a-3392-6a02-386431a9a432@redhat.com>
Date:   Fri, 26 Oct 2018 13:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181026015804.4120-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-10-18 03:58, Diego Viola wrote:
> med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> 
> Switching the LPM to max_performance fixes this issue.
> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>

Thank you for the patch, have you updated the firmware and
confirmed that this happens with the latest firmware version too ?

If not please send a new version limiting the blacklist to your
firmware version.

Regards,

Hans




> ---
>   drivers/ata/libata-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a9dd4ea7467d..a7f5202a4815 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	/* These specific Samsung models/firmware-revs do not handle LPM well */
>   	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>   	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> +	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
>   
>   	/* devices that don't properly handle queued TRIM commands */
>   	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> 
