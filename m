Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E54ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2013214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2013214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbeGMAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:43:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45828 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbeGMAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:43:11 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CEFF114019AE3;
        Thu, 12 Jul 2018 17:31:09 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:31:07 -0700 (PDT)
Message-Id: <20180712.173107.1123272614896683104.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 00/18] net: mvpp2: add RSS support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 17:31:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 12 Jul 2018 13:54:09 +0200

> This series adds support for RSS on PPv2. There already was some code to
> handle the RSS tables, but the driver was missing all the classification
> steps required to actually use these tables.
> 
> RSS is used through the classifier, using at least 2 lookups :
>  - One using the C2 engine, a TCAM engine that match the packet based on
>    some header extracted fields, assigns the default rx queue for that
>    packet and tag it for RSS
>  - One using the C3Hx engine, which computes the hash that's used to perform
>    the lookup in the RSS table.
> 
> Since RSS spreads the load across CPUs, we need to make sure that packets
> from the same flow are always assigned the same rx queue, to prevent
> re-ordering.
> 
> This series therefore adds a classification step based on the Header Parser,
> that separate ingress traffic into 52 flows, based on some L2, L3 and L4
> parameters.
> 
> Patches 1 and 2 fix some header issues, from the driver splitting
> 
> Patches 3 to 7 make sure the correct receive queue setup is used for RSS
> 
> Patches 8 to 14 deal with the way we handle the RSS tables
> 
> Patch 15 implement basic classifier configuration, by using it to assign the
> default receive queue
> 
> Patch 16 implement the ingress traffic splitting into multiple flows
> 
> Patch 17 adds RSS support, by using the needed classification steps
> 
> Patch 18 adds the required ethtool ops to configure the flow hash parameters
> 
> This was tested on MacchiatoBin, giving some nice performance improvements
> using ip forwarding (going from 5Gbps to 9.6Gbps total throughput).
> 
> RSS is disabled by default.

Series applied, thank you.
