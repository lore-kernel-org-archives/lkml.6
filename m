Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CDBECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E577208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ning4PGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E577208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeIQIyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:54:06 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:15894
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727564AbeIQI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2yAQ3k2Jo9cxdXOfsBabxO0aqTpFYFvfKqZJi9SMoA=;
 b=ning4PGHEuV4zAspsnd7Skg9FlxUOo5FT3T9KXMzV85VKs7KDnMNdSlwQFpUukG63u+pSWl4NJl2MyhtuapiJpUMkoWIyT0WNWx//RX8Pq/dcZABAgw2axCG4aDPlNcYoeqekVQ6HLrpSHTTGOmGetAWbtLznZEaQ4dTlUJAils=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 111/136] audit: Fix extended comparison of
 GID/EGID
Thread-Topic: [PATCH AUTOSEL 4.18 111/136] audit: Fix extended comparison of
 GID/EGID
Thread-Index: AQHUTjK2dLm4U08CCUi0jlnpjIW4OA==
Date:   Mon, 17 Sep 2018 03:01:22 +0000
Message-ID: <20180917030006.245495-111-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:mKqCDvAWeDcMxIIo8bJyvWAu2armPU9RxX60fMR1K9dv5p6V1eMdjEUC17vHdro80ncS0GINFRkAfY4+JeM7rEA+4l68iQ7vfB6nTkBFsY+yfpT2g7r7sfz3sA2U3DxTife7Q5yVVJOpIBEDWbQyp6dOinp8V47FD7MeeBO1OvDMXqPJNtRxxTHd/PycVEgoxzWEGL/RXAOkHUGOq8MdkRpOAdWVoPdduiKjUzZKijFE5KIFU+3xDj2xPf9dnQzS3eUSuhLhw/1zZkQiemHwckHEODckB7+wNCwCwZEwO3ahJopbBv+vpEBkGotlL2UzRsp4KfvU7Kf/iF0fopFXmzxAgs7kI9YZqvkEfM/nEUnk+SFeO4kLP9RPyyeSmsv6EXGfMkQNsCUk3dycXv0x1oX+K4tDy5qVBXdiScEFEaHrNxVc4jl73GryBjZ5ngmUuPeLIkkNGDPYXelvQMGG2A==;5:KyMI4hGfJ6phn9egWTB86VRuNC1Oy4YzeWrn5GuIewaecAY7knCvEGAtWOHMxkXksFpcrfbNeSjNatWQaaFozXcO1NvGNIUVRPYTwCSo/UuV7yWxS8xQHm8CnmoBIoJTExrq4sg+6O6JyEZDhrRTAIe4ZNLebZxt/TmqQRQeeD4=;7:D3eZ6t03sR2ipH8asDjjBp/BPVsmzMu0VfCv+4rliSb+3R+czpcsTHvWy+Nun3kV4MI9/Swc4k2NeRGhCxRtLOf3X9dFRCUGmB9q0Khu0nS6KZ5lwgjVbRmFoJTVBhLQM5gVz4dCiHugpRCeF5TB6ccuPp68/30iQOuMi0/9a0NNOTezg922MnATe52oVt66YsU9Lzo4L5jdM14BTgjZDaTdFbimokFqCw4lCwRlnvl7KduPmZPcwwUNhxnYzeHQ
x-ms-office365-filtering-correlation-id: 0732582b-8f20-4167-656f-08d61c4a0ab2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168F18860CA3E4ED5A02581FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(966005)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6306002)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6UzCGvbCvKns5A/6H7LLKo5Q9k3iLJYm8vWlumEWGbvQlQKfVIVyIJl+eFk/8iKH3B/yQtBp2cIqHX0BoYyAH8vIpL31bQzF9Rm0TbElXnr/jx5rUolpfV/Q+od5De2kti9w+D+A/MY7gO88+Yallw+jTSdKzbTie8YeFoKxfctyMPnG5y5eddzm88m+8LfhUj4gNPCBMJUX0+9SZcWKz+dFLSaxM3MkMp9g90L4psL6qOOpVIPJ/ajlLgFgJppSkoxu12u85xhc3BYCUY4wwR650fjptGfrod+hqdPgpomT49kz35QYR5BhV+2oKrVlN0bJPo5sSabmn1C7kx/Hx/P5STs7jPVLBBI/SJtFE+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <35582CB9A731B04FB2BC02E3C7BC7912@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0732582b-8f20-4167-656f-08d61c4a0ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:22.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT25kcmVqIE1vc27DocSNZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+DQoNClsgVXBzdHJl
YW0gY29tbWl0IGFmODVkMTc3MmUzMWZlZDM0MTY1YTFiM2RlY2VmMzQwY2Y0MDgwYzAgXQ0KDQpU
aGUgYXVkaXRfZmlsdGVyX3J1bGVzKCkgZnVuY3Rpb24gaW4gYXVkaXRzYy5jIHVzZWQgdGhlIGlu
X1tlXWdyb3VwX3AoKQ0KZnVuY3Rpb25zIHRvIGNoZWNrIEdJRC9FR0lEIG1hdGNoLCBidXQgdGhl
c2UgZnVuY3Rpb25zIHVzZSB0aGUgY3VycmVudA0KdGFzaydzIGNyZWRlbnRpYWxzLCB3aGlsZSB0
aGUgY29tcGFyaXNvbiBzaG91bGQgdXNlIHRoZSBjcmVkZW50aWFscyBvZg0KdGhlIHRhc2sgZ2l2
ZW4gdG8gYXVkaXRfZmlsdGVyX3J1bGVzKCkgYXMgYSBwYXJhbWV0ZXIgKHRzaykuDQoNCk5vdGUg
dGhhdCB3ZSBjYW4gdXNlIGdyb3VwX3NlYXJjaChjcmVkLT5ncm91cF9pbmZvLCAuLi4pIGFzIGEN
CnJlcGxhY2VtZW50IGZvciBib3RoIGluX2dyb3VwX3AgYW5kIGluX2Vncm91cF9wIGFzIHRoZXNl
IGZ1bmN0aW9ucyBvbmx5DQpjb21wYXJlIHRoZSBwYXJhbWV0ZXIgdG8gY3JlZC0+ZnNnaWQvZWdp
ZCBhbmQgdGhlbiBjYWxsIGdyb3VwX3NlYXJjaC4NCg0KSW4gZmFjdCwgdGhlIHVzYWdlIG9mIGlu
X2dyb3VwX3Agd2FzIGV2ZW4gbW9yZSBpbmNvcnJlY3Q6IGl0IGNvbXBhcmVzIHRvDQpjcmVkLT5m
c2dpZCAod2hpY2ggaXMgdXN1YWxseSBlcXVhbCB0byBjcmVkLT5lZ2lkKSBhbmQgbm90IGNyZWQt
PmdpZC4NCg0KR2l0SHViIGlzc3VlOg0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWF1ZGl0L2F1
ZGl0LWtlcm5lbC9pc3N1ZXMvODINCg0KRml4ZXM6IDM3ZWViZTM5Yzk3MyAoImF1ZGl0OiBpbXBy
b3ZlIEdJRC9FR0lEIGNvbXBhcmF0aW9uIGxvZ2ljIikNClNpZ25lZC1vZmYtYnk6IE9uZHJlaiBN
b3NuYWNlayA8b21vc25hY2VAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFBhdWwgTW9vcmUg
PHBhdWxAcGF1bC1tb29yZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBrZXJuZWwvYXVkaXRzYy5jIHwgOCArKysr
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9rZXJuZWwvYXVkaXRzYy5jIGIva2VybmVsL2F1ZGl0c2MuYw0KaW5kZXgg
ODBkNjcyYTExMDg4Li4yNTU5M2JmY2ZmOWYgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYXVkaXRzYy5j
DQorKysgYi9rZXJuZWwvYXVkaXRzYy5jDQpAQCAtNDk0LDIwICs0OTQsMjAgQEAgc3RhdGljIGlu
dCBhdWRpdF9maWx0ZXJfcnVsZXMoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssDQogCQkJcmVzdWx0
ID0gYXVkaXRfZ2lkX2NvbXBhcmF0b3IoY3JlZC0+Z2lkLCBmLT5vcCwgZi0+Z2lkKTsNCiAJCQlp
ZiAoZi0+b3AgPT0gQXVkaXRfZXF1YWwpIHsNCiAJCQkJaWYgKCFyZXN1bHQpDQotCQkJCQlyZXN1
bHQgPSBpbl9ncm91cF9wKGYtPmdpZCk7DQorCQkJCQlyZXN1bHQgPSBncm91cHNfc2VhcmNoKGNy
ZWQtPmdyb3VwX2luZm8sIGYtPmdpZCk7DQogCQkJfSBlbHNlIGlmIChmLT5vcCA9PSBBdWRpdF9u
b3RfZXF1YWwpIHsNCiAJCQkJaWYgKHJlc3VsdCkNCi0JCQkJCXJlc3VsdCA9ICFpbl9ncm91cF9w
KGYtPmdpZCk7DQorCQkJCQlyZXN1bHQgPSAhZ3JvdXBzX3NlYXJjaChjcmVkLT5ncm91cF9pbmZv
LCBmLT5naWQpOw0KIAkJCX0NCiAJCQlicmVhazsNCiAJCWNhc2UgQVVESVRfRUdJRDoNCiAJCQly
ZXN1bHQgPSBhdWRpdF9naWRfY29tcGFyYXRvcihjcmVkLT5lZ2lkLCBmLT5vcCwgZi0+Z2lkKTsN
CiAJCQlpZiAoZi0+b3AgPT0gQXVkaXRfZXF1YWwpIHsNCiAJCQkJaWYgKCFyZXN1bHQpDQotCQkJ
CQlyZXN1bHQgPSBpbl9lZ3JvdXBfcChmLT5naWQpOw0KKwkJCQkJcmVzdWx0ID0gZ3JvdXBzX3Nl
YXJjaChjcmVkLT5ncm91cF9pbmZvLCBmLT5naWQpOw0KIAkJCX0gZWxzZSBpZiAoZi0+b3AgPT0g
QXVkaXRfbm90X2VxdWFsKSB7DQogCQkJCWlmIChyZXN1bHQpDQotCQkJCQlyZXN1bHQgPSAhaW5f
ZWdyb3VwX3AoZi0+Z2lkKTsNCisJCQkJCXJlc3VsdCA9ICFncm91cHNfc2VhcmNoKGNyZWQtPmdy
b3VwX2luZm8sIGYtPmdpZCk7DQogCQkJfQ0KIAkJCWJyZWFrOw0KIAkJY2FzZSBBVURJVF9TR0lE
Og0KLS0gDQoyLjE3LjENCg==
