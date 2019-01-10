Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26761C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E15206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfAJQtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:49:36 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:46791 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbfAJQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:49:35 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DA914201353427;
        Thu, 10 Jan 2019 17:49:23 +0100 (CET)
Subject: Re: General protection fault in `switch_mm_irqs_off()`
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
 <20190109211104.GG15665@zn.tnic>
 <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
 <20190110160054.GD17621@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <4de0b458-6028-3ab1-fef6-04c7fc440277@molgen.mpg.de>
Date:   Thu, 10 Jan 2019 17:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190110160054.GD17621@zn.tnic>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040907090603090101090106"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040907090603090101090106
Content-Type: multipart/mixed;
 boundary="------------F50DDD6653283D174A6F3EC7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F50DDD6653283D174A6F3EC7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Boris, dear Thomas,


On 01/10/19 17:00, Borislav Petkov wrote:
> On Thu, Jan 10, 2019 at 02:57:40PM +0100, Paul Menzel wrote:
>> Thank you very much. Indeed, the machine does not crash. I used Linus=E2=
=80=99
>> master branch for testing, and applied your patch on top. Please find
>> the full log attached.
>=20
>> 80.649: [    3.197107] Spectre V2 : spectre_v2_user_select_mitigation:=
 set X86_FEATURE_USE_IBPB
>=20
> This is amazing.
>=20
> Ok, next diff, same exercise. Thx.>=20
> ---
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/as=
m/nospec-branch.h
> index dad12b767ba0..528ef8336f5f 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -284,6 +284,12 @@ static inline void indirect_branch_prediction_barr=
ier(void)
>  {
>  	u64 val =3D PRED_CMD_IBPB;
> =20
> +	if (WARN_ON(boot_cpu_has(X86_FEATURE_USE_IBPB))) {
> +		pr_info("%s: c: %px, array: 0x%x\n",
> +			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
> +		return;
> +	}
> +
>  	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
>  }
> =20
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 8654b8b0c848..e818e5abe611 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -371,6 +371,9 @@ spectre_v2_user_select_mitigation(enum spectre_v2_m=
itigation_cmd v2_cmd)
>  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
>  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> =20
> +		pr_err("%s: set X86_FEATURE_USE_IBPB, c: %px, array: 0x%x\n",
> +			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
> +
>  		switch (cmd) {
>  		case SPECTRE_V2_USER_CMD_FORCE:
>  		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> index cb28e98a0659..8566737fa500 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -765,6 +765,9 @@ static void apply_forced_caps(struct cpuinfo_x86 *c=
)
>  		c->x86_capability[i] &=3D ~cpu_caps_cleared[i];
>  		c->x86_capability[i] |=3D cpu_caps_set[i];
>  	}
> +
> +	if (c =3D=3D &boot_cpu_data)
> +		pr_info("%s: c: %px, array: 0x%x\n", __func__, c, c->x86_capability[=
7]);
>  }
> =20
>  static void init_speculation_control(struct cpuinfo_x86 *c)
> @@ -778,6 +781,10 @@ static void init_speculation_control(struct cpuinf=
o_x86 *c)
>  	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>  		set_cpu_cap(c, X86_FEATURE_IBRS);
>  		set_cpu_cap(c, X86_FEATURE_IBPB);
> +
> +		pr_info("%s: X86_FEATURE_SPEC_CTRL: c: %px, array: 0x%x, CPUID: 0x%x=
\n",
> +			__func__, c, c->x86_capability[7], cpuid_edx(7));
> +
>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>  	}
> =20
> @@ -793,9 +800,13 @@ static void init_speculation_control(struct cpuinf=
o_x86 *c)
>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>  	}
> =20
> -	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
> +	if (cpu_has(c, X86_FEATURE_AMD_IBPB)) {
>  		set_cpu_cap(c, X86_FEATURE_IBPB);
> =20
> +		pr_info("%s: X86_FEATURE_AMD_IBPB: c: %px, array: 0x%x, CPUID: 0x%x\=
n",
> +			__func__, c, c->x86_capability[7], cpuid_ebx(0x80000008));
> +	}
> +
>  	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
>  		set_cpu_cap(c, X86_FEATURE_STIBP);
>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);

Please find the logs attached.


Kind regards,

Paul

--------------F50DDD6653283D174A6F3EC7
Content-Type: text/x-log;
 name="coreboot-ucode-updates-0x0600063e-linux-5.0-rc1+-more-debug-from-boris-spectre_v2_user-auto.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="coreboot-ucode-updates-0x0600063e-linux-5.0-rc1+-more-debug-";
 filename*1="from-boris-spectre_v2_user-auto.log"

[    0.000000] Linux version 5.0.0-rc1.mx64.236-00029-g3db1296abd46 (pmen=
zel@elcattivo.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Thu Jan 10 =
17:11:18 CET 2019
[    0.000000] Command line: BOOT_IMAGE=3D/boot/bzImage.test crashkernel=3D=
256M root=3DLABEL=3Droot ro console=3DttyS0,115200n8 console=3DttyS1,1152=
00n8 console=3Dtty0 init=3D/bin/systemd audit=3D0
[    0.000000] init_speculation_control: X86_FEATURE_AMD_IBPB: c: fffffff=
f8255d500, array: 0x4000104, CPUID: 0x1000
[    0.000000] apply_forced_caps: c: ffffffff8255d500, array: 0x4000104
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x18e/0x2c=
0 with crng_init=3D0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b7d97fff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000b7d98000-0x00000000b7ffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000b8000000-0x00000000bfffbfff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000bfffc000-0x00000000cfffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fcb00000-0x00000000fcb03fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb00fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002037ffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000002038000000-0x000000203fffffff] res=
erved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866ba200 01/0=
8/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2399.777 MHz processor
[    0.001963] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> re=
served
[    0.001965] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.010434] AGP: No AGP bridge found
[    0.010512] last_pfn =3D 0x2038000 max_arch_pfn =3D 0x400000000
[    0.010518] MTRR default type: write-back
[    0.010518] MTRR fixed ranges enabled:
[    0.010519]   00000-9FFFF write-back
[    0.010520]   A0000-BFFFF uncachable
[    0.010521]   C0000-FFFFF write-back
[    0.010522] MTRR variable ranges enabled:
[    0.010523]   0 base 0000C0000000 mask FFFFC0000000 uncachable
[    0.010524]   1 disabled
[    0.010525]   2 disabled
[    0.010525]   3 disabled
[    0.010525]   4 disabled
[    0.010526]   5 disabled
[    0.010526]   6 disabled
[    0.010527]   7 disabled
[    0.010528] TOM2: 0000002040000000 aka 132096M
[    0.012742] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.012899] last_pfn =3D 0xbfffc max_arch_pfn =3D 0x400000000
[    0.019366] Base memory trampoline at [(____ptrval____)] 99000 size 24=
576
[    0.019370] Using GB pages for direct mapping
[    0.019373] BRK [0x02c01000, 0x02c01fff] PGTABLE
[    0.019376] BRK [0x02c02000, 0x02c02fff] PGTABLE
[    0.019377] BRK [0x02c03000, 0x02c03fff] PGTABLE
[    0.019432] BRK [0x02c04000, 0x02c04fff] PGTABLE
[    0.019837] BRK [0x02c05000, 0x02c05fff] PGTABLE
[    0.019917] RAMDISK: [mem 0x375e7000-0x37aeafff]
[    0.019923] ACPI: Early table checksum verification disabled
[    0.019983] ACPI: RSDP 0x00000000000F6250 000024 (v02 COREv4)
[    0.019988] ACPI: XSDT 0x00000000B7D990E0 000094 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.019995] ACPI: FACP 0x00000000B7D9B930 0000F4 (v03 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020002] ACPI: DSDT 0x00000000B7D99280 0026A7 (v02 COREv4 COREBOOT =
00000001 INTL 20180810)
[    0.020006] ACPI: FACS 0x00000000B7D99240 000040
[    0.020009] ACPI: FACS 0x00000000B7D99240 000040
[    0.020011] ACPI: SSDT 0x00000000B7D9BA30 0039F2 (v02 COREv4 COREBOOT =
0000002A CORE 0000002A)
[    0.020015] ACPI: MCFG 0x00000000B7D9F430 00003C (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020019] ACPI: APIC 0x00000000B7D9F470 00015E (v02 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020022] ACPI: SRAT 0x00000000B7D9F5D0 000320 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020026] ACPI: SLIT 0x00000000B7D9F8F0 00003C (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020029] ACPI: SRAT 0x00000000B7D9F930 000320 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020033] ACPI: SLIT 0x00000000B7D9FC50 00003C (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020036] ACPI: SRAT 0x00000000B7D9FC90 000320 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020039] ACPI: SLIT 0x00000000B7D9FFB0 00003C (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020043] ACPI: SRAT 0x00000000B7D9FFF0 000320 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020047] ACPI: SLIT 0x00000000B7DA0310 00003C (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020050] ACPI: IVRS 0x00000000B7DA0350 0000B4 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020053] ACPI: HPET 0x00000000B7DA0410 000038 (v01 COREv4 COREBOOT =
00000000 CORE 00000000)
[    0.020062] ACPI: Local APIC address 0xfee00000
[    0.020109] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.020110] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.020112] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.020113] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.020114] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.020115] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.020116] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.020117] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.020118] SRAT: PXM 1 -> APIC 0x08 -> Node 1
[    0.020119] SRAT: PXM 1 -> APIC 0x09 -> Node 1
[    0.020120] SRAT: PXM 1 -> APIC 0x0a -> Node 1
[    0.020121] SRAT: PXM 1 -> APIC 0x0b -> Node 1
[    0.020122] SRAT: PXM 1 -> APIC 0x0c -> Node 1
[    0.020124] SRAT: PXM 1 -> APIC 0x0d -> Node 1
[    0.020125] SRAT: PXM 1 -> APIC 0x0e -> Node 1
[    0.020126] SRAT: PXM 1 -> APIC 0x0f -> Node 1
[    0.020127] SRAT: PXM 2 -> APIC 0x20 -> Node 2
[    0.020128] SRAT: PXM 2 -> APIC 0x21 -> Node 2
[    0.020129] SRAT: PXM 2 -> APIC 0x22 -> Node 2
[    0.020130] SRAT: PXM 2 -> APIC 0x23 -> Node 2
[    0.020131] SRAT: PXM 2 -> APIC 0x24 -> Node 2
[    0.020133] SRAT: PXM 2 -> APIC 0x25 -> Node 2
[    0.020134] SRAT: PXM 2 -> APIC 0x26 -> Node 2
[    0.020135] SRAT: PXM 2 -> APIC 0x27 -> Node 2
[    0.020136] SRAT: PXM 3 -> APIC 0x28 -> Node 3
[    0.020137] SRAT: PXM 3 -> APIC 0x29 -> Node 3
[    0.020138] SRAT: PXM 3 -> APIC 0x2a -> Node 3
[    0.020139] SRAT: PXM 3 -> APIC 0x2b -> Node 3
[    0.020140] SRAT: PXM 3 -> APIC 0x2c -> Node 3
[    0.020141] SRAT: PXM 3 -> APIC 0x2d -> Node 3
[    0.020142] SRAT: PXM 3 -> APIC 0x2e -> Node 3
[    0.020144] SRAT: PXM 3 -> APIC 0x2f -> Node 3
[    0.020147] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.020148] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.020150] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83fffffff]
[    0.020151] ACPI: SRAT: Node 1 PXM 1 [mem 0x840000000-0x103fffffff]
[    0.020153] ACPI: SRAT: Node 2 PXM 2 [mem 0x1040000000-0x183fffffff]
[    0.020154] ACPI: SRAT: Node 3 PXM 3 [mem 0x1840000000-0x203fffffff]
[    0.020158] NUMA: Initialized distance table, cnt=3D4
[    0.020161] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000=
-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.020163] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x10000000=
0-0x83fffffff] -> [mem 0x00000000-0x83fffffff]
[    0.020169] NODE_DATA(0) allocated [mem 0x83fffc000-0x83fffffff]
[    0.020174] NODE_DATA(1) allocated [mem 0x103fffc000-0x103fffffff]
[    0.020180] NODE_DATA(2) allocated [mem 0x183fffc000-0x183fffffff]
[    0.020186] NODE_DATA(3) allocated [mem 0x2037ff9000-0x2037ffcfff]
[    0.020199] Reserving 256MB of memory at 624MB for crashkernel (System=
 RAM: 130941MB)
[    0.020325] Zone ranges:
[    0.020326]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.020328]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.020330]   Normal   [mem 0x0000000100000000-0x0000002037ffffff]
[    0.020332] Movable zone start for each node
[    0.020333] Early memory node ranges
[    0.020334]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.020336]   node   0: [mem 0x0000000000100000-0x00000000b7d97fff]
[    0.020337]   node   0: [mem 0x00000000b8000000-0x00000000bfffbfff]
[    0.020338]   node   0: [mem 0x0000000100000000-0x000000083fffffff]
[    0.020340]   node   1: [mem 0x0000000840000000-0x000000103fffffff]
[    0.020341]   node   2: [mem 0x0000001040000000-0x000000183fffffff]
[    0.020342]   node   3: [mem 0x0000001840000000-0x0000002037ffffff]
[    0.020362] Zeroed struct page in unavailable ranges: 718 pages
[    0.020363] Initmem setup node 0 [mem 0x0000000000001000-0x000000083ff=
fffff]
[    0.020366] On node 0 totalpages: 8387890
[    0.020367]   DMA zone: 64 pages used for memmap
[    0.020368]   DMA zone: 21 pages reserved
[    0.020369]   DMA zone: 3998 pages, LIFO batch:0
[    0.021073]   DMA32 zone: 12215 pages used for memmap
[    0.021075]   DMA32 zone: 781716 pages, LIFO batch:63
[    0.045174]   Normal zone: 118784 pages used for memmap
[    0.045176]   Normal zone: 7602176 pages, LIFO batch:63
[    0.274434] Initmem setup node 1 [mem 0x0000000840000000-0x000000103ff=
fffff]
[    0.274438] On node 1 totalpages: 8388608
[    0.274440]   Normal zone: 131072 pages used for memmap
[    0.274440]   Normal zone: 8388608 pages, LIFO batch:63
[    0.536320] Initmem setup node 2 [mem 0x0000001040000000-0x000000183ff=
fffff]
[    0.536324] On node 2 totalpages: 8388608
[    0.536326]   Normal zone: 131072 pages used for memmap
[    0.536327]   Normal zone: 8388608 pages, LIFO batch:63
[    0.813326] Initmem setup node 3 [mem 0x0000001840000000-0x0000002037f=
fffff]
[    0.813330] On node 3 totalpages: 8355840
[    0.813332]   Normal zone: 130560 pages used for memmap
[    0.813333]   Normal zone: 8355840 pages, LIFO batch:63
[    1.077314] ACPI: PM-Timer IO Port: 0x820
[    1.077318] ACPI: Local APIC address 0xfee00000
[    1.077328] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    1.077341] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI=
 0-23
[    1.077344] IOAPIC[1]: apic_id 33, version 33, address 0xfce00000, GSI=
 24-55
[    1.077346] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    1.077348] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)=

[    1.077350] ACPI: IRQ0 used by override.
[    1.077351] ACPI: IRQ9 used by override.
[    1.077353] Using ACPI (MADT) for SMP configuration information
[    1.077355] ACPI: HPET id: 0x43538301 base: 0xfed00000
[    1.077360] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    1.077382] [mem 0xd0000000-0xfcafffff] available for PCI devices
[    1.077386] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1910969940391419 ns
[    1.269123] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:3=
2 nr_node_ids:4
[    1.272436] percpu: Embedded 42 pages/cpu @(____ptrval____) s133976 r8=
192 d29864 u262144
[    1.272447] pcpu-alloc: s133976 r8192 d29864 u262144 alloc=3D1*2097152=

[    1.272449] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [1] 08 09 10 11 12=
 13 14 15=20
[    1.272454] pcpu-alloc: [2] 16 17 18 19 20 21 22 23 [3] 24 25 26 27 28=
 29 30 31=20
[    1.272492] Built 4 zonelists, mobility grouping on.  Total pages: 329=
97158
[    1.272493] Policy zone: Normal
[    1.272496] Kernel command line: BOOT_IMAGE=3D/boot/bzImage.test crash=
kernel=3D256M root=3DLABEL=3Droot ro console=3DttyS0,115200n8 console=3Dt=
tyS1,115200n8 console=3Dtty0 init=3D/bin/systemd audit=3D0
[    1.272663] audit: disabled (until reboot)
[    1.272665] printk: log_buf_len individual max cpu contribution: 4096 =
bytes
[    1.272666] printk: log_buf_len total cpu_extra contributions: 126976 =
bytes
[    1.272667] printk: log_buf_len min size: 131072 bytes
[    1.272780] printk: log_buf_len: 262144 bytes
[    1.272782] printk: early log buf free: 118428(90%)
[    1.287985] AGP: Checking aperture...
[    1.296453] AGP: No AGP bridge found
[    1.296456] AGP: Node 0: aperture [bus addr 0xf8000000-0xfbffffff] (64=
MB)
[    1.296459] AGP: Node 1: aperture [bus addr 0xf8000000-0xfbffffff] (64=
MB)
[    1.296462] AGP: Node 2: aperture [bus addr 0xf8000000-0xfbffffff] (64=
MB)
[    1.296464] AGP: Node 3: aperture [bus addr 0xf8000000-0xfbffffff] (64=
MB)
[    2.026227] Memory: 131620760K/134083784K available (14340K kernel cod=
e, 1439K rwdata, 3520K rodata, 1576K init, 1132K bss, 2463024K reserved, =
0K cma-reserved)
[    2.026583] ftrace: allocating 41943 entries in 164 pages
[    2.056056] rcu: Hierarchical RCU implementation.
[    2.056059] rcu: 	RCU event tracing is enabled.
[    2.056061] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_id=
s=3D32.
[    2.056063] rcu: RCU calculated value of scheduler-enlistment delay is=
 100 jiffies.
[    2.056064] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D32
[    2.058660] NR_IRQS: 16640, nr_irqs: 1224, preallocated irqs: 16
[    2.059050] spurious 8259A interrupt: IRQ7.
[    2.064135] Console: colour VGA+ 80x25
[    2.089435] printk: console [tty0] enabled
[    3.102588] printk: console [ttyS0] enabled
[    3.106985] ACPI: Core revision 20181213
[    3.111330] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484873504 ns
[    3.120710] hpet clockevent registered
[    3.120726] APIC: Switch to symmetric I/O mode setup
[    3.125840] Switched APIC routing to physical flat.
[    3.131424] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D=
0
[    3.141721] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x229764d2b3e, max_idle_ns: 440795222549 ns
[    3.152481] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 4799.55 BogoMIPS (lpj=3D2399777)
[    3.153482] pid_max: default: 32768 minimum: 301
[    3.179696] Dentry cache hash table entries: 8388608 (order: 14, 67108=
864 bytes)
[    3.193462] Inode-cache hash table entries: 4194304 (order: 13, 335544=
32 bytes)
[    3.193935] Mount-cache hash table entries: 131072 (order: 8, 1048576 =
bytes)
[    3.194864] Mountpoint-cache hash table entries: 131072 (order: 8, 104=
8576 bytes)
[    3.195948] init_speculation_control: X86_FEATURE_AMD_IBPB: c: fffffff=
f8255d500, array: 0x4000104, CPUID: 0x1000
[    3.196483] apply_forced_caps: c: ffffffff8255d500, array: 0x5020104
[    3.197483] apply_forced_caps: c: ffffffff8255d500, array: 0x5020104
[    3.198490] apply_forced_caps: c: ffffffff8255d500, array: 0x5020104
[    3.199482] mce: CPU supports 7 MCE banks
[    3.200492] LVT offset 1 assigned for vector 0xf9
[    3.201487] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    3.202482] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB =
0
[    3.203483] Spectre V2 : Mitigation: Full AMD retpoline
[    3.204481] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
[    3.205482] Spectre V2 : spectre_v2_user_select_mitigation: set X86_FE=
ATURE_USE_IBPB
[    3.206482] Spectre V2 : spectre_v2_user_select_mitigation: set X86_FE=
ATURE_USE_IBPB, c: ffffffff8255d500, array: 0x52a3104
[    3.207482] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
[    3.208481] Spectre V2 : User space: Vulnerable
[    3.209483] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl and seccomp
[    3.211571] Freeing SMP alternatives memory: 44K
[    3.213480] smpboot: CPU0: AMD Opteron(tm) Processor 6278 (family: 0x1=
5, model: 0x1, stepping: 0x2)
[    3.213670] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    3.214484] ... version:                0
[    3.215482] ... bit width:              48
[    3.216482] ... generic registers:      6
[    3.217482] ... value mask:             0000ffffffffffff
[    3.218482] ... max period:             00007fffffffffff
[    3.219482] ... fixed-purpose events:   0
[    3.220482] ... event mask:             000000000000003f
[    3.221552] rcu: Hierarchical SRCU implementation.
[    3.222589] MCE: In-kernel MCE decoding enabled.
[    3.224850] smp: Bringing up secondary CPUs ...
[    3.225675] x86: Booting SMP configuration:
[    3.226482] .... node  #0, CPUs:        #1
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fa4f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 1.55 No irq handler for vector
[    3.248681]   #2
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fa8f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 2.55 No irq handler for vector
[    3.267979]   #3
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81facf080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 3.55 No irq handler for vector
[    3.287295]   #4
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fb0f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 4.55 No irq handler for vector
[    3.306627]   #5
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fb4f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 5.55 No irq handler for vector
[    3.325952]   #6
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fb8f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 6.55 No irq handler for vector
[    3.345285]   #7
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff888=
81fbcf080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 7.55 No irq handler for vector
[    3.364706] .... node  #1, CPUs:    #8
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fa0f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 8.55 No irq handler for vector
[    3.386131]   #9
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fa4f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 9.55 No irq handler for vector
[    3.405587]  #10
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fa8f080, array: 0x4000104, CPUID: 0x1000
[    1.085499] do_IRQ: 10.55 No irq handler for vector
[    3.425104]  #11
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01facf080, array: 0x4000104, CPUID: 0x1000
[    3.439590]  #12
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fb0f080, array: 0x4000104, CPUID: 0x1000
[    3.453813]  #13
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fb4f080, array: 0x4000104, CPUID: 0x1000
[    3.468541]  #14
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fb8f080, array: 0x4000104, CPUID: 0x1000
[    3.482809]  #15
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
01fbcf080, array: 0x4000104, CPUID: 0x1000
[    3.497539] .... node  #2, CPUs:   #16
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fa0f080, array: 0x4000104, CPUID: 0x1000
[    3.573940]  #17
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fa4f080, array: 0x4000104, CPUID: 0x1000
[    3.588501]  #18
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fa8f080, array: 0x4000104, CPUID: 0x1000
[    3.602860]  #19
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81facf080, array: 0x4000104, CPUID: 0x1000
[    3.617559]  #20
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fb0f080, array: 0x4000104, CPUID: 0x1000
[    3.631855]  #21
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fb4f080, array: 0x4000104, CPUID: 0x1000
[    3.646631]  #22
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fb8f080, array: 0x4000104, CPUID: 0x1000
[    3.660848]  #23
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff889=
81fbcf080, array: 0x4000104, CPUID: 0x1000
[    3.675726] .... node  #3, CPUs:   #24
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017c0f080, array: 0x4000104, CPUID: 0x1000
[    3.691933]  #25
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017c4f080, array: 0x4000104, CPUID: 0x1000
[    3.706787]  #26
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017c8f080, array: 0x4000104, CPUID: 0x1000
[    3.720847]  #27
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017ccf080, array: 0x4000104, CPUID: 0x1000
[    3.735827]  #28
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017d0f080, array: 0x4000104, CPUID: 0x1000
[    3.749841]  #29
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017d4f080, array: 0x4000104, CPUID: 0x1000
[    3.764853]  #30
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017d8f080, array: 0x4000104, CPUID: 0x1000
[    3.778846]  #31
[    1.085499] init_speculation_control: X86_FEATURE_AMD_IBPB: c: ffff88a=
017dcf080, array: 0x4000104, CPUID: 0x1000
[    3.793627] smp: Brought up 4 nodes, 32 CPUs
[    3.794484] smpboot: Max logical packages: 2
[    3.795487] smpboot: Total of 32 processors activated (153582.59 BogoM=
IPS)
[    3.805892] devtmpfs: initialized
[    3.807985] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275000 ns
[    3.808521] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    3.810771] xor: automatically using best checksumming function   avx =
     =20
[    3.811743] NET: Registered protocol family 16
[    3.812933] cpuidle: using governor ladder
[    3.817976] ACPI: bus type PCI registered
[    3.821547] PCI: MMCONFIG for domain 0000 [bus 00-1f] at [mem 0xc00000=
00-0xc1ffffff] (base 0xc0000000)
[    3.831485] PCI: MMCONFIG at [mem 0xc0000000-0xc1ffffff] reserved in E=
820
[    3.838492] PCI: Using configuration type 1 for base access
[    3.850012] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    3.873614] raid6: sse2x4   gen()  3207 MB/s
[    3.894603] raid6: sse2x4   xor()  2894 MB/s
[    3.915600] raid6: sse2x2   gen()  4406 MB/s
[    3.936601] raid6: sse2x2   xor()  5164 MB/s
[    3.957606] raid6: sse2x1   gen()  3234 MB/s
[    3.978600] raid6: sse2x1   xor()  3468 MB/s
[    3.983482] raid6: using algorithm sse2x2 gen() 4406 MB/s
[    3.988482] raid6: .... xor() 5164 MB/s, rmw enabled
[    3.994482] raid6: using ssse3x2 recovery algorithm
[    3.999688] ACPI: Added _OSI(Module Device)
[    4.003484] ACPI: Added _OSI(Processor Device)
[    4.008483] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.013482] ACPI: Added _OSI(Processor Aggregator Device)
[    4.018483] ACPI: Added _OSI(Linux-Dell-Video)
[    4.023483] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    4.028482] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    4.038816] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    4.047410] ACPI: Interpreter enabled
[    4.051502] ACPI: (supports S0 S1 S3 S5)
[    4.055484] ACPI: Using IOAPIC for interrupt routing
[    4.060518] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    4.070687] ACPI: Enabled 6 GPEs in block 00 to 1F
[    4.090497] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.098561] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.106557] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.114558] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.122555] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.130554] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.138555] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.146555] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14 15) =
*0, disabled.
[    4.164295] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-08])
[    4.170487] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    4.179521] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapabi=
lity LTR]
[    4.196602] acpi PNP0A08:00: host bridge window expanded to [io  0x000=
0-0x0cf7 window]; [io  0x0000-0x0cf7 window] ignored
[    4.207517] PCI host bridge to bus 0000:00
[    4.212485] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
[    4.219483] pci_bus 0000:00: root bus resource [io  0x0d00-0x5fff wind=
ow]
[    4.226483] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[    4.233483] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfcbff=
fff window]
[    4.241483] pci_bus 0000:00: root bus resource [mem 0xfcc00000-0xfceff=
fff window]
[    4.249484] pci_bus 0000:00: root bus resource [bus 00-08]
[    4.254494] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
[    4.254621] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    4.254737] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    4.254755] pci 0000:00:02.0: enabling Extended Tags
[    4.260508] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    4.260609] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    4.260627] pci 0000:00:04.0: enabling Extended Tags
[    4.265506] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    4.265606] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    4.265626] pci 0000:00:09.0: enabling Extended Tags
[    4.270506] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    4.270601] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    4.270621] pci 0000:00:0a.0: enabling Extended Tags
[    4.276507] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    4.276600] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    4.276619] pci 0000:00:0b.0: enabling Extended Tags
[    4.281511] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    4.281606] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    4.281624] pci 0000:00:0c.0: enabling Extended Tags
[    4.286506] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    4.286602] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    4.286622] pci 0000:00:0d.0: enabling Extended Tags
[    4.291505] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    4.291610] pci 0000:00:11.0: [1002:4394] type 00 class 0x010601
[    4.291632] pci 0000:00:11.0: reg 0x10: [io  0x5020-0x5027]
[    4.291642] pci 0000:00:11.0: reg 0x14: [io  0x5040-0x5043]
[    4.291651] pci 0000:00:11.0: reg 0x18: [io  0x5028-0x502f]
[    4.291661] pci 0000:00:11.0: reg 0x1c: [io  0x5044-0x5047]
[    4.291670] pci 0000:00:11.0: reg 0x20: [io  0x5000-0x500f]
[    4.291679] pci 0000:00:11.0: reg 0x24: [mem 0xfcb0d000-0xfcb0d3ff]
[    4.291801] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    4.291820] pci 0000:00:12.0: reg 0x10: [mem 0xfcb08000-0xfcb08fff]
[    4.291964] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    4.291982] pci 0000:00:12.1: reg 0x10: [mem 0xfcb09000-0xfcb09fff]
[    4.292126] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    4.292148] pci 0000:00:12.2: reg 0x10: [mem 0xfcb0e000-0xfcb0e0ff]
[    4.292518] pci 0000:00:12.2: supports D1 D2
[    4.292519] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    4.292619] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    4.292637] pci 0000:00:13.0: reg 0x10: [mem 0xfcb0a000-0xfcb0afff]
[    4.292780] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    4.292797] pci 0000:00:13.1: reg 0x10: [mem 0xfcb0b000-0xfcb0bfff]
[    4.292945] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    4.292966] pci 0000:00:13.2: reg 0x10: [mem 0xfcb0f000-0xfcb0f0ff]
[    4.293046] pci 0000:00:13.2: supports D1 D2
[    4.293048] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    4.293151] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    4.293317] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    4.293335] pci 0000:00:14.1: reg 0x10: [io  0x5030-0x5037]
[    4.293344] pci 0000:00:14.1: reg 0x14: [io  0x5048-0x504b]
[    4.293354] pci 0000:00:14.1: reg 0x18: [io  0x5038-0x503f]
[    4.293363] pci 0000:00:14.1: reg 0x1c: [io  0x504c-0x504f]
[    4.293373] pci 0000:00:14.1: reg 0x20: [io  0x5010-0x501f]
[    4.293395] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-=
0x01f7]
[    4.300483] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=

[    4.307483] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-=
0x0177]
[    4.314488] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=

[    4.321577] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    4.321603] pci 0000:00:14.2: reg 0x10: [mem 0xfcb04000-0xfcb07fff 64b=
it]
[    4.321603] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    4.321626] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    4.321782] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    4.321913] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    4.321932] pci 0000:00:14.5: reg 0x10: [mem 0xfcb0c000-0xfcb0cfff]
[    4.322083] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    4.322177] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    4.322258] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    4.322341] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    4.322431] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    4.322517] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    4.322604] pci 0000:00:19.0: [1022:1600] type 00 class 0x060000
[    4.322697] pci 0000:00:19.1: [1022:1601] type 00 class 0x060000
[    4.322783] pci 0000:00:19.2: [1022:1602] type 00 class 0x060000
[    4.322870] pci 0000:00:19.3: [1022:1603] type 00 class 0x060000
[    4.322962] pci 0000:00:19.4: [1022:1604] type 00 class 0x060000
[    4.323046] pci 0000:00:19.5: [1022:1605] type 00 class 0x060000
[    4.323136] pci 0000:00:1a.0: [1022:1600] type 00 class 0x060000
[    4.323234] pci 0000:00:1a.1: [1022:1601] type 00 class 0x060000
[    4.323321] pci 0000:00:1a.2: [1022:1602] type 00 class 0x060000
[    4.323406] pci 0000:00:1a.3: [1022:1603] type 00 class 0x060000
[    4.323499] pci 0000:00:1a.4: [1022:1604] type 00 class 0x060000
[    4.323591] pci 0000:00:1a.5: [1022:1605] type 00 class 0x060000
[    4.323680] pci 0000:00:1b.0: [1022:1600] type 00 class 0x060000
[    4.323775] pci 0000:00:1b.1: [1022:1601] type 00 class 0x060000
[    4.323860] pci 0000:00:1b.2: [1022:1602] type 00 class 0x060000
[    4.323945] pci 0000:00:1b.3: [1022:1603] type 00 class 0x060000
[    4.324037] pci 0000:00:1b.4: [1022:1604] type 00 class 0x060000
[    4.324118] pci 0000:00:1b.5: [1022:1605] type 00 class 0x060000
[    4.324241] pci 0000:00:02.0: PCI bridge to [bus 01]
[    4.329517] pci 0000:00:04.0: PCI bridge to [bus 02]
[    4.334538] pci 0000:03:00.0: [8086:10d3] type 00 class 0x020000
[    4.334576] pci 0000:03:00.0: reg 0x10: [mem 0xfc900000-0xfc91ffff]
[    4.334604] pci 0000:03:00.0: reg 0x18: [io  0x1000-0x101f]
[    4.334618] pci 0000:03:00.0: reg 0x1c: [mem 0xfc920000-0xfc923fff]
[    4.334751] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    4.334889] pci 0000:00:09.0: PCI bridge to [bus 03]
[    4.340486] pci 0000:00:09.0:   bridge window [io  0x1000-0x1fff]
[    4.340488] pci 0000:00:09.0:   bridge window [mem 0xfc900000-0xfc9fff=
ff]
[    4.340542] pci 0000:04:00.0: [8086:10d3] type 00 class 0x020000
[    4.340578] pci 0000:04:00.0: reg 0x10: [mem 0xfca00000-0xfca1ffff]
[    4.340606] pci 0000:04:00.0: reg 0x18: [io  0x2000-0x201f]
[    4.340620] pci 0000:04:00.0: reg 0x1c: [mem 0xfca20000-0xfca23fff]
[    4.340746] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    4.340879] pci 0000:00:0a.0: PCI bridge to [bus 04]
[    4.345485] pci 0000:00:0a.0:   bridge window [io  0x2000-0x2fff]
[    4.345487] pci 0000:00:0a.0:   bridge window [mem 0xfca00000-0xfcafff=
ff]
[    4.345523] pci 0000:00:0b.0: PCI bridge to [bus 05]
[    4.350521] pci 0000:00:0c.0: PCI bridge to [bus 06]
[    4.355526] pci 0000:07:00.0: [8086:10fb] type 00 class 0x020000
[    4.355544] pci 0000:07:00.0: reg 0x10: [mem 0xfcc00000-0xfcc7ffff 64b=
it pref]
[    4.355551] pci 0000:07:00.0: reg 0x18: [io  0x3000-0x301f]
[    4.355566] pci 0000:07:00.0: reg 0x20: [mem 0xfcd00000-0xfcd03fff 64b=
it pref]
[    4.355613] pci 0000:07:00.0: PME# supported from D0 D3hot
[    4.355635] pci 0000:07:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
[    4.355638] pci 0000:07:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000f=
ffff 64bit] (contains BAR0 for 64 VFs)
[    4.366494] pci 0000:07:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
[    4.366496] pci 0000:07:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000f=
ffff 64bit] (contains BAR3 for 64 VFs)
[    4.376598] pci 0000:07:00.0: 16.000 Gb/s available PCIe bandwidth, li=
mited by 5 GT/s x4 link at 0000:00:0d.0 (capable of 32.000 Gb/s with 5 GT=
/s x8 link)
[    4.390539] pci 0000:07:00.1: [8086:10fb] type 00 class 0x020000
[    4.390559] pci 0000:07:00.1: reg 0x10: [mem 0xfcc80000-0xfccfffff 64b=
it pref]
[    4.390566] pci 0000:07:00.1: reg 0x18: [io  0x3020-0x303f]
[    4.390579] pci 0000:07:00.1: reg 0x20: [mem 0xfcd04000-0xfcd07fff 64b=
it pref]
[    4.390579] pci 0000:07:00.1: PME# supported from D0 D3hot
[    4.390579] pci 0000:07:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
[    4.390579] pci 0000:07:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000f=
ffff 64bit] (contains BAR0 for 64 VFs)
[    4.400493] pci 0000:07:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
[    4.400495] pci 0000:07:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000f=
ffff 64bit] (contains BAR3 for 64 VFs)
[    4.410662] pci 0000:00:0d.0: PCI bridge to [bus 07]
[    4.416485] pci 0000:00:0d.0:   bridge window [io  0x3000-0x3fff]
[    4.416489] pci 0000:00:0d.0:   bridge window [mem 0xfcc00000-0xfcdfff=
ff 64bit pref]
[    4.416502] pci_bus 0000:08: extended config space not accessible
[    4.422512] pci 0000:08:01.0: [1a03:2000] type 00 class 0x030000
[    4.422534] pci 0000:08:01.0: reg 0x10: [mem 0xfc000000-0xfc7fffff]
[    4.422546] pci 0000:08:01.0: reg 0x14: [mem 0xfc800000-0xfc81ffff]
[    4.422558] pci 0000:08:01.0: reg 0x18: [io  0x4000-0x407f]
[    4.422639] pci 0000:08:01.0: supports D1 D2
[    4.422641] pci 0000:08:01.0: PME# supported from D0 D1 D2 D3hot D3col=
d
[    4.422704] pci 0000:08:02.0: [11c1:5811] type 00 class 0x0c0010
[    4.422726] pci 0000:08:02.0: reg 0x10: [mem 0xfc820000-0xfc820fff]
[    4.422726] pci 0000:08:02.0: supports D1 D2
[    4.422726] pci 0000:08:02.0: PME# supported from D0 D1 D2 D3hot
[    4.422726] pci 0000:00:14.4: PCI bridge to [bus 08] (subtractive deco=
de)
[    4.429485] pci 0000:00:14.4:   bridge window [io  0x4000-0x4fff]
[    4.429489] pci 0000:00:14.4:   bridge window [mem 0xfc000000-0xfc8fff=
ff]
[    4.429493] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 windo=
w] (subtractive decode)
[    4.429496] pci 0000:00:14.4:   bridge window [io  0x0d00-0x5fff windo=
w] (subtractive decode)
[    4.429497] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bff=
ff window] (subtractive decode)
[    4.429499] pci 0000:00:14.4:   bridge window [mem 0xfc000000-0xfcbfff=
ff window] (subtractive decode)
[    4.429501] pci 0000:00:14.4:   bridge window [mem 0xfcc00000-0xfcefff=
ff window] (subtractive decode)
[    4.430480] pci 0000:08:01.0: vgaarb: setting as boot VGA device
[    4.430480] pci 0000:08:01.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
[    4.446484] pci 0000:08:01.0: vgaarb: bridge control possible
[    4.452482] vgaarb: loaded
[    4.455582] SCSI subsystem initialized
[    4.459730] libata version 3.00 loaded.
[    4.459730] ACPI: bus type USB registered
[    4.463506] usbcore: registered new interface driver usbfs
[    4.469495] usbcore: registered new interface driver hub
[    4.475473] usbcore: registered new device driver usb
[    4.480507] pps_core: LinuxPPS API ver. 1 registered
[    4.485482] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[    4.494486] PTP clock support registered
[    4.499337] EDAC MC: Ver: 3.0.0
[    4.502671] Advanced Linux Sound Architecture Driver Initialized.
[    4.508500] PCI: Using ACPI for IRQ routing
[    4.513804] PCI: pci_cache_line_size set to 64 bytes
[    4.513892] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    4.513894] e820: reserve RAM buffer [mem 0xb7d98000-0xb7ffffff]
[    4.513895] e820: reserve RAM buffer [mem 0xbfffc000-0xbfffffff]
[    4.514347] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    4.519484] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    4.527745] clocksource: Switched to clocksource tsc-early
[    4.579411] VFS: Disk quotas dquot_6.6.0
[    4.583525] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    4.590617] FS-Cache: Loaded
[    4.593734] CacheFiles: Loaded
[    4.596947] pnp: PnP ACPI init
[    4.600497] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)=

[    4.600549] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 PNP030b =
(active)
[    4.600642] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)=

[    4.600691] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)=

[    4.600760] pnp: PnP ACPI: found 4 devices
[    4.611728] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
[    4.620876] pci 0000:00:02.0: bridge window [io  0x1000-0x0fff] to [bu=
s 01] add_size 1000
[    4.620879] pci 0000:00:02.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    4.620882] pci 0000:00:02.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 01] add_size 200000 add_align 100000
[    4.620887] pci 0000:00:04.0: bridge window [io  0x1000-0x0fff] to [bu=
s 02] add_size 1000
[    4.620890] pci 0000:00:04.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    4.620892] pci 0000:00:04.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 02] add_size 200000 add_align 100000
[    4.620898] pci 0000:00:09.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    4.620904] pci 0000:00:0a.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    4.620910] pci 0000:00:0b.0: bridge window [io  0x1000-0x0fff] to [bu=
s 05] add_size 1000
[    4.620913] pci 0000:00:0b.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 05] add_size 200000 add_align 100000
[    4.620915] pci 0000:00:0b.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 05] add_size 200000 add_align 100000
[    4.620921] pci 0000:00:0c.0: bridge window [io  0x1000-0x0fff] to [bu=
s 06] add_size 1000
[    4.620924] pci 0000:00:0c.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 06] add_size 200000 add_align 100000
[    4.620926] pci 0000:00:0c.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 06] add_size 200000 add_align 100000
[    4.620936] pci 0000:00:0d.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 07] add_size 800000 add_align 100000
[    4.620964] pci 0000:00:02.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.627811] pci 0000:00:02.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.635035] pci 0000:00:02.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.642920] pci 0000:00:02.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.651179] pci 0000:00:04.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.658027] pci 0000:00:04.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.665231] pci 0000:00:04.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.673117] pci 0000:00:04.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.681354] pci 0000:00:09.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.689237] pci 0000:00:09.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.697476] pci 0000:00:0a.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.705369] pci 0000:00:0a.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.713603] pci 0000:00:0b.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.720449] pci 0000:00:0b.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.727646] pci 0000:00:0b.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.735534] pci 0000:00:0b.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.743767] pci 0000:00:0c.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.750631] pci 0000:00:0c.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.757837] pci 0000:00:0c.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.765748] pci 0000:00:0c.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.774009] pci 0000:00:0d.0: BAR 14: no space for [mem size 0x0080000=
0]
[    4.780863] pci 0000:00:0d.0: BAR 14: failed to assign [mem size 0x008=
00000]
[    4.788086] pci 0000:00:02.0: BAR 13: no space for [io  size 0x1000]
[    4.794593] pci 0000:00:02.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.801442] pci 0000:00:04.0: BAR 13: no space for [io  size 0x1000]
[    4.807941] pci 0000:00:04.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.814807] pci 0000:00:0b.0: BAR 13: no space for [io  size 0x1000]
[    4.821332] pci 0000:00:0b.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.828188] pci 0000:00:0c.0: BAR 13: no space for [io  size 0x1000]
[    4.834689] pci 0000:00:0c.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.841542] pci 0000:00:0d.0: BAR 14: no space for [mem size 0x0080000=
0]
[    4.848391] pci 0000:00:0d.0: BAR 14: failed to assign [mem size 0x008=
00000]
[    4.855597] pci 0000:00:0c.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.862452] pci 0000:00:0c.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.869657] pci 0000:00:0c.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.877542] pci 0000:00:0c.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.885778] pci 0000:00:0c.0: BAR 13: no space for [io  size 0x1000]
[    4.892301] pci 0000:00:0c.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.899151] pci 0000:00:0b.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.906006] pci 0000:00:0b.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.913211] pci 0000:00:0b.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.921097] pci 0000:00:0b.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.929331] pci 0000:00:0b.0: BAR 13: no space for [io  size 0x1000]
[    4.935832] pci 0000:00:0b.0: BAR 13: failed to assign [io  size 0x100=
0]
[    4.942709] pci 0000:00:0a.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.950620] pci 0000:00:0a.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.958853] pci 0000:00:09.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.966767] pci 0000:00:09.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    4.975027] pci 0000:00:04.0: BAR 14: no space for [mem size 0x0020000=
0]
[    4.981882] pci 0000:00:04.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    4.989103] pci 0000:00:04.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    4.996990] pci 0000:00:04.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    5.005227] pci 0000:00:04.0: BAR 13: no space for [io  size 0x1000]
[    5.011733] pci 0000:00:04.0: BAR 13: failed to assign [io  size 0x100=
0]
[    5.018582] pci 0000:00:02.0: BAR 14: no space for [mem size 0x0020000=
0]
[    5.025437] pci 0000:00:02.0: BAR 14: failed to assign [mem size 0x002=
00000]
[    5.032642] pci 0000:00:02.0: BAR 15: no space for [mem size 0x0020000=
0 64bit pref]
[    5.040528] pci 0000:00:02.0: BAR 15: failed to assign [mem size 0x002=
00000 64bit pref]
[    5.048762] pci 0000:00:02.0: BAR 13: no space for [io  size 0x1000]
[    5.055269] pci 0000:00:02.0: BAR 13: failed to assign [io  size 0x100=
0]
[    5.062120] pci 0000:00:02.0: PCI bridge to [bus 01]
[    5.067235] pci 0000:00:04.0: PCI bridge to [bus 02]
[    5.072348] pci 0000:00:09.0: PCI bridge to [bus 03]
[    5.077459] pci 0000:00:09.0:   bridge window [io  0x1000-0x1fff]
[    5.083701] pci 0000:00:09.0:   bridge window [mem 0xfc900000-0xfc9fff=
ff]
[    5.090644] pci 0000:00:0a.0: PCI bridge to [bus 04]
[    5.095758] pci 0000:00:0a.0:   bridge window [io  0x2000-0x2fff]
[    5.102007] pci 0000:00:0a.0:   bridge window [mem 0xfca00000-0xfcafff=
ff]
[    5.108957] pci 0000:00:0b.0: PCI bridge to [bus 05]
[    5.114074] pci 0000:00:0c.0: PCI bridge to [bus 06]
[    5.119205] pci 0000:07:00.0: BAR 7: no space for [mem size 0x00100000=
 64bit]
[    5.126508] pci 0000:07:00.0: BAR 7: failed to assign [mem size 0x0010=
0000 64bit]
[    5.134223] pci 0000:07:00.0: BAR 10: no space for [mem size 0x0010000=
0 64bit]
[    5.141677] pci 0000:07:00.0: BAR 10: failed to assign [mem size 0x001=
00000 64bit]
[    5.149479] pci 0000:07:00.1: BAR 7: no space for [mem size 0x00100000=
 64bit]
[    5.156769] pci 0000:07:00.1: BAR 7: failed to assign [mem size 0x0010=
0000 64bit]
[    5.164509] pci 0000:07:00.1: BAR 10: no space for [mem size 0x0010000=
0 64bit]
[    5.171966] pci 0000:07:00.1: BAR 10: failed to assign [mem size 0x001=
00000 64bit]
[    5.179765] pci 0000:07:00.1: BAR 10: no space for [mem size 0x0010000=
0 64bit]
[    5.187243] pci 0000:07:00.1: BAR 10: failed to assign [mem size 0x001=
00000 64bit]
[    5.195045] pci 0000:07:00.1: BAR 7: no space for [mem size 0x00100000=
 64bit]
[    5.202331] pci 0000:07:00.1: BAR 7: failed to assign [mem size 0x0010=
0000 64bit]
[    5.210047] pci 0000:07:00.0: BAR 10: no space for [mem size 0x0010000=
0 64bit]
[    5.217507] pci 0000:07:00.0: BAR 10: failed to assign [mem size 0x001=
00000 64bit]
[    5.225301] pci 0000:07:00.0: BAR 7: no space for [mem size 0x00100000=
 64bit]
[    5.232592] pci 0000:07:00.0: BAR 7: failed to assign [mem size 0x0010=
0000 64bit]
[    5.240305] pci 0000:00:0d.0: PCI bridge to [bus 07]
[    5.245412] pci 0000:00:0d.0:   bridge window [io  0x3000-0x3fff]
[    5.251653] pci 0000:00:0d.0:   bridge window [mem 0xfcc00000-0xfcdfff=
ff 64bit pref]
[    5.259629] pci 0000:00:14.4: PCI bridge to [bus 08]
[    5.264740] pci 0000:00:14.4:   bridge window [io  0x4000-0x4fff]
[    5.270982] pci 0000:00:14.4:   bridge window [mem 0xfc000000-0xfc8fff=
ff]
[    5.277944] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    5.277946] pci_bus 0000:00: resource 5 [io  0x0d00-0x5fff window]
[    5.277948] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    5.277950] pci_bus 0000:00: resource 7 [mem 0xfc000000-0xfcbfffff win=
dow]
[    5.277951] pci_bus 0000:00: resource 8 [mem 0xfcc00000-0xfcefffff win=
dow]
[    5.277954] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    5.277956] pci_bus 0000:03: resource 1 [mem 0xfc900000-0xfc9fffff]
[    5.277958] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    5.277959] pci_bus 0000:04: resource 1 [mem 0xfca00000-0xfcafffff]
[    5.277961] pci_bus 0000:07: resource 0 [io  0x3000-0x3fff]
[    5.277963] pci_bus 0000:07: resource 2 [mem 0xfcc00000-0xfcdfffff 64b=
it pref]
[    5.277965] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    5.277966] pci_bus 0000:08: resource 1 [mem 0xfc000000-0xfc8fffff]
[    5.277968] pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
[    5.277970] pci_bus 0000:08: resource 5 [io  0x0d00-0x5fff window]
[    5.277971] pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    5.277973] pci_bus 0000:08: resource 7 [mem 0xfc000000-0xfcbfffff win=
dow]
[    5.277974] pci_bus 0000:08: resource 8 [mem 0xfcc00000-0xfcefffff win=
dow]
[    5.278118] NET: Registered protocol family 2
[    5.283023] tcp_listen_portaddr_hash hash table entries: 65536 (order:=
 8, 1048576 bytes)
[    5.291920] TCP established hash table entries: 524288 (order: 10, 419=
4304 bytes)
[    5.301258] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[    5.308447] TCP: Hash tables configured (established 524288 bind 65536=
)
[    5.315390] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    5.322632] UDP-Lite hash table entries: 65536 (order: 9, 2097152 byte=
s)
[    5.331584] pci 0000:08:01.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
[    5.340169] PCI: CLS 64 bytes, default 64
[    5.340232] Trying to unpack rootfs image as initramfs...
[    5.449049] Freeing initrd memory: 5136K
[    5.494133] iommu: Adding device 0000:00:11.0 to group 0
[    5.500095] iommu: Adding device 0000:00:12.0 to group 1
[    5.505580] iommu: Adding device 0000:00:12.1 to group 1
[    5.511064] iommu: Adding device 0000:00:12.2 to group 1
[    5.517042] iommu: Adding device 0000:00:13.0 to group 2
[    5.522538] iommu: Adding device 0000:00:13.1 to group 2
[    5.528025] iommu: Adding device 0000:00:13.2 to group 2
[    5.533943] iommu: Adding device 0000:00:14.0 to group 3
[    5.539901] iommu: Adding device 0000:00:14.1 to group 4
[    5.545846] iommu: Adding device 0000:00:14.2 to group 5
[    5.551815] iommu: Adding device 0000:00:14.3 to group 6
[    5.559104] iommu: Adding device 0000:00:14.4 to group 7
[    5.565056] iommu: Adding device 0000:00:14.5 to group 8
[    5.571015] iommu: Adding device 0000:03:00.0 to group 9
[    5.576939] iommu: Adding device 0000:04:00.0 to group 10
[    5.582984] iommu: Adding device 0000:07:00.0 to group 11
[    5.588997] iommu: Adding device 0000:07:00.1 to group 12
[    5.594554] iommu: Adding device 0000:08:01.0 to group 7
[    5.600020] iommu: Adding device 0000:08:02.0 to group 7
[    5.645039] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    5.650645] AMD-Vi: Lazy IO/TLB flushing enabled
[    5.657994] amd_uncore: AMD NB counters detected
[    5.663713] LVT offset 0 assigned for vector 0x400
[    5.669080] perf: AMD IBS detected (0x000000ff)
[    5.674935] workingset: timestamp_bits=3D40 max_order=3D25 bucket_orde=
r=3D0
[    5.682175] SGI XFS with ACLs, security attributes, realtime, no debug=
 enabled
[    5.691910] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 250)
[    5.699693] io scheduler mq-deadline registered
[    5.704371] io scheduler kyber registered
[    5.709201] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    5.715123] pcieport 0000:00:04.0: can't derive routing for PCI INT A
[    5.721717] pcieport 0000:00:04.0: PCI INT A: no GSI
[    5.726875] pcieport 0000:00:04.0: Signaling PME with IRQ 28
[    5.732857] pcieport 0000:00:09.0: Signaling PME with IRQ 30
[    5.738848] pcieport 0000:00:0a.0: Signaling PME with IRQ 32
[    5.744826] pcieport 0000:00:0b.0: Signaling PME with IRQ 33
[    5.750803] pcieport 0000:00:0c.0: Signaling PME with IRQ 34
[    5.756779] pcieport 0000:00:0d.0: Signaling PME with IRQ 35
[    5.762714] IPMI message handler: version 39.2
[    5.767303] ipmi device interface
[    5.770767] ipmi_si: IPMI System Interface driver
[    5.775662] ipmi_si: Unable to find any System Interface(s)
[    5.781380] IPMI Watchdog: driver initialized
[    5.785875] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IP=
MI Powerdown via sys_reboot
[    5.795102] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0C:00/input/input0
[    5.803708] ACPI: Power Button [PWRB]
[    5.807564] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input1
[    5.815204] ACPI: Power Button [PWRF]
[    5.821860] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    5.849022] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
[    5.877345] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200=
) is a 16550A
[    5.885454] lp: driver loaded but no devices found
[    5.890726] Linux agpgart interface v0.103
[    5.903965] brd: module loaded
[    5.913281] loop: module loaded
[    5.932532] drbd: initialized. Version: 8.4.11 (api:1/proto:86-101)
[    5.938999] drbd: built-in
[    5.941851] drbd: registered as block device major 147
[    5.947262] Uniform Multi-Platform E-IDE driver
[    5.952254] ide_generic: please use "probe_mask=3D0x3f" module paramet=
er for probing all legacy ISA IDE ports
[    5.962255] ide-gd driver 1.18
[    5.965475] ide-cd driver 5.00
[    5.969003] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 =
EST 2006)
[    5.976810] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST =
2006)
[    5.983944] megasas: 07.707.50.00-rc1
[    5.987777] mpt3sas version 27.101.00.00 loaded
[    5.993185] ahci 0000:00:11.0: version 3.0
[    5.993414] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps =
0x3f impl SATA mode
[    6.001861] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led clo pmp =
pio slum part ccc=20
[    6.011078] scsi host0: ahci
[    6.014656] scsi host1: ahci
[    6.017919] scsi host2: ahci
[    6.021239] scsi host3: ahci
[    6.024554] scsi host4: ahci
[    6.027878] scsi host5: ahci
[    6.030999] ata1: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
100 irq 22
[    6.038662] ata2: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
180 irq 22
[    6.046305] ata3: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
200 irq 22
[    6.053932] ata4: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
280 irq 22
[    6.061625] ata5: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
300 irq 22
[    6.069292] ata6: SATA max UDMA/133 abar m1024@0xfcb0d000 port 0xfcb0d=
380 irq 22
[    6.078412] scsi host6: pata_atiixp
[    6.082475] scsi host7: pata_atiixp
[    6.086206] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x5010 i=
rq 14
[    6.093326] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x5018 i=
rq 15
[    6.100886] tun: Universal TUN/TAP device driver, 1.6
[    6.106477] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bn=
x2x 1.712.30-0 (2014/02/10)
[    6.116029] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    6.122285] e100: Copyright(c) 1999-2006 Intel Corporation
[    6.127943] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k=
8-NAPI
[    6.135183] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    6.141131] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    6.147144] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    6.153391] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) =
set to dynamic conservative mode
[    6.218779] e1000e 0000:03:00.0 0000:03:00.0 (uninitialized): register=
ed PHC clock
[    6.280430] e1000e 0000:03:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 2=
0:cf:30:4e:1d:5c
[    6.288651] e1000e 0000:03:00.0 eth0: Intel(R) PRO/1000 Network Connec=
tion
[    6.295758] e1000e 0000:03:00.0 eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0=
FF
[    6.302936] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) =
set to dynamic conservative mode
[    6.367665] e1000e 0000:04:00.0 0000:04:00.0 (uninitialized): register=
ed PHC clock
[    6.391233] ata5: SATA link down (SStatus 0 SControl 300)
[    6.396821] ata6: SATA link down (SStatus 0 SControl 300)
[    6.402442] ata3: SATA link down (SStatus 0 SControl 300)
[    6.439446] e1000e 0000:04:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 2=
0:cf:30:4e:1d:3e
[    6.447665] e1000e 0000:04:00.0 eth1: Intel(R) PRO/1000 Network Connec=
tion
[    6.454785] e1000e 0000:04:00.0 eth1: MAC: 3, PHY: 8, PBA No: FFFFFF-0=
FF
[    6.461704] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.=
4.0-k
[    6.468822] igb: Copyright (c) 2007-2014 Intel Corporation.
[    6.474566] igbvf: Intel(R) Gigabit Virtual Function Network Driver - =
version 2.4.0-k
[    6.482704] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    6.488829] sky2: driver version 1.30
[    6.492872] Fusion MPT base driver 3.04.20
[    6.497115] Copyright (c) 1999-2008 LSI Corporation
[    6.502161] Fusion MPT SPI Host driver 3.04.20
[    6.506805] Fusion MPT FC Host driver 3.04.20
[    6.511324] Fusion MPT SAS Host driver 3.04.20
[    6.515936] Fusion MPT misc device (ioctl) driver 3.04.20
[    6.521725] mptctl: Registered with Fusion MPT base driver
[    6.527353] mptctl: /dev/mptctl @ (major,minor=3D10,220)
[    6.532672] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[    6.539349] ehci-pci: EHCI PCI platform driver
[    6.544066] ehci-pci 0000:00:12.2: EHCI Host Controller
[    6.549454] ehci-pci 0000:00:12.2: new USB bus registered, assigned bu=
s number 1
[    6.557115] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3=
 EHCI dummy qh workaround
[    6.566073] ehci-pci 0000:00:12.2: debug port 1
[    6.570829] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.570865] ehci-pci 0000:00:12.2: irq 17, io mem 0xfcb0e000
[    6.577273] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.589369] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.589675] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    6.596054] ata2.00: ATA-8: HGST HDN724030ALE640, MJ8OA5E0, max UDMA/1=
33
[    6.601877] hub 1-0:1.0: USB hub found
[    6.608519] ata2.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 32)=
, AA
[    6.608527] ata1.00: ATA-7: Hitachi HUA721010KLA330, GKAOA70M, max UDM=
A/133
[    6.612461] hub 1-0:1.0: 6 ports detected
[    6.619515] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32)=
, AA
[    6.619884] ata4.00: ATA-8: HGST HDN724030ALE640, MJ8OA5E0, max UDMA/1=
33
[    6.627108] ehci-pci 0000:00:13.2: EHCI Host Controller
[    6.630889] ata4.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 32)=
, AA
[    6.631231] ata2.00: configured for UDMA/133
[    6.637941] ehci-pci 0000:00:13.2: new USB bus registered, assigned bu=
s number 2
[    6.644807] ata1.00: configured for UDMA/133
[    6.650169] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3=
 EHCI dummy qh workaround
[    6.657527] ata4.00: configured for UDMA/133
[    6.661676] ehci-pci 0000:00:13.2: debug port 1
[    6.691825] ehci-pci 0000:00:13.2: irq 19, io mem 0xfcb0f000
[    6.698616] tsc: Refined TSC clocksource calibration: 2400.028 MHz
[    6.704734] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    6.705006] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2=
298520eaa9, max_idle_ns: 440795297870 ns
[    6.711077] hub 2-0:1.0: USB hub found
[    6.725150] clocksource: Switched to clocksource tsc
[    6.725193] hub 2-0:1.0: 6 ports detected
[    6.734839] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.741224] ohci-pci: OHCI PCI platform driver
[    6.745920] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    6.751674] ohci-pci 0000:00:12.0: new USB bus registered, assigned bu=
s number 3
[    6.759344] ohci-pci 0000:00:12.0: irq 16, io mem 0xfcb08000
[    6.820860] hub 3-0:1.0: USB hub found
[    6.824779] hub 3-0:1.0: 3 ports detected
[    6.829229] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    6.834959] ohci-pci 0000:00:12.1: new USB bus registered, assigned bu=
s number 4
[    6.844042] ohci-pci 0000:00:12.1: irq 16, io mem 0xfcb09000
[    6.905851] hub 4-0:1.0: USB hub found
[    6.909780] hub 4-0:1.0: 3 ports detected
[    6.914233] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    6.919961] ohci-pci 0000:00:13.0: new USB bus registered, assigned bu=
s number 5
[    6.927725] ohci-pci 0000:00:13.0: irq 18, io mem 0xfcb0a000
[    6.989844] hub 5-0:1.0: USB hub found
[    6.993759] hub 5-0:1.0: 3 ports detected
[    6.998169] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    7.003906] ohci-pci 0000:00:13.1: new USB bus registered, assigned bu=
s number 6
[    7.011561] ohci-pci 0000:00:13.1: irq 18, io mem 0xfcb0b000
[    7.072849] hub 6-0:1.0: USB hub found
[    7.076778] hub 6-0:1.0: 3 ports detected
[    7.081191] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    7.086925] ohci-pci 0000:00:14.5: new USB bus registered, assigned bu=
s number 7
[    7.094643] ohci-pci 0000:00:14.5: irq 18, io mem 0xfcb0c000
[    7.155845] hub 7-0:1.0: USB hub found
[    7.159778] hub 7-0:1.0: 2 ports detected
[    7.164078] uhci_hcd: USB Universal Host Controller Interface driver
[    7.170812] usbcore: registered new interface driver usb-storage
[    7.176996] usbcore: registered new interface driver ftdi_sio
[    7.182902] usbserial: USB Serial support registered for FTDI USB Seri=
al Device
[    7.190531] usbcore: registered new interface driver omninet
[    7.196375] usbserial: USB Serial support registered for ZyXEL - omni.=
net lcd plus usb
[    7.204673] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 ir=
q 1
[    7.211641] i8042: PNP: PS/2 appears to have AUX port disabled, if thi=
s is incorrect please boot with i8042.nopnp
[    7.222909] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.228334] rtc_cmos 00:00: RTC can wake from S4
[    7.233598] rtc_cmos 00:00: registered as rtc0
[    7.238263] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpe=
t irqs
[    7.245732] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, =
revision 0
[    7.253402] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller =
at 0xb20
[    7.261059] IR NEC protocol handler initialized
[    7.264057] input: AT Translated Set 2 keyboard as /devices/platform/i=
8042/serio0/input/input2
[    7.265770] IR RC5(x/sz) protocol handler initialized
[    7.279837] IR RC6 protocol handler initialized
[    7.284512] IR JVC protocol handler initialized
[    7.289216] IR Sony protocol handler initialized
[    7.293982] IR SANYO protocol handler initialized
[    7.298836] IR Sharp protocol handler initialized
[    7.303680] IR MCE Keyboard/mouse protocol handler initialized
[    7.309663] IR XMP protocol handler initialized
[    7.314358] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    7.320114] iTCO_vendor_support: vendor-support=3D0
[    7.325003] nv_tco: NV TCO WatchDog Timer Driver v0.01
[    7.331140] EDAC amd64: Node 0: DRAM ECC enabled.
[    7.335995] EDAC amd64: F15h detected (node 0).
[    7.340748] EDAC MC: DCT0 chip selects:
[    7.340749] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.345643] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.350513] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.355394] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.360246] EDAC MC: DCT1 chip selects:
[    7.360247] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.365110] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.369981] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.374833] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.379678] EDAC amd64: using x4 syndromes.
[    7.384003] EDAC amd64: MCT channel count: 2
[    7.388555] EDAC MC0: Giving out device to module amd64_edac controlle=
r F15h: DEV 0000:00:18.3 (INTERRUPT)
[    7.398602] EDAC amd64: Node 1: DRAM ECC enabled.
[    7.403468] EDAC amd64: F15h detected (node 1).
[    7.408229] EDAC MC: DCT0 chip selects:
[    7.408230] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.413159] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.418019] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.422881] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.427726] EDAC MC: DCT1 chip selects:
[    7.427727] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.432604] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.437448] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.442328] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.447185] EDAC amd64: using x4 syndromes.
[    7.451523] EDAC amd64: MCT channel count: 2
[    7.456077] EDAC MC1: Giving out device to module amd64_edac controlle=
r F15h: DEV 0000:00:19.3 (INTERRUPT)
[    7.466019] EDAC amd64: Node 2: DRAM ECC enabled.
[    7.470870] EDAC amd64: F15h detected (node 2).
[    7.475598] EDAC MC: DCT0 chip selects:
[    7.475618] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.480462] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.485340] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.490185] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.495040] EDAC MC: DCT1 chip selects:
[    7.495041] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.499901] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.504749] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.509603] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.514452] EDAC amd64: using x4 syndromes.
[    7.518812] EDAC amd64: MCT channel count: 2
[    7.523336] EDAC MC2: Giving out device to module amd64_edac controlle=
r F15h: DEV 0000:00:1a.3 (INTERRUPT)
[    7.533344] EDAC amd64: Node 3: DRAM ECC enabled.
[    7.538199] EDAC amd64: F15h detected (node 3).
[    7.542921] EDAC MC: DCT0 chip selects:
[    7.542922] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.547771] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.552661] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.557512] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.562387] EDAC MC: DCT1 chip selects:
[    7.562388] EDAC amd64: MC: 0:     0MB 1:     0MB
[    7.567243] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    7.572108] EDAC amd64: MC: 4:     0MB 5:     0MB
[    7.576975] EDAC amd64: MC: 6:     0MB 7:     0MB
[    7.581828] EDAC amd64: using x4 syndromes.
[    7.586183] EDAC amd64: MCT channel count: 2
[    7.590773] EDAC MC3: Giving out device to module amd64_edac controlle=
r F15h: DEV 0000:00:1b.3 (INTERRUPT)
[    7.600685] EDAC PCI0: Giving out device to module amd64_edac controll=
er EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[    7.611705] AMD64 EDAC driver v3.5.0
[    7.615438] hidraw: raw HID events driver (C) Jiri Kosina
[    7.621364] usbcore: registered new interface driver usbhid
[    7.627122] usbhid: USB HID core driver
[    7.632084] Key type dns_resolver registered
[    7.634748] snd_hda_intel 0000:00:14.2: no codecs found!
[    7.645395] microcode: CPU0: patch_level=3D0x0600063e
[    7.650448] microcode: CPU1: patch_level=3D0x0600063e
[    7.655655] microcode: CPU2: patch_level=3D0x0600063e
[    7.660682] microcode: CPU3: patch_level=3D0x0600063e
[    7.665706] microcode: CPU4: patch_level=3D0x0600063e
[    7.670757] microcode: CPU5: patch_level=3D0x0600063e
[    7.675803] microcode: CPU6: patch_level=3D0x0600063e
[    7.680833] microcode: CPU7: patch_level=3D0x0600063e
[    7.685863] microcode: CPU8: patch_level=3D0x0600063e
[    7.690906] microcode: CPU9: patch_level=3D0x0600063e
[    7.695945] microcode: CPU10: patch_level=3D0x0600063e
[    7.701070] microcode: CPU11: patch_level=3D0x0600063e
[    7.706308] microcode: CPU12: patch_level=3D0x0600063e
[    7.711426] microcode: CPU13: patch_level=3D0x0600063e
[    7.716660] microcode: CPU14: patch_level=3D0x0600063e
[    7.721784] microcode: CPU15: patch_level=3D0x0600063e
[    7.726911] microcode: CPU16: patch_level=3D0x0600063e
[    7.732056] microcode: CPU17: patch_level=3D0x0600063e
[    7.737291] microcode: CPU18: patch_level=3D0x0600063e
[    7.742422] microcode: CPU19: patch_level=3D0x0600063e
[    7.747703] microcode: CPU20: patch_level=3D0x0600063e
[    7.752829] microcode: CPU21: patch_level=3D0x0600063e
[    7.757951] microcode: CPU22: patch_level=3D0x0600063e
[    7.763081] microcode: CPU23: patch_level=3D0x0600063e
[    7.768235] microcode: CPU24: patch_level=3D0x0600063e
[    7.773385] microcode: CPU25: patch_level=3D0x0600063e
[    7.778593] microcode: CPU26: patch_level=3D0x0600063e
[    7.783743] microcode: CPU27: patch_level=3D0x0600063e
[    7.788867] microcode: CPU28: patch_level=3D0x0600063e
[    7.793987] microcode: CPU29: patch_level=3D0x0600063e
[    7.799212] microcode: CPU30: patch_level=3D0x0600063e
[    7.804335] microcode: CPU31: patch_level=3D0x0600063e
[    7.809677] microcode: Microcode Update Driver: v2.2.
[    7.809694] sched_clock: Marking stable (6725168747, 1084499928)->(826=
0620602, -450951927)
[    7.823825] registered taskstats version 1
[    7.828834] rtc_cmos 00:00: setting system clock to 2004-01-05T08:02:0=
3 UTC (1073289723)
[    7.837253] ALSA device list:
[    7.840382]   No soundcards found.
[    8.934643] floppy0: no floppy controllers found
[    8.940294] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HUA72101 =
A70M PQ: 0 ANSI: 5
[    8.948885] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.0=
0 TB/932 GiB)
[    8.948886] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    8.949277] scsi 1:0:0:0: Direct-Access     ATA      HGST HDN724030AL =
A5E0 PQ: 0 ANSI: 5
[    8.956802] sd 0:0:0:0: [sda] Write Protect is off
[    8.962546] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    8.962562] sd 1:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.0=
0 TB/2.73 TiB)
[    8.962565] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    8.962577] sd 1:0:0:0: [sdb] Write Protect is off
[    8.962597] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    8.962668] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    8.970748] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    8.976137] scsi 3:0:0:0: Direct-Access     ATA      HGST HDN724030AL =
A5E0 PQ: 0 ANSI: 5
[    8.981219] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    8.989423] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    8.989709] sd 3:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.0=
0 TB/2.73 TiB)
[    8.989725] sd 3:0:0:0: [sdc] 4096-byte physical blocks
[    8.989783] sd 3:0:0:0: [sdc] Write Protect is off
[    8.989786] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    8.989821] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    8.995879] sd 1:0:0:0: [sdb] Attached SCSI disk
[    9.004798]  sda: sda1 sda2
[    9.048514]  sdc:
[    9.052724] sd 0:0:0:0: [sda] Attached SCSI disk
[    9.061905] sd 3:0:0:0: [sdc] Attached SCSI disk
[    9.082728] Freeing unused kernel image memory: 1576K
[    9.094605] Write protecting the kernel read-only data: 20480k
[    9.101625] Freeing unused kernel image memory: 2016K
[    9.107124] Freeing unused kernel image memory: 576K
[    9.112237] Run /init as init process
[    9.117447] WARNING: CPU: 3 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.127803] Modules linked in:
[    9.130994] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.0.0-rc1.mx64.2=
36-00029-g3db1296abd46 #1
[    9.139936] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[    9.148095] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[    9.153222] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[    9.172376] RSP: 0018:ffffc900062cfe20 EFLAGS: 00010003
[    9.177749] RAX: 052a310401c13fff RBX: ffff88881d742800 RCX: 000000000=
0000000
[    9.185047] RDX: ffff88881d742800 RSI: ffff88881d742800 RDI: ffffffff8=
247e460
[    9.192343] RBP: ffffc900062cfe70 R08: 000000021f6f8400 R09: 000000000=
0000000
[    9.199633] R10: ffffc900062cfe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[    9.206911] R13: ffff88881d742800 R14: 0000000000000003 R15: ffff88881=
f40ee80
[    9.214194] FS:  0000000000000000(0000) GS:ffff88881fac0000(0000) knlG=
S:0000000000000000
[    9.222531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.228449] CR2: ffffc900068b0000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[    9.235763] Call Trace:
[    9.238352]  ? __schedule+0x1b9/0x7b0
[    9.242154]  __schedule+0x1b9/0x7b0
[    9.245794]  schedule_idle+0x1e/0x40
[    9.249513]  do_idle+0x146/0x200
[    9.252909]  cpu_startup_entry+0x19/0x20
[    9.256972]  start_secondary+0x183/0x1b0
[    9.261046]  secondary_startup_64+0xa4/0xb0
[    9.265388] ---[ end trace bf77d94572ccc569 ]---
[    9.270849] WARNING: CPU: 6 PID: 1 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.281178] Modules linked in:
[    9.284385] CPU: 6 PID: 1 Comm: init Tainted: G        W         5.0.0=
-rc1.mx64.236-00029-g3db1296abd46 #1
[    9.294298] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[    9.302445] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[    9.307586] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[    9.326694] RSP: 0018:ffffc9000625fcd0 EFLAGS: 00010003
[    9.332068] RAX: 052a310401c13fff RBX: ffff88881d742400 RCX: 000000000=
0005daa
[    9.339373] RDX: ffff88881d742400 RSI: ffff88881d742400 RDI: ffff88881=
d742c00
[    9.346662] RBP: ffffc9000625fd20 R08: 0000000228955800 R09: 000000000=
0000156
[    9.353961] R10: ffffc9000625fd38 R11: 0000000000000000 R12: ffff88881=
d742c00
[    9.361241] R13: ffff88881d742400 R14: 0000000000000006 R15: ffff88881=
f40e140
[    9.368530] FS:  0000000000855880(0000) GS:ffff88881fb80000(0000) knlG=
S:0000000000000000
[    9.376875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.382768] CR2: 0000000000856730 CR3: 000000081f40c000 CR4: 000000000=
00406e0
[    9.390048] Call Trace:
[    9.392642]  ? __schedule+0x1b9/0x7b0
[    9.396453]  __schedule+0x1b9/0x7b0
[    9.400111]  schedule+0x28/0x70
[    9.403406]  do_wait+0x1cf/0x230
[    9.406801]  kernel_wait4+0x8d/0x140
[    9.410514]  ? task_stopped_code+0x50/0x50
[    9.414800]  __se_sys_wait4+0x78/0xb0
[    9.418597]  ? handle_mm_fault+0xd0/0x220
[    9.422794]  ? __do_page_fault+0x24c/0x4d0
[    9.427028]  ? do_syscall_64+0x48/0x100
[    9.431018]  ? page_fault+0x8/0x30
[    9.434582]  do_syscall_64+0x48/0x100
[    9.438401]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    9.443645] RIP: 0033:0x48dd8a
[    9.446851] Code: c7 c0 e0 ff ff ff f7 da 64 89 10 48 89 f8 eb d8 8b 0=
5 d2 6a 3c 00 85 c0 75 2b 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 c7 c2 e0 ff ff ff f7 d8 64 89 02
[    9.465968] RSP: 002b:00007ffee737b7b8 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000003d
[    9.473777] RAX: ffffffffffffffda RBX: 00000000008581a0 RCX: 000000000=
048dd8a
[    9.481057] RDX: 0000000000000000 RSI: 00007ffee737b7c8 RDI: fffffffff=
fffffff
[    9.488363] RBP: 00000000008581a0 R08: 0000000000000000 R09: 000000000=
0855880
[    9.495659] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0856bf8
[    9.502940] R13: 00000000008581a0 R14: 00000000ffffffff R15: 000000000=
0856b38
[    9.510221] ---[ end trace bf77d94572ccc56a ]---
[    9.515376] WARNING: CPU: 0 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.525732] Modules linked in:
[    9.528940] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[    9.539271] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[    9.547427] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[    9.552610] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[    9.571726] RSP: 0018:ffffffff82403e00 EFLAGS: 00010003
[    9.577093] RAX: 052a310401c13fff RBX: ffff88881d742c00 RCX: 000000000=
0000000
[    9.584389] RDX: ffff88881d742c00 RSI: ffff88881d742c00 RDI: ffffffff8=
247e460
[    9.591696] RBP: ffffffff82403e50 R08: 000000023728dc00 R09: 000000000=
0000000
[    9.598975] R10: ffffffff82403e68 R11: 0000000000000000 R12: ffffffff8=
247e460
[    9.606265] R13: ffff88881d742c00 R14: 0000000000000000 R15: ffff88881=
dad0d80
[    9.613602] FS:  0000000000000000(0000) GS:ffff88881fa00000(0000) knlG=
S:0000000000000000
[    9.621915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.627802] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406f0
[    9.635081] Call Trace:
[    9.637683]  ? __schedule+0x1b9/0x7b0
[    9.641510]  __schedule+0x1b9/0x7b0
[    9.645169]  schedule_idle+0x1e/0x40
[    9.648905]  do_idle+0x146/0x200
[    9.652269]  cpu_startup_entry+0x19/0x20
[    9.656350]  start_kernel+0x486/0x4a6
[    9.660154]  secondary_startup_64+0xa4/0xb0
[    9.664513] ---[ end trace bf77d94572ccc56b ]---
[    9.669529] WARNING: CPU: 5 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.679879] Modules linked in:
[    9.683069] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[    9.693426] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[    9.701598] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[    9.706701] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[    9.725803] RSP: 0018:ffffc900062dfe20 EFLAGS: 00010003
[    9.731168] RAX: 052a310401c13fff RBX: ffff88881b24ec00 RCX: 000000000=
001b7c7
[    9.738465] RDX: ffff88881b24ec00 RSI: ffff88881b24ec00 RDI: ffffffff8=
247e460
[    9.745798] RBP: ffffc900062dfe70 R08: 0000000240576000 R09: 000000000=
00001d8
[    9.753077] R10: ffffc900062dfe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[    9.760375] R13: ffff88881b24ec00 R14: 0000000000000005 R15: ffff88881=
b3e2ec0
[    9.767664] FS:  0000000000000000(0000) GS:ffff88881fb40000(0000) knlG=
S:0000000000000000
[    9.775983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.781876] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[    9.789155] Call Trace:
[    9.791769]  ? __schedule+0x1b9/0x7b0
[    9.795613]  __schedule+0x1b9/0x7b0
[    9.799242]  schedule_idle+0x1e/0x40
[    9.802964]  do_idle+0x146/0x200
[    9.806327]  cpu_startup_entry+0x19/0x20
[    9.810407]  start_secondary+0x183/0x1b0
[    9.814542]  secondary_startup_64+0xa4/0xb0
[    9.818918] ---[ end trace bf77d94572ccc56c ]---
[    9.824219] WARNING: CPU: 7 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.834544] Modules linked in:
[    9.837770] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[    9.848089] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[    9.856256] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[    9.861367] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[    9.880502] RSP: 0018:ffffc900062efe20 EFLAGS: 00010003
[    9.885903] RAX: 052a310401c13fff RBX: ffff88881b24e800 RCX: 000000000=
0000000
[    9.893183] RDX: ffff88881b24e800 RSI: ffff88881b24e800 RDI: ffffffff8=
247e460
[    9.900483] RBP: ffffc900062efe70 R08: 000000024990ec00 R09: 000000000=
0000000
[    9.907820] R10: ffffc900062efe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[    9.915103] R13: ffff88881b24e800 R14: 0000000000000007 R15: ffff88881=
b3e2180
[    9.922406] FS:  0000000000000000(0000) GS:ffff88881fbc0000(0000) knlG=
S:0000000000000000
[    9.930753] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.936655] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[    9.943943] Call Trace:
[    9.946528]  ? __schedule+0x1b9/0x7b0
[    9.950357]  __schedule+0x1b9/0x7b0
[    9.955394]  schedule_idle+0x1e/0x40
[    9.959113]  do_idle+0x146/0x200
[    9.962517]  cpu_startup_entry+0x19/0x20
[    9.966608]  start_secondary+0x183/0x1b0
[    9.970680]  secondary_startup_64+0xa4/0xb0
[    9.975005] ---[ end trace bf77d94572ccc56d ]---
[    9.981280] WARNING: CPU: 4 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[    9.991609] Modules linked in:
[    9.994809] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   10.005129] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   10.013287] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   10.018392] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   10.037525] RSP: 0018:ffffc900062d7e20 EFLAGS: 00010003
[   10.042926] RAX: 052a310401c13fff RBX: ffff88881b24e400 RCX: 000000000=
0000000
[   10.050206] RDX: ffff88881b24e400 RSI: ffff88881b24e400 RDI: ffffffff8=
247e460
[   10.057507] RBP: ffffc900062d7e70 R08: 0000000252ed8c00 R09: 000000000=
0000000
[   10.064816] R10: ffffc900062d7e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   10.072097] R13: ffff88881b24e400 R14: 0000000000000004 R15: ffff88881=
f40e140
[   10.079404] FS:  0000000000000000(0000) GS:ffff88881fb00000(0000) knlG=
S:0000000000000000
[   10.087749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.093635] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   10.100922] Call Trace:
[   10.103511]  ? __schedule+0x1b9/0x7b0
[   10.107345]  __schedule+0x1b9/0x7b0
[   10.110977]  schedule_idle+0x1e/0x40
[   10.114695]  do_idle+0x146/0x200
[   10.118076]  cpu_startup_entry+0x19/0x20
[   10.122158]  start_secondary+0x183/0x1b0
[   10.126231]  secondary_startup_64+0xa4/0xb0
[   10.130584] ---[ end trace bf77d94572ccc56e ]---
[   10.222961] random: fast init done
[   10.354657] WARNING: CPU: 2 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[   10.364978] Modules linked in:
[   10.368172] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   10.378498] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   10.386674] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   10.391776] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   10.410886] RSP: 0018:ffffc900062c7e20 EFLAGS: 00010003
[   10.416251] RAX: 052a310401c13fff RBX: ffff88881b24e000 RCX: 000000000=
0000000
[   10.423539] RDX: ffff88881b24e000 RSI: ffff88881b24e000 RDI: ffffffff8=
247e460
[   10.430853] RBP: ffffc900062c7e70 R08: 00000002692e2c00 R09: 000000000=
0000000
[   10.438133] R10: ffffc900062c7e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   10.445432] R13: ffff88881b24e000 R14: 0000000000000002 R15: ffff88881=
b3e2180
[   10.452747] FS:  0000000000000000(0000) GS:ffff88881fa80000(0000) knlG=
S:0000000000000000
[   10.461067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.466985] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   10.474275] Call Trace:
[   10.476859]  ? __schedule+0x1b9/0x7b0
[   10.480663]  __schedule+0x1b9/0x7b0
[   10.484294]  schedule_idle+0x1e/0x40
[   10.488012]  do_idle+0x146/0x200
[   10.491384]  cpu_startup_entry+0x19/0x20
[   10.495448]  start_secondary+0x183/0x1b0
[   10.499548]  secondary_startup_64+0xa4/0xb0
[   10.503897] ---[ end trace bf77d94572ccc56f ]---
[   10.512180] XFS (sda1): Mounting V4 Filesystem
[   10.663350] XFS (sda1): Ending clean mount
[   10.884076] random: crng init done
[   11.520795] systemd[1]: System time before build time, advancing clock=
=2E
[   12.010146] NET: Registered protocol family 10
[   12.015300] Segment Routing with IPv6
[   12.049337] NET: Registered protocol family 1
[   12.182311] systemd[1]: systemd 239 running in system mode. (+PAM -AUD=
IT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 d=
efault-hierarchy=3Dhybrid)
[   12.218024] systemd[1]: Detected architecture x86-64.
[   12.232102] systemd[1]: Set hostname to <lassmichmalbittekurznachdenke=
n.molgen.mpg.de>.
[   12.343293] WARNING: CPU: 1 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.343693] WARNING: CPU: 8 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.344664] WARNING: CPU: 15 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.344666] Modules linked in: ip_tables unix ipv6 autofs4
[   12.344673] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.344675] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.344678] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.344680] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.344681] RSP: 0018:ffffc9000632fe20 EFLAGS: 00010003
[   12.344683] RAX: 052a310401c13fff RBX: ffff88881d3b7400 RCX: 000000000=
0000000
[   12.344702] RDX: ffff88881d3b7400 RSI: ffff88881d3b7400 RDI: ffffffff8=
247e460
[   12.344703] RBP: ffffc9000632fe70 R08: 00000002dfcc4000 R09: 000000000=
0000000
[   12.344705] R10: ffffc9000632fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.344724] R13: ffff88881d3b7400 R14: 000000000000000f R15: ffff88881=
a94a440
[   12.344725] FS:  0000000000000000(0000) GS:ffff88901fbc0000(0000) knlG=
S:0000000000000000
[   12.344727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.344746] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.344746] Call Trace:
[   12.344756]  ? __schedule+0x1b9/0x7b0
[   12.344768]  __schedule+0x1b9/0x7b0
[   12.344771]  schedule_idle+0x1e/0x40
[   12.344774]  do_idle+0x146/0x200
[   12.344777]  cpu_startup_entry+0x19/0x20
[   12.344779]  start_secondary+0x183/0x1b0
[   12.344782]  secondary_startup_64+0xa4/0xb0
[   12.344784] ---[ end trace bf77d94572ccc570 ]---
[   12.353670] Modules linked in: ip_tables unix ipv6 autofs4
[   12.363988] Modules linked in: ip_tables unix ipv6 autofs4
[   12.374419] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.380137] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.390649] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.398795] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.398799] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.403904] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.408820] WARNING: CPU: 10 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.408821] Modules linked in: ip_tables unix ipv6 autofs4
[   12.408826] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.408827] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.408830] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.408832] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.408834] RSP: 0018:ffffc90006307e20 EFLAGS: 00010003
[   12.408835] RAX: 052a310401c13fff RBX: ffff88901ca40c00 RCX: 000000000=
0000000
[   12.408836] RDX: ffff88901ca40c00 RSI: ffff88901ca40c00 RDI: ffffffff8=
247e460
[   12.408837] RBP: ffffc90006307e70 R08: 00000002e39f5400 R09: 000000000=
0000000
[   12.408838] R10: ffffc90006307e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.408839] R13: ffff88901ca40c00 R14: 000000000000000a R15: ffff88881=
a94a440
[   12.408841] FS:  0000000000000000(0000) GS:ffff88901fa80000(0000) knlG=
S:0000000000000000
[   12.408842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.408843] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.408844] Call Trace:
[   12.408848]  ? __schedule+0x1b9/0x7b0
[   12.408850]  __schedule+0x1b9/0x7b0
[   12.408852]  schedule_idle+0x1e/0x40
[   12.408854]  do_idle+0x146/0x200
[   12.408856]  cpu_startup_entry+0x19/0x20
[   12.408858]  start_secondary+0x183/0x1b0
[   12.408860]  secondary_startup_64+0xa4/0xb0
[   12.408862] ---[ end trace bf77d94572ccc571 ]---
[   12.423029] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.425834] WARNING: CPU: 12 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.425835] Modules linked in: ip_tables unix ipv6 autofs4
[   12.425840] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.425841] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.425844] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.425845] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.425847] RSP: 0018:ffffc90006317e20 EFLAGS: 00010003
[   12.425848] RAX: 052a310401c13fff RBX: ffff88901ca40c00 RCX: 000000000=
0000000
[   12.425849] RDX: ffff88901ca40c00 RSI: ffff88901ca40c00 RDI: ffffffff8=
247e460
[   12.425850] RBP: ffffc90006317e70 R08: 00000002e4a2ec00 R09: 000000000=
0000000
[   12.425851] R10: ffffc90006317e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.425853] R13: ffff88901ca40c00 R14: 000000000000000c R15: ffff88881=
a94a440
[   12.425854] FS:  0000000000000000(0000) GS:ffff88901fb00000(0000) knlG=
S:0000000000000000
[   12.425855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.425856] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.425857] Call Trace:
[   12.425861]  ? __schedule+0x1b9/0x7b0
[   12.425863]  __schedule+0x1b9/0x7b0
[   12.425865]  schedule_idle+0x1e/0x40
[   12.425867]  do_idle+0x146/0x200
[   12.425869]  cpu_startup_entry+0x19/0x20
[   12.425871]  start_secondary+0x183/0x1b0
[   12.425873]  secondary_startup_64+0xa4/0xb0
[   12.425875] ---[ end trace bf77d94572ccc572 ]---
[   12.428412] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.435747] RSP: 0018:ffffc900062f7e20 EFLAGS: 00010003
[   12.437942] WARNING: CPU: 14 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   12.437943] Modules linked in: ip_tables unix ipv6 autofs4
[   12.437948] CPU: 14 PID: 0 Comm: swapper/14 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   12.437949] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   12.437952] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   12.437953] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   12.437955] RSP: 0018:ffffc90006327e20 EFLAGS: 00010003
[   12.437956] RAX: 052a310401c13fff RBX: ffff88901ca40c00 RCX: 000000000=
0000000
[   12.437957] RDX: ffff88901ca40c00 RSI: ffff88901ca40c00 RDI: ffffffff8=
247e460
[   12.437958] RBP: ffffc90006327e70 R08: 00000002e55bb000 R09: 000000000=
0000000
[   12.437959] R10: ffffc90006327e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.437960] R13: ffff88901ca40c00 R14: 000000000000000e R15: ffff88881=
a94a440
[   12.437962] FS:  0000000000000000(0000) GS:ffff88901fb80000(0000) knlG=
S:0000000000000000
[   12.437963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.437964] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.437965] Call Trace:
[   12.437969]  ? __schedule+0x1b9/0x7b0
[   12.437971]  __schedule+0x1b9/0x7b0
[   12.437973]  schedule_idle+0x1e/0x40
[   12.437975]  do_idle+0x146/0x200
[   12.437977]  cpu_startup_entry+0x19/0x20
[   12.437979]  start_secondary+0x183/0x1b0
[   12.437981]  secondary_startup_64+0xa4/0xb0
[   12.437982] ---[ end trace bf77d94572ccc573 ]---
[   12.443077] RSP: 0018:ffffc900062bfe20 EFLAGS: 00010003
[   12.450397] RAX: 052a310401c13fff RBX: ffff88881cb60400 RCX: 000000000=
0000000
[   12.450400] RDX: ffff88881cb60400 RSI: ffff88881cb60400 RDI: ffffffff8=
247e460
[   12.457747] RAX: 052a310401c13fff RBX: ffff88881b24ec00 RCX: 000000000=
0000000
[   12.457749] RDX: ffff88881b24ec00 RSI: ffff88881b24ec00 RDI: ffffffff8=
247e460
[   12.465068] RBP: ffffc900062f7e70 R08: 00000002dfbd6c00 R09: 000000000=
0000000
[   12.465130] R10: ffffc900062f7e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.473467] RBP: ffffc900062bfe70 R08: 00000002dfb76400 R09: 000000000=
0000000
[   12.473470] R10: ffffc900062bfe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   12.479414] R13: ffff88881cb60400 R14: 0000000000000008 R15: ffff88881=
a9743c0
[   12.479416] FS:  0000000000000000(0000) GS:ffff88901fa00000(0000) knlG=
S:0000000000000000
[   12.486788] R13: ffff88881b24ec00 R14: 0000000000000001 R15: ffff88881=
ac2a380
[   12.486791] FS:  0000000000000000(0000) GS:ffff88881fa40000(0000) knlG=
S:0000000000000000
[   12.489371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.489373] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.493184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.493187] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   12.496824] Call Trace:
[   12.500535] Call Trace:
[   12.503935]  ? __schedule+0x1b9/0x7b0
[   12.508037]  ? __schedule+0x1b9/0x7b0
[   12.512125]  __schedule+0x1b9/0x7b0
[   12.512161]  schedule_idle+0x1e/0x40
[   12.516511]  __schedule+0x1b9/0x7b0
[   12.516515]  schedule_idle+0x1e/0x40
[   12.521310]  do_idle+0x146/0x200
[   12.526943]  do_idle+0x146/0x200
[   12.532644]  cpu_startup_entry+0x19/0x20
[   12.542967]  cpu_startup_entry+0x19/0x20
[   12.553305]  start_secondary+0x183/0x1b0
[   12.561454]  start_secondary+0x183/0x1b0
[   12.569650]  secondary_startup_64+0xa4/0xb0
[   12.574771]  secondary_startup_64+0xa4/0xb0
[   12.579878] ---[ end trace bf77d94572ccc574 ]---
[   12.590294] ---[ end trace bf77d94572ccc575 ]---
[   13.394696] systemd[1]: File /lib/systemd/system/systemd-journald.serv=
ice:36 configures an IP firewall (IPAddressDeny=3Dany), but the local sys=
tem does not support BPF/cgroup based firewalling.
[   13.412307] systemd[1]: Proceeding WITHOUT firewalling in effect! (Thi=
s warning is only shown for the first loaded unit using IP firewalling.)
[   13.890332] systemd[1]: Reached target Remote File Systems.
[   13.896782] systemd[1]: Started Forward Password Requests to Wall Dire=
ctory Watch.
[   13.905316] systemd[1]: Listening on Journal Socket.
[   13.912766] systemd[1]: Starting Create list of required static device=
 nodes for the current kernel...
[   13.922984] systemd[1]: Listening on udev Control Socket.
[   14.513947] RPC: Registered named UNIX socket transport module.
[   14.520160] RPC: Registered udp transport module.
[   14.525163] RPC: Registered tcp transport module.
[   14.530074] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   15.236246] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   15.458275] systemd-journald[345]: Received request to flush runtime j=
ournal from PID 1
[   15.520836] systemd-journald[345]: File /var/log/journal/95790226b8d07=
79f4b4797314ca986d4/system.journal corrupted or uncleanly shut down, rena=
ming and replacing.
[   16.041638] WARNING: CPU: 18 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.042673] WARNING: CPU: 30 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.044638] WARNING: CPU: 20 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.044640] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.044655] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.044657] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.044660] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.044662] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.044663] RSP: 0018:ffffc90006357e20 EFLAGS: 00010003
[   16.044665] RAX: 052a310401c13fff RBX: ffff8888177d9000 RCX: 000000000=
0014733
[   16.044667] RDX: ffff8888177d9000 RSI: ffff8888177d9000 RDI: ffffffff8=
247e460
[   16.044668] RBP: ffffc90006357e70 R08: 00000003bc532800 R09: 000000000=
00000ca
[   16.044669] R10: ffffc90006357e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.044670] R13: ffff8888177d9000 R14: 0000000000000014 R15: ffff88881=
ab70ec0
[   16.044672] FS:  0000000000000000(0000) GS:ffff88981fb00000(0000) knlG=
S:0000000000000000
[   16.044673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.044674] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.044675] Call Trace:
[   16.044685]  ? __schedule+0x1b9/0x7b0
[   16.044686]  __schedule+0x1b9/0x7b0
[   16.044690]  schedule_idle+0x1e/0x40
[   16.044694]  do_idle+0x146/0x200
[   16.044697]  cpu_startup_entry+0x19/0x20
[   16.044699]  start_secondary+0x183/0x1b0
[   16.044702]  secondary_startup_64+0xa4/0xb0
[   16.044704] ---[ end trace bf77d94572ccc576 ]---
[   16.046661] WARNING: CPU: 25 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.046662] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.046674] CPU: 25 PID: 0 Comm: swapper/25 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.046676] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.046679] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.046681] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.046683] RSP: 0018:ffffc9000637fe20 EFLAGS: 00010003
[   16.046685] RAX: 052a310401c13fff RBX: ffff88881ab89800 RCX: 000000000=
0019f1b
[   16.046686] RDX: ffff88881ab89800 RSI: ffff88881ab89800 RDI: ffffffff8=
247e460
[   16.046687] RBP: ffffc9000637fe70 R08: 00000003bc72a400 R09: 000000000=
00000a9
[   16.046688] R10: ffffc9000637fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.046689] R13: ffff88881ab89800 R14: 0000000000000019 R15: ffff88881=
abb6f00
[   16.046691] FS:  0000000000000000(0000) GS:ffff88a017c40000(0000) knlG=
S:0000000000000000
[   16.046693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.046694] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.046695] Call Trace:
[   16.046704]  ? __schedule+0x1b9/0x7b0
[   16.046706]  __schedule+0x1b9/0x7b0
[   16.046710]  schedule_idle+0x1e/0x40
[   16.046713]  do_idle+0x146/0x200
[   16.046716]  cpu_startup_entry+0x19/0x20
[   16.046719]  start_secondary+0x183/0x1b0
[   16.046721]  secondary_startup_64+0xa4/0xb0
[   16.046723] ---[ end trace bf77d94572ccc577 ]---
[   16.049828] WARNING: CPU: 22 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.049829] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.049837] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.049838] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.049841] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.049843] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.049844] RSP: 0018:ffffc90006367e20 EFLAGS: 00010003
[   16.049846] RAX: 052a310401c13fff RBX: ffff88881ab89400 RCX: 000000000=
0000000
[   16.049847] RDX: ffff88881ab89400 RSI: ffff88881ab89400 RDI: ffffffff8=
247e460
[   16.049848] RBP: ffffc90006367e70 R08: 00000003bca4a800 R09: 000000000=
0000000
[   16.049849] R10: ffffc90006367e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.049850] R13: ffff88881ab89400 R14: 0000000000000016 R15: ffff88881=
abb61c0
[   16.049852] FS:  0000000000000000(0000) GS:ffff88981fb80000(0000) knlG=
S:0000000000000000
[   16.049853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.049854] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.049855] Call Trace:
[   16.049859]  ? __schedule+0x1b9/0x7b0
[   16.049861]  __schedule+0x1b9/0x7b0
[   16.049863]  schedule_idle+0x1e/0x40
[   16.049865]  do_idle+0x146/0x200
[   16.049867]  cpu_startup_entry+0x19/0x20
[   16.049869]  start_secondary+0x183/0x1b0
[   16.049871]  secondary_startup_64+0xa4/0xb0
[   16.049873] ---[ end trace bf77d94572ccc578 ]---
[   16.052156] WARNING: CPU: 27 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.052157] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.052170] CPU: 27 PID: 0 Comm: swapper/27 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.052172] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.052175] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.052177] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.052178] RSP: 0018:ffffc9000638fe20 EFLAGS: 00010003
[   16.052180] RAX: 052a310401c13fff RBX: ffff88881ab89000 RCX: 000000000=
0000000
[   16.052181] RDX: ffff88881ab89000 RSI: ffff88881ab89000 RDI: ffffffff8=
247e460
[   16.052183] RBP: ffffc9000638fe70 R08: 00000003bcc6e800 R09: 000000000=
0000000
[   16.052184] R10: ffffc9000638fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.052185] R13: ffff88881ab89000 R14: 000000000000001b R15: ffff88881=
cc3cf40
[   16.052186] FS:  0000000000000000(0000) GS:ffff88a017cc0000(0000) knlG=
S:0000000000000000
[   16.052188] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.052189] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.052190] Call Trace:
[   16.052199]  ? __schedule+0x1b9/0x7b0
[   16.052201]  __schedule+0x1b9/0x7b0
[   16.052204]  schedule_idle+0x1e/0x40
[   16.052207]  do_idle+0x146/0x200
[   16.052209]  cpu_startup_entry+0x19/0x20
[   16.052213]  start_secondary+0x183/0x1b0
[   16.052215]  secondary_startup_64+0xa4/0xb0
[   16.052217] ---[ end trace bf77d94572ccc579 ]---
[   16.052230] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.054741] WARNING: CPU: 17 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.054742] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.054749] CPU: 17 PID: 0 Comm: swapper/17 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.054750] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.054753] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.054755] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.054756] RSP: 0018:ffffc9000633fe20 EFLAGS: 00010003
[   16.054757] RAX: 052a310401c13fff RBX: ffff88881cc30c00 RCX: 000000000=
0000000
[   16.054759] RDX: ffff88881cc30c00 RSI: ffff88881cc30c00 RDI: ffffffff8=
247e460
[   16.054760] RBP: ffffc9000633fe70 R08: 00000003bcefa400 R09: 000000000=
0000000
[   16.054761] R10: ffffc9000633fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.054762] R13: ffff88881cc30c00 R14: 0000000000000011 R15: ffff88881=
cc3c200
[   16.054763] FS:  0000000000000000(0000) GS:ffff88981fa40000(0000) knlG=
S:0000000000000000
[   16.054765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.054766] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.054766] Call Trace:
[   16.054771]  ? __schedule+0x1b9/0x7b0
[   16.054772]  __schedule+0x1b9/0x7b0
[   16.054775]  schedule_idle+0x1e/0x40
[   16.054777]  do_idle+0x146/0x200
[   16.054779]  cpu_startup_entry+0x19/0x20
[   16.054781]  start_secondary+0x183/0x1b0
[   16.054782]  secondary_startup_64+0xa4/0xb0
[   16.054784] ---[ end trace bf77d94572ccc57a ]---
[   16.057390] WARNING: CPU: 29 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.057392] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.057404] CPU: 29 PID: 0 Comm: swapper/29 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.057406] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.057409] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.057411] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.057413] RSP: 0018:ffffc9000639fe20 EFLAGS: 00010003
[   16.057415] RAX: 052a310401c13fff RBX: ffff88881cc30800 RCX: 000000000=
0000000
[   16.057416] RDX: ffff88881cc30800 RSI: ffff88881cc30800 RDI: ffffffff8=
247e460
[   16.057417] RBP: ffffc9000639fe70 R08: 00000003bd169000 R09: 000000000=
0000000
[   16.057418] R10: ffffc9000639fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.057419] R13: ffff88881cc30800 R14: 000000000000001d R15: ffff88881=
cc86f80
[   16.057421] FS:  0000000000000000(0000) GS:ffff88a017d40000(0000) knlG=
S:0000000000000000
[   16.057422] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.057423] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.057424] Call Trace:
[   16.057434]  ? __schedule+0x1b9/0x7b0
[   16.057435]  __schedule+0x1b9/0x7b0
[   16.057438]  schedule_idle+0x1e/0x40
[   16.057441]  do_idle+0x146/0x200
[   16.057444]  cpu_startup_entry+0x19/0x20
[   16.057446]  start_secondary+0x183/0x1b0
[   16.057449]  secondary_startup_64+0xa4/0xb0
[   16.057451] ---[ end trace bf77d94572ccc57b ]---
[   16.062753] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.064167] WARNING: CPU: 9 PID: 0 at ./arch/x86/include/asm/nospec-br=
anch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.064169] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.064179] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W         =
5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.064180] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.064183] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.064186] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.064187] RSP: 0018:ffffc900062ffe20 EFLAGS: 00010003
[   16.064189] RAX: 052a310401c13fff RBX: ffff88881cc30000 RCX: 000000000=
0000000
[   16.064190] RDX: ffff88881cc30000 RSI: ffff88881cc30000 RDI: ffffffff8=
247e460
[   16.064191] RBP: ffffc900062ffe70 R08: 00000003bd7f6000 R09: 000000000=
0000000
[   16.064192] R10: ffffc900062ffe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.064193] R13: ffff88881cc30000 R14: 0000000000000009 R15: ffff88881=
cccafc0
[   16.064195] FS:  0000000000000000(0000) GS:ffff88901fa40000(0000) knlG=
S:0000000000000000
[   16.064197] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.064198] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.064199] Call Trace:
[   16.064205]  ? __schedule+0x1b9/0x7b0
[   16.064206]  __schedule+0x1b9/0x7b0
[   16.064209]  schedule_idle+0x1e/0x40
[   16.064213]  do_idle+0x146/0x200
[   16.064216]  cpu_startup_entry+0x19/0x20
[   16.064218]  start_secondary+0x183/0x1b0
[   16.064220]  secondary_startup_64+0xa4/0xb0
[   16.064222] ---[ end trace bf77d94572ccc57c ]---
[   16.073275] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.084129] CPU: 30 PID: 0 Comm: swapper/30 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.084182] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.094791] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.094796] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.100003] WARNING: CPU: 13 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.100004] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.100012] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.100013] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.100015] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.100017] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.100018] RSP: 0018:ffffc9000631fe20 EFLAGS: 00010003
[   16.100020] RAX: 052a310401c13fff RBX: ffff88881cce1000 RCX: 000000000=
0000000
[   16.100021] RDX: ffff88881cce1000 RSI: ffff88881cce1000 RDI: ffffffff8=
247e460
[   16.100022] RBP: ffffc9000631fe70 R08: 00000003bfa24800 R09: 000000000=
0000000
[   16.100023] R10: ffffc9000631fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.100024] R13: ffff88881cce1000 R14: 000000000000000d R15: ffff88881=
a89b040
[   16.100026] FS:  0000000000000000(0000) GS:ffff88901fb40000(0000) knlG=
S:0000000000000000
[   16.100027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.100028] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.100029] Call Trace:
[   16.100033]  ? __schedule+0x1b9/0x7b0
[   16.100035]  __schedule+0x1b9/0x7b0
[   16.100037]  schedule_idle+0x1e/0x40
[   16.100040]  do_idle+0x146/0x200
[   16.100042]  cpu_startup_entry+0x19/0x20
[   16.100043]  start_secondary+0x183/0x1b0
[   16.100045]  secondary_startup_64+0xa4/0xb0
[   16.100047] ---[ end trace bf77d94572ccc57d ]---
[   16.103090] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.103838] WARNING: CPU: 16 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.103840] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.103847] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.103848] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.103851] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.103853] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.103854] RSP: 0018:ffffc90006337e20 EFLAGS: 00010003
[   16.103856] RAX: 052a310401c13fff RBX: ffff88881a888400 RCX: 000000000=
0000000
[   16.103857] RDX: ffff88881a888400 RSI: ffff88881a888400 RDI: ffffffff8=
247e460
[   16.103858] RBP: ffffc90006337e70 R08: 00000003bfdccc00 R09: 000000000=
0000000
[   16.103859] R10: ffffc90006337e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.103860] R13: ffff88881a888400 R14: 0000000000000010 R15: ffff88881=
a8e0340
[   16.103862] FS:  0000000000000000(0000) GS:ffff88981fa00000(0000) knlG=
S:0000000000000000
[   16.103863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.103864] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.103865] Call Trace:
[   16.103870]  ? __schedule+0x1b9/0x7b0
[   16.103871]  __schedule+0x1b9/0x7b0
[   16.103874]  schedule_idle+0x1e/0x40
[   16.103876]  do_idle+0x146/0x200
[   16.103878]  cpu_startup_entry+0x19/0x20
[   16.103879]  start_secondary+0x183/0x1b0
[   16.103881]  secondary_startup_64+0xa4/0xb0
[   16.103883] ---[ end trace bf77d94572ccc57e ]---
[   16.105403] WARNING: CPU: 26 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.105404] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.105411] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.105412] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.105415] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.105417] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.105418] RSP: 0018:ffffc90006387e20 EFLAGS: 00010003
[   16.105420] RAX: 052a310401c13fff RBX: ffff888819d36c00 RCX: 000000000=
0000000
[   16.105421] RDX: ffff888819d36c00 RSI: ffff888819d36c00 RDI: ffffffff8=
247e460
[   16.105422] RBP: ffffc90006387e70 R08: 00000003bff35800 R09: 000000000=
0000000
[   16.105423] R10: ffffc90006387e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.105424] R13: ffff888819d36c00 R14: 000000000000001a R15: ffff88881=
9d28380
[   16.105426] FS:  0000000000000000(0000) GS:ffff88a017c80000(0000) knlG=
S:0000000000000000
[   16.105427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.105428] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.105429] Call Trace:
[   16.105433]  ? __schedule+0x1b9/0x7b0
[   16.105435]  __schedule+0x1b9/0x7b0
[   16.105437]  schedule_idle+0x1e/0x40
[   16.105439]  do_idle+0x146/0x200
[   16.105441]  cpu_startup_entry+0x19/0x20
[   16.105443]  start_secondary+0x183/0x1b0
[   16.105445]  secondary_startup_64+0xa4/0xb0
[   16.105447] ---[ end trace bf77d94572ccc57f ]---
[   16.108237] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.109887] WARNING: CPU: 21 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.109888] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.109896] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.109897] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.109900] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.109902] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.109903] RSP: 0018:ffffc9000635fe20 EFLAGS: 00010003
[   16.109905] RAX: 052a310401c13fff RBX: ffff888819de0400 RCX: 000000000=
0000000
[   16.109906] RDX: ffff888819de0400 RSI: ffff888819de0400 RDI: ffffffff8=
247e460
[   16.109907] RBP: ffffc9000635fe70 R08: 00000003c0391c00 R09: 000000000=
0000000
[   16.109908] R10: ffffc9000635fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.109909] R13: ffff888819de0400 R14: 0000000000000015 R15: ffff88881=
977a440
[   16.109911] FS:  0000000000000000(0000) GS:ffff88981fb40000(0000) knlG=
S:0000000000000000
[   16.109912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.109913] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.109914] Call Trace:
[   16.109918]  ? __schedule+0x1b9/0x7b0
[   16.109920]  __schedule+0x1b9/0x7b0
[   16.109922]  schedule_idle+0x1e/0x40
[   16.109924]  do_idle+0x146/0x200
[   16.109927]  cpu_startup_entry+0x19/0x20
[   16.109928]  start_secondary+0x183/0x1b0
[   16.109930]  secondary_startup_64+0xa4/0xb0
[   16.109932] ---[ end trace bf77d94572ccc580 ]---
[   16.110636] WARNING: CPU: 28 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.110637] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.110644] CPU: 28 PID: 0 Comm: swapper/28 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.110645] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.110648] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.110650] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.110651] RSP: 0018:ffffc90006397e20 EFLAGS: 00010003
[   16.110653] RAX: 052a310401c13fff RBX: ffff888819de0000 RCX: 000000000=
0000899
[   16.110654] RDX: ffff888819de0000 RSI: ffff888819de0000 RDI: ffffffff8=
247e460
[   16.110655] RBP: ffffc90006397e70 R08: 00000003c0448800 R09: 000000000=
0000122
[   16.110656] R10: ffffc90006397e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.110657] R13: ffff888819de0000 R14: 000000000000001c R15: ffff88881=
97c51c0
[   16.110659] FS:  0000000000000000(0000) GS:ffff88a017d00000(0000) knlG=
S:0000000000000000
[   16.110660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.110661] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.110662] Call Trace:
[   16.110666]  ? __schedule+0x1b9/0x7b0
[   16.110668]  __schedule+0x1b9/0x7b0
[   16.110670]  schedule_idle+0x1e/0x40
[   16.110672]  do_idle+0x146/0x200
[   16.110674]  cpu_startup_entry+0x19/0x20
[   16.110676]  start_secondary+0x183/0x1b0
[   16.110678]  secondary_startup_64+0xa4/0xb0
[   16.110680] ---[ end trace bf77d94572ccc581 ]---
[   16.112795] WARNING: CPU: 11 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.112797] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.112805] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.112806] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.112809] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.112811] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.112812] RSP: 0018:ffffc9000630fe20 EFLAGS: 00010003
[   16.112814] RAX: 052a310401c13fff RBX: ffff8888197ce400 RCX: 000000000=
0000000
[   16.112815] RDX: ffff8888197ce400 RSI: ffff8888197ce400 RDI: ffffffff8=
247e460
[   16.112816] RBP: ffffc9000630fe70 R08: 00000003c0657400 R09: 000000000=
0000000
[   16.112817] R10: ffffc9000630fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.112818] R13: ffff8888197ce400 R14: 000000000000000b R15: ffff88881=
9e0a4c0
[   16.112820] FS:  0000000000000000(0000) GS:ffff88901fac0000(0000) knlG=
S:0000000000000000
[   16.112821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.112822] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.112823] Call Trace:
[   16.112829]  ? __schedule+0x1b9/0x7b0
[   16.112830]  __schedule+0x1b9/0x7b0
[   16.112833]  schedule_idle+0x1e/0x40
[   16.112836]  do_idle+0x146/0x200
[   16.112838]  cpu_startup_entry+0x19/0x20
[   16.112840]  start_secondary+0x183/0x1b0
[   16.112842]  secondary_startup_64+0xa4/0xb0
[   16.112844] ---[ end trace bf77d94572ccc582 ]---
[   16.116553] WARNING: CPU: 23 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.116556] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.116588] CPU: 23 PID: 0 Comm: swapper/23 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.116606] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.116612] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.116615] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.116617] RSP: 0018:ffffc9000636fe20 EFLAGS: 00010003
[   16.116620] RAX: 052a310401c13fff RBX: ffff888819e78000 RCX: 000000000=
0013ee5
[   16.116622] RDX: ffff888819e78000 RSI: ffff888819e78000 RDI: ffffffff8=
247e460
[   16.116624] RBP: ffffc9000636fe70 R08: 00000003c09d6800 R09: 000000000=
000035a
[   16.116626] R10: ffffc9000636fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.116628] R13: ffff888819e78000 R14: 0000000000000017 R15: ffff88881=
9f1cd40
[   16.116631] FS:  0000000000000000(0000) GS:ffff88981fbc0000(0000) knlG=
S:0000000000000000
[   16.116633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.116635] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.116637] Call Trace:
[   16.116644]  ? __schedule+0x1b9/0x7b0
[   16.116647]  __schedule+0x1b9/0x7b0
[   16.116652]  schedule_idle+0x1e/0x40
[   16.116655]  do_idle+0x146/0x200
[   16.116659]  cpu_startup_entry+0x19/0x20
[   16.116662]  start_secondary+0x183/0x1b0
[   16.116666]  secondary_startup_64+0xa4/0xb0
[   16.116669] ---[ end trace bf77d94572ccc583 ]---
[   16.120890] WARNING: CPU: 24 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.120891] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.120899] CPU: 24 PID: 0 Comm: swapper/24 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.120900] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.120903] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.120905] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.120906] RSP: 0018:ffffc90006377e20 EFLAGS: 00010003
[   16.120908] RAX: 052a310401c13fff RBX: ffff888819fd5800 RCX: 000000000=
0000000
[   16.120909] RDX: ffff888819fd5800 RSI: ffff888819fd5800 RDI: ffffffff8=
247e460
[   16.120910] RBP: ffffc90006377e70 R08: 00000003c0e0fc00 R09: 000000000=
0000000
[   16.120911] R10: ffffc90006377e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.120912] R13: ffff888819fd5800 R14: 0000000000000018 R15: ffff88881=
2832e00
[   16.120914] FS:  0000000000000000(0000) GS:ffff88a017c00000(0000) knlG=
S:0000000000000000
[   16.120915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.120916] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.120917] Call Trace:
[   16.120922]  ? __schedule+0x1b9/0x7b0
[   16.120923]  __schedule+0x1b9/0x7b0
[   16.120926]  schedule_idle+0x1e/0x40
[   16.120928]  do_idle+0x146/0x200
[   16.120930]  cpu_startup_entry+0x19/0x20
[   16.120932]  start_secondary+0x183/0x1b0
[   16.120934]  secondary_startup_64+0xa4/0xb0
[   16.120936] ---[ end trace bf77d94572ccc584 ]---
[   16.127585] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.127586] RSP: 0018:ffffc900063a7e20 EFLAGS: 00010003
[   16.127587] RAX: 052a310401c13fff RBX: ffff8888177d9800 RCX: 000000000=
00201a8
[   16.127588] RDX: ffff8888177d9800 RSI: ffff8888177d9800 RDI: ffffffff8=
247e460
[   16.127589] RBP: ffffc900063a7e70 R08: 00000003bc356c00 R09: 000000000=
000015b
[   16.127590] R10: ffffc900063a7e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.127591] R13: ffff8888177d9800 R14: 000000000000001e R15: ffff88881=
d3cae80
[   16.127593] FS:  0000000000000000(0000) GS:ffff88a017d80000(0000) knlG=
S:0000000000000000
[   16.127594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.127595] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.127595] Call Trace:
[   16.127627]  ? __schedule+0x1b9/0x7b0
[   16.133019] RSP: 0018:ffffc90006347e20 EFLAGS: 00010003
[   16.140403]  __schedule+0x1b9/0x7b0
[   16.140406]  schedule_idle+0x1e/0x40
[   16.147957] WARNING: CPU: 31 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.147958] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.147967] CPU: 31 PID: 0 Comm: swapper/31 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.147968] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.147971] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.147973] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.147974] RSP: 0018:ffffc900063afe20 EFLAGS: 00010003
[   16.147976] RAX: 052a310401c13fff RBX: ffff888819de0c00 RCX: 000000000=
0000000
[   16.147978] RDX: ffff888819de0c00 RSI: ffff888819de0c00 RDI: ffffffff8=
247e460
[   16.147979] RBP: ffffc900063afe70 R08: 00000003c27e1000 R09: 000000000=
0000000
[   16.147980] R10: ffffc900063afe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.147982] R13: ffff888819de0c00 R14: 000000000000001f R15: ffff88881=
9db6400
[   16.147984] FS:  0000000000000000(0000) GS:ffff88a017dc0000(0000) knlG=
S:0000000000000000
[   16.147985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.147987] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.147988] Call Trace:
[   16.147991]  ? __schedule+0x1b9/0x7b0
[   16.147993]  __schedule+0x1b9/0x7b0
[   16.147996]  schedule_idle+0x1e/0x40
[   16.147999]  do_idle+0x146/0x200
[   16.148001]  cpu_startup_entry+0x19/0x20
[   16.148003]  start_secondary+0x183/0x1b0
[   16.148006]  secondary_startup_64+0xa4/0xb0
[   16.148008] ---[ end trace bf77d94572ccc585 ]---
[   16.148064] WARNING: CPU: 19 PID: 0 at ./arch/x86/include/asm/nospec-b=
ranch.h:287 switch_mm_irqs_off+0x61b/0x710
[   16.148065] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl l=
ockd grace sunrpc ip_tables unix ipv6 autofs4
[   16.148086] CPU: 19 PID: 0 Comm: swapper/19 Tainted: G        W       =
  5.0.0-rc1.mx64.236-00029-g3db1296abd46 #1
[   16.148089] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-213-gdb866=
ba200 01/08/2019
[   16.148095] RIP: 0010:switch_mm_irqs_off+0x61b/0x710
[   16.148101] Code: 31 d2 31 f6 e8 66 4a da 00 49 8b 06 48 85 c0 75 e7 e=
8 e9 ee 06 00 44 89 fe 48 c7 c7 c0 a1 46 82 e8 ca 88 06 00 e9 41 fc ff ff=
 <0f> 0b e9 bd fa ff ff 0f 0b 8b 0d 36 10 50 01 48 c7 c2 00 d5 55 82
[   16.148103] RSP: 0018:ffffc9000634fe20 EFLAGS: 00010003
[   16.148109] RAX: 052a310401c13fff RBX: ffff88881cce1400 RCX: 000000000=
00018fd
[   16.148114] RDX: ffff88881cce1400 RSI: ffff88881cce1400 RDI: ffffffff8=
247e460
[   16.148119] RBP: ffffc9000634fe70 R08: 00000003c27f8400 R09: 000000000=
00003e1
[   16.148122] R10: ffffc9000634fe88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.148126] R13: ffff88881cce1400 R14: 0000000000000013 R15: ffff88881=
a8122c0
[   16.148133] FS:  0000000000000000(0000) GS:ffff88981fac0000(0000) knlG=
S:0000000000000000
[   16.148136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.148139] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.148142] Call Trace:
[   16.148156]  ? __schedule+0x1b9/0x7b0
[   16.148161]  __schedule+0x1b9/0x7b0
[   16.148169]  schedule_idle+0x1e/0x40
[   16.148175]  do_idle+0x146/0x200
[   16.148181]  cpu_startup_entry+0x19/0x20
[   16.148186]  start_secondary+0x183/0x1b0
[   16.148192]  secondary_startup_64+0xa4/0xb0
[   16.148195] ---[ end trace bf77d94572ccc586 ]---
[   16.149215] RAX: 052a310401c13fff RBX: ffff8888174b5400 RCX: 000000000=
000b44e
[   16.149237] RDX: ffff8888174b5400 RSI: ffff8888174b5400 RDI: ffffffff8=
247e460
[   16.156638]  do_idle+0x146/0x200
[   16.164074] RBP: ffffc90006347e70 R08: 00000003bc268000 R09: 000000000=
00001a0
[   16.164077] R10: ffffc90006347e88 R11: 0000000000000000 R12: ffffffff8=
247e460
[   16.171510]  cpu_startup_entry+0x19/0x20
[   16.180132] R13: ffff8888174b5400 R14: 0000000000000012 R15: ffff88881=
945e0c0
[   16.180155] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000) knlG=
S:0000000000000000
[   16.186163]  start_secondary+0x183/0x1b0
[   16.193606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.193627] CR2: 0000000000000000 CR3: 000000000240e000 CR4: 000000000=
00406e0
[   16.196228]  secondary_startup_64+0xa4/0xb0
[   16.200139] Call Trace:
[   16.200156]  ? __schedule+0x1b9/0x7b0
[   16.203854] ---[ end trace bf77d94572ccc587 ]---
[   16.207656]  __schedule+0x1b9/0x7b0
[   16.207660]  schedule_idle+0x1e/0x40
[   19.134878]  do_idle+0x146/0x200
[   19.134882]  cpu_startup_entry+0x19/0x20
[   19.134884]  start_secondary+0x183/0x1b0
[   19.134886]  secondary_startup_64+0xa4/0xb0
[   19.134889] ---[ end trace bf77d94572ccc588 ]---
[   19.162268] acpi_cpufreq: overriding BIOS provided _PSD data
[   19.169540] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - ve=
rsion 5.1.0-k
[   19.177667] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   19.339570] ixgbe 0000:07:00.0: Multiqueue Enabled: Rx Queue count =3D=
 32, Tx Queue count =3D 32 XDP Queue count =3D 0
[   19.350607] ixgbe 0000:07:00.0: 16.000 Gb/s available PCIe bandwidth, =
limited by 5 GT/s x4 link at 0000:00:0d.0 (capable of 32.000 Gb/s with 5 =
GT/s x8 link)
[   19.365075] ixgbe 0000:07:00.0: MAC: 2, PHY: 20, SFP+: 5, PBA No: E665=
60-003
[   19.372387] ixgbe 0000:07:00.0: 00:1b:21:87:2a:fc
[   19.380509] ixgbe 0000:07:00.0: Intel(R) 10 Gigabit Network Connection=

[   19.387872] libphy: ixgbe-mdio: probed
[   19.551822] kvm: Nested Virtualization enabled
[   19.556470] kvm: Nested Paging enabled
[   20.525368] ixgbe 0000:07:00.1: Multiqueue Enabled: Rx Queue count =3D=
 32, Tx Queue count =3D 32 XDP Queue count =3D 0
[   20.536240] ixgbe 0000:07:00.1: 16.000 Gb/s available PCIe bandwidth, =
limited by 5 GT/s x4 link at 0000:00:0d.0 (capable of 32.000 Gb/s with 5 =
GT/s x8 link)
[   20.550870] ixgbe 0000:07:00.1: MAC: 2, PHY: 1, PBA No: E66560-003
[   20.557324] ixgbe 0000:07:00.1: 00:1b:21:87:2a:fd
[   20.564689] ixgbe 0000:07:00.1: Intel(R) 10 Gigabit Network Connection=

[   20.571511] libphy: ixgbe-mdio: probed
[   24.092920] e1000e 0000:03:00.0 net00: renamed from eth0
[   24.115654] e1000e 0000:04:00.0 net01: renamed from eth1
[   24.128452] ixgbe 0000:07:00.0 net02: renamed from eth2
[   24.142508] ixgbe 0000:07:00.1 net03: renamed from eth3
[   24.857068] ixgbe 0000:07:00.0: registered PHC device on net02
[   25.028720] ixgbe 0000:07:00.0 net02: detected SFP+: 5
[   25.413660] 8021q: 802.1Q VLAN Support v1.8
[   25.413677] 8021q: adding VLAN 0 to HW filter on device net02
[   25.487811] ixgbe 0000:07:00.0 net02: NIC Link is Up 10 Gbps, Flow Con=
trol: RX/TX
[   26.312883] XFS (sda2): Mounting V4 Filesystem
[   26.490854] XFS (sda2): Ending clean mount
[   26.504294] XFS (sdb): Mounting V4 Filesystem
[   26.633277] XFS (sdb): Ending clean mount
[   27.378369] svc: failed to register lockdv1 RPC service (errno 97).
[   27.658786] NFSD: starting 45-second grace period (net f0000098)
[   30.837051] IPv6: ADDRCONF(NETDEV_UP): vlan.tor0: link is not ready
[   30.837058] IPv6: ADDRCONF(NETDEV_CHANGE): vlan.tor0: link becomes rea=
dy
[   59.817887] FS-Cache: Netfs 'nfs' registered for caching
[   60.188465] NFS: Registering the id_resolver key type
[   60.188476] Key type id_resolver registered
[   60.188477] Key type id_legacy registered

--------------F50DDD6653283D174A6F3EC7--

--------------ms040907090603090101090106
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAxMTAxNjQ5MjNaMC8GCSqGSIb3DQEJBDEiBCDG0Hsp7ZmbC/IRv2CH
Uzr5giXFCj4GINvDLRcAkIthdDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAJd4
Gt5uWYTKkH08JFlGm6ZRwQDwmytqLw39wVQ13fcpj82cu2p2GfTS6maV07VjiD+UX05RpJj0
xVCzNhLNmlpqGeP9IBxucq9Ljx5UhkBR7SEjtHekyiwsKINBlDNwo8hHF1ZxsW1//LPF3yPi
Nmk/zuOLbjk/n9+SbPNANwrP476rvoI9f31eKME5j7bAVUHJ8NgUPi0gUiMegOyW90ic6ljn
jg0NwcqGP/B07FNp5GdhoPPoNxEAlO8q+uDk0fMdlS7QcDYO3XXhGmNMrctqmlJ5inOMdVw2
ZouFE9zSg8VZo9ghUqxRvRtuuvlL692x06othEz2Yz+evD/xu0gAAAAAAAA=
--------------ms040907090603090101090106--
