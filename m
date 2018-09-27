Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9DA216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwXgCL8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9DA216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeI0T6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeI0T6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:58:00 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C35216E3;
        Thu, 27 Sep 2018 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538055580;
        bh=F2EqgD8qrDY6ZUbuRSMMzaxGPTJBxpW+u/ynLRYrbjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JwXgCL8vPzjh8rv7hi38ghV8rq2o/wcpSxPd9aEcubaORpuGzHl8Wqfw2zMsB4pgU
         5ekszZkW0bMAmaXA5FT/yrMWLKTrslL73RWAAhNMktMct+TUFaQF8/0G63RMAovcaD
         oLacGfX16wVWv4sR8QTqAK2ZLKqdGblvsR9gfTT4=
Received: by mail-qt1-f170.google.com with SMTP id m15-v6so2706454qtp.8;
        Thu, 27 Sep 2018 06:39:40 -0700 (PDT)
X-Gm-Message-State: ABuFfohuPdu3fG7hCaqdLGsKRa5PtGQE5aJCqjMplDWInqu9g7QJAi+F
        HNut9vwaBjE31Se3pVhd5OKqFzmdsGVA/rj6vw==
X-Google-Smtp-Source: ACcGV61d6L3cd/USZSsJ88SWnhzGyBB5A8hcYbeMFHBmRqPUJ3n53nrht7aHdtty6Zq2Vs5eQ2+Brd13t3PU82eh+Dg=
X-Received: by 2002:a0c:bc03:: with SMTP id j3-v6mr7455742qvg.77.1538055579729;
 Thu, 27 Sep 2018 06:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-2-robh@kernel.org>
In-Reply-To: <20180910150403.19476-2-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Sep 2018 08:39:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLTs3rdyOD51cpPxhCG-ZZ4sA5_=+h6x+xfc=f1xwed-Q@mail.gmail.com>
Message-ID: <CAL_JsqLTs3rdyOD51cpPxhCG-ZZ4sA5_=+h6x+xfc=f1xwed-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] powerpc: build .dtb files in dts directory
To:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>
> Align powerpc with other architectures which build the dtb files in the
> same directory as the dts files. This is also in line with most other
> build targets which are located in the same directory as the source.
> This move will help enable the 'dtbs' target which builds all the dtbs
> regardless of kernel config.
>
> This transition could break some scripts if they expect dtb files in the
> old location.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Remove duplicate mpc5200 dtbs from image-y targets. The dtb target already
>    comes from the cuImage.<platform> target.

Do the PPC folks have any comments on this?

Rob

>
>  arch/powerpc/Makefile          |  2 +-
>  arch/powerpc/boot/Makefile     | 55 ++++++++++++++++------------------
>  arch/powerpc/boot/dts/Makefile |  1 +
>  3 files changed, 28 insertions(+), 30 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/Makefile
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 11a1acba164a..53ea887eb34e 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -294,7 +294,7 @@ bootwrapper_install:
>         $(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
>
>  %.dtb: scripts
> -       $(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> +       $(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)
>
>  # Used to create 'merged defconfigs'
>  # To use it $(call) it with the first argument as the base defconfig
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0fb96c26136f..bca5c23767df 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -304,9 +304,9 @@ image-$(CONFIG_PPC_ADDER875)                += cuImage.adder875-uboot \
>                                            dtbImage.adder875-redboot
>
>  # Board ports in arch/powerpc/platform/52xx/Kconfig
> -image-$(CONFIG_PPC_LITE5200)           += cuImage.lite5200 lite5200.dtb
> -image-$(CONFIG_PPC_LITE5200)           += cuImage.lite5200b lite5200b.dtb
> -image-$(CONFIG_PPC_MEDIA5200)          += cuImage.media5200 media5200.dtb
> +image-$(CONFIG_PPC_LITE5200)           += cuImage.lite5200
> +image-$(CONFIG_PPC_LITE5200)           += cuImage.lite5200b
> +image-$(CONFIG_PPC_MEDIA5200)          += cuImage.media5200
>
>  # Board ports in arch/powerpc/platform/82xx/Kconfig
>  image-$(CONFIG_MPC8272_ADS)            += cuImage.mpc8272ads
> @@ -381,11 +381,11 @@ $(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperb
>         $(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))
>
>  # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
> -$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
> -       $(call if_changed,wrap,$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> +$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
> +       $(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
>
> -$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb FORCE
> -       $(call if_changed,wrap,$*,,$(obj)/$*.dtb)
> +$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(obj)/dts/%.dtb FORCE
> +       $(call if_changed,wrap,$*,,$(obj)/dts/$*.dtb)
>
>  # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
>  # prefix
> @@ -395,36 +395,33 @@ $(obj)/vmlinux.strip: vmlinux
>  $(obj)/uImage: vmlinux $(wrapperbits) FORCE
>         $(call if_changed,wrap,uboot)
>
> -$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> +$(obj)/uImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
>
> -$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
> +$(obj)/uImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,uboot-$*,,$(obj)/dts/$*.dtb)
>
> -$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> +$(obj)/cuImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
>
> -$(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
> +$(obj)/cuImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,cuboot-$*,,$(obj)/dts/$*.dtb)
>
> -$(obj)/simpleImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> +$(obj)/simpleImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
>
> -$(obj)/simpleImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,simpleboot-$*,,$(obj)/$*.dtb)
> +$(obj)/simpleImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,simpleboot-$*,,$(obj)/dts/$*.dtb)
>
> -$(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
> +$(obj)/treeImage.initrd.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb,$(obj)/ramdisk.image.gz)
>
> -$(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits) FORCE
> -       $(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
> +$(obj)/treeImage.%: vmlinux $(obj)/dts/%.dtb $(wrapperbits) FORCE
> +       $(call if_changed,wrap,treeboot-$*,,$(obj)/dts/$*.dtb)
>
> -# Rule to build device tree blobs
> -$(obj)/%.dtb: $(src)/dts/%.dts FORCE
> -       $(call if_changed_dep,dtc)
> -
> -$(obj)/%.dtb: $(src)/dts/fsl/%.dts FORCE
> -       $(call if_changed_dep,dtc)
> +# Needed for the above targets to work with dts/fsl/ files
> +$(obj)/dts/%.dtb: $(obj)/dts/fsl/%.dtb
> +       @cp $< $@
>
>  # If there isn't a platform selected then just strip the vmlinux.
>  ifeq (,$(image-y))
> diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
> new file mode 100644
> index 000000000000..f66554cd5c45
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/Makefile
> @@ -0,0 +1 @@
> +# SPDX-License-Identifier: GPL-2.0
> --
> 2.17.1
