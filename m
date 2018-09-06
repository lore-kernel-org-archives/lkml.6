Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9DAC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7RmcWxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeIGB73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:59:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44535 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeIGB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:59:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so5881290pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=afZ7jJxVwUat57tgXVmvU7YWN7y4OCnLZK9HgP16dSM=;
        b=O7RmcWxcn9eowpeOOnPLm2bjDoE7um+VqIRMkIfUWDQ5mCfBtd71ZE717qqnTAH99u
         pXeYwTy9hOz8TlKWtUXDtJwx0/iai1MuSoLkXZr3Kv4mLZQ9DGhacw0Ghc49LPsry6rJ
         wGOl1D+5bu/5g8N50C616EUintxs2/MZeEFQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=afZ7jJxVwUat57tgXVmvU7YWN7y4OCnLZK9HgP16dSM=;
        b=EkOl+rwAbbuC1WefmrAgPqnmLR5gM1lyzsA13md7EFFL2OJg1OIxR+aSO1cNUfWVNQ
         adt/iRFQWgBY5810av2cKvHaFVBf1XpZCqrgfuk2jcbmqR4jmirRxB8Rda+9gNZtBtrZ
         8hUoFP2FdKpWi4P+pVZAjTsXl8n3740PSXylZGGhOx6ExfHSTZncGgh2hXZ6wyqmGovM
         EOkX0/dTbZI13N6de1arYmuCd1s7Yi05LreG8qkzKGa4UL3c9UOQkW62OtSplE8S1mkl
         vhRM5Moe51mQp0qFUqyem/8nfV7qM6FH3cV6gOO81tbQ+191t7zHBTrCY/960eKsR6H9
         fgsA==
X-Gm-Message-State: APzg51B0JZ1z5FWdfOtBUNsYNwgo+Y7uOggxKKPX7ICnpj2I3qRD2ZL1
        5cq8r8KHNfQpHO6o0OicAc6TFg==
X-Google-Smtp-Source: ANB0VdbDuGM3gS6LNIHpT6nEBIWo0d7BU1tp0Rrts1WH7kq53+za0eeLW6Ar52pcLUNm9YuW9nWPyw==
X-Received: by 2002:a63:cb0f:: with SMTP id p15-v6mr4963356pgg.197.1536268927073;
        Thu, 06 Sep 2018 14:22:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id t21-v6sm10218266pfi.73.2018.09.06.14.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:22:06 -0700 (PDT)
Date:   Thu, 6 Sep 2018 14:22:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
Message-ID: <20180906212206.GE22824@google.com>
References: <20180906210454.247219-1-mka@chromium.org>
 <20180906210454.247219-4-mka@chromium.org>
 <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:10:43PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > Add a channel node for the die temperature to the ADC.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Double-SoB?

I must have run 'amend' with '-s' out of habit, which wasn't the right
thing to do in this case :/

> ...presumably Andy can remove that when he lands and doesn't need a re-post...

Andy, in case you need me to repost let me know.

Thanks

Matthias
