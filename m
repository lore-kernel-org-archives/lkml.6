Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9828C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7853120857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nmnDGTvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7853120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeIGFOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:15 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbeIGFOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErhOCor3hzm94uM81gqhWrumPTuqEQbv62tUH4dLWHc=;
 b=nmnDGTvf2TgP6OSKZHrpj+Tae5F3sbwh+ZkDv66HamZ/nRwoO51eRa+MEvZ9sXKX8L7FEsVed/aNJ+ZHHkE9uNFDAbApKyvCDDAsqeUwTKc4JUCNTnLQDjRt0w9MaPvRzzV/fpNq1zPq5axkloX9B5YALSVDMIYU0RG4BATXNF4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/88] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Topic: [PATCH AUTOSEL 4.18 22/88] kbuild: add .DELETE_ON_ERROR special
 target
Thread-Index: AQHURkLEaoqf5qU2/06kRAIZt9+gFQ==
Date:   Fri, 7 Sep 2018 00:36:07 +0000
Message-ID: <20180907003547.57567-22-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:gpROHgkoBGKjab/yGTKmrOMz1PgysvDAwPA22SJbasZF7fK8pZhEMF114B333fVTCLclYTePr56OdSNit3mGTs5SAA2uKBJB8tnumJ4VfuISZK6vgaMRsMvBZdQrUW9vAjazn9FNl3U4D8shjQRl5uHiHncdNpMiH/9fYvI04vHKZg8CzQ7mMi9oemqATavp9LaZONx2D6aWqZuMyh2oAlHgPiQXE8DS2ajAq2qbWa9cKIIHXTts6jf0kabBbsDBVp0tb13Rq1JHcTBRsZRan0iG5KCQrCrAznhLb7IDOoEK7sDhPmk4tqJlDkPbZ2sPEIxQEuE0fWMny1OueiQETmodsz9EIP0/75IM4rBSUC/LpdeyiG10UTwFUEO1OdHZ7BqJPlcfTRA6UQmuKZ+g8eDQDpnw3erNSaJpn+QFNeLRAj/CXyeD4VZvcslwUVyeGzL9oapBJh70S2oGyQpqYw==;5:gVodgDeHACX0N5PMOA9LmSaw33KszxqlyNC9Qxy0TI8ktoLX2IvMSTuAMnc3QtBUPIZ7t8+0d9ISkZgVdbRJ3Vj/WihBvVENTSaFZKqmIPlmkMd107Xu+Mj1ou/4flLDm05Coz/36ya1HiCidmLOZZQYiQXuu8JbFIU5baHgdbk=;7:P/rqAoi2Ww0LFEX0zZtAEOHnLiN3deWG48r8+Ec1sFrRUU6KO1a9Qu+12OOK4NOQaYJSC2t35GF8wUMKyTj0SHTpL24XGrwUBnp2XPfX3I9HYjIBPyekwnNLdRs06myosCOjVU2YaICqUcCk5nb2VtwFbMNaxWw3+PZ4qW/LMuZ5NX9zIXXNWQ92UPiGY4THimsEr3YxiYtaiDNPQ51hvOyTi61y+PJ65zra4VLrlRlsE+JcYl0sEdM34/usFer7
x-ms-office365-filtering-correlation-id: 2ddb56e5-ea73-4a30-fc13-08d61459e719
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB082407A87984A95DDE92DAB9FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BeUURZUSuOKUS2+S7rdFExkbeHK3p9NSmTUKygyVf+KQICyGgvqlltByiIJIYfr4Ddwa/SN7bz6V0CxK6coiBK9qeEpcRD01/xoeXap2sa/oTmtWM0qFNJEtWzV9dC2Q+uRA3RLiHYNZHWl3vgSyOoG9y23w5B6z3wtlhMpOmyh99Ot7tIyBMVKed2m83sUI/lLc0pibu8QtyZAzOjKGy4LCCgE/1+R9P97+uKbSIXcVKzEEK+8YkDxw5qTFtKLYi70C4ePZMboStjxWepiR8e8ryS3h65x6kmAtOvQhmFEg9+r/lfm6g0f650/je59HAgK0k0GGNM/uzRAajtirb+i98nCdBRt7kPuZcmFHV/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6956467F78DF504D9258B68FC199E95D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb56e5-ea73-4a30-fc13-08d61459e719
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:07.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCg0K
WyBVcHN0cmVhbSBjb21taXQgOWMyYWYxYzczNzdhOGE2ZWY4NmU1Y2FiZjgwOTc4ZjNkYmJiMjVj
MCBdDQoNCklmIE1ha2UgZ2V0cyBhIGZhdGFsIHNpZ25hbCB3aGlsZSBhIHNoZWxsIGlzIGV4ZWN1
dGluZywgaXQgbWF5IGRlbGV0ZQ0KdGhlIHRhcmdldCBmaWxlIHRoYXQgdGhlIHJlY2lwZSB3YXMg
c3VwcG9zZWQgdG8gdXBkYXRlLiAgVGhpcyBpcyBuZWVkZWQNCnRvIG1ha2Ugc3VyZSB0aGF0IGl0
IGlzIHJlbWFkZSBmcm9tIHNjcmF0Y2ggd2hlbiBNYWtlIGlzIG5leHQgcnVuOyBpZg0KTWFrZSBp
cyBpbnRlcnJ1cHRlZCBhZnRlciB0aGUgcmVjaXBlIGhhcyBiZWd1biB0byB3cml0ZSB0aGUgdGFy
Z2V0IGZpbGUsDQppdCByZXN1bHRzIGluIGFuIGluY29tcGxldGUgZmlsZSB3aG9zZSB0aW1lIHN0
YW1wIGlzIG5ld2VyIHRoYW4gdGhhdA0Kb2YgdGhlIHByZXJlcXVpc2l0ZXMgZmlsZXMuICBNYWtl
IGF1dG9tYXRpY2FsbHkgZGVsZXRlcyB0aGUgaW5jb21wbGV0ZQ0KZmlsZSBvbiBpbnRlcnJ1cHQg
dW5sZXNzIHRoZSB0YXJnZXQgaXMgbWFya2VkIC5QUkVDSU9VUy4NCg0KVGhlIHNpdHVhdGlvbiBp
cyBqdXN0IHRoZSBzYW1lIGFzIHdoZW4gdGhlIHNoZWxsIGZhaWxzIGZvciBzb21lIHJlYXNvbnMu
DQpVc3VhbGx5IHdoZW4gYSByZWNpcGUgbGluZSBmYWlscywgaWYgaXQgaGFzIGNoYW5nZWQgdGhl
IHRhcmdldCBmaWxlIGF0DQphbGwsIHRoZSBmaWxlIGlzIGNvcnJ1cHRlZCwgb3IgYXQgbGVhc3Qg
aXQgaXMgbm90IGNvbXBsZXRlbHkgdXBkYXRlZC4NCllldCB0aGUgZmlsZeKAmXMgdGltZSBzdGFt
cCBzYXlzIHRoYXQgaXQgaXMgbm93IHVwIHRvIGRhdGUsIHNvIHRoZSBuZXh0DQp0aW1lIE1ha2Ug
cnVucywgaXQgd2lsbCBub3QgdHJ5IHRvIHVwZGF0ZSB0aGF0IGZpbGUuDQoNCkhvd2V2ZXIsIE1h
a2UgZG9lcyBub3QgY2F0ZXIgdG8gZGVsZXRlIHRoZSBpbmNvbXBsZXRlIHRhcmdldCBmaWxlIGlu
DQp0aGlzIGNhc2UuICBXZSBuZWVkIHRvIGFkZCAuREVMRVRFX09OX0VSUk9SIHNvbWV3aGVyZSBp
biB0aGUgTWFrZWZpbGUNCnRvIHJlcXVlc3QgaXQuDQoNCnNjcmlwdHMvS2J1aWxkLmluY2x1ZGUg
c2VlbXMgYSBzdWl0YWJsZSBwbGFjZSB0byBhZGQgaXQgYmVjYXVzZSBpdCBpcw0KaW5jbHVkZWQg
ZnJvbSBhbG1vc3QgYWxsIHN1Yi1tYWtlcy4NCg0KUGxlYXNlIG5vdGUgLkRFTEVURV9PTl9FUlJP
UiBpcyBub3QgZWZmZWN0aXZlIGZvciBwaG9ueSB0YXJnZXRzLg0KDQpUaGUgZXh0ZXJuYWwgbW9k
dWxlIGJ1aWxkaW5nIHNob3VsZCBuZXZlciBldmVyIHRvdWNoIHRoZSBrZXJuZWwgdHJlZS4NClRo
ZSBmb2xsb3dpbmcgcmVjaXBlIGZhaWxzIGlmIGluY2x1ZGUvZ2VuZXJhdGVkL2F1dG9jb25mLmgg
aXMgbWlzc2luZy4NCkhvd2V2ZXIsIGluY2x1ZGUvY29uZmlnL2F1dG8uY29uZiBpcyBub3QgZGVs
ZXRlZCBzaW5jZSBpdCBpcyBhIHBob255DQp0YXJnZXQuDQoNCiBQSE9OWSArPSBpbmNsdWRlL2Nv
bmZpZy9hdXRvLmNvbmYNCg0KIGluY2x1ZGUvY29uZmlnL2F1dG8uY29uZjoNCiAgICAgICAgICQo
USl0ZXN0IC1lIGluY2x1ZGUvZ2VuZXJhdGVkL2F1dG9jb25mLmggLWEgLWUgJEAgfHwgKCAgICAg
ICAgICBcDQogICAgICAgICBlY2hvID4mMjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgZWNobyA+JjIgIiAgRVJST1I6IEtl
cm5lbCBjb25maWd1cmF0aW9uIGlzIGludmFsaWQuIjsgICAgICAgICAgIFwNCiAgICAgICAgIGVj
aG8gPiYyICIgICAgICAgICBpbmNsdWRlL2dlbmVyYXRlZC9hdXRvY29uZi5oIG9yICRAIGFyZSBt
aXNzaW5nLiI7XA0KICAgICAgICAgZWNobyA+JjIgIiAgICAgICAgIFJ1biAnbWFrZSBvbGRjb25m
aWcgJiYgbWFrZSBwcmVwYXJlJyBvbiBrZXJuZWwgc3JjIHRvIGZpeCBpdC4iOyBcDQogICAgICAg
ICBlY2hvID4mMiA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KICAgICAgICAgL2Jpbi9mYWxzZSkNCg0KU2lnbmVkLW9mZi1ieTogTWFzYWhp
cm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NClNpZ25lZC1vZmYtYnk6
IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHNjcmlw
dHMvS2J1aWxkLmluY2x1ZGUgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUgYi9zY3JpcHRzL0tidWls
ZC5pbmNsdWRlDQppbmRleCA4NjMyMWYwNjQ2MWUuLmVkMzAzZjU1MmY5ZCAxMDA2NDQNCi0tLSBh
L3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCisrKyBiL3NjcmlwdHMvS2J1aWxkLmluY2x1ZGUNCkBA
IC00MDAsMyArNDAwLDYgQEAgZW5kaWYNCiBlbmRlZg0KICMNCiAjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQorDQorIyBkZWxldGUgcGFydGlhbGx5IHVwZGF0ZWQgKGkuZS4gY29ycnVwdGVkKSBmaWxl
cyBvbiBlcnJvcg0KKy5ERUxFVEVfT05fRVJST1I6DQotLSANCjIuMTcuMQ0K
