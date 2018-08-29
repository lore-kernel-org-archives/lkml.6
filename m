Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32833C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B132086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C403Y0qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B132086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeH2KzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:55:24 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:42431 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2KzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:55:24 -0400
Received: by mail-io0-f171.google.com with SMTP id n18-v6so3570892ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuz20UYvmpY0TQJW7G9hBeCSS0KS/EaFK+T4i8j8uYg=;
        b=C403Y0qUX5atPV5biggCSB9KRvnSA3adH5AarPBE6XtZ0tVDjVrWphr7mtW4wDe6Wa
         4Am25ULoTlwwKPqXDVfSWybpuNpYUYERB6+KMvoZm9+eV++oFR6L6moIS68sURmCMzjs
         iDfBfzl7cyxz+Ia4RgMenf+iZA/8twbSslM2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuz20UYvmpY0TQJW7G9hBeCSS0KS/EaFK+T4i8j8uYg=;
        b=j7ZrEmZkqOdN+VIipaJI2J1AicZ+D747SxQi+Mup4347fMzZxu3cA0TdYRq8jjV0k3
         3K4GYYaFBNwS+LXlIcJx6LT4UH1/an2zl7VU9+hC3RyORy3q1+ynhHUyEWXBhNqe4fAr
         +6+O9QeNVSiCSUvP0IBn8HhqLSSp3OXKxsD+EizK7m3tsLrSkevyg6PeYVTtYSZ4jLt9
         7i4fXNX6EWNSb/97Q0Et6EAliB/OOUVFdV1DhoCkYQS/yi4aoJjs/Y5vctjBBjwREuiS
         pkKa20m3SleMZhsY4NeUind+UG9kqNF5JiefP1P9FqAvOkMjxlSUYwdad0e7megx9Qup
         h3KA==
X-Gm-Message-State: APzg51CbAloEuXdfS+5bTyIUlKpRKfy7QViP+wbBMm+gxp21XBx+dVYn
        54EDvaG3j54A2/4BlZjZSj3MNU/11K6WAqxT72kf/kGeEjk=
X-Google-Smtp-Source: ANB0VdY+Hr9xsJpstGVkd9yNjDrDxgY0iCb/IVFw3t/T6v4pB3TTS6xB2GdZNY9OMtx8pcmohvSdp/LE69MaXpyynOc=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4068152iog.175.1535526000137;
 Wed, 29 Aug 2018 00:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180829062401.8701-1-hch@lst.de>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 08:59:48 +0200
Message-ID: <CACRpkdaHfNE7aPc5G6u7aGaXjq9ccpvtmnRyFg2n+g52eqY22w@mail.gmail.com>
Subject: Re: various dma_mask fixups
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>, mroos@linux.ee,
        Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 8:24 AM Christoph Hellwig <hch@lst.de> wrote:

> Fix warnings and regressions from requiring a dma mask.

Applied all three patches and took a few ARM systems for a test ride:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
