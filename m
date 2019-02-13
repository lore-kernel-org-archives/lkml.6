Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CAEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300BD20700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbfBMO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:28:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45843 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfBMO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:28:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id y195so1400703qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y83HGNMQd0DuWDWDAfAIXbfOheQz3mAr6eKKBDtRjMY=;
        b=AtsP+drlhiSCKovW8RYHmaQKqnAxf3/PqxJvMKQr8CBYMvrEkePto8/Pc5louYq9Sx
         NaftRYbdBFnftbcw8FaL68fubkvwycfULqn30s2eORycngzsch4U2eRStPaM8EeddfqG
         VsdP9KSKSarhP3c9Z5MOJxG57tVPLY43GH+0Ik7sFzg8lBB9muM7OLhtH6G06YsxQ+ay
         idPsU0kWA8y3VWSTqNOEftutEJpewfo/dvrQk2NAc52fALA0xN/yk+jrxoAzlKTsErKl
         YUORwN5EWZBPimtRUyvjK4ch3t9Fmu68E5L/H/6qv/mKONHwaR1GDDT4m8Ki+rP8KXhU
         zI3w==
X-Gm-Message-State: AHQUAuYu5UT/e6oG5ENalQ1sqyKAKx6b7aNRqusNZYEP09uv9I3HUCin
        8ZevPf5knCfEVglhEOUv+KIRjemPaJsyEcbbLpU=
X-Google-Smtp-Source: AHgI3IbfTLnlwe6xs1PSvf0Dm+PJYCHl5ZIAWyj2Rk+RQSHNbZ0MY2AtfdNAKtRCcj5evW2oJ4TlUksHqWjUT7BJFJ4=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr573796qki.291.1550068133539;
 Wed, 13 Feb 2019 06:28:53 -0800 (PST)
MIME-Version: 1.0
References: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
In-Reply-To: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Feb 2019 15:28:36 +0100
Message-ID: <CAK8P3a1Ad+u9DHXkAe=p6pzCm0b24wvh8NH+Y3n6RRup7maBuA@mail.gmail.com>
Subject: Re: [PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 1:57 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> We should use SoC compatible string in stead of wildcard string for
> PMIC child devices.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good. I had a look at arch/arm64/boot/dts/sprd/sc2731.dtsi
as well, which contains lines such as

compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";

which fortunately work with both variants of the driver.
Just to make sure we have the same understanding though:

- Other drivers will leave out the 27xx part and just do
  compatible = sprd,sc2732-efuse", "sprd,sc2731-efuse";

- When you specific a generic name (such as the sc2731 part),
  the more specific one (e.g. sc2732) needs to come /first/.
  The current DT appears to have those mixed up.

      Arnd
