Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AEF20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SCojItZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AEF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeKIIUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:20:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44344 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeKIIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:20:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8Mg2Io128496;
        Thu, 8 Nov 2018 16:42:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541716922;
        bh=gaYhPHrMk2tIGL5QxHfc9RcYeii56CmIRG7IB+bEwBw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SCojItZ6JoqX4YD6YuHvZEVPQgCLa/mA9srne9zSCqpzjVjNs3AQ128EyTmrOUp18
         zfX/1WpZD+qZBqhKlbmWeISD7+JtxAHY68LlnlfjNCL4hgH5koEgLLYoGN7f0ST6Qg
         IfCOaqs37i5Nd+m1uPBij8cCVNoTdGIEZBy1qngM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8Mg2Vv099774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 16:42:02 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 16:42:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 16:42:02 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8Mg2nF017008;
        Thu, 8 Nov 2018 16:42:02 -0600
Subject: Re: [PATCH 4/5] phy: mvebu-cp110-comphy: convert to use eth phy mode
 and submode
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-5-grygorii.strashko@ti.com>
 <20181108222123.GZ30658@n2100.armlinux.org.uk>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <61832475-9828-078c-170a-0d25915687d7@ti.com>
Date:   Thu, 8 Nov 2018 16:42:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108222123.GZ30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Russell,

On 11/8/18 4:21 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 07, 2018 at 06:36:16PM -0600, Grygorii Strashko wrote:
>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> index 7a37a37..fb28b71 100644
>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> @@ -1165,28 +1165,17 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>>    */
>>   static int mvpp22_comphy_init(struct mvpp2_port *port)
>>   {
>> -	enum phy_mode mode;
>> +	int submode;
>>   	int ret;
>>   
>>   	if (!port->comphy)
>>   		return 0;
>>   
>> -	switch (port->phy_interface) {
>> -	case PHY_INTERFACE_MODE_SGMII:
>> -	case PHY_INTERFACE_MODE_1000BASEX:
>> -		mode = PHY_MODE_SGMII;
>> -		break;
>> -	case PHY_INTERFACE_MODE_2500BASEX:
>> -		mode = PHY_MODE_2500SGMII;
>> -		break;
>> -	case PHY_INTERFACE_MODE_10GKR:
>> -		mode = PHY_MODE_10GKR;
>> -		break;
>> -	default:
>> -		return -EINVAL;
>> -	}
>> +	submode = port->phy_interface;
>> +	if (submode == PHY_INTERFACE_MODE_1000BASEX)
>> +		submode = PHY_INTERFACE_MODE_SGMII;
> 
> If the intention is to move the ethernet PHY mode into the generic PHY
> layer, I'd suggest that the equivalence of 1000base-X and SGMII is
> handled in the generic PHY driver rather than ethernet drivers.  Just
> move this into this hunk of the comphy driver:

sure, will do

> 
>> @@ -517,10 +519,14 @@ static int mvebu_comphy_set_mode(struct phy *phy,
>>   {
>>   	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>>   
>> -	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
>> +	if (mode != PHY_MODE_ETHERNET)
>> +		return -EINVAL;
>> +
>> +	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
>>   		return -EINVAL;
>>   
>>   	lane->mode = mode;
>> +	lane->submode = submode;
>>   	return 0;
>>   }
> 

-- 
regards,
-grygorii
