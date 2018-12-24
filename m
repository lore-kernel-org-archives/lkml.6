Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96181C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB521773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftYwLhId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbeLXJp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:45:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39857 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLXJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:45:55 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so14694681itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biCQmdDY24vx8InW8AEFkECihgQ9z4WjVvSJR8Vj0zs=;
        b=ftYwLhIdQHSyhEAJ2jnewLdWgM8NMMiTBvSAIB1GkTYC63mlapxqhYl4bawctj+p0p
         5vdAwdvT55MiaiEgQQhKd4xxHdHz4P6Qo8ZPsaZ8zUdwSjiIWaByFMSAECOedFnM1CDM
         pG397hIPimUfTmmictKc1yQlZmnK9AsEXSNfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biCQmdDY24vx8InW8AEFkECihgQ9z4WjVvSJR8Vj0zs=;
        b=aV0AMKQt8bSns65VJ2sG6Eje1IGzm8U6gzLctMQNqyD4vK6Hx4tAhEbLYNgway75ny
         ao4Er8T3GCMgW320zoJsRBikbV2xH0cJqV0dgs94MhYW3FmtjomupCjCXqvbwXpgVDnP
         y8CI2Kz29mo0kSn7bmpwZN0LgyJytLpg+x1uzT4esqd437NMZYJtE3JvgNYaZDzXIKgR
         hqS5QLcR3yQqjLnevzPY1TMunVqEXN7dKUf76ThRKzKHkAaF/HY+YJfa2Dw/Ypx3FrVG
         IW1b5av6zlTCxe+3KVx+M1SmJCCEiRZOiulxSfxy3zNhBgLC9eaeWoPyNcCx+dcS5zwv
         tOvA==
X-Gm-Message-State: AA+aEWbMo8DqxWmRhS5MT43pflVZi2qp+by6XsBXH7VK06Z4Qmg8xYqn
        4Wrh81SaqoIWWsRT5JxDR8GGE64YYhv53qO7F14R8Q==
X-Google-Smtp-Source: AFSGD/WXkibwPgHAsFsg03CQBE9XcTnTLxgKrY3m9mCMAS5q0DnFbArFXWind5omClKtQ4GM84HdItION/iBv1OFxzc=
X-Received: by 2002:a24:710:: with SMTP id f16mr7199968itf.121.1545644753637;
 Mon, 24 Dec 2018 01:45:53 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Dec 2018 10:45:42 +0100
Message-ID: <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To:     Yueyi Li <liyueyi@live.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 at 08:40, Yueyi Li <liyueyi@live.com> wrote:
>
> When KASLR enaled(CONFIG_RANDOMIZE_BASE=y), the top 4K virtual
> address have chance to be mapped to physical address, but which
> is expected to leave room for ERR_PTR.
>
> Also, it might cause some other warparound issue when somewhere
> use the last memory page but no overflow check. Such as the last
> page compressed by LZO:
>
> [ 2738.034508] Unable to handle kernel NULL pointer dereference at virtual address 00000009
> [ 2738.034515] Mem abort info:
> [ 2738.034518]   Exception class = DABT (current EL), IL = 32 bits
> [ 2738.034520]   SET = 0, FnV = 0
> [ 2738.034523]   EA = 0, S1PTW = 0
> [ 2738.034524]   FSC = 5
> [ 2738.034526] Data abort info:
> [ 2738.034528]   ISV = 0, ISS = 0x00000005
> [ 2738.034530]   CM = 0, WnR = 0
> [ 2738.034533] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffff94cee000
> [ 2738.034535] [0000000000000009] *pgd=0000000000000000, *pud=0000000000000000
> ...
> [ 2738.034592] pc : lzo1x_1_do_compress+0x198/0x610
> [ 2738.034595] lr : lzo1x_1_compress+0x98/0x3d8
> [ 2738.034597] sp : ffffff801caa3470 pstate : 00c00145
> [ 2738.034598] x29: ffffff801caa3500 x28: 0000000000001000
> [ 2738.034601] x27: 0000000000001000 x26: fffffffffffff000
> [ 2738.034604] x25: ffffffff4ebc0000 x24: 0000000000000000
> [ 2738.034607] x23: 000000000000004c x22: fffffffffffff7b8
> [ 2738.034610] x21: ffffffff2e2ee0b3 x20: ffffffff2e2ee0bb
> [ 2738.034612] x19: 0000000000000fcc x18: fffffffffffff84a
> [ 2738.034615] x17: 00000000801b03d6 x16: 0000000000000782
> [ 2738.034618] x15: ffffffff2e2ee0bf x14: fffffffffffffff0
> [ 2738.034620] x13: 000000000000000f x12: 0000000000000020
> [ 2738.034623] x11: 000000001824429d x10: ffffffffffffffec
> [ 2738.034626] x9 : 0000000000000009 x8 : 0000000000000000
> [ 2738.034628] x7 : 0000000000000868 x6 : 0000000000000434
> [ 2738.034631] x5 : ffffffff4ebc0000 x4 : 0000000000000000
> [ 2738.034633] x3 : ffffff801caa3510 x2 : ffffffff2e2ee000
> [ 2738.034636] x1 : 0000000000000000 x0 : fffffffffffff000
> ...
> [ 2738.034717] Process kworker/u16:1 (pid: 8705, stack limit = 0xffffff801caa0000)
> [ 2738.034720] Call trace:
> [ 2738.034722]  lzo1x_1_do_compress+0x198/0x610
> [ 2738.034725]  lzo_compress+0x48/0x88
> [ 2738.034729]  crypto_compress+0x14/0x20
> [ 2738.034733]  zcomp_compress+0x2c/0x38
> [ 2738.034736]  zram_bvec_rw+0x3d0/0x860
> [ 2738.034738]  zram_rw_page+0x88/0xe0
> [ 2738.034742]  bdev_write_page+0x70/0xc0
> [ 2738.034745]  __swap_writepage+0x58/0x3f8
> [ 2738.034747]  swap_writepage+0x40/0x50
> [ 2738.034750]  shrink_page_list+0x4fc/0xe58
> [ 2738.034753]  reclaim_pages_from_list+0xa0/0x150
> [ 2738.034756]  reclaim_pte_range+0x18c/0x1f8
> [ 2738.034759]  __walk_page_range+0xf8/0x1e0
> [ 2738.034762]  walk_page_range+0xf8/0x130
> [ 2738.034765]  reclaim_task_anon+0xcc/0x168
> [ 2738.034767]  swap_fn+0x438/0x668
> [ 2738.034771]  process_one_work+0x1fc/0x460
> [ 2738.034773]  worker_thread+0x2d0/0x478
> [ 2738.034775]  kthread+0x110/0x120
> [ 2738.034778]  ret_from_fork+0x10/0x18
> [ 2738.034781] Code: 3800167f 54ffffa8 d100066f 14000031 (b9400131)
> [ 2738.034784] ---[ end trace 9b5cca106f0e54d1 ]---
> [ 2738.035473] Kernel panic - not syncing: Fatal exception
>
> in = 0xfffffffffffff000
> in_len = 4096
> ip = x9 = 0x0000000000000009 overflowed.
>
> Always leave room the last size of ARM64_MEMSTART_ALIGN region
> in linear region.
>
> Signed-off-by: liyueyi <liyueyi@live.com>
> ---
>  arch/arm64/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 0340e45..20fe11e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -439,7 +439,8 @@ void __init arm64_memblock_init(void)
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 extern u16 memstart_offset_seed;
>                 u64 range = linear_region_size -
> -                           (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +                          (memblock_end_of_DRAM() - memblock_start_of_DRAM()) -
> +                          ARM64_MEMSTART_ALIGN;
>
>                 /*
>                  * If the size of the linear region exceeds, by a sufficient

Does the following change fix your issue as well?

index 9b432d9fcada..9dcf0ff75a11 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
                 * memory spans, randomize the linear region as well.
                 */
                if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-                       range = range / ARM64_MEMSTART_ALIGN + 1;
+                       range /= ARM64_MEMSTART_ALIGN;
                        memstart_addr -= ARM64_MEMSTART_ALIGN *
                                         ((range * memstart_offset_seed) >> 16);
                }
