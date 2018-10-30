Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647E62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCX7lu23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647E62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ3UnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:43:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44932 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3UnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:43:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id n12so6967432qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBWYgkAFhXP2miiAliLFpNfxVwwZXcMKdsAzVr8E8vU=;
        b=FCX7lu232ekWcaZDbnTJAlm2r3SlOQoJtsI3jx39bG75aVjzSoFJjY6478xt3XolZl
         2LNkUPnnWe9DQCiHWnHTIKO4Mbgpa7iSUQSkmLU3nCxorJClYsu7Lx6bbHKToG2icWmb
         TynltDNwrMdFr/mN8Rx1AZJSaJZBnEDSShapo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HBWYgkAFhXP2miiAliLFpNfxVwwZXcMKdsAzVr8E8vU=;
        b=Fn+f4BdEiqhP+3eYehYCBh17GTkoI8u6Y1gk/H5Y7n9WFdiPfcPc5krr890kUovebp
         dX6RY2kkywoHTsWn92U5c/hOSkzPGSx2yWNPWh+tIeRAoLn4yA1kGRBw4urT9/Vnu/VU
         D/mXHqtN46L/ui0lrMgh3DxaFQvFTpsYUhaKosvD94AGSq+4iK/pmiIdEd+upC84AMt+
         0FXV9scWzlcFtBMDMug8hIfjOVEdYa2t5FMqYR8Agg5A/eFhwmyFQjtVjKWgoLbPhBv2
         NDVx1MPAUEVYLxxfaVCMX+b7k1hxD3tzMbAs5iV79aXAwRibNydXROOdmw3qT7nFw6es
         JeLA==
X-Gm-Message-State: AGRZ1gJokAmCJsgubPzQvY2MsFdzy1G89ovUtU8TMA3cWo7DNB0b0G7A
        SAUm2xuWCO02m0dVasthH5f0AQ==
X-Google-Smtp-Source: AJdET5d4uBF46z94/K1Y5eqFzIHl0YxG7TX9g6Wfzi5SgUT+LX+nQYIppiQBIoyrdDvEUueWiqqCdg==
X-Received: by 2002:a37:6cc3:: with SMTP id h186-v6mr15663896qkc.49.1540900191350;
        Tue, 30 Oct 2018 04:49:51 -0700 (PDT)
Received: from [192.168.1.100] ([216.244.219.111])
        by smtp.gmail.com with ESMTPSA id u13-v6sm19571439qtu.90.2018.10.30.04.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 04:49:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] arm64: kprobe: make page to RO mode when allocate it
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181030113850.31150-1-anders.roxell@linaro.org>
Date:   Tue, 30 Oct 2018 08:49:48 -0300
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAC371D3-7D52-49D5-BA99-9B90389F3197@linaro.org>
References: <20181030113850.31150-1-anders.roxell@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

> On 30 Oct 2018, at 08:38, Anders Roxell <anders.roxell@linaro.org> wrote:
>=20
> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuabl=
e pages")
> has successfully identified code that leaves a page with W+X
> permissions.
>=20
> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval=
____)/0xffff000000d90000
> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_=
page+0x410/0x420
> [    3.246141] Modules linked in:
> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-2=
0180928-00001-ge70ae259b853-dirty #62
> [    3.247008] Hardware name: linux,dummy-virt (DT)
> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    3.247623] pc : note_page+0x410/0x420
> [    3.247898] lr : note_page+0x410/0x420
> [    3.248071] sp : ffff00000804bcd0
> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
> [    3.252664] Call trace:
> [    3.252953]  note_page+0x410/0x420
> [    3.253186]  walk_pgd+0x12c/0x238
> [    3.253417]  ptdump_check_wx+0x68/0xf8
> [    3.253637]  mark_rodata_ro+0x68/0x98
> [    3.253847]  kernel_init+0x38/0x160
> [    3.254103]  ret_from_fork+0x10/0x18
>=20
> kprobes allocates a writable executable page with module_alloc() in
> order to store executable code.
> Reworked to that when allocate a page it sets mode RO. Inspired by
> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use tex=
t_poke()").
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Please remove these SOBs, Arnd and I provided input to this patch but you ar=
e the one sending it (sob does not assert authorship or anything like that, i=
t just asserts that the code in the patch was made available under a compati=
ble license)

Also, please add the acks you received from Masami and Laura.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
> 1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes=
/kprobes.c
> index 9b65132e789a..decf483b4153 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -23,7 +23,9 @@
> #include <linux/slab.h>
> #include <linux/stop_machine.h>
> #include <linux/sched/debug.h>
> +#include <linux/set_memory.h>
> #include <linux/stringify.h>
> +#include <linux/vmalloc.h>
> #include <asm/traps.h>
> #include <asm/ptrace.h>
> #include <asm/cacheflush.h>
> @@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> static void __kprobes
> post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>=20
> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +{
> +    void *addrs[1];
> +    u32 insns[1];
> +
> +    addrs[0] =3D (void *)addr;
> +    insns[0] =3D (u32)opcode;
> +
> +    return aarch64_insn_patch_text(addrs, insns, 1);
> +}
> +
> static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> {
>    /* prepare insn slot */
> -    p->ainsn.api.insn[0] =3D cpu_to_le32(p->opcode);
> +    patch_text(p->ainsn.api.insn, p->opcode);
>=20
>    flush_icache_range((uintptr_t) (p->ainsn.api.insn),
>               (uintptr_t) (p->ainsn.api.insn) +
> @@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>    return 0;
> }
>=20
> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +void *alloc_insn_page(void)
> {
> -    void *addrs[1];
> -    u32 insns[1];
> +    void *page;
>=20
> -    addrs[0] =3D (void *)addr;
> -    insns[0] =3D (u32)opcode;
> +    page =3D vmalloc_exec(PAGE_SIZE);
> +    if (page)
> +        set_memory_ro((unsigned long)page, 1);
>=20
> -    return aarch64_insn_patch_text(addrs, insns, 1);
> +    return page;
> }
>=20
> /* arm kprobe: install breakpoint in text */
> --=20
> 2.19.1
>=20
