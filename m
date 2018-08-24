Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF320839
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UMUB4yQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeHXM7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:59:14 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:45074
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeHXM7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzB0uGcWewxXUwe+pV77qiFhTDKg8BRxuxM8UkcczeY=;
 b=UMUB4yQVFSU2f+fgfrovi9dn13+5YFdhAyU6sWhydbIzTGUpR6iyNS38Bifg7+y9R6JRpixafrwEVXeLBcmS57zkWGtA3Ui0OcyaD0X+f6LOR/mvMaNROxibKZxE0V9BUzM0q5XXhabu1+722bABnUPVFwX5zb45X92CmeuVPjQ=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Fri, 24 Aug 2018 09:25:23 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested
Date:   Fri, 24 Aug 2018 11:24:58 +0200
Message-Id: <20180824092458.13165-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 15dbae05-a1b2-4fb2-6121-08d609a3854d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:fwEMpswvuf4sb8BbjZc9baCb6th49Z3NijxZzZai7X7Sv5CCSCVTX6AC3PMGQilQW237VH4SXlSqltzT2J0V4/V1G4noNJA4P28fECUHmX1jPyuPEe1lhZX7dJuyNSAEk8YHEpbTTW+2xziUC0XmQdDPEKxaTGjovoh67K2CyHmbhkIwUY9i7iWlc/O0XZ2ey+DJZjW3FWWfGlSaDE5gqUBiSLHTbHcQ5qVgzqrna9RZVY35SwqUxMkhkkoCILpv;25:/MyKvfxQBFvzPmV1ISw/k3OVDH3QoUVKwyzus/dGUUEfD/A5Vg+KvN8BJYTO3WNyGkusWlGE0taRqK7tgvvZQaT0UqY7JWPKuppPpGi0+z7+n2TMRp+QqLqEqz1Eiuu4dHx2gFp+OdVoMWvFC58e8Jr3YP8tFsNyLFUGW0eMBCWwu5r/1KdsVFvfUFTc8/67R/2HyA2kaUYDB16RnvUnrG4HpF5jm7JhN7cQWx4KGs9pss4GsQ+xVQzYcVVQFsAzyB7RHBzQkmlhyzjIV/ixm8n4D/0rU8qWQ4cG2YPQmr9lXGw1jfLvM69X6EsmGEFH8CECNHvttukG1Da0GUwfww==;31:K0oB5sx6ZTHsDv6vuINISp7Xf1rIzk6siQ3sZ8j1Z7uPAU1ayKbYIaF3YpZSfSccmVt8Nr4mt4dH4upjHtETeV1Xl44OTwSlRviA/kRsZbCVcaTeeSFvYxMo26n7A/L7ZuQPX/lQBQPdNZJFYCsz/n1riKu8npQHt0YRWJm6QnMmzaPca4G/9S33nV6TeMwej4QnXUQ+X6Og2aU4qULTSfAMK0M/GhqHqxbTk1oK7To=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2458FA2A7AF373C559013080BC360@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:n08GLvLaF2eNwc7s9oMcpTwsUR+h+SuNuaxo3txTtVtsYcA3Tga66nU50+1OTA1FJfF+pw2ZOFKTPq89F4efWrlWsI0bn6UMs+OLCoJk32eQUrbrVUJa6dJxCLVxqeQYZn4rxvoUXJDa4IkmetGIoWoNwqEy3PVzhYmF7XNvR+2HetshFwoXT1/9fuouKazVov6dZdKlP0r/7hHKMAONCzaN7MtKwzM4Slfn32NTBYJAho+5qmupvCpR13stg1S91Vrn4fdymZ0jWhOOhcHl+g==
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(136003)(366004)(346002)(189003)(199004)(386003)(16526019)(186003)(1076002)(316002)(956004)(2616005)(25786009)(52116002)(476003)(51416003)(36756003)(26005)(6346003)(446003)(6506007)(6916009)(11346002)(6666003)(8936002)(4326008)(50226002)(76176011)(54906003)(16586007)(68736007)(3846002)(2361001)(6116002)(5660300001)(86362001)(6512007)(6486002)(105586002)(53936002)(106356001)(48376002)(74482002)(2351001)(50466002)(81166006)(7736002)(47776003)(66066001)(8676002)(2906002)(81156014)(478600001)(486006)(97736004)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2458;23:5cl+bJ708bUwTAIA5dXXSjLYaNNSNZW0aafmZYl?=
 =?us-ascii?Q?xflfyY6TauRYmtOe6Ke/OyZKc1n8gay1pGHkAlNrC72X1jAsSZPGGBvCoY+t?=
 =?us-ascii?Q?JIA9TZiha15N1SaGpbb8w6WQo/h7FKf8uhlo+8EHHh3k2KBrvYOWWazku0KT?=
 =?us-ascii?Q?lQiWpKc5vKB5PHwjAPaQj+NWrbB4VuaO2w2AhZwcHOEogKrNRevEN16YWCUk?=
 =?us-ascii?Q?ngFRNvwq/oaSQtheUnF51wnzgQkX1t4RtXZuCqmWmibrVTXWK23HKsz3n+77?=
 =?us-ascii?Q?npDORYSWZbteJUfiHqIW/tuXqXlcfS3un5LwvJBff73TtRXW6XtX2KFQOUxw?=
 =?us-ascii?Q?AIET4tZBuKOtcI9NNAr8/ly7zJl9xSSGSEqWK+GqgKk6bvn+yEP08FY90RiR?=
 =?us-ascii?Q?Kw1cZHTo1M5GHUHKLhJVHxNWDITb1a2bvt7EpbtTM1Af3oNhswcll76g8TJW?=
 =?us-ascii?Q?JN7taBAzmHqF6zk0DIRth96K97BrjVuDOn9BggUxhH/q5hz0Ux54MpUCNwl1?=
 =?us-ascii?Q?gxR8Kc5ARRAhf/nAzQB1xicDpiTKsk7zgbR2HTS21McjOh4dxEwacc/4Y//w?=
 =?us-ascii?Q?eKDtneFRHhIQ12QzBuoaod/4HpYl8cDEF5xjm91ofKPqrRyeWJUmYwL6Wygx?=
 =?us-ascii?Q?zBhUH9ujKZ2R1JZ+n++dQXXoGNPwCfdva4W7Jnmug7mSd2bMaY6VwtzOw2Vd?=
 =?us-ascii?Q?zxoAjMhHSsOOPp84TNMDYKd8WpfbPOPzdjb4Kd0cHQKEFDgZ6363cxWd6XU6?=
 =?us-ascii?Q?99VHAfZV+xInXdJjzM1BXUm+9hLnO/qQjm7/R3EtFa/v5ctdoMsxczfcuKtv?=
 =?us-ascii?Q?8AIgSH4Wezk/20ZQtNyZfq8aO+IPoTfWjTdXvF0N4ovedRGCBlOoK5aWYtRu?=
 =?us-ascii?Q?rMZdCcheBJ2dOpLZZmDb4zuCg/Ozy8JI8u/6qYU0dPmw8EeZETqNwLH4J04j?=
 =?us-ascii?Q?GUW+7rn30k2IUxBBODbuVTaZq5J4ebDR88ZdJ8RBmZBAUmC40EU+R7Q8+TNq?=
 =?us-ascii?Q?/RpIDuLrhffOFq4inJcW4052NgAM68l5m6fVpfkalcaHe7zzsgcvJJiXjGKg?=
 =?us-ascii?Q?ZWOzFaCyz5NRfXBBDFGdxsgcb6TQCamaV4tU/mY/YdtAWDAp0hPVKSGbfzW8?=
 =?us-ascii?Q?p2j9CVXx1dpgaKmP1NBz2b+Q57oEAxvQbijjwiQhdkz4gwWvxEO46phbt8Ee?=
 =?us-ascii?Q?DUxBw/hjuHdbRu7DD2mUwj/Lto2/01xWMxwPaRf7+0poTgSqCJR6q96Up5uZ?=
 =?us-ascii?Q?MLjPungcaoxtHBtw5F8Sw/mKaGu3C6BdCVqyJmIIU1ux8aICV/4BDS0GJ410?=
 =?us-ascii?Q?RjAI04uA44ZmSW6nxiHFbR24=3D?=
X-Microsoft-Antispam-Message-Info: dzalyR95AvG8oPNksSA69/7R5LpJ8ccohItfACjIeDnpdp+/B7uhp/XmkyPHiM0dfPfE0WdYikr8uOl+AZeb+Y/nz9voiIkX6HyAPaDhb0s5XtSWCk8EbFhWhHQpvnZRPlTQmnnK/lhaHFc+R+CiFD1HzIPgIA6GQ6cwexSEqFROsfzZNRFCbdn/aGbzTnoqlc63ySilNzdbnjNuJ2MCGqvrkNYJMvUiyq0OJQjxeRhumjcll6MsqThkWZ1pSj9OANevBwGaOJQGVzJlnhDwUNDK2tA+ZQEDq/38knXMLtRSUved6P2GuQEDDI0amnMhuI8QZuN3QDjaF2gPRnmdq0ADT8QgZjwR+H81UcrzaIg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:VpDRARjYt07wFloB91NjnX/625J2l2iVOhbuRaPsinJ8TjUbj4EDS2UizksrpbaWpK38fmr01BjTQN3Z2QgeuZNWZRKI4LM6Oww8zKcCD/U6Hg8aC+6lHS9K8e8+2DbfKFORsVbpUhtHhl+gu2G3qo8yv2CF4SHkRB8eW+lwhkfSUT2/mTe+JGzYrFM49PWFH5j3o8UbWVtJbuPpWjHQPI6nmGiFD1uovc9uDN7xgNIzmw1bgnJUdj1DGgPGWrsEeKvqh7Kq7L77npPgfdFYnabuSjkjcMnlNtXJory5l+Q/T50rp7n885YOu8v8/mtpTz0BRFspMX+x8/imRFiCCgB5XDWF1aSqGUmD60JLN77ygsqe2i3Mkv054LV9fhFTJif2vaxX9IVm8eVI6hamc5sxdbB3UeMnaW/9/LDIJZZc49eYVeZLT48ySkte5wUuLIQJT+Q5nklZvSnyzA/AUQ==;5:7cKQRJgQ13CgLzgfGz3ZcVTueFWmfgZ/bQu5wvk3mSml81YyPUNTkRF8Eyszu7L3wPxLU5ugaI4fsEs/t55FCLZYqhu+Yz9LdixrcXlBlLFj0oZv2AjxKl2hZX6ipfjkqRHZD/PhEN26qrcLArWIgsdF1WayVL21NRY8ELWGmVw=;7:7ge/vs5oTh1ykm8QFsGAij5ltQCENHLoq1KsyauwLshuvkWjolOmp2buTJPYq/9WJ4ypZbi1WoRlo09zYafouWiMplVlfY8GAPF1kgCgY/wYUCQueiAZuToB2dP86UPAaV6NPF7To3gy4A1TZScPcs2Fw3qF06DiRbxijdz599IMuwNnM+EMMmhH2ODGVtEC2JLaPmCJURVyG8+O0NTtg1GgP57oasgt71naN+WGvN1Wim5QAL4HRovYnASl4pMY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 09:25:23.2327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dbae05-a1b2-4fb2-6121-08d609a3854d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But only if the highest pixel-clock frequency lower than requested
is significantly less accurate than the lowest frequency higher than
requested.

I pulled "10 times" as the discriminator out of the hat, and went with
that.

This is useful, if e.g. the target pixel-clock is 65MHz and the sys_clk
is 132MHz. In this case the highest possible pixel-clock lower than the
requested 65MHz is 52.8MHz, which is almost 20% off (and outside the
spec for the panel). The lowest possible pixel-clock higher than 65MHz
is 66MHz, which is a *much* better match, and only 1.5% off.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0d9d1042752a..9e34bce089d0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -116,6 +116,18 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		div = DIV_ROUND_UP(prate, mode_rate);
 		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
 			div = ATMEL_HLCDC_CLKDIV_MASK;
+	} else {
+		int div_low = prate / mode_rate;
+
+		if (div_low >= 2 &&
+		    ((prate / div_low - mode_rate) <
+		     10 * (mode_rate - prate / div)))
+			/*
+			 * At least 10 times better when using a higher
+			 * frequency than requested, instead of a lower.
+			 * So, go with that.
+			 */
+			div = div_low;
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
-- 
2.11.0

