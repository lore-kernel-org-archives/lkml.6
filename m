Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47310ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DE82075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DE82075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeGRQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:16:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbeGRQQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:16:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 86857207E8; Wed, 18 Jul 2018 17:37:39 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 52F9520766;
        Wed, 18 Jul 2018 17:37:39 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers in RX and TX queue
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
        <20180713161841.11202-4-gregory.clement@bootlin.com>
        <20180713191720.GA17271@n2100.armlinux.org.uk>
Date:   Wed, 18 Jul 2018 17:37:39 +0200
In-Reply-To: <20180713191720.GA17271@n2100.armlinux.org.uk> (Russell King's
        message of "Fri, 13 Jul 2018 20:17:20 +0100")
Message-ID: <87tvow8sho.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell King,
 
 On ven., juil. 13 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, Jul 13, 2018 at 06:18:37PM +0200, Gregory CLEMENT wrote:
>> From: Yelena Krivosheev <yelena@marvell.com>
>> 
>> The initial values were too small leading to poor performance when using
>> the software buffer management.
>
> What does this do to latency when a large transfer is also ongoing
> (iow, the classic bufferbloat issue) ?

IXIA latency test had been done without seeing any differences for long
traffic (routing).

These new values offer better performance for the main usage of this SoC
(NAS applications), however both Rx and TX queues size can be change by
ethtool.

Gregory

>
>> 
>> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
>> [gregory: extract from a larger patch]
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
>> index f4e3943a745d..c22df28b07c8 100644
>> --- a/drivers/net/ethernet/marvell/mvneta.c
>> +++ b/drivers/net/ethernet/marvell/mvneta.c
>> @@ -295,10 +295,10 @@
>>  #define MVNETA_RSS_LU_TABLE_SIZE	1
>>  
>>  /* Max number of Rx descriptors */
>> -#define MVNETA_MAX_RXD 128
>> +#define MVNETA_MAX_RXD 512
>>  
>>  /* Max number of Tx descriptors */
>> -#define MVNETA_MAX_TXD 532
>> +#define MVNETA_MAX_TXD 1024
>>  
>>  /* Max number of allowed TCP segments for software TSO */
>>  #define MVNETA_MAX_TSO_SEGS 100
>> -- 
>> 2.18.0
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
