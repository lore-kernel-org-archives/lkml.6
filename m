Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DFC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FC2186B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="E6Nqv9TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4FC2186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeHJPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:34:17 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:51891
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeHJPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDxutFTwt6Aq9eAfDrVPglp75enktPxsSdR5mA48ads=;
 b=E6Nqv9THp3Jj0KD87qwCCDhISNtTdpK3+k7tBfej6ilHkCafvcjUWkSEMFbl4uqmFIdKQE5/z2Fd4QDKnnfnPvCPmq1hq5s7jzUJu0/BG/AGrWCFRfUu0CzRfSLyzdbKd+sdRO8l63qCT/IRDJ4kD0CGA/rlQR81mhwQ8kx56Pc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 13:04:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
Date:   Fri, 10 Aug 2018 15:03:58 +0200
Message-Id: <20180810130359.9882-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de74f84d-9f9d-4a15-7179-08d5fec1cb6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:zL38bX7JZ7ry+w/lc//Uhk4xFrLkCs1Ky0+fVxJbiUv/ULuQ3JIRMxmRDNmVLIlPCqKafxQc6pCoqPzx+tjGhglSEcTXhmReqMYuPTx6yEEHRjgQyLsfnT8laENq81nj1Ygxql/3yjFUZ3z/G56NXTAfDZ0w0GG4nJ3BeJL4rGFIoUzBtYY3aPpfHDahUec73BhO4VmMlWyCLqLZOtsP0zy4CUAVI1nUmPr3/S7U3BE3seMQb6AhxLW7l0FAgrjS;25:6wzAaZ/QiawFHNFfHvlNy/1kOE2JVjRuyPw0bvshP7flQ5fJ1pe8n4fKbOWHx9oinUTl6OY9ICbXM4KmMo13apjIva9J9HPQrsSlL9wAMGCFxHChZYabODsOUlTCemyKVGrLSlI5Shbo8DZ9yod/uA0HvIRaQIo2ku35u98y2jqpQTEKDchaagud45hbUZhJZ6uRhQkxF2igv7inoNoSSpH/mGfOMB0hsPYdkpUgEtiIpaqFtg9eYOUUVNW4ae/8O8PeXFhsY+QXII6zJkeNjNHyC8carfuR1oDrbF3Qzy9ESyKvfzzBO3MQAGQZ/E3DJ0qVmrcG1zNGruqQQGrhng==;31:UEeHySlpq7omBwTXm7KIkZexz3hSlO2ja7RLLI7RgRbWKjkRjUIfYOfRzsQ9QjnQFHwEqLv+1aPYN3cA/4Q4IIs+AWqtwunEXtKv67F9sQiPRhqvsM7JQafDUhsr730QG3QKtYfhz/H6yHtJnp2uQ7dXQN1kpF033zsh/uwLlQu2jHbcib1Uc8gDI833P1h2Ij8ZECsMVALGW75/lzZvSA/Peuz3BI6W9yh5shGezPw=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246422190DF4E5FF3D701DEDBC240@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:OC4oGhMiVWszDKHnX9e16UAycCIc+1nIMyLvbcWjwY2cVZO72o59PwuynDo6Wgk87pr4IVDcjlLwnFngokIB2k4k9VHIglY1ilJWg5ePnEPa6B2ZFDvKtZmF+R3JhI2fPdj4e8pr0ssRy5BGpYqHdBxKjORh1ks2GUCcMkXg89Bv4fI8n0JbYZT125hED7zmsyc45U6C/iwbmUY+60hcuIikYuqg78sXWoaUDOBd1BkfaD7Rtnd1Ss5LLv10oboLepr8DDq6gE1TcscvaFm8CQ==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(396003)(346002)(189003)(199004)(5024004)(66066001)(3846002)(16526019)(50466002)(74482002)(50226002)(36756003)(305945005)(47776003)(8936002)(186003)(4326008)(86362001)(26005)(54906003)(48376002)(1076002)(6116002)(68736007)(6486002)(7736002)(76176011)(16586007)(25786009)(7416002)(6666003)(105586002)(81166006)(81156014)(316002)(8676002)(478600001)(6512007)(476003)(53936002)(956004)(2616005)(2361001)(2351001)(6506007)(52116002)(386003)(51416003)(5660300001)(106356001)(6916009)(11346002)(2906002)(486006)(446003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:mPHQRIAVEX++CmlYWXDKqxFG74osAdDDOsRjEdk?=
 =?us-ascii?Q?9HkcS9IyewvXACGGg81obQfY0DhYsuY+Ox3EfSIIo1fSLN0bHVxiw82Zf0dq?=
 =?us-ascii?Q?u1YqGNwjwESPcs+8d5uqWREsemQFCiiCLojuG4Byvb/z9F4MGvoRGXK0oI9+?=
 =?us-ascii?Q?HtWersxogeq7aIxPnbSQOvDai3QejIHXew/ius++3c5gxckTqMRJHiLew3yv?=
 =?us-ascii?Q?7yiK0S0gIUI6b3eYls28O+OXDhmqwRPhaOuyxIyrhDj381egLtZEIPSQ2dfN?=
 =?us-ascii?Q?Hg/IEw/esCDjQz7btt5HV+CgH7iXCWf9FmAU5ZWqzCn32D5C6nWIn4ts2MPX?=
 =?us-ascii?Q?NYmwZjFTN5hCm2cf65RaLZ+KV9ftGL/MeOEJceDxiku3OXdRNkpALijdTwXx?=
 =?us-ascii?Q?BEq+3mhAt1vcLgN9uCDsPy/4wkNZuQCLwDPHrEaBvxZQlLaKsCuc9faY06Ot?=
 =?us-ascii?Q?GYm1+8yCnYIhD69XDfhFYgGKCtFqButET+7Pupm0COxmklXDd4kDtn5kEPXe?=
 =?us-ascii?Q?+ecbs4LiCmlLyoDKYJj33t7L1zOyKg83nUB0uCprPBBNAAR6jOnG57NEEI+q?=
 =?us-ascii?Q?RogwGvUXirAWyw6Gz/pKoO5TdR8V18pPL7Muvp882vshviPMOG9hCzp3+CKV?=
 =?us-ascii?Q?uwQ0u3jRMQcxYri/bOZ/AHn5M5ERN4W1gQ/S0vhw4HDCcsMjGTwm95ZQhv+M?=
 =?us-ascii?Q?Z3/+cZIuXr9xuNvEXg5T+9E2akhXGxPElozOOvpfyg6TD/0HTm2v8HsvJQQ+?=
 =?us-ascii?Q?7rjnStBaAtmpo1Yu6/IKiJFZaKy3ttof/7Htvame8wWY5TZfUC7GdavVAAET?=
 =?us-ascii?Q?922BkDXOKSvCJ9CJovQdWeIO8YbGmegf9CSBD53NL82wS36HmchCvfBc0NrF?=
 =?us-ascii?Q?XjXYFUvks+yklkavYE+8ql4Rk8S7ULXqzfWFCjkK48UvsSNd+wUjjIuM7hEf?=
 =?us-ascii?Q?YzuP8Nerm5LS6Htnm8ICxpZiV7fQueb/gjEXag672N5gnVvXq3UMJdhovUPb?=
 =?us-ascii?Q?sKxUog7gsorKi+pN/i7s81XL5q4lulIWXo5LNXIfUfumhX93FUiFY6lZ52yV?=
 =?us-ascii?Q?7H/R9M0oPrXGIJRQuQpNAiJvAl03YsA0j3/gY8o327aQDnj5PS8AmaoRIAxu?=
 =?us-ascii?Q?rvXg+EKxenneqWAcMk1uL4lTmegznZn7Elt/zD19HNHknspiikmFudDcgRtL?=
 =?us-ascii?Q?6ODS4X9NsxQlmZ7dAD9eboox/mev0IMF+05sOuR436jLlfVjEc75Mr2zVWQi?=
 =?us-ascii?Q?WLVQQegUfFYWmxXF8K3M1jLeK/yaUL+nUg1jtpKw2oVuWvl2Yl7+ncehKMGq?=
 =?us-ascii?Q?kpO3eOWb1jJAF/AyVeMGv7Yw7qc2/kQeqfHDmqtIDtlzw?=
X-Microsoft-Antispam-Message-Info: fF+gR4iyeuN7cHzcAs2dy/eNY9p85w9K3d7LoA1a9fuQqRHxv2Di42R3Dl+eXpmIBIAIxTa8+ALMHmt3g0ESJ2t/wLLMsI0wNteTihGv5nt+nOT3VM0Yz6A7anymH5kZR7mMBk2iW/evQ+9xt7PYdfiTDV9Z45rAccsboUiwstH5AS6xLua+QxE1/8BHAJUhBUu9qPdIOBOjXBNhEP/PZdLgDh7MDVCKOB4Mst8Tn9TgnOwC29EKaKl4je15w7WvcXVl26SgSt2emgmq8/JtlhWjrMnPMI14KFXLb4INb6OhkmWKv33oxbkdqJrxLGA0X+60WCuLq5JNTFXug/lW897Kji3GzOgKnVeMzSpe2TA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:8rFCHihv2iKkjv84bSyP00IbOuuJfJ0brWb5RgOhQBm0TDlaeFXVxWEbBXmLADhKeeyrrNVz0GFeStpJ1Pw0PT5wUkO0nIXNXA8oZoEMkKrEdTrrif+Q0w4aCcvymhMDHupNT3MJnh9DC41jcldQ5GoIX4uVykDOWYyWBvKrwwItgWL/JIIVbfjhU17grUaN6LCiLik5rcCWgBdMRPyFgyGeTMsiGiEWYHByu8HttsfVhGaaAp61mFq9hKs3YDX/rHHieqDsWRTcVf1HSEG/brl6OHWeFY2gMgLu/GMnm9CS8BfYAoUmbd+DhaxMR49Hzn1o9Brq6OeTfxbP1926/WUhA5ep136AzhrglH1ERisKziILAsztbKrhveKLcQqry7HcK5hv2/v9LNHNS7/pP4bn59nreCL8AJlaDu1ifqv4asbXamcdQTL4gk9soVQLBzfh8INDO7SQb+4Hr3ObZg==;5:v8jHIecMklhbIcSHNP5YpA+oe0QyMunEtClrIa+qDqk+FnIEkdtB8YUcHwc8ipL8RwYQEkvLoF7O1lUrgvg5l6JnNxEZIq7tjWahao7LUYOyqsC4N5YHQhUrL2U+XA6E5m5QxMQSpvslE3zNNMJMuJR/al0uR8K1xMsMIwcJnvc=;7:rrnF0swFmg8192CEOALScXq89e2qBSLx/CMp0Ub/8v2pUMK/q1CurWffbBVeID9dAYE/6/sUfWpWOknpiIELWAv0wtwiBANzWHq0PTQTd0mP1ojWy+A8qgrDS2KN41aElYheG2FIKi/JvBhROoI0+2liWNjWweJR01akrfK6hnZdHv2amHd8x8si0wCvdrnFwvnoDoTHjJeLXkjdgbDPUESow9bjjaoFvQrIMPNpF1uH+JLtro4yOY64PsxX75OE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 13:04:22.9889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de74f84d-9f9d-4a15-7179-08d5fec1cb6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables more flexible devicetrees. You can e.g. have two output
nodes where one is not enabled, without the ordering affecting things.

Prior to this patch the active node had to have endpoint id zero.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..16c1b2f54b42 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
-static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
+static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
+				       struct of_endpoint *endpoint)
 {
 	struct drm_encoder *encoder;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
-	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
+	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
+					  endpoint->port, endpoint->id,
 					  &panel, &bridge);
 	if (ret)
 		return ret;
@@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev)
 {
-	int endpoint, ret = 0;
-
-	for (endpoint = 0; !ret; endpoint++)
-		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
+	struct of_endpoint endpoint;
+	struct device_node *node = NULL;
+	int count = 0;
+	int ret = 0;
+
+	for_each_endpoint_of_node(dev->dev->of_node, node) {
+		of_graph_parse_endpoint(node, &endpoint);
+
+		if (endpoint.port)
+			continue;
+
+		ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
+		if (ret == -ENODEV)
+			continue;
+		if (ret) {
+			of_node_put(node);
+			break;
+		}
+		count++;
+	}
 
 	/* At least one device was successfully attached.*/
-	if (ret == -ENODEV && endpoint)
+	if (ret == -ENODEV && count)
 		return 0;
 
 	return ret;
-- 
2.11.0

