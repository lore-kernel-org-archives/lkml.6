Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C402ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F2214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LmCdcESk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45F2214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJQTdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:33:43 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:47069
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbeJQTdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii6grIvXaTGCxaolnBzms4MuV4QAj9tKhkJLKB4iLSI=;
 b=LmCdcESk1GBaUJe1yhONUS60QIa4H3MqxM980HgeeGHoYw50RzlxsZvbaOQ1uHrOeB6PnqAzqZsfs4O41u73A7tPm9bObNOVkNj9j1Uwhrs4M498AMtxPqK3KUSuUXfm7WAfNZPuE8ELX0gpCM9qoP+QfLJNbr9na2+t08Efw2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.50) by
 AM0PR08MB2980.eurprd08.prod.outlook.com (2603:10a6:208:5b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 11:38:19 +0000
Date:   Wed, 17 Oct 2018 12:38:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH]  arm64/pvpanic-mmio : add pvpanic mmio device
Message-ID: <20181017113816.6kub42pii5hev6fh@lakrids.cambridge.arm.com>
References: <1539770903-18531-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539770903-18531-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: CWLP265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:51::29) To AM0PR08MB2980.eurprd08.prod.outlook.com
 (2603:10a6:208:5b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9afb10-a024-4541-d1c4-08d634250970
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB2980;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2980;3:rn/HAPjo3OodMwwcFNrLyu2gz5F2Xr2MQRGXqYEjp1vEhc3Ndae+Pq9gAehhUQK0UdSJyCjNfEoGl7Q2kNC1N87ADatdfvyIFuqC5ZpOrP37Ubyip6vtAIlGTE8rEbIAYsMTWh/Y7NRa9X4xS7DLH6LydJjRSEwI/Mql9glRcp0HXfOD07C6iRSI932uwr/6pc41QIdVwJx6eA2oItwTw37Mq5KSfzFHsQQnEJQvNcGHzvAWZPREbgBEAjoWhvyh;25:EH+UjBe0hjvtTd7WkKZisBS4fwzRcLyCN8KAtniTOANqApjoJkjRPtAZtvGP8HdngyqEgnDJpPjTQQMUzWsg2M+7RWbyOHGFdNM9LurMLfDIMyFPOCbhzNJzhjMyo2BAMIhfB2OlXBzkeEZ4kLD3vQJwUhbyDA+rCDA1oGxhqQU16HRXhcrUHP0sRUcfiN/GfDK0HTvslNK14SlU6cuQBa2pn07nMRsvG2PltLwji1qGMi+bL9dnJ4aTNkDnEcndGEmhYhgoPNHxE47sKxFOAhwil/4FrOIzBpWvhiSWLu/dH94OXrAjG3iZ0LyqEsRzMaP/I45+adWwRnQSXy2/Tg==;31:8tZXo1+MURhIerxv0BvDXkh77QwzyYpzw+y6PnaVJtdLUOxn03VjhiicYTE2GUAU1LauEMfe85M32Jz1o/nXu1wE+6BfCPa1I1xAzVhhI7SJKRFfGtlc3NHq8pt94f3l22M7otTxsIv3haqzVVyrdNK3JHEpjFs7FVGDPJWRCmL/ufK8HXpQbfIoCrPona/XXxNVBP1SZEAUIv1oM2aKp1wECv7JivzvjIqM40f8zCc=
X-MS-TrafficTypeDiagnostic: AM0PR08MB2980:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2980;20:f6mA3fPWHaWrN/oiuhzT6kvd+NZ9anG+rbIcHvUq6uy/+U4uAAWr+ajMcQa78aaSarnKNjmzrk36HDFO3+g9XBo6LfIfUIoNmnEBXTJiT7R44FQdSdsn13jdBBDrXzrUItBfORTcJ80BL1Zzgtwjry3vPsyG731ck7M9RrBc4DRbtmZVw2LtlUrPOYfSZ5nmlkFYK/Tft8JrR6jThX/1OBC+IS0b8Bdpjg8PQBooiBWpBQVTjz+6o6Kw0deHiZFwaW01C27+k4SYzrJIVjbsrkF0Nzqgbs2rwhB3Jt/in+v9nmCqWYqImzZ2c6HueP5F2i3CZ2W1Jez1wR9q66CYraqnsp0fB/FVwfY0WzxsLaklWJePzPxZRZxCuAwB/Nj2lJIY4mtGqC1kaMehH3itrk7ll2qZ1Q2PhQdlh8LtxrY=;4:LgRhHQG8pHwJvegVa932+IBfQVg+hrQFDF0ikVKyqrqYDa1T7ar+p72pb3LHAly4Y4T+PnKDo8PT8sIj3vUiW4TRZAoQbUd5Ba3TVJRTJXHOuUgfye+ToqKXxd1QVwctdw+zdUts4xukEO0Qf59LDs55dNatXfLv1cYSG8L4l0jLl34eVm5QHG17CvHtCj6/DZLJo+TJBsLT6AmbWtgizPBH0BzHifCHh7l2Jr6tUaVyel5gKoeujBLo5+EIB3pf79x1NcXOFofnswVjRvjh0SRWQYsQBt4oPBdJbx9cR6I4uGqu0DtJtd/KLEhtklUEfR6NtoGDzz+5zDYCctkGbnD1+gc4Odgv7QcJrpO16RY=
X-Microsoft-Antispam-PRVS: <AM0PR08MB2980284BBC6385CC3998B06484FF0@AM0PR08MB2980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(4982022)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB2980;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB2980;
X-Forefront-PRVS: 08286A0BE2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(189003)(7696005)(11346002)(52116002)(66066001)(76176011)(86362001)(16526019)(16586007)(305945005)(68736007)(7736002)(97736004)(956004)(58126008)(6306002)(26005)(6666004)(72206003)(25786009)(4326008)(386003)(446003)(47776003)(50466002)(476003)(186003)(5660300001)(486006)(105586002)(478600001)(6916009)(2906002)(106356001)(81156014)(14444005)(8676002)(81166006)(44832011)(1076002)(316002)(53936002)(6246003)(55016002)(8936002)(3846002)(23726003)(6116002)(229853002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB2980;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB2980;23:Gl8fHyHLSM7Ij6/mQg8WuTwev9MRW8xrZwJfnySD/?=
 =?us-ascii?Q?YjoPQGiuY5pbXCTfocAaWgHX8IFfw8mxY6plkyAobcTK3CMaxxHRjk/n1MQR?=
 =?us-ascii?Q?Crdz7W0sUNmbs+ZqMofB4On3ExwldtVHhQN6eaMKSEZ25Hl4pOMFOGhHZ9sA?=
 =?us-ascii?Q?keB7TRzL87ufv/B7VjdHJ11uCYQ4XN4mqB9fIPnwWjPp05rpsBgjHoYpc0mS?=
 =?us-ascii?Q?10+JZctI2Zsne1QoFqzP2DXZrcPg+A3jX8DXORNLt9wp4KJVYAGw3P/xpLgN?=
 =?us-ascii?Q?Qmfeap9fsBX4j1NXTpoLnKxwZ5haS/8wsfvDXWo7U8L7vVbiA1tMVZMWAb1m?=
 =?us-ascii?Q?c7mIRKuf43EJ7+w8puAirDtuLRWwsRxK/w7IkPapvW+7pqB+9FCexVykk0VQ?=
 =?us-ascii?Q?Ukpx4xX6QksC6ko8ZsqbrtGXdwtiZBduc5b9NatKaD2pO2ouc3IJOgBTARF8?=
 =?us-ascii?Q?Hsjn8kBJEeLFTzWv7n7TeOXEFoP6SJ9pPuZFx15KlE3F4g/HV2eVZlEzYO3K?=
 =?us-ascii?Q?jSfNvo9gvBn67pumjw6O8AcVknrvIxHkrVbPoqk4lvS5bmAvpRZqexwm48pX?=
 =?us-ascii?Q?O7Nn0/fSM6y/C8f6+HJQkrMFHUH9/vGLvvPaK89yuXwyCzeCqSkqqW1tXeHj?=
 =?us-ascii?Q?kO4SpR3FLNyNsQcoYrHzanQRMofmn3vAbmxZyHh4tf/KtzhiJwdurfW1c6Cz?=
 =?us-ascii?Q?kqZDkNUVwGLARFwcTTFtgUIJBtKLkCpDFkTHPwjlu2VyDBD/c3pg1+RB9y0e?=
 =?us-ascii?Q?l7mYhAyTjiY+av17+G0rr68IMKYS93+DwOdP1XSRi2Q6wdI3Z+hwcAwIGUq5?=
 =?us-ascii?Q?JE5xjCxixJ2RG2vP7lyqapdT2MVthydj4hrGOkHH88NbX7cWeMWSjXFJGK+e?=
 =?us-ascii?Q?Kgurlk17ffq3kzDYbuicgoz8YlAuJxWmAa5DMAP5Sqmo53sICOzqHfB/XtuI?=
 =?us-ascii?Q?b34YI/P7xrQBdgEa45akfQAKDnvo76K0M7f8pRrn9Uu1T1cjOywtEb4PuRU3?=
 =?us-ascii?Q?E9oFpznRyg0kAoHBdR5fCXssF291kXK+lsbvr/LIgYCMj1KiXSmtrs9MeqZk?=
 =?us-ascii?Q?CF7/EXEpnCPDSsskzH/zrfsvuC09k1ALN089lR7jVVYGV2vB0aH48QGGVGEy?=
 =?us-ascii?Q?UCYYajdyYmTaWwV2YrrDFabon42rTyE4RiZy69R+4hxjKMAGfwwIZRjfh3js?=
 =?us-ascii?Q?aRzFtx2Phc1DyNco3jQzqclCKJSkH/BAgg+DU6iu8YDFGJ2vb2vbZr77SWfG?=
 =?us-ascii?Q?iBGo1zW7xuNul4oKy0=3D?=
X-Microsoft-Antispam-Message-Info: uGcCcAbV1GGG5eH/2HeZDWlDBDDWrZ/rff53xjrhpwKiSeMNpilv1qABCQYeufVVqHuBfaKMNvZmG7sMFms0RsLZDonwpCNHXonAO80+F4Fx/ElZANbP4UE9nOv4vx9tWRADbmFz7XO2FdFEedQBE2ShBnGj5BI7AEkj/rQk9lQdOQc/cXeowfQkBai5kTGUzTFA3UKWGrNBjzTwg8Bjte7JLFtZuB0Yf6qtymzuwj/CKZWiR9MPaADIR30r9K+CSV/AbANDbU7TsQLda9oA+zxkkRjw8Ny+2oghAOBLbm6hCAxQXTFTA0r5LLzfooc8nhJndyE3tJQB37Pft+f4Hdl8JRCwsLiwUFUBIzOKu4c=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2980;6:roJoJTniPIjw7u5q0Ji8TDC3+WmjV9i7qD3v+JuCAgOyxNeS5bDuNR3TWpOBtN/XREdCNQJFNSmTlLlAV9FnJwgSktejoJKiuo9aoEUVXsm8jZCqq3HlCKVEQu489ZhqRmP+zVDzd2E5sGBr+smL2nWgE2t1WWe6tKJFyUW4yJAI3tEI780x7c6DO32exaII91mnGW/uxGdFLZrA+3peoFyxFdMNfCJBH0TaBsOURkC+qKE6D5insW+E+qpxvjPSkTVFE5VF7Ls6/pyC7/bWMVGHLZGyRoP055YC3lJWW3pzoA1LHisX2dK6pgUxxCW1iQsB6HjjpoNMyQutWGhmd4CWEyOG7xBaDGr3mwQXDoaLyLhlwL7aiFgmBZSdAXxZG+qjhLSorIrZL5tQu7Gg2Unn9sUMyjarVxqsUluWYhYDNa/duU4jO4fMwMwwf4bwnC9Eg63eedJUJqM2Wc9jmw==;5:CU4H8uP/w7u5BoAaZSB0yZZCUlTlf5OwU+cTtlqkMM8UYExcTJedjuyDYJ9+S3BYPcTrhNTn6MDf3Yo7GI4eMypUdHEsD4pepSXc+DewRvoOFFNGBusXjBkvIsQMZn2rgSlAHhswEOnOMS1Q/WOrW8Pf3Lsdgyb5sSMftRpym/8=;7:dhDaawp+JHZ8s7DLxutcyXxvhyfpJUFAmhJ1FQZQFhf1cVRWoxl66lSq6Nb7UVwFHO7Ln0oftTYOZn9aFwBudQIu8fj1cwKeQMPedMypukj2lS8YRTElwDg+U73etYS2O7uWldZF4jPA/hJJD6imZPinD90aMuKBvKNQ1dnJOfOwDaenDWpw/xyjHyRQ+w+jOYmaF+OvCZuLDMWGYlaboCndItKSL60Avso6iE2/zMrGuGceIJnD8ivGK/H+ZgFO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 11:38:19.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9afb10-a024-4541-d1c4-08d634250970
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[adding devicetree]

On Wed, Oct 17, 2018 at 06:08:23PM +0800, Peng Hao wrote:
> Add a platform device driver, pvpanic-mmio that is similar
> to x86's pvpanic device.

It would be worth noting in the commit message that this is a
QEMU-specific device.

Is this already in upstream QEMU?

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/platform/Kconfig            |   3 +
>  drivers/platform/Makefile           |   1 +
>  drivers/platform/arm/Kconfig        |   6 ++
>  drivers/platform/arm/Makefile       |   6 ++
>  drivers/platform/arm/pvpanic-mmio.c | 123 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 139 insertions(+)
>  create mode 100644 drivers/platform/arm/Kconfig
>  create mode 100644 drivers/platform/arm/Makefile
>  create mode 100644 drivers/platform/arm/pvpanic-mmio.c

If this is an MMIO device, why does this need to be specific to arm?

Surely *any* architecture could use this?

> 
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index d4c2e42..8b64b78 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,3 +1,6 @@
> +if ARM64
> +source "drivers/platform/arm/Kconfig"
> +endif
>  if X86
>  source "drivers/platform/x86/Kconfig"
>  endif
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4b2ce58..232231c 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for linux/drivers/platform
>  #
>  
> +obj-$(CONFIG_ARM64)               += arm/
>  obj-$(CONFIG_X86)		+= x86/
>  obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
>  obj-$(CONFIG_MIPS)		+= mips/
> diff --git a/drivers/platform/arm/Kconfig b/drivers/platform/arm/Kconfig
> new file mode 100644
> index 0000000..89fd694
> --- /dev/null
> +++ b/drivers/platform/arm/Kconfig
> @@ -0,0 +1,6 @@
> +config PVPANIC_MMIO
> +        tristate "pvpanic mmio device support"
> +        help
> +          This driver provides support for the pvpanic mmio device. pvpanic mmio
> +          is a paravirtualized device provided by QEMU; it lets a virtual machine
> +          (guest) communicate panic events to the host.
> diff --git a/drivers/platform/arm/Makefile b/drivers/platform/arm/Makefile
> new file mode 100644
> index 0000000..a68af01
> --- /dev/null
> +++ b/drivers/platform/arm/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/arm
> +# arm Platform-Specific Drivers
> +#
> +obj-$(CONFIG_PVPANIC_MMIO) = pvpanic-mmio.o
> diff --git a/drivers/platform/arm/pvpanic-mmio.c b/drivers/platform/arm/pvpanic-mmio.c
> new file mode 100644
> index 0000000..6a06d24
> --- /dev/null
> +++ b/drivers/platform/arm/pvpanic-mmio.c
> @@ -0,0 +1,123 @@
> +/*
> + * pvpanic mmio device driver
> + *
> + * Copyright (C) 2018 ZTE Ltd.
> + * Author: Peng Hao <peng.hao2@zte.com.cn>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <asm/virt.h>
> +#include <linux/platform_device.h>
> +
> +#define PVPANIC_MMIO_CRASHED	(1 << 0)

This looks like it's identical to PVPANIC_PANICKED in the existing ACPI
IO pvpanic driver.

I suspect on the QEMU side, there's one device, and the distinction is
only in how this is described.

Can't one driver support both?

> +
> +struct pvpanic_mmio_device {
> +	void __iomem *base;
> +};
> +
> +static struct pvpanic_mmio_device pvpanic_mmio_dev;
> +
> +static void
> +pvpanic_mmio_trigger_event(unsigned int event)
> +{
> +	writeb(event, pvpanic_mmio_dev.base);
> +}
> +
> +static int
> +pvpanic_mmio_crash_notify(struct notifier_block *nb, unsigned long code,
> +			void *unused)
> +{
> +	pvpanic_mmio_trigger_event(PVPANIC_MMIO_CRASHED);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pvpanic_mmio_crash_nb = {
> +	.notifier_call = pvpanic_mmio_crash_notify,
> +	.priority = 1,
> +};
> +
> +static int pvpanic_mmio_probe(struct platform_device *pdev)
> +{
> +	struct resource *mem;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return -EINVAL;
> +
> +	if (!devm_request_mem_region(&pdev->dev, mem->start,
> +				resource_size(mem), pdev->name))
> +		return -EBUSY;
> +
> +	pvpanic_mmio_dev.base = devm_ioremap(&pdev->dev, mem->start,
> +										resource_size(mem));
> +	if (pvpanic_mmio_dev.base == NULL)
> +		return -EFAULT;
> +
> +	platform_set_drvdata(pdev, &pvpanic_mmio_dev);
> +
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +								  &pvpanic_mmio_crash_nb);
> +
> +	return 0;
> +}
> +
> +
> +static int pvpanic_mmio_remove(struct platform_device *pdev)
> +{
> +
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					&pvpanic_mmio_crash_nb);
> +	devm_kfree(&pdev->dev, &pvpanic_mmio_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id pvpanic_mmio_match[] = {
> +	{ .compatible = "pvpanic,mmio", },
> +	{},
> +};

This should be "qemu,pvpanic-mmio"; "pvpanic" is not the vendor.

This should also have a binding document somewhere.

Thanks,
Mark.

> +MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
> +
> +static struct platform_driver pvpanic_mmio_driver = {
> +	.probe =        pvpanic_mmio_probe,
> +	.remove =       pvpanic_mmio_remove,
> +	.driver = {
> +		.name =	"pvpanic-mmio",
> +		.of_match_table = pvpanic_mmio_match,
> +	},
> +};
> +
> +static int __init pvpanic_mmio_init(void)
> +{
> +	return platform_driver_register(&pvpanic_mmio_driver);
> +}
> +
> +static void __exit pvpanic_mmio_exit(void)
> +{
> +	platform_driver_unregister(&pvpanic_mmio_driver);
> +}
> +
> +module_init(pvpanic_mmio_init);
> +module_exit(pvpanic_mmio_exit);
> +
> +MODULE_AUTHOR("Peng Hao<peng.hao2@zte.com.cn>");
> +MODULE_DESCRIPTION("pvpanic mmio device driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.3.1
> 
