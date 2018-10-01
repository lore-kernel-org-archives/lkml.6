Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2735C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3F920666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fAlh9Zk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeJAHRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:44 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:31049
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728961AbeJAHRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJlPJpz9ONuDQ6SWjHaFo1eu5QnHAMwfYYD+fX2DD+M=;
 b=fAlh9Zk2+GSTdihIXSfRM+xvVmwvY/3NwHFRHYLexYrtIzAl79zeX+CrGyBVYYihUHSAjAJbrT5MlJbmUIsFl3M4BEWpHNWc1cYHOI1OZUwzw8KrdL/DLTCKJazUrp/3FQTODkqXgeWfH0prC3D2iV9whlXhMC7cGug5qPTqZO0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Abraham <j.abraham1776@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 13/13] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Thread-Topic: [PATCH AUTOSEL 3.18 13/13] xen: fix GCC warning and remove
 duplicate EVTCHN_ROW/EVTCHN_COL usage
Thread-Index: AQHUWR+MXw+NMOWtJ0O7T3602IbXkA==
Date:   Mon, 1 Oct 2018 00:41:53 +0000
Message-ID: <20181001004139.147341-13-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:raQq2dK6/rdj+PmFkmFCbXuuBTEOT763AruMaBR4bip1Dy/7NL3oo5Ad2rfqi8OBP/ZHQ//69KBBi4e9TkE0DtlmLBt0ngADuupm8MGzxo1fdBVxrZ5BTVFL1rQnM7gxT6mChjp5KIUBdncCIhwFAOSzT6TIw6x4TK4oyB1GQ9GJcIi6OcyQkpZFlBm+h8JrSD3770RwJYc6MQePBAZ6jjGVncfHwF8Mvzeg+AiiszPeHZo8jZE6narlEgrS6ycPtT/U2A258tHLc2geJIg/QiJsS1eChmwrAsi6hQvvsFaHte4V/4jpniIrQ+zxQpZ/rNGb7j8YQ6AGlmoyqfBxZd0vlJfkPk1JOKcsa1bZfBzmbudTYl8u8bq9ND1tqoLfXpp0irARGN/atjjO2lwBl4wOwsSo4zdVgnDJxIKxl6viKBFL4xRvrVMmpWyKrtYLWW6ZKlqj3rIlLegAETV75w==;5:b1c9vh9uHYmhGFmearlAxTCdV3TxYRoVjSAL7GMcNsNOpzRX0BCrslGp7G6fFOybBN6D8aZttMy4F8FJXVEBn/fq951e9almLllKK4Hv7EgNhs6/udn+cn7ZI1zHHp09Gb2X6/eDu84shOGdt4QTGt6ayAx2o8W6syEp6XLdOz4=;7:r2bGam4SgdPkgtMSnk9W+Qnz1gbQyzrKeVR96SeSxPmeLPlJZVKboAGVWLARDpoankbxenIiLHnZNroEkfPjv42RLCySV3DQ344kXyeuYKZjNdMbFwXWqouvMAdpj800bo+t5U1k8UjSwCQgomjHzhOTAS/hblVMWowutS5L6VNkpQa9upezJukyj4p8+Mc1EZlzTfyALW+WJFUWaxpz+dJb67veH2DtFR9wF81dLtygGfB+qJ4pkbZsRmavJzbQ
x-ms-office365-filtering-correlation-id: 2c5847a5-83df-4822-7fcc-08d62736aec8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184C53A524C8E973CE241B0FBEF0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(4326008)(72206003)(99286004)(5660300001)(102836004)(39060400002)(11346002)(1076002)(256004)(14444005)(186003)(107886003)(2501003)(36756003)(26005)(105586002)(478600001)(6512007)(86612001)(446003)(10290500003)(86362001)(71190400001)(5250100002)(217873002)(2900100001)(3846002)(6116002)(66066001)(14454004)(34290500001)(71200400001)(53936002)(486006)(68736007)(2906002)(22452003)(316002)(97736004)(2616005)(10090500001)(6436002)(54906003)(76176011)(6486002)(476003)(6506007)(106356001)(25786009)(305945005)(8936002)(7736002)(110136005)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +UDSiMmLa8QxERU3W1OBfziB1Ez45AFWn7xwXHCC4W9FWSqj3isLn40+T7DK7LyYP4/UeQFTnMiXxW0fK+THk+/j3PyOXqxx1t0Fud+8mqWPvlmOVOIrxLd99R3SbE4+ifzS9VS/uvTr5+Sh292yuxEs+2oO3Ay2SQKRkVAVSeUwWjTJGTZAoyusdz5207bMmiLzCjc290shN0Ls1jG049eybpb0RKPQ6OZYryjfOB5eym86FViYyNHqFHF+x2VuSSMJWtU00OVqrycuS3dFw4ZC+EodfY37AaVUYvFeCFzJlIc5Vxge4w519J2MtZH3JW88iVrk+u5+EiOmozWVyxpj7q3DPU3XKGaCwJeo5dU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F2BC087A4BBAB4D9C64B08F8CF23743@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5847a5-83df-4822-7fcc-08d62736aec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:53.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBBYnJhaGFtIDxqLmFicmFoYW0xNzc2QGdtYWlsLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNGRjYTg2NGI1OWRkMTUwYTIyMTczMDc3NWUyZjIxZjQ5Nzc5YzEzNSBdDQoNClRo
aXMgcGF0Y2ggcmVtb3ZlcyBkdXBsaWNhdGUgbWFjcm8gdXNlYWdlIGluIGV2ZW50c19iYXNlLmMu
DQoNCkl0IGFsc28gZml4ZXMgZ2NjIHdhcm5pbmc6DQp2YXJpYWJsZSDigJhjb2zigJkgc2V0IGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCg0KU2lnbmVkLW9mZi1ieTog
Sm9zaHVhIEFicmFoYW0gPGouYWJyYWhhbTE3NzZAZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NClNpZ25lZC1vZmYtYnk6IEJvcmlzIE9zdHJv
dnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IGY3Mjk3
MjE3YjgzYy4uZGE2ZjJiNmI3MjZjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2
ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAt
MTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2dGNobl90b19pcnEodW5zaWduZWQgZXZ0
Y2huLCB1bnNpZ25lZCBpcnEpDQogCQljbGVhcl9ldnRjaG5fdG9faXJxX3Jvdyhyb3cpOw0KIAl9
DQogDQotCWV2dGNobl90b19pcnFbRVZUQ0hOX1JPVyhldnRjaG4pXVtFVlRDSE5fQ09MKGV2dGNo
bildID0gaXJxOw0KKwlldnRjaG5fdG9faXJxW3Jvd11bY29sXSA9IGlycTsNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
