Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88363C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32498217FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkvyuyAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32498217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeHJRJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:09:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34200 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeHJRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:09:31 -0400
Received: by mail-ua1-f65.google.com with SMTP id r15-v6so2076684uao.1;
        Fri, 10 Aug 2018 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=My/dG6rVWDQZhO6jex8h3m0BrUhvSJlqED5P1zQEhPI=;
        b=CkvyuyAn/IvEkyOfyQNJCGXYdFaz/573Y2n/oE3HynlUveaioUy7eSY+eO79r6/qvI
         PWG8lCpqv1cV6JsSdufd68jZ0JPllLZzlaZMPg42742XoTooBIe2yhEgwvtDWly8fvt4
         STZ5k8Q8rdf+QfLDj167PkQfqB38tJzRkitKS6bbR9HtG2eGAxC4QmTqfdqd5EIx+wGS
         /tR73NqsbIxVamPiAvWu+MycRvk3Z5wQ+4a8zB375h7hlGnOzeqTsyrLV3kpO/dvuGsr
         p51fYJLEJvREVtZGhK6CbKS1/ZTempzOyHU1NUBv4RLPOCLz0S7YM1rSOSFOWvoRtII9
         CG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=My/dG6rVWDQZhO6jex8h3m0BrUhvSJlqED5P1zQEhPI=;
        b=boelu90iMG/7FgcDGsaEpIKzf8vAYws6mCZaqtXgITsP+hZ/9A/ya5TsiIl9RFe4jM
         BZ1xZYsBmXRtTedTk/63oVshuIqiYHjaIHeWVHywIC40OyMJ6lavv8nHeIlx7U+dC+69
         nl8NvyZsF5erkYPX613ffNVYvx7uatO6f+exdRTEXXanGm+bcBizPmYblxEbhiqgsiXL
         8s1VLlbf3x1sXP8Arq5b+kO7ybz3gMNfDZQRu4tfvuTHiJy/bqjKd/HWew55eG3kmpUV
         h02D2tTZegWOTbbc/e0ahdXmIahAR0K3wtO2o2KLJsEjeM7+AEKeCl60Z282sfvbhBI/
         U3EQ==
X-Gm-Message-State: AOUpUlGusMobR+wtpLtmmYxnjKl4Y2eRoJBpiXZvuR2WZPOGY0bo4Flj
        +YZVsfXVGfS1Yc9517ftYxAK5SSShRUWwHUGe2M=
X-Google-Smtp-Source: AA+uWPw7npaJth81OsgUAnPtWm2CQNdU7mXBF6xljaL5Y+szAOoVbL7m3rlILgOUtmh3sHnxTC/hLgMTOD7PPuid/Jc=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr4146396vkf.76.1533911959062;
 Fri, 10 Aug 2018 07:39:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 07:39:17
 -0700 (PDT)
In-Reply-To: <20180810080526.27207-15-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-15-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Aug 2018 17:39:17 +0300
Message-ID: <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] net: simplify eth_platform_get_mac_address()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:05 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We don't need to use pci_device_to_OF_node() - we can retrieve
> dev->of_node directly even for pci devices.
>

>         struct device_node *dp;
>
> -       if (dev_is_pci(dev))
> -               dp = pci_device_to_OF_node(to_pci_dev(dev));
> -       else
> -               dp = dev->of_node;
> -
> +       dp = dev->of_node;
>         addr = NULL;
>         if (dp)
>                 addr = of_get_mac_address(dp);

Looking more at this I could even propose to change all above by

addr = device_get_mac_address(dev, mac_addr, ETH_ALEN);

Thoughts?

-- 
With Best Regards,
Andy Shevchenko
