Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74745ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA1208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAA1208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeGMPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:21:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:12759 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbeGMPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:21:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 08:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="56286605"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.93.136])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2018 08:06:16 -0700
Message-ID: <78b1a67902c44d3de3f5de87708993547c4a3f30.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/2] ata: ahci: Support state with min power and
 Partial low power state
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net
Date:   Fri, 13 Jul 2018 08:06:16 -0700
In-Reply-To: <fa324b27-4424-afa2-9723-10437ca29801@redhat.com>
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
         <20180712222712.65310-2-srinivas.pandruvada@linux.intel.com>
         <fa324b27-4424-afa2-9723-10437ca29801@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,
On Fri, 2018-07-13 at 11:08 +0200, Hans de Goede wrote:
> Hi,
> 
> On 13-07-18 00:27, Srinivas Pandruvada wrote:
> > Currently when min_power policy is selected, the partial low power
> > state
> > is not entered and link will try aggressively enter to only slumber
> > state.
> > Add a new policy which still enable DEVSLP but also try to enter
> > partial
> > low power state.
> > 
> > For information the difference between partial and slumber
> > Partial – PHY logic is powered up, and in a reduced power state.
> > The link
> > PM exit latency to active state maximum is 10 ns.
> > Slumber – PHY logic is powered up, and in a reduced power state.
> > The link
> > PM exit latency to active state maximum is 10 ms.
> > Devslp – PHY logic is powered down. The link PM exit latency from
> > this
> > state to active state maximum is 20 ms, unless otherwise specified
> > by
> > DETO.
> > 
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> 
> You got this the wrong way around, when ALP
You mean ASP, as per spec in section 3.3.7 of the spec.

>  is not set you only get
> partial,
Not exactly.
It means that the system will try to enter aggressively  partial . I
have seen slumber residency also when this is reset. When "set" you
don't see any any partial. But when you reset you see both. So based on
idle duration link will transition from partial to slumber even if "not
set".

> the ALP bit is active high, not active low as your commit
> suggests.  So the name of the new policy should be
> min_power_without_asp.


The policy name I am suggesting is not the actual bit value of ASP (I
interpreted ASP as name for partial), but whether you will get to
partial or not. So I think it is better to rename to
"min_power_with_partial". User should not have to worry about the bit
value. 


So user will see with the rename from "min_power_with_asp" to
"min_power_with_partial":

#cat /sys/class/scsi_host/host*/link_power_management_policy 
min_power_with_partial
min_power_with_partial
min_power_with_partial

Output of test (You will see both partial and slumber)

SATA LPM Summary - Sampled: Residency (Percentage)
Disk Name          , Off (%), Active (%), Partial (%), Slumber (%),
Devsleep (%), Other (%), Uninitialized (%)
---------          , -------, ----------, -----------, -----------, -
-----------, ---------, -----------------
INTEL SSDSCKJF180A5, 0.0    , 4.6       , 13.1       , 30.3       ,
52.0        , 0.0      , 0.0

SATA LPM Summary - Sampled: Counts
Disk Name          , Off, Active, Partial, Slumber, Devsleep, Other,
Uninitialized
---------          , ---, ------, -------, -------, --------, -----, --
-----------
INTEL SSDSCKJF180A5, 0  , 9     , 27     , 60     , 103     , 0    , 0


# cat /sys/class/scsi_host/host*/link_power_management_policy
min_power
min_power
min_power

Output of test (You will see only slumber)

SATA LPM Summary - Sampled: Residency (Percentage)
Disk Name          , Off (%), Active (%), Partial (%), Slumber (%),
Devsleep (%), Other (%), Uninitialized (%)
---------          , -------, ----------, -----------, -----------, -
-----------, ---------, -----------------
INTEL SSDSCKJF180A5, 0.0    , 6.8       , 0.0        , 53.8       ,
39.3        , 0.0      , 0.0

SATA LPM Summary - Sampled: Counts
Disk Name          , Off, Active, Partial, Slumber, Devsleep, Other,
Uninitialized
---------          , ---, ------, -------, -------, --------, -----, --
-----------
INTEL SSDSCKJF180A5, 0  , 11    , 0      , 107    , 76      , 0    , 0

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> > ---
> >   drivers/ata/libahci.c     | 6 +++++-
> >   drivers/ata/libata-core.c | 1 +
> >   drivers/ata/libata-scsi.c | 1 +
> >   include/linux/libata.h    | 3 ++-
> >   4 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 511fb67f363d..8cf2cf49537d 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -799,8 +799,11 @@ static int ahci_set_lpm(struct ata_link *link,
> > enum ata_lpm_policy policy,
> >   				return 0;
> >   		} else {
> >   			cmd |= PORT_CMD_ALPE;
> > +
> >   			if (policy == ATA_LPM_MIN_POWER)
> >   				cmd |= PORT_CMD_ASP;
> > +			else if (policy ==
> > ATA_LPM_MIN_POWER_WITH_ASP)
> > +				cmd &= ~PORT_CMD_ASP;
> >   
> >   			/* write out new cmd value */
> >   			writel(cmd, port_mmio + PORT_CMD);
> > @@ -811,7 +814,8 @@ static int ahci_set_lpm(struct ata_link *link,
> > enum ata_lpm_policy policy,
> >   	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
> >   	    (hpriv->cap2 & HOST_CAP2_SADM) &&
> >   	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
> > -		if (policy == ATA_LPM_MIN_POWER)
> > +		if (policy == ATA_LPM_MIN_POWER ||
> > +		    policy == ATA_LPM_MIN_POWER_WITH_ASP)
> >   			ahci_set_aggressive_devslp(ap, true);
> >   		else
> >   			ahci_set_aggressive_devslp(ap, false);
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index cc71c63df381..245a59e6cb18 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -3970,6 +3970,7 @@ int sata_link_scr_lpm(struct ata_link *link,
> > enum ata_lpm_policy policy,
> >   		scontrol |= (0x6 << 8);
> >   		break;
> >   	case ATA_LPM_MED_POWER_WITH_DIPM:
> > +	case ATA_LPM_MIN_POWER_WITH_ASP:
> >   	case ATA_LPM_MIN_POWER:
> >   		if (ata_link_nr_enabled(link) > 0)
> >   			/* no restrictions on LPM transitions */
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index aad1b01447de..2d683db50ceb 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
> >   	[ATA_LPM_MAX_POWER]		= "max_performance",
> >   	[ATA_LPM_MED_POWER]		= "medium_power",
> >   	[ATA_LPM_MED_POWER_WITH_DIPM]	=
> > "med_power_with_dipm",
> > +	[ATA_LPM_MIN_POWER_WITH_ASP]	=
> > "min_power_with_asp",
> >   	[ATA_LPM_MIN_POWER]		= "min_power",
> >   };
> >   
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index 32f247cb5e9e..1e154f1f7e8f 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -523,7 +523,8 @@ enum ata_lpm_policy {
> >   	ATA_LPM_MAX_POWER,
> >   	ATA_LPM_MED_POWER,
> >   	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win
> > IRST does */
> > -	ATA_LPM_MIN_POWER,
> > +	ATA_LPM_MIN_POWER_WITH_ASP, /* Min Power + partial and
> > slumber */
> > +	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber
> > only) */
> >   };
> >   
> >   enum ata_lpm_hints {
> > 
