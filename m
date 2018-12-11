Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F89EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11B220855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11B220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeLKRxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:53:47 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50225 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:53:47 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 91780440205;
        Tue, 11 Dec 2018 19:53:42 +0200 (IST)
References: <20181211163228.26130-1-antoine.tenart@bootlin.com> <20181211163635.GG30658@n2100.armlinux.org.uk>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
In-reply-to: <20181211163635.GG30658@n2100.armlinux.org.uk>
Date:   Tue, 11 Dec 2018 19:53:42 +0200
Message-ID: <877egg6jbt.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, Antoine,

Russell King - ARM Linux writes:
> On Tue, Dec 11, 2018 at 05:32:28PM +0100, Antoine Tenart wrote:
>> The mvpp2_phylink_validate() function sets all modes that are
>> supported by a given PPv2 port. A recent change made all ports to
>> advertise they support 10G modes in certain cases. This is not true,
>> as only the port #0 can do so. This patch fixes it.
>> 
>> Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
>> Cc: Baruch Siach <baruch@tkos.co.il>
>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>> ---
>>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> index 125ea99418df..88aa488054a8 100644
>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> @@ -4405,12 +4405,14 @@ static void mvpp2_phylink_validate(struct net_device *dev,
>>  	case PHY_INTERFACE_MODE_10GKR:
>>  	case PHY_INTERFACE_MODE_XAUI:
>
> Are these modes supported on anything except port 0?  If not, you
> should be rejecting these, rather than just treating them as RGMII.

That is, something like this, right?

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 125ea99418df..04cb0241ca2b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4404,13 +4404,18 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_XAUI:
+		if (port->gop_id != 0)
+			goto empty_set;
+		/* Fall-through */
 	case PHY_INTERFACE_MODE_NA:
-		phylink_set(mask, 10000baseCR_Full);
-		phylink_set(mask, 10000baseSR_Full);
-		phylink_set(mask, 10000baseLR_Full);
-		phylink_set(mask, 10000baseLRM_Full);
-		phylink_set(mask, 10000baseER_Full);
-		phylink_set(mask, 10000baseKR_Full);
+		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseCR_Full);
+			phylink_set(mask, 10000baseSR_Full);
+			phylink_set(mask, 10000baseLR_Full);
+			phylink_set(mask, 10000baseLRM_Full);
+			phylink_set(mask, 10000baseER_Full);
+			phylink_set(mask, 10000baseKR_Full);
+		}
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
