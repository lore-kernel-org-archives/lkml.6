Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CA9C4161C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720D5214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WwRPN3VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720D5214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeIQIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:25 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730455AbeIQIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mznj0+jKoB5y3VBxBxXh133SDBQ/rsyXtLKcL27qu8=;
 b=WwRPN3VQiIZv2iFHiF6fWR1FHEaIn2KKbEl+2BKkiaxwYaWzkvzIc0gtbyMKQyonXzCg1dlTtOyYjS/2y4CPLsFjbegIvQ68udzzF1+kL+ScmZI6m3VAG3axtbA7ABLslJI4D5ZU7H44Y9VjbNPewXWAskG5uzx79lStaeigQFA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 75/87] audit: Fix extended comparison of GID/EGID
Thread-Topic: [PATCH AUTOSEL 4.14 75/87] audit: Fix extended comparison of
 GID/EGID
Thread-Index: AQHUTjL4tZGJx/fgREWRFUUUUXRY7A==
Date:   Mon, 17 Sep 2018 03:03:12 +0000
Message-ID: <20180917030220.245686-75-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:Gn/9oFfljnu6880VSQRMtxvNc7i8WLgfRrcXtxFVbmQZLSt8lzIDWalvCyodhA0X2vEM/pZB9cBAMZa7K2K1SiYose+MTj/zmKWubw0y3zVq3GZP9lW7Td9P+nNyt+5Qe1cGjs49rNoGCU8B5i/uXGmSR7Joz2rY4U1fgBDAifTyCbWNY8irTjoymAYjf46zJqp6iRHTGpFU52/wq0zhQFA+1gAdX56P6X/9UhnjFDBYgyL/92JzihqIS3Kico2s/M3jfbHG03yuq339IQG1uXBFhCWQizsHJsTRdXN6Ya27zOLY7DoeP11VO72Ahty5XBjAkySrPipZ5Op8s5RsilqAd6plTDbWkRzHxiP1KkC8c5qkIHfPavX5nvJlJ2dk3qP+2Jg+w7DZHnaOVSkS4w33gMmB5Y4WMVKVEdOXHKCYWOF0osltCLgu8nJetQbI/N12q7nqcAte0xzP4O0Pkg==;5:iCchvw5C1xzSgcdQHQI1u5mlrvT9LmQOSNd/eOf8AuOIQ6wr1E3eM224INEUPsu7t1RAc2aSqpw8ATXw87JL47T6d5LPS9lNzonSAfeSpC36Om49MW+0TEbIHe9LlURcklAwN4dBWXsiterwyzOvleVwRsHomIruaTCqgSpJGd8=;7:nwjjUKA44VJm8ffOEtQTz0XD7zWRT00wrYnkUw3cv+yE8yRWEzGk1TmXus6wf3Ky5zVDNoPkBbj05I5RrVaYLapwyeIE0+LTUT+cWEgfl2qgg2lQBMDnXvTkIKiwTMoquViXTxTxSvs3WHFpd1KikfkQ/1Emhk7cig+tBLYxkfLMfMOKRppDzTDPHf1WFWpf3d3AMOp203ky9CaRMBsS0MKVv835NUtQVDxrUtd972JS9urEkcXL4n+Ml+IW9Tf1
x-ms-office365-filtering-correlation-id: f032baab-87fe-42b6-ed98-08d61c4a5b4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133565D680996DC92F3E646FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2kvn7ZB0eAWcltrc9OpVQrwZDKfxd76uspIRD3wXIhYPwaKXmOa4Qx0K+SC9Z3MH6DFjVVaw7SUJ4dao37LCTccnCRRQ/rhYOFFh3s2EjA9lgcjZ2cX6XDXamrwOPSWUHV2epNwxZtN9WF0IaLCFu9K94V2p2DABIC5yFZgKwFsvaqvHWeDMle/slAWfJ992mWmvx5p+cb96Lu3J5/aK/JLBAg/HD0OPAC40YhSUANuA+97cmttW/f1VA5qaSfchG0OautTD/Zcp29ydDp6QV3a6Dpaee5RyHcrNkqNDmaASuPM5r2yW9MjORL4ywQ0NkJY/mxiv1WKj6dRzuZmqKOkcoXMfdpYNl7f66JEoVug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6E3228F51ACBE42B033789CAEF9309A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f032baab-87fe-42b6-ed98-08d61c4a5b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:12.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
NzZkNzg5ZDZjZWEwLi5iYjg2MTMyN2YzNjcgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYXVkaXRzYy5j
DQorKysgYi9rZXJuZWwvYXVkaXRzYy5jDQpAQCAtNDkwLDIwICs0OTAsMjAgQEAgc3RhdGljIGlu
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
