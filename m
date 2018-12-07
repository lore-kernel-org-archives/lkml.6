Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8547F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrExCRL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8547F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:10:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:10:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so3075339ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDIPOLrbVjB0WB8GXWEDeCaKrdKm8IAyhUY8mn+zcHI=;
        b=IrExCRL1K5O67tJA0hR8PrdI+NdJC49XvaJpE40qy5g3ZgA7q72aEYCCNactGsfzwf
         wIAEk9ppJNo4TaK0hwaCcRe4dEWM4XyfBzZltsPPjOC/cm+LNWnsWadDvVpA9B2nE3d9
         fX8X9jD0NbeclZA5I08gHu867gMCKvE2L9qgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDIPOLrbVjB0WB8GXWEDeCaKrdKm8IAyhUY8mn+zcHI=;
        b=ejEJDdDqZfSpuabMvORqR0WqReGmZcb1MXruZSAfwgXF3Eggp8SmmxHYkEiqtYnXMq
         yqe8SJayZp5NMN9JBlR3D6sBUwm45kn+fN3jVNcUMqU+oe6uZspas8VL0O1JdKx+4zUR
         CLiTdkeAAkICOaAqExUMQICNfvbpl6zHjqWOVfLSFqEYISbBP8HAapOLM+I5KglPRWhK
         I+BzsO3yoQTkixvZJbuM8ObEJup93XZVyjPrQnNIEL08LFhDQm7uZ4aaqKGAkLspGksQ
         aksy5ayumMjop/bXgfBBTPU88ecS+S03klmG7zgbb15NXSWLT2qN46ibwVfVnevNa8QO
         a4ug==
X-Gm-Message-State: AA+aEWbDGOWKt91fLnxdQK8+NAuZPvfHJsAqhciC/B6pAS3ciAebcaEF
        Kyjg9JVtwVGkmFJAL0RaK8MCU+F35/WOSHvqKDKOyQ==
X-Google-Smtp-Source: AFSGD/VknUd8qqWd8QRqrPS9ZAfQeo1oD6isRj5tm48diAh1XQDpT76gmfiZYNmwhbUfd16h5qvvz2qPXzamij9WF0Y=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr960334ljj.9.1544177449507;
 Fri, 07 Dec 2018 02:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20181130162246.3555-1-tiny.windzz@gmail.com>
In-Reply-To: <20181130162246.3555-1-tiny.windzz@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 11:10:37 +0100
Message-ID: <CACRpkdbxhdb3BWgsDVBmNri+i4coYDHRTRbRAfjVzyDN7uzMPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: ks8695: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     tiny.windzz@gmail.com
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:22 PM Yangtao Li <tiny.windzz@gmail.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Patch applied.

Yours,
Linus Walleij
