Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4101821477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jcM/rp+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4101821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIOGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:58 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728589AbeIOGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5BEITq3RkPF4R6DU5SRsyjqYFjw+kUQhgvKcGy3LQg=;
 b=jcM/rp+i7khezSKrOhIAVKWe+ersDvPl5qz7kD/7FjKtoXXuiFT+RW0fjBevtOa5V5OJZFf+WvOG6NCBurQ3J9PDOxk7Mw+wK5TT92wtC4aoruyEys6gFsKTZwYVgAx52TwgeO+MOEBExzSjOBjAdMWIrIQsDj7CSLtkzCWfZdQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 55/92] lightnvm: pblk: enable line minor version
 detection
Thread-Topic: [PATCH AUTOSEL 4.18 55/92] lightnvm: pblk: enable line minor
 version detection
Thread-Index: AQHUTJOvzaX0NKclQEOb4TM3ayzCcw==
Date:   Sat, 15 Sep 2018 01:30:28 +0000
Message-ID: <20180915012944.179481-54-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:AgBYn1bDn6XjRebWs/kgYBmR3esjFa9UNRfvtpY+OfPZr4ORYuaUKx9xqYGvOB2pTVkAseDERXAf7n4FkGtuYoNbgL1c+JmqPfqJ5heKyAoY/Q8Ei1m7uWSYG+ALgqjYhlRcb83OZoc4le43vr/HBQbJUezLRlkbpm1B+u6CImxC/VXtojnJJXcksEbTJdZOVuHMNdQnDXeETAk4/v31FDfA6+KD6WPdSp1+O6Mp1Om+NGJ8BRSkpoCGeq/wzpchJaAJ7vpMkGQQiEX5WkGybWXWn1beFkW4z6YFFKPlQqL4vSVcrNS27nmpvNjZoak8QLkkC7sB+J8Niau2rGpTyYuUR8DW2P+8haeMPi4tn654o4DgT06aK4l4k5pTp5CkUnnleVlRcZdY/QYamK46MSTfkqVsx5udkAMuVJnbWpwZdVLB0d+E/DltN95hrBSZWzskl3n7GmR41DuBMxtjBw==;5:71b7ojseanWgV3cpDWU42+JbLMTT32uMgvr641uoprih0QksULMbjjwEmOi+eTwuz5FshD9BEcHyeaO5SUnwOIexV5a5XDrDP5ZxcL0lcRj4n0vCTNmOdIPYBXvKgsvD2YgghAoSB7/sqQ/1doDnNuf+++XAS25e51KBIiHogtU=;7:kp2VQNFM48j+nW17sYEg0yfetVwdWU/8DR+m/dD6GRXDr/GH5cZycx0uSWpjrOhGVCsdteKMZz6aczic7zXkjsytfkthSKBlUqDwNlpwwLuyU51575sUvrPjQd2aUHt0q8AQqq/jwfasar9+rt74diCWrNAjSXptKWNUo+m6VcKdqwCB5rib4wYnhSPrfrmpc/lMsVEykvwPgj7ToyfaIXOLj0OnC40b/Y8UlIgEM7hlazEqEtxtiiebXYrc/ZmG
x-ms-office365-filtering-correlation-id: 19f45d5c-efe5-45c9-529b-08d61aaae192
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085632699652DC253B673B71FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 98b8lJ1k+g1SXunYRCPucKFTAhjY7YVSRl39yxthzZJNp2bYcsNtVRr4JgdWLoJGZdHPAUBmtR5XMvzmbzU58bxLjv5OPyQ3cCeAQ9qDiZGPgglJAiczwp2wqmHGsyto/pdNR/7GdXjgjVogYMkO7sOm78qIqSgNraW2N2LZ2kBW4HlFjiZsozknAFKOHnD3lt6WPsHGTy5KZfCFB1QNMLS15hnPAcNFfTzjcnl63WIUGt8gfKlpPbPaV5BQsDc5zVcQCnLFk5CSvw2tzogapiJVxQy9JP1MbERIsivOJerMMKYDzNKE1kiON13Ji+0uYJQYZGh5Z5a4vzgy1t41Il62Oyrx0d1lIiaf1sUX5QI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <035F9109CC87794982FB07FCD6504261@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f45d5c-efe5-45c9-529b-08d61aaae192
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:28.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRudm0uaW8+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDk5YjhkYWQxYjZlNTI3MjE5MDQyMjAzMjJhOTQ3ZjdiNzUwNTYzMDMgXQ0KDQpXaGVuIHJl
Y292ZXJpbmcgYSBsaW5lLCBhbiBleHRyYSBjaGVjayB3YXMgYWRkZWQgd2hlbiBkZWJ1Z2dpbmcg
d2FzDQphY3RpdmUsIHN1Y2ggdGhhdCBtaW5vciB2ZXJzaW9uIHdoZXJlIGFsc28gY2hlY2tlZC4g
VW5mb3J0dW5hdGVseSwNCnRoaXMgdXNlZCB0aGUgaWZkZWYgTlZNX0RFQlVHLCB3aGljaCBpcyBu
b3QgY29ycmVjdC4NCg0KSW5zdGVhZCB1c2UgdGhlIHByb3BlciBERUJVRyBkZWYsIGFuZCBub3cg
dGhhdCBpdCBjb21waWxlcywgYWxzbyBmaXgNCnRoZSB2YXJpYWJsZS4NCg0KU2lnbmVkLW9mZi1i
eTogTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRudm0uaW8+DQpGaXhlczogZDBhYjBiMWFiOTkx
ZiAoImxpZ2h0bnZtOiBwYmxrOiBjaGVjayBkYXRhIGxpbmVzIHZlcnNpb24gb24gcmVjb3Zlcnki
KQ0KUmV2aWV3ZWQtYnk6IEphdmllciBHb256w6FsZXogPGphdmllckBjbmV4bGFicy5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQpTaWduZWQtb2ZmLWJ5
OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2
ZXJzL2xpZ2h0bnZtL3BibGstcmVjb3ZlcnkuYyB8IDUgKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9s
aWdodG52bS9wYmxrLXJlY292ZXJ5LmMgYi9kcml2ZXJzL2xpZ2h0bnZtL3BibGstcmVjb3Zlcnku
Yw0KaW5kZXggM2E1MDY5MTgzODU5Li5kODM0NjZiMzgyMWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2xpZ2h0bnZtL3BibGstcmVjb3ZlcnkuYw0KKysrIGIvZHJpdmVycy9saWdodG52bS9wYmxrLXJl
Y292ZXJ5LmMNCkBAIC03NDIsOSArNzQyLDEwIEBAIHN0YXRpYyBpbnQgcGJsa19yZWNvdl9jaGVj
a19saW5lX3ZlcnNpb24oc3RydWN0IHBibGsgKnBibGssDQogCQlyZXR1cm4gMTsNCiAJfQ0KIA0K
LSNpZmRlZiBOVk1fREVCVUcNCisjaWZkZWYgQ09ORklHX05WTV9QQkxLX0RFQlVHDQogCWlmICho
ZWFkZXItPnZlcnNpb25fbWlub3IgPiBFTUVUQV9WRVJTSU9OX01JTk9SKQ0KLQkJcHJfaW5mbygi
cGJsazogbmV3ZXIgbGluZSBtaW5vciB2ZXJzaW9uIGZvdW5kOiAlZFxuIiwgbGluZV92KTsNCisJ
CXByX2luZm8oInBibGs6IG5ld2VyIGxpbmUgbWlub3IgdmVyc2lvbiBmb3VuZDogJWRcbiIsDQor
CQkJCWhlYWRlci0+dmVyc2lvbl9taW5vcik7DQogI2VuZGlmDQogDQogCXJldHVybiAwOw0KLS0g
DQoyLjE3LjENCg==
