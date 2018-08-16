Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A018C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F2B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N0yuI299"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F2B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeHPXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:08:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42608 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeHPXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:08:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id w7-v6so4417312uan.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9UeDdLsVym8qM3xwEKkEFfsoKbWWPNPpjRSpt3oFrRw=;
        b=N0yuI299h9TDUAwf/STuv7GnT03A8+8zfzK3TmpQymjW4vLo+pjQ7xY3beHq0zjYTj
         95PreNUiAxGeApdR7Wmbr7cos9GIuW16Pzmp6OgpJFRACQhwjJSxifFdXLbKKVzLvwx2
         lLWArtvUITMdctxsMFXXey+DeLa2gnjBMQ9SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9UeDdLsVym8qM3xwEKkEFfsoKbWWPNPpjRSpt3oFrRw=;
        b=TVwpLHA6pjruZOAmmt0wvb2byQW6GEEJaybLxVJ/dTKjDVPC9b5nZ4O22KdBJtLu36
         NHJB/nJDOrKjoWUPeXmKPdRomQlFqNC++0jLGDs08v+AWi1WBF/p/29sG2EhYw7M5wji
         BMfzMH9qIJXqYMQkwEdiHfh/dKUh3LFcs6tzcTSovyx+UQnqWQ/XT5+lxhh0btlRiJVn
         IbwaL3r8vkWbWVqds6HC8jfl22rUn8VOe4VY+JrzkgLtViqUCC5S9l7CN21eGoTlgICv
         EbTukYkzwb5mEricsgJ+62rX2tLpbKayeO2u12C+LdEtuDCg+RS9gCOmOoYq5jaBACkp
         zExQ==
X-Gm-Message-State: AOUpUlHzOL/U5qrzMh55E5q+9ojywtlRJSiqtjqEdbvmvXmZSmMiRLX0
        WRXot7MRxX1gOW0avlQNlJjhvRD20mg=
X-Google-Smtp-Source: AA+uWPywq8SBm7u3mHTTSwwZSKgdduLqqaGAlwf6MThMEMaXXlqKXTJnEE2MKNKK7dHaNro7bGEFjg==
X-Received: by 2002:ab0:1724:: with SMTP id j36-v6mr21173686uaf.0.1534450070829;
        Thu, 16 Aug 2018 13:07:50 -0700 (PDT)
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com. [209.85.213.52])
        by smtp.gmail.com with ESMTPSA id m143-v6sm62957vke.23.2018.08.16.13.07.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:07:49 -0700 (PDT)
Received: by mail-vk0-f52.google.com with SMTP id s17-v6so2068877vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:07:49 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr20769720vkh.114.1534450068985;
 Thu, 16 Aug 2018 13:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 13:07:47 -0700 (PDT)
In-Reply-To: <20180815111318.GY2414@sirena.org.uk>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org> <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
 <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org> <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
 <20180815111318.GY2414@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Aug 2018 13:07:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VT6b1SmboyuBSGCnm17HTxxvAL8Hec23Dmc6Yfk5jYOg@mail.gmail.com>
Message-ID: <CAD=FV=VT6b1SmboyuBSGCnm17HTxxvAL8Hec23Dmc6Yfk5jYOg@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 15, 2018 at 4:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 14, 2018 at 04:56:42PM -0700, Doug Anderson wrote:
>
>> IMO about the best we could hope to do would be to map "mode" from
>> children to parent.  AKA: perhaps you could assume that if a child is
>> in a higher power mode that perhaps a parent should be too?
>
> That's not going to work well - different regulators have wildly
> different abilities to deliver current which is the whole reason why
> modes are so fuzzy and hard to use in the first place.  A high power
> load for a low noise regulator designed to feed analogue circuits might
> not even make it out of the lowest power LDO mode of a DCDC designed to
> supply the main application processors in the system or (more
> relevantly) provide the main step down for a bunch of LDOs.

OK, fair enough.  I'll drop this patch and rebase the later patches in
the series without it since I think they're still useful.

I'll work on either adding more regulator_set_load() calls to clients
or perhaps disabling the "regulator-allow-set-load" for a bunch of
rails.  David: presumably if we have a rail that we never need to be
on-and-in-low-power-mode can just be left in high power mode all the
time?  There should be no advantage of being in low power mode for a
regulator that is off, right?


-Doug
