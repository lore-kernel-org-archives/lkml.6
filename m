Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B802C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B343B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="YAhgXSu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B343B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeK2IMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:12:38 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:39558 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbeK2IMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:12:38 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASL5RL8025530;
        Wed, 28 Nov 2018 15:09:38 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0120.outbound.protection.outlook.com [216.32.181.120])
        by mx0a-00010702.pphosted.com with ESMTP id 2p149he58q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Nov 2018 15:09:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve8HBN5WuRhjgNYrC7kMduGgP2L4QfHhaj9Z3+ovl5o=;
 b=YAhgXSu2LclwG15knC2BLemGAa20cjnmR3QcNuxQMRCloIAdDqn17dpcvi1hp8wC7m281+gjIoRYFIIMUgdRrC8j5FIkMU/mbyOmgBqUGvA5xalYEE3ggUBBtey5SaAtYRiSveg1GxrBwfjvkdzEscPmRfmmOaVJmgjZ3nqsw+o=
Received: from BN7PR04MB4322.namprd04.prod.outlook.com (52.133.221.152) by
 BN7PR04MB4083.namprd04.prod.outlook.com (20.176.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 28 Nov 2018 21:09:35 +0000
Received: from BN7PR04MB4322.namprd04.prod.outlook.com
 ([fe80::dc08:8a7f:6a6:1f2f]) by BN7PR04MB4322.namprd04.prod.outlook.com
 ([fe80::dc08:8a7f:6a6:1f2f%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 21:09:35 +0000
From:   Brandon Streiff <brandon.streiff@ni.com>
To:     Harini Katakam <harini.katakam@xilinx.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "harinikatakamlinux@gmail.com" <harinikatakamlinux@gmail.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Topic: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Index: AQHUgxNAbu3Co8uTGEqCd0JItPQ7vKVltyuA
Date:   Wed, 28 Nov 2018 21:09:35 +0000
Message-ID: <5b550305-ff96-fdf6-883e-b6ae69ad3124@ni.com>
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:802:20::43) To BN7PR04MB4322.namprd04.prod.outlook.com
 (2603:10b6:406:f9::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR04MB4083;6:42ND1lEM430jxmLUnQJDx8J6o7GZtyfAEi/X96iTpWYuMZhcFjcER79NMgfAsGJ4eUNfHWuxCLOY5oV4/U27hxy+R8Qn5uFVhFYIDClDHDJuOzHJKHZq1Ny3vsOtGxRQfoUcSexKmL6rtJirRmTf0eBPVm7yVyIJ7ptZqjA5yfwCaba9WFoxBM4+pv04ryUGqnyqqbddZnaq7P1eIp4fipxwONJwV5xeMuhIFg6g4+y9ArJ1sEetyoogkj4tkLz+Ly1HMPNj2cQioXvKVb/pr/7CkIBDVlfHnjquPPPJqN4JwaSxgnQvLF8aeyOEPHNkdAPXpTrgZbeml2ywXTtMtwc0p8byHMtoRSf6fbsSl61HzSFlrUoNqJLSb04UP1y5VG6dPfIBcB5i4n2Nxg6BFF75ktqto6/bxME5lDbgvymj0ITBwzfInp6Qc5de3Y/CKz4ft9OWRHigAs+ccZBrfg==;5:bNm1bjdG/CRDj7DApJftk5VlALqZOKgAUlrGe2Hf4frDkz3f1WXwtSIaHyuWklLaLIvYI8Js26Z7KBVCIq10wDJYKe58zwPpsLTXBd0hotWpAnIGB74zcMVIl5Q3dNKL4rhXHNQ2tfACEiFAPw+LKOPleIgoLwRVhwnjQEnSXtU=;7:xDAGAqaS5a0g75lSH02GLEj+YbilqMdYCvPT8h1hdEkKfraKhE/3vl+UvKI/N/s4gnwvq/k7CsUWkgKzy5GxSHGTKwHIvUUUD9n9u6ZpR5vMJ/Twz2YzDV9UxMGOaqIFkOeuYN51m8pF4Nxl47TTSQ==
x-ms-office365-filtering-correlation-id: eae635fb-dba1-4fde-a3a4-08d65575ccb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR04MB4083;
x-ms-traffictypediagnostic: BN7PR04MB4083:
x-microsoft-antispam-prvs: <BN7PR04MB4083681193DF177E731D5CCA9FD10@BN7PR04MB4083.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN7PR04MB4083;BCL:0;PCL:0;RULEID:;SRVR:BN7PR04MB4083;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(53546011)(110136005)(305945005)(6436002)(44832011)(6246003)(53936002)(31686004)(575784001)(6486002)(2501003)(316002)(86362001)(7736002)(229853002)(6512007)(25786009)(446003)(54906003)(11346002)(2201001)(256004)(476003)(71190400001)(486006)(386003)(5660300001)(71200400001)(26005)(2616005)(102836004)(186003)(31696002)(99286004)(6116002)(478600001)(76176011)(66066001)(52116002)(6506007)(105586002)(4326008)(8676002)(8936002)(81166006)(3846002)(97736004)(68736007)(2906002)(36756003)(14454004)(81156014)(106356001)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR04MB4083;H:BN7PR04MB4322.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fesCddOMnawbHfXI1agZ9snvSZJ/9KqNQObRXwlJoGcRlVv+f52/HrT2hAJex8E+5oWm97AsE0HBRqMidew3TG5AvqejzmlIPUxtMnH0d79ZnjO10+P75saiGdjCs/AzJfrJuF8jeN0ceF9jBkpBV4FNYoEIwJfKApRK2EQxzRFpnqfb6PxyL5MfPNZ1V0xPn2yYajlm4VjYS+H4oYeriAd6ECLpjerWTcKwrSL7fmm2l5LhOC81+h9DOwKstJ5I0hHzEYTIQtqcH4BD43hRXO2Um/ed0LVtML3XjS3PTyVPqi2YmInglE+mLkAEYjAANlyb8+vqassDkrQ9wve5lJDU/9TXxwQ6JsC/M7fy+ng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0927223994995D429D05B7C88719CF1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae635fb-dba1-4fde-a3a4-08d65575ccb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 21:09:35.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjAxOCAzOjU5IEFNLCBIYXJpbmkgS2F0YWthbSB3cm90ZToNCj4gKy8qIEVycmF0
YSBtYXNrIGJpdHMgKi8NCj4gKyNkZWZpbmUgTUFDQl9FUlJBVEFfUlhMT0NLVVAJCQkweDAwMDAw
MDAxDQo+ICsNCj4gIC8qIExTTyBzZXR0aW5ncyAqLw0KPiAgI2RlZmluZSBNQUNCX0xTT19VRk9f
RU5BQkxFCQkJMHgwMQ0KPiAgI2RlZmluZSBNQUNCX0xTT19UU09fRU5BQkxFCQkJMHgwMg0KPiBA
QCAtMTA4NSw2ICsxMDg4LDcgQEAgc3RydWN0IG1hY2JfY29uZmlnIHsNCj4gIAkJCSAgICBzdHJ1
Y3QgY2xrICoqcnhfY2xrKTsNCj4gIAlpbnQJKCppbml0KShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KTsNCj4gIAlpbnQJanVtYm9fbWF4X2xlbjsNCj4gKwl1MzIJZXJyYXRhOw0KPiAgfTsN
Cj4gIA0KPiAgc3RydWN0IHRzdV9pbmNyIHsNCj4gQEAgLTEyMTQsNiArMTIxOCw4IEBAIHN0cnVj
dCBtYWNiIHsNCj4gIA0KPiAgCWludAlyeF9iZF9yZF9wcmVmZXRjaDsNCj4gIAlpbnQJdHhfYmRf
cmRfcHJlZmV0Y2g7DQo+ICsNCj4gKwl1MzIgZXJyYXRhOw0KPiAgfTsNCg0KSGkgSGFyaW5pLA0K
DQpDb3VsZCB0aGlzIGJlIG1hZGUgaW50byBzaW1wbGVyIGJ5IGluc3RlYWQgYWRkaW5nIGEgY2Fw
cyBiaXQsIG5hbWVkDQoocGVyaGFwcykgTUFDQl9DQVBTX0JVR0dZX1JYVUJSIG9yIE1BQ0JfQ0FQ
U19ORUVEU19SWFVCUl9SRVNFVFMgb3INCnNvbWV0aGluZz8NCg0KVGhhdCB3b3VsZCBzYXZlIG5l
ZWRpbmcgdG8gYWRkIGEgbmV3IHUzMiBmaWVsZCBpbnRvIHRoZSBtYWNiX2NvbmZpZyBhbmQNCm1h
Y2Igc3RydWN0cyAoYm90aCBvZiB3aGljaCBhbHJlYWR5IGhhdmUgdGhpcyBjYXBzIGZpZWxkKS4N
Cg==
