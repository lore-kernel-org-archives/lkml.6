Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC6C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B8B2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=namikoda.onmicrosoft.com header.i=@namikoda.onmicrosoft.com header.b="fMdzMV8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B8B2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namikoda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIAWMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 18:12:53 -0400
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:2858
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbeIAWMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 18:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=namikoda.onmicrosoft.com; s=selector1-namikoda-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P26rET91hYOpeJAR5Jq7JQvenDwFJb+85143gojyPpA=;
 b=fMdzMV8cTTqGao2YUikCs+GqNIewiS5lM25lm/iue8R7mQInICNiG2gkOBe3lE1BThNat+H1Rc8H3dKZeP+6bFKJhEhWWy3JJL3/L4rHhqD+g3Tt7qUGbtaub2bSQMCuDXNOtmvCnuuCxx4Ai58fGYJ5TdCASt3FB0LpSnY9kpo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=william.lieurance@namikoda.com; 
Received: from teh11e.internal.billylieurance.net (50.249.243.77) by
 DM5PR18MB2103.namprd18.prod.outlook.com (2603:10b6:4:b8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Sat, 1 Sep 2018 17:59:59 +0000
From:   William Lieurance <william.lieurance@namikoda.com>
Cc:     william.lieurance@namikoda.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / LPSS: Ensure LPIOEP is always set on resume
Date:   Sat,  1 Sep 2018 12:59:15 -0500
Message-Id: <20180901175916.28567-1-william.lieurance@namikoda.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.249.243.77]
X-ClientProxiedBy: MWHPR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:300:ed::22) To DM5PR18MB2103.namprd18.prod.outlook.com
 (2603:10b6:4:b8::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c98f53-33c6-44ed-b129-08d61034bc28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB2103;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR18MB2103;3:zujcNq+K9QISn3v9mx2WTtAraMAtWuAbUlwBbyMwWLK2EewBfUX0O1TCIlHjdt/CZDLdUiRGuCC+ar8Du6J90NOY4xKLw5ZcrfY8DuYL/yCnbKtJxkoF2CPA2azknF6vauhSAXOeW68mDYUCxE7ayNTIN8+hFZo4McFgER5o5ys67JkZwg2KagDpsNiA7yYga4z+XdxhCGJBzyPZJJHKpsdmtTU8sPzNXYe07Bk2eD3zVPg5XSYZSOkORpIZWmUd;25:jUuklkqbn77loSVoN3CXol/qc/zfSf9jXlNBcE3jM3ox22dAnTVW/N9ypWV96DGvYJlMaiOTmGpF/LS6ehJi18cFnCUjNPvIkhRr1IARne5gWKCwnYQVV+3+7k/7LsvLVCeakMulEmRtB9kzx5j1tUrXbMLgw9eNa6jcphgmbEcAgO8DBLRxEACxARGYaq2zrUZ8cDAuaJxldvsnCK2kfnoLZ454eG2QTLpN/IfM4CfPupXxVcAWljvJbCvXKzpQ9nK60UlID3Wi5XFit4U2Rnp+z1GdnscFyN+Pq/HN9E3ioJAbUafl+i4PmAj+c30Vr+8N9RoO/wtP5VfRUNGGUQ==;31:ej/jL0hEv6tzPMVkgwQ041eaIyzVHJ9uCuYSpbhoe6bwfyj6Zo/MvCjYIi8tcExojaRNMNnBv8d74KzcTQ7VCESJaOl0+Bxml0yysOsfbbtk434L1cuTLXUX7VOSQ8bYoi39tjRYPznDP3ZxzrXRMRz72S1DoqGHMFHDZeVQjoC5Wjkw4wVH5qZ23wrCix7sUcli59/0cNkwqNQMYrNw6wJUU30N3reValD5npbwRcU=
X-MS-TrafficTypeDiagnostic: DM5PR18MB2103:
X-Microsoft-Antispam-PRVS: <DM5PR18MB2103F4D2AB7DA26FC5637EE1840E0@DM5PR18MB2103.namprd18.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(2016111802025)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:DM5PR18MB2103;BCL:0;PCL:0;RULEID:;SRVR:DM5PR18MB2103;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR18MB2103;4:OjTs+Nb8jMz0Cnwx1jA4wG2txk6wptxg4tfuTxBma+zgMi/Uymg9K1qKBndJFHYDaRISwtfaLlSyJxJzCukJRPZ49rdEGdgodFXzluoad+MfpPSgvmi9OQXFCvvCLsYLf9sAfYpQVAMSlBxkQbV+qVt995V84L9U2zfUhdGWcmzKzAuXjooFR3DVpp0j7Ko4ULNxEi+pejUCldRxFcvfjKlSMeeCJqimib5qPZBfMcSxyMX97Nj0siQG3vIa2uW9n2R1Ylq3PfPHpR83b4BY6w==
X-Forefront-PRVS: 0782EC617F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(6512007)(53936002)(68736007)(105586002)(6486002)(305945005)(81166006)(1076002)(25786009)(4326008)(3846002)(8676002)(36756003)(81156014)(6116002)(7736002)(5660300001)(54906003)(26005)(2906002)(1857600001)(6666003)(16526019)(16586007)(316002)(14444005)(50466002)(106356001)(6506007)(47776003)(2616005)(476003)(386003)(956004)(44832011)(51416003)(52116002)(1671002)(8936002)(97736004)(109986005)(86362001)(478600001)(486006)(66066001)(48376002)(50226002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2103;H:teh11e.internal.billylieurance.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: namikoda.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR18MB2103;23:9GMVvc2p7OfmCZLEoADpYArzLnG8I54z6OyrzH0TY?=
 =?us-ascii?Q?WZxfuALrdDW8r1PGV8OClxofZheG9U9CdWgjSmR7o6++nwSiPsyNWX0tZdEb?=
 =?us-ascii?Q?ovdMTdf5MepI/tt0qRPmzLAP78VBpGFN1q1dfKH/mbyO8YEjh33l20NJyxQd?=
 =?us-ascii?Q?tv/UEfJQrBZyAg2vXIxcJmkwc1vdx25p9oNvaF7xEBpA5hOpsUTIzwB6VncA?=
 =?us-ascii?Q?gEQnra5AtS6UYuxbp/6deEjukBs/Mq1UxShDsV3+3J06kmgoi2H3oppIlGRs?=
 =?us-ascii?Q?Oa9BxPjdofadif74xdI0bP/TxdBlX4bISHNMgHiCH8qNKJOHyexgx8KxihY2?=
 =?us-ascii?Q?pLkdZ3Eg2VuG6rs6TOnEPya/leG15aOZCGplfBLr5BoqHKHloCs51Y4EXF3V?=
 =?us-ascii?Q?f13DTTtp0u23JAYLFgWOwSzOh7Sz4eiPbFO5Q3rhILuYnJEmtnEhiLXVlBM1?=
 =?us-ascii?Q?yHZNbJjAilycsXpJ1+wML3DbEWp6UEmWS4H/NgjBxuhQKsV73FctR1pWPhUX?=
 =?us-ascii?Q?VJPkGFVFs66Ha/UoyIxWHmQgQ7Qlf6Bcv84VzBz832GoZbKCQNcuJSIEynPB?=
 =?us-ascii?Q?8P7GBr4jHsmm7AxkHhaijc3bpQe5Ity1qm9e09eLDrmVn7Lb5I6jFIj2mKkr?=
 =?us-ascii?Q?3c5sotbZ06QVOVEU+PxMF0TW4vpdDl4SDd1r+tyuLzKX+HblPo1HHO5xgHmF?=
 =?us-ascii?Q?TbhgAbFFgqTGi/E0vNAHp6SM4RBv6rmYuu/QUgHdI4xm4MSojMCXuESzCQYC?=
 =?us-ascii?Q?JIXOiR9qSd7XvVVjxaBNj4ZDSfikq9oszieRzfNB+4FPYftjCTjPn8avZj52?=
 =?us-ascii?Q?ZFRYzaotrg+R497WHclqYA12F19tMo/aqSJN/hJLfsO6ZiSL2OpOp0rA5lu/?=
 =?us-ascii?Q?WowCWf1KBwZQ4FNCpcAISjCzjQwWtAhOXi0cmMGTbtYIqp5PbNAfVGte2Rpt?=
 =?us-ascii?Q?aHFjma3hLO3fHcct5IRJKI5Q6woVmjto/+DfhWeb6mjC+ZeXbuFgbCHLggxa?=
 =?us-ascii?Q?dnRjuZjODEdZI4ZVLgXwoubOs0oZgsPy0R6OBsE5OlC/eYq3LPIiDpQ70j5a?=
 =?us-ascii?Q?RgQZh/mxP82ABZxz4rlALzTxYoMWHG/13PB4rnFJXvVeLpj6gEvocsWrWtsu?=
 =?us-ascii?Q?c4/Th+hX3fTVLebBp17PJ3n6pJY0gHgDS4smprLznO7S2mOxGXWlywfeW7Kk?=
 =?us-ascii?Q?TDf7hD8mJwEh8TT9pq+8/YYKEH0XCx/1aGdnG7ONjRAh+Mcpq4rTcjL0A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: iJncCyUjAbJiKLjRiFwb8ADUke9/m0HHBG0TGTQQKEI8IZw4cf/5uHbQfNv557pCcmiRaR/ru/CaMp1G26v0TPXU/s7h5diHA4jOIcOYgVUtEJiWLk2WjMWMLvd6Ftcf6bKQKtCgQkw50GZvIjMYXCQrPfeW9U5n6wEaNNMHXkQ99TMzntqzPVABAWCqvFqXNhaRGx2W2t/h9cGPqyxyDys7TjEdqH+ntil6e5YKL7wxrZfQJrLIkw4eGWiGD9pFwP0fue0yAR+dpdMYe6gH59K0H3SV1jLjxBWHWDxkXD7pyifTj06dFiybYvA9geRD1SrcOcc247swK/KYXEx/GoM4sjNIpMvlL0M/RjG766s=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR18MB2103;6:7eKjFfdWTATDUOBC6hTS5Alz9VcFgSTFJeLymOyWTYPdAsrDW3UQv2Lb4MwhYXr72d6xWBcFKd7DM+dE01ChCoczePOqHLwxzN2j57mtXUh0WL/BUiuRYPN90JJ+isA8M2xcYBvyTTgp2dt4AUINwsQeV0tQUHNKhapxg6SvJZBkfTlT1rp4Vm5p0GrPBS5j1C7dBBlK9/VdCTVcxKXS/AxFiuqWJ3ZHuBCBtFvUnDvD2lFQzaQEo44o5D6G0cs5JZlVaY7B8YGjF5v9H/K/nYi9CJacJvyH5YnfjuYH+RGvnFikENUcXxNO+jowC2LW5boEVRD//K5NWJS7RI393qHvsPMhh+1OE1dXnZ9VJhSRzmtqMHpGnQPnhyneuTj8VhFMeLVlNfCa1FVz+M6HdUCb/pQblkuqG+ecdane3unVsKUd5B6uWZnG/5Lu739UMKMg7ClW780Z1M2hr2kpUA==;5:k49W6ClVRgg/5ySZZDVX5cv1EC2eEHM5jX8hOfWcA/Wt1bTDQfqzXu3ad4SdRVE+QvaQmaEEmhQxMQ8j3cPvXw4sp7rXmydxC7NPAqP3KyP1VQaFzUrf6pw+9SGCUbYKN3V7h1HlkMKg10fWaooj86jBJmuW3yjE9Oq878J36/I=;7:2gLMvA/1bzhDMrq0J6547hiB8JQktElorlqsd9s+D0fLf9wP4+BFoMEZibsO2JDAGh6pFVyOvd4o0MOQSSudoDQBwbQkWZExiCi9eD6ret+IgLzbdxRQbihCum/VtxD2loEE8NYJhkAsIq09opYLOVahdKw1FywQjoyIe451gvwNMXpEd8JQGOgzFT5+e9jf0vyo+wbsujJ5AgIYxsfrQUJfYK7Olw40dFvNBCEWwp3CEug16xzY5Xzc0wSEDESL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: namikoda.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2018 17:59:59.3345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c98f53-33c6-44ed-b129-08d61034bc28
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 214ec84e-0881-48c1-b8eb-7a4034509f29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2103
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some number of systems with lpss_quirks enabled, on boot the system
goes through an acpi_lpss_resume() without a corresponding
acpi_lpss_suspend() having been called.  In that case, it requires the
IOSF write to LPSS_IOSF_UNIT_LPIOEP / LPSS_IOSF_GPIODEF0 in order to
continue booting successfully.

Signed-off-by: William Lieurance <william.lieurance@namikoda.com>
---
 drivers/acpi/acpi_lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 9706613eecf9..c7790ba943d4 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -939,14 +939,14 @@ static void lpss_iosf_exit_d3_state(void)
 
 	mutex_lock(&lpss_iosf_mutex);
 
+	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
+			LPSS_IOSF_GPIODEF0, value1, mask1);
+
 	if (!lpss_iosf_d3_entered)
 		goto exit;
 
 	lpss_iosf_d3_entered = false;
 
-	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
-			LPSS_IOSF_GPIODEF0, value1, mask1);
-
 	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
 			LPSS_IOSF_PMCSR, value2, mask2);
 
-- 
2.17.1

