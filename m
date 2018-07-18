Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6153ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CAD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CAD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbeGRWJp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:09:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeGRWJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:09:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D88C320731; Wed, 18 Jul 2018 23:29:56 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46D01206A6;
        Wed, 18 Jul 2018 23:29:46 +0200 (CEST)
Date:   Wed, 18 Jul 2018 23:29:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 5/5] mtd: rawnand: qcom: reorganization by removing
 read/write helpers
Message-ID: <20180718232945.407e22de@xps13>
In-Reply-To: <1530863519-5564-6-git-send-email-absahu@codeaurora.org>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
        <1530863519-5564-6-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
13:21:59 +0530:

> Driver does not send the commands to NAND device for page
> read/write operations in ->cmdfunc(). It just does some
> minor variable initialization and rest of the things
> are being done in actual ->read/write_oob[_raw].

Thank you for cleaning actively this driver. I think you are comfortable
enough now to switch to start the migration to ->exec_op().

I will take this patch as I think it shrinks a bit the driver (which is
inordinately huge) but I would like to get rid of any kind of hackish
->cmdfunc() implementation. Boris and I can help you doing that, you
can grep for drivers already converted and observe they structure
(marvell, fsmc, vf610).

> 
> The generic helper function calls for invoking commands during
> page read/write are making this driver complicated. For QCOM NAND
> driver, ->cmdfunc() does minor part of initialization and rest of
> the initialization is performed by actual page read/write
> functions. Also, ->read/write_oob() does not calls helper
> function and all the initialization is being done in
> ->read/write_oob() itself.  
> 
> Since after 'commit 25f815f66a14 ("mtd: nand: force drivers to
> explicitly send READ/PROG commands")', sending of commands has
> been moved to driver for page read/write, so this patch does
> following changes to make code more readable:
> 
> 1. Introduce qcom_nand_init_page_op() and qcom_nand_start_page_op()
>    helper functions which helps in removing code duplication in each
>    operation.
> 
> 2. After issuing PROGRAM PAGE/BLOCK ERASE, QCOM NAND
>    controller waits for BUSY signal to be de asserted and
>    automatically issues the READ STATUS command. Currently, driver
>    is storing this status privately and returns the same when status
>    command comes from helper function after program/erase operation.
>    Now, for write operations, the status can be returned from main
>    function itself, so storing status can be removed for program
>    operations.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

Thanks,
Miquèl
