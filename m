Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XCo2BXax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeKTJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:09:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51716 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbeKTJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:09:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJMgtSq092386;
        Mon, 19 Nov 2018 16:42:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542667375;
        bh=Rn4nDJ5kcbTVqCdYRf6PUmz0hCz9iln0gLVUGfP98UE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XCo2BXaxTkdATspPgYSgCEKg91kIJu1qj3EaeVp4Vl14F7nvV81aRh5/gtYWcYkwv
         sOyXrotMCEkkzS4gVyD1/mRtNHq4esxTio1R7ZIy3u+PLF5riAJ2ORRJIjghKobQoL
         0rCu1bioH5xpgGO+LaUEf4OMDZ0qAhVO3ZvbMw6Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJMgtsc091047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 16:42:55 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 16:42:55 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 16:42:54 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJMgs2q020871;
        Mon, 19 Nov 2018 16:42:54 -0600
Subject: Re: [PATCH v2 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-5-grygorii.strashko@ti.com>
 <20181119170732.GB30658@n2100.armlinux.org.uk>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <de388271-e8f8-bb57-8efa-99938468ffb6@ti.com>
Date:   Mon, 19 Nov 2018 16:42:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119170732.GB30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 11/19/18 11:07 AM, Russell King - ARM Linux wrote:
> On Fri, Nov 09, 2018 at 05:47:54PM -0600, Grygorii Strashko wrote:
>> Convert mvebu-cp110-comphy PHY driver to use recently introduced
>> PHY_MODE_ETHERNET and phy_set_mode_ext().
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
>>   drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 83 ++++++++++++++-----------
>>   2 files changed, 48 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> index 7a37a37..731793a 100644
>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> @@ -1165,28 +1165,13 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>>    */
>>   static int mvpp22_comphy_init(struct mvpp2_port *port)
>>   {
>> -	enum phy_mode mode;
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
>> -
>> -	ret = phy_set_mode(port->comphy, mode);
>> +	ret = phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET,
>> +			       port->phy_interface);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
>> index 79b52c3..7dee72b 100644
>> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
>> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/iopoll.h>
>>   #include <linux/mfd/syscon.h>
>>   #include <linux/module.h>
>> +#include <linux/phy.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>> @@ -131,26 +132,26 @@ struct mvebu_comhy_conf {
>>   
>>   static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
>>   	/* lane 0 */
>> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
>> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>>   	/* lane 1 */
>> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
>> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>>   	/* lane 2 */
>> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
>> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
>> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
>> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
>>   	/* lane 3 */
>> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
>> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
>> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
>> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
>>   	/* lane 4 */
>> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
>> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
>> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
>> -	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
>> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
>> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
>> +	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
>>   	/* lane 5 */
>> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
>> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
>> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>>   };
>>   
>>   struct mvebu_comphy_priv {
>> @@ -163,10 +164,12 @@ struct mvebu_comphy_lane {
>>   	struct mvebu_comphy_priv *priv;
>>   	unsigned id;
>>   	enum phy_mode mode;
>> +	int submode;
>>   	int port;
>>   };
>>   
>> -static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>> +static int mvebu_comphy_get_mux(int lane, int port,
>> +				enum phy_mode mode, int submode)
>>   {
>>   	int i, n = ARRAY_SIZE(mvebu_comphy_cp110_modes);
>>   
>> @@ -177,7 +180,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>>   	for (i = 0; i < n; i++) {
>>   		if (mvebu_comphy_cp110_modes[i].lane == lane &&
>>   		    mvebu_comphy_cp110_modes[i].port == port &&
>> -		    mvebu_comphy_cp110_modes[i].mode == mode)
>> +		    mvebu_comphy_cp110_modes[i].mode == submode)
> 
> This looks like it could be a future source of problems, since we
> have both a "mode" and a "submode".  Is there any reason not to
> rename mvebu_comphy_cp110_modes's .mode member to be .submode ?
> 

Thank you for review. I seems need to update it same way as requested
for ocelot-serdes by Quentin Schulz and add pair mode + submode handling
where needed. Will update and re-send.


-- 
regards,
-grygorii
