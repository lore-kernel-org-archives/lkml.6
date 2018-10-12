Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B10C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5620865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXD8V55m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeJLUQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:16:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43797 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:16:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so5886731plb.10;
        Fri, 12 Oct 2018 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9wL70jQ9n9DEljZDo6ba099okOE6toh5sDh6KNJziU=;
        b=sXD8V55moTRwiI1GKTvVqf07c7UcJOhWGU139rQqnRZOjYw1szdBwk2Hyc3+WsMMaP
         AgfURm21gJeJvBE1d3bCBRfQaR4nprSIALoxYKd6bBnKQNoHUsEgducuoHtgpTu0vb6G
         /y51DnBqzxZNLUZUsEjmVdoaJXBoMMnXt301+NUELwduxhk1TRCxsTG12RahhuF4+2bm
         tiqF3m538NU7N1VJNATm2GEOc4eG97otp0lUuPore7hykrhA3WbsWdLnEV4m63xIqanV
         dvsphpizqXzDf9Z7KhVSy/rHfGjHdPLrZ5LJHKvRM4uYX6zHFWymjKCGbdn+fRth3us2
         s90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9wL70jQ9n9DEljZDo6ba099okOE6toh5sDh6KNJziU=;
        b=hOaxJ8vR3yO+S5MThZmYhpzG3YuGUBYS2xEm5MNNG6HIg2dSZSipVWRs4l5wkRHw7M
         B972Y+E3FJ9C8ybwsOoe1KhzTglgA93TkTT2x6vw+U22IP8Dw5w8aIMtLGk27i4pGy+9
         hjkmbVtGufybQjlmDc4TIwkb8rump46qdDNT2gIBEKcmQoaLhnIaKoo8bgqt9EZaUb/V
         5iKT3H706MipUGOmOXuS8ckwB8SihADtAv9LYttexBzImyYP6l3ssUggL3Aqys0yMlAs
         zRP0Of/7AdwdsYHSi8p7DvL4MR6MZr9WSq8w7L+3oF4Qj4ZVV+F9owXhfmVSuBUMqmko
         s/HQ==
X-Gm-Message-State: ABuFfoh7iIg0WozGYsztFUn8wGCSYr88bw28pTjjM94BQdBBHIZ3F7IK
        1scl8SsI8XPLjc+vlBc5Ic8=
X-Google-Smtp-Source: ACcGV61WVGs5GkuOrmcWLWjxSYQ3d+dhI+b8qIcIt4V/UcmE0MCrWmsLt4PKyO1UoobH51a/DWZ0nw==
X-Received: by 2002:a17:902:5c4:: with SMTP id f62-v6mr5903063plf.18.1539348276066;
        Fri, 12 Oct 2018 05:44:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k63-v6sm2228528pga.36.2018.10.12.05.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:44:35 -0700 (PDT)
Date:   Fri, 12 Oct 2018 05:44:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <robh@kernel.org>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, joel@jms.id.au
Subject: Re: [PATCH v5 01/10] dt-bindings: fsi: Add P9 OCC device
 documentation
Message-ID: <20181012124434.GA11386@roeck-us.net>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535664761-86018-2-git-send-email-eajames@linux.vnet.ibm.com>
 <20180910181610.GA5907@bogus>
 <c002018d3765280e135d673f7c731784a90a260d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c002018d3765280e135d673f7c731784a90a260d.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:56:33AM +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2018-09-10 at 13:16 -0500, Rob Herring wrote:
> > On Thu, Aug 30, 2018 at 04:32:32PM -0500, Eddie James wrote:
> > > Document the bindings for the FSI-attached POWER9 On-Chip Controller.
> > > 
> > > Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> > > ---
> > >  Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > > new file mode 100644
> > > index 0000000..46372f6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > > @@ -0,0 +1,15 @@
> > > +Device-tree bindings for FSI-attached POWER9 On-Chip Controller (OCC)
> > > +---------------------------------------------------------------------
> > > +
> > > +This is the binding for the P9 On-Chip Controller accessed over FSI from a
> > > +service processor. See fsi.txt for details on bindings for FSI slave and CFAM
> > > +nodes.
> > > +
> > > +Required properties:
> > > + - compatible = "ibm,p9-occ"
> > > +
> > > +Examples:
> > > +
> > > +    occ {
> > 
> > FSI slave devices are supposed to have an address according to the 
> > binding doc.
> 
> This isn't the FSI device per-se actually. This is a node below the
> "sbefifo" FSI device. The SBE fifo is the mechanism by which we
> communicate with the OCC. The sbefifo doesn't really define a "bus",
> it's mostly used from userspace directly via /dev/sbefifo* to perform
> various tasks in the chip, but it happens to also provide the in-kernel 
> transport for the OCC commands.
> 

What is the conclusion here ? Is it ok as-is, or does it have to be changed ?

Thanks,
Guenter

> Cheers,
> Ben.
> 
> > > +        compatible = "ibm,p9-occ";
> > > +    };
> > > -- 
> > > 1.8.3.1
> > > 
> 
