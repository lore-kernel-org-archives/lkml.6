Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123BCC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE32720834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2JaxOH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE32720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJZPPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:15:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:15:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so311126wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MqqE0Xu44TkqUL0xiIYfULybT4mQAynRwnheqAI4sAA=;
        b=j2JaxOH4nEkPdjznlEUUptZHLVN8VwmTe5EuSojqANUq3dW5dWeFt8rhj6xS8upQ3I
         9TT9+6WKNrpp44MQJYBcnnS57MBG7l0fCbG+goHAszfK67si7yRPXJy1Ro8d1Snqv+8q
         Zdc1N3yOjS/XgnrysNV4IYbS+6D7XbspVQGss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MqqE0Xu44TkqUL0xiIYfULybT4mQAynRwnheqAI4sAA=;
        b=p4+TgbV4H4cbxqXoP+yqfV7wLVuqSyw3s8PbzZI5ItXXhDlxLzPB28ghR4H4jxnYTX
         o5Cn7TEhWitAe0XKr34nh3Q5aAqS1u8NxDPMQWoAK6mtw1cW8+6AXm6pu334pT0wfdgS
         Jr9HFnAQEg1VxJza/DSSR1bAIYkl3V2EHHLtzi8McJPL5luGb27SIK3JcKzfvwx6h6w7
         t2msOPsMG29aFePVN3Z+ScE/b5see0sd+HnLaST+Ju7Pw1rF14izHTd/f23IZlpIsnBU
         Xw/x6dxapZ7oWMgX+BTA1yBzvpWDUPzZhAZ8+yJh1fCBwZoIIZdpSs2evbBeA9RdUreA
         2grg==
X-Gm-Message-State: AGRZ1gKAk2aLLNo4kxeTvSYOMMyB0CZl+pMLxCWfB5dhH+8g9oC7KDFH
        f3+1Dq6LQ6lWzsYU80uAY99Wvw==
X-Google-Smtp-Source: AJdET5esqbrcD17icGGVGHQKEdYLKuj3dxCetrZ3PlWH7htFZvAA7/cNgVY44v3jZMhNVonvV5SOnw==
X-Received: by 2002:a1c:5505:: with SMTP id j5-v6mr4179367wmb.146.1540535964826;
        Thu, 25 Oct 2018 23:39:24 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id s11-v6sm287188wrq.41.2018.10.25.23.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:39:23 -0700 (PDT)
Date:   Fri, 26 Oct 2018 07:39:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
Message-ID: <20181026063921.GF4870@dell>
References: <20181025154656.10153-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025154656.10153-1-TheSven73@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, thesven73@gmail.com wrote:

> >> This is why the bridge driver has a dependency on a pwm.
> >> If the pwm could be enabled individually, I could drop this dependency.
> >> Can you think of a way?
> >
> > How about using the pwm-clock device tree binding to turn the PWM into
> > a clock?
> > Documentation/devicetree/bindings/clock/pwm-clock.txt
> 
> Looks like a winner. Thanks !!

Could you fix your mailed to reply to mails 'threaded' please?

Your mails are now spread far and wide across my Inbox.

Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
