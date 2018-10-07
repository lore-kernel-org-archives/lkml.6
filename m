Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D2C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FFE214C2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FFE214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJGW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:28:05 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50552 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGW2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:28:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id CAF554926E;
        Sun,  7 Oct 2018 16:20:23 +0100 (BST)
Date:   Sun, 7 Oct 2018 16:20:20 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: Add PNI RM3100 device tree binding.
Message-ID: <20181007162020.6535767e@archlinux>
In-Reply-To: <20181007161808.44a61d45@archlinux>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-3-songqiang1304521@gmail.com>
        <20181007161808.44a61d45@archlinux>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2018 16:18:08 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  2 Oct 2018 22:38:11 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > ---
> >  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > new file mode 100644
> > index 000000000000..4677690fc5d0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > @@ -0,0 +1,20 @@
> > +* PNI RM3100 3-axis magnetometer sensor
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100"
> > +- reg : the I2C address or SPI chip select number of the sensor.
> > +
> > +Optional properties:
> > +
> > +- interrupts: data ready (DRDY) from the chip.
> > +  The interrupts can be triggered on rising edges.  
> From Phil's response this appears to be incorrect and
> it's actually a level sensitive interrupt.
> I haven't checked the data sheet to confirm this.
> 
> That'll bring all sorts of pain if you have a host that can only
> do edge sensitive so I'm hoping that's not true for you
> (edge sensitive only interrupts on hosts are pretty unusual
> though it cause me a lot of problems when I started out
> with IIO years ago :(
> 
> The docs aren't super clear on this.  The subtlety is
> whether there is a guaranteed 'low' time between reading the
> data and it going high again due to another reading.  This usually
> only matters if you are running very quickly though so may be
> fine here.
> 
> This will only become relevant with continuous mode if you
> add support for that later (I think!)
I realised just after I sent this that I was being unclear.

If you aren't doing continuous mode and hence have a fairly
strong guarantee of a decent gap between reads, you may be
able to get away with supporting either LEVEL or EDGE
interrupts.  In continuous mode, it is necessary to have
a minimum low time for EDGE interrupts to work.

Jonathan
> 
> Jonathan
> 
> > +
> > +Example:
> > +
> > +rm3100: rm3100@20 {
> > +	compatible = "pni,rm3100";
> > +	reg = <0x20>;
> > +	interrupt-parent = <&gpio0>;
> > +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> > +};  
> 

