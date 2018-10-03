Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5591213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5591213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJCTTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:19:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:19:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5390C207CC; Wed,  3 Oct 2018 14:31:04 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08B28207C3;
        Wed,  3 Oct 2018 14:30:54 +0200 (CEST)
Date:   Wed, 3 Oct 2018 14:30:54 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Message-ID: <20181003143054.597b3a9e@bbrezillon>
In-Reply-To: <20181003120028.9257-1-jmkrzyszt@gmail.com>
References: <20180719081508.5dafebde@bbrezillon>
        <20181003120028.9257-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Wed,  3 Oct 2018 14:00:28 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Replace legacy callbacks with ->select_chip() and ->exec_op().

Thanks for working on that, that's really appreciated.

> 
> Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> nand_wait_ready(),

I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
are doing, but is shouldn't be too hard to replace them by an
ams_delta_wait_ready() func.

> otherwise that function would probabaly have to be

				^ probably


> reimplemented inside the driver.  Hence, legacy callback ->dev_ready()
> is still used.
> 
> Use of IO_ADDR_R and IO_ADDR_W legacy structure members will be dropped
> later, as soon as the driver is converted to use GPIO API for data I/O.

In the meantime, can you move the iomem pointer to the ams_delta
private struct so that this driver no longer uses the ->IO_ADDR_R/W
fields?

> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Hi,
> 
> I've not tested the change on hardware yet as I'm not sure if:
> - handling of NCE limited to that inside ->select_chip() is
>   sufficient,

I think it is.

> - releasing ALE / CLE immediately after ams_delta_write_buf() is
>   correct.

Well, you should probably consider waiting for instr->ctx.delay_ns
nanoseconds after each instruction, but, if it was working before the
conversion to ->exec_op(), it should work just fine now.

Regards,

Boris
