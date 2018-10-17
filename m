Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5029ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D292087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D292087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeJREva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:51:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44898 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:51:29 -0400
Received: by mail-ua1-f67.google.com with SMTP id i30so3819475uae.11;
        Wed, 17 Oct 2018 13:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9+p5GxX2HyPASIvmZ+xNSEcE2+5a8r/JK5lgIZn2xk=;
        b=MFcn/SO/OVh2oCtJhJbKv8Y74k5wGDSi1sJEb3//9Uscm4iuuoycfXcz6X7Le3GHKD
         F+ZIlQcdQPlbUxRgw8YkfmrjVyJw5F+d7XHMuCPB/LVwqNTNh0aOE2LLJEhRvEabYnh8
         6iVZOcrnKae/EMJ6/FbasiiIKNPsnz5UZM9GHq9JQBHgOIuQAVr/z0wTQf4jhLcOR/aE
         DYyWEM7a1xYMaErdyfPQubkKwokD7ykSidr64Zet2nAoIsNJigT+msk1sOLt9hloVjZ9
         2W8xMKAWrwu9Af4SwreoypzGS5tQ0+MgyR/6kSSObrR6+jjxgzJC2frTMHTZyf302P32
         tcZQ==
X-Gm-Message-State: ABuFfojwsVflA+Kly0NUPZOEw7DxhrsfCEkhGRlN7dl4fD4weiIw8b+c
        PjJY5aPG/W6wzwY8UbjXOtpWJAazR4wqMLm8M08=
X-Google-Smtp-Source: ACcGV62TYbun9/76N5C+Wax0Iw/Xswrp1UGSbe3Ro9hdTExHrTiv2rfhaOYrOiEMq3J28cl7zjJfMIu+tAUr/5guCV8=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr5545125uae.20.1539809641814;
 Wed, 17 Oct 2018 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181017185128.2634666-1-arnd@arndb.de>
In-Reply-To: <20181017185128.2634666-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Oct 2018 22:53:48 +0200
Message-ID: <CAMuHMdUHV_eeA7Va+MdkhnercM+1yop56wL8uyMhNSz8sh6dWg@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: fix PCI dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Oct 17, 2018 at 8:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The code reorganization broke building without CONFIG_PCI:
>
> drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
> drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]
>
> Add back an #ifdef around the code block that requires it.
>
> Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Already fixed in spi-next by commit 9c2120090586d7e5 ("PCI: Provide
pci_match_id() with CONFIG_PCI=n").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
