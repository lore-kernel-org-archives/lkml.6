Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D32C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915E52075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915E52075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJIRVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:21:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46161 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeJIRVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:21:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8EF782075C; Tue,  9 Oct 2018 12:05:32 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4F50220717;
        Tue,  9 Oct 2018 12:05:22 +0200 (CEST)
Date:   Tue, 9 Oct 2018 12:05:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20181009120522.6b2bd15a@bbrezillon>
In-Reply-To: <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 09:52:23 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> 1. In the dspi driver (spi controller), bits_per_word
> (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
> layer (spi-mem.c) is used. In this way, I can only assign the
> appropriate value of transfer->bits_per_word before passing to the
> controller, that is, the controller driver does not know the value of
> bits_per_word, and it will use this value when the upper level sets
> what value is passed.

I think you're missing my point: ->bits_per_word is not what you're
looking for if what you're trying to do is use 32-bits accesses when
things are properly aligned.

> 2. As I understand, bits_per_word does not
> exist for non-byte alignment, but for the need to reserve non-byte
> transmission mode that meets the controller.

Exactly. It's an optimization you have to take care of inside your
driver. The core cannot help you with that.

> 3. In addition, now the
> XSPI of dspi cannot transfer data normally, so this problem needs to
> be solved.

I still don't understand what the problem is.

> As for the DMA transfer mode, some colleagues will study
> it.

