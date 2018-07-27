Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FDB2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FDB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbeG0N6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:58:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42805 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbeG0N6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:58:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so3809146edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTYlgWqnKdqahKDZrwqjH9Ij0ZfviJtQxAsUwpXimtw=;
        b=HqPvhwI+uE89gZYuAamrLIHzZGa/rMAMY/b15Rii0ub1hpv/XPVufiP10lZcbiGNMM
         dSNU3ZBBe66Fcvz9su3MiEa1eJS2isHeis3KXG9+XJKnCpPjNsY+uO9JfcAco86PB9n8
         3DAiYRyqcaSIie6RyqPye02sx3cXpgbzTqqjRtpvfMrAXBtzVumvOngzNMgOvMqd+LSR
         gXfIZBncaeJIoblwpVPKevxSycbVUYMhD+/BpttPI6G0uWGxPM/9UAAWkq3+uPK4qygP
         tvsqqkw0/Vx+l+ujoZD4jo0NhjgOTjZA6workh641SPDuO2qOBNj+DVfR1uQ+orxMlUh
         LnpQ==
X-Gm-Message-State: AOUpUlE6COngHZlCmpd4wA8gfDPuOmF9mEI5F0a9PYMhJbVMTyaIN/pK
        O4365Zc9NMtoF+i+SrgtLcXyAQ==
X-Google-Smtp-Source: AAOMgpfmWDVrWxOGY0fotywg9HblTE9JabT5pT456B+XG/elkDPhTzEKLORrV28lf8XEZSguZpOUdg==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr7318123edb.174.1532695013669;
        Fri, 27 Jul 2018 05:36:53 -0700 (PDT)
Received: from localhost.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l30-v6sm1971853edc.70.2018.07.27.05.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 05:36:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] ata: ahci: Enable DEVSLP by default on x86 with
 SLP_S0
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net
References: <20180720000156.77759-1-srinivas.pandruvada@linux.intel.com>
 <20180720000156.77759-3-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69247ef7-0b7d-19d8-1f58-b79478cb3387@redhat.com>
Date:   Fri, 27 Jul 2018 14:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720000156.77759-3-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/20/2018 02:01 AM, Srinivas Pandruvada wrote:
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> 
> Several of these system don't have traditional ACPI S3, so it is
> important that they enter SLP_S0 state, to avoid draining battery even
> during suspend. So it is important that out of the box Linux installation
> reach this state.
> 
> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
> user has to either use scsi-host sysfs or tools like powertop to set
> the sata-host link_power_management_policy to min_power.
> 
> This change sets by default link power management policy to min_power
> with partial (preferred) or slumber support on idle for some platforms.
> 
> To avoid regressions, the following conditions are used:
> - User didn't override the policy from module parameter
> - The kernel config is already set to use med_power_with_dipm or deeper
> - System is a SLP_S0 capable using ACPI low power idle flag
> This combination will make sure that systems are fairly recent and
> since getting shipped with SLP_S0 support, the DEVSLP function
> is already validated.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/ata/ahci.c | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 738fb22978dd..72dc9edbc221 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1550,6 +1550,34 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>   	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>   }
>   
> +void ahci_update_initial_lpm_policy(struct ata_port *ap,
> +				    struct ahci_host_priv *hpriv)
> +{
> +	int policy = mobile_lpm_policy;
> +
> +	/* Ignore processing for non mobile platforms */
> +	if (!(hpriv->flags & AHCI_HFLAG_IS_MOBILE))
> +		return;
> +
> +	/* user modified policy via module param */
> +	if (policy != CONFIG_SATA_MOBILE_LPM_POLICY)
> +		goto update_policy;


This means that if the user explicitly requests the
default CONFIG_SATA_MOBILE_LPM_POLICY, it will still
be overridden below.

I think it would be better to initialize the global mobile_lpm_policy
to -1 and then do:

	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;

	...

	/* user modified policy via module param */
	if (mobile_lpm_policy != -1) {
		policy = mobile_lpm_policy;
		goto update_policy;
	}


Otherwise this series looks good to me.

Regards,

Hans


> +
> +#ifdef CONFIG_ACPI
> +	if (policy > ATA_LPM_MED_POWER &&
> +	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +		if (hpriv->cap & HOST_CAP_PART)
> +			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
> +		else if (hpriv->cap & HOST_CAP_SSC)
> +			policy = ATA_LPM_MIN_POWER;
> +	}
> +#endif
> +
> +update_policy:
> +	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
> +		ap->target_lpm_policy = policy;
> +}
> +
>   static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	unsigned int board_id = ent->driver_data;
> @@ -1747,10 +1775,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		if (ap->flags & ATA_FLAG_EM)
>   			ap->em_message_type = hpriv->em_msg_type;
>   
> -		if ((hpriv->flags & AHCI_HFLAG_IS_MOBILE) &&
> -		    mobile_lpm_policy >= ATA_LPM_UNKNOWN &&
> -		    mobile_lpm_policy <= ATA_LPM_MIN_POWER)
> -			ap->target_lpm_policy = mobile_lpm_policy;
> +		ahci_update_initial_lpm_policy(ap, hpriv);
>   
>   		/* disabled/not-implemented port */
>   		if (!(hpriv->port_map & (1 << i)))
> 
