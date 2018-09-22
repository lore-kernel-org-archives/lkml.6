Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362AFECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102C21567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvikT6S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D102C21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeIVPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeIVPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:05:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C755421532;
        Sat, 22 Sep 2018 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537607529;
        bh=HCxI/MK105iEdQgLB9YTN2SqTi8uOuasEV3caJW+t8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvikT6S38KFKdntfnxqhO/wSDhvHFTPQ+/HfQqgYbmEGCTLf2r9W/nP+eC2E/ThAF
         QImASlphW6r2O+cLY/uaWQ7yctiCCXZGdVUTrbEv6CDH/3p8UK4gerS2yCqrKGMgMN
         fz8rIZz7VGLNbxsZUpO8H2V24xXhV1BH0YwZn0j0=
Date:   Sat, 22 Sep 2018 10:12:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
Message-ID: <20180922101204.07ce82d5@archlinux>
In-Reply-To: <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
References: <20180918170850.2749-1-david@lechnology.com>
        <20180918170850.2749-4-david@lechnology.com>
        <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 12:14:50 -0500
David Lechner <david@lechnology.com> wrote:

> On 09/18/2018 12:08 PM, David Lechner wrote:
> > This changes how the SPI message for the triggered buffer is setup in
> > the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> > multiple samples in a single SPI transfer. If the SPI controller
> > supports DMA transfers, we can see a significant reduction in CPU usage.
> > 
> > For example, on an ARM9 system running at 456MHz reading just 4 channels
> > at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> > of this driver to be ~7.7%. After this change, the CPU usage drops to
> > ~3.8%.
> > 
> > The use of big-endian for the raw data was cargo culted from another
> > driver when this driver was originally written. It used an SPI word size
> > of 8 bits and big-endian byte ordering to effectively emulate 16 bit
> > words.
> > 
> > Now, in order to inject a CS toggle between each word, we need to use
> > the correct word size, otherwise we would get a CS toggle half way
> > through each word 16-bit. The SPI subsystem uses CPU byte ordering for
> > multi-byte words. So, the data we get back from the SPI is going to be
> > CPU endian now no matter what. Converting that to big endian will just
> > add overhead on little endian systems so we opt to change the raw data
> > format from big endian to CPU endian.
> > 
> > There is a small risk that this could break some lazy userspace programs
> > that use the raw data without checking the data format. We can address
> > this if/when it actually comes up.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---  
> 
> And I just realized I forgot to pick up...
> 
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
I've applied this on top of the original series on the basis I doubt
anyone will be testing this particular driver in such a way as to hit the
changes you made in the last two patches + I don't think Mark has tagged
those for me to easily pick up.  If it's a problem I can apply them
to the IIO tree as well and git will sort it out come merge window time.
However, that's inelegant so I won't do it unless needed.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it

Thanks,

Jonathan


