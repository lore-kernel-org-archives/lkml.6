Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB93C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BA2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eE/moRND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227BA2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeJAHNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:22 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbeJAHNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBc7zUy6xQdHr5ojEEHTWpSpEtUv0gLoe0hW7Zqftzg=;
 b=eE/moRND5zmz1ohcXx/II3tStYetik3lq/fqScrxs+qW04lovfu7w7L2AgFpJpctIW/w3+leP6Wfh8t9WqwewNkFBesEq7LHSqdygSprRzHlkhB5oOFjJxIFGfm0epfwdAN4OvoXOcuIvBf/IImiM5m6aeTcMHViW0QddsIcNxA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chris Phlipot <cphlipot0@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/65] perf util: Fix bad memory access in trace
 info.
Thread-Topic: [PATCH AUTOSEL 4.18 13/65] perf util: Fix bad memory access in
 trace info.
Thread-Index: AQHUWR8Hq8qMuWeLIUGvwzJD+YH85w==
Date:   Mon, 1 Oct 2018 00:38:10 +0000
Message-ID: <20181001003754.146961-13-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:KpDScoP240c2KaG9E6YX4UmJn8W0h6Lw2paIyzKa6j1fmMc93XMyObxNO4xU26R0NGENVW2Qx2seHjj74JDDeX3P2iJwCYDBBevObWnX48o2aYM5gTjctgSNnACncw4F8LmRtTIArjwFGBZrOOy6QSh+Mx3ycnRqFpqCxuRr/x4RAqeddWZEIUc1wV4370lglnZ+lYyHqt6BQI78Om6jlz1uW0WtZPwWnvEzp6MbHRPeBauYOJF8crEINRkfUmnBsdXPJDkHpWcoTWOHtXUqgYHiJC0j6Eif/OzNYjc7+LYDhSCrgurkjY7ExFRC8FPRWDtLEh1500k+a6DHExMwPV56RrH0wkCXZndyXebOo8HbL+ZYTJ10IJ0qDsHmXddT0QcmTx3KKorFLvsCn8LJto0clXeQVqIRSrJ4MJ67Bmq0gwd4rey89WVhy02MnHyQWrGhh5fT5nj5VL3Mm1f5Xg==;5:6PARZ8zFulgeGplJoAuoaoSQQEsRjJYgpPuskjEtnr/Ee6jI85lE0vaRgFvCTSGdxsvJ/sXiVuAaOKC5VqoHh3kCb2ToFTxeMZwu0OebAixk2IfmZYTPEyhNgxHQh+vI35twHWlZWPUw6UvLjXeEH58vly1WIa9v1Odb9OpT3Xk=;7:6mmMDwrF+BZox3h0Z5BAoXcfI93IEFSHYHQCRUWHlWhK7gnYd2T2KXTAZBD3wwou372tIIshUvwFaeStbwHrMCZUm+P2Pd13CUoGWyQjuOl81E+M0vYHk13wcShWptPFTNijs7f77ar1rhR2uSV2QsUNlPLxxKLTbCZhIPr7xieQtcVZ+xtHol7DZce6vFmPxkEtsPI4M8AEFzGmEuRz3fUENNvXSiCl31KGo59jaxMdzOv45t5HAwu9T+G3xbfQ
x-ms-office365-filtering-correlation-id: 32693533-59ee-428c-6379-08d627362a35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472E86534BFFB1567E36F96FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(966005)(6486002)(6306002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(39060400002)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8M8L9KuqkB9f4orzKT9arnm1EV0abh4gHMQfryTUfl5ieQSlUs3GoO/nCGLeOGwt/5kVYGXtNioWfkL9Sng96BglOmmVE90JsmsEEQTdLQtH5Yudt18g9UwS+lvVw6DWs354T0HlSHk99p/l/VLgsvH4wDxwp3zLREVzxSJDQt0R1n/oB1AJkAfMvLlUNJFtQYUEnQ2Q0h48c+soeJVPM92AvJa5iOUwfpGzrNJdBhjzIXk38al+ClM/z9cFtUcdUIP4VRS8X5RC9Mv9qVDaEFC3yAv0GuIuBoUaVDNgC7RchqHuco+YMxMUm/B7rlrBGxkJYOG9xbNb9MiEf1AeqinY/tlM38eshRZjkiKE/Fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32693533-59ee-428c-6379-08d627362a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:10.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

[ Upstream commit a72f64261359b7451f8478f2a2bf357b4e6c757f ]

In the write to the output_fd in the error condition of
record_saved_cmdline(), we are writing 8 bytes from a memory location on
the stack that contains a primitive that is only 4 bytes in size.
Change the primitive to 8 bytes in size to match the size of the write
in order to avoid reading unknown memory from the stack.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829061954.18871-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-eve=
nt-info.c
index c85d0d1a65ed..7b0ca7cbb7de 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -377,7 +377,7 @@ static int record_ftrace_printk(void)
=20
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err =3D 0;
--=20
2.17.1
