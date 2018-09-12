Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CCB20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CCB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeILTjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:39:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56012 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeILTjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:39:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 501C020799; Wed, 12 Sep 2018 16:34:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D52D203DA;
        Wed, 12 Sep 2018 16:34:03 +0200 (CEST)
Date:   Wed, 12 Sep 2018 16:34:02 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180912143402.GA23373@kwain>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
 <20180831143721.GB19733@lunn.ch>
 <20180831152131.GN30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831152131.GN30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Fri, Aug 31, 2018 at 04:21:31PM +0100, Russell King - ARM Linux wrote:
> 
> I think some questions for Antoine are:

I just got back to this. Using the SFP port on the 7040-db board (which
is one of the problematic interfaces):

> - what is the state of the carrier at the start of mvpp2_start() ?

Always on.

> - when does the missing call to mac_link_up() occur - is it the first
>   time the netdev is brought up, or a subsequent time?

Only the first time the netdev is brought up. If the link is set down
and then up again, its phylink link state would be good, and a mismatch
with the carrier state occurs as expected.

> - is the carrier always off at the end of mvpp2_stop()?

Always off.

So the issue really is the phylink internal link state matching the
carrier on when phylink is started the first time (and hence mac_config
is not called).

I've made some patches to rework PPv2 not to mess things up in
mac_config(), I've added a call to netif_carrier_off() at the
beginning of phylink_start(), and then removed the netif_carrier_off()
call in mvneta's open() function. It seems to work fine, I tested a few
boards with various network configurations. I'll send them so that
we can have more people testing this, and have proper reviews, since
this seems to be an acceptable solution given the answers in this
thread.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
