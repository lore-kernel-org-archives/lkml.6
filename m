Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70550ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C34A20877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C34A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeITPCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:02:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57201 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeITPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:02:48 -0400
X-IronPort-AV: E=Sophos;i="5.53,397,1531810800"; 
   d="scan'208";a="20304057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2018 02:20:17 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 20 Sep 2018 02:20:16 -0700
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON
 flash
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <bd92d56c-fba6-6b79-07a8-cb426de33639@microchip.com>
 <VI1PR04MB103873DF92DF3380E53C572699130@VI1PR04MB1038.eurprd04.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <2f7430c2-bef0-0959-e428-ea1658cb9818@microchip.com>
Date:   Thu, 20 Sep 2018 12:20:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB103873DF92DF3380E53C572699130@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -271,6 +271,7 @@ static inline int set_4byte(struct spi_nor *nor, const
>> struct flash_info *info,
>>>  	u8 cmd;
>>>
>>>  	switch (JEDEC_MFR(info)) {
>>> +	case SNOR_MFR_ST:
>>
>> We should mark switch cases where we are expecting to fall through, so that we
>> will be prepared when enabling -Wimplicit-fallthrough.
> 
> Please explain more, not able to get this comment. Sorry for ignorance.
> 
>>
>>>  	case SNOR_MFR_MICRON:
>>>  		/* Some Micron need WREN command; all will accept it */
>>>  		need_wren = true;

We can ignore my comment, it's not in the scope of this patch.

I wrongly suggested to do this:
case SNOR_MFR_ST:
	/* fall through */
case SNOR_MFR_MICRON:

in order to suppress the -Wimplicit-fallthrough warning that I thought it will
appear on gcc 7. The suggestion is wrong because the warning is not emitted for
empty case bodies, so it's not needed here.

However, when compiling with gcc 7 and -Wimplicit-fallthrough the following can
be seen:

drivers/mtd/spi-nor/spi-nor.c: In function ‘set_4byte’:
drivers/mtd/spi-nor/spi-nor.c:290:13: warning: this statement may fall through
[-Wimplicit-fallthrough=]
   need_wren = true;
   ~~~~~~~~~~^~~~~~
drivers/mtd/spi-nor/spi-nor.c:291:2: note: here
  case SNOR_MFR_MACRONIX:
  ^~~~

We should add a /* fall through */ comment after setting need_wren = true;, but
it's not in the scope of this patch.

Cheers,
ta
