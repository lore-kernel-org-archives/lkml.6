Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3532147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hOr4ZDab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3532147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeIQIdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:05 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbeIQIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZzsGU3Qx3AoTsON/aB+JnZBsVBjSb1p9/WhfR2KA4w=;
 b=hOr4ZDab5WDwUskLyneDZJAYz3rrnDIjGRRz2LZkSh+FpiQOOD+hyEZU9QXgJnThjj7BcF5L+oVJdfhSU0U7x6Y+9t03yxWdRmRMlGU4s62cdKJciIqrc4fiLncby4FYo1GI++U6HfL2gpGyY6HEtvoJ0535jTXPv/MG5QzU9mg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 38/43] audit: Fix extended comparison of GID/EGID
Thread-Topic: [PATCH AUTOSEL 4.4 38/43] audit: Fix extended comparison of
 GID/EGID
Thread-Index: AQHUTjNAJeMLvEJbYUOmPgG0VHi6QQ==
Date:   Mon, 17 Sep 2018 03:05:12 +0000
Message-ID: <20180917030445.484-38-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:xbDMp96brYD197gJClL7OdNeHwa8G2MybbdRmVmMTiFAlhth8/RsHtEDMYzpoLSUiAuqe2Sic1iGk8yLNsGniqBMDt/Ni+SsWDlGxtNRnihVZjEvwQPCxlPWgUoT2dFcPVfbGzBB01wCFLYZmcgLQBQuPsaTqMevDC4orbdcrGBCvJgbgl1Olg8+SIJjVTFAjxLLXtSr8Yyyp8vtMEutL7XQ23YL5Of/8WTvvdxHU+R6Xb7Oulj7q+nrlCBN1jY8c6OdoCNTyUnvbQl1i6foci4nSb5oidHvTM05/0JzEPhI5/bFhsSVtkDexFWfEVJGMZRd4LKJdlLZdQXeN1TwBtbyorU6Do1SaNpV+IPWtfJqJQnxsDodeaIsIdDf6PgbDKG1cqR5I8Plp1r8zUUTt2sHpPP2d6Nr6bQByS11cBipvuidCCrOG30QuMwg7G1kVvDm7Z0QAuBEYyjQn9jTrg==;5:pjZgpsPauBaHPRMRJwp4YzqyGBalonXEu4G9+MsZu6vo2pmHU/obpK1RRrWbXqhHwQLVTxU4D7MQrBkbL/4krnrS/89Zr8tHRFvdozUucpXgclqGgJdU4hGW1GQ7yGF8GqLsvME72m9XkIROBoGHtU5Wdeqd+ODzUbf/9j9anvM=;7:ZSbHkYWqzl1Dbf38BFaByvl1i1HWr3NS5S/JpSFh7cpefmqNZMYIROsis10DwLZjRjKSnZb0Elazkfbw8KKdfcSk5rSzt8Zt/BvjRWu/AvICdUvbz85q2R4447vtcJver73wux9o1h30oKRYOMm+1+FXp1sjzCvsj2zdgxgQuZ0pMJ3a3tY7YB8K+K+ejUZWtduDyz8h/4rt5MIFRdRSwBlvgWen0+WAbbXYHc6OTQdPF5s3Uzm/hEesIvoD0ycI
x-ms-office365-filtering-correlation-id: 9da57bf2-7485-4f03-884c-08d61c4abddb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08397CEE894223DAD98164ECFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4Hp4c3Ld3ENCegmGgtqcfmLjwDFhJeTgl8CfYzJQWv7tsVC6oMfirqNfoaVca6MOqaOtXvQjRR4aMtxi/kvpqroIHrTpTBB8kyhD0nGmr5QDjjRzfZ80twO+nd5hSO93bbOIN1ddnkissMozqXRgolkbp6O0ejNwgiXwrZn7qko8VJvwImRM/t42SX3U8UdXf3UPWO5ZVykFow8CqKAGwspvKV5WBqpmDDsZbp32JXBw8A/1HW8V61XYPTNvib3+w7DLMIfbjE14jouPGk32FxXmImcyo75WVzLW+lTyNRM3lVNxAO/5n4Eknzn/0uVxM/51Vtg+xr6BMFu/KjVBRToL/wa6sv2hrvPcfKs0Qxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3063CAB80EBE8840845855289F9FD077@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da57bf2-7485-4f03-884c-08d61c4abddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:12.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
MGZlOGIzMzcyOTFhLi5kYTM0NDVhYTBkY2EgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYXVkaXRzYy5j
DQorKysgYi9rZXJuZWwvYXVkaXRzYy5jDQpAQCAtNDg5LDIwICs0ODksMjAgQEAgc3RhdGljIGlu
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
