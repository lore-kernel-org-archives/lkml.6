Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B197C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31B42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bglf7+eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31B42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeJXQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:00:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35412 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeJXQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:00:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id w186-v6so4244319wmf.0;
        Wed, 24 Oct 2018 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YF1wO9NyG8uKqLGo3bF9rVq5MMXAjc8vyckrlBNCa8=;
        b=Bglf7+euR6AlIhNKcnSWIeE8CsiPe/zkGZp7zTcqBVeEjmrZidckW+dvBTfj4jy1Vw
         BWLWec8gk4ybtMvDcYoEZn3i2p9hO2gtt2jVOrJoooCmHC//soIGcyNrharP7DYAQx/q
         gbruSTmQYie6he8wXKaaXo5FfdJmksOejFxxVUFP5B5Nzyr9JNt7cBIDhkGvDsZQDDxl
         AyJ8rxwA//SFxLRuK6ykUkhQ7hmpMhpy2LCJ1UC0yZFIEKKt5aBzxKU1oBxp4Nz3UEWD
         dy4FystvkFGSZd1+prWayXuJTGUGWkXK4R3nvaepIB4KZQv4s/jQh1M9w87Y/FTFT1se
         jh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YF1wO9NyG8uKqLGo3bF9rVq5MMXAjc8vyckrlBNCa8=;
        b=L70Xwd8cC8HmTPnw7l2djXj7XTpTJcEZ8pbXJcZk6F1iJQMN9ZHJ/jwW6BlpE2uH1I
         XhTP6uqZjMxiNIx7SzzZf46OB9T1ai1t5V3hii6I/kHM3AsN4ve7Pd2PnBJpUleXNG7B
         0rJ84q5rftcp5ZdflTsJ9u9ovse+SV5Q0+nf+WIwN9Jq45JOGCiylXuhsVpMgmOeeYPN
         cVhs1kSwbtoX2JT5tNf7nPIJc+yw6ZPfjmWmSahG2QyNYAhXnIO4gpK66EGl4e4dCCNA
         iberd+SYdgjTK+aldyIV4n12MV4F5q2x7G6GZyWH11frxLUFBhv46PEvpwo5ERlMl44c
         5fhw==
X-Gm-Message-State: AGRZ1gIFB6Ibt7pwJvq6O2sXqwpiPWUgfbCbL7002vqaDxfv2wM+4jHb
        707Mu56qfK1pEqIiWBUuX9s=
X-Google-Smtp-Source: AJdET5c+AdkUIW0yxI03vPSXhxRs0qFVaMEisyuVkxcgiWXnwJjqpI3BIPQzlVa89y5L4W/B++dXWw==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194-v6mr1354206wmg.98.1540366417092;
        Wed, 24 Oct 2018 00:33:37 -0700 (PDT)
Received: from pi ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id y19-v6sm4906374wra.60.2018.10.24.00.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 00:33:35 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.91)
        (envelope-from <johan@pi>)
        id 1gFDeT-0005QC-I6; Wed, 24 Oct 2018 09:32:25 +0200
Date:   Wed, 24 Oct 2018 09:32:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        joabreu@synopsys.com, Samuel Ortiz <sameo@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/9] of: fix compatible-child-node lookups
Message-ID: <20181024073225.GD20058@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180904130557.GT28861@localhost>
 <20181023091951.GC20058@localhost>
 <CAL_Jsq+eX0Zr46UT6_+OKhfxLhc315Un5MZkHHAWhK0tt4OvzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+eX0Zr46UT6_+OKhfxLhc315Un5MZkHHAWhK0tt4OvzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:32:56PM -0500, Rob Herring wrote:
> On Tue, Oct 23, 2018 at 4:21 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Sep 04, 2018 at 03:05:57PM +0200, Johan Hovold wrote:

> > > I think Rob will be picking up any patches that remain by the end of the
> > > release cycle for 4.20.
> >
> > So far only Ulf has picked up the mmc patch below directly, so if you
> > could take the rest through your tree for -rc1 that would be great.
> 
> Thanks for the reminder, though before the merge window opened would
> have been better. I've applied all but the mtd patch.

Yeah, sorry about that, this slipped my mind. Thanks for picking them
up.

Johan
