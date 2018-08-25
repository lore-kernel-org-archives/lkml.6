Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E244208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="m4EP8jRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E244208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHYMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:35:10 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:20530
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeHYMfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZh4ND8MnVhV+fnpHahXtSlare/sMZtqH6X2huHycUA=;
 b=m4EP8jRslBlYo6WQq6ylNY9NwHZsPH6Rl2C7SxXOT29SwU/I+WogmFzuMSd7bFcuKqiiHwTFY8y/9yWSxfsSyo0D55S3EmD1C/OVneUJIb2fNOyteqXiTv1oRclmwquKrgf//DiHZbJdCNE1U4MQ/nDj2fqdlTIgRl6HnbI1lGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Sat, 25 Aug
 2018 08:56:45 +0000
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
Subject: [PATCH v9 3/4] drm/atmel-hlcdc: always iterate over the first 4 output endpoints
Date:   Sat, 25 Aug 2018 10:56:19 +0200
Message-Id: <20180825085620.10566-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::17) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfdcc90a-d5db-467d-3b87-08d60a68b058
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:4zdN7pnwJL7ZCFmHV3I/lNsbNSdsSG3StS44M3eU4RKmynNu5faV4toDJOMwXB1ydf+tfaW6Tj0Js7px+wo+TBc7Jj63hmDFoVls41Lb5geUgN2S+hFgMCpq1do0CcasSQo5FeJfEjs1XT/G5rGokJZRsf1eLawjsLNVjYVr7NEAcqGY1nQdeLA0rzQXWQTYbHg09WVj7fzQqhPoRfTELqiIBSHSs3OkQIWjybem9jfz6oH/UlDr3FrxGR7rkzro;25:uSnpgL75vUNQbMTUfEck3mlrGVAbjK6iQd9LMNuKDHwu1rdxYTeo9vSM91jY20JbT41iDhdjZzOXhbsDDS2LCLajU8urlpOm4u0Ad1/DzmBrs4lZXwnDTP3yPL+IOUAL1L8+hFbqebEfh0rt96oUOtbEyEU+9c9nsedxoiWdTp/KBmx5bUWXg0ItI+ZLn1GhTHModi0FfjaNncegdl+UeXvyq1D0pfuR+NyuFzLFHDuPsn02mqx+K27DsCr8jbDhEQSozhNIBBnRNvoAuLNHLmlR1dQ0/pcll09ITqS3u4ZBhdgfC2yYD4Pz4Gn8IdE/8KoG29FYDuMY7Etk+ocPIw==;31:QHeJ+usY535A5U9W3Q2nTNg0s/1siR6ZVi1+5Q1gGPF3lzJN/DLugb+4TxCgxuMUCzMKJIGrWcxb0wGnVD5BMoZzzmRUM+2blpVCcszGUT3UdVGDpB9jXUTOYPSXGDZNHaKaynwisDDiiyF8KWx2FwLLBmKiHf/it2wKGZ5NVLhEn3oMmOv4GpFYHraJVF6Qls9/xjbthlr+dDOJMFpBUOOHFWlle39OMztmVHQFF1c=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463057D67B6D1E7477228B9BC350@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:cHpzVeFrvCyufnvMz5R2GkJIa3nFWucfWEjtMRt2Fph1qsoKyn7l4jMsEDrbQBnHDkxhZ0QF2p5W6PpxjJuu0hV2d146lPUbPjgldkNmZZ4ZOv/WJrzQOqYcENvp+h+IxY0r+wigo0au34wFAOLMLHI147CvUxarc5swdE8KVCVDZiq5cPRsu5RO6VQFuOdtHLv3BccIpAF9fXDO/6N2gpdLhr3XsMaHqzPGnksbmiqOCrjl14FBobh3xOhIGJWwhcLY5V6B/XcwXGqRdH1+qA==
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(189003)(52116002)(54906003)(105586002)(50226002)(478600001)(476003)(11346002)(446003)(2616005)(2351001)(956004)(106356001)(316002)(16586007)(74482002)(486006)(6666003)(6916009)(81166006)(81156014)(8936002)(8676002)(7736002)(7416002)(5660300001)(2361001)(305945005)(97736004)(386003)(186003)(68736007)(26005)(6506007)(16526019)(47776003)(50466002)(51416003)(6512007)(66066001)(48376002)(2906002)(53936002)(3846002)(6116002)(5024004)(25786009)(36756003)(86362001)(4326008)(6486002)(76176011)(1076002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2463;23:IA5t9RQUr2Srvze/78Oao4o9l1KNjcFhPweGG74?=
 =?us-ascii?Q?n7GZ3Aer8TpuRvrTjzd4smfOXmsYkukSpzD0WHvGq15nIN8mEI4Tj45aN6oE?=
 =?us-ascii?Q?c02V1d8zTceBlQcKwz+VHmCnqYuuVR19vqPzNnt5Sqk6TL1LN79CQ2L9y4+m?=
 =?us-ascii?Q?ecsJM1fdUKhsib7zex5yC3eXJcwFf4jKcFPDIJtpx6QbbnrW1s8h3Qz1eheM?=
 =?us-ascii?Q?qxsINkIPkVbYwZuJi6U4etQ8g5iDf8oyjXU95o4uKojazI+F5LKd/Af3JJ2c?=
 =?us-ascii?Q?dz2esWcmT/zewnjbY3UVfQ5G6WSGeLv1dzBxxsV1rKLKIUJaRkAojw963hgQ?=
 =?us-ascii?Q?Dx7uGk+3OplCPfOJpp2IGZmbi4RgTB8YpqcHjuHcCKVOAn7D5d67aGyNNrMS?=
 =?us-ascii?Q?6DD2a7H31si7eg6W2hhEuX8eC76zP3mVYsN1jtZiT8mNlYqHAhZguNxPSIXM?=
 =?us-ascii?Q?n6XBJ1O3HHhfyxxjGQJIQziq6rjOFe6s4ALdEDJ+tmKlSnAzKrEPpMLR1dNY?=
 =?us-ascii?Q?fqa9N6b8To2umCwr1lcTPeJMhAxUIHlUoJ3YNFFITKP8G+1GpAZlo90o3HXg?=
 =?us-ascii?Q?qApc31vz0+JnPl+Oh3vpqK3wg13I5uU5Wi5jF1BezCTrmFEOFy+w2c5160Xj?=
 =?us-ascii?Q?jzMlv9cCe/n/vgn+zbjjYhts+npudNJfiy5eFMxZl5TFvXKDraKCmpQ5DPaY?=
 =?us-ascii?Q?Ct2J8YNZwS75bqbnp6x1gpZoICmK0FLRH3lZqPZ1wmi8xALssNr8QV5ml4ZH?=
 =?us-ascii?Q?6QTW1KAgnSZMgqHGSRHQitPCTIa31l8wCVh5fXQxvV9E0CUXgT1uuDvYT5Wg?=
 =?us-ascii?Q?YN0qRghdo3bf2nrVqxqu3dzmGkN1TNvImS9Y5T1C31cdIxv8RzkjuKS50m7d?=
 =?us-ascii?Q?SPc11tY74Ibwyn/BHigdnF+z2gjHX5KxWSNryHHJkoNcogcOqR7LSUhs/Ihf?=
 =?us-ascii?Q?SGgR3cN34pt85fu8uHqtkTXoG7P0Cok8CoFBGss3FRtMU31iaG0OFZvLSxvD?=
 =?us-ascii?Q?DQOrLcbqtb7ywJFu5lJINPANURo28hK/Orxx9VX11PUAkfa228fn2hZISbYB?=
 =?us-ascii?Q?OIUeOUanRLsaDGoKM1Ayk/j/QJEJLK/An8oLAJhIkUsJaprvkWCs8QQbAOre?=
 =?us-ascii?Q?9DEmcipxsM8GcRCddFjQhN+ViGiHnZ0SHu87Gv2y0m3j3z23pit+dPWfboUF?=
 =?us-ascii?Q?lx8TOFPUQUYPqLhA9m0qIVPoDi917JyCab5I2Y1wJ3uqFs+sD0banIh5NQ1U?=
 =?us-ascii?Q?vX1bA2Y37kSZksbEFB7ySFZX3X88GfOr92YJpLZpwkeAatyIVkg6YRLm8DE8?=
 =?us-ascii?Q?cW+4Dy1j/GDEV/YMj5AWTxN4rRunf8NTXLrrKH78LC38A?=
X-Microsoft-Antispam-Message-Info: kLNHOP5KE5aGBTnG0lbbd64yNYFoKaQpUHIVlt7bK9VOMZWoZSMm2Pm4Ne1TpnozuE+yOT8XycuW1IIt6CCnGhBWetm1neIjoiOHGsXe5t7Hwzd+CaUO0Q4flmhC8iYpdLxKt2+U776ey7Lv6krWvzKCGKi+ChHRJUtBT8zzOWPZNs8m4TfhmQchZMfz4lJ8mc3IEzsOS/AG07Ng0JvA2hmHmVaTd0sHuwKUCnwsInKqnSZ0eUEHbL4QEDzjSjratJFC9kMko17VQB5B/GJZ/gDYb9bTvg/wjtJM00eEINl5rHqJnLe/XMmWSW+cr+dbXSixKKHpqUIA8BScDBE8FnaRUPLzmhLPB9/5X2jcJd8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:ckZdji3hbFaOt8g52bwQGK3CuBsXPPn4189xQYDL1cqBjHadne6FTf7Jz3KIaL/5lFR6zyttyVfCopU5RBI2aBvS8jXdnAYYpG3TsDLs6rPqa91b+FPuKzmUL5kb7UnbhBV1kC/iUwnFTXbrr6QD+QeFV/QI0A7OwgZ3NbP+nHlWuJ5W4zbEsFnwmXxP/8jDZ919huj1ZBTsSTjtj5NvGb2eWVc4HA/1WXhTCQzw/h1BG7EJ9aGLpG04C00vmK68YfvcskXBCJpdyIkkaXyNMC63jxtzIYzi07NCrf0txZEetETl5W4t+fN9dTCVUoQsSksvBrs88rmCFC13mzyfTRk2IIpdGIxvCevRnWndigKK9fluhakGPjrfpppheZ7w1sVYf6CpyF4WoJ6WZGclFGaVnCQal2vt0pOqF2hA6jTmY3m17iG1rgznLBvP2ihwWzeWeqI2wrxS0f4KecTUPw==;5:+SDi3AherjrkTGaj3zbwZl+8zpfX2me6SH2H7nkLswYARSgQftvlaN+WMMU/CSUDS9KdSn3T4Pt0EsX5xatku+4AamFX+1xwxlWLMM+EsRG6RkV/ceYHz4+B7vECNYxJyjzsnPpOECY0Knh6IFFX/59s9WQaOGGlNTyusbPfiAY=;7:k2eZ6GKwDt08ex1uiqMIMl79tvoiBwbri4U8dK70CZrhHpoic9P7+KTCEEZZFjECShSjHzUXQn3VrEfdlMeBYcMytJbLJTKdsfEwu56/mXHs22TuNjGEP+VLwi2SBE9Vfc8bwc44fXC/lfyP6o7fzfMAsY5J9OUsV8m5opVnQsr90R+05hhSGFOxwdfFXopa5pErW6uH9MIV5YD2JVdzHFj4b7zTLoC8RRr9wfqyH8VkBXlnsjPHMoV8OzkruN/+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 08:56:45.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdcc90a-d5db-467d-3b87-08d60a68b058
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables more flexible devicetrees. You can e.g. have two output
nodes where one is not enabled, without the ordering affecting things.

Prior to this patch the active nodes had to have endpoint id zero and
upwards consecutively.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..c05c2b744981 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -78,12 +78,23 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 int atmel_hlcdc_create_outputs(struct drm_device *dev)
 {
 	int endpoint, ret = 0;
+	int attached = 0;
 
-	for (endpoint = 0; !ret; endpoint++)
+	/*
+	 * Always scan the first few endpoints even if we get -ENODEV,
+	 * but keep going after that as long as we keep getting hits.
+	 */
+	for (endpoint = 0; !ret || endpoint < 4; endpoint++) {
 		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
+		if (ret == -ENODEV)
+			continue;
+		if (ret)
+			break;
+		attached++;
+	}
 
 	/* At least one device was successfully attached.*/
-	if (ret == -ENODEV && endpoint)
+	if (ret == -ENODEV && attached)
 		return 0;
 
 	return ret;
-- 
2.11.0

