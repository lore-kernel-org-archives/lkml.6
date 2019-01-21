Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFFC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F46B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548096848;
	bh=hq+FdVIPwR3zOZB3uDNDr9SstA4vB1P6EsPzIIFlyPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UnsN/ZIvwWBPFww7gfJ8KOv18BjUZwzWY+iBgvQVCOrtSyN/AvId6oEdAxUnQnY1z
	 8ks1XwBHT2GDCu49MSL8JmLgsSQfmJe+Y5RACWTm+VaN00xHu9DKhelxErvTN2v9Jo
	 TsbXH6CEJsEEZ5RuGH8di3jftACWuVePuloXEgzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAUSyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfAUSyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:54:06 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3117C20861;
        Mon, 21 Jan 2019 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548096845;
        bh=hq+FdVIPwR3zOZB3uDNDr9SstA4vB1P6EsPzIIFlyPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qpIyXnjtokVHLfibtrZIn4JYHUK+5nJ3SncSX+DtnA92E6HIUP+7pwaxeZNagpz+b
         APZVWwkNufJywCcbKgRkcfbeTWJatblH7dVtU4znfOdcGQH+EaDH/smYLB7WrPSP/w
         PFjkNHRmXOl8PXicW5whoRqsxI/ZWoP+ErGzqcYg=
Date:   Mon, 21 Jan 2019 19:53:54 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: check return code of nand_reset() and
 nand_readid_op()
Message-ID: <20190121195354.788199f5@bbrezillon>
In-Reply-To: <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
References: <1548075934-19963-1-git-send-email-yamada.masahiro@socionext.com>
        <20190121141403.20f6107b@bbrezillon>
        <CAK7LNATUpyfnicBiSdL49dsFnvo+M=N9X-wY-J0efnRc-1_0gA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 00:57:43 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 
> Maybe, is the following better?

Sounds good, even if the original commit message was fine too. I was
just pointing out that nand_scan() should, when possible, be passed
the real number of CS lines connected to the chip instead of the max
number of CS lines supported by the controller.

> 
> 
> ------------------>8-----------------------  
> nand_scan_ident() iterates over maxchips to find as many homogeneous
> chips as possible.
> 
> Since commit 2d472aba15ff ("mtd: nand: document the NAND controller/NAND
> chip DT representation"), new drivers should pass in the exact number of
> CS lines instead of possible max, but old platforms may still rely on
> nand_scan_ident() to detect the actual number of connected CS lines.
> 
> In that case, this loop bails out when manufacturer or device ID
> unmatches. The reason of unmatch is most likely no chip is connected
> to that CS line. If so, nand_reset() should already have failed,
> and the following nand_readid_op() is pointless.
> 
> Before ->exec_op hook was introduced, drivers had no way to tell
> the failure of NAND_CMD_RESET to the framework because the legacy
> ->cmdfunc() has void return type. Now drivers implementing ->exec_op  
> hook can return the error code. You can save nand_readid_op() by
> checking the return value of nand_reset(). The return value of
> nand_readid_op() should be checked as well. If it fails, probably
> id[0] and id[1] are undefined values.
> 
> Just for consistency, it should be sensible to check the return
> code in nand_do_write_oob() as well.
