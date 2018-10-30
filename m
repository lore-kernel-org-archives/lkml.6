Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F118E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nMRgAWXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F118E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJaCjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:39:24 -0400
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:34256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727732AbeJaCjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h4eSOEprfagOCK4/YIWvbI5EcaVq85NahuSfYqVS6I=;
 b=nMRgAWXsWE9uVLph4qojmhNnV6DvB6lXwFZO+S3uFD4SLjJ2gLpxAYss9GLoZoYL+9Kp4qFrRZDTSe5QmTLR5JdWD86yAi21IEYezYx2KUZRwcWrfgMPljk9SYiDfGdfZ4pz3f9GM8NrN8Ioq0LjpIwBTN7U9eSYNMycDuT8h6A=
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com (10.167.161.167) by
 MWHPR2101MB0811.namprd21.prod.outlook.com (10.167.173.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.14; Tue, 30 Oct 2018 17:44:54 +0000
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79]) by MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79%3]) with mapi id 15.20.1294.014; Tue, 30 Oct 2018
 17:44:54 +0000
From:   Long Li <longli@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Choose CPU based on allocated IRQs
Thread-Topic: [PATCH] Choose CPU based on allocated IRQs
Thread-Index: AQHUanGopgv0yEp/J0aFaWDzsmj8YaU2x/KAgAFONDA=
Date:   Tue, 30 Oct 2018 17:44:54 +0000
Message-ID: <MWHPR2101MB0729230F08FA352EDAB9C486CECC0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20181023014044.15888-1-longli@linuxonhyperv.com>
 <alpine.DEB.2.21.1810292138480.5984@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810292138480.5984@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2:edeb:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0811;6:d3plJMZFa1KPeksHOXBmTBi+LHvxzUDJY7VgFc+ICXJHsf3PSJHRIU0dO1yDOnyGQek4t4Gi/5fWvMOud02RWRlzKRX//RnHJpf7a/GBP58Qptp9rEUaZR4jhymNeq320sMUjCUXgj+uaeZSLAXbrK6jp2FrH6DpEEmMRUi0iwSawALoWW54qXLhFxs5NE+06JPgL0uqqndnW19/Qyfu6WwrTs+McOv5O4rJjerSvlbzrrU5hnP7ajxVa6AUuvhYRxyGiY27fry9+SazbNU7dI80uhKn589NnVVRBztExItAK+pYJtcu1dZ2IN36pEtyqbQiJFRbkSxyDqCf390sshI6RVenQ/Wmigfms7KCY1KUynsHIohRELbIPoFZvnLfT3C/v/Wx1xmNot1ISrMDbnm06BKn8fMsoUkJ6h9HBlaA7CRWtDrpyuAYI698mg55yogKu1huf7C8iYDKndTK9g==;5:MmWQRRoDmLYOliC6QsyzTdrMMd2wERHUD+3RFaHg4l8PHgt/GR9WsZxaUzSoRCwGpsSRSzekL7Oo/cgP94R8O23TVpAI20NSv3eEHUC4lAXlYKCoLM55BlwYG08qXgqedC5vA/HiG17zINwJ20RPwYEVCJPa+Jz4JBdAkobkgkI=;7:vtJ8pjFBu/AJrtjAT1EfpzpQRNwgovo1wk9FwOBtXzkWhLqbjTT8PVj6k0NgfKjdIYEB7773R5RcosWIcxLAlQIfujVTyUXBgKEFCmIBbQkMIKuFFsmLNFuNXHJpP3dNmygbl+nPOpZYQHAic0dsOw==
x-ms-office365-filtering-correlation-id: 6448b062-46f6-4319-b4fc-08d63e8f6709
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR2101MB0811;
x-ms-traffictypediagnostic: MWHPR2101MB0811:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR2101MB081198394651C24747A74718CECC0@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2101MB0811;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0811;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(346002)(39860400002)(54534003)(199004)(189003)(476003)(8990500004)(68736007)(7736002)(10090500001)(11346002)(7696005)(446003)(76176011)(106356001)(107886003)(6246003)(81166006)(97736004)(102836004)(6506007)(5660300001)(229853002)(25786009)(53936002)(5250100002)(71200400001)(6116002)(71190400001)(33656002)(46003)(478600001)(8676002)(81156014)(9686003)(2900100001)(74316002)(4326008)(55016002)(2906002)(6436002)(105586002)(86362001)(14454004)(186003)(316002)(54906003)(8936002)(86612001)(99286004)(256004)(486006)(14444005)(6916009)(22452003)(10290500003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0811;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SRrOMoBIFSOxriBrpiTE6YFOV5A7Ot7qIg8Jt7a4dLl+9ZyjVVPCSoq2fIm6BofvMWaGkH9SxzE9AzgOl6A65s7hx8ZXgYTInGTDY2ZIhoYZ7OAf42A4Zklgjd89ql0tbxl/NeK779OZ/PlwhGT+WrEuBMaJ1Yn0FJ+1TG7bJ6nbs6zc1h408sqA9S4Dp/Ku8AnPVWeCyizCFk/yVX0+RUrBndMm+WoJ/DJG2JEUdTYbRGlYhAJsD4dcPrtUOStxmODNgZ4ci1hTWrSPNxGeyB4nbR3itvf0++sTXWwJ9juBUm+3GqcucDcwYoPJy/fhvJqk5vO0i2LVdBGlx6Olsgidjja8p0rYblxg2Z+TwNI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6448b062-46f6-4319-b4fc-08d63e8f6709
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 17:44:54.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] Choose CPU based on allocated IRQs
>=20
> Long,
>=20
> On Tue, 23 Oct 2018, Long Li wrote:
>=20
> thanks for this patch.
>=20
> A trivial formal thing ahead. The subject line
>=20
>    [PATCH] Choose CPU based on allocated IRQs
>=20
> is lacking a proper subsystem prefix. In most cases you can figure the pr=
efix
> out by running 'git log path/to/file' which in this case will show you th=
at most
> commits touching this file use the prefix 'genirq/matrix:'.
>=20
> So the proper subject would be:
>=20
>    [PATCH] genirq/matrix: Choose CPU based on allocated IRQs
>=20
> Subsystem prefixes are important to see where a patch belongs to right fr=
om
> the subject. Without that it could belong to any random part of the kerne=
l
> and needs further inspection of the patch itself. This applies to both em=
ail
> and to git shortlog listings.

Thank you. I will send v2 to address this.

>=20
> > From: Long Li <longli@microsoft.com>
> >
> > In irq_matrix, "available" is set when IRQs are allocated earlier in
> > the IRQ assigning process.
> >
> > Later, when IRQs are activated those values are not good indicators of
> > what CPU to choose to assign to this IRQ.
>=20
> Can you please explain why you think that available is the wrong indicato=
r
> and which problem you are trying to solve?
>=20
> The WHY is really the most important part of a changelog.

The problem I'm seeing is that on a very large system with multiple devices=
 of the same class (e.g. NVMe disks, using managed IRQs), they tend to use =
interrupts on several CPUs on the system. Under heavy load, those several C=
PUs are busy while other CPU are most idling. The issue is that when NVMe c=
all irq_matrix_alloc_managed(), the assigned the CPU is always the first CP=
U in the cpumask, because they check for cpumap->available that will not ch=
ange after managed IRQs are reserved in irq_matrix_reserve_managed (which w=
as called from the 1st stage of IRQ setup in irq_domain_ops->alloc).

>=20
> > Change to choose CPU for an IRQ based on how many IRQs are already
> > allocated on this CPU.
>=20
> Looking deeper. The initial values are:
>=20
>     available =3D alloc_size - (managed + systembits)
>     allocated =3D 0
>=20
> There are two distinct functionalities which modify 'available' and 'allo=
cated'
> (omitting the reverse operations for simplicity):
>=20
> 1) managed interrupts
>=20
>    reserve_managed()
> 	managed++;
> 	available--;
>=20
>    alloc_managed()
>         allocated++;
>=20
> 2) regular interrupts
>=20
>    alloc()
> 	allocated++;
> 	available--;
>=20
> So 'available' can be lower than 'allocated' depending on the number of
> reserved managed interrupts, which have not yet been activated.
>=20
> So for all regular interrupts we really want to look at the number of 'av=
ailable'
> vectors because the reserved managed ones are already accounted there
> and they need to be taken into account.

I think "reserved managed" may not always be accurate. Reserved managed IRQ=
s may not always get activated. For an irq_data, when irq_matrix_reserve_ma=
naged is called, all the CPUs in the cpumask are reserved. Later, only one =
of them is activated via the call to irq_matrix_alloc_managed(). So we end =
up with a number of "reserved managed" that never get used.

>=20
> For the spreading of managed interrupts in alloc_managed() that's indeed =
a
> different story and 'allocated' is more correct. But even that is not com=
pletely
> accurate and can lead to the wrong result. The accurate solution would be=
 to
> account the managed _and_ allocated vectors separately and do the
> spreading for managed interrupts based on that.

I think checking for "allocated" is the best approach for picking which CPU=
 to assign for a given irq_data, since we really can't rely on "managed" to=
 decide how busy this CPU really is. Checking for "allocated" should work f=
or both unmanaged and managed IRQs.

>=20
> Thanks,
>=20
> 	tglx
