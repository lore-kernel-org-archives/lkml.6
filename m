Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52404ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE2420844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YibVELlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE2420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeGPMr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:47:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37723 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbeGPMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:47:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so31679548wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T/12huL75C8/ffmcGlYd7MBgq8LuvYKvjxW8yRl8lDU=;
        b=YibVELlP+gZJtA8oLj15xrdlylrmNYiuV/Qc+Rx0RpR49HbXTJJ444hqdnnYRKLdT7
         AggL40VBAGJSlYW47BkFko1nNCpBPMBbGbQOZz8T1eiPcDse21knGSeAtOOqQZ29c1O7
         QsJ4SKLQ3oTXRcDE3tV/FHi1AHSFIkw0yz66E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/12huL75C8/ffmcGlYd7MBgq8LuvYKvjxW8yRl8lDU=;
        b=XvPcFBdH/P0aDAXDyPBYkof2/IeItCGz67q7lFovFS2r7pnizyXdMY9Y5+7J/xOScz
         IbBA7C4PnFebP6gpNLVabFmZ6px1Ym1IhJ1a66slY1E0U9VLAiaKCtzz2QWcGifDkxfr
         4nmZUthyTrAXfNJYwxNMRLhji1WP0o/9h2LlsBJslxHupXuqSaRtD7tM0BhLmJ54vkII
         dfEOJIVsQHAaO+XgszCg940sZDbStEUtSssenL/reDZtk+ISyDVpNugcrnjEMFVG+thZ
         l6b9/aVRsS8m0FvI7UHNfb9EiCQt/eC6Y3QzxQiZloPqSXdBvDMVS7qVqsDMvV5DSK5R
         7rXA==
X-Gm-Message-State: AOUpUlHJDMrljTigtF5pS11VS3hHq/egAgFhUlVWn5sNi3ZlfWVsxdcd
        rfc3BD8LQMy0A/1fJzK8/oVX7A==
X-Google-Smtp-Source: AAOMgpcz7SVDG+OaGl4ydBnh+wLUBDULxaGbG9QNxo3sgAA/cCT3MwLCnubTouXn14lEyJIittA1vg==
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr8083830wro.59.1531743615494;
        Mon, 16 Jul 2018 05:20:15 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 79-v6sm10833372wmf.5.2018.07.16.05.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:20:14 -0700 (PDT)
Subject: Re: [PATCH v4 01/18] nvmem: add support for cell lookups
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c460e73f-bfc4-abc6-e61c-26290632a3ab@linaro.org>
Date:   Mon, 16 Jul 2018 13:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180629094039.7543-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/18 10:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> 
> We can currently only register nvmem cells from device tree or by
> manually calling nvmem_add_cells(). The latter options however forces
> users to make sure that the nvmem provider with which the cells are
> associated is registered before the call.
> 
> This patch proposes a new solution inspired by other frameworks that
> offer resource lookups (GPIO, PWM etc.). It adds functions that allow
> machine code to register nvmem lookup which are later lazily used to
> add corresponding nvmem cells and remove them if no longer needed.
> 
> Signed-off-by: Bartosz Golaszewski<bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
