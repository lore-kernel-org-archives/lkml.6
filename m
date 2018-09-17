Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF6ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C5E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dteOj5TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C5E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeIQIb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:58 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:42432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731060AbeIQIb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k625KlHQ6yq1uOLBjjezfgH+tfIQzr26yhN23aVZZ48=;
 b=dteOj5TNinYpNKybp+aFN1r4Af2CBCXEQE8NGG9KEwAtfwLw5oYARzBEU5/mPJ+B0VPcjUfPk6ktfqrr5TASxVOClUcqbNYcARP6bRO5GhxDo+2h3N3CvtBxzVa7y11n8qHSEJmK85JU37zAd6NC3XuAR6d8X03DN9ACHgQm4Qw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 49/57] audit: Fix extended comparison of GID/EGID
Thread-Topic: [PATCH AUTOSEL 4.9 49/57] audit: Fix extended comparison of
 GID/EGID
Thread-Index: AQHUTjMc4aCYvLQRQ0iosw1EJXCwPQ==
Date:   Mon, 17 Sep 2018 03:04:13 +0000
Message-ID: <20180917030340.378-49-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:HoFilOCsLqUZojm+xi4qtvKUR1MBia/xn0JmmLPqTOYrkZq9qrtvLllVToSFpg4JHBAu929oMEHXvy9TM59izdcTiAmuB64aymSssSsbhld6/d7aCoUwBNJCEEf/2fUJbkeb5CQaegUm/gfIKv8MRynAErMUo3Ja9PSGJNRpsllGboGIrbhkGFCnb4uYQB1sO7O8cIiFCNeaq/QhGAClwa1pD6zuH702h46xtF5r2Kc1XFoj3hgN2FhYqVwErogzgGRti54uZzasI4CiL/i+hwyjo1AG7OSh+BfQlBE65HdMjLHU4RwzeS2iZuhHXW1pFNocBnUo0T7fcW0C6bzpHSNvVh03IN1DFjc5zPb1VJyM6xXV8JFItl2AS2I6YqPa5NJasnpWLmSW+tuaLaf3+zjLSP+616dMjgQOrSWi6BJxn7eZPKCUMKKR07cRGkx27NzjDaRnNn7Oepj/927pjQ==;5:QHWw11oN3gDS8l9uT68fif2GOvne08COppo45HJIG6r0Yu0IuCYHLdgRYRTyyG/edgv9OsZj7epPCWWZxAjZrO2lq3MwYdd0gTaBCfVrajEAtSG4fuZGJIYNCL684NyhDfDYYy5xZ65ap5iBY4hNgVnq5aGLvEGgkRRcZxHC95A=;7:2M7XhZXwzhY4NgU8HE1rhXCivj6O0OHYJElDZcbKaQYuLZb8V07wQk440dJtAYeRVqHF3eKlR/XFJoh3hP0HGf4i3X9t7kdYnI9xNYKg2gvZOENkU2pFqafEd1TYk069W7OmlcpUPl6j/Zw16QcnpH8tpYgI3+wCR8n6ny/p0Mtb2F4qFHKEZqKr8Bo46GfuO2UQwtM3Goerr8MpV5n3MEnr0F0PCnowyFsisxx+0zbF2tXODhnnFUgxO8Dc+PLo
x-ms-office365-filtering-correlation-id: d349d178-6b0c-4656-db99-08d61c4a8d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742DEEDC0CF62027EE1EFDFFB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(6306002)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(966005)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7lPdE2tfUuC6RyCf7B7ytOBvZG4M3T6+Zj1d3iIIvO1iyYMkHnJYWP+XQW1ym+b1lfP+4DHnSWDc4Bn6fli65scYyIXPe5Jnd7bdTAGI1mr8srYIhnW7yLN7iEsqf2qZBQ2MNw7vxkueOqs1J/Soe+LNa8D4xzfcREI1PSiqNU2goRPB5s4ZZMCGvQ2AAkqcRVNWglGXglC6PWqfDTIjPcqh8ZCn87F59suiUnWmNWHoJjS75wEplr1wJcj98804ivBiYRo/4wEEgm/1CNtg+8Z0KYVD18K53eCnwYAhGpL42krGDeLfqNOdFj13sWn+UfXsi2P8dy+1nh7LwCSqptQXSq10U+YaVtgM7OguEBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C059B8179B9D24B8DC499A8539D7AAC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d349d178-6b0c-4656-db99-08d61c4a8d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:13.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
YzJhYWY1Mzk3MjhmLi43NzQzNGMyZDQyZTMgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYXVkaXRzYy5j
DQorKysgYi9rZXJuZWwvYXVkaXRzYy5jDQpAQCAtNDg4LDIwICs0ODgsMjAgQEAgc3RhdGljIGlu
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
