Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA16C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162D218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MimCXGW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfBGDyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:54:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35060 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfBGDyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:54:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3927529pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dzXRzhNeAJaEDDw2bDa7ru6nYvSSdEcmyz9Bav3YOBU=;
        b=MimCXGW0Zu7FeWTSBR9d1/YF9E7VPhv36ttKdTrQaqDHEbHFsoysktz5aHAAUGMXYJ
         /2/oDvpnfjxcMKyQKw14aSa6rKxUbQedk2Wjk/J4PARs2y5LdKQM0yYN7T9lah6SaCqc
         Y6/EqGrAmZPBka4qczbSkvPOOXVK2vc28xDSBMQn+5Klx/p+fPtXsmOj6pMLN/RtgdLu
         4utt1CO3kzBRchYjNnnbd8LSe2et8Ye+jbM5KnsWbxxet6I4NkZqr9/Uax1YjoQCtNrM
         ZNsfXL7W4m5lqeknrJP/oXvjZym6zfla0cgjpvKR/4Oa0m6rSvRXmuL/0Y74tsr65l7F
         ErMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dzXRzhNeAJaEDDw2bDa7ru6nYvSSdEcmyz9Bav3YOBU=;
        b=FVkcmwTuybhtPIFIchRnEigUN9fAXe8ZBhbSLCvViGlsQFH6gf06Dw/tO+xJTzqykE
         F/5/lcIIm4PgBe/8Q5Fx/mx+g/CQKQ8zCJc0dpTNnw6N0aoTYSo3chC/iEoDwkKJEj66
         l1tINZ2Iok3666xbIl1/K3NeDLboRJlfAz2QPVkKU26HRpvPiI4zhP34X1XcDSITOJg0
         scVUa4m7FCJq0WQwmNLWgQONPAbQZRP12pOJvAMhz/g6zl4CWJdPITCXEF9WGL412LY2
         Et98LcJUWoO7t2rKaMrj9RzYJKG/GjoGBGYuhFsQ2N6cP7ucDQv3TBUqTC413sojLAoo
         /tRg==
X-Gm-Message-State: AHQUAuaV1BG/UTvB6+oVvcHbpVJHZ0MVBRV4ieVh8E0MzmghcfW8nHFE
        p+/Kf/IU41hacHt0JosnBEf+bg==
X-Google-Smtp-Source: AHgI3IZlRGwVgh2CPfMev7H+GxPlpUtK2D9w1DvuR8UVW0yabk9i1txXo7EmDTCJQLHIK4+xYu4BSg==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr8369118pgv.427.1549511662023;
        Wed, 06 Feb 2019 19:54:22 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id l70sm10201707pgd.20.2019.02.06.19.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:54:21 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: meson: do not select COMMON_CLK_AMLOGIC
In-Reply-To: <20190128182252.32589-1-jbrunet@baylibre.com>
References: <20190128182252.32589-1-jbrunet@baylibre.com>
Date:   Wed, 06 Feb 2019 19:54:19 -0800
Message-ID: <7himxwgsno.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The patchset remove the selection of CONFIG_COMMON_CLK_AMLOGIC.
> This CONFIG symbol:
> * Is already selected by controller driver which requires it.
> * Is being removed by this changeset [0]
>
> Whether or not series [0] is merged, selecting CONFIG_COMMON_CLK_AMLOGIC
> is not necessary and it is safe to remove it.
>
> [0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com

Queued for v5.1 (branch: v5.1/soc)

Kevin
