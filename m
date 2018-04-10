Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeDJKaH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:30:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752424AbeDJKaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:30:06 -0400
Date: Tue, 10 Apr 2018 12:30:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 9/9] mtd: nand: qcom: erased page bitflips detection
Message-ID: <20180410123003.34f4cfaa@xps13>
In-Reply-To: <1522845745-6624-10-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-10-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed,  4 Apr 2018 18:12:25 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Some of the newer nand parts can have bit flips in an erased
> page due to the process technology used. In this case, qpic

AFAIK, this has always been possible, it was just rare.

> nand controller is not able to identify that page as an erased
> page. Currently the driver calls nand_check_erased_ecc_chunk for
> identifying the erased pages but this won’t work always since the
> checking is being with ECC engine returned data. In case of
> bitflips, the ECC engine tries to correct the data and then it
> generates the uncorrectable error. Now, this data is not equal to
> original raw data. For erased CW identification, the raw data
> should be read again from NAND device and this
> nand_check_erased_ecc_chunk function should be called for raw
> data only.

Absolutely.

> 
> Now following logic is being added to identify the erased
> codeword bitflips.
> 
> 1. In most of the case, not all the codewords will have bitflips
>    and only single CW will have bitflips. So, there is no need to
>    read the complete raw page data. The NAND raw read can be
>    scheduled for any CW in page. The NAND controller works on CW
>    basis and it will update the status register after each CW read.
>    Maintain the bitmask for the CW which generated the uncorrectable
>    error.
> 2. Schedule the raw flash read from NAND flash device to
>    NAND controller buffer for all these CWs between first and last
>    uncorrectable errors CWs. Copy the content from NAND controller
>    buffer to actual data buffer only for the uncorrectable errors
>    CWs so that other CW data content won’t be affected, and
>    unnecessary data copy can be avoided.

In case of uncorrectable error, the penalty is huge anyway.

> 3. Both DATA and OOB need to be checked for number of 0. The
>    top-level API can be called with only data buf or oob buf so use
>    chip->databuf if data buf is null and chip->oob_poi if
>    oob buf is null for copying the raw bytes temporarily.

You can do that. But when you do, you should tell the core you used
that buffer and that it cannot rely on what is inside. Please
invalidate the page cache with:

chip->pagebuf = -1;

> 4. For each CW, check the number of 0 in cw_data and usable
>    oob bytes, The bbm and spare bytes bit flip won’t affect the ECC
>    so don’t check the number of bitflips in this area.

OOB is an area in which you are supposed to find the BBM, the ECC bytes
and the spare bytes. Spare bytes == usable OOB bytes. And the BBM
should be protected too. I don't get this sentence but I don't see its
application neither in the code?

> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
