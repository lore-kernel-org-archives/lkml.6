Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CACC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B74320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B74320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeLEMuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:50:18 -0500
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:33216
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeLEMuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7LU8TSSCzQLyslN5rLZZg2lFiDOwKIKR/Bc+Jr5TOs=;
 b=NY0EG4Vlof4H3BJhbNuHi6y+BAsSoR2fq9A/bQsQdutxNAUcCt99ohwWamFFlf4LOzjaisz/p6Wy3xvSL1DYQn+OGgvz74xJ7zzbTRJaxlttfXdWaWTRE2o08z2GH6InOq9NGX1K6D5y/BYnrwTQERAlxIlxLxLVyDYlCG/G1+g=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4590.namprd07.prod.outlook.com (52.135.75.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 12:50:14 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%5]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 12:50:14 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Topic: [PATCH v2 00/10] irqdomain, gic-v3-its: Implement late irq
 domain initialization
Thread-Index: AQHUhyiqlMdEsFpCz0uB8aDmjfRnhqVwI8YA
Date:   Wed, 5 Dec 2018 12:50:14 +0000
Message-ID: <20181205125006.GV4262@rric.localdomain>
References: <20181128144240.28727-1-rrichter@cavium.com>
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0602CA0012.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::22) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.55.182.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4590;6:Q421W/q9qScQhkJTqTsCBkneztJsk+RPwbPIq2/L/u5xLxLVMiSASt+zNoSceehXnxi7mf1u3ZnA5eomEfw+57/0a0KtlqYDWsT1WG9rM4ZJ1KlUjHP839ghsJK9mQJAu61TGuhLzHHC/JsE6PrbORvd+wD0Jddev/XVz7Q0W2JPOwMMGwbK53alkHa8T/x9b+qF9iePAPbChp7Ta5xIt9o3B+5NeLtNv/lqOmU4xKXjnXcprZIzGzE6pXcoubIrGs/xa6NYDcswBc4GQ+hZoPeX8tp4G+jO4/qyzlTCJrdmYRft/uEMHZEnoDgX2TNpLDHjagFmsBrjsXSObf2Fr0Bp+21Eog276DsW2UNAQTuPkgMRrwN1dD0PA5e/hVaTVOM65hBJ4mqOP2eyqtVv/P2Cjp3iu3qykwt8STcUDhBfXe/Gy8pdaQrtiV9uL0w5eMB9uzKaPxiU1Bs8p288fQ==;5:J72pCj+0H3Bq4uSTxG5p6bnaS1q10LmSFKUfYsZ8krX25Pq/fB1e8A/cxeODW0o8PofTieSvk1xjcxyqrB4820RL1Vf4d5Cjjtu8YUSrnO975xXZfiPP68TG3rQ4JnzrEQyzDtRIN6mlKyJzEaP6ESb3Oc+SAaKP5pbvI1MX+Rc=;7:imvk2L+6FdlYk62wdmI6qXlf2t4liYw4mzGTVDjsSjA66QJL5unT4F3xzTgxexm/G1pqmF2IhMkom0Oh8pZeAY3PZdafuwXuIQAhDN96ZagaL4DDG6QjoXjn5zRbsfI+mFAUg2KEtm7+nAE1BYrIig==
x-ms-office365-filtering-correlation-id: de710e2f-6baf-4830-51ba-08d65ab0331d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4590;
x-ms-traffictypediagnostic: SN6PR07MB4590:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-microsoft-antispam-prvs: <SN6PR07MB459019F3B1F4C41ABF99FBBEF1A80@SN6PR07MB4590.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4590;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4590;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(229853002)(25786009)(6486002)(6436002)(53936002)(6246003)(71190400001)(71200400001)(6512007)(9686003)(8676002)(6306002)(8936002)(105586002)(106356001)(81156014)(81166006)(68736007)(66066001)(86362001)(33656002)(5660300001)(966005)(4326008)(39060400002)(52116002)(478600001)(72206003)(99286004)(476003)(256004)(11346002)(14444005)(446003)(14454004)(2906002)(97736004)(6116002)(3846002)(486006)(316002)(305945005)(7736002)(6506007)(386003)(53546011)(76176011)(33896004)(7416002)(54906003)(26005)(102836004)(110136005)(1076002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4590;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qkWLkXZ4CqLX6BKUTO8FVb+QaAtceixTtgmm1wTlc4BUQhC9BcBF+moyrfryNeaLtm/bGRoYgEoVKWD7ud8HlqjT/E6tm9uFuPYPGbtCWPJLgWCDcUazqMoKduZrW+/JMAwGNwhtOxDsObEq2kl99sjhVZUSOKZjdjZ2OwGXecQJ26OwYzvh3I9uREYMhQs95/AjEs6S0I8KLM6PXDoxU735hLviJM8C+knoXUQ4exUSshxGE1uDWYz28gPhY6imqHdhFY0amt8EK75hhzCHGZDT7HVBjlwC0LP9YyNpCOSGS4QS8XHbP/mU131R60si9u6bCGg2bUgGPsw3osuwzajOAHYaaMhLbjekGsjm334=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD7CBEC30A74D44085C237B617944B71@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de710e2f-6baf-4830-51ba-08d65ab0331d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 12:50:14.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

do you have any comments on this series? Please take a look at it.

There is also this one on top:

 https://patchwork.kernel.org/cover/10685025/

Both series fix ITS table allocation for 4k page size and make the
upstream kernel working without the need of additional patches.

Thanks,

-Robert


On 28.11.18 15:43:02, Richter, Robert wrote:
> This patch series is a rework of the gic-v3-its initialization. It is
> in preparation of a further series that uses CMA memory allocation for
> ITS tables. For this the CMA framework must be available and thus ITS
> needs to be initialized after the arch_initcalls. This requires two
> major reworks.
>=20
> First we must remove all irq domain init order dependencies (patches
> #1-#5), second the ITS initialization must be split into an early
> probe and a later init part (patches #6-#10).
>=20
> Patch #1 introduces a new interface to request an irq domain, see the
> patch description for details. In patches #2-#5 all ITS related irq
> domains are converted to use the new interface. There are no order
> dependencies for parent and client irq domain initialization anymore
> which allows us to initialize all ITS irq domains in the same initcall
> (moving to the later subsys_initcall). Note that I do not have fsl
> hardware available, the code should work, but is only carefully
> reviewed and compile tested, please test on that hardware.
>=20
> The remaining patches #6-#10 are an incremental rework of the ITS
> initialization, basically splitting probe and init (patch #7) and
> separating it from gic-v3 code (patch #8). Patches #9 and #10 change
> initcall levels for various drivers.
>=20
> Patches have been tested with Cavium ThunderX and ThunderX2. I have an
> implementation of CMA ITS table allocation on top of this series
> available, I will send out patches for this in a couple of days.
>=20
> v2:
>  * fix check for domain match in irq_domain_handle_requests()
>  * add comment that describes this check in irq_domain_handle_
>    requests()
>=20
> Robert Richter (10):
>   irqdomain: Add interface to request an irq domain
>   irqchip/gic-v3-its-platform-msi: Remove domain init order dependencies
>   irqchip/irq-gic-v3-its-pci-msi: Remove domain init order dependencies
>   irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain init order
>     dependencies
>   fsl-mc/dprc-driver: Remove domain init order dependencies
>   irqchip/gic-v3-its: Initialize its nodes in probe order
>   irqchip/gic-v3-its: Split probing from its node initialization
>   irqchip/gic-v3-its: Decouple its initialization from gic
>   irqchip/gic-v3-its: Initialize its nodes later
>   irqchip/gic-v3-its: Initialize MSIs with subsys_initcalls
>=20
>  drivers/bus/fsl-mc/dprc-driver.c              |  41 +++++++
>  drivers/bus/fsl-mc/fsl-mc-msi.c               |   6 +-
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |  49 +++++---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  68 ++++++-----
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  56 +++++++--
>  drivers/irqchip/irq-gic-v3-its.c              | 160 ++++++++++++++++----=
-----
>  drivers/irqchip/irq-gic-v3.c                  |  12 +-
>  include/linux/cpuhotplug.h                    |   1 +
>  include/linux/irqchip/arm-gic-v3.h            |   5 +-
>  include/linux/irqdomain.h                     |  15 +++
>  kernel/irq/irqdomain.c                        | 163 ++++++++++++++++++++=
++++++
>  11 files changed, 446 insertions(+), 130 deletions(-)
>=20
> --=20
> 2.11.0
>=20
