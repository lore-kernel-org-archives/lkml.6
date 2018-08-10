Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41196C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A322430
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6/c85lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34A322430
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeHJTSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:18:24 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36279 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJTSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:18:24 -0400
Received: by mail-ua1-f67.google.com with SMTP id c12-v6so2536845uan.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3zkZwbqDexLIcadcgOE3tvONKZ/2r608Wx5Ms7Huxgs=;
        b=k6/c85lUiclloZ2z+xENTtemZ2ixb4iKwEBQzHYYt8wHSYzq89ZhKCHDWFsprNKLMe
         uWMbESg4hMLq6uN/WFSda11FWEss/1UbMT+MLb0Wv/A0GyYFPlli+F333VJ6/3CfrPBo
         7jxX2qFS4hjZnRd7aIJ2U985dRQPecJrGuuD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3zkZwbqDexLIcadcgOE3tvONKZ/2r608Wx5Ms7Huxgs=;
        b=tu8HZYmplWTe6jXBv3jztIU3R98OeQk2JJLpDAuQF88VCNGJL90Ue73uI8zL+UpiR+
         DVu+6dO4wcfvlnCat89kK0XCqVI/n7eiERk7jtvDxJlENjwyRZtjhdxBAPjIhplgYO4S
         3WtnQCGSxK1VmosiaQLfn8bBIZs3iJC6UW7N9PGqLg+pkuY8h8w9Qlf49vPdXYCjSJW0
         FGKi9P7EzDk6rA8bE0yclKG5QKQdS21XG3fUXHrzvsAs5T0lPlx3pfL/8NALIYnI/jKJ
         8xz8wX5g4avLLP53lmY23e1Mr/k+7KOncXercAxaSRGBgTgztgUTF2vmD2K8HWsQYdqe
         6I8g==
X-Gm-Message-State: AOUpUlEDSawqMY/oNN6UR4Qeg+DxWVxcHiKBYNddzUwf0oLnYunPQ0Zb
        6FC9EVCYpq5pBHTyRJEF2e+38Dhr21o=
X-Google-Smtp-Source: AA+uWPyshNaU4eD2wUs4aPpgbrjaNykCLS5AYh6NNtddCT5RaeEcIqUm4XXS1+HBs9gXjYcfxP+tMg==
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr4887389uae.72.1533919666420;
        Fri, 10 Aug 2018 09:47:46 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a19-v6sm1509436uan.1.2018.08.10.09.47.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:47:45 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id i4-v6so2532561uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:47:45 -0700 (PDT)
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr4612699vke.70.1533919665011;
 Fri, 10 Aug 2018 09:47:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:47:44 -0700 (PDT)
In-Reply-To: <20180810164345.GH20971@sirena.org.uk>
References: <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk> <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
 <20180810164345.GH20971@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 09:47:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=t4txkWKkO2qiCf0m6iSLWhckr++G+eYJL6REMFdTyQ@mail.gmail.com>
Message-ID: <CAD=FV=X=t4txkWKkO2qiCf0m6iSLWhckr++G+eYJL6REMFdTyQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
To:     Mark Brown <broonie@kernel.org>
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:43 AM, Mark Brown <broonie@kernel.org> wrote:
>> IMO the line marked "/* UNNEEDED */" below should be removed:
>
>>     ...
>>     spi-max-frequency = <50000000>;  /* UNNEEDED */
>
> This is a line in the device tree (which I agree shouldn't be there),
> not code in the SPI driver?

My whole point was that the line above shouldn't be there.  If you
agree to that then we're done.  Everything else was my suggestions of
ways the driver would deal with that line not being there.

-Doug
