Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D42EC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9A20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jetldfq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF9A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeJAHPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:04 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729608AbeJAHPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jLgRmJL77mHHhk80p3tf7+/FVSnQOOV/HjXnnKkgsc=;
 b=Jetldfq+bugm8fAA3sW+ec+OSTGY6ykc5i/CTrZ60AELmxI6pPpuAhvzA10H8LnDIOkBYJh/dOifFyVojGE2Jxot10o8fimXkf8tW0LdO4IKzJCjmKAaeN5eV4v6sOD8gx+nuBVtPvcoh0X/cQ+S4Er8yb0A/mOBIHZTTsLRAZU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/37] fs/cifs: suppress a string overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 21/37] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR8okvfzSNCz5k+Zu4JvNfhUNA==
Date:   Mon, 1 Oct 2018 00:39:06 +0000
Message-ID: <20181001003850.147107-21-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:3YRLSO8ydCF82TgFUGVXj2tag46xlPRRF09TIFifONlFcDsDsEH4ilKDQYoOsnYLskwVTzyAILs11e/bO0x+EswyLVrJ059G7AJAp/MM/GDowovtF7Cu81kEJTicbReKKQGX/L7pBt/jcLI0sS46z1GStzZUF+a25xpfg6kOmSB2jtcM+DJlus6bgPhk67EQex6dufTW/QrYpSY5as4dthXZE5II7hkZ1OsZCHM3EZb4XunfAnuN+pc4PCtpLLkKVCcO4yx1BqYWQsUxdH6SKUTl3MsoBg7TJyURGCSJ/QGRCOUT1DLvVWT3A8BJ152Pa+lbMwkHLy2iDL2HhAOuEq7FdhQd+g615LRmyIOE3H/XAUwJ1TBj232zSr2lrpDJVg5dkn8oRyEpzXezyZ9KwyybIe7tUS9aMpSOkvl535UXMZJQJjfc/xSEZzAG2Rp4B01/svSEJabUJl5ozhD3vg==;5:WS4sA7IdQkzM2/HtYA9ofPGju3qA0d7CoUJWnjhjU2ct+mwhq4pEsFbTQ849tPo54CSN4upAO9oapkRTRUopAW+bB1qSevpZK3f0Wkd+sabikBlsrc1lnvmtDCzHIfAuMypqCg7PYILIe/40fsRoIOsNLkx9x6JMcK7TKNv18b8=;7:4GTpS+0iDaJgyyb4ZV2syNeHxQTKpHAXYq33GygOapSJY6wTpA0cnkogeaIxQZ20xKBPgzH4cPHh2fhxkd4tqFGkAhmqCvp7HkKI2HUarDrtsC8g8TyxZr3Uudvo7p8H10A3ektljV58ydtpeH3yYcnoi8t1PybiPOKe1YX81MYIcsfgR9/C7a9+4eJBQ24HgomIfoyxpKnyTk4njkkMlwO/tWUWaWuhOduVCsz87ptfKv7aEBwavkYre1MTPLbW
x-ms-office365-filtering-correlation-id: a0d07031-fa0d-4312-d19e-08d627366260
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854D90A85EE887B37BD82A5FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +gs8CFmL3up8TNV2yJU1YcnStuQH/jMYlYp4OiNmlL0ftDkv+Hq+zF786dLjak2gCtBjMhRwvktBZeyZOYKXFIWkud5n+3fuWj9wY8EpcEkKeTG8SkafWhGLfK5b1qBxI3gnaI0ReY1qB/VRChNbCURAiakBPZXc+BnR1g7p3zfv/sksiMMmoGILk9cfcmmdf+Bf3SZo1YJeTvvBo5fP9guBm+206TStnu10Ah++c1t6M42unVuhV/2CtyWtggLQzTLQ2Hb6q0JG9dqHh9+6n4BlGXe4spcQL7G6kaxbXmQP1SXF5s5uU1008NNS1WjtwDNiMSoECX9Rihzo/6C3NR2jo139nJWJQSt9dQH90jE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FCDBFD2CD43AC418D929D2DB31A0C56@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d07031-fa0d-4312-d19e-08d627366260
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:06.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQoNClsgVXBzdHJl
YW0gY29tbWl0IGJjZmI4NGE5OTZmNmZhOTBiNWU2ZTI5NTRiMmFjY2I3YTQ3MTEwOTcgXQ0KDQpB
IHBvd2VycGMgYnVpbGQgb2YgY2lmcyB3aXRoIGdjYyB2OC4yLjAgcHJvZHVjZXMgdGhpcyB3YXJu
aW5nOg0KDQpmcy9jaWZzL2NpZnNzbWIuYzogSW4gZnVuY3Rpb24g4oCYQ0lGU1NNQk5lZ290aWF0
ZeKAmToNCmZzL2NpZnMvY2lmc3NtYi5jOjYwNTozOiB3YXJuaW5nOiDigJhzdHJuY3B54oCZIHdy
aXRpbmcgMTYgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDEgb3ZlcmZsb3dzIHRoZSBkZXN0
aW5hdGlvbiBbLVdzdHJpbmdvcC1vdmVyZmxvdz1dDQogICBzdHJuY3B5KHBTTUItPkRpYWxlY3Rz
QXJyYXkrY291bnQsIHByb3RvY29sc1tpXS5uYW1lLCAxNik7DQogICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2luY2Ugd2UgYXJl
IGFscmVhZHkgZG9pbmcgYSBzdHJsZW4oKSBvbiB0aGUgc291cmNlLCBjaGFuZ2UgdGhlIHN0cm5j
cHkNCnRvIGEgbWVtY3B5KCkuDQoNClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNm
ckBjYW5iLmF1dWcub3JnLmF1Pg0KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5j
aEBtaWNyb3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5s
ZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZnMvY2lmcy9jaWZzc21iLmMgfCAxMSArKysrKysr
Ky0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNzbWIuYyBiL2ZzL2NpZnMvY2lmc3NtYi5jDQppbmRl
eCBiNWE0MzY1ODM0NjkuLjJlOTM2Zjk0ZjEwMiAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvY2lmc3Nt
Yi5jDQorKysgYi9mcy9jaWZzL2NpZnNzbWIuYw0KQEAgLTU4OSwxMCArNTg5LDE1IEBAIENJRlNT
TUJOZWdvdGlhdGUoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfc2VzICpzZXMp
DQogCX0NCiANCiAJY291bnQgPSAwOw0KKwkvKg0KKwkgKiBXZSBrbm93IHRoYXQgYWxsIHRoZSBu
YW1lIGVudHJpZXMgaW4gdGhlIHByb3RvY29scyBhcnJheQ0KKwkgKiBhcmUgc2hvcnQgKDwgMTYg
Ynl0ZXMgYW55d2F5KSBhbmQgYXJlIE5VTCB0ZXJtaW5hdGVkLg0KKwkgKi8NCiAJZm9yIChpID0g
MDsgaSA8IENJRlNfTlVNX1BST1Q7IGkrKykgew0KLQkJc3RybmNweShwU01CLT5EaWFsZWN0c0Fy
cmF5K2NvdW50LCBwcm90b2NvbHNbaV0ubmFtZSwgMTYpOw0KLQkJY291bnQgKz0gc3RybGVuKHBy
b3RvY29sc1tpXS5uYW1lKSArIDE7DQotCQkvKiBudWxsIGF0IGVuZCBvZiBzb3VyY2UgYW5kIHRh
cmdldCBidWZmZXJzIGFueXdheSAqLw0KKwkJc2l6ZV90IGxlbiA9IHN0cmxlbihwcm90b2NvbHNb
aV0ubmFtZSkgKyAxOw0KKw0KKwkJbWVtY3B5KHBTTUItPkRpYWxlY3RzQXJyYXkrY291bnQsIHBy
b3RvY29sc1tpXS5uYW1lLCBsZW4pOw0KKwkJY291bnQgKz0gbGVuOw0KIAl9DQogCWluY19yZmMx
MDAxX2xlbihwU01CLCBjb3VudCk7DQogCXBTTUItPkJ5dGVDb3VudCA9IGNwdV90b19sZTE2KGNv
dW50KTsNCi0tIA0KMi4xNy4xDQo=
