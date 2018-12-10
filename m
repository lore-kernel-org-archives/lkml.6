Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF39C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B5F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g29925gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B5F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLJGQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:16:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54506 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeLJGQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:16:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2193977wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PbJwxQUzTE/UyEN2i6C98e48JCS+XOpPs+LaaL0XlQY=;
        b=g29925gTNUh8hi1KXX7yPrvThITSjsc+EqvvtA9BfPAKq2ZT5q3edLDUU9z24lnLkw
         39qlsbqUFl/awFkVOOH07plucfcDFQdyWuVwP7B81qMlJr2xX3DRsYpdUo7/Ma63Z/gN
         g/IPRxnhTlXHbPVtGzhcDZeQSydxUJ71HrmkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PbJwxQUzTE/UyEN2i6C98e48JCS+XOpPs+LaaL0XlQY=;
        b=N2sk5cAr/Z48XhpyPezMgADXorxa4t1vPfGTw/CDHneYVhLtS7jGVBoofcgqJvxL68
         H5jqSeVVNkkO+MAXFd1lXooYL1rA7gob01pZ5MJr7kV/Bm7CFxC51XY9dZOMKRHYXxVa
         gfdM7fTsbyQhXdzAfB7Dppb5CHDh7nZ29ARbnewDEGSLH/0NAEhiez6RzDNu1zAoPtii
         0Fu1kbLumi3UUaZbkbXBl7IZeUlHL1jtwlmoeXV13NB8es/ARBYEP+dIq5eRtr/JeJ5m
         flUqaHm9SWHM5EM/rHb2EYZI1CZx3s3XtWmVkbONiFb0TzIcQMD+mmE9dHFIBzhKkcFa
         s4Ig==
X-Gm-Message-State: AA+aEWYMH4oVXhYajaG5mtTWCdf4HVEs4g0CusMYvUpUx8Ux8Pfpbza/
        UOfja96KwTqPbde8G8jtNB2/Psy/Kqs=
X-Google-Smtp-Source: AFSGD/XyItO8k5L9fG7x0e8Z1fPgNJoH6rcs+Unh6SHJmdOrDvn4YtMCtQpYdVW/qVysIdbv3jcd8g==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr9750264wmi.39.1544422597742;
        Sun, 09 Dec 2018 22:16:37 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id q185sm13080565wmg.14.2018.12.09.22.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:16:37 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:16:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org,
        marcel.ziswiler@toradex.com, stefan@agner.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181210061638.GM26661@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181128091532.GU4272@dell>
 <20181209045241.GF211094@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209045241.GF211094@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Dmitry Torokhov wrote:

> On Wed, Nov 28, 2018 at 09:15:32AM +0000, Lee Jones wrote:
> > On Fri, 23 Nov 2018, Philippe Schenker wrote:
> > 
> > > Move defines that are ADC related to the header of the overlying mfd,
> > > so they can be used from multiple sub-devices.
> > > 
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > > ---
> > > 
> > > Changes in v3:
> > >  - None
> > > 
> > > Changes in v2:
> > >  - This is a new added commit. Separate commit for moving the defines out of
> > >    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
> > >  - Pre-fix defines with STMPE_
> > > 
> > >  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
> > >  include/linux/mfd/stmpe.h            | 11 +++++++++
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> The series seem to be heading towards MFD or IIO, so I assume this patch
> will be merged through one of these trees.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'd be happy to take it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
