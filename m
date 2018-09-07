Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB912C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871832083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871832083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeIGHAH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:00:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:39507 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeIGHAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:00:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 19:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="71019199"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.86])
  by orsmga007.jf.intel.com with SMTP; 06 Sep 2018 19:21:36 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 07 Sep 2018 10:21:35 +0800
Message-ID: <1536286895.6128.4.camel@intel.com>
Subject: Re: [PATCH v2 2/9] nios2: build .dtb files in dts directory
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     nios2-dev@lists.rocketboards.org
Date:   Fri, 07 Sep 2018 10:21:35 +0800
In-Reply-To: <20180905235327.5996-3-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
         <20180905235327.5996-3-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 18:53 -0500, Rob Herring wrote:
> Align nios2 with other architectures which build the dtb files in the
> same directory as the dts files. This is also in line with most other
> build targets which are located in the same directory as the source.
> This move will help enable the 'dtbs' target which builds all the
> dtbs
> regardless of kernel config.
> 
> This transition could break some scripts if they expect dtb files in
> the old location.
> 
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack so I can take the whole series via the DT tree.
> 
>  arch/nios2/Makefile          | 4 ++--
>  arch/nios2/boot/Makefile     | 4 ----
>  arch/nios2/boot/dts/Makefile | 1 +
>  3 files changed, 3 insertions(+), 6 deletions(-)
>  create mode 100644 arch/nios2/boot/dts/Makefile
> 
> diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
> index 8673a79dca9c..50eece1c6adb 100644
> --- a/arch/nios2/Makefile
> +++ b/arch/nios2/Makefile
> @@ -59,10 +59,10 @@ archclean:
>         $(Q)$(MAKE) $(clean)=$(nios2-boot)
> 
>  %.dtb: | scripts
> -       $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> +       $(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
> 
>  dtbs:
> -       $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> +       $(Q)$(MAKE) $(build)=$(nios2-boot)/dts
> 
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
> index 2ba23a679732..007586094dde 100644
> --- a/arch/nios2/boot/Makefile
> +++ b/arch/nios2/boot/Makefile
> @@ -47,10 +47,6 @@ obj-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) +=
> linked_dtb.o
> 
>  targets += $(dtb-y)
> 
> -# Rule to build device tree blobs with make command
> -$(obj)/%.dtb: $(src)/dts/%.dts FORCE
> -       $(call if_changed_dep,dtc)
> -
>  $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
> 
>  install:
> diff --git a/arch/nios2/boot/dts/Makefile
> b/arch/nios2/boot/dts/Makefile
> new file mode 100644
> index 000000000000..f66554cd5c45
> --- /dev/null
> +++ b/arch/nios2/boot/dts/Makefile
> @@ -0,0 +1 @@
> +# SPDX-License-Identifier: GPL-2.0
> --
> 2.17.1
> 
Hi Rob

I have synced your all-dtbs branch from here: https://git.kernel.org/pu
b/scm/linux/kernel/git/robh/linux.git/log/?h=all-dtbs

It shows error when compile kernel image and also when "make
dtbs_install".



make dtbs_install
make[1]: *** No rule to make target
'arch/nios2/boot/dts/arch/nios2/boot/dts/10m50_devboard.dtb', needed by
'arch/nios2/boot/dts/arch/nios2/boot/dts/10m50_devboard.dtb.S'.  Stop.
Makefile:1229: recipe for target 'dtbs' failed
make: *** [dtbs] Error 2

Regards
Ley Foon
