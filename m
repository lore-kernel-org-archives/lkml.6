Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06889C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB6214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq7Fsd0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FB6214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbeKOCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:33:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36446 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbeKOCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:33:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so420659pgm.3;
        Wed, 14 Nov 2018 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBs/l53GzzzPwage8UDERhIK6GSRtdi9Du+NL799VIw=;
        b=cq7Fsd0UdXcY2nv3dBQDFrv3DdBkonYXP5pTzofdJWm/AD6y0sJLrqo4Kqd8dqMEf6
         HO8dDcqosG2VwiW4LJyz5iS7Xs//8vNlkfyzP33U9ITllMcFw00flSJFKj4PKVExkPjf
         uT53w4+CGSjlebAkVKOSkCIF/ePKygsbcFQscxMWSqZN1tSXNcKyU3hCDZ72qaiY69kB
         minjc29CSgTMj13yHMEJtTi7lHM89k9+EPOaXDJLP/4/oePLRNoNu560yWVd3P9yxHIg
         n+EWKAQmxJnGA7wxJjKxYhtg2Nt9Kjy1wV54p3JyvpihLZBppkw3WUBWGZHTwvsssSQy
         +ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBs/l53GzzzPwage8UDERhIK6GSRtdi9Du+NL799VIw=;
        b=lD+R0qgZGvrCdcaoQyOmeouvBDA9I3lPZpAIbMqY6gR/lIQXhIgASWfp4hn+eTYo7x
         9A034Do/4/P7ts81FEQoIoJXqZhGOu6uqguJ3D7VkCHixfJj03vaaTWxJfzdpQSTifjZ
         8ObM9cik6qUMJ5FpmUht7IKahHRRaTjFwIz6jyjoVqgyoHwr2+mV+3cy1k/WcAaTpV7l
         aZd//h+r187+sYNF3xWE9DU5966PkIaIR2pycFjWcpmGPv/bNJK6B5Tzu6a3v9+DVCNw
         txXFJIpYf1zAclwAfKdyDaJxW4kZEhSHj65e8qY2J4Ascitan6kt1jmTyN2a7CNRNncp
         bZgg==
X-Gm-Message-State: AGRZ1gLwL8FxcScf0pRM2eAuiGNXka6NLcBUN/gr9rV7FSBvevPNSt8L
        IOv8N76YnffdJuZQW4OCORc=
X-Google-Smtp-Source: AJdET5eZfhS7TEdHTxk4RVqHEiAeEilAX15XO2FIDV2FcW8Ned+k2FViZ5f63AvuOUrnLTvKlCGPXA==
X-Received: by 2002:a62:1cc6:: with SMTP id c189-v6mr2652438pfc.49.1542212988583;
        Wed, 14 Nov 2018 08:29:48 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id y10-v6sm7082944pfl.187.2018.11.14.08.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 08:29:48 -0800 (PST)
Date:   Wed, 14 Nov 2018 21:59:40 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <20181114162938.GA16316@nishad>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
 <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
 <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:11:57AM +0000, Ardelean, Alexandru wrote:
> On Fri, 2018-11-09 at 13:08 +0530, Nishad Kamdar wrote:
> > Add device tree table for matching vendor ID.
> 
> One comment inline for this.
> 
> Thanks
> Alex
> 
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index a2fead85cd46..b8a9149fbac1 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -422,6 +422,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad7816_of_match[] = {
> > +	{ .compatible = "adi,ad7816", },
> 
> I think you also need to add:
> +	{ .compatible = "adi,ad7817", },
> +	{ .compatible = "adi,ad7818", },
> 
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > +
> >  static const struct spi_device_id ad7816_id[] = {
> >  	{ "ad7816", ID_AD7816 },
> >  	{ "ad7817", ID_AD7817 },
> > @@ -434,6 +440,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
> >  static struct spi_driver ad7816_driver = {
> >  	.driver = {
> >  		.name = "ad7816",
> > +		.of_match_table = of_match_ptr(ad7816_of_match),
> >  	},
> >  	.probe = ad7816_probe,
> >  	.id_table = ad7816_id,

Ok. I'll do that.

Thanks for the review.

regards,
Nishad
