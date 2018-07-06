Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE434C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80C224E8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E80C224E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeGFVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:37:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46003 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754151AbeGFVhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:37:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C83FB2072D; Fri,  6 Jul 2018 23:37:10 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80D16206DE;
        Fri,  6 Jul 2018 23:37:00 +0200 (CEST)
Date:   Fri, 6 Jul 2018 23:37:01 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, "Bean Huo \(beanhuo\)" <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180706233701.05da0666@bbrezillon>
In-Reply-To: <20180706212720.0e9dacb8@bbrezillon>
References: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
        <20180706212720.0e9dacb8@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 21:27:20 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Mon, 25 Jun 2018 10:44:42 +1200
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
> > Hi,
> > 
> > I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip  
> 
> Hm, it's even worse than I thought. The model name does not include the
> -ITE suffix (E means ECC can't be disabled), which means we have no way
> to detect the version with forced on-die ECC.
> 
> I see 2 solutions to this problem:
> 1/ Bean provides us a solution to reliably detect when ECC can be
>    de-actived and when it can't
> 2/ We only ever expose 64 bytes of OOB to the user and consider that
>    ECC can be disabled, even if it can't in reality
>

After reading the doc again, I forgot one thing you can try before
deciding to go for option #2.

8th bit in byte 5 of READID's result encodes whether the on-die ECC
state (enabled or not). I remember we had a discussion with Bean where
he told us this was a runtime status reflecting the on-die ECC state,
which is crazy, since READID might return different values depending on
the NAND state, and most of the code in the core assumes READID
provides a fixed ID that encodes the chip characteristics/capabilities,
not its state.

Anyway, if this bit is actually reflecting the on-die ECC state and
on-die cannot be disabled on your chip, it should stay at 1 even after
you have sent the SET_FEATURES(DISABLE_ECC) command. Let's hope this
works as I expect, otherwise we're back to option #2 until Bean suggest
something else.
