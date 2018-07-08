Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C4C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7420837
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGHVrq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:47:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38056 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754371AbeGHVro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:47:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 449002079C; Sun,  8 Jul 2018 23:47:42 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E5B1203B4;
        Sun,  8 Jul 2018 23:47:41 +0200 (CEST)
Date:   Sun, 8 Jul 2018 23:47:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v5] mtd: rawnand: qcom: erased page bitflips detection
Message-ID: <20180708234742.0d86b9d1@xps13>
In-Reply-To: <1530619563-24712-1-git-send-email-absahu@codeaurora.org>
References: <1530619563-24712-1-git-send-email-absahu@codeaurora.org>
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

Abhishek Sahu <absahu@codeaurora.org> wrote on Tue,  3 Jul 2018
17:36:03 +0530:

> NAND parts can have bitflips in an erased page due to the
> process technology used. In this case, QCOM NAND controller
> is not able to identify that page as an erased page.
> Currently the driver calls nand_check_erased_ecc_chunk() for
> identifying the erased pages but this won’t work always since the
> checking is being with ECC engine returned data. In case of
> bitflips, the ECC engine tries to correct the data and then it
> generates the uncorrectable error. Now, this data is not equal to
> original raw data. For erased CW identification, the raw data
> should be read again from NAND device and this
> nand_check_erased_ecc_chunk function() should be called for raw
> data only.
> 
> Now following logic is being added to identify the erased
> codeword bitflips.
> 
> 1. In most of the cases, not all the codewords will have bitflips
>    and only single CW will have bitflips. So, there is no need to
>    read the complete raw page data. The NAND raw read can be
>    scheduled for any CW in page. The NAND controller works on CW
>    basis and it will update the status register after each CW read.
>    Maintain the bitmask for the CW which generated the uncorrectable
>    error.
> 2. Do raw read for all the CW's which generated the uncorrectable
>    error.
> 3. Both DATA and OOB need to be checked for number of 0. The
>    top-level API can be called with only data buf or OOB buf so use
>    chip->databuf if data buf is null and chip->oob_poi if
>    OOB buf is null for copying the raw bytes temporarily.
> 4. For each CW, check the number of 0 in cw_data and usable
>    oob bytes, The bbm and spare (unused) bytes bit flip won’t
>    affect the ECC so don’t check the number of bitflips in this area.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v4:
> 
>  1. Used for_each_set_bit for determining CW’s which generated
>     uncorrectable errors.
>  2. Introduced cw_data_buf and cw_oob_buf which will have starting
>     buffer address for current codeword and used the same in helper
>     functions.
>  3. Added new line before calling of nand_check_erased_ecc_chunk for
>     better code readability.
> 
> * Changes from v3:
> 
>  1. Major changes in erased codeword detection for
>     raw read function
> 
> * Changes from v2:
>   NONE
> 
> * Changes from v1:
>  1. Minor change in commit message
>  2. invalidate pagebuf if databuf or oob_poi is used
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 126 +++++++++++++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 37 deletions(-)

Applied to nand/next.

Thanks,
Miquèl
