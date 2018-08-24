Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B920880
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="sxSTw73t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122B920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeHXM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:59:08 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:25191
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeHXM7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8hS4ozfObn57mO4EE31ECCcilWxS2L3Olh+dJpLtBY=;
 b=sxSTw73tyNqCYu1CW3hBxLeoYYB8lkEmYtJGaYXSvRyzK48JTXiJKkHIsMs75b9670eWW/+cJNmENldDOy34kE8Rb1wh25f8IjQCR3zcOhrL64YcAbL64cv2DMbOtCG8N5EGK9rgDMY8QGJpZxnjcK/o4te40FWQxUDl6rhgcp0=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Fri, 24 Aug 2018 09:25:16 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
Date:   Fri, 24 Aug 2018 11:24:57 +0200
Message-Id: <20180824092458.13165-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180824092458.13165-1-peda@axentia.se>
References: <20180824092458.13165-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:800:90::31) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfeafc91-ef5d-48fd-d88d-08d609a38186
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:l7d/0elew4uc2INTLHL07jNsdbBDZWU36p8jNYt3Gex9CG+BarQeP5txq81aEnxHDBvaTRt/fMVzB5S8eSbs7oB6kwhoKXFRjKgjFi/zF6xeDkOQfHtGJXMx/0QIrO+XLZujJ0jwDmUkKUy1TvvGWLkTfk7P9jY63xAnGQc0PedhiTQAgpKYwaCPmp2ykmBLk+a6q/j5rQOlcqqj5drXxr+5+4N96eSk7ydIq4p88T1vRajqBNQNo1Yc0V0OsAnk;25:dN3F8QCi4w2vq7EyJc2/BVFvJsS/vm/4WJUPcvcJZj/oUINJmLyKHI4IevELwE5BPLSdGAjrPPXDv4ZVsfbkaLzc+A2Un3jQ3ZgDa1rG3D3zHLD7ve44jzBGxUlUTenPRVgOhxX3MPr604VlGE9jSzHiqXFk6Lq0/JdWRL+7sQpfYSEGipQpdWQZBjJR84BVsE4lmOI4UfoUTaOBJ/BtmT5LeVZb6waylSt3NekmCsIZ6BGTgEwpCGPwAbthDUAia/dzfmKZGOg5jHvaXlmFWJU1UDPL11ipNMlqBT6ENm0FqU1Zol0PfTNK/gB1GUmDKBh3uiNLRfuF8uOBQjSYkA==;31:6kfW7J/5HB5J/3ALX/d05kceRGiWPcZkQmCNtu2HwnEEAhR9Vx9ifjCszg1EoebHydsukEb82x+B3t/6oFSfnSCcFFacQrWodbU/csD65LMJXV722U0ycwhpoMFJVUfMWAUHmNIHmqFKS8DYBAno+DdMO2VuHLB/2yoWG1X6u4wB6ZbYicU1+1LYf+ybQKQsLyWhXBd+x2pEq9dr014kfSy1rs/hBYj3QuhA5s0HdNw=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2458E85CF2F4D7943F35B94BBC360@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:759pihfiMtBZh43kDYaZi3qbrxcqA6CGj85pniEq2AQBTLlku0n0UtMRdOtS57yhcveByoS/FeNMLPvlcEo3OI5bUejKs/6crAFDmQmMMByoM57jz5xgn39BEF18tVqkB0/IpEXSmXtWa8QKbqe+OHtYMK3jB28kYpN2gMPMd7YjAzCtn248/XfjkZcRDmbImN7YN7cYgYtgTwA/189gWdwoeb6TobKNmKfvWMFwO51dMruxsTX7CG8lhpX/1TOUXyV2Shc2nJkzKB6e0veOgw==
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(136003)(366004)(346002)(189003)(199004)(386003)(16526019)(186003)(1076002)(316002)(956004)(2616005)(25786009)(52116002)(476003)(51416003)(36756003)(26005)(6346003)(446003)(6506007)(6916009)(11346002)(6666003)(8936002)(4326008)(50226002)(76176011)(54906003)(16586007)(68736007)(3846002)(2361001)(6116002)(5660300001)(86362001)(6512007)(6486002)(105586002)(53936002)(106356001)(48376002)(74482002)(2351001)(50466002)(81166006)(7736002)(47776003)(66066001)(8676002)(2906002)(81156014)(478600001)(486006)(97736004)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2458;23:xRGWuQwO/4VefB3+SXe0U4JAW+Mu5LTUmE5Nc2U?=
 =?us-ascii?Q?0Biv2nXS6SD7YwrcLWtGZzWL45oztE6LljEWTIBXAeA98B2zhoa+NvQgWZHk?=
 =?us-ascii?Q?XPGk578jHBnHZsSv9ozhtgmFljGLGOpMZDXZC52Ad0f5YOWxh3SAE4FWxjYr?=
 =?us-ascii?Q?C0TR+f5ImY01LgtOzi4ZMV3bgbhv4OdV+ElQV5fjL+a6tmuUE+YNMWVcSZf6?=
 =?us-ascii?Q?Iia36vt7zz0uDofF0DYoEUQtgJ/ICHUqfluPQ5n3uuDESUnsqo8rkt1c2Auy?=
 =?us-ascii?Q?c9E9ng5eyMzYg0DCFx+kXUyMl7/UvTM7PBMV9FKubpOID/kNMisSw7QfnYDM?=
 =?us-ascii?Q?dOmwYAhV8CcV9/QO/I/SKU0ulIAlOwuYMQSWs3tT2ZU3g6ZD8SwbYAA0wSFv?=
 =?us-ascii?Q?MeO4zhj0KYXAGmrSSfgD9Oz3HrpihI0hsPey54HEKBWbIsxquq5MACO64SPH?=
 =?us-ascii?Q?0J85ymj5lDP42F/PR9UqI7riyFswrsPNKn16I9ptIf2f17/A5PrbPPg7kEuR?=
 =?us-ascii?Q?x4cqajN6ZdGGRonPxtlYlNfpRFq0/NEd1HOyatfW563TOCoybTYi/PGULI7g?=
 =?us-ascii?Q?vJcjeVz/0jAB7fzVPKn7rhUjnDTxfQIJ3AoOxTNuoOyjiaEDafloC3tro0D/?=
 =?us-ascii?Q?n5p561HA5fq7zbXBOPsRfFDEN7rilVw71VEmkx7CkyXQmUziv0y5YSFLDbkJ?=
 =?us-ascii?Q?xRvMt6MR5ja5r5obXJkaOcC5lGrp2yKbPDXUCj9DqAFHnANjmthtqWyi/GS7?=
 =?us-ascii?Q?NkgprqX3ZNDhoX9EOneKvrWfdJu4vmpn6o1ZdczZD5lMjjQ1/leT/VFqgWpF?=
 =?us-ascii?Q?tUEcUbsN1DeMYN0ffyKiaYYjugvV4FfGfpLG4MFIClW2JG6HepdhVHbtkn+D?=
 =?us-ascii?Q?jeNPiXL811+R3KeXxZGL/VmqFftd7cTsxEulTGn2vXjMn40Qi2IyckbLfbpe?=
 =?us-ascii?Q?Dr/XAvFY+orl3q0U21wx44ZeHIjE60C8t8rr+fxRBgdfleN7K6Ef9uEPQ5jU?=
 =?us-ascii?Q?ebrpaemxqN++m43Jycm5XWwBlF699pFWulrNPb/uBvcQrFBZ9gqcgXSL1Aa1?=
 =?us-ascii?Q?94EdQgIbSxwVd6E+frVrp/LebVIr8Qg/yYY9q0IYJeCZ5ZH4lE6hzWQ8SqP4?=
 =?us-ascii?Q?gbWhbKCdZo47Mww32YZMvC0oYBIOmHKatzWzWGOHFLdrdr2Xx3VR48B8qsG5?=
 =?us-ascii?Q?/bPnsL4p8GBFAUuZIHI1wTpLepMbBLfnITaUf6PWhsx1JIxRhw4itMcqmzoh?=
 =?us-ascii?Q?slS4kdull9rjHAv6/Rpnrs1g4JIjWINQdw36Jvv+hteZFnW4zA7xRkWUV6ci?=
 =?us-ascii?Q?3TKE8GAjL/v40/+8ivJRQxAg=3D?=
X-Microsoft-Antispam-Message-Info: sdok2G+OeEcdQiAUNKzUFvOXeIJnYfJ0VhmBL4SKbblyZXH0YCaQ6iLa01cz8RWthvasTcIUttngTOnmC6rdZDZGHIYfQ+JXQvR+HLIXktwvG9hGCUtbJC6oNNIS7W1l6r/hX3sghf9IRzYEAntYMf0f3mbYjXpG9G358tEJvDtM80KceSalCBBVfV9IvZk/0Oc/cLO+6ud0SaOypKxzoEI3uT9hFF4+rxOYJabY5RHRYx5M7asrtI5x2Z56dq+9PaYgnvFfOT+HvEATPpD/GTPJXgW9UqCFwWGhGkCoUwqJxtAf6eR+zAeSGxU1h+AHEkGDx+qVThfKmeyt1+IPfBRA5VWckf3ZnjdnyVxY4Ck=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:LuoRXK6+am6q8XafRQmppmR3gFxnfNd4w1lwWBUPbaXGVlQNL2ScFwifkRzjxLBD5PghRC3FX6Ty4L0eYtpcxGjq6F84z7pEfdZCm0m0g3c3cgVm6EpZXrsif541/M8wQVfhBKjgaBWEbUQzRU8Bl/AY7t3AWwZ20gPG8eFigAXBKOiiufEq6EvBpv0QdGztt4hpjvKutkZ++dZdGpGigTDnW3XrOjcN8J/SOQqUMtN0cy2lQ7tAaiWt8sC3x2bzHm/X15iTU5LI5bFFTYC2cZOl5gvQ154ZBds7G5IBqrOqvduWyBBu/AqnhJWAyw+784QgkP2FCItAB7OSh6ULnXgILMj1khCmKqcMg2cCMkXGM0EmKN9xpsWz2GGfoeec2d0ByFFwQHJmYmvcjksTUnp/nhsc4hu64tb68+YDBJ/uMIVoZTTnmmZtRIME2JiyExWL6wlxQnpTuMkxHPFG/A==;5:mWEZUIci6EUI+gPU7LU8J8gPeWlx/AHzU48lKVvMptjoK7cdOK3ps9MTg9HTKq0VMYPI1pcxx0T8UrjLorcRTyAENtDzU6mwVYbhRrMJoddT2sY0DekkA0OKSX3a79dF84zGNEOEIh/n9BbuW0rzdXniay0Vyp9U+l3xbyO0C4E=;7:bbBm5J5WOHDlNK4dSHwU331cbgZQTpTZc2CIxHpGsAEzJjqGI59pjmh1mHlxTCBhJtcYNoK0dSe5FjXHiUJE0Bcu7pNMwrACokMkgRxLLOA4ziDJVpYJq5SDxtFfebST2zwk4v2AAUeRdR5ve9HqVbUEVxPEUGKzeq7Bc4/m6Ffd2lHne7M1lN9SJgLWT00Qny6QQqZv5yhKz7856ddNzLG3wOMWer3XJ4xmmgnU2+qPIThpaWs5hXPCBvWbg8NO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 09:25:16.8934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeafc91-ef5d-48fd-d88d-08d609a38186
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the divider used to get the pixel-clock is small, the granularity
of the frequencies possible for the pixel-clock is quite coarse. E.g.
requesting a pixel-clock of 65MHz with a sys_clk of 132MHz results
in the divider being set to 3 ending up with 44MHz.

By preferring the doubled sys_clk as base, the divider instead ends
up as 5 yielding a pixel-clock of 52.8Mhz, which is a definite
improvement.

While at it, clamp the divider so that it does not overflow in case
it gets big.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index c38a479ada98..0d9d1042752a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -101,18 +101,22 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
-	cfg = 0;
+	cfg = ATMEL_HLCDC_CLKSEL;
 
-	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate = adj->crtc_clock * 1000;
-	if ((prate / 2) < mode_rate) {
-		prate *= 2;
-		cfg |= ATMEL_HLCDC_CLKSEL;
-	}
 
 	div = DIV_ROUND_UP(prate, mode_rate);
-	if (div < 2)
+	if (div < 2) {
 		div = 2;
+	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
+		/* The divider ended up too big, try a lower base rate. */
+		cfg &= ~ATMEL_HLCDC_CLKSEL;
+		prate /= 2;
+		div = DIV_ROUND_UP(prate, mode_rate);
+		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
+			div = ATMEL_HLCDC_CLKDIV_MASK;
+	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
 
-- 
2.11.0

