Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D69222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E65OioZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfBMJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:56:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40763 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfBMJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:56:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so1830988qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XeiGOFny/PvKbXqkedANt10pJAYMJYW3szL+IqAnA9o=;
        b=E65OioZsifoTJ5uaMGJzSmerPfPGfEAzIiEANzx0pDzpHGg7JfWB6o2KiqLMaJsZTE
         woNKE4MZ1IDA32TpC/mcFSO65FaTgwHm74PfJIEW7dLz5/OEcKlJtSQR46F6gPNe4WdH
         CBn7Z2AuOmnjfF5e7LPXJOEG5+fRDLsiL89t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XeiGOFny/PvKbXqkedANt10pJAYMJYW3szL+IqAnA9o=;
        b=RkJwghynAWeuuAgQjcUxin4UH4X4xhUM/WlOsT4BQnu2Fd9Imr3Ac4uNhfRY8dNYNJ
         MkYX5w8lHUH6cC517cOASFpF5Yx4/WI8hxGuvL9TR5PcRNZ8LLCzXcrlPvby5BO6xV+6
         C2aTz8H+FwR9Sp0PE/6v3D4w7dQNshqG5GMMMTXqj+a9ZzURpalR/TrtBs3QXYUxel8h
         f/d6+YTnTEPZ+yuDwOOTtUYj8JUZ/v9zyKnNHZj885tEa0Vt4tTqV+63+iQ8PBfuLQ5u
         I4J5Wkjxwpq8R4ol3rZfMZFuw10avTF8jpE4848i2eATyRlaPi1pu4yjya5xToQhPlQY
         xk7A==
X-Gm-Message-State: AHQUAuapkxy64SQ39mAyUdPxuAeTNVPX/Nb/7FGW21hjOjb3lAuUCday
        /8+lD1yeN6mhxDH8YM83hGlTmnmg/m5mCinZjNoL4Q==
X-Google-Smtp-Source: AHgI3IZ6R4fNZeuFGBMis2RmAArdl/Plm4z83ZEsP1XodUREYoyMbbcJTcuYP8MCabKEi/wydw/ahr8R25ga16uSb8Y=
X-Received: by 2002:aed:2022:: with SMTP id 31mr1758875qta.368.1550051807956;
 Wed, 13 Feb 2019 01:56:47 -0800 (PST)
MIME-Version: 1.0
References: <1541747389-28544-1-git-send-email-prpatel@nvidia.com>
 <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com> <39d4161b-bcc0-0f1c-e7a3-5ad552fae724@nvidia.com>
In-Reply-To: <39d4161b-bcc0-0f1c-e7a3-5ad552fae724@nvidia.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 13 Feb 2019 17:56:36 +0800
Message-ID: <CANMq1KDU=rTbwBdej+E0=RaWGQCOJrtKo_0W6kc=EdomNrKzog@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: disable kmemleak scan on removed memory blocks
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, matt@codeblueprint.co.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, talho@nvidia.com,
        Stephen Warren <swarren@nvidia.com>, vdumpa@nvidia.com,
        snikam@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:46 PM Prateek Patel <prpatel@nvidia.com> wrote:
>
>
> On 11/10/2018 2:58 AM, Rob Herring wrote:
> > On Fri, Nov 9, 2018 at 1:09 AM Prateek Patel <prpatel@nvidia.com> wrote=
:
> >> From: Sri Krishna chowdary <schowdary@nvidia.com>
> >>
> >> Memory reserved with "nomap" DT property in of_reserved_mem.c
> >> removes the memory block. The removed memory blocks don't have
> >> VA to PA mapping created in kernel page table. Kmemleak scan on
> >> removed memory blocks is causing page faults and leading to
> >> kernel panic. So, Disable kmemleak scan on the removed memory
> >> blocks.
> >>
> >> Following is the observed crash log:
> >> [  154.846370] Unable to handle kernel paging request at virtual addre=
ss ffffffc070a00000
> >> <1>[  154.846576] Mem abort info:
> >> <1>[  154.846635]   Exception class =3D DABT (current EL), IL =3D 32 b=
its
> >> <1>[  154.846737]   SET =3D 0, FnV =3D 0
> >> <1>[  154.846796]   EA =3D 0, S1PTW =3D 0
> >> <1>[  154.846859] Data abort info:
> >> <1>[  154.846913]   ISV =3D 0, ISS =3D 0x00000006
> >> <1>[  154.846983]   CM =3D 0, WnR =3D 0
> >> <1>[  154.847053] swapper pgtable: 4k pages, 39-bit VAs, pgd =3D fffff=
f8009df7000
> >> <1>[  154.847228] [ffffffc070a00000] *pgd=3D000000087fff5803, *pud=3D0=
00000087fff5803, *pmd=3D0000000000000000
> >> <0>[  154.847408] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> >> <4>[  154.847511] Modules linked in: nvs_led_test nvs_bmi160 nvs_cm321=
8 nvs_bh1730fvc nvi_bmpX80 nvi_ak89xx nvi_mpu cdc_acm uas lr388k7_ts imx268=
 imx318 imx204 imx274 imx185 lc898212 ov23850 ov10823 ov9281 ov5693 tc35884=
0 pca9570 nvs snd_soc_tegra_machine_driver_mobile lp855x_bl spidev input_cf=
boost pwm_tegra tegra_cryptodev tegra_se_nvhost tegra_se_elp tegra_se ghash=
_ce sha2_ce sha1_ce aes_ce_ccm cryptd nvgpu cpufreq_userspace snd_soc_tegra=
186_alt_dspk snd_soc_tegra186_alt_asrc snd_soc_tegra186_alt_arad snd_soc_te=
gra210_alt_ope snd_soc_tegra210_alt_mvc snd_soc_tegra210_alt_dmic snd_soc_t=
egra210_alt_amx snd_soc_tegra210_alt_adx snd_soc_tegra210_alt_afc snd_soc_t=
egra210_alt_mixer snd_soc_tegra210_alt_i2s snd_soc_tegra210_alt_sfc snd_soc=
_tegra210_alt_adsp snd_soc_tegra210_alt_admaif snd_soc_tegra210_alt_xbar
> >> <4>[  154.882606]  snd_soc_tegra_alt_utils snd_hda_tegra
> >> <4>[  154.888133] CPU: 2 PID: 8079 Comm: sh Not tainted 4.14.53-tegra-=
05132-g9c33465 #2
> >> <4>[  154.895983] Hardware name: e3360_1099 (DT)
> >> <4>[  154.900447] task: ffffffc7d62dda00 task.stack: ffffff800e2b0000
> >> <4>[  154.906502] PC is at scan_block+0x7c/0x148
> >> <4>[  154.911234] LR is at scan_block+0x78/0x148
> >> <4>[  154.915689] pc : [<ffffff8008271724>] lr : [<ffffff8008271720>] =
pstate: 804000c9
> >> <4>[  154.923290] sp : ffffff800e2b3b80
> >> <4>[  154.927228] x29: ffffff800e2b3b80 x28: ffffffc7d62dda00
> >> <4>[  154.932999] x27: ffffff8009aaa000 x26: ffffffc070c00000
> >> <4>[  154.938769] x25: 00000000000000c0 x24: ffffff8009d90608
> >> <4>[  154.944287] x23: ffffffc7dc6c6000 x22: ffffff8009d90000
> >> <4>[  154.950320] x21: ffffff8009aeb320 x20: ffffffc070a00ff9
> >> <4>[  154.955919] x19: ffffffc070a00000 x18: 00000000bec4c3f2
> >> <4>[  154.961438] x17: 0000002224777924 x16: ffffff80080bb0e0
> >> <4>[  154.967124] x15: 0000000000000000 x14: 0000000000000f75
> >> <4>[  154.973069] x13: 000fffffffffffff x12: ffffffbf1e9f4240
> >> <4>[  154.978670] x11: 0000000000000040 x10: 0000000000000ad0
> >> <4>[  154.984107] x9 : ffffff800e2b3ab0 x8 : ffffffc7d62de530
> >> <4>[  154.989958] x7 : 0000000780000000 x6 : 0000000000000018
> >> <4>[  154.995645] x5 : 0000000000000000 x4 : 0000000000000000
> >> <4>[  155.001245] x3 : ffffff8009aaa000 x2 : 00000047f6712000
> >> <4>[  155.006846] x1 : ffffffc7d1ae6900 x0 : 0000000000000000
> >>
> >> Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
> >> Signed-off-by: Prateek <prpatel@nvidia.com>
> >> ---
> >>   drivers/of/of_reserved_mem.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem=
.c
> >> index 1977ee0..ac8f377 100644
> >> --- a/drivers/of/of_reserved_mem.c
> >> +++ b/drivers/of/of_reserved_mem.c
> >> @@ -21,6 +21,7 @@
> >>   #include <linux/sort.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/memblock.h>
> >> +#include <linux/kmemleak.h>
> >>
> >>   #define MAX_RESERVED_REGIONS   32
> >>   static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> >> @@ -50,8 +51,10 @@ int __init __weak early_init_dt_alloc_reserved_memo=
ry_arch(phys_addr_t size,
> >>          }
> >>
> >>          *res_base =3D base;
> >> -       if (nomap)
> >> +       if (nomap) {
> >> +               kmemleak_no_scan(__va(base));
> >>                  return memblock_remove(base, size);
> > I'm curious how I can't find any other similar example in the kernel.
> > Please Cc some kmemleak folks.
> >
> > Perhaps we should be using memblock_mark_nomap() for nomap areas?
> >
> > Rob
>
> Sorry for this late reply.
>
> Yes, memblock_mark_nomap() can be used here but if I understand
> correctly, memblock_mark_nomap() is used to indicate marked parts of
> memory should not be covered by the kernel direct mapping and
> memblock_remove() here is doing that by removing a given memory from the
> "memblock.memory" list to prevent the memory from CPU accessing by the
> linear address. I am not 100% sure what will be the side effects of
> using memblock_mark_nomap(). Adding folks to help me here on
> MEMBLOCK_NOMAP and kmemleak.

I have no idea about your question: memblock_mark_nomap seems
reasonable though, but I think this is orthogonal to this patch, whose
main purpose is to add kmemleak_no_scan?

In any case, I tested both the original patch, and the hunk below on a
different platform (with some no-map reserved_memory as well), and
they fix the issue.

Tested-by: Nicolas Boichat <drinkcat@chromium.org>

> I checked and verified with following and I didn't find any errors on my
> local setup:
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1977ee0..f77cde0 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -50,8 +50,10 @@ int __init __weak
> early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>          }
>
>          *res_base =3D base;
> -       if (nomap)
> -               return memblock_remove(base, size);
> +       if (nomap) {
> +               kmemleak_no_scan(__va(base));
> +               return memblock_mark_nomap(base, size);
> +       }
>          return 0;
>   }
