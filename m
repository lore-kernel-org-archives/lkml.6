Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D35EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B312156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="diBSyQYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B312156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeIVVGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeIVVGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:06:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39EDF20C0A;
        Sat, 22 Sep 2018 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537629130;
        bh=xFmWAhD7ESVWU1pQClaVLYJ8amkdMItl9sCvkYLz/18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diBSyQYEGweeiRVWYH1O8p/yaIUWU7rd7DcHKemfGga0IWv2fRV138UNIHPfXuq7i
         lnpwbzZx9fRRslYlWv8LVtkjzc/VkJYcqA8dFB1VhuFutqjqCw5r9KHu37l3gNZMs/
         3F3hZH5XYVfP9TeddbVaUWdZd7SvvXVUFXflZR+8=
Date:   Sat, 22 Sep 2018 16:12:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, tglx@linutronix.de, ak@it-klinger.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922161205.63d3f4cf@archlinux>
In-Reply-To: <20180922145658.GA4443@himanshu-Vostro-3559>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180922154658.752f2fbf@archlinux>
        <20180922145658.GA4443@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 20:26:58 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:21 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > This driver was originally written by ST in 2016 as a misc input device
> > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > from it's API and reformed it into an iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > It can be tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > There are a few bits and bobs in here, but as they are all minor and
> > one at least was me giving you wrong advise, I've fixed it up.
> > 
> > Please check I haven't made a mess of it! 
> > 
> > Applied with changes to the togreg branch of iio.git and pushed out
> > as testing (where it should be visible now) for the autobuilders to
> > play with it.  
> 
> The SPDX license identifier is inconsistent!
> 
> > +// SPDX-License-Identifier: GPL-2.0+  
> 
> > +MODULE_LICENSE("GPL v2");  
> 
> 216         For 'GNU General Public License (GPL) version 2 only' use:
> 217           SPDX-License-Identifier: GPL-2.0
> 218         For 'GNU General Public License (GPL) version 2 or any later version' use:
> 219           SPDX-License-Identifier: GPL-2.0+
> 
> 
Good spot.

I'll fix that up as well.

I'll assume the MODULE_LICENCE is right for now as it seems likely to have come
from the original ST code.

Jonathan
