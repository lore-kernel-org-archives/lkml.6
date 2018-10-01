Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D1C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B078D20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VMcm9a7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbeJAHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:01 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730124AbeJAHRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N8MdxtqIN7+Lv+UkosN+4UbmuIOe3xzIQKY+n/Wg6s=;
 b=VMcm9a7vT2MLiMfXsCfQmZDjnoeA1B/wUoaENVV1rSKaw4PVAQNFrvA9cdykiHtYUSR1EmOGpogsT4M19AQLjcHPMVozTQvG0STkKg+VMN6d1QFQHFWUx4dtq5JAcIY/7Z6HyfkZ8v7cMcMT5y/uiUj6Ynq27g9JWgYEQq9FUQk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Abraham <j.abraham1776@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 17/17] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Thread-Topic: [PATCH AUTOSEL 4.4 17/17] xen: fix GCC warning and remove
 duplicate EVTCHN_ROW/EVTCHN_COL usage
Thread-Index: AQHUWR+BrTK0ZyhAT0+z76qCtnoxBA==
Date:   Mon, 1 Oct 2018 00:41:34 +0000
Message-ID: <20181001004122.147276-17-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:j6Zuq/knXX1idRL3+/gYijw+U5tgS57xqtZU0URyNj9FNuITrTg1igoVSS1W9t1o9I4J284zDlj4stP4sg4g0zn0nrUUJrAP+eB+CRVq5iq3irLtrM7pTJmShsCBRy9bdvF7haXo6xMycLw56iMiYw8iTRA9rWjh3gWRolL2QObjHq1ufvErkxApSV8yqqW234hLQclasgYEWFl6kq02lBfU5AgRyAPf13brhHU6gFL+kjlq2SOsS8HZ/Dda3DHGVhTh66c2bYCkiJa3lJ//H3yPlPXVBdKvjUMRbjxPuUP+Q0mMPe93UEPEfcdl3KuNfBcIUmLnLIfv6OPsijJEBIw8+rQqFglcL1JwPFVyicLbolokFagPW//2Oz7o/tEwmhyR0XGR106fMWk+2AfHyyKU1pAEvG2/WVSR9O1mRmy6TkQ9tERaZRx5kAPLGVy6IqyousH4ECDS7HbbNlqQ3g==;5:0Z+KAc/xw/bFUTr+FctVjbpzNxUDYnPjellBgYpPW0dd9ly3QSmFKi/5as+331kjGJ/s6XiXfPd6B/UtjX48HyIIhRHiINAj5w2dW9ngPPtDvcjgHnRzl1/dZusOkOOLWlttWtR5ndaB/yPouvMtFIw9X6mi3huGEyqPAl0ryn4=;7:FQbtL4n5xuIs+ZmzOK3+jM7cUBy4gj1QTUu9ni39tNdlWv9jDZ/MLNnVH8UV1yZM65lmw6mV8uHOE+zREoqWCtBzqYvWhwJlPhJXjdtbxmzS+dafr5G0DhIDDeUVEB81JOpEkwHeNTW1BCxnr4EVDfCXHQCCVSI1iUV29cmLDm3EU5rTfB7n2iUxRSCQX17/tHxzNECC6fp/bkaNKhGNaT98qfBIahAdooWEiNYUNRoXF29CuZ/8CZKpys7r4wzY
x-ms-office365-filtering-correlation-id: fb1449ab-fb89-4b6a-f2ec-08d62736a3c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791F7AB01D51DA7441FB20FFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(39060400002)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BloitDWwsnDgOkUm3tqOyGa4EPKPZbLFHWM+yDHBQLxPoyKY7MMiFQQnK/Kr34IkcxHZvpBKA8LNIv9FGHiYKWVw9qhQ5lXxHZR0BwqWHM7RlkV/fr8TMhtTTY/pTWmjAyykp0trKEls42obNuu5JK/hoI0e1WftkboNgbXLY+TisAlldEeFR2/M43VGqtfrin2PRcvQUtGuKAmY+e6FIeRSeRgIm/uqsHybHTGy6RrY9YGYMAGECL5zshOrkSEAKVEoKo+5d2c8iTPre9V6p3l9TGllNvASg6MCW2JPgv6q2MzhmQtfTITfna/GMXLvdH3LfSnWTli9g20M5JtiWQlS2Xn2CyF7m7TIDagbEps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <27275E7E245CD84E9A4E61FF40854019@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1449ab-fb89-4b6a-f2ec-08d62736a3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:34.7980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
dHNfYmFzZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IDIxZDY3
OWY4OGRmYS4uODc4YTQwOTUwYTNhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2
ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAt
MTM5LDcgKzEzOSw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2dGNobl90b19pcnEodW5zaWduZWQgZXZ0
Y2huLCB1bnNpZ25lZCBpcnEpDQogCQljbGVhcl9ldnRjaG5fdG9faXJxX3Jvdyhyb3cpOw0KIAl9
DQogDQotCWV2dGNobl90b19pcnFbRVZUQ0hOX1JPVyhldnRjaG4pXVtFVlRDSE5fQ09MKGV2dGNo
bildID0gaXJxOw0KKwlldnRjaG5fdG9faXJxW3Jvd11bY29sXSA9IGlycTsNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
