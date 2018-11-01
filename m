Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48260C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2CE205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KL3CNtM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2CE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeKBBnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:43:05 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:59818
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKBBnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXUCFqP2cB9uzTov3s0QPODsvgIBEdFvGseJrGxCGZQ=;
 b=KL3CNtM5nGee/cQDwsx74Ae2jPRB+EjIPxrkd7QzMbTgZBvC/TZhmZEErVgkTI1ao0+dsBQr1qlvkXymdo/2NR7bsjm4uxMrYgf33Gv7juMVUwCG18ioOaOvsFxEkIhhNfCw7zclQP3tn1/w0ByzfzXQHKjUxjtnGvOrY3W7+jQ=
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com (10.167.161.167) by
 MWHPR2101MB0809.namprd21.prod.outlook.com (10.167.161.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.5; Thu, 1 Nov 2018 16:39:18 +0000
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79]) by MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79%3]) with mapi id 15.20.1294.014; Thu, 1 Nov 2018
 16:39:18 +0000
From:   Long Li <longli@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2] genirq/matrix: Choose CPU for assigning interrupts
 based on allocated IRQs
Thread-Topic: [Patch v2] genirq/matrix: Choose CPU for assigning interrupts
 based on allocated IRQs
Thread-Index: AQHUcZEPeX0Gc7CT0UG2AWIMZ5IM+KU6nFUAgACC3oA=
Date:   Thu, 1 Nov 2018 16:39:18 +0000
Message-ID: <MWHPR2101MB0729643A3EB596B3AF701C43CECE0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20181101031332.7404-1-longli@linuxonhyperv.com>
 <alpine.DEB.2.21.1811010931400.1642@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811010931400.1642@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.193.116.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;6:Lh3PYg46sCecuTYt72vML4bs23vR5hG3ygG2Zjl3jwiDRU+63EfVg7OqPFH+6WfMKIoZ3GpD57XZplufzyMUJiQ0iG/dhv3IdCeGBIwz+aAStNFpKALvPxLr7WDpAoOepdeZ72l6DK5T42V1DC3rzR1v0jRaSe1w0upYQ4uz+6OELMx7soAStGI66NaWzwGaDVlVi9GKanbvGQmUJwwPzRje32S0bJxi3kry9hFkvsWxn+eoMtNeD9bwPIaPiVAL5YIQ1QNZ8ZPlgvLE+YA7noZnYKYI3xQoOmFXHH9jEiUE8xWkOkybylOqeSPp9iFL9RCNnGyPkJxGL6D9EoV7jo58fTT4w0okrODl+VTIhh9TP4waY+uehq/QjaDbyX9EU7YhkyGNlxjG6WHv3wLDZtFq9KfzrnXzRwOa9IvrSU3BB88PDtqIHnnCXlV3DWb0ky6mgVusPBc0Hk8tETYV0Q==;5:LiFbS+M1ovqvTneBs3Og0x35w3qE4nUuT4z27dkenfuivWS6BrzeoIfOiC1f8fpMVxrvVqbg8JiEhVToPqQm/we8kV7uiMskXCqkYOGfL1PI58OlqFq/G0EhWSYxs3FzgHvlwhCN51x0hXZzClmz28wCKOMW/Es7qvwSZ9WSjkk=;7:76wk9tg6Ogjikp5h9DuxmeAhn+MobMdHz7WE9y0SY20fLykVhQ/ojN51bpIiZS2pb8+xCsCf/cR96+p6Y3e4uUEmy+kiBtWGyRvL5QyaobwcRF93Gm8OTW26u5ZxDFnLj/VpZ/BxIk2IaVaEe9rZkA==
x-ms-office365-filtering-correlation-id: ffd4927a-90bc-4b7b-1aca-08d6401891cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR2101MB08098F3673E51EA2C579E9A5CECE0@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(366004)(346002)(189003)(199004)(81166006)(478600001)(14444005)(8990500004)(256004)(6436002)(6246003)(68736007)(74316002)(305945005)(53936002)(9686003)(55016002)(7736002)(8676002)(476003)(446003)(81156014)(71190400001)(8936002)(71200400001)(486006)(14454004)(66066001)(345774005)(97736004)(6916009)(3846002)(11346002)(6116002)(2906002)(5660300001)(33656002)(186003)(106356001)(105586002)(22452003)(26005)(229853002)(6506007)(102836004)(99286004)(10290500003)(76176011)(5250100002)(7696005)(2900100001)(54906003)(25786009)(316002)(86612001)(4326008)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fUFwl5u4hWdDY5fovq/3gaP9np12f2BJuVK6PKVJjL9B7I3VnuhkY0vdoy3Y/DVzUJlqv1xbXOmNcrLx4kZu797ImoeOaQIlUDzdzjZXStNnWpoNUK8dhQ04pAvzwyhsEPZVLLpIqbWpaZGeXw1rZgT3KxCbb+K7qYRhPZ3UvzceanGbwH/NpZJ5nUuhf9SpPMJ2CN90qDoQ3gX3G1ZS2RRj2xAagXrAgO4I2spfUOd7ycpO9nua/H/3L7f0alDI8OIA0tDkgWomFSW+EPhLxApNVLQgRGHh82hQckLfubGz7vCnchQIbZzXvqY6CPOQmdX2L1rzJSkwimL4AeOrGAaE2XiA8B+nydU3AjD9F88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd4927a-90bc-4b7b-1aca-08d6401891cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 16:39:18.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [Patch v2] genirq/matrix: Choose CPU for assigning interrupt=
s
> based on allocated IRQs
>=20
> Long,
>=20
> On Thu, 1 Nov 2018, Long Li wrote:
> > On a large system with multiple devices of the same class (e.g. NVMe
> > disks, using managed IRQs), the kernel tends to concentrate their IRQs
> > on several CPUs.
> >
> > The issue is that when NVMe calls irq_matrix_alloc_managed(), the
> > assigned CPU tends to be the first several CPUs in the cpumask,
> > because they check for
> > cpumap->available that will not change after managed IRQs are reserved.
> >
> > In irq_matrix->cpumap, "available" is set when IRQs are allocated
> > earlier in the IRQ allocation process. This value is caculated based
> > on
>=20
> calculated
>=20
> > 1. how many unmanaged IRQs are allocated on this CPU 2. how many
> > managed IRQs are reserved on this CPU
> >
> > But "available" is not accurate in accouting the real IRQs load on a gi=
ven CPU.
> >
> > For a managed IRQ, it tends to reserve more than one CPU, based on
> > cpumask in irq_matrix_reserve_managed. But later when actually
> > allocating CPU for this IRQ, only one CPU is allocated. Because
> > "available" is calculated at the time managed IRQ is reserved, it
> > tends to indicate a CPU has more IRQs than it's actually assigned.
> >
> > When a managed IRQ is assigned to a CPU in irq_matrix_alloc_managed(),
> > it decreases "allocated" based on the actually assignment of this IRQ t=
o this
> CPU.
>=20
> decreases?
>=20
> > Unmanaged IRQ also decreases "allocated" after allocating an IRQ on thi=
s
> CPU.
>=20
> ditto
>=20
> > For this reason, checking "allocated" is more accurate than checking
> > "available" for a given CPU, and result in a more evenly distributed
> > IRQ across all CPUs.
>=20
> Again, this approach is only correct for managed interrupts. Why?
>=20
> Assume that total vector space size  =3D 10
>=20
> CPU 0:
>        allocated	=3D  8
>        available	=3D  1
>=20
>        i.e. there are 2 managed reserved, but not assigned interrupts
>=20
> CPU 1:
>        allocated	=3D  7
>        available	=3D  0
>=20
>        i.e. there are 3 managed reserved, but not assigned interrupts
>=20
> Now allocate a non managed interrupt:
>=20
> irq_matrix_alloc()
>=20
> 	cpu =3D find_best_cpu() <-- returns CPU1
>=20
> 	---> FAIL
>=20
> The allocation fails because it cannot allocate from the managed reserved
> space. The managed reserved space is guaranteed even if the vectors are n=
ot
> assigned. This is required to make hotplug work and to allow late activat=
ion
> without breaking the guarantees.
>=20
> Non managed has no guarantees, it's a best effort approach, so it can fai=
l.
> But the fail above is just wrong.
>=20
> You really need to treat managed and unmanaged CPU selection differently.

Thank you for the explanation. I will send another patch to do it properly.

Long

>=20
> Thanks,
>=20
> 	tglx
