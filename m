Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68620844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lCg7SxM7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mfEJXBYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfBFN5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:57:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5427 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfBFN5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549461455; x=1580997455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z6PRaJ3YnHHAKJvc/Z2KGVHNFtxPI9HFCMwg7MWVsAw=;
  b=lCg7SxM7u9TNVEknVJVTzggZ0uSLfnGOyzYB89bPBSdFgZHVevDHobh0
   mVifochhxEqQiFIT9NT/0LzLAIZLnlxicUULcZFWRQ3VY5Ohm2T9sUeA9
   FOpVezH32JfzgczTicA1oPuQATWL9HAqmnZrtH/7birhJbUqOIlFx3Q5h
   JvXiTuqFLE1fa642Q8u0kzl54IesnTGpXGYknT/fyNfN2DxNm9aCH9g+A
   XPVL7DZ0nN6CSgwBsBNCT4RrcCx4Kt/6HihnopY8P3344knacUN+SXv4P
   DjJcZ+Xv4Tg0ubfCe3YfFAq3EyH/BFQmznz9AOxtD2HyYn2Npx2ce2aEc
   w==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544457600"; 
   d="scan'208";a="102409175"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 21:57:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6PRaJ3YnHHAKJvc/Z2KGVHNFtxPI9HFCMwg7MWVsAw=;
 b=mfEJXBYbWPD9EnOa5H+dKDdgLzHqb7RSTm+ol3WLdFeIVGjXkxghAEE/E1rkbHO4j9mbFKmXs3xfIZAntHmLrTkMfuNSS/j1GyMehqJTTPnXQALCayqSeNuFpdiH3OH1P0Rr7x1u25e4JViVviskOlrOMSvA0zl9LhhHTP76vG4=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4574.namprd04.prod.outlook.com (52.135.120.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 13:57:17 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:57:17 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
Thread-Topic: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
Thread-Index: AQHUvYUJXCGbR8eUckWD2lWQ8QcUhaXSpv2AgAAiFzA=
Date:   Wed, 6 Feb 2019 13:57:17 +0000
Message-ID: <SN6PR04MB4925A158FB93AC99D15ED3EBFC6F0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190205185902.106085-1-evgreen@chromium.org>
 <20190205185902.106085-7-evgreen@chromium.org>
 <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
In-Reply-To: <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4574;6:4lZI89uoWRdge81ttfR+gTiMD6NyhZLuf9wTykhjFMeOWlbqKWwDYonzGCXjG1F7ThsUdXACbQlQdxc3wvUyHaNV4lzw3K0tAYhIaHB5JFopQ9hWCN9C7gjNmfH7jlw/m6ZvejCs7LntCyXABm1CfJ79AkoBDtak/R+yPriIFoi2qO7LhvHjU4uh38N84vz3dmxLe0Yx7DW+L3ISTYWzV3sbmfKtmdQZkEB/0rcvViFv+3N6FzSxdJ8xJwOgLu5yWaGNTaWds5EZvf/sYuz9iU6n6bvNYYDVOw95z7SC7SdZXh+BY3W1scG6adq7jBa7qhxZAbAQ9YS1cZMqvAWwaXyk6JnhZUvWkEqNENixmLNgm0tZiql55sR9h3uz42t3h6CXbOqt/0WGNyn5YNlROC5Upul0fi11iIb+QERxwu3QvhN1ipsWSK/hATYKPX5OC6+310xmOFe6+L05iZ1iCQ==;5:HVqLxpk97gIjj/R8C96P+Vmuo4dVIURzDDBPs0xe7KJ8q8oYcgoL19nKOuFKR4Y8VmEO0pbx0R92ZK7iDRfxu3grB8SHDKki2tzwMoLILYBCiF68iWU4napM4FkqkZTQONAk6nU0NDfZm3ibx82sMTzBpsATzbmmTlhb+/kNs1wlA2H3oRoE1GimNR79VEi5aChY0zd7jjq4zAGX8SFwdQ==;7:bRupiGsr6zLVq3yFBJyyDMd/YVzJHqrTWxWhJYaXgV1tUlP7aVq7+I7/dymHDZ4d2t2SNiT2sn5+D7rydVc68bizlWLx2+1X0ykH7TY3g7PSs8MrKvVecMTUcnXPd1JNu+yVTmwG3NLKQzHFTUCLHQ==
x-ms-office365-filtering-correlation-id: 624d020e-c22f-448e-6edf-08d68c3b0141
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4574;
x-ms-traffictypediagnostic: SN6PR04MB4574:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4574637137D371A339D8A47CFC6F0@SN6PR04MB4574.namprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(55016002)(9686003)(6436002)(72206003)(229853002)(478600001)(256004)(106356001)(66066001)(97736004)(68736007)(4744005)(105586002)(99286004)(476003)(486006)(11346002)(446003)(7416002)(54906003)(71200400001)(71190400001)(316002)(3846002)(110136005)(6506007)(53546011)(14454004)(7696005)(76176011)(102836004)(186003)(26005)(53936002)(7736002)(305945005)(74316002)(4326008)(2906002)(6116002)(25786009)(8936002)(8676002)(81166006)(81156014)(86362001)(33656002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4574;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cQHvPrOIdTxvjx2D7AU10E03ictRqjfdKnwSWuMWBf4UEwFGlwfpsfxu2v1pRF1i46KRUjSFJRKzjEUZ372fpkZ/6KphV3VBJzebGwT4/8tPn2COQuyUVfcGBudvAGcMZnPdHxCR8HSq2uu0Ko85jFWdtd3c3g2xOUvulc+YNlflwV9jezx1X7hcagYi0MK8eiSp6rg+ah+/1Zpe9AgNH4cikH1YMZYcO1LPLEWP/t+yGIwWQ53Co1A2enXbXn99KBgzX1PTCuF981IqWh2M3xoHPIc+gkdG01BdGLLJ+m2Ufya8YT1iTZEXlySJPuFanglSwwaukKW6Y2Vw5LUKTokeEpbhHvET4CQthmnzFolOScBFzs8LIsPEbZNMDv7SkAdUf4pQAnYEwyvZ8X9kuCQujgUOaWHcc2S3gQ/wyhA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d020e-c22f-448e-6edf-08d68c3b0141
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:57:17.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gT24gMDYvMDIvMTkgMTI6MjkgQU0sIEV2YW4gR3JlZW4gd3JvdGU6DQo+ID4gRXhw
b3NlIGEgcmVzZXQgY29udHJvbGxlciB0aGF0IHRoZSBwaHkgd2lsbCBsYXRlciB1c2UgdG8gY29u
dHJvbCBpdHMNCj4gPiBvd24gUEhZIHJlc2V0IGluIHRoZSBVRlMgY29udHJvbGxlci4gVGhpcyB3
aWxsIGVuYWJsZSB0aGUgY29tYmluaW5nDQo+ID4gb2YgUEhZIGluaXQgZnVuY3Rpb25hbGl0eSBp
bnRvIGEgc2luZ2xlIGZ1bmN0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBHcmVl
biA8ZXZncmVlbkBjaHJvbWl1bS5vcmc+DQo+IA0KPiBJJ2QgbGlrZSB0byBnZXQgQUNLIGZyb20g
c2NzaS91ZnMvIE1BSU5UQUlORVIgVmluYXlhayBmb3IgbWUgbWVyZ2UgaXQgaW4gUEhZDQo+IHRy
ZWUuDQpMb29rcyBsaWtlIHRoaXMgc2VyaWVzIGlzIHFjb20gc3BlY2lmaWMsIGFuZCBoYXMgbGVz
cyBpbXBhY3Qgb2YgdGhlIHVmcyBjb3JlIGRyaXZlci4NCg0KPiA+ICsJZXJyID0gZGV2bV9yZXNl
dF9jb250cm9sbGVyX3JlZ2lzdGVyKGRldiwgJmhvc3QtPnJjZGV2KTsNCkp1c3QgbXkgMiBjZW50
czoNCklzbid0IHRoaXMgc2hvdWxkIGJlIGRvbmUgc29tZXdoZXJlIGluIGRyaXZlcnMvY2xrL3Fj
b20sDQpMaWtlIGl0cyBkb25lIGZvciBhbnkgb3RoZXIgcWNvbSBib2FyZD8NCg==
