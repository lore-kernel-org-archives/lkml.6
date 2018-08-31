Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5502083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OrrrN7Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5502083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeHaTw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:52:28 -0400
Received: from mail-eopbgr720092.outbound.protection.outlook.com ([40.107.72.92]:45246
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbeHaTw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ2S/L0MPdpmiUX7o0gQ0+tJcA8H7Z+8yMbJDewVwEk=;
 b=OrrrN7Zm3zG7St2sN/Bvul475EsRsmdEQMt6SQd0LqpoLmyDuAhwBEU++8w4kvdTdgQG9jhCminL0gEhhQbJuUePKsKSiERPP9QQk3aKVTXkHWC9cbtAVeVoa21+52KZTNhTVOAl8Mo/zvKXEUd9rWLwjW3ksSmM++qBqdrxvTY=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 31 Aug 2018 15:44:20 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%4]) with mapi id 15.20.1143.000; Fri, 31 Aug 2018
 15:44:20 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
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
Thread-Index: AQHUP68VsXFSuaRnjUyblznIsuxuh6TYpX4AgAFdh7A=
Date:   Fri, 31 Aug 2018 15:44:20 +0000
Message-ID: <CY4PR21MB077373EB5898095B481E1158DC0F0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-3-git-send-email-mikelley@microsoft.com>
 <MW2PR2101MB11135AA9A2CBCA230B75CE4DA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB11135AA9A2CBCA230B75CE4DA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-31T15:44:17.7961183Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:7G1gG3+EgI0c7e3dKFH27JMsRiOvRvBz1DGp8PrV5/cmnZ5hfosMuR9qnAulB6P04uvBSWXuiZC18VD6PWQdxVUepZGicRTTieh/ogLndPJE4BbIWwMQk44cK6N5bxMR28HkLNh2PiIBvhGjLD5Kcy9o3kOKFbnDNhVTcmo5Q378gH0u6uU6lVGAE9tfHpw8A1mh56RacL3IgDh1S03WyRhhG5LZbrWSzlpSalH/pejf5ndRXNbx8oI01FtmLb664n8k9fThSGbUmVG/kOzTcEP1lYXXj5SbGKbNFziiLy/IEh/Srpn1ryea9Ra3WRoE7N2oNEoh00e6KjozX5e5uvQc4CKy6WtBUD+H5SgojJZMkRy3FddhTNbofDgGdTQC/MPKQOAcJvJp4mnf0n4wDWJvZUHPJcfMj6EyIFr9TubagmzET/bBoEtL8tT/DuVV8rJiQF7WmEp/LMuhjldUXA==;5:ft9nQFKzre4silugG2V4uk54FBBe4u3vJZsjB8vUxgf36PseqEV9k7LYMeTPu7uQJEPwK5xtUtp2TqEk8rRgJADs/vxAay5z1VBjaJ+fGlGklvfkBLzKYdBk3qiTFnNe0k9l1taNDh6hWAG5VICEnB58jZP39zuRZ69ZnQFcBEg=;7:KQocqoFANC2bwxhnYCZp4W57h0B2wWLzGYXyi5urcZoR1AHKeDBWHjsAJgaduYVseW/J2iMn/xL/GQ45pwCkRcL2X76vrj42aGAuV9mcnpLN340vHo87DAM6JRAbcAyWTKb1qvFQ8KqIHO11Ih6F6acovRIEOareW5X7Oi1Wz1u+vO0PBEsFaKXrYZtZq//Nw3ok9fbANBBwqsQbtmcWDk0SQun6spkyZay3vKax7cBIlILmZaY2YeiTDCOukExm
x-ms-office365-filtering-correlation-id: 6e872b46-8097-4bba-4afe-08d60f589e19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07746BE316355BF1AC826599DC0F0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(102836004)(105586002)(6506007)(229853002)(26005)(106356001)(446003)(25786009)(9686003)(5250100002)(55016002)(53936002)(6436002)(2501003)(86612001)(6246003)(2201001)(2906002)(476003)(6116002)(86362001)(3846002)(486006)(11346002)(8990500004)(97736004)(7416002)(7696005)(68736007)(10290500003)(7736002)(316002)(305945005)(99286004)(74316002)(14454004)(2900100001)(76176011)(478600001)(72206003)(256004)(6636002)(81156014)(110136005)(22452003)(8936002)(81166006)(8676002)(5660300001)(1511001)(33656002)(66066001)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WCVTwewP1me61kIY5rOYxrj3P8QuCnNnhkvW1gQ1C1BEOj3C5vNOStoUxDHzNhAEFQJC2MzguqDcIUlHKiASBMZkyQfzhur4k4l5S2Z/lZiZ7toLfzqpN0SaqzU1pn5nljPDQv9SvsBVRrJwkJiEocIb7j4D+THQumstUYtFdLPWa0oqhSbf278jWXevYdWWs0yXqwFufxmtzQB+szhy024kZzBX15sITmrCoOq5dwdoa4D9ljtWVVeKNYJ0BE+9Rhos+c1Lj5PEfef/ra4i7B9yepIihmPBiPN0eWy4UE+qIUygLEyJOPToS5gdcHXcAaS+L/Ezx/CGisf5MHQf52EPFPNvkXVkTTg65G2wQ6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e872b46-8097-4bba-4afe-08d60f589e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 15:44:20.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KY Srinivasan  Sent: Thursday, August 30, 2018 11:51 AM

> > +	/* Allocate percpu VP index */
> > +	hv_vp_index =3D kmalloc_array(num_possible_cpus(),
> > sizeof(*hv_vp_index),
> > +				    GFP_KERNEL);
> > +	if (!hv_vp_index)
> > +		return 1;
> > +
> We should perhaps set the array so the contents are invalid so we can cor=
rectly
> handle enlightenments for TL shootdown and IPI.

Agreed.  Will add the initialization in v3 of the patch.

Michael
