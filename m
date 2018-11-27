Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE923C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CC6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVV9CzRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CC6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeK0TzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:55:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33563 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeK0TzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:55:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id 79so1060234wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MLyuJe/PEbSC/N9cwFBA22fI1nqLjt94djt7Etpu7A4=;
        b=aVV9CzRMzfB/ENgqnwkOaMZndvG6h9i0i/c9vgnf3nqP+whJuqyARUsjMVtRxE7bsy
         0v5J/K12gY6u+Jxia72C8CTgecKWYJwBxQNjKKngbSMEKfZGF2iTRJBBW8dkvWGnyOrX
         tk0U17ER28JeOeslC+6hxnkvVXyH6bNNEbLCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MLyuJe/PEbSC/N9cwFBA22fI1nqLjt94djt7Etpu7A4=;
        b=l1QIo5s/tyQO1ddSnR0TH7b6kX3ZxZJbQ13Y/Llb9kYS0ENZQprWB3HBZnIiBmqW5A
         eSg37b999h9zoLJi0f2dEsLwrATRlYyKUSQZdWAlNPajDwnJVmlE0nqw7+lcP3P237/p
         X8gKLEpRW4uM/MecBMxSX66VWKK78o+GKhADmJDDIHd64L8AYK9nrAlJT7roYelKQM25
         tlUURUaSGG9QFjDYqvp6bEwG7WlBv/6Y1pLL6ku6zi0jUORDJANo7AhM4WLTzUssxbEV
         h8g6AWRGY2rG39f1/uC6FK63pk1jjpagCbKAgn8phKM5qpL3PVqWcQ/wUONw4ACIM1NK
         T/mQ==
X-Gm-Message-State: AGRZ1gKy4tAV0CWVlFdZTyrIpPXnnB7CruuatQ+2KvoKKaAXr+7iam9+
        e5XkVNjB13clMPnb/F1hmgKV+A==
X-Google-Smtp-Source: AJdET5dwuui2r+9ZMuZxccHLrKKBfB9iL8jo3whGAZeUr6L1XIFDsKenWKDiW9Yh8pqZO8YlfJ81EQ==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr25543405wma.91.1543309078851;
        Tue, 27 Nov 2018 00:57:58 -0800 (PST)
Received: from dell ([2.27.35.241])
        by smtp.gmail.com with ESMTPSA id 68sm4062587wmt.10.2018.11.27.00.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 00:57:58 -0800 (PST)
Date:   Tue, 27 Nov 2018 08:57:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v5 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181127085742.GG4272@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-3-git-send-email-p.paillet@st.com>
 <20181113074037.GC29388@dell>
 <5BFC2B69.1050204@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BFC2B69.1050204@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Pascal PAILLET-LME wrote:
> Hi Lee,
> I have just one question regarding i2c_device_id.

Don't forget to trim your responses.

Lots of unrequired quotes here.

[...]

> >> +static const struct i2c_device_id stpmic1_id[] = {
> >> +	{ "stpmic1"},
> >> +	{}
> >> +};
> > I don't think this is required any more.
> should I replace with the following ?
> 
> static const struct of_device_id stpmic1_of_match[] = {
>      { .compatible = "st,stpmic1", },
>      {},
> };
> MODULE_DEVICE_TABLE(of, stpmic1_of_match);

I think it should have had that already.  So yes, please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
