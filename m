Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B12089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="avJC0Ffe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9B12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJIQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:13:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJIQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:13:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so891312wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vIhVQby9N9ujUlx6Av5LbEkVQJqL2ffSXlCNvJ3LV5A=;
        b=avJC0Ffel9vho9bbPjHwNg1Lff0Ts8mwrqG+sFNDFuvDa0VQd+tQ7zkrd/KcwCtF/s
         BqJy2bKfKvW5gCdKAmqjl6rpkkHw7UZ7hejpWxPDfg6sE4LVbr9nCCTWUZDZ3LD5vjwp
         q6gvyKiGxbVt7pg/8Gm781JOsqmbDDWxJXWnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vIhVQby9N9ujUlx6Av5LbEkVQJqL2ffSXlCNvJ3LV5A=;
        b=lYlnXAGZFAR/ckBAka4b7E4m19X6KvDYOObQvr/BE/w+f/3lCdAE3zVfYMZHmXJOr3
         8SsfyZ/O4hvsLw3zySkbu5oCq7SnaMwKdEC6abKND+tzFLdUHnSoX+CMaVBcTsqv8I0z
         dieYS/wwk/4LsPOoMMajm9b8EwGWwCKoHwoXajwOStDfC7CQBZF/mzmpI3ooQB4xBAsE
         3PjWgZICHpbK9IZ16PDn3QVBnCYahCJ3ggTCUjmjHfwYAhNLlgEK6O6DOBI9c0ubHtE/
         edyMjD2s2jYW19M8lhbxQTR0pg5Y5NR6O4/V6lEbsv1INdD5WtZYh/ni60JShEuKB0Sw
         olHw==
X-Gm-Message-State: ABuFfojalpFxq4JKTzeLgPWcXlsJ0VLUCLj9G53J4acY0Ogk6PcTByZZ
        Laiiw97l5lGOEBNeu6PYwQhTGw==
X-Google-Smtp-Source: ACcGV62r40f/LZVU7lm3hkCMzJxIRCvyli/i6BKhWxW7Lrzgh2S14sDSmClV2Bnk1zwp7Cm2uzsypQ==
X-Received: by 2002:adf:8065:: with SMTP id 92-v6mr18867865wrk.23.1539075443705;
        Tue, 09 Oct 2018 01:57:23 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id y19-v6sm11216307wra.60.2018.10.09.01.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 01:57:22 -0700 (PDT)
Date:   Tue, 9 Oct 2018 01:57:21 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        dmurphy@ti.com
Subject: Re: [PATCH 3/3] mfd: ti-lmu: use of_device_get_match_data() helper
Message-ID: <20181009085721.GC4939@dell>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
 <20180911210650.GC32497@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911210650.GC32497@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> Replace of_match_device() with of_device_get_match_data(), which
> slightly decreases lines of code and allows to move the DT table
> next to the I2C table.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Not sure how you're sending these patches, but for future reference
`git send-email` is usually preferred.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
