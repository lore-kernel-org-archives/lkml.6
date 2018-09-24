Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7670520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnqAMKCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7670520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeIXJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 05:12:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIXJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 05:12:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so195637wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+SNeM+3rEiB9AOJ7flDOpSJUnC15RRsbdFD5lT7uKC0=;
        b=SnqAMKCCGlWIo/gOYkuoAs6fkjlHU+/PYDwsByRhX8K9QEb0k+OOvp7jo0cYnz0VoJ
         gYfDgSLx7YBuZk5tL1/bvp/R+CYcS+ic+3Urbh28xnTHUWHPmUSnSFi47oIsT+OaVRP3
         Wdr13LB00WqD50k9N2Q7Wke0wOF97W/UopqT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+SNeM+3rEiB9AOJ7flDOpSJUnC15RRsbdFD5lT7uKC0=;
        b=TeeMBNtH+svxv+NnO7ZXoMQkCYXBfodtpX0UWb/pnYOlYaRlW41bW8cG4Oi8xy+c67
         1Fw+pia0y3CU1b8yM7wzU7IluXsFi3cmG5ue0d4oiXMRRX71VkLm+mTF2+xF9N3dIe+e
         ai9p8giy5ET8EyUbz44gqO/WyS9bt8LPENr4FMNwjZ88h9W2OXBfow5kdjQEwvGGIoZU
         j7zGgr46fPN2QMwsBNf8a2rJTRMzSckGse4oqZYzhCej7XbMw2Vs+9TNvgPXWLlBA4Mb
         weuj4tWCics6tT8a6wvW+JIyl75e27y4aX+HWWAWok5cEwkWg5V7YO2ChjwzUQxdKbbj
         K8iQ==
X-Gm-Message-State: ABuFfogq4TvmyUA6VslKeNWhG/7ou7NJ+roGjDcelgoDGZbcXtbCXAcB
        LQHasAG6DOFuv32aEIGJ9p32dA==
X-Google-Smtp-Source: ANB0Vdays2jX5iJ+DbdDiAqzMmKDj57HlI7Zx1ZrlnPZ6HnjXxnmIM3fgkhpedb1bS6kSJDV7g3VIA==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr5661512wmi.35.1537758751389;
        Sun, 23 Sep 2018 20:12:31 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm31067102wmd.46.2018.09.23.20.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 20:12:30 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e0836866-552f-374b-d271-a4ea2d4953ac@linaro.org>
Date:   Mon, 24 Sep 2018 05:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821171635.22740-6-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2018 19:16, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.

Can you provide a much more complete description of the timer in order
to make my life easier for the review of this patch?

Thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

