Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EADC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B1120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJ2hLQSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B1120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeIKTHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:07:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50315 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeIKTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:07:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1165340wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PDOV5RNjUSk9jfwBKAajmu3EIyurQT4z6wtGZF18l+I=;
        b=eJ2hLQSg6OD60AJYiX7svlh1/h2nq15lDN5pVsC71uUIAKooZ0dtBN7icMot3JyUhw
         0hrG2DMSndRJTLGsb06NIVx/hRyAFemdMTh0RETdeLZsZRHeHxL79uYdCn+kAkPQih5s
         YuL79ZZE7Y1pBYdL2LmIpe9VZFOCeFhJbvcaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PDOV5RNjUSk9jfwBKAajmu3EIyurQT4z6wtGZF18l+I=;
        b=skxE6+WPuAXXt4ZSmzPrEdOJI6pCLw6rejQJSjRNsx+SvGM75CAsu/xPT6erc3Yi1I
         djjsWJ8zAiV/4Yh0MFKZ7wguKcUzxxRSltoVaY4fM+/GdEAO+IGdVPq51Ge6OsaIP5vm
         Nn3G/BcnFFUbf2/7PzWrDEsTGFjIzltCYnYdrsKuD95TqJPeGUaFxjjaxDGTuYG6fKlu
         xT6pwAlkH8B2gVeFycZn3p3lz/5B7r95qD3FPuvnl4ciLR4AaVpOXpZ1QJd/MuzQFAou
         /HW9zEyOITPqCmsO1WRWJErtCuV8NodcyeWJM7NsDKu5hF7nQ8Y8ouFO7rwyNHIEu7ix
         da9Q==
X-Gm-Message-State: APzg51CmeEeK6wAq8xO/bQG0oSyJSG/v7+1oy9RCFHlAaoR4d/PszNbv
        kbPA8RUpY9nCGJOpwgoXJhVVjA==
X-Google-Smtp-Source: ANB0VdYNbKMrJm0y/IYCaJw//u7Q6EBpZZnga+GidOo8uHyDXAtW77OzCWqMXGVqOLCh3C7n/ImIJQ==
X-Received: by 2002:a1c:c642:: with SMTP id w63-v6mr1422586wmf.3.1536674856381;
        Tue, 11 Sep 2018 07:07:36 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id b124-v6sm1302819wmg.47.2018.09.11.07.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 07:07:35 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:07:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
Message-ID: <20180911140733.GU4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911111850.GJ4185@dell>
 <20180911140400.GB18410@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911140400.GB18410@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Greg KH wrote:

> On Tue, Sep 11, 2018 at 12:18:50PM +0100, Lee Jones wrote:
> > [In case you missed it]
> > 
> > This new pull-request contains the following changes since v1:
> > 
> >  - Uplift the submission version from v11 to v12
> >  - Include fix for build breakage due to missing Device Tree include file
> > 
> > Since it is based on the original pull-request, it can be pulled
> > in either directly on top of it or as a pull in its own right.
> > 
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > 
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1
> 
> Ok, let's try this again, I've dropped that other patch and taken this
> branch into my tree.

What happened to not rebasing? :D

> Hopefully this all works well :)

Me too. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
