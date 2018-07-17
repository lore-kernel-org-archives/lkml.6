Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84A520C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJ7CvU2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84A520C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeGQJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:20:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35412 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeGQJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:20:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so655066wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YsUBJbK6QfW3n/j1Hb4Fk31inSrLXIeIFA4IppZCSFc=;
        b=XJ7CvU2wqUhxagL51ier5M3VPk7nBdy5k6k1hGv57Tl6pVyabWgH1/7zHAqjqj49ti
         qEsXltsL2rkn/um6Sz3f8JhzH4tFs9L7ObKqXdAks30whcmfCNl/hNIgiup69+q/XTig
         m68Auuvs22IalKto1n38WlR/MouQTLxkU8Jmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YsUBJbK6QfW3n/j1Hb4Fk31inSrLXIeIFA4IppZCSFc=;
        b=Vm/VXeDUOvy6XwhyCNzfEOJWo5LLRYtJK5BH4oqiE0tIEmK8z8vGRld3ZKg2rJBFpn
         QHgasjCD6YwWGygQYCcFMVFkzDpAGr0YU2DyMMkZkmZjusn4Ipi9KbSbtKp7V2ZoAm+z
         c8gDr2RtBi7zHZ3smGNfz8JwAj6aMUe6IJMYA2PEA0OKIpigxf39NYa80QD69pVapL0S
         /LN26NmOtYZvXcVCtat2IGF9cZ9nzETdqA0xFG2j66FOWiXYQvjLkBYI+Z6pSeu3NLad
         zDp7TfFXUAxUAuNF2i9bHBrJryGTdZwFScfiXS9zDc7S42EzKVL/0HlTmc025Qzrd8ma
         Fx0g==
X-Gm-Message-State: AOUpUlFoBR39s+ZuzCzOgZ2gAKA5JI3/cyBOg2Ak2vwq4UC4wua2/WEK
        GuInyFj1k6evqzjokELPL3SnEQF0aDM=
X-Google-Smtp-Source: AAOMgpfoG3blF0YZbRRikRBXAE2zF2f+QeMGcnxcA6HoxMRUEiQa1uCKkSTszw1TGyf6GvaBhEEN8w==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr752789wmg.102.1531817315171;
        Tue, 17 Jul 2018 01:48:35 -0700 (PDT)
Received: from [192.168.8.101] ([37.168.37.237])
        by smtp.googlemail.com with ESMTPSA id r1-v6sm362780wrs.39.2018.07.17.01.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 01:48:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] time: Introduce one suspend clocksource to compensate
 the suspend time
To:     Baolin Wang <baolin.wang@linaro.org>, tglx@linutronix.de,
        john.stultz@linaro.org, sboyd@kernel.org, arnd@arndb.de,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9efe5275-e429-76c7-7746-7750c8fd4203@linaro.org>
Date:   Tue, 17 Jul 2018 10:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 09:55, Baolin Wang wrote:
> On some hardware with multiple clocksources, we have coarse grained
> clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
> which are less than ideal for timekeeping whereas other clocksources
> can be better candidates but halt on suspend.
> 
> Currently, the timekeeping core only supports timing suspend using
> CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
> current clocksource for timekeeping.
> 
> As a result, some architectures try to implement read_persistent_clock64()
> using those non-stop clocksources, but isn't really ideal, which will
> introduce more duplicate code. To fix this, provide logic to allow a
> registered SUSPEND_NONSTOP clocksource, which isn't the current
> clocksource, to be used to calculate the suspend time.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

