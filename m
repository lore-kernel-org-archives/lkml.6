Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8FDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFa70hX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B02F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeKHHKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:10:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40269 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeKHHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:10:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so5457576pll.7;
        Wed, 07 Nov 2018 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O6p/SxLdWuaDNw5TU6VIArAUGJsUpQ1DcX4dplbFCSU=;
        b=AFa70hX0LydIxjfqZqnj0Ao82mKYnpVlSRzKjkGAE9tWlpmu8BrePkNY1eYwiOy5ju
         lH2RNZbP54AvyevgjDhcSYTizGbyoc13D2E6M/lj5ORMkFoJRGFyhFMvnYkZDapQFk1d
         Ygh4C6INksJHQJrAFyLO9SuNy8D1kXVnRyXL8R3zf+pq4crKXGRuwX1MJkkrKBU+J9Ng
         0HVF+cWc9URmliD4BYxdbRfpUTLTfNsh1YDsp99bqm86NhXgh9L5yXRXdxQWF4FQRX/l
         +bjIj0/Ated80afIcCUwwA5dehRcHtnrt0NaMnrj00iP8Kk7/t8zkV5lQyCGcVRWbe2y
         pG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=O6p/SxLdWuaDNw5TU6VIArAUGJsUpQ1DcX4dplbFCSU=;
        b=e7QjwBsOxaDR+NlZKR0au9LuWPI+voNkQP0Xg7NHOOHfYFUevGShUmPDR3p3BKk9VN
         sn0uadszrBJspWDXDqAb6FwsJxc7B8YycJuVTDKb4sEyWzgigLhnW+iVhHYdyh68fzXn
         QrSVqjo0str68kNGVhpeToYh/bneZKlXvPGvFHoPzYeUWItaL6mdDDdEf1Qvq040JEut
         NBuFPCvARkZTCLhkvzRFHv2MLTcQacHiOngdrkwq3Q3b3HGUg15WoCtzW4hHN7EGkEM2
         7BOOx4I7Dpr5FIrtA8RHUDCaHqb6RHkKiwrebNRm6kNLQknkm/VW4GT9MIJvV9Q7N4Gi
         ciGg==
X-Gm-Message-State: AGRZ1gK16YUVsuwf/CYglY59NJ26ndqVnuvkxQ9w7nh7Say6lJeF7gXr
        brpmQ98n45J+imN3fa3QMpw=
X-Google-Smtp-Source: AJdET5dHPmXujlByEqZTbTk7G7rxzR8P3W25eHW2xC1OaEUBUomLF3D/prqKWvsH4dFmxmuEZTmZ1w==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr1911316plh.145.1541626714360;
        Wed, 07 Nov 2018 13:38:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-v6sm1570329pgn.49.2018.11.07.13.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 13:38:33 -0800 (PST)
Date:   Wed, 7 Nov 2018 13:38:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: tmp108: add optional interrupts and
 #thermal-sensor-cells
Message-ID: <20181107213831.GA14140@roeck-us.net>
References: <20181107154708.422-1-heiko@sntech.de>
 <20181107183958.GB5468@roeck-us.net>
 <5910167.PXNgySJWA7@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5910167.PXNgySJWA7@diego>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:33:12PM +0100, Heiko Stübner wrote:
> Hi Guenter,
> 
> Am Mittwoch, 7. November 2018, 19:39:58 CET schrieb Guenter Roeck:
> > On Wed, Nov 07, 2018 at 04:47:08PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@bq.com>
> > > 
> > > The tmp108 does have an alert output that can be used as interrupt source
> > > and can of course also be used as part of a thermal sensor setup for
> > > things
> > > like thermal-based cpu frequencies, so document the necessary properties.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> > 
> > Do you also plan to actually implement interrupt support in the driver ?
> 
> Not right now but I'm hoping down the road.
> 
> The main argument for including this standard property is that
> the dt-binding is of course a description of the hardware and not the
> state of the linux driver and the tmp108 obviously has that alert output
> pin, hence I'd really like to already have it in the new board-dts I'm
> currently working on so it simply magically works once the driver can
> use it :-) .
> 
NP, just asking. Let's wait for Rob's review, then I'll apply the patch
unless he has issues.

Thanks,
Guenter

> 
> Heiko
> 
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/hwmon/tmp108.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > > b/Documentation/devicetree/bindings/hwmon/tmp108.txt index
> > > 8c4b10df86d9..54d4beed4ee5 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > > +++ b/Documentation/devicetree/bindings/hwmon/tmp108.txt
> > > 
> > > @@ -7,6 +7,10 @@ Requires node properties:
> > >  - compatible : "ti,tmp108"
> > >  - reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
> > > 
> > > +Optional properties:
> > > +- interrupts: Reference to the TMP108 alert interrupt.
> > > +- #thermal-sensor-cells: should be set to 0.
> > > +
> > > 
> > >  Example:
> > >  	tmp108@48 {
> > >  	
> > >  		compatible = "ti,tmp108";
> 
> 
> 
> 
