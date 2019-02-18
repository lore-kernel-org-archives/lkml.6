Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016BC2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCnjD3dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBRG3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:29:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39798 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfBRG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:29:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so8026925pfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 22:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vMCeLKfnmmzvgnErdQUS+x/DKuvLGfZGkILErkwYP14=;
        b=uCnjD3dldNBtn6PtC0cA2goL7cDjsFujcao4cFptgTph1RcbFQzPce8QuwM1O+ImGp
         Ng2+cYNn8NUoUGW4ZanojgJrt7PjTmp5GuFnNlWK5Pu8FYa7j67OS4UAl4SGaXZDq9Mq
         7fCCsJjeVGdu7m3L3rzMrDYc6fFKL04uArCZPNA7HJHln/KdycudaZMMUQ/t4rIpTrsY
         WsqZdDuG5i+Gc/ctC0fs07Yhuq9KPM9bF4FnwwcK2lW6GRUeKVOatyzTAeKkbebRcmcy
         gwpeWRObT2O5I/uGACY3MEbyqfW32uuufUXIXKJOTM8uUKrIffK3eh0rxTbT7yo13IVc
         H5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vMCeLKfnmmzvgnErdQUS+x/DKuvLGfZGkILErkwYP14=;
        b=Kc3fg5A37f6uhAcPJ3bMy0937JLdC2zIsxVEHzz+29AhSmqD11UHi47maDrl6u1++u
         FViXaS4QK5WbYrCwn/8O24LicfR/wMX2ihAeasZEdE6LB35gtuqsWzpnVVtfPAEoj4u8
         VEpOa7hqBwKUp0H7tHdJySZCeKH0QVNrLEmmA5uiXFtJDssRM1mYQFV0jrtUoIta6Y4L
         CihpaGAwIXuLVty3tGKT3mhyZQcrTVN+FFlQTAUMq5s5bRnyeyGe/+r9TMNSMQp5BdCL
         xsw+YdGheMFQ8pkItsPFr0xSL+/bxrZtecmFk9Qk8V9aY0RdxtTXHbK3oemhnMYNaJfb
         oIiA==
X-Gm-Message-State: AHQUAuYqaWzLaeF92s+MGT5wBg7iNsZ9HUhQ1eWR0GWpcJqN8RwfCgjI
        oArW1zJzPLGsmuCB/pU2dpRVHA==
X-Google-Smtp-Source: AHgI3IZ834xZeb2zU8CSHGPmjMAA9/Q89n+AHOlIuxyVGoRN7vTFBMdmBw76W83LcKQKJMBWRtJcuA==
X-Received: by 2002:a63:43c1:: with SMTP id q184mr16304950pga.110.1550471362528;
        Sun, 17 Feb 2019 22:29:22 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b197sm15104054pga.89.2019.02.17.22.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 22:29:21 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:59:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] cpufreq: davinci: move configuration to
 include/linux/platform_data
Message-ID: <20190218062919.n3etewl6ln3shr42@vireshk-i7>
References: <20190214170505.27251-1-brgl@bgdev.pl>
 <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
 <979dd2f6-17dd-9569-42fe-9490c09be1bf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979dd2f6-17dd-9569-42fe-9490c09be1bf@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-19, 11:56, Sekhar Nori wrote:
> On 18/02/19 11:46 AM, Viresh Kumar wrote:
> > Applied. Thanks.
> 
> Here is a belated ack from my side.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Included that and pushed again :)

-- 
viresh
