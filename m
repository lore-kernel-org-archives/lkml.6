Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37394C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CA52086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tkfXEQDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfANP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:26:55 -0500
Received: from mail-eopbgr740072.outbound.protection.outlook.com ([40.107.74.72]:35936
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfANP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SseuCRrqCTHr/0KC0oJaNIXGL/XcJAxzB78EKopsnMQ=;
 b=tkfXEQDXTCiGul1JJb/976K5EaeVvk+M8DAA7kuZFnV2npAQpgkj/liFyBwyWRCmsC6FXLYV4X10yglm1qUupTR+ywhBnqdj2D9DtdFJmSfjqzpKhoUl33WjGELjA+t5Xnu84tXHDf+FaReOPCbCbGmS9reFgAqiPOOj1yOROU0=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3581.namprd12.prod.outlook.com (20.178.242.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 15:26:51 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 15:26:51 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path
 as well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2qWngtqAgACqJYCABm8wAIAAVaaA
Date:   Mon, 14 Jan 2019 15:26:50 +0000
Message-ID: <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
In-Reply-To: <20190114103312.GG2773@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3581;20:yQS8w+UQYRXpDpoADHhcQT06e+ZMkSc0lmMEPCQzxC0g0FHSYtC8qSvFmmnvtvj4IrBEq9q9ZfRRt5I3olVc+UTeK4an9viVbz0UJosEBdBABDoBjokHhvQMzTDSe6Imis0rDsI1OuqHpBXoPFgGOYJyo8Sj/6Ld6k+c3o4I3a4cQMjzaMf3IT/DV5ygI+Em08diSiEPVcN6licysR8Y7944pCDOcFbwt4g+4WeJV3XPKB6Qn7HF5vfSVsyMCfLo
x-ms-office365-filtering-correlation-id: f4de54c0-fbe5-492f-df3a-08d67a34b3d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3581;
x-ms-traffictypediagnostic: MN2PR12MB3581:
x-microsoft-antispam-prvs: <MN2PR12MB3581CAD5CBF29027FADDC93FF2800@MN2PR12MB3581.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(478600001)(14454004)(14444005)(305945005)(6246003)(6636002)(256004)(54906003)(110136005)(186003)(36756003)(68736007)(97736004)(72206003)(4326008)(6436002)(6486002)(25786009)(31696002)(6512007)(93886005)(5660300001)(6116002)(7736002)(476003)(53936002)(3846002)(2906002)(229853002)(81166006)(81156014)(66066001)(8936002)(71190400001)(71200400001)(31686004)(6506007)(386003)(2616005)(99286004)(486006)(52116002)(446003)(11346002)(53546011)(316002)(105586002)(106356001)(8676002)(76176011)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3581;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7r6rday94FYNsRyg+S5SQar4VzsLETlywrFIItJjrxEfnszQ9R+cO0Q/ZR5lTau1z/Ob+46vg7bN0Ul1RWplRAq7upXTCtggz+CQ3EWFdvfcxb+TdljKIvKUh1GD9cLqy6YCV96WN7ZSjITBuD3YJ46uDOy9yHT4pjfJp7IzzqFG5L3RrXkdHqCmo/gkizVkTAA9lrCmeF56QzgEmxug0ODWx20zNPTTdhmvuquEZiTzCz2f+E1IQ+EbEDFB/sB/6+R/xu98Dcil1xrtUhoudTPIXMJckS3Cn0NoSrKJGJyrGdVfsUwUJZxqjpnfU+2uPxFTslz+GfMQj6/EzXNKHYQJWSayzUxbwYMnUlb5hmvId+7O8gLCFVV10cfztx8IXkzE8VIwXthjl7/EtwQgp7nayeuXSuBvguQUev+GOtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3594A274C5888042A6DE01E207456541@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de54c0-fbe5-492f-df3a-08d67a34b3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 15:26:51.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzE0LzIwMTkgNDowMyBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUaHUs
IEphbiAxMCwgMjAxOSBhdCAwODowNDo0OUFNICswMDAwLCBTIHdyb3RlOg0KPj4gUGVyaGFwcyBu
byBuZWVkIHRvIGNoZWNrIHRoZSBtb2RlbCBhbHRvZ2V0aGVyLCB0aGlzIGlzIGFwcGxpY2FibGUg
dG8NCj4+IGVudGlyZSBmYW1pbHkgMTUsIHNpbmNlIHRoZXJlIGlzIG5vIDh0aCBHZW4uDQo+IEkg
d291bGRuJ3QgYmUgc28gc3VyZS4gQXQgdGhlIHRpbWUgSSBkaWQgdGhpcywgd2UgZXhjbHVkZWQg
bW9kZWxzID49DQo+IDB4MTAgYnV0IEkgZG9uJ3QgcmVtZW1iZXIgd2h5IGFueW1vcmUuIFlvdSBu
ZWVkIHRvIGNoZWNrIHdpdGggaHcgZm9sa3MNCj4gd2hldGhlciB5b3UgY2FuIHJlYWxseSBkbyB0
aGlzIGZvciB0aGUgd2hvbGUgZmFtaWx5Lg0KDQpJIHdpbGwgZ2V0IGJhY2sgd2l0aCBhIHRob3Jv
dWdoIGNvbmZpcm1hdGlvbiBmcm9tIHRoZSBodyBmb2xrcy4NCg0KU2luY2UgWWF6ZW4gaXMgb24g
dmFjYXRpb24sIGkgd2lsbCBjb25zdWx0IHdpdGggaGltIHRvbyBvbmNlIGhlIGlzIGJhY2suDQoN
ClRoYW5rcyBmb3IgYWxsIHRoZSBjb21tZW50cywgaSBzaGFsbCBpbXBsZW1lbnQgdGhlIHNhbWUg
aW4gY2FzZSB0aGVyZSANCndvdWxkIGJlIGFub3RoZXIgcmUtc3Bpbi4NCg0KUmVnYXJkcywNCg0K
U2hpcmlzaCBTDQoNCj4+IEkgaGF2ZSBzdW1tYXJpemVkIHRoaXMgc2VxdWVuY2UgYWZ0ZXIgY2Fw
dHVyaW5nIHRoZSBjYWxsIHRyYWNlIGluIGJvdGgNCj4+IHNjZW5hcmlvcy4NCj4+DQo+PiBJdHMg
Y2xlYXIgdGhhdCB0aGUgcXVpcmtzIGFyZSBub3QgYXBwbGllZCBkdXJpbmcgUzMtPiBTMCB0cmFu
c2l0aW9uLA0KPj4gaGVuY2UgdGhlIHBhdGNoLg0KPiBPay4NCj4NCj4gQnR3LCBmaXggeW91ciBt
YWlsZXI6IEl0IGhhcyBhbiBlbXB0eSBmcm9tOg0KPg0KPiBGcm9tOiBTDQo+DQo+IHdoaWNoLCB3
aGVuIEkgZG8gInJlcGx5LXRvLWFsbCIgaGVyZSwgZ2VuZXJhdGVzIGFuIGVtcHR5IFRvOiB0b28u
DQo+DQo+IFRoeC4NCj4NCi0tIA0KUmVnYXJkcywNClNoaXJpc2ggUw0KDQo=
