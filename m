Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA2020657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tMOOxLCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfANNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:42:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38666 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfANNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:42:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDg91s112127;
        Mon, 14 Jan 2019 07:42:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547473329;
        bh=FjQ3wMwFuhO8m/GnNpV5kx6Rm0KFUmI8NK1Obc+2T4Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tMOOxLCtp6Y7gZ2M88/1iVE0qYq/ZNvmNnAZajI7qMtn3JV0GKOaxm+z5zTqoM3AA
         QTicaWdOI3NJGVs8w2uyj6A9t5zJOFleK0/DGjUIWuUYPS7XFrdB8ylrbYH1OUwSTm
         kGWCO7+oRElh/NXPjFwYl1rhwVBa1i295hTuylqk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDg9BZ030396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:42:09 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:42:09 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:42:09 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDg5Wm003868;
        Mon, 14 Jan 2019 07:42:06 -0600
Subject: Re: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
To:     Jens Axboe <axboe@kernel.dk>, <john.hubbard@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190113012909.11986-1-jhubbard@nvidia.com>
 <20190113012909.11986-2-jhubbard@nvidia.com>
 <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a9d5a1a9-ae8f-5db0-106f-e69158163ba3@ti.com>
Date:   Mon, 14 Jan 2019 19:11:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/19 7:35 AM, Jens Axboe wrote:
> On 1/12/19 6:29 PM, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
>> the PHY_MODE_SATA, but that enum had not yet been added. This caused a
>> build failure for me, with today's linux.git.
>>
>> Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
>> in the Marvell Berlin SATA PHY driver.
>>
>> Fix the build by:
>>
>>     1) Renaming Marvell's defined value to a more scoped name,
>>        in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.
>>
>>     2) Adding the missing enum, which was going to be added anyway as part
>>        of [1].
>>
>> [1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com
>>
>> Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")
> 
> Linus, this is probably a better option in terms of what should go in to
> fix that commit.
> 
>>
>> Cc: Grzegorz Jaszczyk <jaz@semihalf.com>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/phy/marvell/phy-berlin-sata.c | 5 +++--
>>  include/linux/phy/phy.h               | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
>> index a91fc67fc4e0..d70ba9bc42d9 100644
>> --- a/drivers/phy/marvell/phy-berlin-sata.c
>> +++ b/drivers/phy/marvell/phy-berlin-sata.c
>> @@ -32,7 +32,7 @@
>>  
>>  /* register 0x01 */
>>  #define REF_FREF_SEL_25		BIT(0)
>> -#define PHY_MODE_SATA		(0x0 << 5)
>> +#define PHY_BERLIN_MODE_SATA	(0x0 << 5)
>>  
>>  /* register 0x02 */
>>  #define USE_MAX_PLL_RATE	BIT(12)
>> @@ -102,7 +102,8 @@ static int phy_berlin_sata_power_on(struct phy *phy)
>>  
>>  	/* set PHY mode and ref freq to 25 MHz */
>>  	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x01,
>> -				    0x00ff, REF_FREF_SEL_25 | PHY_MODE_SATA);
>> +				    0x00ff,
>> +				    REF_FREF_SEL_25 | PHY_BERLIN_MODE_SATA);
>>  
>>  	/* set PHY up to 6 Gbps */
>>  	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x25,
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index e8e118d70fd7..3f350e2749fe 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -42,6 +42,7 @@ enum phy_mode {
>>  	PHY_MODE_PCIE,
>>  	PHY_MODE_ETHERNET,
>>  	PHY_MODE_MIPI_DPHY,
>> +	PHY_MODE_SATA
>>  };
>>  
>>  /**
>>
> 
> 
