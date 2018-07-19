Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE8DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B71206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd0SP9ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B71206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbeGSTwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:52:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55691 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeGSTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:52:36 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so11340008itl.5;
        Thu, 19 Jul 2018 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ayyu5j774uCw8au4qdPNIKicLGdYZ/T0Z7Lcmvzt3bQ=;
        b=vd0SP9wsXowDxJANmL6OsPfzhxH9ljtXEvv5dtmRVoXoweN3NRNWi6kkRighbhjtsx
         yOT0Yj410fsGNxrv6CJHF/89+JGqfjAGXUGf6J2kGJjFPw0giNgSC5Cd0cCbOQtWJ/It
         2T5OQXQLeM5yPhyfnJSb43In8tXLnj/g7qTRXi7OrJVYmf6trGG93PZBe7uN82hlnfEe
         HBUG5nBBpt4hz8k7SLL293C8hvRh0CX2emUrcSrnqRUSPdLDHr+/CFSPQpWDo/8102o4
         UhFWzjYK/fNJz8vuJOiZ57QtYyZLOFpHUy3fsattop7Vdt6EoeMUNhAQRnjANtsu0guD
         hWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ayyu5j774uCw8au4qdPNIKicLGdYZ/T0Z7Lcmvzt3bQ=;
        b=moeNtIdcTdIOnjXTspsu/WPuGZamJp7o3hTO7KhjvDd3rdKe1nQ1QgIIPF3RGzEGgV
         WvKUiGpbUK+VTU5UNVkn+g+dP2NN0JtOuaeWalV1m4/I81MC1h3BZdoUte2T+5at9Bal
         UFMzfsuCxPHghLgcdVIHle5YX54rAm7J/887dEMZZouoN8G+hgaN3tKzBs1/P8ZCYrfB
         PG33mDqJHkGDhHayZHdrSFgCWT7PckCE0WwNSzQn1kRJ8wyiS4F0tGAkzF/19to6IdSM
         ox72z72rOOBQlyn8Sq3mB5B4sqxO3YfLAVorozAek4iDRQ0pdx7K6Tc+G5c0U1ZSEiSl
         Tq/g==
X-Gm-Message-State: AOUpUlEQAo/Cj57ucl6EGIBNcFhRDNA33T35Xk1fCDnDtuqhzV5c8uu+
        CFQKIHkW5m6ID5IzSTfMFG9ZtIccNJyoHUDqg8M=
X-Google-Smtp-Source: AAOMgpeF8GKEYW3I0Mxnu+ctJShCThzij9Id76DnP5O+N2BKPyyvzH8KylGDFq4pgUD1N0d1vpnsqTMoNF1x4QgOv88=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr10843901jaa.127.1532027286704;
 Thu, 19 Jul 2018 12:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180719005941.10458-1-andrew.smirnov@gmail.com> <CAOMZO5D1rKH+_wuJrhD6Cr4psQwnk7CHVWm6qi0Jv7vnTiazUQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D1rKH+_wuJrhD6Cr4psQwnk7CHVWm6qi0Jv7vnTiazUQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 19 Jul 2018 12:07:54 -0700
Message-ID: <CAHQ1cqE7m6WO1t3YggrMrApFV2m2Y2G4NPDMcb6Ry9zQHC8xqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 5:45 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Wed, Jul 18, 2018 at 9:59 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > +/ {
> > +       model = "ZII VF610 CFU1 Board";
> > +       compatible = "zii,vf610cfu1", "zii,vf610dev", "fsl,vf610";
> > +
> > +       chosen {
> > +               stdout-path = &uart0;
> > +       };
> > +
> > +       memory {
>
> memory@80000000 to avoid dtc warnings with W=1, please.
>
> Please make sure that this patch does not introduce any W=1 warning.
>

I foolishly assumed building it with W=2 would reveal W=1 level
problems as well, but apparently not. Will fix in v2. Same problems
were missed in SPU3 patch that just went it. I'll send fixes for that
one as well.

Thanks,
Andrey Smirnov
