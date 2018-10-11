Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03075C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906B20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQQuY+mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJLEV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:21:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44460 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeJLEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:21:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so4994101pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rVUXqSuC6PJ/5WXJSxUgp3NMKr49r3X1R6tgDbt7DgU=;
        b=BQQuY+mmcRaGbn2gUaBm0yDBOZEeEL9BdQbQ3V3hgAqh2MV/ZJ23o0QcYaTQwmFXx9
         1e8hicuAt14vBuicy4b+NKcqfrEdY3eZ9MZIzOVn3YH48mqZtp49rPbw6Z5HB3P3y+2n
         AIhdxlyUt95m2QSM50De/NULjOpfttor7RQ+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVUXqSuC6PJ/5WXJSxUgp3NMKr49r3X1R6tgDbt7DgU=;
        b=VCk0w7FK3dRQ4RWmDXedzJ22QMzvhs8VjOM4X14L0PEsqWIfO2sjtuqgMbViBe3yYR
         NFoDZ7fIYD5rWAdswSnLcYQXhTlnm14v3V4KNHhN1oPJgEKjoDqzcfu4v/4e2jEOh23+
         9vo2j7x+Zbokr3utVlcUlV8IdJVIAiUDzFe6l2546Ecc/MoeWdl/MjgiWHQ/m0NpRqNO
         bHRRNs5oN5UhF5yDVvmNzZRO/p6rKU7VcfGIQCfZJgWYUNHOEdPbwzet7S3JDcGctucc
         ecAmIjW1l/M3PNFw/WQooVCne3y5ionUOd4r71tOHXSPe9//KDXmLxJV616fhFVYqLVY
         4kkw==
X-Gm-Message-State: ABuFfojuesL/5AENJljBwX3ASooZ1piP8QleqL27nnI0F14thwTBD/9X
        2gAPa0Ibp6hmRWTOzYvNPqOosg==
X-Google-Smtp-Source: ACcGV63pyQ6/0tTYaitQdCAT5mXygUwL+G7cGnLbV4C8ZLlnkMH2zJbFikNw7B6nlmh7hewfWrpBgg==
X-Received: by 2002:a63:e505:: with SMTP id r5-v6mr2763497pgh.170.1539291180136;
        Thu, 11 Oct 2018 13:53:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id n87-v6sm25757026pfb.62.2018.10.11.13.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 13:52:59 -0700 (PDT)
Date:   Thu, 11 Oct 2018 13:52:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181011205258.GN22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
 <20181011191134.GM22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011191134.GM22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:11:34PM -0700, Matthias Kaehlcke wrote:
> Hi Rob,
> 
> On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> > On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > > The node has a reg property, therefore its name should include a unit
> > > address.
> > > 
> > > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > > DT conventions.
> > 
> > This is ADC channels?
> 
> yes
> 
> > If so, then DT convention would really be "adc@...". 
> 
> ok, will update
> 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v4:
> > > - patch added to the series
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > index d0c188e5c922..ff7aa5038ba6 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > @@ -112,7 +112,7 @@ Example:
> > >  		io-channel-ranges;
> > >  
> > >  		/* Channel node */
> > > -		usb_id_nopull {
> > > +		usb-id-nopull@VADC_LR_MUX10_USB_ID {
> > >  			reg = <VADC_LR_MUX10_USB_ID>;
> > 
> > Defines are generally used when there's not well defined numbering such 
> > as clock ids. Interrupts and addresses are generally well defined and 
> > don't need defines.
> 
> ok, I'll update this to use literals

Actually I'm not convinced literals are the right answer here. It
makes perfect sense for a standard ADC, with a 1:1 mapping of channel
number and physical input. However in case of the VADC/ADC5 there
can be multiple channel numbers per input pin, the different values
are used to select a certain 'configuration' (eg. ADC5_BAT_THERM,
ADC5_BAT_THERM_30K_PU, ADC5_BAT_THERM_100K_PU,
ADC5_BAT_THERM_400K_PU). IMO using integer channel numbers here would
be more error prone and obfuscating than using the defines.
