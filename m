Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D62C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813B020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b4R4/a/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967224AbeFSSUk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:20:40 -0400
Received: from mail-eopbgr690113.outbound.protection.outlook.com ([40.107.69.113]:62910
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966935AbeFSSUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sJD1qBkZ6xRtn+mCI3rvzg/e49NZIXlNT1AaGXBGt8=;
 b=b4R4/a/K+BKpAWSHED0zM4CJ102QT8wi76F9hO4w/N3khiCiiWQiAZxxgbh3liSjmZC4Wx6KShxMN5n6yrNEj8TS5FT5/z41ihl1eSeJ3VTGmmOog+ZqnuQveShmzQfsIJtIfcJb/VlqWotm3V8m66m869J5vVMYk6+h2aAT70s=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0908.namprd21.prod.outlook.com (52.132.152.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Tue, 19 Jun 2018 18:20:37 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0906.004; Tue, 19 Jun 2018
 18:20:37 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Topic: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Index: AQHUBMYlSJQ3WMa140uivtTO6PwhI6Rn5ECAgAAF1FA=
Date:   Tue, 19 Jun 2018 18:20:36 +0000
Message-ID: <MW2PR2101MB111340FC6B6AFA7CEC494498A0700@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180615163010.20381-1-vkuznets@redhat.com>
 <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:8033:11f:30b5:19e4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0908;7:h/VZE8VLT8QuUtOQScHja4JeRrIkeg3x/6DV4aAJff9lar3k9t+4fSaUCe2QF9rMYjl8Tl11mX1ov7UiqnH4Sf3G5imEzXN4dqDnHHu46Dq3SoQueGdATwsTwcQGiH9UqZH4Fu/MSjsn5DbPI5qSn8Amt0jMgmPJSu6fj9ZWfYON9T0B30eiKfxynnKz0BPK3l6shc3tdSBh9c96aeHaMMRmWl8Oz/UvuwdatryBnjWRWHVkbyHNR42L1OkMKotZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 90281867-d94f-4a62-2417-08d5d6115ae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB0908;
x-ms-traffictypediagnostic: MW2PR2101MB0908:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0908439461BB8B1E74B90B27A0700@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0908;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0908;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(39380400002)(366004)(199004)(189003)(13464003)(1511001)(8936002)(97736004)(5660300001)(81156014)(81166006)(8676002)(86612001)(305945005)(7736002)(7696005)(74316002)(6116002)(2900100001)(68736007)(3660700001)(55016002)(3280700002)(2906002)(86362001)(8990500004)(105586002)(106356001)(10090500001)(446003)(478600001)(11346002)(107886003)(10290500003)(46003)(76176011)(110136005)(229853002)(486006)(54906003)(4326008)(53936002)(25786009)(14454004)(6246003)(6436002)(22452003)(53546011)(6506007)(99286004)(476003)(5250100002)(2501003)(9686003)(102836004)(33656002)(316002)(12043001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0908;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PlD8iNsXSaqOg3vxWeynZtdzatuqN41ZRye4zGspkkHHL/jvxCO3sobJm3atzZ9av+O7KE19/htYhKrZjzRERP291R3pyAzaIb26LtGBa8qKo+TtaF7J4zYNdtUR9xXL4NvCgHMKwYHZjdNGU5QnLW68lNhXsx6YWhdqm1cf4M31/9yyo9rRkKpwWpl8+LgK3roGps73f2BQAcSRx03HRXfU9nuvGddIahMgJYltBWI0Quj5dST7/n/6IukL8l1CKna2NajawKpcy5ba5P+mSIWuKCoGKHqNKB8uM0zosVWTaa/lCVmXT/2Sekx1olVH+m3HwCPB7iUuZSg7HkQLxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90281867-d94f-4a62-2417-08d5d6115ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 18:20:36.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (EOSG)
> Sent: Tuesday, June 19, 2018 10:57 AM
> To: Vitaly Kuznetsov <vkuznets@redhat.com>; x86@kernel.org
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY
> Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> <Tianyu.Lan@microsoft.com>
> Subject: RE: [PATCH] x86/hyper-v: use cheaper
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf
> > Of Vitaly Kuznetsov
> > Sent: Friday, June 15, 2018 9:30 AM
> > To: x86@kernel.org
> > Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY
> Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Stephen Hemminger
> > <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar
> > <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> > <Tianyu.Lan@microsoft.com>
> > Subject: [PATCH] x86/hyper-v: use cheaper
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
> > hypercalls when possible
> >
> > While working on Hyper-V style PV TLB flush support in KVM I noticed th=
at
> > real Windows guests use TLB flush hypercall in a somewhat smarter way:
> when
> > the flush needs to be performed on a subset of first 64 vCPUs or on all
> > present vCPUs Windows avoids more expensive hypercalls which support
> > sparse CPU sets and uses their 'cheap' counterparts. This means that
> > HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a
> misnomer: EX
> > hypercalls (which support sparse CPU sets) are "available", not
> > "recommended". This makes sense as they are actually harder to parse.
> >
> > Nothing stops us from being equally 'smart' in Linux too. Switch to
> > doing cheaper hypercalls whenever possible.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
>=20
> This is a good idea.  We should probably do the same with the hypercalls =
for
> sending
> IPIs -- try the simpler version first and move to the more complex _EX
> version only
> if necessary.
I am not sure if this would work correctly. When I was developing the IPI e=
nlightenment,=20
what I remember was that the guest is expected to use the API recommended b=
y the Hypervisor.

K. Y=20
>=20
> A complication:  We've recently found a problem with the code for doing I=
PI
> hypercalls, and the bug affects the TLB flush code as well.  As secondary=
 CPUs
> are started, there's a window of time where the hv_vp_index entry for a
> secondary CPU is uninitialized.  We are seeing IPIs happening in that win=
dow,
> and
> the IPI hypercall code uses the uninitialized hv_vp_index entry.   Same t=
hing
> could
> happen with the TLB flush hypercall code.  I didn't actually see any
> occurrences of
> the TLB case in my tracing, but we should fix it anyway in case a TLB flu=
sh gets
> added at some point in the future.
>=20
> KY has a patch coming.  In the patch, hv_cpu_number_to_vp_number()
> and cpumask_to_vpset() can both return U32_MAX if they encounter an
> uninitialized hv_vp_index entry, and the code needs to be able to bail ou=
t to
> the native functions for that particular IPI or TLB flush operation.  Onc=
e the
> initialization of secondary CPUs is complete, the uninitialized situation=
 won't
> happen again, and the hypercall path will always be used.
>=20
> We'll need to coordinate on these patches.  Be aware that the IPI flavor =
of
> the
> bug is currently causing random failures when booting 4.18 RC1 on Hyper-V
> VMs
> with large vCPU counts.
>=20
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
