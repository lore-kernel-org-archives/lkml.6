Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3523FBE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vv8mZpBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB3523FBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGFQMU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:12:20 -0400
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:2496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933109AbeGFQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZanj+ZDJBCzRV4kPzT2Lq3Q208Q1A0g+yl8zKupo14=;
 b=Vv8mZpBgBtqLDbwV72iPJeAiovWuwaBrkph67w0Wvbqs5ttUlGyLHQZXqXTuz2B9HHjlMoYCiB9ukcFIwo6jABb2WAL9V+GAlczixkaoo1YfjkN1u+DfcQwiRXknCBIBenUb7jWaRtAdcFjJPLfOND8lsbHTNqUZmg85Y483YIM=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1088.namprd21.prod.outlook.com (52.132.115.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Fri, 6 Jul 2018 16:12:16 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.008; Fri, 6 Jul 2018
 16:12:16 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>
CC:     Ingo Molnar <mingo@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Topic: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Index: AQHUEyH9VEON6uYIaEmnD3ui5VQFzaR/PNWAgAF+/gCAAApPAIAAXTGAgAAT4gCAAAaDgIAAV3aAgABSIoCAAB5fgIAAWfzA
Date:   Fri, 6 Jul 2018 16:12:16 +0000
Message-ID: <SN6PR2101MB1120C1ACA2320EA5AEF5E590DC470@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
 <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com>
 <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
 <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1807061052410.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061240560.1664@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807061240560.1664@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-06T16:12:14.5291009Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1088;7:dUCg9ik6GP2NIQps590kR5klaN6q2LflsMp/sGoWUB9SRY7CtI7JTBPTqMY1oIa/ChNy8qR03vk9JV2fBDnVm3Lke6bcB3UgHN0WPeC2Sa4Q1/I4gGfONrrRZ+jSlhnb2Ny8CAnZqaaHBPGKiju15th9NXFs86oiFv96w/9he69/DFkzVEpRU4wqjPUhyw01rCx4lG134HFVspH6zeqC4Ncft7ZG3lRbzUw7rp5xntkAj3ZvPVVoB78rt90yCPgK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6cae756f-741b-4612-80be-08d5e35b3e1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:SN6PR2101MB1088;
x-ms-traffictypediagnostic: SN6PR2101MB1088:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB10885B65E8B60ECB999BC67ADC470@SN6PR2101MB1088.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231291)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1088;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(13464003)(199004)(189003)(14454004)(10290500003)(478600001)(72206003)(2900100001)(5250100002)(9686003)(6436002)(2906002)(7416002)(99286004)(256004)(5660300001)(3846002)(6116002)(7696005)(26005)(8990500004)(86612001)(102836004)(86362001)(33656002)(7736002)(25786009)(93886005)(68736007)(486006)(186003)(6636002)(4326008)(76176011)(53546011)(6506007)(106356001)(8676002)(11346002)(10090500001)(1511001)(8936002)(446003)(81156014)(81166006)(229853002)(66066001)(22452003)(54906003)(110136005)(53936002)(316002)(305945005)(74316002)(476003)(6246003)(55016002)(105586002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1088;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RMhKjCr5TKIFOLunWxvt4CIKddTN+AKgcstH0Ue/EAQjXPeNH++5Vuvp8W7gLilDDhA0jRQMwORuHY5OcmFYcWRZ9EJZHHiyC6udAfu5B5puU6PGN6uI7RlDezosAbLOFtN42ZGiGmNBYJDLRL9Z9jt5ZsOeorauAAdYw5TuPWuuDkiRYGQWwSzXq/7pULzBwNaWhoc44NLoyo1t1QEkgJ1vtNRLKetXur4P6Lpq0hINoUTkJY4Zt2Hkx2Q6so+Mh/cfLdgOvMLVTlTucfxj1e3vuIlsABV03VlKbJdq6honJxh7koi2EXDf88gKYJcNXBIt6EEHN4Y601zqUGfLqwNN+3io7XUPb0Mb6uefGTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae756f-741b-4612-80be-08d5e35b3e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 16:12:16.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, July 6, 2018 3:42 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: Ingo Molnar <mingo@kernel.org>; x86@kernel.org; gregkh@linuxfoundatio=
n.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de; apw=
@canonical.com;
> jasowang@redhat.com; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft=
.com>;
> Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.c=
om
> Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI=
 enlightenment.
>=20
> On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> > On Fri, 6 Jul 2018, KY Srinivasan wrote:
> > > >
> > > > The problem is that the wreckage is in Linus tree and needs to be f=
ixed
> > > > there, i.e. via x86/urgent.
> > > >
> > > > Now we have the new bits queued in x86/hyperv already which collide=
. So
> > > > we
> > > > need to merge x86/urgent into x86/hyperv after applying the fix and=
 mop up
> > > > the merge wreckage in x86/hyperv.
> > > >
> > > > I'll have a look tomorrow morning unless you beat me to it.
> > >
> > > I can rebase this patch against the latest tip and resend (tomorrow).
> >
> > That doesn't help as we need to push the original fix to Linus ...
>=20
> Applied it to x86/urgent and fixed up the '-1' sloppy hack as pointed out
> by Vitaly and merged x86/urgent into x86/hyperv.
>=20
> Please check both branches for correctness.

Changes look good to me.  Some pre-existing signed/unsigned type sloppiness=
 is
still there in that hv_cpu_number_to_vp_number() should be 'u32' instead
of 'int', along with related local variables, but that's probably best to f=
ix in
linux-next on top of Vitaly's other changes.  This code will work.

Michael

>=20
> Thanks,
>=20
> 	tglx

