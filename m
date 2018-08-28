Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF70C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771DC208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771DC208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=macq.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeH1Mxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:53:43 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:51680 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeH1Mxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:53:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id 55E9C130D3E;
        Tue, 28 Aug 2018 11:03:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rcDiRL6LUPKO; Tue, 28 Aug 2018 11:03:00 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id AF221130D0E;
        Tue, 28 Aug 2018 11:03:00 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 905B1DF007A; Tue, 28 Aug 2018 11:03:00 +0200 (CEST)
Date:   Tue, 28 Aug 2018 11:03:00 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] media: imx274: use regmap_bulk_write to write
        multybyte registers
Message-ID: <20180828090300.GA23579@frolo.macqel>
References: <20180725162455.31381-1-luca@lucaceresoli.net> <20180725162455.31381-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162455.31381-2-luca@lucaceresoli.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:24:54PM +0200, Luca Ceresoli wrote:
> Currently 2-bytes and 3-bytes registers are set by very similar
> functions doing the needed shift & mask manipulation, followed by very
> similar for loops setting one byte at a time over I2C.
> 
> Replace all of this code by a unique helper function that calls
> regmap_bulk_write(), which has two advantages:
>  - sets all the bytes in a unique I2C transaction
>  - removes lots of now unused code.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
...
> +/**
> + * Write a multibyte register.
> + *
> + * Uses a bulk write where possible.
> + *
> + * @priv: Pointer to device structure
> + * @addr: Address of the LSB register.  Other registers must be
> + *        consecutive, least-to-most significant.
> + * @val: Value to be written to the register (cpu endianness)
> + * @nbytes: Number of bits to write (range: [1..3])
> + */
> +static int imx274_write_mbreg(struct stimx274 *priv, u16 addr, u32 val,
> +			      size_t nbytes)

Should nbytes be called nbits, or is nbytes a 'Number of bytes' ?

Philippe
-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
