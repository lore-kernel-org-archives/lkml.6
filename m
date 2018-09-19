Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9220877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD9220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeITDGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:06:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36395 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeITDGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:06:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9385920795; Wed, 19 Sep 2018 23:26:31 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1F1C4203DA;
        Wed, 19 Sep 2018 23:26:31 +0200 (CEST)
Date:   Wed, 19 Sep 2018 23:26:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: rawnand: denali: remove ->dev_ready() hook
Message-ID: <20180919232630.105c3373@xps13>
In-Reply-To: <1536305309-28026-2-git-send-email-yamada.masahiro@socionext.com>
References: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
        <1536305309-28026-2-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri,  7 Sep
2018 16:28:28 +0900:

> The Denali NAND IP has no way to read out the current signal level
> of the R/B# pin.  Instead, denali_dev_ready() checks if the R/B#
> transition has already happened. (The INTR__INT_ACT interrupt is
> asserted at the rising edge of the R/B# pin.)  It is not a correct
> way to implement the ->dev_ready() hook.
> 
> In fact, it has a drawback; in the nand_scan_ident phase, the chip
> detection iterates over maxchips until it fails to find a homogeneous
> chip.  For the last loop, nand_reset() fails if no chip is there.
> 
> If ->dev_ready hook exists, nand_command(_lp) calls nand_wait_ready()
> after NAND_CMD_RESET.  However, we know denali_dev_ready() never
> returns 1 unless there exists a chip that toggles R/B# in that chip
> select.  Then, nand_wait_ready() just ends up with wasting 400 msec,
> in the end, shows the "timeout while waiting for chip to become ready"
> warning.
> 
> Let's remove the mis-implemented dev_ready hook, and fallback to
> sending the NAND_CMD_STATUS and nand_wait_status_ready(), which
> bails out more quickly.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Both patches applied on nand/next.

Thanks,
Miquèl
