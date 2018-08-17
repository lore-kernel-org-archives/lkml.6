Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A322C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFB221A28
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="NiNr/Zvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFB221A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeHQTgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:36:36 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:37266
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbeHQTgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrenqZC3+P5V94P5PH9dC8JaK5BrL/S235bXU1ecWnA=;
 b=NiNr/ZvgoiybmizTTyS/4I1FNPtKVGBocJvfm6tZclKx1htDhlfRopJGZ2So6H3mWnUqV6nZPgmJaxpAqj9v1Re4uSbCoP4EZsmHyElt2SkNGjSjcxrbKAtHBRtB/yn7ekDj1vNZK2KraRaqYfqlRYthKEEUh/cKLhZlopMwY5o=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3596.namprd06.prod.outlook.com (10.167.236.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Fri, 17 Aug 2018 16:32:31 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864%2]) with mapi id 15.20.1038.026; Fri, 17 Aug 2018
 16:32:31 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: dw: support 4-16 bits per word
Thread-Topic: [PATCH v2] spi: dw: support 4-16 bits per word
Thread-Index: AQHUNfg4nuLA2ae5sUaOX3MuOsQKJKTEI9cA
Date:   Fri, 17 Aug 2018 16:32:31 +0000
Message-ID: <1534523550.2283.397.camel@impinj.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
         <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
In-Reply-To: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3596;6:FgVWyrnznJuaJtjJvC5GHQ9rVHa9zfP5eYU9b48pYTA/QEdP++XVpQ9Kkk4MNztmv6dO6Ig1+tWcMdvL/Yi/wTazlwgYvWxzN2Eq27gvxHjBqUzRmBbRDpW74s5CxEmnIMqOfsQSgKwSWFDXQ51CrHG3vuZHFMfhrwhArvErMoj4prZXq5MMrOSA8Zwdep4j/TVDhfAr1r4Rw21cImUYlKwMDFE4V74typkijknLdBG9/CqfnqxAfnEp80I/ucRcrNqEAeryq5hmMDr02cdsjXs4ldmwGUlM335JrFtNxjmj9lxTRsMz8O8sWaOnLSslV4mQt2WE44DM8cWPQavwpE0LZoifOnX70QGnFtsK3+3Lavxy4RpJd8cQ1XSAuqu7pL2s8mY5bapZAwrBzfgYge/paz2/kWcwg5ixfZmoMmm/fFOKGF6iopwX0z2Ywpi/je+OWrv2KnBUfZAkihMiYQ==;5:Oc4YUL3Xy0wZEPQGgetap04DMU0Uk8e6AzzUqshUJ/YfXChRTDMhFShj0gMR9uZUntTzoEqSS9Le+Bycfrj+MHQvNbs6M1h6rmFsuDighZgk0ZeC/y4e2DklwUe2G7AgCGEglYdEWhK9SOVr/iWGfcZvai7TQHLtwqa4p2l2ees=;7:Q1Rnoxviz94l2KhjfgGtqWe/zTAA09uOwLLGULZmLUtb9e2YBzoD8Yt/mMcJCSoDnLbAN5taEN+x3Do/e0fKqtBL1QdMSoQ1uKvvjucahtXztU2Ar5u0LTiS9V8UCO7UMDB0yCcUYboEPB2XUEiX8OYg0GYykaxDhKFYW/f8AsMGIw1OrZClTjt0l1vt9n4zI8iIDxh3eieswgALECzTAOvkoM8qFoCft0gzGar/HfhvNmQ5529YqpEm9WiAoXA7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fcb272aa-b21e-48c5-4a76-08d6045f0776
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3596;
x-ms-traffictypediagnostic: MWHPR0601MB3596:
x-microsoft-antispam-prvs: <MWHPR0601MB35969E55E349C24DFED60C03D33D0@MWHPR0601MB3596.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR0601MB3596;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3596;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39850400004)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(102836004)(106356001)(26005)(2900100001)(86362001)(105586002)(8936002)(68736007)(2501003)(5250100002)(2201001)(36756003)(2906002)(256004)(6506007)(66066001)(6246003)(186003)(39060400002)(486006)(11346002)(25786009)(446003)(476003)(2616005)(14454004)(8676002)(6512007)(6436002)(6486002)(6116002)(3846002)(478600001)(53936002)(305945005)(316002)(99286004)(97736004)(229853002)(103116003)(76176011)(5660300001)(110136005)(81166006)(81156014)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3596;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lCjMNoPcQXMQ8Zn9vcwyaNYv5BfByIxeQM+EWuHJRUn5wDoqkIPTwpyysp1FtIkLlw/bYpVpkyt6Sxu3ZTZl8ZHgPcAnMiwCCgCytTdUXHlfNyHyqYnDeh8kzYKsZ/G/81GwJ62QAuIONMJhjocdFxeqLTpUrBKRO8t/izlZQNDanQy8Ov6CHe46zgATh23Z3vjZEn/NGTH52sj1yRFxuY9pMisaNtobvR/SHnsyluhQR2SQlukrlDKZIaK9a+WpheozhvZS4iG0STc+ZrOBTdLEXYDSN7DvQ8EuDwzCA5yVkPwTecGFk49oBv0hKM0QGuDpB+vG47OopymdXl3Kf44oD9Dcvw3TnKFMR3LCltU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E96AE1C0D7E3F4F9072F9FBF5E5E939@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb272aa-b21e-48c5-4a76-08d6045f0776
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 16:32:31.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTE3IGF0IDA5OjAxICswMjAwLCBTaW1vbiBHb2xkc2NobWlkdCB3cm90
ZToNCj4gVGhlIHNwaS1kdyBkcml2ZXIgY3VycmVudGx5IG9ubHkgc3VwcG9ydHMgOCBvciAxNiBi
aXRzIHBlciB3b3JkLg0KPiANCj4gU2luY2UgdGhlIGhhcmR3YXJlIHN1cHBvcnRzIDQtMTYgYml0
cyBwZXIgd29yZCwgYWRhcHQgdGhlIGRyaXZlcg0KPiB0byBhbHNvIHN1cHBvcnQgdGhpcy4NCj4g
DQo+IA0KDQo+IEBAIC0zMDcsMTUgKzMwNywxMyBAQCBzdGF0aWMgaW50IGR3X3NwaV90cmFuc2Zl
cl9vbmUoc3RydWN0IHNwaV9jb250cm9sbGVyICptYXN0ZXIsDQo+ICsNCj4gKwlpZiAoKHRyYW5z
ZmVyLT5iaXRzX3Blcl93b3JkIDwgNCkgfHwgKHRyYW5zZmVyLT5iaXRzX3Blcl93b3JkID4gMTYp
KQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQoNCllvdSBkb24ndCBuZWVkIHRoaXMgY2hl
Y2sgYXMgdGhlIHNwaSBjb3JlIHZhbGlkYXRlcyB0aGUgdHJhbnNmZXINCmFnYWluc3QgbWFzdGVy
LT5iaXRzX3Blcl93b3JkX21hc2suDQoNCj4gIAltYXN0ZXItPm1vZGVfYml0cyA9IFNQSV9DUE9M
IHwgU1BJX0NQSEEgfCBTUElfTE9PUDsNCj4gLQltYXN0ZXItPmJpdHNfcGVyX3dvcmRfbWFzayA9
IFNQSV9CUFdfTUFTSyg4KSB8IFNQSV9CUFdfTUFTSygxNik7DQo+ICsJbWFzdGVyLT5iaXRzX3Bl
cl93b3JkX21hc2sgPSAgU1BJX0JQV19SQU5HRV9NQVNLKDQsIDE2KTsNCj4gIAltYXN0ZXItPmJ1
c19udW0gPSBkd3MtPmJ1c19udW07DQo+IA==
