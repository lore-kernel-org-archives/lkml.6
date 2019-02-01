Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B3A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549036406;
	bh=J05/pA4Tw3IyG/X7lPNXAUT0bLf1MB9DtIwPQW/iEvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XwJn/gEzT4MjJYPmk+3WY0RnyVmBP8GowdaHWP27IezNUloBs1yMbUph18DsA1DaP
	 uRrqNPLa6h9zmUVsdIb6dKQPsBMdzaWHkJp3jFReBnoKuKO4d8Y/PsCb3Jo6YAemh9
	 vx489wChULZ0/6Qzrh3pjXiH0Bw1JC73j6GVL+/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfBAPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfBAPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:53:24 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97A22086C;
        Fri,  1 Feb 2019 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549036403;
        bh=J05/pA4Tw3IyG/X7lPNXAUT0bLf1MB9DtIwPQW/iEvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+RJeNpI6tMS+cNBQgXFGRoY9jxzot3W4hbwqRh3gYrEaGNWcltzXn/2GMhxxsHL6
         1mAl3kONo1YykXQ7LeHJENSHm3oAMruNv4xQFRBNIUtNFWrwyBMv2rp55cVP6uDD2h
         jrP7K5tIq1tZljgCPIesJhWZcQqDgM3TF89MRQxM=
Date:   Fri, 1 Feb 2019 16:53:13 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] setup_data_interface() hook when switching to a
 different type of NAND chip
Message-ID: <20190201165218.22a0ac21@bbrezillon>
In-Reply-To: <CAK7LNAQLzvW-zDaR8qkDaxEXxmiCj7XQDK-G57sPhvZu1_eBdA@mail.gmail.com>
References: <CAK7LNAQLzvW-zDaR8qkDaxEXxmiCj7XQDK-G57sPhvZu1_eBdA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Fri, 1 Feb 2019 19:27:46 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi.
> 
> 
> When I was looking into the NAND controller/chips separation,
> this question popped up in my mind.
> 
> 
> Commit 2d472aba15ff169 provides us a more flexibility
> about the controller/chips connection.
> The connected NAND chips do not need to be homogeneous
> any more.
> 
> 
> My question is about the ->setup_data_interface() hook
> when switching between NAND chips with different speed (timing mode).
> 
> 
> Think about the case below:
> 
> {
>         compatible = "foo-nand-controller";
>         reg = <...>;
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         nand@0 {
>                   reg = <0>;
>                   /* Slow NAND chip */
>         }
> 
>         nand@1 {
>                   reg = <1>;
>                   /* Fast NAND chip */
>         }
> 
> }
> 
> 
> 
> In this case, two devices /dev/mtdblock0 and /dev/mtdblock1
> will appear.
> 
> If a user gets access to those two devices in turns,
> I think ->setup_data_interface() should be invoked somehow
> in order to update the timing registers on the controller side.
> 
> Currently, ->setup_data_interface() is invoked in nand_scan_tail()
> and that's it.
> 
> So, both nand@0 and nand@1 are accessed by the timing mode of nand@1
> (assuming nand@0 and nand@1 are initialized in this order)
> 
> 
> Of course, it depends on the controller.
> 
> If a controller has a register set for every chip select,
> the hardware will be able to change the access speed automatically.
> 
> 
> I think most of controllers just have a single set of timing registers.
> So, when switching between different types of chips,
> the driver must update the timing registers.
> 
> 
> If this is a worthwhile usecase,
> should it be taken care of by the NAND framework,
> or by drivers ?
> 
> 
> I just thought we could do something in
> nand_get_device() / nand_release_device().
> 
> 
> If this should be done per driver,
> drivers can update registers in select_target or select_chip.
> 
> 
> Thought?

It should be done by the driver in its select_target() handler.
Actually, it's already done like that in several drivers (marvell,
sunxi, ...).
->setup_data_interface() is not required to apply timings right away.
What it should do is convert the NAND timings into controller timings.
Of course, if the controller has one set of timing regs per CS, the
driver can apply timings right away, but when that's not the case,
controller timings should be stored in the private nand data and
applied when the chip is selected.

Feel free to enhance the ->setup_data_interface() doc if you think it's
not clear enough.

Regards,

Boris
