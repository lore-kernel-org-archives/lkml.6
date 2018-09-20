Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A1CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D0A21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D0A21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbeITUoC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:44:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59319 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732640AbeITUoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:44:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9144E20795; Thu, 20 Sep 2018 17:00:07 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 658EA206EE;
        Thu, 20 Sep 2018 16:59:57 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Yelena Krivosheev <yelena@marvell.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni\@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier\@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal\@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw\@semihalf.com" <mw@semihalf.com>
Subject: Re: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA unmapping
References: <20180919132906.26868-1-antoine.tenart@bootlin.com>
        <5ab58500e78549618b597fdc2e54356a@IL-EXCH01.marvell.com>
        <20180920112010.GB1158@kwain>
Date:   Thu, 20 Sep 2018 16:59:58 +0200
In-Reply-To: <20180920112010.GB1158@kwain> (Antoine Tenart's message of "Thu,
        20 Sep 2018 13:20:10 +0200")
Message-ID: <87k1ngjjtd.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,
 
 On jeu., sept. 20 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> Hi Yelena,
>
> On Thu, Sep 20, 2018 at 10:14:56AM +0000, Yelena Krivosheev wrote:
>> 
>> Please, check and fix all cases of dma_unmap_single() usage.
>> See mvneta_rxq_drop_pkts()
>> ...
>> 		if (!data || !(rx_desc->buf_phys_addr))
>> 			continue;
>> 		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
>> 				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
>> 		__free_page(data);
>> ...
>
> I had a look at the one reported by CONFIG_DMA_API_DEBUG, and at DMA
> unmapping calls using PAGE_SIZE. As you pointed out there might be
> others parts, thanks!

Actually Jisheng had submitted a similar patch few weeks ago and as I
pointed at this time, the dma_unmap in mvneta_rxq_drop_pkts can be
called when the allocation is done in with HWBM in this case which use a
dma_map_single.

I though that in this case using dma_map_single is the things to do even
if in the SWBM case it is less optimal.

Gregory

>
> Antoine
>
> -- 
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
