Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E07C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CD020693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEa3el0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CD020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGSIzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:55:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44217 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbeGSIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:55:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so7089214wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71yMCPMLcjR/ZmID9/ossZV/m+VtBWlUwmxF8c0vSRo=;
        b=MEa3el0uQBZMYpU+kCRVTBFVIC2OdMxtW54P/E+iRawwz5LMd0qEMUsB4BkqI2MoO5
         B6P3y1MnEHioHQQ46Gf2kkB5ZRC417L8hXMqavDomqvb9109dBDZm4UgQs+FRo+LLoe9
         N/9S7QnnbqiwZbTOW2nxvHB9YtgW1Ci6VTVKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71yMCPMLcjR/ZmID9/ossZV/m+VtBWlUwmxF8c0vSRo=;
        b=ZoHgSCSHvkE3Hsjo04znmCOBpz3YLmRHOcWoTtKFTfwh6xR9gqbDM7RhGtZGURVFXS
         qCrkBEtVERSZvFC4j1Z0+hByR39EJh4+Yb6hBRKirkSvNgQsabAv74Qk0B/3VeoEdtRJ
         CJgv+v6aOxYN8nwvex1lXHCuKoXXuBKXKy2yWXyz4JKwKWY2wLBD8optkYVwsN3UTxSQ
         0LGhV95pDqpPFLFOTP8PFl3Eb2XfoKa8WJ/63gEMdle4O5vmqQSOSBlHBpEEqyniXqeE
         CLit5+6fbtnr1sNe54TH6WhbfJvdk64K1QXWfbxxO5HWEOw/rDj1Z5wmaAki95HjHTaI
         Y5Hw==
X-Gm-Message-State: AOUpUlHbZMIBVDox3VWgh/mtJUJeSij/U9I4Dw/BLrQkDPOriE2UFGMy
        ZTKz/0kvdxNUBp84Enk2JVc6eg==
X-Google-Smtp-Source: AAOMgpe8IiHTBbZl/E0H19Qmo1uUZtL6k59JvQMesa65mWWeO8NU8plZuhU6/0fH2gmW+fnWxctp0Q==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr6304488wrn.163.1531988035962;
        Thu, 19 Jul 2018 01:13:55 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id v4-v6sm11142399wra.22.2018.07.19.01.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:13:55 -0700 (PDT)
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
Message-ID: <ef17488c-8524-850d-48e0-37f78a2408a2@linaro.org>
Date:   Mon, 16 Jul 2018 13:19:25 +0100
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
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
