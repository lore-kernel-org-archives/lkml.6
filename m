Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48320218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbeLTP2O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:28:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35581 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeLTP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:28:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so1215174qka.2;
        Thu, 20 Dec 2018 07:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jq3I+sIGPWuTXU9l2I91zVqcZTURf4bARp+MtSMgm1I=;
        b=I4ZDdKjoD/nyRlH+9HCOn/EYNJhyRi5bS96/5jpCNMVuGCuALT4vifWWoB4EMkGuGY
         fqj4Wdh05TFbphbmpygHKb1XJx2fq7DcwKaF22YjIMWNk3tNbSQ3BTcUeuvA68slqk1X
         pmrLKqq8lEdCG/8Yo1Q5Ea1YBzOAriNpmQ0tE8pkShwJHIulj08HBEemMwKkCEV4FBAW
         ibCy3UERgyiSvhWCNVbs+DfcPloNdC7uLQg+hKJ/+P7bQzuz0m25IAQU7WlXqJxBFA2e
         /ETc4+r4XGZuC4k4wcH3ufiz4IW9AnSz8MLAiraQAs+IO+TivylsQ9qqGCAwRqUx+zLM
         PkLg==
X-Gm-Message-State: AA+aEWbpwpOMDgs05yK3yPr8hFn1LLEW75ULaBAorEzdB3/KlsOacyu9
        3WBaEHzNL4sxPS4151yhk8sw2Hyc1mtAwjKtJb0=
X-Google-Smtp-Source: AFSGD/V8H9l/pA3RobftRSciF8rJuTJ5OeZ66JUloZ7THmfqhqtbtiRwleRd6hnPYkmoZ7g4C4qibWr88W9YOlFqNf4=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr23791913qkf.107.1545319692643;
 Thu, 20 Dec 2018 07:28:12 -0800 (PST)
MIME-Version: 1.0
References: <2071995319.127120.1545163830046@email.ionos.de> <20181219101844.6362-1-horia.geanta@nxp.com>
In-Reply-To: <20181219101844.6362-1-horia.geanta@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Dec 2018 16:27:56 +0100
Message-ID: <CAK8P3a3RLdRtY2ND0r4VQ5447V1WLYD6b9NcWjYvYR2AUCV1tg@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"
To:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:18 AM Horia Geantă <horia.geanta@nxp.com> wrote:
>
> This reverts commit d9678adbe733a770428a98651beaa2817d503ed3.
>
> Received below report from Stefan.
> Revert the commit until CAAM driver dependency cycles are fixed.
>
> this patch in next-20181214 breaks "make modules_install" for
> arm64/defconfig on my Ubuntu machine:
>
> DEPMOD  4.20.0-rc6-next-20181214
> depmod: ERROR: Found 6 modules in dependency cycles!
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio
> depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> error
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_desc -> caamalg_desc
>
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

I've applied the revert, but I think there is still a problem, since
anyone could manually enable those options and should not
see those cycles in the module dependencies.

Horia, can you have a look at what caused that and how to fix it?
It's probably a commit in the caam drivers. I have also created
a patch to address a problem with that driver but forgot
to send that out, it might fix this one as well, see my follow-up
patch "crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM
dependency".

       Arnd
