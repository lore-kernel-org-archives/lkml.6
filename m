Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA622087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWoOHPUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA622087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJSVPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:15:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33317 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJSVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:15:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id q40-v6so38186641qte.0;
        Fri, 19 Oct 2018 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLTGO3aWKDhOyuuJS0fbrHTM/iEWsxnQLUwh//H4oUo=;
        b=rWoOHPUiaChexXrHJRdYBN0JbiODLT44MyPGFhKMAFBilYPpVjNxo/jtObWvFLJDB6
         Qb9P3LOpHkaqNHZ3prY5sPpcuJTKpbeMhUtOSQeQOm06ccuTyf5s6UrabAhORNx6hsBm
         /xezPH037qLrso78nRHfSUsabnU8YWT1dkwjveVO5MQSluKb/r29XiCGUUom8Zoqs//8
         ARJAk5gEESIvYfWwWQGBVvtsGy0qv0PFhHBV9Hv9YsLvhrdferrwVLXUUB7oNZSXOVWO
         XtCO1bNxVU0n30pUrBnKf8yTE8cyblA1ZMXNlsolyXFmhb5hgyYWRI2KkfrnhVGNo+Zw
         fJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLTGO3aWKDhOyuuJS0fbrHTM/iEWsxnQLUwh//H4oUo=;
        b=uhpgJ2pxZV8xyu87zoGczR3bysq5tQUpkAa86euJrXV2atq1n2U7PLifuq18ok2K10
         JFvn6KAT04Ml55d/pxParTrLEBePUEQROIG/TJmX4gDmj+2CbjhmPtWuGrPSKmQekmyY
         eXEQKXhNyOfeBt76pfC3fV496wMhYnxD3TZkQycZavKbBXniR1oAtDi0a7+V8odajdYo
         4T7IsinWn5hT8/K+rjw8WXtjHbWWqOUHCkIKe7zgoGa7H8RSzTkZ2s27SftFqKyDy0KJ
         /cbQQBAFJ6MEfY90FbajDEgufg93w0T6GYL7IX9QrD2GNMCpzZh0PbrQEvOXAv8F21Tp
         Vgyg==
X-Gm-Message-State: AGRZ1gJpQPhsKFAOqT5jcsOEgf4kBWnFtq/ufcMxqbVn/LtK1qvS023i
        oW9D8lhgG4o1lDUZjizqRQauIsowvoLiKXRzkps=
X-Google-Smtp-Source: ACcGV60K1I3aHSV6JFJvtzHgZmI4n0g8INhBTPh7+P1hpMwyrQ/o5vl2nMp3BtaVFl5BsaRQlWYexxgQr7zwJYCjfWc=
X-Received: by 2002:aed:3e46:: with SMTP id m6-v6mr1914855qtf.99.1539954568841;
 Fri, 19 Oct 2018 06:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-6-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-6-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:09:17 +0300
Message-ID: <CAHp75VdNJwWbKfbsMQ2ZVmC=H3yPaLgxnE4Kstff9CYeopZJ7A@mail.gmail.com>
Subject: Re: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86 tree
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There are ARM OLPC machines that use mostly the same drivers, including
> EC infrastructure, DCON and Battery.
>
> While at that, fix Kconfig to allow building this as a module.


> -       depends on MOUSE_PS2 && OLPC
> +       depends on MOUSE_PS2 && X86 && OLPC


> -       depends on OLPC && FB
> +       depends on X86 && OLPC && FB

Looking to this I would rather introduce an idiom

depends on OLPC && X86

on the opposite you may do similar for ARM

depends on OLPC && ARM // or ARM64 or whatever it's called

thus, above would look like

depends on MOUSE_PS2
depends on OLPC && X86

and

depends on FB
depends on OLPC && X86

respectively.

-- 
With Best Regards,
Andy Shevchenko
