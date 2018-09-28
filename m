Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E761C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22EA21571
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+j801IG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22EA21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1UIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeI1UIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:08:47 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA892173D;
        Fri, 28 Sep 2018 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538142294;
        bh=CWT1mp+mjvQ6NF6YuqWl2Os52EhMv6oS1W1vZfCyGdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K+j801IGLUkqp+Q2hiy+X7PTCNlrkdfj2ClIXGaR1SoDVtcHs3KG12gnbYnaLjFcL
         PCZE46xA5iMB2awF5zskCwNkGU6l+2klFaOvfzwetRIdNGzGBoRqx9YiYjz2tPoh21
         te5jPIOnjEt97rHNFDeYUdgoKMqA8naGQloxor4A=
Received: by mail-qk1-f174.google.com with SMTP id 80-v6so3891115qkj.1;
        Fri, 28 Sep 2018 06:44:54 -0700 (PDT)
X-Gm-Message-State: ABuFfohrvea5cc9NRzfv22+FANkK79trP7yZhhAE1/zo4oWfi1RWwwJ5
        OrZuOzPnvb/YMVSAYQZC40bZX2i+CHiovYgngw==
X-Google-Smtp-Source: ACcGV62+l5WjT0op2MNnjjR03dgU08rTqkGnrbVR3GpLQ+HIxhGNoi30SSrShJ6wvcrD8vkH5Znewe/xPNGzwMUDFb8=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr11925244qks.147.1538142293648;
 Fri, 28 Sep 2018 06:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180928064841.14117-1-takahiro.akashi@linaro.org> <20180928064841.14117-7-takahiro.akashi@linaro.org>
In-Reply-To: <20180928064841.14117-7-takahiro.akashi@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Sep 2018 08:44:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
Message-ID: <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
Subject: Re: [PATCH v15 06/16] of/fdt: add helper functions for handling properties
To:     "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David Gibson

On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> These functions will be used later to handle kexec-specific properties
> in arm64's kexec_file implementation.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_fdt.h |  4 +++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 800ad252cf9c..c65c31562ccb 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -25,6 +25,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
> +#include <linux/types.h>
>
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
>  #endif
>
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> +
> +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
> +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
> +
> +int fdt_prop_len(const char *prop_name, int len)
> +{
> +       return (strlen(prop_name) + 1) +
> +               sizeof(struct fdt_property) +
> +               FDT_TAGALIGN(len);

Looks like you are using this to calculate how much space you need to
allocate in addition to the current DTB for a couple of new or
replaced properties. I'm not sure that this calculation is completely
accurate. And it is strange there doesn't seem to be any libfdt
function for this already. It would be simpler to just add some fixed
additional amount.

Maybe David G has comments on this?

> +}
> +

The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
should go into libfdt, but I'm fine with having it in the kernel for
now.

> +static void fill_property(void *buf, u64 val64, int cells)
> +{
> +       __be32 val32;
> +
> +       while (cells) {
> +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
> +               memcpy(buf, &val32, sizeof(val32));
> +               buf += sizeof(val32);

This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.

BTW, for purposes of moving to libfdt, we'll need the authors'
(Masahiro Yamada and Hans de Goede) permission to dual license.

> +       }
> +}
> +
> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> +                                               u64 addr, u64 size)
> +{
> +       int addr_cells, size_cells;
> +       char buf[sizeof(__be32) * 2 * 2];
> +               /* assume dt_root_[addr|size]_cells <= 2 */
> +       void *prop;
> +       size_t buf_size;
> +
> +       addr_cells = fdt_address_cells(fdt, 0);
> +       if (addr_cells < 0)
> +               return addr_cells;
> +       size_cells = fdt_size_cells(fdt, 0);
> +       if (size_cells < 0)
> +               return size_cells;
> +
> +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
> +       if ((addr_cells == 1) && (addr > U32_MAX))
> +               return -FDT_ERR_BADVALUE;
> +
> +       if ((size_cells == 1) && (size > U32_MAX))
> +               return -FDT_ERR_BADVALUE;
> +
> +       buf_size = (addr_cells + size_cells) * sizeof(u32);
> +       prop = buf;
> +
> +       fill_property(prop, addr, addr_cells);
> +       prop += addr_cells * sizeof(u32);
> +
> +       fill_property(prop, size, size_cells);
> +
> +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> +}
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index b9cd9ebdf9b9..842af6ea92ea 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
>  static inline void unflatten_and_copy_device_tree(void) {}
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>
> +int fdt_prop_len(const char *prop_name, int len);
> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
> +                                               u64 addr, u64 size);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_OF_FDT_H */
> --
> 2.19.0
>
