Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC865C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZxrYqiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F36620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeIKPMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:12:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34266 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:12:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so25339683wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q48GhJwAjnEqreRmRUnADocGQFVKgYGnEGKwaHX1jbA=;
        b=ZZxrYqiKGuy5ny83FuDtT7UiJasE42xrWXti9KjWzkpmnQl+vSChZSOrxr5+jqGuAF
         oBTRj2x0EzbTaz6ThZrKbrNWRIrL9jck/36aykgBFeSfXAjCvlJLb/KUAx8ov8gcfzpg
         Rl47b2aBQyIoE1ZdZMxKuwNATZGP8LsXYOgyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q48GhJwAjnEqreRmRUnADocGQFVKgYGnEGKwaHX1jbA=;
        b=KBYAOnujQE/LDcj5YbJR1dqew0jZuP5D7ZcrtKG2wKmG6nOxs2DrqoMQconoWgKaI9
         Xlf5y3zh5l0lSq5cQkpgAhpDiRVYM58ERF6H6XGjeigkG6Y6Ix/rVsFboCC+9LyaQQoz
         KHo7aUxtIB2pRJfYQURgWtj7qtmWeMLmf41ktX4opg8um4pXeYAkgyKr7kADGh3rC+1n
         TUXrWbTXFboKwzoAnnJGz5dp8iEFUm4zs96aauhqwu12p2YqXUrvNYasIVHqaYqW2rP+
         ohYbMNKZ5yrvtj/eAsEm5qIxejz8gcITk84KXRPTNOF1kZ6APQA2kpawDLrchGhJWZC/
         dGYg==
X-Gm-Message-State: APzg51D68u2VVCs+XSg6Gaa4Tz1d6lKsmb4YIL8ac2uMHY2u9XMYJgdh
        ZeRxxWv5LD43MrgLeOhfJQDdvQ==
X-Google-Smtp-Source: ANB0VdYN1d4tYjHv9rufQCuplHcnRdm7PLWtJhdcjN/JR9VyrBHUBnKxLnFmS6swO/+vCAkWJqpkdg==
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr879956wmn.145.1536660801450;
        Tue, 11 Sep 2018 03:13:21 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id w10-v6sm24769524wrp.31.2018.09.11.03.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 03:13:20 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:13:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911101319.GH4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com>
 <20180911094430.GG4185@dell>
 <743b5545-e942-b6f4-4ce6-8e10950a05fc@microchip.com>
 <20180911100336.GA3822@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911100336.GA3822@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Greg KH wrote:

> On Tue, Sep 11, 2018 at 11:56:49AM +0200, Nicolas Ferre wrote:
> > On 11/09/2018 at 11:44, Lee Jones wrote:
> > > On Tue, 11 Sep 2018, Greg KH wrote:
> > > 
> > > > On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> > > > > On Mon, 10 Sep 2018, Lee Jones wrote:
> > > > > 
> > > > > > Enjoy!
> > > > > > 
> > > > > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > > > > 
> > > > > >    Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > > > > 
> > > > > > are available in the Git repository at:
> > > > > > 
> > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > > > > > 
> > > > > > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > > > > > 
> > > > > >    tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> > > > > 
> > > > > Due to a comedy of errors, I'm voiding this pull-request.
> > > > 
> > > > Um, I can't do that as my tree can not be rebased :(
> > > 
> > > Oh dear. :(
> > > 
> > > > I can take follow-on patches, so I will go apply the patch posted so
> > > > that my tree builds again.  I recommend you just apply it as well.
> > > 
> > > What a pickle.  As per my last email, it looks as though this set was
> > > applied under false pretences.  The MFD patch which was carrying my
> > > Ack was doing so incorrectly.  The author mistakenly applied it to the
> > > wrong patch.  After re-review (actually initial review) I wish to NACK
> > > the implementation.
> > 
> > What? We discussed this to the bone!
> > 
> > Radu followed all the recommendations, collected all the feedback from major
> > subsystems SPI and USART, resent the series again.
> > 
> > It was then forgotten. Wrong series was finally applied (which could trigger
> > 0-day reports, I warn you)... and now we are discussing about the
> > implementation of *v2* (we're at v12)!

This situation is frustrating.  The reason I was not part of the
discussion can be attributed to an erroneous application of my Ack
earlier in the review process.

Anyway ... since Greg has applied the pull-request I do agree that the
path of least friction would be just to apply the set. :(

> > > My suggestion would be to sit tight, rather than do anything rash and
> > > see how this plays out.  After which we can fix your tree.
> > 
> > Come on, Greg's tree is fixed now. We can catch-up with v11..v12 changes
> > with patches and cleanup the mess together.
> > 
> > Just one misalignment with one patch merged for v4.19-rc1, fixed the same
> > day, cannot generate such a reaction after months of development.
> 
> I agree, my tree is now fixed, no harm done.  Just apply the same patch
> to whomever also pulled it into their trees and all is good.

Have you applied Nicolas' patch already?  Without discussion? :((

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
