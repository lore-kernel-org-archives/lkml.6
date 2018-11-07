Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF18C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C872081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bwySVrRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C872081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeKHENh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:13:37 -0500
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:7263
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeKHENh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+DLsOvwQC/dNfMphswknC0ulJXgxkLxci5fGLOTxCM=;
 b=bwySVrRmr8t7hTKmx+zcDRgImFEKC6GjERHY2BEZBHcjiHVHxhmBaLcuB3O/pjC+mCOi7Jv8NtdiSFGYpvvmapFSjo2TQ2DAX+k95yMFI++dMVMQQpl3UrDeHbRbgdDVA1f5oiL/BZjIZ6bRpyRJvyj8W5WTTue826N4ZAp7FMQ=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0632.namprd21.prod.outlook.com (10.175.115.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.6; Wed, 7 Nov 2018 18:41:58 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d531:216d:20e5:ecf3]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d531:216d:20e5:ecf3%16]) with mapi id 15.20.1339.009; Wed, 7 Nov 2018
 18:41:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: RE: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
Thread-Topic: [tip:irq/core] genirq/matrix: Improve target CPU selection for
 managed interrupts.
Thread-Index: AQHUdh/7HQUTgxnwQ0ms3OFdp8tfHaVEn4FQ
Date:   Wed, 7 Nov 2018 18:41:57 +0000
Message-ID: <CY4PR21MB0773C3A2748B87E9125095F9D7C40@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181106040000.27316-1-longli@linuxonhyperv.com>
 <tip-e8da8794a7fd9eef1ec9a07f0d4897c68581c72b@git.kernel.org>
In-Reply-To: <tip-e8da8794a7fd9eef1ec9a07f0d4897c68581c72b@git.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-07T18:41:56.1410311Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0632;6:7MNsQkMUcAspz55wCx0+saHhf92KQNmM8xivQbgYs9oK0ZBAwlsPgJamdn+8U7yOrTuuikGMq26YgD40d29uflGt4vHe0H7Z8VlbWzfbG6C3s/9xr6HNgDO50u+aCvIMHVNepfpxBq9zjY9ce0+5ouGk4ATbfQmxoFYXX6HGxrKiC9KlmOmU1OiEzRF2Qzm4ktROqcrIMolodv/MBKYDKLFGM18cWRdwVZBKacMYACs+HkPthwGUYgesDqzQeUMnYlpQKeFrmNRnDHt4y1IgmRbgvQR5ZKpYGCSNBR+5Be+dF461tAGXIX2226RD7eE9aM34r2hL1lTu7H/2TQgX896HP4+x50FGzZaWYlEAYCt7IUFQXnwOfXy1/G3Ci8SizBGw9v2hgyjmoybBkwJ5sfOr7wFZQ8QMpHHDC6sG8TJkCAZ1cD7/YOGE1H4xOBJGgwlPlpnb9QmLjACG7cpXrg==;5:NVCDq3bzb8K7BoUfbEq7UT82m6YyMbBpsJGGkBRftumXfFBM0lYnJicQWxLMyU0YI9mAjPm/oVaN3xLPaLL6JbRnzv0lSjvHMtW/NZVVo0T37LlA6Nb7oxxxPX47WuzAyumy29uA1NMOffL/dt7ER03+MN0D+Y14rgKvSVgynSU=;7:XtW+RdJPsNWJLwi79mzFP7UK03GdiD5A2IH6NIMqQeYh1eOTkPLAsvkATcAprXfZ5PabRWpBD5TD0EpZTwjpynnxeglQ4z2g455eTo0SplrkeuvKEDXZkWimE7JQPf3evheBp/DN41m5v3jNgpALgQ==
x-ms-office365-filtering-correlation-id: cff3f94e-4af8-467a-f802-08d644e0b2b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0632;
x-ms-traffictypediagnostic: CY4PR21MB0632:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB063238D5A33A4C34F1E7D913D7C40@CY4PR21MB0632.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231382)(944501410)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0632;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(102836004)(478600001)(81166006)(229853002)(81156014)(25786009)(66066001)(6636002)(8990500004)(68736007)(8676002)(186003)(26005)(2201001)(2900100001)(7696005)(1511001)(76176011)(6506007)(86612001)(33656002)(99286004)(5660300001)(86362001)(110136005)(316002)(22452003)(8936002)(10290500003)(53936002)(6436002)(97736004)(14454004)(6246003)(105586002)(2906002)(486006)(476003)(9686003)(71190400001)(256004)(71200400001)(2501003)(55016002)(106356001)(74316002)(11346002)(3846002)(446003)(7736002)(6116002)(305945005)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0632;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: km6uu08IvTHaVS086SbBQfDOJQ6Fa1R+09JaiIXKVaxWB3PQ8iiAxRrAhh/D5CtChylV0p+tt5fcV/c6QD3YsUO1YiDGc3SPpdXvfZ11lUFxA+Dv/vyLTeLJzRiksSdMG6Mltov4urDisQvsqSVjg7S56waguHIpXZBXhS9f++6DiavlOHIcHSaj+djiCp1i3khayDvR36fseMNR+BVEXPO4fGEgOhQoPesQoH79B7MTtTsBQf+VfAaHNbtSLq7Oe/gG6OfYavnsgTJG/kGPjKEp9xUHneLT1Y8+Kh8x1sP3xSY3p5eUcn5/U+sfN7RpdGYAAHdVZ5sr6ZlWIMc3/DmAL99IGUnRhs4Aijxicrc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff3f94e-4af8-467a-f802-08d644e0b2b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:41:57.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogdGlwIHRyZWUgcm9ib3QgPHRpcGJvdEB6eXRvci5jb20+ICBTZW50OiBUdWVzZGF5LCBO
b3ZlbWJlciA2LCAyMDE4IDI6MjggUE0NCj4NCj4gQ29tbWl0dGVyOiAgVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENvbW1pdERhdGU6IFR1ZSwgNiBOb3YgMjAxOCAyMzoy
MDoxMyArMDEwMA0KPiANCj4gIDIpIE1hbmFnZWQgaW50ZXJydXB0czoNCj4gDQo+ICAgICBNYW5h
Z2VkIGludGVycnVwdHMgZ3VhcmFudGVlIHZlY3RvciByZXNlcnZhdGlvbiB3aGVuIHRoZSBNU0kv
TVNJLVgNCj4gICAgIGZ1bmN0aW9uYWxpdHkgb2YgYSBkZXZpY2UgaXMgZW5hYmxlZCwgd2hpY2gg
aXMgYWNoaWV2ZWQgYnkgcmVzZXJ2aW5nDQo+ICAgICB2ZWN0b3JzIGluIHRoZSBiaXRtYXBzIG9m
IHRoZSBwb3NzaWJsZSB0YXJnZXQgQ1BVcy4gVGhpcyByZXNlcnZhdGlvbg0KPiAgICAgZGVjcmVt
ZW50cyB0aGUgYXZhaWxhYmxlIGNvdW50IG9uIGVhY2ggcG9zc2libGUgdGFyZ2V0IENQVS4NCj4N
Cg0KVGhvbWFzLA0KDQpGb3IgdGhlIGN1cmlvdXMsIGNvdWxkIHlvdSBlbGFib3JhdGUgb24gdGhl
IHJlc2VydmF0aW9uIGd1YXJhbnRlZSBmb3INCm1hbmFnZWQgaW50ZXJydXB0cz8gIFdoYXQgZXhh
Y3RseSBpcyBndWFyYW50ZWVkPyAgSSdtIHRyeWluZyB0bw0KdW5kZXJzdGFuZCB0aGUgYmVuZWZp
dCBvZiByZXNlcnZpbmcgYSB2ZWN0b3Igb24gYWxsIHBvc3NpYmxlIHRhcmdldCBDUFVzLg0KSSBj
YW4gaW1hZ2luZSB0aGlzIG1heSBiZSB0byByZWxhdGVkIGhvdC1yZW1vdmUgb2YgQ1BVcywgYnV0
IEknbSBub3QNCnNlZWluZyB0aGUgc2NlbmFyaW8gd2hlcmUgcmVzZXJ2aW5nIG9uIGFsbCBwb3Nz
aWJsZSB0YXJnZXQgQ1BVcyBzb2x2ZXMNCmFueSBmdW5kYW1lbnRhbCBwcm9ibGVtLiAgaXJxX2J1
aWxkX2FmZmluaXR5X21hc2tzKCkgYXNzaWducyBzcHJlYWRzDQp0YXJnZXQgQ1BVcyBhY3Jvc3Mg
ZWFjaCBJUlEgaW4gdGhlIGJhdGNoLCBzbyB5b3UgbWlnaHQgZ2V0IGEgc21hbGwgaGFuZGZ1bA0K
b2YgcG9zc2libGUgdGFyZ2V0IENQVXMgZm9yIGVhY2ggSVJRLiAgQnV0IGlmIHRob3NlIHNtYWxs
IGhhbmRmdWwgb2YgQ1BVcw0Kd2VyZSB0byBiZSBob3QtcmVtb3ZlZCwgdGhlbiBhbGwgdGhlIHJl
c2VydmVkIHZlY3RvcnMgZGlzYXBwZWFyIGFueXdheS4NClNvIG1heWJlIHRoZXJlJ3MgYW5vdGhl
ciBzY2VuYXJpbyBJJ20gbWlzc2luZy4NCg0KVGhhbmtzLA0KDQpNaWNoYWVsDQo=
