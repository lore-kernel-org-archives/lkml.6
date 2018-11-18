Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3542E20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCCdR06v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3542E20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeKRLrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:47:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:47:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so10927032wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NHugqHJwL8XvT6GjZJ61qx/oiY/xW4ADJy5QzFAF/rI=;
        b=RCCdR06vUZxVldN7VROrSFDliCfLTrpioqXRmGpstZnqsA0dRRcJgiIjyKNOe5ZkGt
         0+txUqHRbHqBEcl6CUD2/SoOMqSdm6Y8XS6vY2ENdvC/qF5W1CH4sz0PDfQNQkU0iXqF
         o4U4DurRGtn4g8OLPL4KsEcu8cj+ChOx31tHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NHugqHJwL8XvT6GjZJ61qx/oiY/xW4ADJy5QzFAF/rI=;
        b=Q2x7XZe5Xpz+F0vPZcEtfhVPR4L///9Eykkfsg69rHEhpL6lvD8UzgcWpIWOKem+pM
         cFzmEPXjRYdSZ8BnMkBuGvs4qtb1wA4WDVToAyX0oJudQLc040MoI1WQ2lOvUETCdctR
         YtpqDkjUUptpWknidplj+NufHutUqiSX98F5lC2O/MHsQD80sXaustF/PxU/Wupr1WBz
         O6y+mRGlz0AeLU8JhdteLw+6i8J/J6rcS0SJc1LrlfONVQvXSYElJxz7OwmKpUedIzfr
         vihGcIff92QVmgxDnW1xQRQdi57r0udjSJn94Q9zIBR30SwhYBQ3tFUJ9EmrQ7YAvtdn
         XkrA==
X-Gm-Message-State: AGRZ1gLCIhxTqyjITybBXHYGioSYRO9q3K3NYn2WsgbwxnCmbOsFMCKT
        AGoO0b8z7JJGuoRxoMTKqwRZuA==
X-Google-Smtp-Source: AJdET5cJoPX6jtSiINRoJe6v0fIxCP4hGESs1GZ6pieZ4wxwUwyIUo0GZrvIRLhpJewsC/1o+PDrGQ==
X-Received: by 2002:adf:a409:: with SMTP id d9-v6mr14185050wra.190.1542504510470;
        Sat, 17 Nov 2018 17:28:30 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j199sm16750656wmf.13.2018.11.17.17.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:28:29 -0800 (PST)
Subject: Re: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Baolin Wang <baolin.wang@linaro.org>
References: <20181115133203.28567-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ef535f28-04e3-d638-22da-7e0b64f367da@linaro.org>
Date:   Sun, 18 Nov 2018 02:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115133203.28567-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 14:32, Linus Walleij wrote:
> Demote the DBx500 PRCMU clocksource to quality 100 and
> mark it as NONSTOP so it will still be used for
> timekeeping across suspend/resume.
> 
> The Nomadik MTU timer which has higher precision will
> be used when the system is up and running, thanks to
> the recent changes properly utilizing the suspend
> clocksources.
> 
> This was discussed back in 2011 when the driver was
> written, but the infrastructure was not available
> upstream to use this timer properly. Now the
> infrastructure is there, so let's finalize the work.
> 
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Both applied, thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

