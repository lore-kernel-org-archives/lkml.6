Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F220661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oU9ttSQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeH3WzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:55:13 -0400
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:15682
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeH3WzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftd9O4As9JS3tLzyUlCURmxKB2TCw9Dbe1YaQHaYYDM=;
 b=oU9ttSQOvAlb9UrZyQZac8PyEgjLi9DMvQfQTHj6WyYo3oVy6zNv9dq9/4aQDTOGaB6ige4IBs+ohxtG9unMfc4n0n/+ej8bD3Xe2Kj6gKqpJ4FXaOz8V4W3se3krdPIV/n9+QUzW16e9aOrkY2FSm/Q2gH5o/xZDap7ulDSSv0=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1067.namprd21.prod.outlook.com (52.132.149.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 18:51:16 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1%4]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 18:51:16 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v2 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Topic: [PATCH v2 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUP68UqawVYiUjRkuMvWx42onNGqTYnk4A
Date:   Thu, 30 Aug 2018 18:51:16 +0000
Message-ID: <MW2PR2101MB11135AA9A2CBCA230B75CE4DA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1535556148-10452-3-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.136.232.39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:NkqUtbcbJ5KhSmjBZZ5hHEO0LIJ7nzFkTdtZfGvOKLXNKiibmytTM/hJOwM8R0FicX5jWmQHd5XBtrOX8yod1GgAnflvycB87+PXnub3g61sExJct0u0oLP5BGAMH9bw/xEeDbPnurEZFCuAhvYfTXjexl8TcJshMnXE5JBbh5kD9qFESx+TidWyEHCrcuaKrhqJom21ty/TDAJlmfTgD2/kXNCn4fXyD/w228H3IPzPtYygzu1VhubRVI8OEVPsaUJtbx5OH05pu2YKJXqG7lWx+KRYHQ6PAoGou8HauIo3jHV+/3j2hb+Gcm1FUXsbhCqyzSipR030J0RzziSppunosKwirZzEwO/OxLQ9r2fR6Z8yZ4sQTOAQ4E8mMJxfBh6FaAuRPB3uGvzhCNPur5zc1ClbdRvauAD57ReITm/yF5xfFYhpJ3YHSYsN/xQxQzXWu7BwC0Y5yIW+qzDoDQ==;5:iBl3cKlQn3QCO0YwE4CqF7T9pgQY3IxEwaE8x+B9orowyp54qJT24IFpHm8uK3KmIDXPoX0sWZJF4Lp1r81CKGTW1/SVltx7bb4Ex1BDKZSb5ojcoogAHPvL103uzim6IM0i20HsUYx1+PqUsGrhW3sHEpJQp0/Z0du5hHVY+ig=;7:UVX96yJmJ03G9zWz6aGV+19vSY0sp5r0dNhHRQOTzjkfXZH3ppzaa4eA5TJS/prGqQRhMyNp/JGINLuJo685LDRhdb359P/oCqflayTInUTpbn4LOAbSQYNDOktXjewaODYq1lKfz0MCsC203tHwSOp0twv5Z3lWH+Cyu1Wvwbk6pyLRRD3x6hHRe9OL3qQgzbdfOdxc9vPMZ77LsD/shrsN9Tej816x2EI8Ny/BL9gMRu3SuD/bDag3gVrJzGNc
x-ms-office365-filtering-correlation-id: e171f7ff-24ef-40db-e426-08d60ea99140
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1067DFD8CCA0D75B1D08A8E8A0080@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(85827821059158)(258649278758335)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(13464003)(199004)(189003)(9686003)(86362001)(6246003)(2900100001)(3846002)(6116002)(7696005)(68736007)(305945005)(26005)(1511001)(105586002)(7736002)(102836004)(106356001)(76176011)(74316002)(14454004)(66066001)(97736004)(2201001)(53546011)(6506007)(25786009)(2906002)(55016002)(53946003)(8936002)(6436002)(476003)(10290500003)(81166006)(110136005)(7416002)(5250100002)(2501003)(81156014)(8676002)(53936002)(486006)(22452003)(229853002)(86612001)(446003)(478600001)(33656002)(5660300001)(99286004)(316002)(256004)(14444005)(6636002)(11346002)(8990500004)(10090500001)(2004002)(921003)(1121003)(579004)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vc8iWtXrmWn2L8cVbYBuGGMT4UT6EzdUflVEwf5PaOp36IhBbopHElCARNJMwmNXRUByacRuXWQqyjhati3GjJ7zhjiPgg26rQwG0yoBDykyihdwatA3wrh70OBZ9SYSMwqhWry7iu/BWPU87CcffsD3EQTjke77Pv/Rbm+ijlHF8/ASnO+h2mbh/mI32UniGeBSg3+fihtzlPfq6Lf5S5rYkJaaTuE80Utqo9nsBRAOGShDpOQhePbwK9Wic2Unq1AgR6PPbXIyqy4n+6DdKODpzk1dH+81tqA2OP1nr49XM0NX04Hy0djjMVr3YVzMXggOvGiZc/2AOAyhtyl+Zz6lJ0h13hSV2mbPuZh7CSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e171f7ff-24ef-40db-e426-08d60ea99140
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 18:51:16.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: mhkelley58@gmail.com <mhkelley58@gmail.com>
> Sent: Wednesday, August 29, 2018 10:22 AM
> To: will.deacon@arm.com; catalin.marinas@arm.com;
> mark.rutland@arm.com; marc.zyngier@arm.com; linux-arm-
> kernel@lists.infradead.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets <vkuznets@redhat.com>;
> jasowang@redhat.com; marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Subject: [PATCH v2 2/4] arm64: hyperv: Add support for Hyper-V as a
> hypervisor
>=20
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> Add ARM64-specific code to enable Hyper-V. This code includes:
> * Detecting Hyper-V and initializing the guest/Hyper-V interface
> * Setting up Hyper-V's synthetic clocks
> * Making hypercalls using the HVC instruction
> * Setting up VMbus and stimer0 interrupts
> * Setting up kexec and crash handlers
> This code is architecture dependent code and is mostly driven by
> architecture independent code in the VMbus driver in drivers/hv/hv.c
> and drivers/hv/vmbus_drv.c.
>=20
> This code is built only when CONFIG_HYPERV is enabled.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: James Morris <jmorris@namei.org>
> ---
>  MAINTAINERS                  |   1 +
>  arch/arm64/Makefile          |   1 +
>  arch/arm64/hyperv/Makefile   |   2 +
>  arch/arm64/hyperv/hv_hvc.S   |  54 ++++++
>  arch/arm64/hyperv/hv_init.c  | 437
> +++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c | 178 ++++++++++++++++++
>  6 files changed, 673 insertions(+)
>  create mode 100644 arch/arm64/hyperv/Makefile
>  create mode 100644 arch/arm64/hyperv/hv_hvc.S
>  create mode 100644 arch/arm64/hyperv/hv_init.c
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8db9be..3adf83c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6777,6 +6777,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
>  F:	arch/x86/hyperv
>  F:	arch/arm64/include/asm/hyperv-tlfs.h
>  F:	arch/arm64/include/asm/mshyperv.h
> +F:	arch/arm64/hyperv
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d..af1bcfc 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -106,6 +106,7 @@ core-y		+=3D arch/arm64/kernel/
> arch/arm64/mm/
>  core-$(CONFIG_NET) +=3D arch/arm64/net/
>  core-$(CONFIG_KVM) +=3D arch/arm64/kvm/
>  core-$(CONFIG_XEN) +=3D arch/arm64/xen/
> +core-$(CONFIG_HYPERV) +=3D arch/arm64/hyperv/
>  core-$(CONFIG_CRYPTO) +=3D arch/arm64/crypto/
>  libs-y		:=3D arch/arm64/lib/ $(libs-y)
>  core-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> new file mode 100644
> index 0000000..988eda5
> --- /dev/null
> +++ b/arch/arm64/hyperv/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y		:=3D hv_init.o hv_hvc.o mshyperv.o
> diff --git a/arch/arm64/hyperv/hv_hvc.S b/arch/arm64/hyperv/hv_hvc.S
> new file mode 100644
> index 0000000..8263696
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_hvc.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Microsoft Hyper-V hypervisor invocation routines
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */
> +
> +#include <linux/linkage.h>
> +
> +	.text
> +/*
> + * Do the HVC instruction.  For Hyper-V the argument is always 1.
> + * x0 contains the hypercall control value, while additional registers
> + * vary depending on the hypercall, and whether the hypercall arguments
> + * are in memory or in registers (a "fast" hypercall per the Hyper-V
> + * TLFS).  When the arguments are in memory x1 is the guest physical
> + * address of the input arguments, and x2 is the guest physical
> + * address of the output arguments.  When the arguments are in
> + * registers, the register values depends on the hypercall.  Note
> + * that this version cannot return any values in registers.
> + */
> +ENTRY(hv_do_hvc)
> +	hvc #1
> +	ret
> +ENDPROC(hv_do_hvc)
> +
> +/*
> + * This variant of HVC invocation is for hv_get_vpreg and
> + * hv_get_vpreg_128. The input parameters are passed in registers
> + * along with a pointer in x4 to where the output result should
> + * be stored. The output is returned in x15 and x16.  x18 is used as
> + * scratch space to avoid buildng a stack frame, as Hyper-V does
> + * not preserve registers x0-x17.
> + */
> +ENTRY(hv_do_hvc_fast_get)
> +	mov x18, x4
> +	hvc #1
> +	str x15,[x18]
> +	str x16,[x18,#8]
> +	ret
> +ENDPROC(hv_do_hvc_fast_get)
> diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
> new file mode 100644
> index 0000000..671d854
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_init.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Initialization of the interface with Microsoft's Hyper-V hypervisor,
> + * and various low level utility routines for interacting with Hyper-V.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */
> +
> +
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/export.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clocksource.h>
> +#include <linux/sched_clock.h>
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/psci.h>
> +#include <asm-generic/bug.h>
> +#include <asm/hypervisor.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv.h>
> +#include <asm/sysreg.h>
> +#include <clocksource/arm_arch_timer.h>
> +
> +static bool	hyperv_initialized;
> +struct		ms_hyperv_info ms_hyperv;
> +EXPORT_SYMBOL_GPL(ms_hyperv);
> +
> +static struct ms_hyperv_tsc_page *tsc_pg;
> +
> +struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> +{
> +	return tsc_pg;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_tsc_page);
> +
> +static u64 read_hv_sched_clock_tsc(void)
> +{
> +	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
> +
> +	if (current_tick =3D=3D U64_MAX)
> +		current_tick =3D hv_get_vpreg(HvRegisterTimeRefCount);
> +
> +	return current_tick;
> +}
> +
> +static u64 read_hv_clock_tsc(struct clocksource *arg)
> +{
> +	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
> +
> +	if (current_tick =3D=3D U64_MAX)
> +		current_tick =3D hv_get_vpreg(HvRegisterTimeRefCount);
> +
> +	return current_tick;
> +}
> +
> +static struct clocksource hyperv_cs_tsc =3D {
> +		.name		=3D "hyperv_clocksource_tsc_page",
> +		.rating		=3D 400,
> +		.read		=3D read_hv_clock_tsc,
> +		.mask		=3D CLOCKSOURCE_MASK(64),
> +		.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static u64 read_hv_sched_clock_msr(void)
> +{
> +	return hv_get_vpreg(HvRegisterTimeRefCount);
> +}
> +
> +static u64 read_hv_clock_msr(struct clocksource *arg)
> +{
> +	return hv_get_vpreg(HvRegisterTimeRefCount);
> +}
> +
> +static struct clocksource hyperv_cs_msr =3D {
> +	.name		=3D "hyperv_clocksource_msr",
> +	.rating		=3D 400,
> +	.read		=3D read_hv_clock_msr,
> +	.mask		=3D CLOCKSOURCE_MASK(64),
> +	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +struct clocksource *hyperv_cs;
> +EXPORT_SYMBOL_GPL(hyperv_cs);
> +
> +u32 *hv_vp_index;
> +EXPORT_SYMBOL_GPL(hv_vp_index);
> +
> +u32 hv_max_vp_index;
> +
> +static int hv_cpu_init(unsigned int cpu)
> +{
> +	u64 msr_vp_index;
> +
> +	hv_get_vp_index(msr_vp_index);
> +
> +	hv_vp_index[smp_processor_id()] =3D msr_vp_index;
> +
> +	if (msr_vp_index > hv_max_vp_index)
> +		hv_max_vp_index =3D msr_vp_index;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function is invoked via the ACPI clocksource probe mechanism. We
> + * don't actually use any values from the ACPI GTDT table, but we set up
> + * the Hyper-V synthetic clocksource and do other initialization for
> + * interacting with Hyper-V the first time.  Using early_initcall to inv=
oke
> + * this function is too late because interrupts are already enabled at t=
hat
> + * point, and sched_clock_register must run before interrupts are enable=
d.
> + *
> + * 1. Setup the guest ID.
> + * 2. Get features and hints info from Hyper-V
> + * 3. Setup per-cpu VP indices.
> + * 4. Register Hyper-V specific clocksource.
> + * 5. Register the scheduler clock.
> + */
> +
> +static int __init hyperv_init(struct acpi_table_header *table)
> +{
> +	struct hv_get_vp_register_output result;
> +	u32	a, b, c, d;
> +	u64	guest_id;
> +
> +	/*
> +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> +	 * have the string "MsHyperV".
> +	 */
> +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +		return 1;
> +
> +	/* Setup the guest ID */
> +	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	hv_set_vpreg(HvRegisterGuestOsId, guest_id);
> +
> +	/* Get the features and hints from Hyper-V */
> +	hv_get_vpreg_128(HvRegisterPrivilegesAndFeaturesInfo, &result);
> +	ms_hyperv.features =3D lower_32_bits(result.registervaluelow);
> +	ms_hyperv.misc_features =3D upper_32_bits(result.registervaluehigh);
> +
> +	hv_get_vpreg_128(HvRegisterFeaturesInfo, &result);
> +	ms_hyperv.hints =3D lower_32_bits(result.registervaluelow);
> +
> +	pr_info("Hyper-V: Features 0x%x, hints 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.hints);
> +
> +	/*
> +	 * Direct mode is the only option for STIMERs provided Hyper-V
> +	 * on ARM64, so Hyper-V doesn't actually set the flag.  But add the
> +	 * flag so the architecture independent code in drivers/hv/hv.c
> +	 * will correctly use that mode.
> +	 */
> +	ms_hyperv.misc_features |=3D
> HV_STIMER_DIRECT_MODE_AVAILABLE;
> +
> +	/*
> +	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
> +	 * that tells architecture independent code not to use this
> +	 * feature.
> +	 */
> +	ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
> +
> +	/* Get information about the Hyper-V host version */
> +	hv_get_vpreg_128(HvRegisterHypervisorVersion, &result);
> +	a =3D lower_32_bits(result.registervaluelow);
> +	b =3D upper_32_bits(result.registervaluelow);
> +	c =3D lower_32_bits(result.registervaluehigh);
> +	d =3D upper_32_bits(result.registervaluehigh);
> +	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
> +
> +	/* Allocate percpu VP index */
> +	hv_vp_index =3D kmalloc_array(num_possible_cpus(),
> sizeof(*hv_vp_index),
> +				    GFP_KERNEL);
> +	if (!hv_vp_index)
> +		return 1;
> +
We should perhaps set the array so the contents are invalid so we can corre=
ctly
handle enlightenments for TL shootdown and IPI.

> +	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> "arm64/hyperv_init:online",
> +			      hv_cpu_init, NULL) < 0)
> +		goto free_vp_index;
> +
> +	/*
> +	 * Try to set up what Hyper-V calls the "TSC reference page", which
> +	 * uses the ARM Generic Timer virtual counter with some scaling
> +	 * information to provide a fast and stable guest VM clocksource.
> +	 * If the TSC reference page can't be set up, fall back to reading
> +	 * the guest clock provided by Hyper-V's synthetic reference time
> +	 * register.
> +	 */
> +	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
> +
> +		u64		tsc_msr;
> +		phys_addr_t	phys_addr;
> +
> +		tsc_pg =3D __vmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL,
> PAGE_KERNEL);
> +		if (tsc_pg) {
> +			phys_addr =3D
> page_to_phys(vmalloc_to_page(tsc_pg));
> +			tsc_msr =3D hv_get_vpreg(HvRegisterReferenceTsc);
> +			tsc_msr &=3D GENMASK_ULL(11, 0);
> +			tsc_msr =3D tsc_msr | 0x1 | (u64)phys_addr;
> +			hv_set_vpreg(HvRegisterReferenceTsc, tsc_msr);
> +			hyperv_cs =3D &hyperv_cs_tsc;
> +			sched_clock_register(read_hv_sched_clock_tsc,
> +						64, HV_CLOCK_HZ);
> +		}
> +	}
> +
> +	if (!hyperv_cs &&
> +	    (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
> {
> +		hyperv_cs =3D &hyperv_cs_msr;
> +		sched_clock_register(read_hv_sched_clock_msr,
> +						64, HV_CLOCK_HZ);
> +	}
> +
> +	if (hyperv_cs) {
> +		hyperv_cs->archdata.vdso_direct =3D false;
> +		clocksource_register_hz(hyperv_cs, HV_CLOCK_HZ);
> +	}
> +
> +	hyperv_initialized =3D true;
> +	return 0;
> +
> +free_vp_index:
> +	kfree(hv_vp_index);
> +	hv_vp_index =3D NULL;
> +	return 1;
> +}
> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
> +
> +/*
> + * This routine is called before kexec/kdump, it does the required clean=
up.
> + */
> +void hyperv_cleanup(void)
> +{
> +	/* Reset our OS id */
> +	hv_set_vpreg(HvRegisterGuestOsId, 0);
> +
> +}
> +EXPORT_SYMBOL_GPL(hyperv_cleanup);
> +
> +/*
> + * hv_do_hypercall- Invoke the specified hypercall
> + */
> +u64 hv_do_hypercall(u64 control, void *input, void *output)
> +{
> +	u64 input_address;
> +	u64 output_address;
> +
> +	input_address =3D input ? virt_to_phys(input) : 0;
> +	output_address =3D output ? virt_to_phys(output) : 0;
> +	return hv_do_hvc(control, input_address, output_address);
> +}
> +EXPORT_SYMBOL_GPL(hv_do_hypercall);
> +
> +/*
> + * hv_do_fast_hypercall8 -- Invoke the specified hypercall
> + * with arguments in registers instead of physical memory.
> + * Avoids the overhead of virt_to_phys for simple hypercalls.
> + */
> +
> +u64 hv_do_fast_hypercall8(u16 code, u64 input)
> +{
> +	u64 control;
> +
> +	control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	return hv_do_hvc(control, input);
> +}
> +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
> +
> +
> +/*
> + * Set a single VP register to a 64-bit value.
> + */
> +void hv_set_vpreg(u32 msr, u64 value)
> +{
> +	union hv_hypercall_status status;
> +
> +	status.as_uint64 =3D hv_do_hvc(
> +		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> +			HV_HYPERCALL_REP_COUNT_1,
> +		HV_PARTITION_ID_SELF,
> +		HV_VP_INDEX_SELF,
> +		msr,
> +		0,
> +		value,
> +		0);
> +
> +	/*
> +	 * Something is fundamentally broken in the hypervisor if
> +	 * setting a VP register fails. There's really no way to
> +	 * continue as a guest VM, so panic.
> +	 */
> +	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
> +}
> +EXPORT_SYMBOL_GPL(hv_set_vpreg);
> +
> +
> +/*
> + * Get the value of a single VP register, and only the low order 64 bits=
.
> + */
> +u64 hv_get_vpreg(u32 msr)
> +{
> +	union hv_hypercall_status status;
> +	struct hv_get_vp_register_output output;
> +
> +	status.as_uint64 =3D hv_do_hvc_fast_get(
> +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> +			HV_HYPERCALL_REP_COUNT_1,
> +		HV_PARTITION_ID_SELF,
> +		HV_VP_INDEX_SELF,
> +		msr,
> +		&output);
> +
> +	/*
> +	 * Something is fundamentally broken in the hypervisor if
> +	 * getting a VP register fails. There's really no way to
> +	 * continue as a guest VM, so panic.
> +	 */
> +	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
> +
> +	return output.registervaluelow;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vpreg);
> +
> +/*
> + * Get the value of a single VP register that is 128 bits in size.  This=
 is a
> + * separate call in order to avoid complicating the calling sequence for
> + * the much more frequently used 64-bit version.
> + */
> +void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output
> *result)
> +{
> +	union hv_hypercall_status status;
> +
> +	status.as_uint64 =3D hv_do_hvc_fast_get(
> +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> +			HV_HYPERCALL_REP_COUNT_1,
> +		HV_PARTITION_ID_SELF,
> +		HV_VP_INDEX_SELF,
> +		msr,
> +		result);
> +
> +	/*
> +	 * Something is fundamentally broken in the hypervisor if
> +	 * getting a VP register fails. There's really no way to
> +	 * continue as a guest VM, so panic.
> +	 */
> +	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
> +
> +	return;
> +
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
> +
> +void hyperv_report_panic(struct pt_regs *regs, long err)
> +{
> +	static bool panic_reported;
> +	u64 guest_id;
> +
> +	/*
> +	 * We prefer to report panic on 'die' chain as we have proper
> +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> +	 * to report it on 'panic'.
> +	 */
> +	if (panic_reported)
> +		return;
> +	panic_reported =3D true;
> +
> +	guest_id =3D hv_get_vpreg(HvRegisterGuestOsId);
> +
> +	/*
> +	 * Hyper-V provides the ability to store only 5 values.
> +	 * Pick the passed in error value, the guest_id, and the PC.
> +	 * The first two general registers are added arbitrarily.
> +	 */
> +	hv_set_vpreg(HvRegisterCrashP0, err);
> +	hv_set_vpreg(HvRegisterCrashP1, guest_id);
> +	hv_set_vpreg(HvRegisterCrashP2, regs->pc);
> +	hv_set_vpreg(HvRegisterCrashP3, regs->regs[0]);
> +	hv_set_vpreg(HvRegisterCrashP4, regs->regs[1]);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available
> +	 */
> +	hv_set_vpreg(HvRegisterCrashCtl, HV_CRASH_CTL_CRASH_NOTIFY);
> +}
> +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> +
> +/*
> + * hyperv_report_panic_msg - report panic message to Hyper-V
> + * @pa: physical address of the panic page containing the message
> + * @size: size of the message in the page
> + */
> +void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
> +{
> +	/*
> +	 * P3 to contain the physical address of the panic page & P4 to
> +	 * contain the size of the panic data in that page. Rest of the
> +	 * registers are no-op when the NOTIFY_MSG flag is set.
> +	 */
> +	hv_set_vpreg(HvRegisterCrashP0, 0);
> +	hv_set_vpreg(HvRegisterCrashP1, 0);
> +	hv_set_vpreg(HvRegisterCrashP2, 0);
> +	hv_set_vpreg(HvRegisterCrashP3, pa);
> +	hv_set_vpreg(HvRegisterCrashP4, size);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available along with
> +	 * the panic message.
> +	 */
> +	hv_set_vpreg(HvRegisterCrashCtl,
> +	       (HV_CRASH_CTL_CRASH_NOTIFY |
> HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> +}
> +EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
> +
> +bool hv_is_hyperv_initialized(void)
> +{
> +	return hyperv_initialized;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> diff --git a/arch/arm64/hyperv/mshyperv.c
> b/arch/arm64/hyperv/mshyperv.c
> new file mode 100644
> index 0000000..3ef0555
> --- /dev/null
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Core routines for interacting with Microsoft's Hyper-V hypervisor,
> + * including setting up VMbus and STIMER interrupts, and handling
> + * crashes and kexecs. These interactions are through a set of
> + * static "handler" variables set by the architecture independent
> + * VMbus and STIMER drivers.  This design is used to meet x86/x64
> + * requirements for avoiding direct linkages and allowing the VMbus
> + * and STIMER drivers to be unloaded and reloaded.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/interrupt.h>
> +#include <linux/kexec.h>
> +#include <linux/acpi.h>
> +#include <linux/ptrace.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv.h>
> +
> +static void (*vmbus_handler)(void);
> +static void (*hv_stimer0_handler)(void);
> +static void (*hv_kexec_handler)(void);
> +static void (*hv_crash_handler)(struct pt_regs *regs);
> +
> +static int vmbus_irq;
> +static long __percpu *vmbus_evt;
> +static long __percpu *stimer0_evt;
> +
> +irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
> +{
> +	if (vmbus_handler)
> +		vmbus_handler();
> +	return IRQ_HANDLED;
> +}
> +
> +/* Must be done just once */
> +void hv_setup_vmbus_irq(void (*handler)(void))
> +{
> +	int result;
> +
> +	vmbus_handler =3D handler;
> +	vmbus_irq =3D acpi_register_gsi(NULL,
> HYPERVISOR_CALLBACK_VECTOR,
> +				 ACPI_LEVEL_SENSITIVE,
> ACPI_ACTIVE_HIGH);
> +	if (vmbus_irq <=3D 0) {
> +		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
> +			vmbus_irq);
> +		vmbus_irq =3D 0;
> +		return;
> +	}
> +	vmbus_evt =3D alloc_percpu(long);
> +	result =3D request_percpu_irq(vmbus_irq, hyperv_vector_handler,
> +			"Hyper-V VMbus", vmbus_evt);
> +	if (result) {
> +		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
> +			vmbus_irq, result);
> +		free_percpu(vmbus_evt);
> +		acpi_unregister_gsi(vmbus_irq);
> +		vmbus_irq =3D 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
> +
> +/* Must be done just once */
> +void hv_remove_vmbus_irq(void)
> +{
> +	if (vmbus_irq) {
> +		free_percpu_irq(vmbus_irq, vmbus_evt);
> +		free_percpu(vmbus_evt);
> +		acpi_unregister_gsi(vmbus_irq);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
> +
> +/* Must be done by each CPU */
> +void hv_enable_vmbus_irq(void)
> +{
> +	enable_percpu_irq(vmbus_irq, 0);
> +}
> +EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
> +
> +/* Must be done by each CPU */
> +void hv_disable_vmbus_irq(void)
> +{
> +	disable_percpu_irq(vmbus_irq);
> +}
> +EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
> +
> +/* Routines to do per-architecture handling of STIMER0 when in Direct
> Mode */
> +
> +static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
> +{
> +	if (hv_stimer0_handler)
> +		hv_stimer0_handler();
> +	return IRQ_HANDLED;
> +}
> +
> +int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
> +{
> +	int localirq;
> +	int result;
> +
> +	localirq =3D acpi_register_gsi(NULL, HV_STIMER0_IRQNR,
> +			ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> +	if (localirq <=3D 0) {
> +		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
> +			localirq);
> +		*irq =3D 0;
> +		return -1;
> +	}
> +	stimer0_evt =3D alloc_percpu(long);
> +	result =3D request_percpu_irq(localirq, hv_stimer0_vector_handler,
> +					 "Hyper-V stimer0", stimer0_evt);
> +	if (result) {
> +		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
> +			localirq, result);
> +		free_percpu(stimer0_evt);
> +		acpi_unregister_gsi(localirq);
> +		*irq =3D 0;
> +		return -1;
> +	}
> +
> +	hv_stimer0_handler =3D handler;
> +	*vector =3D HV_STIMER0_IRQNR;
> +	*irq =3D localirq;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
> +
> +void hv_remove_stimer0_irq(int irq)
> +{
> +	hv_stimer0_handler =3D NULL;
> +	if (irq) {
> +		free_percpu_irq(irq, stimer0_evt);
> +		free_percpu(stimer0_evt);
> +		acpi_unregister_gsi(irq);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
> +
> +void hv_setup_kexec_handler(void (*handler)(void))
> +{
> +	hv_kexec_handler =3D handler;
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> +
> +void hv_remove_kexec_handler(void)
> +{
> +	hv_kexec_handler =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> +
> +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> +{
> +	hv_crash_handler =3D handler;
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> +
> +void hv_remove_crash_handler(void)
> +{
> +	hv_crash_handler =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> --
> 1.8.3.1

