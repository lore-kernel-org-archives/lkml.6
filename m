Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90530C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3610E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE4Wj1gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3610E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeH2LnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:43:00 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DEC92089D;
        Wed, 29 Aug 2018 07:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535528845;
        bh=2xGr9zfxJ6pB9oXxcizTcpaNK3Iadk5XonlFWbksiMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PE4Wj1gvE1opiE4Xy/NBWzAfnhxrvMhYyD3f611u4pq8Hv4VkG4xSY4Qv5j+cg3lZ
         afHyqyQvXUmuMeaiWzhJyYvO+zHyZq7NLkhnLNFTsyqu5P/3Dx0P+/AOcz6+2GB9uB
         IUKGXvdmKcBcdCRwV4gq9Zlto5sY/V+3GC12ytlo=
Received: by mail-wm0-f44.google.com with SMTP id m199-v6so3759637wma.1;
        Wed, 29 Aug 2018 00:47:25 -0700 (PDT)
X-Gm-Message-State: APzg51AhC6m3vaIf36rlmsPc9wzNFSKWryVlzGAr9eP71FNWcyvYmeKQ
        JJ0cf0yqBh0TF7XmZzS1busOQ00ECslZBDRKMIw=
X-Google-Smtp-Source: ANB0VdbJutw+QHO8HVtiiqikdKzLJAkkQcRgitALWptSR3Itl310kSMpf0dRIkS6pbFS8HgEhT4HtF0xUubiiIPNAwA=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr3235714wme.135.1535528843938;
 Wed, 29 Aug 2018 00:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-41-robh@kernel.org>
In-Reply-To: <20180828015252.28511-41-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 Aug 2018 09:47:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdk9Y3N=_Umy1cpuoEAaMbpZU86tUD7_Qp1APfjitc6Fg@mail.gmail.com>
Message-ID: <CAJKOXPdk9Y3N=_Umy1cpuoEAaMbpZU86tUD7_Qp1APfjitc6Fg@mail.gmail.com>
Subject: Re: [PATCH] regulator: Convert to using %pOFn instead of device_node.name
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, sbkim73@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 at 03:55, Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/regulator/max8997-regulator.c      |  4 +-
>  drivers/regulator/mc13xxx-regulator-core.c |  2 +-
>  drivers/regulator/of_regulator.c           | 44 +++++++++++-----------
>  drivers/regulator/qcom-rpmh-regulator.c    | 14 +++----
>  drivers/regulator/s5m8767.c                | 12 +++---

For S5M8767:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
