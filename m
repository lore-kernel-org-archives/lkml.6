Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE6C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C8D21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h7lfIrNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfBSQfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:35:00 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38326 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfBSQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:34:59 -0500
Received: by mail-pf1-f173.google.com with SMTP id n125so3197614pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lr4+Jg65k0SbTIEJroDTI+l23rg21K+Qvzr7FWTny4E=;
        b=h7lfIrNrLgcsx675ZkjMekc7J+8K/wZYCYkLiXNhrZwvivnbJh2FaxpZGGH9ZJWr58
         J30lTocmp1dO36UHM78lwgqeItjlVE7mLW6VKTbIU08V7BEL0TKN07ybQPq9RA1BTe6+
         R4NZ29zXDUhYJCypp+7vd63hGMJoKRddLeJhn+KpxFLE5RypJX/rnwDf27bxiW9aWKq5
         70xqoG4oIc8Zi54vo7nvQEs85WQiDsjeCUPl9yT0mWxuXCQC5tsGZTlorUQm7BAROMjd
         y6Em+6EKeP2SwWh0TQ+wNZh68vUw8pDYd56t151i2SouvQMzJQic4CoNlOd+ep6KQ1iH
         FXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lr4+Jg65k0SbTIEJroDTI+l23rg21K+Qvzr7FWTny4E=;
        b=L3Nwhta90KC4HlrXCOxRqIBw5daxKm5tIYL3zWDBDN2u3pZoeLmCm8253Y4vpJXeLL
         ys6P+RHUg3D1jJsWaC7qSAVX6miN0Hr5t0l2PpSLiFqXAZa10X/yh2qkc2O7XZBUhtJ5
         pB9PYkdUlg0Wa0+z6b1+cLMnFJVlMnBoQCsM8eCQKAbjKbgURBmE3R9IlUIdefK9AT1A
         sruBdmQgmwNjmKkIc679DImi6ulD49ouCLympxKSY1fgZ6UzY3U4UvfHj0P5wd3a56Fq
         TzraNj0FHPU48P5zmYFcsWDj32nhnVuLhuWMTEO8pUCABOcv7y2iTIJDYX7akbkN1Cwk
         SyKQ==
X-Gm-Message-State: AHQUAuaJgi5TV+1g/42BnrWCXs1TR7LM6eqsVoTZPkd+2NJhzHA6Htnh
        Xe0/kgpomqtquQiPHsygHAYn2A==
X-Google-Smtp-Source: AHgI3IZcoO09lcsr7xIPzd1Q27oTPcWk2aTmbZv+Op8nNRSJN9mvD915oUQhvXjB+RigduB8enJHdA==
X-Received: by 2002:a63:3541:: with SMTP id c62mr24736577pga.191.1550594098651;
        Tue, 19 Feb 2019 08:34:58 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t5sm21365051pgo.70.2019.02.19.08.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:34:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gw8MC-0000q6-La; Tue, 19 Feb 2019 09:34:56 -0700
Date:   Tue, 19 Feb 2019 09:34:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, peterhuewe@gmx.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH -next] tpm: change the return type of
 calc_tpm2_event_size to size_t
Message-ID: <20190219163456.GB752@ziepe.ca>
References: <20190219072618.23048-1-yuehaibing@huawei.com>
 <20190219085921.GA5609@linux.intel.com>
 <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
 <20190219103532.GA16707@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103532.GA16707@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:35:32PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 19, 2019 at 05:15:47PM +0800, YueHaibing wrote:
> > On 2019/2/19 16:59, Jarkko Sakkinen wrote:
> > > On Tue, Feb 19, 2019 at 03:26:18PM +0800, YueHaibing wrote:
> > >> calc_tpm2_event_size return size of the event which type is
> > >> size_t, If it is an invalid event, returns 0. And all the
> > >> caller use a size_t variable to check the return value, so
> > >> no need to convert to the return value type to int.
> > >>
> > >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > 
> > > I don't see this patch make any value.
> > 
> > calc_tpm2_event_size return size_t 'size' which derive from u32 'event_field->event_size',
> > 
> > convert it to int may result in truncation.
> 
> Two remarks:
> 
> - Your real name is formatted incorrectly. It should be like "Yue Haibig"
>   as shown in [1].
> - If there is no actual regression, this change is useless.

Clarity of the code is a laudible goal - not everything is about
fixing bugs or adding features.

It is much easier to write the code properly than to try and prove
that event_size can not exceed INT_MAX.

Jason
