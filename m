Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF944C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A420818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhwjc7cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeKJHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeKJHLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:11:36 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D045720840;
        Fri,  9 Nov 2018 21:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541798952;
        bh=DlksNhAywKwI9bKOeGroJq7hQ+fSuWxJn7W47vjYvvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xhwjc7ccalhaI2ClLr9nSyx1EsYivoYkbVPleHEylwyq7Ti3j9xV+zOYOpn+bS6vm
         rHTCgnUwnmt/pfGt9zWcXK7Td71/xmM2usadrRIpP+99B/SR2ev18h8gJ19LVpqZXQ
         OkKkqabXS+et4y1p2jQAoV/1Y5ECO94NNzyK4/pk=
Received: by mail-qk1-f182.google.com with SMTP id o89so4208743qko.0;
        Fri, 09 Nov 2018 13:29:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gJpkrJXNTScbzZTwNAcU1VYM0ISaITsq/UuZeK/ZVxBx6nQAbgO
        UjGDRiskuJxhvkJxCpzpfqJhiFNxscYvlu7ndQ==
X-Google-Smtp-Source: AJdET5ffE9Q8zsYUBaSql8cvwbu4B4HCzBizXLVQC7TP0lCQjGZAfYoFTzRMKRejbgXCJwpwi2UQQWM1NRoV0xoXmps=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr10547621qvb.218.1541798950987;
 Fri, 09 Nov 2018 13:29:10 -0800 (PST)
MIME-Version: 1.0
References: <1541747389-28544-1-git-send-email-prpatel@nvidia.com>
In-Reply-To: <1541747389-28544-1-git-send-email-prpatel@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Nov 2018 15:28:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com>
Message-ID: <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: disable kmemleak scan on removed memory blocks
To:     prpatel@nvidia.com
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, talho@nvidia.com,
        Stephen Warren <swarren@nvidia.com>, vdumpa@nvidia.com,
        snikam@nvidia.com, schowdary@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 1:09 AM Prateek Patel <prpatel@nvidia.com> wrote:
>
> From: Sri Krishna chowdary <schowdary@nvidia.com>
>
> Memory reserved with "nomap" DT property in of_reserved_mem.c
> removes the memory block. The removed memory blocks don't have
> VA to PA mapping created in kernel page table. Kmemleak scan on
> removed memory blocks is causing page faults and leading to
> kernel panic. So, Disable kmemleak scan on the removed memory
> blocks.
>
> Following is the observed crash log:
> [  154.846370] Unable to handle kernel paging request at virtual address =
ffffffc070a00000
> <1>[  154.846576] Mem abort info:
> <1>[  154.846635]   Exception class =3D DABT (current EL), IL =3D 32 bits
> <1>[  154.846737]   SET =3D 0, FnV =3D 0
> <1>[  154.846796]   EA =3D 0, S1PTW =3D 0
> <1>[  154.846859] Data abort info:
> <1>[  154.846913]   ISV =3D 0, ISS =3D 0x00000006
> <1>[  154.846983]   CM =3D 0, WnR =3D 0
> <1>[  154.847053] swapper pgtable: 4k pages, 39-bit VAs, pgd =3D ffffff80=
09df7000
> <1>[  154.847228] [ffffffc070a00000] *pgd=3D000000087fff5803, *pud=3D0000=
00087fff5803, *pmd=3D0000000000000000
> <0>[  154.847408] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> <4>[  154.847511] Modules linked in: nvs_led_test nvs_bmi160 nvs_cm3218 n=
vs_bh1730fvc nvi_bmpX80 nvi_ak89xx nvi_mpu cdc_acm uas lr388k7_ts imx268 im=
x318 imx204 imx274 imx185 lc898212 ov23850 ov10823 ov9281 ov5693 tc358840 p=
ca9570 nvs snd_soc_tegra_machine_driver_mobile lp855x_bl spidev input_cfboo=
st pwm_tegra tegra_cryptodev tegra_se_nvhost tegra_se_elp tegra_se ghash_ce=
 sha2_ce sha1_ce aes_ce_ccm cryptd nvgpu cpufreq_userspace snd_soc_tegra186=
_alt_dspk snd_soc_tegra186_alt_asrc snd_soc_tegra186_alt_arad snd_soc_tegra=
210_alt_ope snd_soc_tegra210_alt_mvc snd_soc_tegra210_alt_dmic snd_soc_tegr=
a210_alt_amx snd_soc_tegra210_alt_adx snd_soc_tegra210_alt_afc snd_soc_tegr=
a210_alt_mixer snd_soc_tegra210_alt_i2s snd_soc_tegra210_alt_sfc snd_soc_te=
gra210_alt_adsp snd_soc_tegra210_alt_admaif snd_soc_tegra210_alt_xbar
> <4>[  154.882606]  snd_soc_tegra_alt_utils snd_hda_tegra
> <4>[  154.888133] CPU: 2 PID: 8079 Comm: sh Not tainted 4.14.53-tegra-051=
32-g9c33465 #2
> <4>[  154.895983] Hardware name: e3360_1099 (DT)
> <4>[  154.900447] task: ffffffc7d62dda00 task.stack: ffffff800e2b0000
> <4>[  154.906502] PC is at scan_block+0x7c/0x148
> <4>[  154.911234] LR is at scan_block+0x78/0x148
> <4>[  154.915689] pc : [<ffffff8008271724>] lr : [<ffffff8008271720>] pst=
ate: 804000c9
> <4>[  154.923290] sp : ffffff800e2b3b80
> <4>[  154.927228] x29: ffffff800e2b3b80 x28: ffffffc7d62dda00
> <4>[  154.932999] x27: ffffff8009aaa000 x26: ffffffc070c00000
> <4>[  154.938769] x25: 00000000000000c0 x24: ffffff8009d90608
> <4>[  154.944287] x23: ffffffc7dc6c6000 x22: ffffff8009d90000
> <4>[  154.950320] x21: ffffff8009aeb320 x20: ffffffc070a00ff9
> <4>[  154.955919] x19: ffffffc070a00000 x18: 00000000bec4c3f2
> <4>[  154.961438] x17: 0000002224777924 x16: ffffff80080bb0e0
> <4>[  154.967124] x15: 0000000000000000 x14: 0000000000000f75
> <4>[  154.973069] x13: 000fffffffffffff x12: ffffffbf1e9f4240
> <4>[  154.978670] x11: 0000000000000040 x10: 0000000000000ad0
> <4>[  154.984107] x9 : ffffff800e2b3ab0 x8 : ffffffc7d62de530
> <4>[  154.989958] x7 : 0000000780000000 x6 : 0000000000000018
> <4>[  154.995645] x5 : 0000000000000000 x4 : 0000000000000000
> <4>[  155.001245] x3 : ffffff8009aaa000 x2 : 00000047f6712000
> <4>[  155.006846] x1 : ffffffc7d1ae6900 x0 : 0000000000000000
>
> Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
> Signed-off-by: Prateek <prpatel@nvidia.com>
> ---
>  drivers/of/of_reserved_mem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1977ee0..ac8f377 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -21,6 +21,7 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
> +#include <linux/kmemleak.h>
>
>  #define MAX_RESERVED_REGIONS   32
>  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> @@ -50,8 +51,10 @@ int __init __weak early_init_dt_alloc_reserved_memory_=
arch(phys_addr_t size,
>         }
>
>         *res_base =3D base;
> -       if (nomap)
> +       if (nomap) {
> +               kmemleak_no_scan(__va(base));
>                 return memblock_remove(base, size);

I'm curious how I can't find any other similar example in the kernel.
Please Cc some kmemleak folks.

Perhaps we should be using memblock_mark_nomap() for nomap areas?

Rob
