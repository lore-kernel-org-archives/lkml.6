Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7664C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E020843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHAH4UGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901E020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKDCdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeKDCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:33:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E684620833;
        Sat,  3 Nov 2018 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541265690;
        bh=HU06r3bRSe7zkc+tJM8e4O0v1IVSlqQAevS3gqArEuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHAH4UGMN+B1FnSFVRS3uKqeJ3jwDKx1ITiUJ07BLlCH0aQ6l5fY8dnnPUZvDCdM9
         3z63PU13dpB1Myq1vjEDQ3rZuGn64wBWEfyL3Ac/J2jy4v+ouCxPByU2zys4bRrpgs
         Cp0QRr0dfO4d4K28g8syVDk0Vz+W2sUzQE+TwWhM=
Date:   Sat, 3 Nov 2018 17:21:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103172125.40541052@archlinux>
In-Reply-To: <20181103160618.wioq7jbdh4z5yqdw@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
        <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
        <20181103131002.7956a08b@archlinux>
        <20181103160618.wioq7jbdh4z5yqdw@renatolg>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 13:06:19 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> On Thu, 1 Nov 2018 15:20:55 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >
> > This looks wrong.
> > I admit this was done in the same way in the probe function, but that looks
> > a bit wrong as well.
> >
> > Typically, the return value of `regulator_get_voltage()` would get checked
> > with:
> >
> > ret = regulator_get_voltage(st->reg);
> > if (ret < 0)
> >    return ret;
> > *val = ret / 1000;
> >
> > So, negative values are errors and zero & positive values are valid voltage
> > values.  
> 
> I see. So -EINVAL is only used when sent the wrong info type?
yes. I actually misread what was there and thought we were just talking
about using a ret variable rather than returning the error via your
local variable.

Definitely want to pass on the error from regulator_get_voltage as
it may have more meaning than a simple -EINVAL.

Thanks,

Jonathan


