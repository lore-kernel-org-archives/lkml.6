Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC12420855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2N+WqeZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC12420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeKJB7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:59:45 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27793 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeKJB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:59:45 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wA9GIMTt010330;
        Sat, 10 Nov 2018 01:18:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wA9GIMTt010330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541780303;
        bh=1JTZ1vdJtKf/gWFMMQq3eUNGs236RGfEMOXw2o/+iCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2N+WqeZ5CMaS4c7Moc1GqZ/Fy/2E9ogpS3L0o5X5WebKNbgsh48i2uctZHej1l2eE
         PpxLJAGqO0Ww0kFR/BT7lCYRJSRhb2V9vG/SfZhgtfM+OfCZMHG9spXHr45mp4eB4h
         VvaXgx6I4M853bWjU7qeRNeEcwWDc2NNvEfnbK+JAOhI9XNxUYrSLDHYOuV+qoMFmn
         wPJxOxCbDLhgyJDf/5QPwReY8ME8RQ2AUmZvyxZhDat5Wxh9JUmGCOl/63ab1QRreo
         oCKkfkiltMfBA3msOHkUqJuKdsZHaMm0/bZukJWL5syGHym7AeTTBxxlN9bcNn1Ef9
         wW3N4Fzm5Ev5A==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id x1so1326010vsc.10;
        Fri, 09 Nov 2018 08:18:23 -0800 (PST)
X-Gm-Message-State: AGRZ1gItyMTtu6PWQhNgTSRiMZFf5qzmMhyapRj3N4ULb6uner/wB4XS
        WNX0TVH9xKaWmVHZko+fvXhzd7rSd5uGDUaLYeU=
X-Google-Smtp-Source: AJdET5cB1SKpkWfnxUz4Zh76w06kMjLJq9kQp4bbFk6s2CorZWFrjGceR5F+6lA98kQZqvyDNdXs73amBBjvSPtLXH8=
X-Received: by 2002:a67:485:: with SMTP id 127mr4204390vse.54.1541780302120;
 Fri, 09 Nov 2018 08:18:22 -0800 (PST)
MIME-Version: 1.0
References: <1541404354-30331-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541404354-30331-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:17:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSHRhWM3X2kUe9KOvZMNxndSD3Hx+awOOEV_MMXT2tqw@mail.gmail.com>
Message-ID: <CAK7LNARSHRhWM3X2kUe9KOvZMNxndSD3Hx+awOOEV_MMXT2tqw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:53 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Ard Biesheuvel reports bindeb-pkg with O= option is broken in the
> following way:
>
>   ...
>     LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
>     LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
>    fakeroot -u debian/rules binary
>   make KERNELRELEASE=4.19.0-12677-g19beffaf7a99-dirty ARCH=arm64 KBUILD_SRC= intdeb-pkg
>   /bin/bash /home/ard/linux/scripts/package/builddeb
>   Makefile:600: include/config/auto.conf: No such file or directory
>   ***
>   *** Configuration file ".config" not found!
>   ***
>   *** Please run some configurator (e.g. "make oldconfig" or
>   *** "make menuconfig" or "make xconfig").
>   ***
>   make[12]: *** [syncconfig] Error 1
>   make[11]: *** [syncconfig] Error 2
>   make[10]: *** [include/config/auto.conf] Error 2
>   make[9]: *** [__sub-make] Error 2
>   ...
>
> Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
> for out-of-tree build"), both objtree and srctree were added to
> --include-dir, and the wrong code '$MAKE image_name' was working
> relying on that. Now, the potential issue that had previously been
> hidden just showed up.
>
> '$MAKE image_name' recurses to the generated $(objtree)/Makefile and
> ends up with running in srctree, which is incorrect. It should be
> invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
> in objtree.
>
> Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.


>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 90c9a8a..0b31f4f 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -81,7 +81,7 @@ else
>         cp System.map "$tmpdir/boot/System.map-$version"
>         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
>  fi
> -cp "$($MAKE -s image_name)" "$tmpdir/$installed_image_path"
> +cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
>
>  if grep -q "^CONFIG_OF=y" $KCONFIG_CONFIG ; then
>         # Only some architectures with OF support have this target
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
