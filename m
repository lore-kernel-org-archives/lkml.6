Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA5C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293A32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VpJRL6Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293A32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeJAHPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:53 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729864AbeJAHPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYyriHF7VXVT03+fqolp1SH+fBVC13kTZxYJwC9yTXA=;
 b=VpJRL6WySWOmkqzn8monoZKmzvo1hjjzKjagfvWTrOJw2Xxtvlrb0N5GVmftvSsy0MFnIXFL3M4PpdN8zur2fuc8Ctd9GWKVEDRt+DGhV71ir4yFPKvT9FMqpu81SWUHDgWpLPHKHGqf5VdGoejp2hXrEI07bi9w92pWEbOUCno=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/26] fs/cifs: suppress a string overflow warning
Thread-Topic: [PATCH AUTOSEL 4.9 13/26] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR9eu2Abd+Qhj0+WYCZxxYb55Q==
Date:   Mon, 1 Oct 2018 00:40:36 +0000
Message-ID: <20181001004026.147201-13-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:7mOYYT0KcDwauTLqpdkO+betEhRdCLiH6CdvIaISaZkjHwId+q8A0D37MrbYBVgZ8OoV3huwv9Hwk0aNxpVVoQxJkPbfqS5klX2n3uOnuNJU3EyV7vmNBCDIuxdpN8HjWaLulBuMGyJx5NaQ+cCwzUF6o29NPiag/w3L8acjeAY6Rpf7A7dUUz8peYEA24zrkwQiav2WCtrMf2zvT2I0038+8BT4mitHvntVsPrMRksRkYiVsE7QuvvbDyMrOWegNnloKquvl1koV03XuCyAsHhClLaViHCXeEhxj7qiz0tlu060xS9V28+o+Hp4DRYgVVix3/cK1+xI9wMLLyK1sqGB2RPNcFXxcPLEiJpbiUkYJpD9wIE/QaG3lr36zZBIjOt3SEkWlRZVLYx+MbrUJPNVrSyiEPz9RRmsmqPYwHivkuBzJqJnCZzAElR1/ONfOt7TIjx0vAkM5HX0obbJ+A==;5:uqnkPMJJgxQO5t3IFfkJqzTnfJBvhuQ7aZe0CrFEX/UljayanZc56Suq5a9GX+udP/a8tNYkX1xI4WkzHSghxKdo32d4sgW9KOdI1krYsaPhXqMhIr4hDOVTKo/0drZdAkQy8YY0Xta8b5L+1PeA8t4qswYvD48fR2JZInUxFF8=;7:1nUKx2+gWsHUsima9TDcKWEgp4iqpn1HKu3bzCrByKFuE6FF/EPvYbzqZTA5KMtvnUdLbI4zJlZa77IvgdMtDWifCW8yGCvm4vzvZDRDmj7D9FJgA8OCW/P8WDxd0K/IIRhHVTbns7urfAJAgJMBmI6edYSFZKE70CYxYW6/0IUFaWjg87NitKdAAHQ3plc5/5nku3tph2Fp21qRvx/f/jWyjw1mERDQ0k4L2RuMMVVUmiZ9nIfMerBkssQ98noh
x-ms-office365-filtering-correlation-id: 82ae336e-7682-4cff-1676-08d627368149
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01208796FB4954D296F67D46FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pzCCoaFVE76N/28vWVyu1MoxnRT9svQkbUtJ5xoWFAONn0lp628vbENVAy633Dtx8RxkDtgi7WuTABXlyyDKVrsV9Uu1SmmORPF8WRqpokP4oHwiyGEvc8bkWrhg/RzE0yUIOOGVoEA3eMfoH1EUP5n9pSnxYZRCq4x3pO8tcP+xZGu0nO+BbTq0nBoyMvFpYLUb11Luzg9TTNDR4zkiLrLwIfzRrmH7o4q1OJOciUBe7pQ2jfdRSNputTEn38wzPAVQwrwXiQ6WBFJ5H30suhSPVRB97H81OYcNigvsUKQRaojjikOizcZPLHDg23Ztr/+GhIyJCWJC3nITqeTHmugDdjqvk9n+Xa5dPAqAuLc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB40D38D44FA9B4AA8297CBEF2E9CDC2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ae336e-7682-4cff-1676-08d627368149
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:36.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
eCA4NDA3YjA3NDI4YTYuLjc0MWI4M2M1OWEzMCAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvY2lmc3Nt
Yi5jDQorKysgYi9mcy9jaWZzL2NpZnNzbWIuYw0KQEAgLTU3NywxMCArNTc3LDE1IEBAIENJRlNT
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
