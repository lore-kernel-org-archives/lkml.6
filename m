Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB76EC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933DF2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FuEVU/jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933DF2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeKHIPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:15:02 -0500
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:23584
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbeKHIPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CFP9LbR2E+RL7XzZaoteKkbd8xvW7mbFxlP5lhbxbM=;
 b=FuEVU/jFbMdgVYJauEK9sSpD1YPCIjdQm8zD+jpskiEgCSHREF6FMZwXUpig7j+rliF5+LibmwiP+9vKDxUkIAwPGLZh11FxHRyrokKRygIE9u86g6qKcIgUcZhBP5br0aKuDJFZlrao/9mTyhrXItD6XSGW95wSOFe4ghFl+3A=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0792.namprd21.prod.outlook.com (10.175.121.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.1; Wed, 7 Nov 2018 22:42:27 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d531:216d:20e5:ecf3]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d531:216d:20e5:ecf3%16]) with mapi id 15.20.1339.009; Wed, 7 Nov 2018
 22:42:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Long Li <longli@microsoft.com>
Subject: RE: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
Thread-Topic: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
Thread-Index: AQHUdh/7HQUTgxnwQ0ms3OFdp8tfHaVEn4FQgAAjqgCAACXFUA==
Date:   Wed, 7 Nov 2018 22:42:27 +0000
Message-ID: <CY4PR21MB077370DED982AAC7B40B884CD7C40@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181106040000.27316-1-longli@linuxonhyperv.com>
 <tip-e8da8794a7fd9eef1ec9a07f0d4897c68581c72b@git.kernel.org>
 <CY4PR21MB0773C3A2748B87E9125095F9D7C40@CY4PR21MB0773.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1811072049070.1666@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811072049070.1666@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-07T22:42:25.7938260Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0792;6:loMgnr+a3K4ifQYo6QtRBFxzunDvncBxl8+m6kFexCiuD5A+1EJ9v7P/MUfJjQPzcQdCixClRgsJKjdJs89zL/MuWQszzMERK/DiM/KUyoJPDwetrA1kZajDvRL4RQRQ36u/+PsQNxLC982HLTju1NSrnVrgbgOmyvvi7MeT/39qabDTUt2kMals1+zX63zDlOF+0uYO3z+l0mVKq3SpYAguOVH1l/oZ4K6K9Hit7kKYr8rNrPSSNFOYlIcZMuLdaurJJuMyCnwNVjXy9BXk7HEd1FEgayuNxl7mftormiWIDlzcXuvY+yubzyvy0cl4Q/AXUOFC+XA2Tx92by4ShiGWzisO2y5nvk08hxW1KWG19gR8xwwtYi/av/hlUu7cAkpYqum/eI7l+Lb5LUx/DtZ7OjK+yOPhv4gayX/esS+7P/a7XuKR3LOhACm086DIi5XPGGQvBt0qeTCvoIkBAg==;5:cgxmfFXJYFDlkgxtMslxl7Qy7vMqj/vulAz1J8MU+EpKVZt7H6HsoUzvVwxa2CRQLlp6FuFY7/4G2F5ZRQ4SWDBUFxfHRTs8c01Cx8ujurLFXn+JfzJc5ibVe8ENcmfZNYbzvEV1/0LZ8S5XGFw9iNNPcIbRmy+2G34BtZ3QLLw=;7:0QdpxKitqQWXm5/UQMsGAR76KZntSnqdXzmuxVA/CJqrVTGcnSUhYSoWOtcqfBdJ/Is0emHLpmmI5YuvRcHCM7cT3qYeB0zED1w83nv1z2S4fkrHLWTnpnpUMwgic0RnntkK0ThcgKEHcaV4oyT1JA==
x-ms-office365-filtering-correlation-id: 0b2e29bb-3e3b-4d4c-cc6a-08d645024b68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0792;
x-ms-traffictypediagnostic: CY4PR21MB0792:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0792CF5F7CC46EC0DD971AB0D7C40@CY4PR21MB0792.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(3231382)(944501410)(2018427008)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0792;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0792;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(2906002)(93886005)(76176011)(4326008)(99286004)(486006)(8990500004)(6916009)(33656002)(54906003)(6246003)(22452003)(6116002)(107886003)(2900100001)(7696005)(53936002)(7736002)(305945005)(316002)(9686003)(476003)(229853002)(3846002)(8676002)(68736007)(74316002)(97736004)(10090500001)(81166006)(81156014)(6436002)(26005)(5660300001)(256004)(71190400001)(71200400001)(186003)(10290500003)(478600001)(66066001)(86362001)(86612001)(106356001)(6506007)(8936002)(55016002)(14444005)(105586002)(11346002)(25786009)(14454004)(446003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0792;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 908KygAqJ6QbCnwCqlrhzwmZjURWbB7QbWAJT8QREZvXIyb26z8+je7g6PQ9R1X+3fHl46/Wg9oZAiTppVkQiPPZ+OH/ht4W1XHW76QHRXyg6yJ0ixP9HgsA8b4M2vo2QB2DJikzJFhGatzzIbOSG5fKzX1cufNGD0aVVlDpzPVQxTdK1AFtCzD1eXGV77MThdyrG5Ti4xDRTpphrBOoOBzzrBLnpIZhXv0V4l/BIPc8olejITCaQXHECdTO5z3ytl8YWpxieYuUGc4hpYsygIJ75WInQ5nQn7BU9fauwB+vJk/ZBNmY5JzpjyNfF+jdvBollPfKzDp/j6XOQgl736APeMJTYRfvKBGpyOCleJQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2e29bb-3e3b-4d4c-cc6a-08d645024b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:42:27.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>  Sent: Wednesday, November 7, 20=
18 12:23 PM
>=20
> There is another interesting property of managed interrupts vs. CPU
> hotplug. When the last CPU in the affinity mask goes offline, then the co=
re
> code shuts down the interrupt and the device driver and related layers
> exclude the associated device queue from I/O. The same applies for CPUs
> which are not online when the device is initialized, i.e. if non of the
> CPUs is online then the interrupt is not started and the I/O queue stays
> disabled.
>=20
> When the first CPU in the mask comes online (again), then the interrupt i=
s
> reenabled and the device driver and related layers reenable I/O on the
> associated device queue.
>=20

Thanks!  The transition into and out of the situation when none of the CPUs
in the affinity mask are online is what I wasn't aware of.  With that piece=
 of
the puzzle, it all makes sense.

Michael
