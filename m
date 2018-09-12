Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBC02088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQh0bilK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBC02088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeILSR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:17:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:17:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so1995543wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U/KG1JqYn2ylXof+E4+9R1BS3i1AuvaO2suqKU/UYqI=;
        b=DQh0bilKVmVWj4SFLvQfzBRB1Iu3qzMNs+AXiMFn89z5VRwNpnVwA8wXd9VllxCi6O
         d0Sc6SHfb5Ugt3Ki82lC4pAa5jj+hkUic006naLTDqPRbqft+ycCa2lDQaQ+90QBFG58
         GghhKsA6qgjaZxmSnkfvGmCGXQhXLg4TldC84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U/KG1JqYn2ylXof+E4+9R1BS3i1AuvaO2suqKU/UYqI=;
        b=TvynodLx50EJFCYwdEraPjXBHaDdF0JPGBzrBiArZCMXk1I9GJD6DxNg81Gz+7za4y
         FDFcR7EW/tkZWQeSw+DHHhnSJo0KqvHJH/87jh4FCfH3tMYcDN1JvISHrthf+EP5EZ+g
         FD1WH5x7kEAKB8Dh5wzNrJJmb1isd7KuDRmaw6OZeJ4kOSAS7SSlPxpPayB3SCH5ex/6
         GE/CAPaCPH7hhmBb6D02N3d7iQMdR3C+qLj/j7wvDdn5OtkVjX13XjgcVqf2olLGHM8t
         38VHnAl3Rn8/KNyYDuE2BALV4eGcpt5V4I5pMpuDq3cqPFg/uiSp9Uc/A9jKB62pMRn/
         73Nw==
X-Gm-Message-State: APzg51AZ17zYAhZMvpgVzbRzOITajOixMSmOnNHYhed7/iotNpxmJtJS
        dl544kpc2v2n8a3PL51OrrMrJQ==
X-Google-Smtp-Source: ANB0VdbqAOFPYhrAIq5i9j+DBLpMR/+CF0kL9WLgnUJOH8VDjdYmW/JRmNex6XpGOe7QzRlIHFgSRg==
X-Received: by 2002:adf:a964:: with SMTP id u91-v6mr1607246wrc.140.1536757977793;
        Wed, 12 Sep 2018 06:12:57 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id m68-v6sm2608406wmb.10.2018.09.12.06.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 06:12:56 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:12:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180912131248.GA21544@dell>
References: <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell>
 <20180911225440.GL4185@dell>
 <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
 <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
 <20180912105407.GR4185@dell>
 <20180912111757.GC2760@piout.net>
 <20180912114352.GT4185@dell>
 <20180912121420.GE2760@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912121420.GE2760@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Alexandre Belloni wrote:

> On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > > But ... we can't have it both ways.  *Either* it's a true MFD, in
> > > > which case it can/should have 2 separate compatible strings which can
> > > > be specified directly from the DT.  *Or* it's not an MFD.  In the
> > > > latter case, which I think we're all agreeing on (else we'd have 2
> > > > compatible strings), MFD is not the place to handle this (my original
> > > > point).
> > > > 
> > > 
> > > If that is what bothers you, then let's move it out of mfd.
> > 
> > As I've already mentioned.  I don't just want it moved out of MFD and
> > shoved somewhere else.  My aim is to fix this properly.
> > 
> 
> If it is out of MFD, then I'm not sure why you would care too much about
> it as you won't be maintaining that code. And I still this what was done
> was correct but I'm open to test what you suggest.

I care for the kernel in general, not just the areas I'm responsible
for.  I guess I'm just that kinda guy! ;)

> > > > So ... this is a USART device which can do SPI, right?
> > > > 
> > > > My current thinking is that; as this is a USART device first &
> > > > foremost, the USART should be probed in the first instance regardless,
> > > > then if SPI mode is specified it (the USART driver) registers the SPI
> > > > platform driver (as MFD does currently) and exits gracefully, allowing
> > > > the SPI driver to take over.
> > > > 
> > > > Spanner in the works: is it physically possible to change the mode at
> > > > run-time?  :s
> > > 
> > > Yes it is possible but on Linux that will not happen without probing
> > > the drivers again.
> > 
> > Not sure I understand what you mean.
> 
> I was just commenting on changing the mode at runtime.

Oh I see.  My question was relating to whether the H/W is physically
capable of changing modes on-the-fly, rather than how Linux would
handle that.  If this is something we'd wish to support, then it would
have to be a single driver, which is why I was asking.  By separating
the drivers this way, we are blocking that as a possibility.  Although
I guess the OP has already thought about that and made the decision
not to support it.

> > I'm suggesting that you use the same platform_* interfaces MFD uses to
> > register the SPI driver if SPI mode has been selected.  Only do so
> > from the appropriate driver i.e. USART.
> 
> Yeah, I understood that but I didn't comment because I'm not sure this
> will work yet.

Other drivers already do this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
