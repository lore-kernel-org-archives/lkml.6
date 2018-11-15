Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C29223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C29223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbeKOXLt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:11:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40205 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbeKOXLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:11:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B93B20752; Thu, 15 Nov 2018 14:04:01 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id D800520510;
        Thu, 15 Nov 2018 14:04:00 +0100 (CET)
Date:   Thu, 15 Nov 2018 14:04:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181115140400.3934effe@xps13>
In-Reply-To: <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
        <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
        <20181105165321.7ea2b45f@bbrezillon>
        <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
        <20181106102851.61deb97a@bbrezillon>
        <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
        <20181106112206.65a70a81@bbrezillon>
        <20181112171351.4ac3506b@xps13>
        <20181112175416.247e3203@bbrezillon>
        <20181112184518.6c02ac6d@bbrezillon>
        <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Liang Yang <liang.yang@amlogic.com> wrote on Thu, 15 Nov 2018 19:25:07
+0800:

> Hi Boris,
> 
> I have implemented dma access base on these helpers you provided below.
> we prepare to send v7 version now, so when will these helpers be pushed?

Thanks for your work. You can send the v7 so we will have a look at the
overall driver; but since we raised the DMA buffers issue we had a
discussion with Boris about how to handle them and I think we are going
to adopt the same solution as Wolfram in the I2C subsystem: manual
flagging. Sadly, this is probably the best we can do to ensure proper
DMA support.

There is nothing set is stone yet but I started a small rework to
handle MTD operations differently (and add a DMA_SAFE flag), you can
have a look there [1]. Don't base your work on it for now as it is just
a preliminary version, subject to big changes.

[1] https://github.com/miquelraynal/linux/commits/dma-safe-buffers

Thanks,
Miquèl
