Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871CEC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CFF21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544959422;
	bh=pfaUUOeARHVl/8SBswulyYjSmtIgwjgKGBuc1bMdI0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2cRI6CPaug3oZT86UW//xgQPeTfU4wyXz0Y+9DfQkiDz8L2L8/YH9GVwzYN/U/P/7
	 scw8tvjjgeTHi+bYzfGhCVlvmC6Sk3/zhKJcKBUtyjfWS6xOlErxBVgD5cNSp6qcB9
	 pOWnYyg2GxH+tJDlxUGq733FWO63M+oFPaf8G3EM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeLPLXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLPLXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:23:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225E2217FA;
        Sun, 16 Dec 2018 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544959420;
        bh=pfaUUOeARHVl/8SBswulyYjSmtIgwjgKGBuc1bMdI0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQbQnrO7AW/Uj7KDAJ0JpMQgT7SxhhiL5ov+iUbdATm0PWa9Y+DKgd9Di3Rn8Nrgv
         i7MsJc87IPXgJTbpZF3/jg7afC7Yrsjd1nB/wgTfwNicmzjOYZsRnzfKCPyJ78P+PP
         RAFqFZIC2bqvvyaTS0SowQBMhJyLJMRPBbbirEWc=
Date:   Sun, 16 Dec 2018 11:23:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jeremy Fertic <jeremyfertic@gmail.com>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 02/11] staging: iio: adt7316: invert the logic of the
 check for an ldac pin
Message-ID: <20181216112334.537f4e40@archlinux>
In-Reply-To: <20181214061820.GV3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-3-jeremyfertic@gmail.com>
        <20181212081949.GH3116@kadam>
        <20181213220629.GB2496@r2700x.localdomain>
        <20181214061820.GV3116@kadam>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 09:18:20 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Dec 13, 2018 at 03:06:29PM -0700, Jeremy Fertic wrote:
> > On Wed, Dec 12, 2018 at 11:19:49AM +0300, Dan Carpenter wrote:  
> > > On Tue, Dec 11, 2018 at 05:54:54PM -0700, Jeremy Fertic wrote:  
> > > > ADT7316_DA_EN_VIA_DAC_LDCA is set when the dac and ldac registers are being
> > > > used to update the dacs instead of the ldac pin. ADT7516_SEL_AIN3 is an adc
> > > > input that shares the ldac pin. Only set these bits if an ldac pin is not
> > > > being used.
> > > > 
> > > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>  
> > > 
> > > Huh...  This bug has always been there...
> > > 
> > > Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> > > 
> > > regards,
> > > dan carpenter
> > >   
> > 
> > Should I include this Fixes tag in v2? I wasn't sure how important this was
> > in staging. I think most of the patches in this series fix bugs that date
> > back to the introduction of the driver.  
> 
> I was just curious to see if it was a cleanup which introduced the
> inverted if statement.
> 
> I think the Fixes tag is always useful.  For example, it would be
> interesting to do some data mining to see how many bugs drivers
> normally have when they're first merged.
> 
Absolutely agreed. It's useful information even if we don't plan on
backporting.  Note that some staging fixes do get backported but
I'm adding a note to most things on this driver to say don't bother!

It's too far from 'good'.  Great to have multiple people working on
sorting that though!

If you and Shreeya could review each others patches that would be
cool.  I do have one of these, but I'm usually too lazy to actually
dig it out to test if there are others who are working with it
more normally!

Jonathan

> regards,
> dan carpenter

