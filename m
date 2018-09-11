Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BFCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dT8k08kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDE32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIKNtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:49:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeIKNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:49:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so24724429wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3JkOBshBkPnoGU3ZFnX2CBww7ePskOJ06sVlq7xA4Tw=;
        b=dT8k08kxcwNMy0ZRYi6QZ2EX4BreGVEQk8yT5DTSfeAX93gr8kc9mmBawbJvJr8cS0
         Uu+ssPOL4OuY58NY+xvQiE9OCAGBV6R66Q3AYNhL/xctBq0+9lzydF0IgOwZ2orro5U7
         ZnU5CbytsjVtpQHUWGqzXKC5xelgjcMt9VTkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3JkOBshBkPnoGU3ZFnX2CBww7ePskOJ06sVlq7xA4Tw=;
        b=crzeyi2jJyfPCoRZAWj5QBaK8JKpjp06tpzeMnAjSWcySz5WXhjku2mnbHxsaGtj8B
         uMxiSpd3MKOzwvCVMSLc/+OiNSzU8HtEg+IL2sZBNauMQtf6bO5a9+sBdH9eiK9W43LL
         dWVbzGKSU3akxc7bbasLjKfBMm5ePZ4YjljIYUd8oW9KISKfmesk62bMfGHWaU2A9iy0
         fPR45ul7xw2fsEw4bHZz/Fs8JXN4yW0DZWCho5d669agGGHeD4rLdB9vf7iIa5aWYgdd
         9tj19qgUP7JA6jViRutGsTa+/zQfuuE206liHPxcTSQfAspOymVV3luswIJcZrBS16nb
         wFRA==
X-Gm-Message-State: APzg51D6wDnwYejCKBVXhz26NU36VZHICMcjCDF5ZK67aowOj4CntklQ
        Ahi/G+bqBTEasuLrVvpFUrznPg==
X-Google-Smtp-Source: ANB0VdbYvL77SxwsPdijp0dxGfpHmAJ6bFqfRc8AzBTaXTQUvHVh+Oloo2gj54X/0+A363Xp5bcFoQ==
X-Received: by 2002:a1c:a94d:: with SMTP id s74-v6mr596784wme.39.1536655889961;
        Tue, 11 Sep 2018 01:51:29 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id s24-v6sm324458wmc.7.2018.09.11.01.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:51:29 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:51:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Nicolae Pirea <pirea.radu@gmail.com>
Cc:     Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911085127.GD4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Radu Nicolae Pirea wrote:

> Hi Lee,
> 
> Thank you for taking the patch series, but you didn't take the latest
> version(v12) :)

Both were marked for merging in my inbox, and since I am working
though my (300+) post-vacation emails chronologically v11 was handled
first.

It appears as though there is an issue in the way 'struct
of_device_id' was declared too.  The header file in which it was
declared used to be included by proxy, however a separation has
recently been made causing build errors.

I will fix both issues and re-submit the PR.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
