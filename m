Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE41ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3F208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXFAtpw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD3F208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeIPRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 13:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbeIPRNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 13:13:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BA2208AE;
        Sun, 16 Sep 2018 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537098655;
        bh=f676sJuHl4MymWITk5UWOLhfqDCOCUh7x4Wl6E2YGk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bXFAtpw95v0kzj4SstkPFbKaeisN6+vE1WCwbz7buc/aBxb1+1y/ZzyKua+DTMGdc
         TLhaipPnrq6Xog6k/vM3XdBwZbJ8cx3YrBpOWEpSNEb7vvTB6tkfRCA3TyI/MDuMRu
         +99EZiTj8ITg1A+ijVoGhj4Er4UKfbGTjAC17GIM=
Date:   Sun, 16 Sep 2018 12:50:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Afonso Bordado <afonsobordado@az8.co>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180916125051.1a904196@archlinux>
In-Reply-To: <20180914173058.GA8405@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
        <201809121715.5Babt1QC%fengguang.wu@intel.com>
        <20180912182350.GA13032@himanshu-Vostro-3559>
        <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
        <20180914173058.GA8405@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 23:00:58 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Sep 14, 2018 at 04:26:44PM +0100, Afonso Bordado wrote:
> > Hi,
> > 
> > Thanks for your help with this.
> >   
> > > And I suspect it may be originating from your code snippet:
> > > 
> > > #define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >>
> > > (scale)))
> > > 
> > > and looking at the implementation:
> > > 
> > > include/linux/iio/iio.h
> > > /**
> > >  * IIO_DEGREE_TO_RAD() - Convert degree to rad
> > >  * @deg: A value in degree
> > >  *
> > >  * Returns the given value converted from degree to rad
> > >  */
> > > #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> > > 18000000ULL)
> > > 
> > > This '/' operator might be the culprit!
> > > 
> > > Just for checking that the error, remove the macro declaration
> > > `FXAS21002C_SCALE`
> > > plus its usage and re-cross compile using `make ARCH=i386`.
> > > 
> > > In my case I used the `div64_s64` function handles builds for both
> > > 32/64
> > > arch accordingly.  
> > 
> > Yes, this is indeed the culprit. If `div64_s64` works the same way, I
> > wonder if the best option is to change the macro definition.  
> 
> "....works the same way" ?
> 
> Let us assume that the problem arises due to the 64 bit division, in
> which gcc places the __divdi3() runtime function to promote the
> "freestanding" environment implementation. And then linking fails
> due to unavailability of definitions/declarations of the aforementioned
> function.
> 
> With `div64_s64` usgae the linker binds the definition present at lib/div64.c
> and the build completes successfully whether building for 32/64 bit
> environment.
> 
> But then why didn't this error showed up in the past, in the rest 
> of the drivers ?
> 
> I see its wide usage in IIO without bug reports:
> 
> himanshu@himanshu-Vostro-3559:~/linux-next$ git grep -w "IIO_DEGREE_TO_RAD" drivers/iio/ | wc -l
> 34
> 
> And that concludes, that there is some problem within your code!
> 
> In the meantime, you can try to look the disassembly of the function
> where this macro is actually used and search for __divdi3/__udivdi3
> function referenced in the plt.
> 
> I might be wrong though...
> 
> Wait a while for the experts to join in!
> 
The reason it's not usually a problem is because it is a compile time
constant for all the other drivers and GCC is more than happy to do
it on 32 bit platforms.

Now whilst it looks like you are doing something that needs to be dynamic
there are actually only a few possible values so this is something we
'want' to do at compile time rather than runtime.  Just add a look up
table for those 4 values instead of computing the conversion every
time.

Thanks,

Jonathan

