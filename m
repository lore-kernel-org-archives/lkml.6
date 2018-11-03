Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0682DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4CF20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fshX1JsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4CF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeKCT4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbeKCT4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:56:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA312081D;
        Sat,  3 Nov 2018 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541241915;
        bh=ICPJuaustjcgPaNXsiCg8rAABPBDIDRRtVEheBzpQhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fshX1JsLeh8fPTYageaK50ALlG1upb5rNH0kDdQ5E1sWriObGCyiIQ6KmuPX14Vhk
         tZ4apwp/mxlcmMjPIhT4JFRNNJu81p66MknOCSZtLGnAwlLy7VD2mZIkGpHmTLWd0E
         HRNAhdX3m7pYkyLZvNAztsdSKUX7QdoOylGRiOCI=
Date:   Sat, 3 Nov 2018 10:45:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181103104511.42d96448@archlinux>
In-Reply-To: <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-3-matheus.bernardino@usp.br>
        <20181028164329.57162e06@archlinux>
        <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 10:59:06 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> On 10/28/18 1:43 PM, Jonathan Cameron wrote:
> > On Fri, 26 Oct 2018 23:00:01 -0300
> > Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >  
> >> Previously, ad2s90_probe ignored the return code from spi_setup, not
> >> handling its possible failure. This patch makes ad2s90_probe check if
> >> the code is an error code and, if so, do the following:
> >>
> >> - Call dev_err with an appropriate error message.
> >> - Return the spi_setup's error code, aborting the execution of the
> >> rest of the function.
> >>
> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> >> ---
> >>   drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> >> index 11fac9f90148..d6a42e3f1bd8 100644
> >> --- a/drivers/staging/iio/resolver/ad2s90.c
> >> +++ b/drivers/staging/iio/resolver/ad2s90.c
> >> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
> >>   	/* need 600ns between CS and the first falling edge of SCLK */
> >>   	spi->max_speed_hz = 830000;
> >>   	spi->mode = SPI_MODE_3;
> >> -	spi_setup(spi);
> >> +	ret = spi_setup(spi);
> >> +
> >> +	if (ret < 0) {
> >> +		dev_err(&spi->dev, "spi_setup failed!\n");
> >> +		return ret;
> >> +	}  
> > I would have reordered this first to be before the iio_device_register call.
> > The reason being that it would avoid this comment.
> >
> > Drop the return ret out of the block above and return ret unconditionally.
> >
> > I don't mind too much as I know this is moving later, but I only know that
> > because of the earlier discussion ;)  Few reviewers read the whole patch
> > set before responding to the early patches - it's just too much like hard
> > work.  So if you can do things in an order that minimizes standard responses
> > then that's great.
> >
> > Patch is fine though - could be solved by a comment in the intro that
> > says the code in question will move in patch X.  
> 
> 
> Ok! As a newcomer I'm not sure about the right way to add this comment. 
> Should I add it to the patch message or after the --- ? Also, how do I 
> reference patch X? Just giving the number of the patch in this series?
For this sort of comment I would put it in the main description. It wants
to go in the git log for anyone who is looking at this patch in isolation
sometime in the future.

The stuff below the --- is usually version change things and other stuff
we don't want in the log.

> 
> An alternative to adding the comment would be to drop the return ret, 
> and reinsert it in the next patch. Dosen't seem so good, to me, but 
> would avoid the problem you presented. What would be better?

Comment would be nicer for this one I think rather than the noise in the
actual code. Both would be acceptable though so which ever you
prefer.

Jonathan

> 
> 
> Matheus.
> 
> 
> >
> > Jonathan  
> >>   
> >>   	return 0;
> >>   }  

