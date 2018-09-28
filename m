Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD648C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8087E21748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8087E21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeI1NlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:41:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45091 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeI1NlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:41:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4369C20711; Fri, 28 Sep 2018 09:18:59 +0200 (CEST)
Received: from bbrezillon (unknown [176.187.87.154])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2A65620AB1;
        Fri, 28 Sep 2018 09:18:33 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:18:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20180928091833.15e95f7f@bbrezillon>
In-Reply-To: <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 06:59:58 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > 
> > It's still unclear why you need to specify a bits_per_word value,
> > but if this is needed, it's probably something you want to add to
> > spi.c, when a message is queued.  
> To specify a specific bits_per_word to be able to use the xspi
> (32bit) mode of the fsl_dspi module to transfer data, you can look at
> my PATCH 2/2. Do not add a value in spis.c that takes into account
> that the value assigned to bits_per_word is decided before the
> transfer. Thanks for your check and reply!

I might be wrong, but that's not my understanding of ->bits_per_word.
To me, it's something that you can use when your *device* (not
controller) expects non-byte aligned words [1]. The spi-mem protocol is
definitely designed to work with 1byte large words, so, as I said, I
suspect you're abusing xfer->bits_per_word to address a controller
driver issue.

[1]https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi.h#L114
