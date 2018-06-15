Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0E45C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6974620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zh8youV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6974620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756247AbeFONwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:52:34 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:24662
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755699AbeFONvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5tjRgNHa1dHn2bq6fceXwpESXgYpV4eXinA5NNiuDQ=;
 b=Zh8youV7RaNidxnVSgP96SFSi6Ve2Y6O93ExQ/Fxo69plmw4cYLc9zvY/vioRLiwcy+HlyN2lnZx6ZCSUkqelKsWf+hYx/IIAHs4a7HkL8/1wqlFb/MoNFpywokgybrQvXQ8lAP91jxgoyNLltfsyGrxFLqB9k5RC7PVtACW/jE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Fri, 15 Jun
 2018 13:51:47 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [RFC PATCH 3/4] drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC modifier
Date:   Fri, 15 Jun 2018 14:51:33 +0100
Message-Id: <1529070694-21088-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To AM5PR0801MB1378.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f181e47b-c741-4dfd-0173-08d5d2c72371
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:aAS3E3mvRJmezKw6IwrswO/LFBn3iKdC50pc8V4v6eq12L1stADvlYr+vDIS5SXzreMBcIXXbKoFSE87+DuQHkt1Z0yVCMM2aEO/JUEKbKhtK9UFezbO9J5BZvM4KKdSZzgQO1L2K4Xg/TUv+uGE8p4jZQH7zUzFD/NTgVJgKzWCbx90K+77Ze97ujVSWi8WJDBJv3Hpbcz7w5sMyUapBNYFPZjovkIlzl2qa9GkZGqDJAdK/ORGkAssof0yvcdR;25:iEh8q6pwep1ynU4crAG2sYzi9bR/OjT+5VvotA47/ABVqK1Ni0wIMmsqtEs9S5TBzVmURGZhrLSUgAPYHVGL5ThBiRbKY7t0g6Qm8cVqyRwQcGOfofhEH+Rf9sm7CRo+M4bHVO8BiK3McKa844T3U3wwCU1Xr3qfJCi37MsNPLL3vC+7yGAj2U1wSIUMGkhjTlZIUiekeTl+XZt9NEi02A8gqJOM74tOu3hIPmxzWlfacjOKAquA3E5/PzW+gOeWWqbR5sP6sGNdd8ozKS+0JH3jEZNFKMWEjxx19zod+C6SBG5ro5jNm5w6bEuOR1paPMH43JpIctSq8n6cNe67Cg==;31:E2tR7D6K6LYA99IRv8IOrQnXqJrE2bM3+PEI6/EXWE7HB6b2bHTLdfsrtsWq77pQw6gCMJkMq7Utl+AyWSBQ6MNnFN8JkH0AC9VX8Hkruxe0GxT1MGpJjS5J/6iGx1cmHPqsJEXFMz8v85pgkjC4lOXt6B4xyeTZMfg8VCvuFc9THF0hpFnYVmQlfZFy8VC4nuwxCj4HOkqanGhFIdAptK7H+HdCXkvZ3uCh+1+vxsw=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:3AMknzahDFJcjDJcXKBPIN68deDu/V8gUBUFzdfnP/V4G9w/czfU+liocv/iMEX3Hm+ct8G3/4nbG8wR/Wc4dTAJyDs0c6BQvPqfvyxc4C/4Qbvy+RWulGr9BHLBpZhpQnEncXMwCHhqJXbm3Ek0zc/MMcQjAQsRwM33BOWCiDqyOstqYsD1su+ka3hVmpe/j3i5Hr3lXP6VwY91Np3lOIlrsYVBRWmdTamrLqN2921jDg+y6ritPJL4nOKf6RY2;4:/BRRzJ4zd1CHhH3YLVdQVZve4cnsdKP/6rWclbky8mRMJWcx529R4RTZRmHVEMFE1pTkbdIJ8V7J+pkABmb8nfYY+/3JP4Vkrb3SKxuELOLMfOkRkzIMqHeHfMpxzM9G4ejcGhiGMl1wgPZdrAjgo4MXoNJyQ8ypGLov723Z59owLyIo8ve1l31yYuP8YySDgesieO/bVAYsmuajddeO7kbULspGztIcfDE9Okntj1Q532ws+jxsQD8onjMfnaUasS7LVRkZPOtv73vw4HnqCb5M/EWLrzhhG/SAhdvSzmZFnvu7cGE2oHuYEz3o5FUj
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1378A1EDC9C33B733F0C6F6BE47C0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(2616005)(2906002)(476003)(5660300001)(47776003)(8936002)(76176011)(97736004)(7696005)(52116002)(11346002)(51416003)(7736002)(53936002)(59450400001)(386003)(446003)(486006)(66066001)(956004)(305945005)(45080400002)(26005)(3846002)(6116002)(50466002)(16526019)(6486002)(478600001)(16586007)(68736007)(48376002)(81166006)(81156014)(36756003)(50226002)(4326008)(106356001)(575784001)(72206003)(8676002)(25786009)(86362001)(105586002)(316002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:Tq2Ttv9oBQfpv8ZC8dItLT7hfd0GtaBipcipazA?=
 =?us-ascii?Q?ktdP45zCffrpxbBiwTJH8cWEn9+HibKY62Rztt9doOWRa5EPE/C6Jz3nK6hE?=
 =?us-ascii?Q?5buDAFgMf7sBiKb8VXvPps3MOp0tEzMQ5zuIAtHC8oi30UJQSidhdtljjQoo?=
 =?us-ascii?Q?n1qHNwOLTt/XRKltXUmPeeLAcGthoWN2TRmlmJFTGHlveBeCUGe00ZSiM8Wb?=
 =?us-ascii?Q?Eacei6y8MIYSSsvYzTBiVF51jxdXoDw3X49+wIWzA7gnc5q5H88qWdY+ztin?=
 =?us-ascii?Q?zJrIBwZx/dM7L3TtAFzftQqywzL3CB2/ugVZg57mqc/eWjBtdc5d40Dc5UdF?=
 =?us-ascii?Q?3WSE3xL/qbSfcbSp5U8rJAMDC25Md0oDaPqUd/RimRnaloElK7s1Kda8AYgt?=
 =?us-ascii?Q?h5OhAOUwhsWFnaWq2xthNRatWUW4hWDIDZ3peAAgno/gmmkPxmzGq/wlKA+f?=
 =?us-ascii?Q?bLS/If9WBP70uZ+WW5kzAjb2ZKii+rTzgoLPifqDypPkYsHPoJdOrqA92cYk?=
 =?us-ascii?Q?eq2zZLdIYma8m0z7ZgVtQCxm1VbWYzmdtBNG49Zlz71G6hBfmrW7TJnrupSg?=
 =?us-ascii?Q?X4ToZke1+HxiTkrKNLNgyvvzELl3SZG3I/ArTS3fKPd7djHTjFXuBk3pIMX/?=
 =?us-ascii?Q?bBx9DSwoD3TL7nfYPe9+KQ8oEsDXqs5mo9Fxg6PnL5YL2kpsKjTBCNbuWXdo?=
 =?us-ascii?Q?8HxAeIjMTt1ZmWLSlv4u2SO+c4fsdzLqQAx/d9E9ba8Ed79/5JS8yd9Z0xJI?=
 =?us-ascii?Q?YvVuQdS1OV7BCJzQLWs3tdjVMF+CUwILM9BP8qH6hXJlGaeP+5rs9FJ+2yvP?=
 =?us-ascii?Q?NLZe18EFOh8tqQBn1+pv9Z1kf2Goo1TEZIRK2YQyxB4+49ZVf2yvZcM6PBdZ?=
 =?us-ascii?Q?xaGzEjaiUXAYT+SJW/pRQ11+72YRlPrKUmlnvhG4xM2wFm99FpQYsmgwMk2Q?=
 =?us-ascii?Q?6CYd5VdKr1M4Lw+H9BPseDUNBWjv6hsKZyqvGuAurInjOQ3cEQBeqvwfRvrn?=
 =?us-ascii?Q?nc6+MnW1SSSc1fLdbKTFAhmBnnaFTmKvQ97to4ZKHvZflrnu8Siz6LQbhwLG?=
 =?us-ascii?Q?QtAi45LPUjgYYzvHRW12V5WRRtWADCoCQypcAtf/oYcISLLpIJd1BKtklQol?=
 =?us-ascii?Q?Vo8oPW6n6tb9I413dC5O1+q94o+AegVY2W3RdYGgxkQeSXM7T3IbLsTERMaX?=
 =?us-ascii?Q?jEBIDkBPiGSQCKDYe5UDO/X/PMzZMTIp8Yy/Tr3c5wIsb0q9IMUHI6HIjFGU?=
 =?us-ascii?Q?zOgdHffTSbPpdqP9UtEU=3D?=
X-Microsoft-Antispam-Message-Info: yHRzlK5HRgWibdVNYH5AEa8ZFZmpUqdTkYEKwg47CkwKqHY/Hhd91Nv+N0MCyKFqBvsJGX6oyiuadZtJDpdPe1PMfJu3Sd4ssHFJX1w/iimgmpQWXc/xBdC++WCNjIh91qASlt+7mkkrVKE7RRn4QwKoJnNYdmzAHWvEB9NG8Qfw8AGO86wifK/ETIMdvKmJ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:rm91ERkfTUFGCyRLoQQGLKWvvEgEdjqxm+DdIo8Y4ood5wP4tI73PGhFWtLhoy9mScmJVvARwnde5ZPZW0YuR7DdmSDXAitb4Rs8LxEgfHttRiaS5U2GE1QtOB2gbUqT65oIFwYjSzI9T5HowP1/j0YhsbIE7JGtuY7SB1jrce/ottadmp247bPgACi3sxDG/HrGLOKf9uiHLMG7gGB5XBK+9Dfp3xzCrUNHZpYHVOLaMjrXmHH1gL/oBf3SkPo2+jfaspp1/65qhHHZI2d7T56pupjkrVq6L6hRjs/7t+dysdk9Inr9W+JuYJBoZKEUemcqAiYubOH2BQB34BTti5UfjUfOjDJXyV0rKGQZWru8eqAC9yjNkib5wu1aOVypAzL4+X5YYuvOFBHypDP8de68W5a3T9Tvql3puaN0pC4aGyukCRGEN+LgOJq527zAWk2RpvVATddbDWJaBck3VA==;5:hFNkb+qe+qSDNZpI7iPa67eGZOywqY8WJhcvNh/VSdrWl9vdZKDW2sybytz5AbtX3uKf5pSGMsGk0d9wWSPbM4xVoVxMBIWZslArZ0aZlAx9VcKzYCD32QkL5bCY6eyjFO+GLektIAMVOF83UDeaNKmVs9ObG3VfqZNLLyizQvc=;24:yPDGShDwn9R8Kp4xQs9MfW1CnIvrU08xWqsxCfl3BieH9eHfTqIIvTgzfNcJO1UbTHDPZYp1lgvpuKeCyb7RHWBE6tX9sXfLwoeUL/2IYxk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;7:XOX4EfonLNO6VZIWe8aSbGEEFlVXYNxku7QYx9x9OWqgR4YdKP/jUQasTEgLWW819nFJ/7ZsxFvsQ4pz6Mid/WK3/pHedtaqc4DTZeX11bdgCCWV/TqgOm6D/r0g0XtYrtKhONg4txXrbM6hgnWaAbPilqb7OXDDp6mmXCCN36T4xAb8lfy/qamClQikPTK1SwPvi2FSG5rdVGQ0expvFPCSx3t5EuW+oSUD4qhy9DrNn1xe5bpkC/0JAt1mkjwB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 13:51:47.5204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f181e47b-c741-4dfd-0173-08d5d2c72371
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the AFBC decoder registers for DP500 , DP550 and DP650.
These registers control the processing of AFBC buffers. It controls various
features like AFBC decoder enable, lossless transformation and block split
as well as setting of the left, right, top and bottom cropping of AFBC buffers
(in number of pixels).
All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
One needs to set the pixel values of the top, left, bottom and right cropping
for the AFBC framebuffer.
Added the functionality in malidp_de_plane_update() to set the various
registers for AFBC decoder, depending on the modifiers.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c     | 27 ++++++++-----
 drivers/gpu/drm/arm/malidp_hw.h     |  2 +
 drivers/gpu/drm/arm/malidp_planes.c | 81 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
 4 files changed, 111 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 4dbf39f..fd6b510 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
 
 static const struct malidp_layer malidp500_layers[] = {
 	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP500_DE_LV_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
 	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
 };
 
 static const struct malidp_layer malidp550_layers[] = {
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
-		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
 };
 
 static const struct malidp_layer malidp650_layers[] = {
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
-		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
 };
 
 #define SE_N_SCALING_COEFFS	96
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 4390243..bbe6883 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -67,6 +67,8 @@ struct malidp_layer {
 	u16 stride_offset;	/* offset to the first stride register. */
 	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
 	enum rotation_features rot;    /* type of rotation supported */
+	/* address offset for the AFBC decoder registers */
+	u16 afbc_decoder_offset;
 };
 
 enum malidp_scaling_coeff_set {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 533cdde..3950504 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -330,6 +330,71 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
 	}
 }
 
+static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
+				       struct malidp_plane *mp,
+				       int plane_index)
+{
+	dma_addr_t paddr;
+	u16 ptr;
+	struct drm_plane *plane = &mp->base;
+	bool afbc = fb->modifier ? true : false;
+
+	ptr = mp->layer->ptr + (plane_index << 4);
+
+	/*
+	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
+	 * pointer manipulation.
+	 */
+	if (!afbc) {
+		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
+						plane_index);
+	} else {
+		struct drm_gem_cma_object *obj;
+
+		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
+
+		if (WARN_ON(!obj))
+			return;
+		paddr = obj->paddr;
+	}
+
+	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
+	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
+}
+
+static void malidp_de_set_plane_afbc(struct drm_plane *plane)
+{
+	struct malidp_plane *mp;
+	u32 src_w, src_h, val = 0, src_x, src_y;
+	struct drm_framebuffer *fb = plane->state->fb;
+
+	mp = to_malidp_plane(plane);
+
+	/* convert src values from Q16 fixed point to integer */
+	src_w = plane->state->src_w >> 16;
+	src_h = plane->state->src_h >> 16;
+	src_x = plane->state->src_x >> 16;
+	src_y = plane->state->src_y >> 16;
+
+	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
+		   src_x;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
+
+	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
+		   src_y;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
+
+	val = MALIDP_AD_EN;
+	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
+		val |= MALIDP_AD_BS;
+	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
+		val |= MALIDP_AD_YTR;
+
+	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
+}
+
 static void malidp_de_plane_update(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
@@ -338,6 +403,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	u32 src_w, src_h, dest_w, dest_h, val;
 	int i;
 	bool format_has_alpha = plane->state->fb->format->has_alpha;
+	struct drm_framebuffer *fb = plane->state->fb;
 
 	mp = to_malidp_plane(plane);
 
@@ -349,15 +415,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 
 	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
 
-	for (i = 0; i < ms->n_planes; i++) {
-		/* calculate the offset for the layer's plane registers */
-		u16 ptr = mp->layer->ptr + (i << 4);
-		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
-							     plane->state, i);
+	for (i = 0; i < ms->n_planes; i++)
+		malidp_set_plane_base_addr(fb, mp, i);
 
-		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
-		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
-	}
 	malidp_de_set_plane_pitches(mp, ms->n_planes,
 				    plane->state->fb->pitches);
 
@@ -381,6 +441,11 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
 				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
 
+	if (fb->modifier)
+		malidp_de_set_plane_afbc(plane);
+	else
+		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
+
 	/* first clear the rotation bits */
 	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
 	val &= ~LAYER_ROT_MASK;
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 149024f..54f4ec5 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -180,10 +180,13 @@
 #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
 #define MALIDP500_DE_LV_BASE		0x00100
 #define MALIDP500_DE_LV_PTR_BASE	0x00124
+#define MALIDP500_DE_LV_AD_CTRL		0x00400
 #define MALIDP500_DE_LG1_BASE		0x00200
 #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
+#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
 #define MALIDP500_DE_LG2_BASE		0x00300
 #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
+#define MALIDP500_DE_LG2_AD_CTRL	0x00418
 #define MALIDP500_SE_BASE		0x00c00
 #define MALIDP500_SE_CONTROL		0x00c0c
 #define MALIDP500_SE_PTR_BASE		0x00e0c
@@ -208,10 +211,13 @@
 #define MALIDP550_LV_YUV2RGB		0x00084
 #define MALIDP550_DE_LV1_BASE		0x00100
 #define MALIDP550_DE_LV1_PTR_BASE	0x00124
+#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
 #define MALIDP550_DE_LV2_BASE		0x00200
 #define MALIDP550_DE_LV2_PTR_BASE	0x00224
+#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
 #define MALIDP550_DE_LG_BASE		0x00300
 #define MALIDP550_DE_LG_PTR_BASE	0x0031c
+#define MALIDP550_DE_LG_AD_CTRL		0x00330
 #define MALIDP550_DE_LS_BASE		0x00400
 #define MALIDP550_DE_LS_PTR_BASE	0x0042c
 #define MALIDP550_DE_PERF_BASE		0x00500
@@ -223,6 +229,20 @@
 #define MALIDP550_CONFIG_VALID		0x0c014
 #define MALIDP550_CONFIG_ID		0x0ffd4
 
+/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
+/* The following register offsets are common for DP500, DP550 and DP650 */
+#define MALIDP_AD_CROP_H                0x4
+#define MALIDP_AD_CROP_V                0x8
+#define MALIDP_AD_END_PTR_LOW           0xc
+#define MALIDP_AD_END_PTR_HIGH          0x10
+
+/* AFBC decoder Registers */
+#define MALIDP_AD_EN                    BIT(0)
+#define MALIDP_AD_YTR                   BIT(4)
+#define MALIDP_AD_BS                    BIT(8)
+#define MALIDP_AD_CROP_RIGHT_OFFSET     16
+#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
+
 /*
  * Starting with DP550 the register map blocks has been standardised to the
  * following layout:
-- 
2.7.4

