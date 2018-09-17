Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1509ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B10214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B10214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeIQOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:00:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbeIQOAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:00:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A4FEE88EFB61;
        Mon, 17 Sep 2018 16:33:38 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 16:33:38 +0800
Date:   Mon, 17 Sep 2018 09:33:25 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     David Lechner <david@lechnology.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Mark Brown" <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
 CPU usage
Message-ID: <20180917093325.00006e24@huawei.com>
In-Reply-To: <b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-4-david@lechnology.com>
        <20180916124110.4edfad9d@archlinux>
        <b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018 11:24:16 -0500
David Lechner <david@lechnology.com> wrote:

> On 09/16/2018 06:41 AM, Jonathan Cameron wrote:
> > On Wed, 12 Sep 2018 19:39:19 -0500
> > David Lechner <david@lechnology.com> wrote:
> >   
> >> This changes how the SPI message for the triggered buffer is setup in
> >> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> >> multiple samples in a single SPI transfer. If the SPI controller
> >> supports DMA transfers, we can see a significant reduction in CPU usage.
> >>
> >> For example, on an ARM9 system running at 456MHz reading just 4 channels
> >> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> >> of this driver to be ~7.7%. After this change, the CPU usage drops to
> >> ~3.8%.
> >>
> >> Signed-off-by: David Lechner <david@lechnology.com>  
> > 
> > Hi David,
> > 
> > I've managed to forget why we are changing any of the endian related code
> > at all.  The change SPI_CS_WORD result in changes between words which is
> > fine but it doesn't change any ordering within words?  So as such why
> > do we no longer need to do the big endian conversions?
> >   
> 
> The big-endian stuff was cargo culted from another driver when this driver
> was originally written. It used an SPI word size of 8 bits and big-endian
> byte ordering to effectively emulate 16 bit words.
> 
> Now, in order to inject a CS toggle between each word, we need to use the
> correct word size, otherwise we would get a CS toggle half way through
> each word 16-bit. The SPI subsystem uses CPU byte ordering for multi-byte
> words. So, the data we get back from the SPI is going to be CPU endian now
> no matter what. Converting that to big endian will just add overhead on
> little endian systems.

Cool. Thanks for the explanation.  If you are rerolling put that in the
patch description.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm kind of assuming Mark will want to take this through the SPI tree
if he is happy with it.

Mark, shout if you want to do it another way.

Thanks,

Jonathan

