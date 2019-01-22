Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98BDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCF220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfAVHtr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:49:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54062 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfAVHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:49:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 476E52078C; Tue, 22 Jan 2019 08:49:45 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id D7130206DC;
        Tue, 22 Jan 2019 08:49:44 +0100 (CET)
Date:   Tue, 22 Jan 2019 08:49:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-tegra@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH 2/2] mtd: rawnand: use unnamed union in struct
 nand_op_parser_pattern_elem
Message-ID: <20190122084944.420fcd4a@xps13>
In-Reply-To: <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com>
References: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
        <1548142975-14219-3-git-send-email-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 22 Jan
2019 16:42:55 +0900:

> Although drivers do not directly get access to the private data of
> instruction patterns, let's use unnamed union field to be consistent
> with nand_op_instr.
> 

Actually this is how we wrote it the first time. Then we got robots
reporting that anonymous unions where not allowed with older (still
supported) GCC versions and I had to do this:


commit c1a72e2dbb4abb90bd408480d7c48ba40cb799ce
Author: Miquel Raynal <miquel.raynal@free-electrons.com>
Date:   Fri Jan 19 19:11:27 2018 +0100

    mtd: nand: Fix build issues due to an anonymous union
    
    GCC-4.4.4 raises errors when assigning a parameter in an anonymous
    union, leading to this kind of failure:
    
    drivers/mtd/nand/marvell_nand.c:1936:
        warning: missing braces around initializer
        warning: (near initialization for '(anonymous)[1].<anonymous>')
        error: unknown field 'data' specified in initializer
        error: unknown field 'addr' specified in initializer
    
    Work around the situation by naming these unions.
    
    Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
    Reported-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
    Tested-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>


Thanks,
Miquèl
