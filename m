Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78665C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380F21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBHWFS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:18 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49977 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:18 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5561A20002;
        Fri,  8 Feb 2019 22:05:12 +0000 (UTC)
Date:   Fri, 8 Feb 2019 23:05:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 06/11] mtd: rawnand: denali: use more precise timeout
 for NAND_OP_WAITRDT_INSTR
Message-ID: <20190208230511.5ee7c0f1@xps13>
In-Reply-To: <1549613335-30319-7-git-send-email-yamada.masahiro@socionext.com>
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
        <1549613335-30319-7-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri,  8 Feb
2019 17:08:50 +0900:

> Currently, wait_for_completion_timeout() is always passed in the
> hard-coded msec_to_jiffies(1000). There is no specific reason for
> 1000 msec, but I just chose it long enough.
> 
> With the exec_op() conversion, NAND_OP_WAITRDY_INSTR provides more
> precise timeout value, depending on the preceding command. Let's use
> it to bail out earlier in error case.

I'm not sure using 10ms instead of 1000ms is relevant in the below
cases, 10ms is rather short for an IRQ, if your system is under load
you might end up with a timeout, not because the right IRQ did not
fire, but because the handler was not executed yet (it happened to me
in the marvell_nand.c driver recently).

Also, would you mind using a define instead of hardcoding '1000'?
 
> 
> I am still keeping the hard-coded values for other higher level hooks
> such as page_read, page_write, etc. We know the value of tR, tPROG, but
> we have unknowledge about the data transfer speed of the DMA engine.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks,
Miquèl
