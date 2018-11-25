Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6982BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2624220867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcEf4KBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKYVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeKYVaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:30:46 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEDD2084E;
        Sun, 25 Nov 2018 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543142399;
        bh=e57a6F+d2gI6WyHO9FIP1Y9b0lEqPOtB2xizKBIirdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bcEf4KBQPmIAOjGx7keiNC1b0Xb5VFBhOZePeNKCB35OMnmOZq4dyXKl1xYNMIwaM
         YrWBOIjN4fmhvPl3SkageWXWeYcSB7uXCJgJTPespPGCBEvkko/mcruY+fly82nVHd
         kBdoTTuNf2ICtRTObSHmxRAniWvpjfon5gK0RgRA=
Date:   Sun, 25 Nov 2018 10:39:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     hofrat@osadl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, carlo@caione.org, khilman@baylibre.com,
        yixun.lan@amlogic.com, xingyu.chen@amlogic.com,
        gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf
 failure
Message-ID: <20181125103953.6d7bcf76@archlinux>
In-Reply-To: <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
References: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
        <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 22:44:55 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Thu, Nov 22, 2018 at 8:52 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kasprintf() may return NULL on failure of internal allocation thus
> > the assignments to  init.name  are not safe if not checked. On error
> > meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
> > (unlikely) failure case of devm_kasprintf() should be fine here.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")  
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> thank you for the patch!
> I tested the non-error case on my Odroid-C1 and it still works fine.
Applied.  I also added a tested by tag for you Martin as it's always nice
for the log to reflect when people make the effort!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> Regards
> Martin

