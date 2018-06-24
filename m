Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80629C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B0524F2C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B0524F2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeFXNrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:47:41 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51994 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeFXNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:47:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 431599E78FC;
        Sun, 24 Jun 2018 14:47:35 +0100 (BST)
Date:   Sun, 24 Jun 2018 14:47:34 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC
 support
Message-ID: <20180624144734.62f28908@archlinux>
In-Reply-To: <20180624143009.48cf14f8@archlinux>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
        <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
        <20180622151338.00003622@huawei.com>
        <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
        <20180624143009.48cf14f8@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018 14:30:09 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 24 Jun 2018 17:13:00 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
> 
> > Hi Jonathan,
> > 
> > On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:  
> > > On Thu, 21 Jun 2018 11:14:05 +0800
> > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > >    
> > >> From: Freeman Liu <freeman.liu@spreadtrum.com>
> > >>
> > >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
> > >> which is used to sample voltages with 12 bits conversion.
> > >>
> > >> [Baolin Wang did lots of improvements]
> > >>
> > >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
> > >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>    
> > >
> > > One trivial missed bit of cleanup inline.  I'll sort that
> > > when applying if no one else points anything out before I get back to my
> > > development machine.    
> > 
> > Thanks.  
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
Sorry, backed out for now.  My togreg tree is non rebasing and
this is dependant on some stuff that only went in during the merge
window.

I'll send a pull request to GregKH fairly soon and after that do
the merge back into my tree to pick that hwspin lock stuff up.

So this will be a week or two before I can apply it without issues.

Give me a poke if I seem to have forgotten about it.

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> >   
> > >> +
> > >> +     indio_dev->dev.parent = &pdev->dev;
> > >> +     indio_dev->name = dev_name(&pdev->dev);
> > >> +     indio_dev->modes = INDIO_DIRECT_MODE;
> > >> +     indio_dev->info = &sc27xx_info;
> > >> +     indio_dev->channels = sc27xx_channels;
> > >> +     indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
> > >> +     ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > >> +     if (ret) {
> > >> +             dev_err(&pdev->dev, "could not register iio (ADC)");
> > >> +             return ret;
> > >> +     }
> > >> +
> > >> +     platform_set_drvdata(pdev, indio_dev);    
> > >
> > > Why?  Looks like this is left over from when we had a remove.    
> > 
> > Sorry, I missed to remove this redundant code.
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

