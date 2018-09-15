Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D20ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88EA21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ao9y0qBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88EA21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeIOGr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:59 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeIOGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVAG6Dha8M9j2mfcFfTAj5d9YFSu3RRdIpIK1ZJCX1U=;
 b=Ao9y0qBuKpvo1jQ05lnDtosw5WYO/JDsI2E09uZKllU02QrXUzcXcPJ75AZxhMgALvATTqZlWX/wvTxCvgXZyKmNF+EtppTZOvdSexSeM/p6fxblTklc+0NkYKX2F3UNm0cYOo3fPzFKNkQDojcDPoqT4F6Mzy3QY5JA0oVx/RU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 54/92] lightnvm: pblk: assume that chunks are
 closed on 1.2 devices
Thread-Topic: [PATCH AUTOSEL 4.18 54/92] lightnvm: pblk: assume that chunks
 are closed on 1.2 devices
Thread-Index: AQHUTJOue47WALEp90uW22LWLo9EhQ==
Date:   Sat, 15 Sep 2018 01:30:27 +0000
Message-ID: <20180915012944.179481-53-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:jZGW5+E4anE4NTyB3LjEC77ReRvvM66ywFx8Mmg9Ly621OYorUlB47Xw9TjNyvUCVKdmNNSRtAtYWnPlpwda3zCpI292/i5U+YAAeKrUtiNDs7Rz88bbBX9FxBSxQB7K1XuIfWR7P/kWUa3Ca2yWxui8b65PSjkuIV/EedmJeoT8Palf+SZ9NPcJwOpnNj0J4DNA9rANGR567JX7zZh8QD5mExFpPrnZkcHuVzZJ9/Q//hzN1DEpEk5jfFr9dGMWjm+FbqBvqTnxu3Vu8CeSKrr6zjzfm2hozDTAmGlXfTkAsD3OfYaAAEgxdGqreLGV35xqfR2VHA/hlbG5gy4QWPwwaEIEP3N0A45zN/NDx1HQ/v/EstmGZWlyWCzQ4SqA3/y1trn8lthwPSQbfLrJaNbFLH0hiGeJUua86TQ+pGFv2sEHIBuuXTslbplvbSAEM1ShaxA6RG8N0So4ABkv2A==;5:88IsG1I8uxVIkUI/5aM6mDx+cs9qzgqBKwHp/a1fXFFNmTIDtUqP0CvugZfhlR9iVMF8exAXjnO3EH/BeWLymsZ69N/P6vepV9uj2xJnR0y8nDtdasVtxwyfnl3VU1zU4FXfi/qWoklw84A2M/V90uOmJ2yBKDUuRBcKTDVUcoU=;7:001yTrzsCBHKPNco36llbARTyTnQQxkH7gLcY5YjdThon81q6oSx11BEhGW6uCpA9G/rg/slE+uN0rhwttRQmKFZ+6vQyVnV24XDxJIy8NF5dPNdLfIgU2rua7CHLhtPSqpn9s2ViLeZ7s8UEGrzpLwn2AJyno+Vh/mrACg/SLSkLWa7qiXVw7l0fkxjJ8nhneUFi7ycRxEpt2bphVEPxd3z/5BzGjbzI4nottW42Qxk0MSccpueqln/d/pBWmDK
x-ms-office365-filtering-correlation-id: 48dc9014-94fb-49e5-08f9-08d61aaae127
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085638DE3FAE5724F98D80FFFB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UbGBJo9WB3nZ84R7NA5teihre3cF6RiHe51IuoI8DMLsqHG9m9WYgzD78jspCrIxBv6SMHN4EbBil5X45sHqLkLU+/JatdSOnaG3n1ZAx2mKi8tSy+HU5eKkpRZ0WrVEygOZyUbOttuXQGLlBpEPm/NKt7Qe8Vm7X5e3jne8CFzY+u9AJT/c+x8G3bPx9VmiEAOoqld3iKzAW+HHlMx8wxzqRFSfIH+dXATbGb5GWbiT1Ul4MRgZi7eYtKoT4ZNjkJ7k8zOlEewdamBZCQxbLlq8uO9li8Z0Rkdifq9dG66BoUluxO4CMZrXUqQbYgLazJLQlgM4Ried5XIUM4VKzaW3i7qn5WH8ZJtvRT/Jpzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C5F59CE56EA54DA054BB2BA00EFBF8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc9014-94fb-49e5-08f9-08d61aaae127
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:27.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGFucyBIb2xtYmVyZyA8aGFucy5ob2xtYmVyZ0BjbmV4bGFicy5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGY2MzUyMTAzZDJlMGFkMmQyMDY2NzI1ZWIxOWJmZGZiODc2MzIzOWIgXQ0K
DQpXZSBjYW4ndCBrbm93IGlmIGEgYmxvY2sgaXMgY2xvc2VkIG9yIG5vdCBvbiAxLjIgZGV2aWNl
cywgc28gYXNzdW1lDQpjbG9zZWQgc3RhdGUgdG8gbWFrZSBzdXJlIHRoYXQgYmxvY2tzIGFyZSBl
cmFzZWQgYmVmb3JlIHdyaXRpbmcuDQoNCkZpeGVzOiAzMmVmOTQxMmMxMTQgKCJsaWdodG52bTog
cGJsazogaW1wbGVtZW50IGdldCBsb2cgcmVwb3J0IGNodW5rIikNClNpZ25lZC1vZmYtYnk6IEhh
bnMgSG9sbWJlcmcgPGhhbnMuaG9sbWJlcmdAY25leGxhYnMuY29tPg0KU2lnbmVkLW9mZi1ieTog
TWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRudm0uaW8+DQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5p
dC5jIHwgNSArKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jIGIvZHJp
dmVycy9saWdodG52bS9wYmxrLWluaXQuYw0KaW5kZXggYjU3Zjc2NGQ2YTE2Li45M2ViYmE2ZGNj
MjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jDQorKysgYi9kcml2
ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jDQpAQCAtNzE2LDEwICs3MTYsMTEgQEAgc3RhdGljIGlu
dCBwYmxrX3NldHVwX2xpbmVfbWV0YV8xMihzdHJ1Y3QgcGJsayAqcGJsaywgc3RydWN0IHBibGtf
bGluZSAqbGluZSwNCiANCiAJCS8qDQogCQkgKiBJbiAxLjIgc3BlYy4gY2h1bmsgc3RhdGUgaXMg
bm90IHBlcnNpc3RlZCBieSB0aGUgZGV2aWNlLiBUaHVzDQotCQkgKiBzb21lIG9mIHRoZSB2YWx1
ZXMgYXJlIHJlc2V0IGVhY2ggdGltZSBwYmxrIGlzIGluc3RhbnRpYXRlZC4NCisJCSAqIHNvbWUg
b2YgdGhlIHZhbHVlcyBhcmUgcmVzZXQgZWFjaCB0aW1lIHBibGsgaXMgaW5zdGFudGlhdGVkLA0K
KwkJICogc28gd2UgaGF2ZSB0byBhc3N1bWUgdGhhdCB0aGUgYmxvY2sgaXMgY2xvc2VkLg0KIAkJ
ICovDQogCQlpZiAobHVuX2JiX21ldGFbbGluZS0+aWRdID09IE5WTV9CTEtfVF9GUkVFKQ0KLQkJ
CWNodW5rLT5zdGF0ZSA9ICBOVk1fQ0hLX1NUX0ZSRUU7DQorCQkJY2h1bmstPnN0YXRlID0gIE5W
TV9DSEtfU1RfQ0xPU0VEOw0KIAkJZWxzZQ0KIAkJCWNodW5rLT5zdGF0ZSA9IE5WTV9DSEtfU1Rf
T0ZGTElORTsNCiANCi0tIA0KMi4xNy4xDQo=
