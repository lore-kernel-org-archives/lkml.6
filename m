Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B613EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711AA20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BZdGWwZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711AA20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeJAHRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:51 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com ([104.47.37.102]:43666
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729667AbeJAHRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AILi8WyYelxzXY7L73j2vYPHm3ifJ77xnIFqwr6C1sw=;
 b=BZdGWwZnc6BErTUHq/CT0/sjR1vzuTfWkkH8wbvetHI1K2AUUZ/WSHpWkhI3qFiqzPd14Cl1MGjIcsa4315Am0MUsApI15UoghpCBTpuJFSIwuikKupJ3SV660clVeVCO4vojei/PfE7K22gHJidxprPew0+OoKy7uHLhLNRvO4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 05/13] fs/cifs: suppress a string overflow
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 05/13] fs/cifs: suppress a string overflow
 warning
Thread-Index: AQHUWR+IDzVAFU2jUESgK7707Czzpg==
Date:   Mon, 1 Oct 2018 00:41:46 +0000
Message-ID: <20181001004139.147341-5-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:feq7z110xs6XTpP0cyM70HAGfBsUr+hiNI2koUzlvRJVVFmYJMwzwJytextnRfvx4p0xyv7fl9L2/W8CiC2meSypJjSOeJndcop5+VLU22wBO5peh7zwdfSe5mvp8OjnD77G9MHe0HMD1sJs9SVTFKLvZ6BdKf2fM6SF6264/fuUM1weKrUI5H9B20M8dj5coJBRfyhN9ObPeE5A981B52AjQGabttuh619s+SnYRPdrgoTxlV0NQXVg8LeILpD4l1zT5k2KLC5OBYRWVFum5lfX+E2OfBcSkNPX8N8Z06UiwSutYVG90gYAPisdsUECPl7ALdqGsFJdPmnjTZNfIO/gKNl16O8BLjDBP1PEzBE4wUr5ZpIbKhpbZBd1uwdABREvJWaiyMVl2QIwc0E9IziBfpgbO/KjsuMZ0DgXJZS67AWZMHBjXOWUDOrFvs4Cs6iB/MEnC9TUiQIpI9LKEg==;5:gV+UaCySq3zqHQ+oYRM4hMD8r1I2mMTXICUafB8OYbeCxjdgK8++yeBGeMZ7lOYJke2R99vpdnk/o9R7aCvMLp7HM341/9o35LWcfmIScocjXYj23EqkdzrjlppuR0F1qiAqOLTjwf93ywYgiJaRVJHAAs0eXmgV93UuIQRF5C8=;7:Eour4sz67tgB6n6aMqv/l2Tq2c4Rr8ygarXRTWvU8cslyVofcvwgzxFEV34LQI+a6lbiuXwLLPnf7ff2+H0aQsg4QU8XZRQ8eKWZcIM9NfVcWeaa15tT3y0zwn7DotUV5IwWKo5UQiGCwez6xUiSzxdgwu5wGk9KGMmqjRMr0LW92b5AZtBMS5He+LzyXpq6xr87ZaTxFEMYljlllVU+Lhf3Y1m4xkxiq7SUYq8SM3n5HkTRdKEBAxylQeyLaZ1M
x-ms-office365-filtering-correlation-id: a734dd7e-4bb1-4c58-be5f-08d62736aaea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB079170A209936E0DD3DBB557FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AYavLKx4aImb34Ym0FlkZXwIBasA7YVS7cprdLdrsNjLRxqHR9x3XCuHxyA2/YFKr+oJq53H7Ml0w+U6EaHDt7NexhIOle16BXWFL8j8QFcHFWtB2rsMJku4DkYr5bCT3vndyspfJIJ+io0/ncHxk9BNDPPAyW0ME4MfeAgr7NqXGUiiYo44IwZwXxWwc+CNTsgE4ZuFztkE9jp2NQUd/JD3F/qZdm6eChUUT1AjdaDrlqGZL/jKGy44OoC6tKQQrWa6lAVGG4Pl4Rt1DFArG35syZ8/qv8XE5ybMtPWcNkWB+KWG6p5vZ/rYPOrWOg1ytm+Uber3jU5qlmp1crfZiNnMytJ6FOmTN6W4xBnkjQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3873E6B1A239B148991A40BE3B1CC590@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a734dd7e-4bb1-4c58-be5f-08d62736aaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:46.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
eCA5NDlkZWI5MzhkYzkuLmRiNzJjNTI4NGQxMyAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvY2lmc3Nt
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
