Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35DAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4692C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AzneoU19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4692C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeIXUxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:30644
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388437AbeIXUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAQcGp5cS51UzYO+C8bdqOu4zkxwnv4MqOPid/6p/kg=;
 b=AzneoU19mDMGlBjDbi6fCPfChXs2ZblqH01XQKsnKVmC4k5754PlnF1oA2JEs5oyL9BdrduLPBVz3ETD8JeLdV1apYOGZv0TDgqaiZ5qClVrjuaZZBNKuu7ujOxA3TPouoeuRwZ+nmIHvmBHdrSCX4vBVaXROf7qstQXGDcXmfw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/23] mac80211: Run TXQ teardown code before
 de-registering interfaces
Thread-Topic: [PATCH AUTOSEL 4.9 01/23] mac80211: Run TXQ teardown code before
 de-registering interfaces
Thread-Index: AQHUVBXIXLqjaWcg5UqS8av1SkBo/A==
Date:   Mon, 24 Sep 2018 14:49:23 +0000
Message-ID: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:tfJ2UI92qz6w9N+mScAdb0WDooESGUS6aYjqMJwg29SHgrGBWvDO0m2eWT1WfrTgVy//VDwkbm6rP5kyLENiEmWu74s2g2SdN9kUlEuzmCn/0RjHaVEHCltwYdazUdCFVaQRqKtciP3XWxCYSSFerg2PRQNios0Qtxu64xviJth7CAhkaZLMmUulI1LS+X86z+/GuL6FTk8V5ZGvSEE90e+LcDgKmY0u/2oYflIs8DgYzpmGvBiY4TdEUULMEqjaT68jqXvWY8L46wjDhHey9mbC6XXt6Xr4aGrmewOeSnHLAT4pn5C6dwbM3aRvszmxztYR6bqpLrGELxyGx7pl39rVuOeVjPVLU6XGaxkx1fr6kAKckJ2eVp3tUp6glKDBdAzZHtI+dD/QIMS981YpSmSZsKqnq9Jjc2eO37SNavMtrRf57KYEdW1BEWJyluB/37Z20jT7fejHulEedUfJdQ==;5:dX7+5R+mjh3aIWvcyU4jtI4n4M/yfT5I86tPTStjbjP9iGmpDC13I8bm4CFbLrAggzm6OZHqr0edtDDJdP87iqHS/jEsCPl8ADJHHYU2083OR0Xjx8qQxGBGfn9nQ1aj3lPTbr/S+0+T/T8wLybi8hM5XZXcRaB199oz5OsT+B4=;7:CR9UWTcjtFrkllMrpoL43XM55YGC2zvGc6QHJQpvP1tLfGITZkarfhRCvLD+7UX1rBSPIVHvLZ9yqirMafaxSDn4itvSUPD7EVSNKbhLmXMX0CzSJlKn5HsV9zFGo6Bq8AEH4NWkTqe7EGH4/RwwaTQVts71U5ufTD4/TZ77F6iUDiX7Cedvz50tR/X85qt/+GkDZ6fLS6n6Lp683edttgzkngvqEqPKzOWPnc+8jct+Ri+zVRiIup7dswgjocsK
x-ms-office365-filtering-correlation-id: 935cc147-1ce5-4495-f799-08d6222d0ef7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181CF2D9B8E6C52831E58E6FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yZvu65belKUKKgEdY4MBBASjkYPN62G0DLaeC9g+C7j0pbUj/+83EWsMOy6z9n/ODZV+Z0+hSUgoAcsf0/JoX6LWStskBpM3njLqwn/DtFLFYGThZIMd9itwHTmcxiyjkEO4lqbNgWzMumC4gBbmuuVqUtX6mXKjG6vtYHGPQJKTAa5FCACe+drYMJpTJkHKYdGPiTaZLMSV+Bhp/zFb6so+IxAs+J9cMjsjKJCt6XbSCrxWv/s+pDP/znWn4Z5CDzj3GzTPrm5itHEUkOstpXuupjoq16lQvr7zPTW0+GBFNUA0M7tPQuP8PcBSx2AStp5zyb73fpkjsS0OCiurT0c0wb2Djckz03wiRCRCDl0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D585A7436A18C48B5AFAD6EA4D54887@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935cc147-1ce5-4495-f799-08d6222d0ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:23.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2UuZGs+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDc3Y2ZhZjUyZWNhNWNhYzMwZWQwMjk1MDdlMGNhYjA2NWY4ODg5OTUgXQ0KDQpU
aGUgVFhRIHRlYXJkb3duIGNvZGUgY2FuIHJlZmVyZW5jZSB0aGUgdmlmIGRhdGEgc3RydWN0dXJl
cyB0aGF0IGFyZQ0Kc3RvcmVkIGluIHRoZSBuZXRkZXYgcHJpdmF0ZSBtZW1vcnkgYXJlYSBpZiB0
aGVyZSBhcmUgc3RpbGwgcGFja2V0cyBvbg0KdGhlIHF1ZXVlIHdoZW4gaXQgaXMgYmVpbmcgZnJl
ZWQuIFNpbmNlIHRoZSBUWFEgdGVhcmRvd24gY29kZSBpcyBydW4NCmFmdGVyIHRoZSBuZXRkZXZz
IGFyZSBmcmVlZCwgdGhpcyBjYW4gbGVhZCB0byBhIHVzZS1hZnRlci1mcmVlLiBGaXggdGhpcw0K
YnkgbW92aW5nIHRoZSBUWFEgdGVhcmRvd24gY29kZSB0byBlYXJsaWVyIGluIGllZWU4MDIxMV91
bnJlZ2lzdGVyX2h3KCkuDQoNClJlcG9ydGVkLWJ5OiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRl
bGF0ZWNoLmNvbT4NClRlc3RlZC1ieTogQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAdG9rZS5k
az4NClNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29t
Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQu
Y29tPg0KLS0tDQogbmV0L21hYzgwMjExL21haW4uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIx
MS9tYWluLmMgYi9uZXQvbWFjODAyMTEvbWFpbi5jDQppbmRleCAyYmI2ODk5ODU0ZDQuLjYzODlj
ZTg2ODY2OCAxMDA2NDQNCi0tLSBhL25ldC9tYWM4MDIxMS9tYWluLmMNCisrKyBiL25ldC9tYWM4
MDIxMS9tYWluLmMNCkBAIC0xMTY0LDYgKzExNjQsNyBAQCB2b2lkIGllZWU4MDIxMV91bnJlZ2lz
dGVyX2h3KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KICNpZiBJU19FTkFCTEVEKENPTkZJR19J
UFY2KQ0KIAl1bnJlZ2lzdGVyX2luZXQ2YWRkcl9ub3RpZmllcigmbG9jYWwtPmlmYTZfbm90aWZp
ZXIpOw0KICNlbmRpZg0KKwlpZWVlODAyMTFfdHhxX3RlYXJkb3duX2Zsb3dzKGxvY2FsKTsNCiAN
CiAJcnRubF9sb2NrKCk7DQogDQpAQCAtMTE5MSw3ICsxMTkyLDYgQEAgdm9pZCBpZWVlODAyMTFf
dW5yZWdpc3Rlcl9odyhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCiAJc2tiX3F1ZXVlX3B1cmdl
KCZsb2NhbC0+c2tiX3F1ZXVlKTsNCiAJc2tiX3F1ZXVlX3B1cmdlKCZsb2NhbC0+c2tiX3F1ZXVl
X3VucmVsaWFibGUpOw0KIAlza2JfcXVldWVfcHVyZ2UoJmxvY2FsLT5za2JfcXVldWVfdGRsc19j
aHN3KTsNCi0JaWVlZTgwMjExX3R4cV90ZWFyZG93bl9mbG93cyhsb2NhbCk7DQogDQogCWRlc3Ry
b3lfd29ya3F1ZXVlKGxvY2FsLT53b3JrcXVldWUpOw0KIAl3aXBoeV91bnJlZ2lzdGVyKGxvY2Fs
LT5ody53aXBoeSk7DQotLSANCjIuMTcuMQ0K
