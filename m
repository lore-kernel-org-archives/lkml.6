Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7659ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0712208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0712208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeGMJWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:22:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeGMJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:22:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so24036603eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TzI13RiLaz0ktAykbnyd98xG0bQqPBP/RQJ9VYlSuW0=;
        b=UTrAzoQDiSSq4L1orbhJQ188MaQqYF3Ma5Ti2ph2X39iE86kEY/SRa/iNSmw90nCa+
         R/ZnktgUeBHPjiULmLVtPftj4GMJAIMTEy/lwmQq5wBqR2CBy/XtltMSnwcSJJi/l3uw
         0+nJy5LqKuDcTQr4fwlWYNKETQ5FwbVPSJgJAVOv8YRzv+i0NqctWtZ9Xwcvn0uzelQR
         xWHg5RRg3mKkAW9B8zrur6zUimyHhLxKBafd+C9JrzCKZB+4Ld2zVmDDCs3Uvxo3BXhI
         NK3qiXqT7f2sNiv83VqvdsEahMjnRXidTAp9lOJaVtnGXbdY/H6mw7UVMsi+O6lZ683z
         WRwg==
X-Gm-Message-State: AOUpUlEmBXqk8XP9BZx+UW5J/RRhlWM52bPbZ1RyZn+P/k0V4Rt+4l4D
        hjtsSnLXMLeUIk+VMyXDdguDDA==
X-Google-Smtp-Source: AAOMgpcg51HO+R1Rbn+1ofmDyWUz9QLuuK6dg7iKaUwz5F7vZbN++D174I8vij1A9Ji70M6bQ7eH9A==
X-Received: by 2002:a50:8fe6:: with SMTP id y93-v6mr6289374edy.290.1531472897583;
        Fri, 13 Jul 2018 02:08:17 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u9-v6sm8245964edk.16.2018.07.13.02.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:08:16 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/2] ata: ahci: Support state with min power and
 Partial low power state
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
 <20180712222712.65310-2-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fa324b27-4424-afa2-9723-10437ca29801@redhat.com>
Date:   Fri, 13 Jul 2018 11:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712222712.65310-2-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-07-18 00:27, Srinivas Pandruvada wrote:
> Currently when min_power policy is selected, the partial low power state
> is not entered and link will try aggressively enter to only slumber state.
> Add a new policy which still enable DEVSLP but also try to enter partial
> low power state.
> 
> For information the difference between partial and slumber
> Partial – PHY logic is powered up, and in a reduced power state. The link
> PM exit latency to active state maximum is 10 ns.
> Slumber – PHY logic is powered up, and in a reduced power state. The link
> PM exit latency to active state maximum is 10 ms.
> Devslp – PHY logic is powered down. The link PM exit latency from this
> state to active state maximum is 20 ms, unless otherwise specified by
> DETO.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

You got this the wrong way around, when ALP is not set you only get
partial, the ALP bit is active high, not active low as your commit
suggests.  So the name of the new policy should be min_power_without_asp.

Regards,

Hans






> ---
>   drivers/ata/libahci.c     | 6 +++++-
>   drivers/ata/libata-core.c | 1 +
>   drivers/ata/libata-scsi.c | 1 +
>   include/linux/libata.h    | 3 ++-
>   4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 511fb67f363d..8cf2cf49537d 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -799,8 +799,11 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   				return 0;
>   		} else {
>   			cmd |= PORT_CMD_ALPE;
> +
>   			if (policy == ATA_LPM_MIN_POWER)
>   				cmd |= PORT_CMD_ASP;
> +			else if (policy == ATA_LPM_MIN_POWER_WITH_ASP)
> +				cmd &= ~PORT_CMD_ASP;
>   
>   			/* write out new cmd value */
>   			writel(cmd, port_mmio + PORT_CMD);
> @@ -811,7 +814,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
>   	    (hpriv->cap2 & HOST_CAP2_SADM) &&
>   	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
> -		if (policy == ATA_LPM_MIN_POWER)
> +		if (policy == ATA_LPM_MIN_POWER ||
> +		    policy == ATA_LPM_MIN_POWER_WITH_ASP)
>   			ahci_set_aggressive_devslp(ap, true);
>   		else
>   			ahci_set_aggressive_devslp(ap, false);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cc71c63df381..245a59e6cb18 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3970,6 +3970,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   		scontrol |= (0x6 << 8);
>   		break;
>   	case ATA_LPM_MED_POWER_WITH_DIPM:
> +	case ATA_LPM_MIN_POWER_WITH_ASP:
>   	case ATA_LPM_MIN_POWER:
>   		if (ata_link_nr_enabled(link) > 0)
>   			/* no restrictions on LPM transitions */
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index aad1b01447de..2d683db50ceb 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
>   	[ATA_LPM_MAX_POWER]		= "max_performance",
>   	[ATA_LPM_MED_POWER]		= "medium_power",
>   	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
> +	[ATA_LPM_MIN_POWER_WITH_ASP]	= "min_power_with_asp",
>   	[ATA_LPM_MIN_POWER]		= "min_power",
>   };
>   
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 32f247cb5e9e..1e154f1f7e8f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -523,7 +523,8 @@ enum ata_lpm_policy {
>   	ATA_LPM_MAX_POWER,
>   	ATA_LPM_MED_POWER,
>   	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
> -	ATA_LPM_MIN_POWER,
> +	ATA_LPM_MIN_POWER_WITH_ASP, /* Min Power + partial and slumber */
> +	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
>   };
>   
>   enum ata_lpm_hints {
> 
