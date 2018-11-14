Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B271C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D052022419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hHU8HMsi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X9BJxyDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D052022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbeKOB2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:28:10 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38322 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725759AbeKOB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:09 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAEFNmAw015724;
        Wed, 14 Nov 2018 07:24:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=QuDZIfFxr9PD3Kch8f8Pmun/DaiqqENnOyLW/XrjpOg=;
 b=hHU8HMsiwpYHz8kSBpz0yr/vYNqqSLHXpB2uuQdvLeRrz5V7B/jogQB1iPaqFcE0BUGh
 QBxdoGJWLyPoTey1Huuh/LKmC8g7ynGL3FMJalj1pTis1LmTEevD6etVCeDAwqFg9haD
 ARIGu/gXIqPX0I6dKnE71SLcfdfmt6+KMSSAFF6R3LKWdNYUNDIkLBA2/MDCGtn1b2C8
 EU/1C8+hZti2xOhcojzbL05wHLF+mCfSnXpFC9Ikjz+FYxhFpfqs35R87+73MskeReZH
 akYBrsTrqktBMSVgUnPhNGJUglKwRd8sR3WCyIjSK7RqksWPSycWiM9JP35cfBiDW1MD hA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0242.outbound.protection.outlook.com [216.32.181.242])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nrnvf85kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Nov 2018 07:24:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuDZIfFxr9PD3Kch8f8Pmun/DaiqqENnOyLW/XrjpOg=;
 b=X9BJxyDZG/DkIcPXSyu8Q+0eG9gDZtJnlo1gzuVnWJneZAnyDCw2+uzshWT2MJhE7XT2KVnY1Te8QJ4+M5A7CjTcklwhxvzWQAPBIrkKQyOJuRIbNIQlBhcmkbwraI8MPgejYr8Q3zOsXor7dl1Us6Igj0CVyT55TbCuRNOLSd0=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2552.namprd07.prod.outlook.com (10.166.201.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 14 Nov 2018 15:24:17 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc%5]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 15:24:17 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] clk: Add driver and bindings for Fixed MMIO clock
Thread-Topic: [PATCH 0/2] clk: Add driver and bindings for Fixed MMIO clock
Thread-Index: AQHUfC4bmXQ9SUBjl0C1bJG2fD1mlg==
Date:   Wed, 14 Nov 2018 15:24:17 +0000
Message-ID: <37A652CE-2DB0-4232-8F94-F11A38D2FA76@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2552;20:29S3rtdHbLtHBBVv/0i+WiQFDIPSb1i+tyGLlnvndGIeU2RjQuXEphSMKepw1QGA/3i48dv6/vCwlWghWpiTRu7zrMGuhsJ7DjCv6cje55rHpWE6fuTfa00m6CR/PmXVbX9yE2a8V19cI99a/ReashCkrK9LRQlitUG3257T1wuS1dnr9DsQ5WfT5cEJv/FpyIVqfmCNzgwRUERFvAneDU6B88RJYTBiI9D+2VNnQbEj2EkD4YrSj7oAjXdqpHWS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46c69c93-e40c-4816-8dae-08d64a453e3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2552;
x-ms-traffictypediagnostic: CO2PR07MB2552:
x-microsoft-antispam-prvs: <CO2PR07MB2552088C2FA2713EBF58FBF0D0C30@CO2PR07MB2552.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231410)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2552;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2552;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(36092001)(199004)(189003)(2906002)(66066001)(81156014)(25786009)(3846002)(81166006)(68736007)(6116002)(8676002)(4326008)(71190400001)(71200400001)(83716004)(97736004)(486006)(54906003)(110136005)(476003)(256004)(316002)(86362001)(305945005)(26005)(53936002)(186003)(2501003)(478600001)(33656002)(2900100001)(99286004)(8936002)(6436002)(6512007)(105586002)(5660300001)(14454004)(106356001)(6486002)(82746002)(6506007)(7736002)(102836004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2552;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uHw8FqZU4IMAdoVHacFTmqRRziLOe8vqo7ChLdLb6lJespdO4z3scI1NG5hcOEGr30cMKQEiH+sFQrBSXxZiWAXfBqrcAobuCw2Qh2BbXgSETplgJe7l/FGbxie7xbgfeXJeVu0EJ0yBApRTiRsYxyxnuXmNfFMcC8clYgrKjMdoobdw1a9UV7z7TfmXQk2Tw4sug0Al0/rl0rJ57M4ynDjk5UvsliiN1wdTzyNFQrBjlTqnBO0/CNz9LY+kKwkEP3BQLAjb1KsRphQ+Qw+ouhSVPAdfJk8wWQnIuSQ46XUpsz7p7UR9G8JlRa3NOGoa6W6gSLUw9orYB7q/lVoohftYTWeRmiTrzRhczHldFuo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18C1E87ACC78DA4FB2C6CB876CF17F8B@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c69c93-e40c-4816-8dae-08d64a453e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 15:24:17.5077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2552
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=696 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Fixed Memory Mapped IO clock.

The driver reads a clock frequency value from a single 32-bit memory
mapped register and registers it as a fixed rate clock.

It can be useful for prototyping Linux on various hardware platforms.

Jan Kotas (2):
  dt-bindings: clk: Add bindings for Fixed MMIO clock
  clk: Add Fixed MMIO clock driver

 .../devicetree/bindings/clock/fixed-mmio-clock.txt | 22 ++++++++++
 drivers/clk/Kconfig                                |  6 +++
 drivers/clk/Makefile                               |  1 +
 drivers/clk/clk-fixed-mmio.c                       | 49 ++++++++++++++++++=
++++
 4 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-cloc=
k.txt
 create mode 100644 drivers/clk/clk-fixed-mmio.c

--=20
2.15.0

