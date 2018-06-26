Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6EA262E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GKnyrN+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6EA262E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755747AbeFZADw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:03:52 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:18211
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754330AbeFZADu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngMxqOVpUI1NLHaqZjwWNs5BiRwrS25Q2BAlfvLbHZw=;
 b=GKnyrN+rX5wEWy/rtafs28oyE4hcUJCjkjcx+D/MSenY/FlNQkXvTgma7l7hvveW2gbZtQGvfiUFSZqCgejLjYEBUDTcHRsYnmBtsZ4UM8d/naCnQq8LnlLvHf+i+ovjy8BZlyXbNL3Ybsr+n/jkNdoouwiJOtyEynwkIsD9TCU=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1069.namprd21.prod.outlook.com (52.132.115.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.6; Tue, 26 Jun 2018 00:03:48 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0930.005; Tue, 26 Jun 2018
 00:03:48 +0000
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
Subject: RE: [PATCH 3/4] x86/hyper-v: use cheaper HVCALL_SEND_IPI hypercall
 when possible
Thread-Topic: [PATCH 3/4] x86/hyper-v: use cheaper HVCALL_SEND_IPI hypercall
 when possible
Thread-Index: AQHUCktiyUHpc2y48EWFPLv7XM/A8qRxrYHw
Date:   Tue, 26 Jun 2018 00:03:48 +0000
Message-ID: <SN6PR2101MB1120F3D64FA63E5D084F985EDC490@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
 <20180622170625.30688-4-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-4-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-26T00:03:46.7172195Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1069;7:HFjG9MhjxJCPZ07j03xEqEosypiGN6hEuIr/JJxWxKnNzJKGaLRUlnjXk79vuwTN82DOz+0X/bg+BXxkC+DXokfnckx6B87suLC1A5T//dLJ5BMf6hbDvmBBvW0rYd/aF+SOY8nGRmY4QOXOkguuv5n+F3RFA1N3qw4PoyGcbbPewLYtQqqLgciPIP67v3AbUQ1X8nfnvP9PZfLt0lKVLh3OFYgdBIWNZObbrXzqtnq8Y86dRQw86lhyp2NFhyB3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75008a4d-d6db-4cca-b6ba-08d5daf84acf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1069;
x-ms-traffictypediagnostic: SN6PR2101MB1069:
x-microsoft-antispam-prvs: <SN6PR2101MB106916D5E77B6474E3C6732BDC490@SN6PR2101MB1069.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1069;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1069;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(8936002)(25786009)(4326008)(107886003)(476003)(11346002)(2501003)(10090500001)(106356001)(5250100002)(14454004)(86612001)(72206003)(68736007)(229853002)(256004)(2900100001)(53936002)(8676002)(10290500003)(105586002)(3846002)(2906002)(6116002)(5660300001)(81156014)(81166006)(6346003)(110136005)(305945005)(7696005)(97736004)(54906003)(102836004)(99286004)(76176011)(74316002)(33656002)(446003)(66066001)(486006)(55016002)(478600001)(9686003)(86362001)(8990500004)(6506007)(186003)(22452003)(6436002)(316002)(53546011)(7736002)(26005)(6246003)(12043001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1069;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: mtb49Yqqq3aWW6wxIV/J63pQHJ+Uo2UTAEF2JF3RgwVbY4LBwQ+duaEP3xT+A8UoUqp7NjQcqNJYWBo4YhvWGs5nhgE08786XYt3fYK+O/nMCWdy0nNJS6p3z5+2eGl3sHOQS7qOWfCcs6n0kq5PFZ/B1sw/Q87rGO6ri05851itFsj5nIorX8X22WGaW+AxSTKkXh2RlqbWXCBsz2822ilxr1U9pvBztaKQ2jyzeY6qUrkSJwZcQ5S07fbup/eCFeheKniWsw9vngq0GpHhh8DTJmLEM/haEKde0EOxF5LyLuUdLyv5SElMgnC4tbJ7CAzj2ObJXNErCtXI2ATRQWBv1PTU6RBRDMcQzEnTF/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75008a4d-d6db-4cca-b6ba-08d5daf84acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 00:03:48.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1069
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
> Subject: [PATCH 3/4] x86/hyper-v: use cheaper HVCALL_SEND_IPI hypercall w=
hen possible
>=20
> When there is no need to send an IPI to a CPU with VP number > 64
> we can do the job with fast HVCALL_SEND_IPI hypercall.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
