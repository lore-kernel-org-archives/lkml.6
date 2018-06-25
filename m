Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0349C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F27208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IAgSrfe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F27208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeFYXya (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:54:30 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:30592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932073AbeFYXy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+viHju/IRLTyhdU2JPEFKpxTVkRQR/75SQFlfwYywg=;
 b=IAgSrfe08aJwu3eIDODlcyj6EYNydsaBM/iF0g4cuxRcfWWIQl8WzADPClfSVd8zeBEec2LzpOj2rdmugvUEnf+bpVEjaRauzbnutfIuzZc38/KYSJtfKxtqZY+DlneVKqREoM3PVQy50RXTbi0+05DVhsa10/RZJ0qyQDmgMR8=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1053.namprd21.prod.outlook.com (52.132.115.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Mon, 25 Jun 2018 23:54:26 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 23:54:26 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH 2/4] x86/hyper-v: use 'fast' hypercall for HVCALL_SEND_IPI
Thread-Topic: [PATCH 2/4] x86/hyper-v: use 'fast' hypercall for
 HVCALL_SEND_IPI
Thread-Index: AQHUCktgwcjn6tsgfU+Yh/WE3ggTO6RxqpVQ
Date:   Mon, 25 Jun 2018 23:54:25 +0000
Message-ID: <SN6PR2101MB11206D0596EDAF0B020E50DFDC4A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
 <20180622170625.30688-3-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-3-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-25T23:54:24.3619386Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1053;7:/ikVf8FEda82AUIa9ZbYa3oND1Go2fiSRGEfXJBMNxWCilAlHlleUNblsk+v5RmNhqcVWmuYIKvPmfA8Vw8YuEnMq6P2hbAsA6Su58yRNTnuZopgHc99/17xMTNPe1b9zJVJWUvlQu+bYNbhY0tHbs6N52rUPu6/vOGJqpNPyhZAqaaSPveu6XZ9WpPLsFYLNG/zci3xUk1sRRnJeP+xthKQqTiKZ1Jz/+2lfu+2KbuN5tKpfQUceSYRrR4VURdv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 92abfe91-c00d-401b-7387-08d5daf6fb96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1053;
x-ms-traffictypediagnostic: SN6PR2101MB1053:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB105311FB406F3C79E6AF8F1EDC4A0@SN6PR2101MB1053.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1053;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1053;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(13464003)(74316002)(476003)(33656002)(11346002)(305945005)(446003)(4326008)(7736002)(478600001)(72206003)(10290500003)(14454004)(25786009)(97736004)(55016002)(86612001)(8936002)(86362001)(6116002)(3846002)(6436002)(76176011)(66066001)(7696005)(9686003)(26005)(186003)(53546011)(6506007)(68736007)(102836004)(8676002)(53936002)(81156014)(81166006)(229853002)(107886003)(6246003)(99286004)(2900100001)(316002)(22452003)(54906003)(5660300001)(110136005)(2501003)(8990500004)(5250100002)(105586002)(106356001)(256004)(486006)(2906002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1053;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sAPpxa1kdOFCP8a6vF51yYBggDtne4x1DGQ/A1Fa7oqVrepcPbEefg3Jp2iWpUO5xcb4zWoe6yH1nAiE2YH31zXD3ME0CJNjnd3MoAJNPG6P6U/XIy86UnYdKh4N7S25dSrgNHYT9ovNgYumUiBr+d7sS7mx6ONk9hVV16+TWB6UtWAyoD0jrHIcYHjvvedUijakrXbeP2+G3JDa84JMM63QI8QLfODg7E5xvOPNG/8yf3iGjrdhvZOdZSb49U8izEiLs8i8Q8KJeaD4aa9qPLXLWEFcQPTFMEOVv+8WPPYYwkTyuRzja2iPPeL9qsrXlql4Y+910SfSTqcRcAUt1ELcb2g9TRZv3a7/BSd9u0o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92abfe91-c00d-401b-7387-08d5daf6fb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 23:54:25.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, June 22, 2018 10:06 AM
> To: x86@kernel.org
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY Sriniv=
asan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemm=
inger
> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Moln=
ar
> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; Michael Kelley (EOSG) <Michael.H.Kelley@micro=
soft.com>
> Subject: [PATCH 2/4] x86/hyper-v: use 'fast' hypercall for HVCALL_SEND_IP=
I
>=20
> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> hypercall can't be 'fast' (passing parameters through registers) but
> apparently this is not true, Windows always uses 'fast' version. We can
> do the same in Linux too.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
