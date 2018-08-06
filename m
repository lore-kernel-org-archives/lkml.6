Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C45821898
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C45821898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeHFNzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:55:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50570 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFNzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:55:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE6EF20794; Mon,  6 Aug 2018 13:46:47 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91F5E203EC;
        Mon,  6 Aug 2018 13:46:47 +0200 (CEST)
Date:   Mon, 6 Aug 2018 13:46:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jheng-Jhong Wu <goodwater.wu@gmail.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180806134648.2976de9e@bbrezillon>
In-Reply-To: <20180801120551.ju6zhxhoef6w5zim@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
        <20180801120551.ju6zhxhoef6w5zim@mwanda>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, 1 Aug 2018 15:05:51 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Aug 01, 2018 at 11:24:19AM +0800, Jheng-Jhong Wu wrote:
> > For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> > are necessary to address the correct page. The driver sets the address for
> > more than 16 bits, but it uses 16-bit arguments and variables (these are
> > page_id, block_id, row) to do address operations. Obviously, these
> > arguments and variables cannot deal with more than 16-bit address.
> > 
> > Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>  
> 
> This seems reasonable...  It would be needed to make commit 6efb21d6d0e7
> ("staging:mt29f_spinand: MT29F2G failing as only 16 bits used for
> addressing.") work.  It also fixes a static checker warning.
> 
> My only concern is that the mtd/nand code seems to use -1 as a magical
> page_id.  For example:

Yes, -1 means "don't issue the row/page address cycles", though I
don't think page can be -1 for NAND_CMD_READ{1,0} commands.

Anyway, if you want this patch merged to fix a static checker warning,
I'm fine with that. In any case, I still plan to send a patch removing
this driver for v4.20, so, anyone using this driver should start
testing the new SPI NAND driver (drivers/mtd/nand/spi) and tweak/fix
the new implementation if needed.

Regards,

Boris
