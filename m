Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86DC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AB22083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B6/lFHT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AB22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbeJAHYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:24:53 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbeJAHOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkk6/sWtjfdMYpFmIBJ0VmxI6SKXSOYyspRrJkxhoxQ=;
 b=B6/lFHT3GIRK2KPzsaycrGtUCiL3ZeVu5BbQXMPv602SYQTen6TGmGKD9O+JdAtK7wgyF8Zj/rBFRbeUVJsKt/Fcn4AmoTtaryEvzSXMWeasYOEP4zgqD+HVhMz1HaeZWCetw1ei5YkhhXFwP73ajh1ys0OtGXjevMb7DQ80C+A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Abraham <j.abraham1776@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 64/65] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Thread-Topic: [PATCH AUTOSEL 4.18 64/65] xen: fix GCC warning and remove
 duplicate EVTCHN_ROW/EVTCHN_COL usage
Thread-Index: AQHUWR8adaCxedD6S0KLLXmznarRMQ==
Date:   Mon, 1 Oct 2018 00:38:42 +0000
Message-ID: <20181001003754.146961-64-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:3r32EUEnpA59HYmZBTJTYJ0CaLNczKM7S3nAPABkMSQ/UTP92ApPmhsnZQAcfQhNcwJwEyStMpDi1Jmpevd91eOZ725u8tHUmFQkMH1cg90OHfBbxZqS5oJKGrLFS0kSqGQrC0ZCqvcOonzFrwVfIzEkfTnXwQh3nwrxDNxsmdl71gZGgpDAl+jzR2R6rDuDRHKO+TBNlm/eJxh9zYyvmary2H+Kr3r98FubskwUlLx+SO+dXldLTpNEYlPddrRZOMXA8TrELl5tFYW95JESj7oh5ti/8B798GbNaNjrlJdUr2mdoQMqDfRkONguwM8A4CUmymxrbVNA0vkgqB2zXJZMC9JoQkxk0BQfUEUJkfHukXBFs5GoQ+rANHRfJCsmqDd/9EZoxq2mcv/HmgU+Gb12Ijtz6M0igsLaCdO46wo5gRvdz9k6xbxE516rcTwdR7yGFgJoRupOWxIGJXtBtQ==;5:lDsGUZvhc766fQCRRE7rGRoZIPCVxTWJL5tb6mS5I7G0XXwYU2fYfIopJ3JPE9yH7jDyQwEPfrMD6T97qZx2VfPRZr+v/biFbXzfmMemSYGTLuEhWW2ZGRIotAZbi7OgCEZGO/qe/DEI0Odlnk11eFS9l42KZRZ3rLuRSsmgY5w=;7:UnC+xy0/EtbI3ciOmsKLPJG0+voJJtDehFCI/HjifR7qYrd3NumlUyEl6oXwlS4lxPEFRX01mPZaixm3YL+x9zHsRlNI1UIhpyBgEK1Ni9oYPIizGlsCyH4e1l0gFlMwkffDO7RQrhPlcSSYzAgLXlDDH/OLv4P5vIrpZa1tKY/4X2woqbcQlWfN7jJnmF7QDkcTPyVjcAVUHwzvyfzCyRHS6GX53DeQqo+5VKmFjJ3pfVJfaPw89t113AKcbZoY
x-ms-office365-filtering-correlation-id: 212af883-1b6a-44c6-7b73-08d627365dbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06964FE915EB2FA2A8AEFE8FFBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(39060400002)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K1fGFkS+c4bBVt5BhTozxQmfvKoaCm8ieBYWUx5j22u6Ci/UsfjfN0Wz5eaDXDsUYx27SeDzPUXgDx0M0NRIwhpkQ4a0N9s/+1pu3vrb6GSwiibmMOPnADIoNGmlsOkdanp2+eL3/xaTc5vRz5aJXd1cDcfTHzbDJK/8CE3RFiQM0U/3qyTwYPoS+N0bgi/oajCpg4MzO42wvyHH0utMCgtTDxrBkffFy9USM+ErRoTJicdfV5hrj0GVuKjBZ4t8iWWVz0G1HX0KEz+UdtCNB47473qzLKDfgRlaP36FAtWLt/8DUqurBU2aZElY4G3LBiUwtnJno8uY1my9PmG3y9BeLU8chHdSTaMnKUY3Ap8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <153521474FD12E4C9507844F05B766F9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212af883-1b6a-44c6-7b73-08d627365dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:42.6365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
dHNfYmFzZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IDA4ZTRh
ZjA0ZDZmMi4uZTZjMTkzNDczNGI3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2
ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAt
MTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2dGNobl90b19pcnEodW5zaWduZWQgZXZ0
Y2huLCB1bnNpZ25lZCBpcnEpDQogCQljbGVhcl9ldnRjaG5fdG9faXJxX3Jvdyhyb3cpOw0KIAl9
DQogDQotCWV2dGNobl90b19pcnFbRVZUQ0hOX1JPVyhldnRjaG4pXVtFVlRDSE5fQ09MKGV2dGNo
bildID0gaXJxOw0KKwlldnRjaG5fdG9faXJxW3Jvd11bY29sXSA9IGlycTsNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
