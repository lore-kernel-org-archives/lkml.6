Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B00C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991EA20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UJVM1T5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991EA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeH3Vfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:31 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:62592
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeH3Vfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmf/HIfFMCswdJi13hWJI+kxmZRFvEBtDIgoqIeOC4A=;
 b=UJVM1T5Q9D373EGYz9u4fArrLv0i2V0kit2GcRqQAkOJceYMhZUDthwgEuuPgnwUf9MdqNmYrngNEqyTsMOg7Lca0LD/sne+Cw5FJToMl270mt2D4QspnnAjGHd/BwqW6nAJUXRaeuQWhdgRwEndUrpNCDd4gO4H659mV5szFH0=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1018.namprd21.prod.outlook.com (52.132.146.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 17:31:58 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1%4]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 17:31:58 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Index: AdQ7H/34qAH7zeGBQLegJ1KnxB9zFAFWLlUAAAM1tsAAAE/x8A==
Date:   Thu, 30 Aug 2018 17:31:58 +0000
Message-ID: <MW2PR2101MB1113456E92B548A3405A0E5AA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB11138A251E48BC8C6B859BF1A0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <PU1P153MB016943FAF912D00D54F46493BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB016943FAF912D00D54F46493BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.136.232.39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;6:W/esra+3DsxATFsbUdq0fAXrIb287LzBn+t5h+814LZd9s2zDycWnXPeHiQIe6Q8k6SkHE9rTVxxAe3E4S1JG/rsyery2F4bCr7Hz5wYw9BztkIEVq0bvSuL6UiDvl/1UZ6LWlPAlElIxKLPW6531v7G7NLIEtAj2T1sLXL9ng4Dv9jz4cS/cMaGqh9gMjmCAxFOhxOtfmKY3T5y8568Pht/HDl361qG1xlopxm6Nyzz9nkqafu0f86TVqSFWLjm8YbJCHhqkeFWxksVLSsm13lDTNP4+EuzbDb8iEuK3f0+RDPWLDDHLbh0LD5CH9be2HKRR5xTX1vscdbwFZZL+3NVzh6rkykOQKyBewst4zywVvvcfVh/K3mIHOAsc66xrcR9AnYco4ImKBviFB+APg2AOwBFp+SFEYFozXfiUb5cf4uMiPWszUzlWEf6wGMXxkemPnwR1ZDZPla4uRbV2g==;5:0T3ivuohGG9F6gbYE1FtbTYGnGqQyNJ7SV2fIw5ipu3rRHwsJMoJ0FV/s0pHvY+MFegvtejkMVekp5ZxsvDXdPWSVuzByDicRyJFHhf/Szfhe9WKuA/TF7qWC2k9zuJsYycX1e0t/9uA1RhkSeKvNAfRQnojep9OSZtMU80CF/Y=;7:KeIpapfnvjM3N5aOuK/SgnT1NFWLADlP5OfAJqYBMg9r2CqNmpz881/BJIdL9RRZpr9fmJ7jgLd80cMcrUKvbtWE7J0P0VlHE4CvLlu1g5M+sRHbBxnq+LsvMwwQn7WSmByiIbCnKq3AjQnVXZkt1sk7eShjYiah7vCA3rFOF9k7Dg71LXSyI2Rk5EGzRxV/GWtOs2JPF1ISh/RinKhQ8H+15iBradDFRfwtm/rEmhS4XgoAm0tFNrjdUDa12sM9
x-ms-office365-filtering-correlation-id: ede8b5c2-02c4-4b43-ffb6-08d60e9e7d1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1018BFB988DE1A6AC441137DA0080@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(21532816269658)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(13464003)(6246003)(99286004)(11346002)(446003)(476003)(486006)(76176011)(26005)(53546011)(6346003)(6506007)(6116002)(3846002)(102836004)(7696005)(106356001)(105586002)(10090500001)(97736004)(14444005)(256004)(2906002)(25786009)(4326008)(55016002)(9686003)(1511001)(6436002)(66066001)(8990500004)(14454004)(229853002)(53936002)(478600001)(22452003)(8676002)(6636002)(81156014)(81166006)(8936002)(316002)(68736007)(5250100002)(305945005)(5660300001)(110136005)(74316002)(7736002)(54906003)(33656002)(86612001)(2900100001)(86362001)(10290500003)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: f81ZjFJdu8KSnWpOBjbfuHUaBwTtOI8Gfw78JpWOMi1zExl+G2pAIkSd8TipX3+OqYyaOXjze9Gxmpcaw8WE9ne6SA2JyrRC7mw8AsvgIf7SY378/E5GIWoWV7PfvFkdkdUnC+PSYAw0p2X//tqCrceJ26mb0SOk5u4TP/xZjuaEql62SQ2hb2oZTJZ/QY4L3c7FJxLmwiN+6W4aKHcMeguOCa3sNmoAhoggotmZ8ueuBpUXDdvf70aNi6KDbGKFUnKMymO86ZU2ErG0INVVWsO+lFpQ/nEtFBJMGNX4sPsRyIxZM2QvWi1WdexlWnepFH7/p8rQBtxnFjOz4SPBlwCRxdc2u+FEaju+5+RWK1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede8b5c2-02c4-4b43-ffb6-08d60e9e7d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 17:31:58.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dexuan Cui
> Sent: Thursday, August 30, 2018 12:27 PM
> To: KY Srinivasan <kys@microsoft.com>; 'gregkh@linuxfoundation.org'
> <gregkh@linuxfoundation.org>; Stephen Hemminger
> <sthemmin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>
> Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> 'driverdev-devel@linuxdriverproject.org' <driverdev-
> devel@linuxdriverproject.org>; 'olaf@aepfle.de' <olaf@aepfle.de>;
> 'apw@canonical.com' <apw@canonical.com>; 'jasowang@redhat.com'
> <jasowang@redhat.com>; vkuznets <vkuznets@redhat.com>;
> 'marcelo.cerri@canonical.com' <marcelo.cerri@canonical.com>
> Subject: RE: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
> vmbus_connect()
>=20
> > From: KY Srinivasan
> > Sent: Thursday, August 30, 2018 09:28
> > ...
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > @@ -119,8 +119,9 @@ static int vmbus_negotiate_version(struct
> > vmbus_channel_msginfo *msginfo,
> >          */
> >    if (version >=3D VERSION_WIN8_1) {
> >        msg->target_vcpu =3D
> > -            hv_cpu_number_to_vp_number(smp_processor_id());
> > -       vmbus_connection.connect_cpu =3D smp_processor_id();
>=20
> > +       hv_cpu_number_to_vp_number(get_cpu());
> > +       vmbus_connection.connect_cpu =3D msg->target_vcpu;
> > +       put_cpu();
>=20
> While the warning " BUG: using smp_processor_id() in preemptible" can als=
o
> be avoided, the line
> +	vmbus_connection.connect_cpu =3D msg->target_vcpu;
> seems incorrect, as the "connect_cpu" should reflect Linux CPU numbering
> rather than Hyper-V's vCPU numbering.

Yes of course!  Can you send me a patch with the fix.

K. Y
>=20
> -- Dexuan
