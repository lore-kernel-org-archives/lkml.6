Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B17C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064192086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FqEnW66N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064192086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbeKPGrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:47:51 -0500
Received: from mail-eopbgr790089.outbound.protection.outlook.com ([40.107.79.89]:12832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeKPGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7/84MbYv2VoQR0sYG4UN0d0Sr+V2CqBPqpGf+k/iqg=;
 b=FqEnW66NEPBpmVv1+yE0Jbr/O1lfEkQsJmY8nvSHzsAdg4Sm3yKsrbK+TQNEOc6mQr10ANkOVaMrXppPpwsMkJeg0SrVZ4f7ut/GpY/MjiL0FaDuwjiazvplPFP78hJIfq9CilzJcB1P42LwfEqjHtRz+AbGwnrJicFv4J9gSRQ=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 20:38:26 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::c839:4c0f:105b:b038]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::c839:4c0f:105b:b038%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 20:38:25 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
CC:     Joerg Roedel <jroedel@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix Kernel Oops triggered by kfdtest
Thread-Topic: [PATCH] drm/amdgpu: Fix Kernel Oops triggered by kfdtest
Thread-Index: AQHUfPH4TPnJKWrUp0Sj+jOooCjPlaVRS8jw
Date:   Thu, 15 Nov 2018 20:38:24 +0000
Message-ID: <DM5PR12MB17072EA7F58CA65AAABAB7EC92DC0@DM5PR12MB1707.namprd12.prod.outlook.com>
References: <20181115144612.30301-1-joro@8bytes.org>
In-Reply-To: <20181115144612.30301-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2552;20:xXg1Q3UBFv5hGY2IMJA+lt4S2YLyiUs/bOd2XYUw2PWwwdt3zoRpb6+nqje2zPJIV02+JssuXx3w0s+4casE8uXtwa+XBSV6QF7Xc1etwFlpVfVl0c4iydYCacKzBnrt9yJeMiIm6nl9TFdZNkUtEyJyt//ZSAiBq6l4cTCMlkdxJZgCsyQwV3QFiCJk9JX6TnFa5g8MfpFDnSzbvL3a5cQjvsy8Dhykz8ohXo7Gc/c6bDTQFLKHgomaaU6jhQHr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(13464003)(189003)(199004)(966005)(478600001)(3846002)(7696005)(54906003)(2900100001)(99286004)(6116002)(26005)(33656002)(72206003)(14454004)(110136005)(53546011)(66066001)(97736004)(4326008)(71190400001)(71200400001)(76176011)(6506007)(102836004)(25786009)(6246003)(316002)(53936002)(106356001)(6436002)(229853002)(6306002)(55016002)(9686003)(256004)(81166006)(14444005)(81156014)(8676002)(476003)(186003)(446003)(486006)(11346002)(6636002)(86362001)(575784001)(7736002)(68736007)(305945005)(2906002)(105586002)(5660300001)(8936002)(74316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2552;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 11ae4306-34da-481b-b21c-08d64b3a4a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2552;
x-ms-traffictypediagnostic: DM5PR12MB2552:
x-microsoft-antispam-prvs: <DM5PR12MB2552D589A2D2B4D0B4E19C0692DC0@DM5PR12MB2552.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2552;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2552;
x-forefront-prvs: 08572BD77F
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HhP6foG8Rx8XNQdd+oynZhL4SINMvX6ng0DFF1OkjGCqSHXDXzjwZrQfZN7AMDFinXrWP0rZULViuttp8cZcQRNbsVFkI69M5uop0izNeZpFBwwStLsK38IDNpeLXGKR1wrtwM4/kDURIW240IwfsLfMEgQi//zTvuVAo4AlT4AZxpV8n6YYosUcGIZLyKMSl0NK9xGM9BINvXg3Jy6t4qGdjxPGaPYfWQpn/bKM4GIhrwRDOOqE19/yI24An8zbp+5c0GlrFTN5XOBNmlx1wTCDP22L5mS50RlSu2pmffLdODdoHRKje3xA6eHn3opoZws1Q1A7cNUcDdCK3OgddhpZqVEqr4nQq2NR7p4Ar2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ae4306-34da-481b-b21c-08d64b3a4a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 20:38:24.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXBvbG9naWVzLiBXZSBhbHJlYWR5IGhhdmUgYSBmaXggZm9yIHRoaXMgb24gb3VyIGludGVybmFs
IGFtZC1rZmQtc3RhZ2luZyBicmFuY2gsIGJ1dCBpdCdzIG1pc3NpbmcgZnJvbSBhbWQtc3RhZ2lu
Zy1kcm0tbmV4dC4gSSdsbCBjaGVycnktcGljayBvdXIgZml4IHRvIGFtZC1zdGFnaW5nLWRybS1u
ZXh0IGFuZCBub21pbmF0ZSBpdCBmb3IgZHJtLWZpeGVzLg0KDQpSZWdhcmRzLA0KICBGZWxpeA0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEpvZXJnIFJvZWRlbA0KU2Vu
dDogVGh1cnNkYXksIE5vdmVtYmVyIDE1LCAyMDE4IDk6NDYgQU0NClRvOiBaaHUsIFJleCA8UmV4
LlpodUBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpIDxEYXZpZDEu
WmhvdUBhbWQuY29tPg0KQ2M6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPjsgZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogRml4IEtlcm5lbCBPb3BzIHRyaWdnZXJlZCBieSBrZmR0ZXN0DQoNCkZyb206IEpvZXJnIFJv
ZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KDQpSdW5uaW5nIGtmZHRlc3Qgb24gS2F2ZXJpIHRyaWdn
ZXJzIGEga2VybmVsIE5VTEwtcHRyIGRlcmVmZXJlbmNlOg0KDQoJQlVHOiB1bmFibGUgdG8gaGFu
ZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgMDAwMDAwMDAwMDAwMDAwMA0K
CVBHRCA0MmMwMTcwNjcgUDREIDQyYzAxNzA2NyBQVUQgNDBmMDcxMDY3IFBNRCAwDQoJT29wczog
MDAxMCBbIzFdIFNNUCBOT1BUSQ0KCUNQVTogMCBQSUQ6IDEzMTA3IENvbW06IGtmZHRlc3QgTm90
IHRhaW50ZWQgNC4yMC4wLXJjMisgIzExDQoJSGFyZHdhcmUgbmFtZTogR2lnYWJ5dGUgVGVjaG5v
bG9neSBDby4sIEx0ZC4gVG8gYmUgZmlsbGVkIGJ5IE8uRS5NLi9GMkE4OFhNLUhEMywgQklPUyBG
NiAwNS8yOC8yMDE0DQoJUklQOiAwMDEwOiAgICAgICAgICAobnVsbCkNCglDb2RlOiBCYWQgUklQ
IHZhbHVlLg0KCVJTUDogMDAxODpmZmZmYzkwMDAxYWRiYmYwIEVGTEFHUzogMDAwMTAyMDINCglS
QVg6IGZmZmZmZmZmYTA4MDYyNDAgUkJYOiBmZmZmODg4NDJhMGZiYzAwIFJDWDogMDAwMDAwMDAw
MDAwMDAwMg0KCVJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAwMDQgUkRJ
OiBmZmZmODg4NDI5NjkwMDAwDQoJUkJQOiBmZmZmYzkwMDAxYWRiYmY4IFIwODogMDAwMDAwMDAw
MDAwMjAwMCBSMDk6IGZmZmY4ODg0MmU1NDJlYzANCglSMTA6IDAwMDA3ZmVmZjc3OGYwMDggUjEx
OiAwMDAwN2ZlZmY3NzhmMDEwIFIxMjogMDAwMDAwMDAwMDAwMDAwMA0KCVIxMzogZmZmZjg4ODQw
ZjA2M2EyMCBSMTQ6IGZmZmY4ODg0MmEwZmJkMjAgUjE1OiAwMDAwMDAwMDBmNDNmZjYwDQoJRlM6
ICAwMDAwN2ZlZmY3NzY5NzQwKDAwMDApIEdTOmZmZmY4ODg0MmZhMDAwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KCUNTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMNCglDUjI6IGZmZmZmZmZmZmZmZmZmZDYgQ1IzOiAwMDAwMDAwNDBmMTIyMDAw
IENSNDogMDAwMDAwMDAwMDA0MDZmMA0KCUNhbGwgVHJhY2U6DQoJID8gYW1kZ3B1X2FtZGtmZF9z
ZXRfY29tcHV0ZV9pZGxlKzB4MjkvMHgzMCBbYW1kZ3B1XQ0KCSByZWdpc3Rlcl9wcm9jZXNzKzB4
MTQwLzB4MTUwIFthbWRncHVdDQoJIHBxbV9jcmVhdGVfcXVldWUrMHgzOTUvMHg1NjAgW2FtZGdw
dV0NCgkga2ZkX2lvY3RsX2NyZWF0ZV9xdWV1ZSsweDI4NS8weDY4MCBbYW1kZ3B1XQ0KCSBrZmRf
aW9jdGwrMHgyN2YvMHg0NTAgW2FtZGdwdV0NCgkgPyBrZmRfaW9jdGxfZGVzdHJveV9xdWV1ZSsw
eDgwLzB4ODAgW2FtZGdwdV0NCgkgZG9fdmZzX2lvY3RsKzB4OTYvMHg2YTANCgkgPyBfX2F1ZGl0
X3N5c2NhbGxfZW50cnkrMHhkZC8weDEzMA0KCSA/IGhhbmRsZV9tbV9mYXVsdCsweDExYi8weDI0
MA0KCSBrc3lzX2lvY3RsKzB4NjcvMHg5MA0KCSBfX3g2NF9zeXNfaW9jdGwrMHgxYS8weDIwDQoJ
IGRvX3N5c2NhbGxfNjQrMHg2MS8weDE5MA0KCSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0NC8weGE5DQoNClRoZSByZWFzb24gaXMgdGhhdCB0aGUgcHBfZnVuY3MtPnN3aXRjaF9w
b3dlcl9wcm9maWxlIGZ1bmN0aW9uIHBvaW50ZXIgaXMgbm90IHNldCBmb3IgYSBLYXZlcmkgQVNJ
QyBhbmQgdGh1cyB0aGUga2VybmVsIGNhbGxzIGEgTlVMTCBwb2ludGVyLg0KDQpBZGQgYSBjaGVj
ayBiZWZvcmUgY2FsbGluZyB0aGUgZnVuY3Rpb24gdG8gYXZvaWQgdGhhdC4NCg0KU2lnbmVkLW9m
Zi1ieTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHBtLmggfCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcG0uaA0KaW5kZXggZjk3MmNkMTU2Nzk1Li4wZWNlZGQzMGYyYWEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHBtLmgNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uaA0KQEAgLTMzNyw4ICszMzcsOSBAQCBl
bnVtIGFtZGdwdV9wY2llX2dlbiB7DQogCQkJKGFkZXYpLT5wb3dlcnBsYXkucHBfaGFuZGxlLCBy
ZXF1ZXN0KSkNCiANCiAjZGVmaW5lIGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoYWRl
diwgdHlwZSwgZW4pIFwNCi0JCSgoYWRldiktPnBvd2VycGxheS5wcF9mdW5jcy0+c3dpdGNoX3Bv
d2VyX3Byb2ZpbGUoXA0KLQkJCShhZGV2KS0+cG93ZXJwbGF5LnBwX2hhbmRsZSwgdHlwZSwgZW4p
KQ0KKwkJaWYgKChhZGV2KS0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5zd2l0Y2hfcG93ZXJfcHJvZmls
ZSAhPSBOVUxMKSBcDQorCQkJKChhZGV2KS0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5zd2l0Y2hfcG93
ZXJfcHJvZmlsZShcDQorCQkJCShhZGV2KS0+cG93ZXJwbGF5LnBwX2hhbmRsZSwgdHlwZSwgZW4p
KQ0KIA0KICNkZWZpbmUgYW1kZ3B1X2RwbV9zZXRfY2xvY2tnYXRpbmdfYnlfc211KGFkZXYsIG1z
Z19pZCkgXA0KIAkJKChhZGV2KS0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5zZXRfY2xvY2tnYXRpbmdf
Ynlfc211KFwNCi0tDQoyLjEzLjcNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4DQo=
