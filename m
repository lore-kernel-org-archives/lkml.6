Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6EC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8FF214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xhLXfv1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8FF214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJJGCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:02:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40036 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:02:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99Mh0iS089537;
        Tue, 9 Oct 2018 17:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539124980;
        bh=w1j/GeI+Oe4XSoSxU1oJwJLIJZSk5Zj99Qi8h0tRo0A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xhLXfv1SjeUsTu/3Zd8bL7Kdm0dumigkLNuvxCdweuJ0noDiuu9vWHhqz/zR1CUVH
         HptnesMVuwT5Fcbnzx0fkvzOmtgAuqMf8H/nrU5euIbeNJokoX4z4CByx6D+QRYNkm
         /dqXdLhhMzbGNBStQv8WyM6yvcHMoZzf9gWF/5ms=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99Mh072007898;
        Tue, 9 Oct 2018 17:43:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 17:43:00 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 17:43:00 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99Mh0Th001882;
        Tue, 9 Oct 2018 17:43:00 -0500
Subject: Re: [RFC PATCH 01/11] phy: core add phy_set_netif_mode() api
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-2-grygorii.strashko@ti.com>
 <54ba13bb-95e1-1519-a30f-8da198447489@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <18219d97-f86e-27ee-a116-a8febc3dcd24@ti.com>
Date:   Tue, 9 Oct 2018 17:43:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54ba13bb-95e1-1519-a30f-8da198447489@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 12:22 AM, Kishon Vijay Abraham I wrote:
> Hi Grygorii,
> 
> On Tuesday 09 October 2018 05:19 AM, Grygorii Strashko wrote:
>> Add new API phy_set_netif_mode(struct phy *phy, phy_interface_t mode) and
>> new PHY operation callback .set_netif_mode() which intended to be implemnte
>> by PHY drivers which supports Network interrfaces mode selection. Both
>> accepts phy_interface_t vlaue as input parameter.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/phy/phy-core.c  | 15 +++++++++++++++
>>   include/linux/phy/phy.h | 12 ++++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 35fd38c..d9aba1a 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -377,6 +377,21 @@ int phy_set_mode(struct phy *phy, enum phy_mode mode)
>>   }
>>   EXPORT_SYMBOL_GPL(phy_set_mode);
>>   
>> +int phy_set_netif_mode(struct phy *phy, phy_interface_t mode)
>> +{
>> +	int ret;
>> +
>> +	if (!phy || !phy->ops->set_netif_mode)
>> +		return 0;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	ret = phy->ops->set_netif_mode(phy, mode);
>> +	mutex_unlock(&phy->mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(phy_set_netif_mode);
> 
> We should try to add only generic PHY APIs and not subsystem specific APIs. In
> this case I think phy_set_mode should suffice.


This is what I've had in mind first, but all my guts argued against it after I've tried:

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bc73d2b..961b156 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -41,6 +41,14 @@ enum phy_mode {
        PHY_MODE_10GKR,
        PHY_MODE_UFS_HS_A,
        PHY_MODE_UFS_HS_B,
+       PHY_MODE_MODE_MII,
+       PHY_MODE_MODE_GMII,
+       PHY_MODE_MODE_SGMII,
+       PHY_MODE_MODE_RMII,
+       PHY_MODE_MODE_RGMII,
+       PHY_MODE_MODE_RGMII_ID,
+       PHY_MODE_MODE_RGMII_RXID,
+       PHY_MODE_MODE_RGMII_TXID,
 };

above introduces ugly constants duplication and required every network phy driver
to maintain conversation table  phy_interface_t -> enum phy_mode.
More over, if above change happens third time (first time PHY_MODE_SGMII/PHY_MODE_10GKR were added,
second - PHY_MODE_2500SGMII) it will never ends (there are ~15 more items only in phy_interface_t).
As result, enum phy_mode might became a un-maintainable monster.

So, as per above, and considering that Network subsystem is based on standards (phy_interface_t lists standard intf)
I've tried to add separate PHY API.

As an idea:
- seems it could be reasonable to introduce PHY_MODE_NETWORK (or PHY_MODE_ETHERNET) and
add generic phy_set_submode(struct phy *phy, long submode). 

So, single functional PHY device can just use phy_set_submode() and
multi-functional devices (like serdes which can be muxed between PCIe, USB, NET), can use:

phy_set_mode(PHY_MODE_ETHERNET)
phy_set_submode(X);

Any way, if you still agree to just add new above phy_modes - i'll redo patches.

-- 
regards,
-grygorii
