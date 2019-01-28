Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F32183F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PiElE4aU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfA1Xrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:33 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9156 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfA1Xr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:28 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4f948e0000>; Mon, 28 Jan 2019 15:47:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 15:47:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Jan 2019 15:47:26 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 23:47:25 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.51) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 28 Jan 2019 23:47:25 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2599.namprd12.prod.outlook.com (20.176.255.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.22; Mon, 28 Jan 2019 23:47:04 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 23:47:04 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V3 3/3] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V3 3/3] i2c: tegra: Add DMA Support
Thread-Index: AQHUtStTAcI7HkG9xUCTwb3QXTduAKXCELwAgANJJjA=
Date:   Mon, 28 Jan 2019 23:47:04 +0000
Message-ID: <BYAPR12MB339874021C106E447529E887C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-3-git-send-email-skomatineni@nvidia.com>
 <5973707c-555f-a27c-2ff3-e867d4b2cde7@gmail.com>
In-Reply-To: <5973707c-555f-a27c-2ff3-e867d4b2cde7@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2599;6:Gjs0k7npeoq3W1/MzoSmGTnzpRPHtqZkew+f96KW0uiqbHo7gsGbfQhCQs2XfLMeEu+5Nage5X816jCloAQU5g53x4a1bjB5Cnv0dxHX7HjEczSr9MmNo522082ukBuqPemBPco3IItVL5Qk7frmAwDgbs6wtthO8KKPGuM9mEB9SvfV2iCP5OMhYKErf1w8P3070f1dIBP+Di1FsjWWkjGvY0KlRFp8i3F75ZMMBmCJ0af83cSlzu+zlq/E6QTfvnAL6q6+l4nFg4LacDFsAgsURnvXhgBoeXBTu9zKPdSYdCCD9utDR2yI1mpJIpCtlrW3S2Ceireu4EQ4Fox5UZapgnxQiIHoYZGAqVyDujwYq7xb85G7/qYDOCjEK3Rb76kVC4ilXr9KoKBgh2nYUfk9VaO8eSIPPXchpVJjQREUKA9Ll44JslxZmQE+CJB+/TPDt4pkOYCMVy+LfS9JkQ==;5:c4C5nEvmGyri2kgwUXRYKOVfTNmZo8ST6Mp7XPkvdiyUvPeWs/brPz5T0ZwC64kn6QbJhjJiT5DU27kh8AgSedxFix+jHVTdyQ5/4j89e0NH7MK8Tj6CTe5pko9gSSZOHS+u2hYD/VHQuxHgyx45AMzHOAIxzYPasyb5100jaFkCeoZDxbZToAr34gXrudIQ+CqNgKyvsT69Rcs5/1XTNg==;7:AVmIRbbm1SSI7fCwBBvJ0lPt28e8SLfwhuH8xzlf5hC4H7cw0bBs9yTkXfX4TEe3Gr6QGHL2AmnLo5/DoZKgTTiZ/c+AcfnCcqWXKJowRz+dGnk427Slg7YJAgwVSSt1QEbImRiQ7xdNYxwMBEEmWw==
x-ms-office365-filtering-correlation-id: 3cc132ac-d405-49e0-06e9-08d6857ae837
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2599;
x-ms-traffictypediagnostic: BYAPR12MB2599:
x-microsoft-antispam-prvs: <BYAPR12MB25994EC9BFFA0025D0D34616C2960@BYAPR12MB2599.namprd12.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(7696005)(14444005)(2906002)(99286004)(305945005)(7736002)(86362001)(76176011)(81166006)(81156014)(8676002)(316002)(6636002)(110136005)(8936002)(14454004)(11346002)(54906003)(74316002)(476003)(446003)(33656002)(256004)(478600001)(486006)(6246003)(105586002)(106356001)(6506007)(97736004)(6436002)(229853002)(55016002)(39060400002)(25786009)(4326008)(2501003)(3846002)(53936002)(6116002)(68736007)(9686003)(102836004)(66066001)(26005)(186003)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2599;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 20vg1SYm6jGHgcbW7jfZcP29lCb2N+PzKHfmKcifFJDlR6485Auh02PWpi4TV3QiVcRqYPHYwu76A+BDG2cU5VWzKGOMb8EEaIBoqHPlUZeWCrDOje8DyNNEpGLGI0nxPddQmnjjrJwxhVwnoASaAqWVx9DMP2APaPL4zqCFBA5N+QGmLlYNI00eNVWkErOmJBEeQW8AOFofu/t/NNUDK48XwPHj5iqASgAK/OPZV78bbEPP0C0UvlePkwZnIglO/tsrXR/JOSmBy3UzL+upZ/x1FKRh/HsOZUCN1h6sUWI+5qnbLURYCIp/EvYyHQR9tHQgA5MDAfI0IX2kS7we/fHKf3EDUYUNmLjRjjIB/b3/1ajLRqkPFWJ+OmsnnBRJGSxkP7uZDWtZ1qzjqT2aBepGqQ+a5KMqImb6PHAmF5g=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc132ac-d405-49e0-06e9-08d6857ae837
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 23:47:04.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548719246; bh=4+8VWOXr99jeDcz2KczVBBwFr/YkjZbqA++bqtMnWy8=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=PiElE4aUJE2Ff72zJFtNtVagawrnAqD+sjRI4LSHJl+Gy+EJrd7Nxp/Nu3kRssHjw
         7T3r2+pkTYVyk/F0pcbrG183RXECchg6wBEE7kfZV4VamM9m76oOZXCwMzDWOjvPzD
         U1kKjaHvEKoslMSZQWOQrM/JkTXgTIqBxeZwTNnrCiDPIo6zfsEm7QGCKpZ+FlUa/3
         M9OTi05BGu7iRqO+Po2Cmt8RKiodpzd9kt3NZXAmxXI+CjaRpeXG6DFUCTX4MonZX9
         KV3puuw47WS8Kbm7QxHjqN9xJFdVywYdXGTQHYGbdi9RBVRqW3dQX1Qk6z3CPZtlwH
         34wPWXVJB+psw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBUaGlzIHBhdGNoIGFkZHMgRE1BIHN1cHBvcnQgZm9yIFRlZ3JhIEkyQy4NCj4gPiAN
Cj4gPiBUZWdyYSBJMkMgVFggYW5kIFJYIEZJRk8gZGVwdGggaXMgOCB3b3Jkcy4gUElPIG1vZGUg
aXMgdXNlZCBmb3IgDQo+ID4gdHJhbnNmZXIgc2l6ZSBvZiB0aGUgbWF4IEZJRk8gZGVwdGggYW5k
IERNQSBtb2RlIGlzIHVzZWQgZm9yIHRyYW5zZmVyIA0KPiA+IHNpemUgaGlnaGVyIHRoYW4gbWF4
IEZJRk8gZGVwdGggdG8gc2F2ZSBDUFUgb3ZlcmhlYWQuDQo+ID4gDQo+ID4gUElPIG1vZGUgbmVl
ZHMgZnVsbCBpbnRlcnZlbnRpb24gb2YgQ1BVIHRvIGZpbGwgb3IgZW1wdHkgRklGTydzIGFuZCAN
Cj4gPiBhbHNvIG5lZWQgdG8gc2VydmljZSBtdWx0aXBsZSBkYXRhIHJlcXVlc3RzIGludGVycnVw
dCBmb3IgdGhlIHNhbWUgDQo+ID4gdHJhbnNhY3Rpb24gYWRkaW5nIG92ZXJoZWFkIG9uIENQVSBm
b3IgbGFyZ2UgdHJhbnNmZXJzLg0KPiA+IA0KPiA+IERNQSBtb2RlIGlzIGhlbHBmdWwgZm9yIExh
cmdlIHRyYW5zZmVycyBkdXJpbmcgZG93bmxvYWRpbmcgb3IgDQo+ID4gdXBsb2FkaW5nIEZXIG92
ZXIgSTJDIHRvIHNvbWUgZXh0ZXJuYWwgZGV2aWNlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPiA+IA0KPiA+
IC0tLQ0KPg0KPiBTZWVtcyB0aGVyZSBhcmUgZ29vZCBuZXdzLCBBUEIgRE1BIGNvdWxkIGFjY2Vz
cyBJUkFNLiBRdW90ZSBmcm9tIFRSTTogIlRoZSBzb3VyY2UgbWF5IGJlIERSQU0gb3IgSVJBTSwg
YW5kIHRoZSBkZXN0aW5hdGlvbiBsb2NhdGlvbiBjb3VsZCBiZSBkZXZpY2VzIHBsYWNlZCBvbiA+
IEFQQiBCdXM7IG9yIHZpY2UgdmVyc2EiLiBIZW5jZSBpdCBzaGFsbCBiZSBtdWNoIG1vcmUgZWZm
aWNpZW50IHRvIHVzZSBJUkFNIGZvciB0aGUgRE1BIGJ1ZmZlciwgcGxlYXNlIGNvbnNpZGVyIHRo
YXQgdmFyaWFudC4NCj4NCg0KUmVnYXJkaW5nIHlvdXIgcmVxdWVzdCBmb3IgV3JpdGUgQ29tYmlu
ZWQgbWVtb3J5LCBpdCBkb2VzbuKAmXQgZ3VhcmFudGVlIHRoZSBvcmRlci4NCg0KTWFpbiByZWFz
b24gZm9yIGFkZGluZyBETUEgbW9kZSBzdXBwb3J0IHRvIFRlZ3JhIEkyQyBkcml2ZXIgaXMgbm90
IGZvciBhY3R1YWwgdHJhbnNmZXIgcGVyZm9ybWFuY2UgYnV0IGZvciBub3QgaGF2aW5nIGRlbGF5
ZWQgSTJDIHRyYW5zZmVyIG1haW5seSBpbiBjYXNlIG9mIENQVSBmdWxseSBsb2FkZWQgYW5kIEky
QyB0cmFuc2ZlciBkdXJpbmcgdGhhdCB0aW1lIChGVyB1cGxvYWQvZG93bmxvYWQsIFNlbnNvciBw
cm9ncmFtbWluZy4uKSB1c2luZyBQSU8gbW9kZSBpbnRyb2R1Y2VzIGRlbGF5IGIvdyBieXRlcyBv
ZiB0cmFuc2ZlciBhcyBpdCBkZXBlbmRzIG9uIENQVSBzY2hlZHVsaW5nIGFuZCBpbnRlcnJ1cHQg
cHJpb3JpdHkgd2hpY2ggaW1wYWN0cyBvbiBzZXJ2aW5nIGludGVycnVwdHMgYW5kIGZpbGxpbmcg
RklGTyBmb3IgdHJhbnNmZXIgdG8gaGFwcGVuLg0KDQpCZWxvdyBhcmUgdGhlIGNhc2VzIHdoZXJl
IHdlIHNlZSB0aGUgbmVlZCBmb3IgRE1BIG1vZGUgZm9yIEkyQyB0cmFuc2ZlcnMgKG1haW5seSBk
dXJpbmcgdGhlIHVzZSBjYXNlcyB3aGVyZSBDUFUgaXMgZnVsbHkgbG9hZGVkKSANCi0gU29tZSBk
ZXZpY2VzIG5lZWQgRlcgdXBkYXRlIG92ZXIgSTJDIGFuZCBETUEgbW9kZSBoZWxwcyBpbiBzdWNo
IGxhcmdlIHRyYW5zZmVycyBvbiBJMkMgcmVkdWNpbmcgQ1BVIGludGVydmVudGlvbiBtYWlubHkg
d2hlbiBDUFUgaXMgZnVsbHkgbG9hZGVkLg0KLSBTb21lIGRldmljZXMgaGF2ZSBpbnRlcm5hbCB0
aW1lb3V0IGZvciBubyBkYXRhIGFjdGl2aXR5IG9uIEkyQyBidXMgYWZ0ZXIgdGhlIHN0YXJ0IGNv
bW1hbmQgKHRpbWUgcmVzdHJpY3Rpb24gYi93IGRhdGEgdG8gZGF0YSB3aXRoaW4gc2luZ2xlIHRy
YW5zYWN0aW9uKSB0byBhdm9pZCBidXMgaGFuZyBhbmQgdGhleSBmb3JjZSB0byBzdG9wIHdoZW4g
dGltZW91dCBoYXBwZW5zLiB3aXRoIFBJTyBtb2RlIGluIHRob3NlIGNhc2VzLCBkZXBlbmRpbmcg
b24gQ1BVIGxvYWQsIHRoZXJlIGNvdWxkIGJlIG1vcmUgZGVsYXkgaW4gc2VydmluZyBpbnRlcnJ1
cHQgZm9yIGRhdGEgcmVxdWVzdHMgYW5kIHNlbmRpbmcgdGhlIGRhdGEgY2F1c2luZyB0aGUgZGV2
aWNlIHRvIHRyaWdnZXIgaXRzIHRpbWVvdXQgYW5kIHRyYW5zYWN0aW9uIHN0b3BzLg0KLSBIZWxw
cyBmb3IgcmVhZGluZyBkYXRhIGZyb20gSTJDIHNlbnNvcnMgd2l0aCBiZXR0ZXIgQlcuDQoNCg0K
