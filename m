Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6220866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKrW6XX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E6220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIJQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:27:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36023 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeIJQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:27:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so12482466wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8U+kXHnGUL+G0CkIOoINnGAKG5T1bpWA4iy5J1e2+bA=;
        b=kKrW6XX+1szFZqcqKM8wDmq0Aul2SwmmOoMZdZXScgjlGgCtJ2//OoBx1mgxkr07A6
         31bDHjZeuMYp5DHmdMmR8zjwqIyVMoki0/WC8de/JsNs0gU6YQss92u1FMtqP+SHhrag
         dUvUJJw5PZHGn8joGfw2TpZ90dwH89PbLtEI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8U+kXHnGUL+G0CkIOoINnGAKG5T1bpWA4iy5J1e2+bA=;
        b=Z3OJOd3xfqN7tD+3ntgCVL7Qm7ABkkdjpOBLcKflZu8e+1ygIZerxpHS29O7YQtbnA
         cCl08vnURPoRmci5OSLafHWkxQvwL5kKmfYaNhgnRj38ktBhmaZTg0E49fQDUrwXX3hY
         o2CuD9laHpKqSCBKb7RY+1R/EBsDNgySdB4IU6mwpG5sfyIKlkbrKemaNfDJ5bJfMoTG
         mTp8E30mg0lcyfdTIzZoboY6lMImLgnn49g+3VNLCUoC/BDxkbGdskEKqg05IERcOrMb
         +uHet1bbJ2D75IMgzbGDfn7JjFyIal8BpAVamq4H58ACrOBbg4rCWTQWmqV50upSuN8w
         WqbA==
X-Gm-Message-State: APzg51A1UAgPU6xm7Wu91Dy+n9FpEIOqMPxX9tK31yUy0viJKwCuIvs2
        +LWs/X5vKPpyxYeb1M/nDgZ8Fw==
X-Google-Smtp-Source: ANB0VdZRL7FOtt6uvFi3+Q8WH5/J6tj3IHx2fmOMyCwDCA30CUoGTR5afQz4gB+c4i20D1a7HP0ENg==
X-Received: by 2002:a5d:64cd:: with SMTP id y13-v6mr13446534wrv.99.1536579216321;
        Mon, 10 Sep 2018 04:33:36 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id k5-v6sm29574264wrm.96.2018.09.10.04.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 04:33:35 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:33:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        patches@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v10 2/2] irqchip: Add driver for Cirrus Logic Madera
 codecs
Message-ID: <20180910113333.GL28860@dell>
References: <20180828130934.18135-1-rf@opensource.cirrus.com>
 <20180828130934.18135-2-rf@opensource.cirrus.com>
 <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de>
 <4aa5941b-547d-7218-1b8f-4cd2a01a4fa5@opensource.cirrus.com>
 <alpine.DEB.2.21.1808301349380.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1808301349380.1210@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Thomas Gleixner wrote:

> On Thu, 30 Aug 2018, Richard Fitzgerald wrote:
> > On 30/08/18 11:31, Thomas Gleixner wrote:
> > > On Tue, 28 Aug 2018, Richard Fitzgerald wrote:
> > > > @@ -0,0 +1,244 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Interrupt support for Cirrus Logic Madera codecs
> > > > + *
> > > > + * Copyright (C) 2015-2018 Cirrus Logic
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License as published by
> > > > the
> > > > + * Free Software Foundation; version 2.
> > > 
> > > You have the SPDX identifier above, which makes this boilerplate
> > > superfluous.
> > > 
> > 
> > Our legal people want it left here.
> > They are ok with the SPDX reference, but they want to keep an
> > explicit statement of the license that was intended.
> 
> The SPDX identifier is an explicit statement. Sigh...

Richard, could you please try to re-engage with your legal team and
explain that the SPDX identifier replaces the licence statement.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
