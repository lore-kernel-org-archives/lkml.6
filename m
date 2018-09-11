Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03535C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF31A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3GqiAvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF31A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeIKOnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:43:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44941 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeIKOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:43:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so25072480wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lhQ5SHAYpnC5hVzv5qAbL+GfLSAlKbO12W1fqc0vyXM=;
        b=B3GqiAvTS+SKoPFgZx0u8UpvWfppfFTfC+rUgcD2QHWmYU48NdHqP/1s/AuPEQMx7m
         ACxH9OtYlvpficlyA/6hz78N+HrvWicnFiBy6FUr0KueXAqQbCDMFkyTS5tAtuNPWJiu
         hESw760casDYDzdg1T0VL6s4j7mh73U3Mp5+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lhQ5SHAYpnC5hVzv5qAbL+GfLSAlKbO12W1fqc0vyXM=;
        b=bLo+JS20FEw+BSz9JzwSPV11hwnagq5g9mkTQOMWvbROs9wavL5AmfU/f8oaJLBP0k
         J69/eCF/MyrpuMlDZD1X0nE+CZuHmlfpQTxH9qY3KaX8vlph/XDaWLxiyD7t1UiR8+ty
         ALy3+Mt0v4LR15GV7KVWMaJPMtRwdmmoZQCy3aB0Zm0GpHDdV+yBcAD9WY3JDHA47iRs
         RFUzjYzM/NLt15IruQ88O2n3ko4ZL/z7o8KxwMTCYp2l1X2bCHLap1AkAOFSE3reuJA5
         9CcnHsVceDsFzULulXUrSM2+r2xoAiCvJtwRJvzwo6cJkB16U16fsWEIhTNhxD/89T+o
         LI0g==
X-Gm-Message-State: APzg51AE886OJzlZuXQ+HN6TCtkL3uKWjEXhV4VkhMMhMyP7Y8l9wPp6
        pvDwrxlgz8zIk9WzxAKeyipi5eFlyXe+TQ==
X-Google-Smtp-Source: ANB0Vdbw5hv5IaeWscbosPxWjEQlApJDvT6PRbK2BSiCJ+d7PlcdOzH5SwsCSAsa48zXgQmnlwqstA==
X-Received: by 2002:a1c:e455:: with SMTP id b82-v6mr775771wmh.93.1536659073318;
        Tue, 11 Sep 2018 02:44:33 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id y203-v6sm812087wmd.1.2018.09.11.02.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 02:44:32 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:44:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911094430.GG4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911090132.GB25161@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Greg KH wrote:

> On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> > On Mon, 10 Sep 2018, Lee Jones wrote:
> > 
> > > Enjoy!
> > > 
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > 
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > > 
> > > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > > 
> > >   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> > 
> > Due to a comedy of errors, I'm voiding this pull-request.
> 
> Um, I can't do that as my tree can not be rebased :(

Oh dear. :(

> I can take follow-on patches, so I will go apply the patch posted so
> that my tree builds again.  I recommend you just apply it as well.

What a pickle.  As per my last email, it looks as though this set was
applied under false pretences.  The MFD patch which was carrying my
Ack was doing so incorrectly.  The author mistakenly applied it to the
wrong patch.  After re-review (actually initial review) I wish to NACK
the implementation.

My suggestion would be to sit tight, rather than do anything rash and
see how this plays out.  After which we can fix your tree.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
