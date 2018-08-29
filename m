Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254AC20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoae52au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254AC20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeH2Lkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeH2Lkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:40:47 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352A520898;
        Wed, 29 Aug 2018 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535528712;
        bh=LvKQMwpmS911p9K4tfmR2DLJ4r4qaolJ0T1iA2oIAgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eoae52auia3hQR/s47dgwYpnUQqXId7aUFbGzJKZI+jt+srsyR6inzj7SKrUuqncA
         C46CwhCNRCD7FyeOLXoRtyzLDKYFyAF4wYA9CBad2VdwsCKeM7U+DexfHCuH50lRBQ
         DYTNxAzcbmVzKAlyBFC7jpDImeFNQAluvFpNorUM=
Received: by mail-wm0-f42.google.com with SMTP id y2-v6so4238092wma.1;
        Wed, 29 Aug 2018 00:45:12 -0700 (PDT)
X-Gm-Message-State: APzg51A9DjhSyE7T7Gc0ltunJwj3MoFV5VbeJTldG+hi/UUZ1UWAphQR
        6nGZUeX6FcM7Fo7nDyrrdnr+MwrJXrbM/F2BeR0=
X-Google-Smtp-Source: ANB0VdZRbwOWFwYApQ0NoWJ2d4hjvPdj8ugSY/MBu0oB49NMEqES3sZGL6WqIObiMDOEYeVGdjr/WU42Zb0Kmq0T0Ek=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr3200029wmd.135.1535528710756;
 Wed, 29 Aug 2018 00:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-29-robh@kernel.org>
In-Reply-To: <20180828015252.28511-29-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 09:44:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdtVA14+DFmL_LYy-UZ1Enq06TxazDLW8c8ihn_+vw8Gw@mail.gmail.com>
Message-ID: <CAJKOXPdtVA14+DFmL_LYy-UZ1Enq06TxazDLW8c8ihn_+vw8Gw@mail.gmail.com>
Subject: Re: [PATCH] memory: Convert to using %pOFn instead of device_node.name
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, rogerq@ti.com, tony@atomide.com,
        kgene@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 at 03:54, Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c           | 18 +++++++-----------
>  drivers/memory/samsung/exynos-srom.c |  4 ++--

For Samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
