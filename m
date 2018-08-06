Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7912BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16314219DD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="C6+OMh6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16314219DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeHFI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:27:17 -0400
Received: from mail-eopbgr60096.outbound.protection.outlook.com ([40.107.6.96]:49134
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725735AbeHFI1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcca0Yh3z2Xre7AtX5CvsPKq/YapidH8+EOSUrRxFAQ=;
 b=C6+OMh6VgKHK21dS2i7UZZne7ALK8s3KF1rpIlvvgW7jf5SWgL1FlDSu3Kdayd+nzvs8pGJ83mSdtGUxUnXra36KAIVnsHyrOAKYmJz8vo/6XI96UGcuo6tmkCICBdNMaOoaX6sP8r3HRSSTnMvLNWQjIJ6p5yI4sk7loyYPh4Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2455.eurprd02.prod.outlook.com (2603:10a6:4:35::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 06:19:37 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 2/2] drm: bridge: document bridge attach/detach imbalance
Date:   Mon,  6 Aug 2018 08:19:10 +0200
Message-Id: <20180806061910.29914-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180806061910.29914-1-peda@axentia.se>
References: <20180806061910.29914-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0334.eurprd05.prod.outlook.com
 (2603:10a6:7:92::29) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42310688-cc23-490c-c1fa-08d5fb6496b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:j/zK3B7lmAyFxXhQ4mP5QGe1OM9Y/6hBDTbGQ595VlmaUCHRXYIPc/jq1FS81B+kLsWbsdVUxWFeEInsriVcL3yME7b+DOPW6BhwpnIXnTsQeHDFPQUew3NfJHxOyiiCAZmg3COnA4dxWNFXAT5VKQ4+c2L6lemWe0wNCqFTq6nuuu9x8cV1DeD3V9y4fnQVx5M9isLZ9LKbHNSKvYweRiIMhOV3lZTWReTl5I6IOKjUU9A6N9vczC1mQ76Q7Ssd;25:jomSuoEIFtOXPFrhM4JNj63KqNoVC4SeT1bU4zMJRs28i4II6sxXPvyty21++loeIfeBS00uUe3kigj6mgka5kbRPjbNpnT4Jv/Xp7t5o0raAu4okpCZStkoUsItPgUKHLOr+z3liuQR+B7s/qAzlROOsSDYImsui0HTD+05QzW8NE7l/HCbYibx677aIgVAZaxZcsLxA/M1XJ0u6EEE6WqayA1Hrwqv1l4ginVA1qjQ2kxd4IPN9wG4tnWk8Y5ept6V+vgRcy50wIdZrt6+GBDxXCAThhG0lISboT4rO8+Sr3lSrdVtjYi1UW9rf3x/2AAanoc/GcmhGFq4wVvoGA==;31:zketCYhze2f8kIkks2pkmkJuwJgO/LpAFHA6zwcJC8rKQqrKRl5vqw0qqXXfJ654V2gU1noPhSAAD2FuRjkZZ/TMdMmas0Z0qikrbHrkwd2y117EK9E08iqmQSwSxmXfjxrZ0znzI9RIJuIGpkfDQANc6g+o7iEiKsnfToJkzJPFvFU02YY0iYaS1HctFtjr7TTKk5tn7WD4unFimsiPBiCKjanhTZgaY4+igNHfXG4=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245514BB3E4883D713ADB909BC200@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:DWW3M1Xy9is4Mw+FnKJszX/Iopb6k2L689+fWzPQir45SU3XVt1A2+nEQp9CoxsCKmad0Y3QNIKOYCep5e97Hgu2k2OSzaVRZoHUTemwnkD6USU9TKEM39G57JV6hfCghO8g64jbbGIxqABZiLXAxSJO7SAUXDW/SwfZWTqjSj/bCckTeZdQuyo4vx4M+tmHCUEFZrlPJrH/FCe+BeBgKiFvpI1hQq+4oj704idw4GOZkbS89gIeqHBBtc31EWSNFixGm3XERrAEqLHelSGF2Q==
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(136003)(346002)(376002)(199004)(189003)(2351001)(11346002)(106356001)(446003)(74482002)(105586002)(316002)(4326008)(47776003)(6116002)(386003)(66066001)(3846002)(25786009)(6506007)(16526019)(186003)(1076002)(97736004)(956004)(50466002)(48376002)(2616005)(476003)(68736007)(486006)(5024004)(76176011)(14444005)(2361001)(26005)(16586007)(52116002)(8676002)(53936002)(478600001)(6512007)(36756003)(86362001)(305945005)(5660300001)(54906003)(81156014)(8936002)(6486002)(2906002)(6666003)(6916009)(81166006)(51416003)(50226002)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2455;23:LhGjsDTETUAW0qzwDjxeHpB5Q9ayGVvOt3oS5ty?=
 =?us-ascii?Q?nLul5Cwi5whdHp+VYbazNI6eIApXIs5oz/rIlVPnoEhN7+c/reKxs7cA9y5F?=
 =?us-ascii?Q?BruUdUCPib2xDlOJe9A27GnkyOprrIQKlruEVP1I5gyf9ByfMWbOFPZizuZ6?=
 =?us-ascii?Q?g5RVuloJXo9diW7ew00XC3z6rP180qvwlNLZjad1BjYNeNXCCXd3zP+4dQeZ?=
 =?us-ascii?Q?W4YtwWsdxAlLtULAGp01fRLwWDaaW1EPWUtyVvm15SgzC7w+TDyy2kVWZPJN?=
 =?us-ascii?Q?hhn+R7gRY3akRxWZQa5BPo0zwVXhiPwxnKOINKG2o3ViQoRCvpKVsL65RlvA?=
 =?us-ascii?Q?Ep46x6NyQiMsJqZfnDy8qyqtgMzv2jeT5NNFh3YnoAHEJdZqAKOcoCnf+HN1?=
 =?us-ascii?Q?uCE0m62d7Z82NQFlx89m4qyF0QzSIXrLtNE9FXqPSYuY4EliGmLpdKB44Gwg?=
 =?us-ascii?Q?LVo3MYOm9VwNRr42CaKfVttG9mmSpfNiNRrO1FHI6lqjMHzUF0NhZ+sdmd2s?=
 =?us-ascii?Q?eJgICl5ynykM50i13YYUm4vXUjbuiyl/INLMN5OGcmhXi/XcZX4GH/YkKDEW?=
 =?us-ascii?Q?eYk6Im+RYUq/LoXULpqMQqFMbCwN2jfGEy6uy6wVPyTnl/G5gu3I3f++X2QY?=
 =?us-ascii?Q?fvlTSsMrSCLCH5d/iKlclRv66tQZP7bNqWCavx8j784fYORSPTCEAttorc/8?=
 =?us-ascii?Q?lJAcxsVigTItwv3J9ew2m4xVRzWZjBxaN0qJUeYR5rrBhL0+w6+/NgzxEg+K?=
 =?us-ascii?Q?5DIZEY8FrvEWNkZ5TFZiE1KpoJd/QbYxV53rkWd7/jG5QHaQYu3EcQk/Ah9H?=
 =?us-ascii?Q?uUAxglZ1ft3NIeFrJnZ/u+7XIlqs/R5yaqZAWuCQpd8PqMlPQCZXB/i0SzjH?=
 =?us-ascii?Q?3H9ByXjCfk3fqgQ9xb+Vy8mgu5U3xZbk4+rrWfePi1k84j7qEqT/p25KEKnF?=
 =?us-ascii?Q?TpmYk37izn+9r9jyvtFks8nlKPIhpmoxR2IAfNQA4FIsvTiCa1Z2WJi17gQl?=
 =?us-ascii?Q?tWZev6QeW0RhYWVdVeKsmGis5zMBLBvdAhVjMZPE1NiCc2huzhnJRryYvujl?=
 =?us-ascii?Q?63HFCW0WT0OMb+p+2uD0D0rbg2CBFoXuGQDrLiXRQWRcOTTeL/dklaU3ypw5?=
 =?us-ascii?Q?Tb2mvLu21KcH+VbCcda+X4OjwG08gmeWIdzy3OoghUtfCZX6qfWcER28QdcE?=
 =?us-ascii?Q?nE3PAc8WUEfDwaPMfJ29ot1d0PvakgxCVlvl95RDcL/mWOBx+SYtgxa/MApA?=
 =?us-ascii?Q?9Fy/0lIypYmvuqDJyn9X5ma2u5dacdVgf9ZJFAWhwZwos856A59l4fht4oCj?=
 =?us-ascii?Q?fTzlGmPWqUJSHHvtvKXxEsM+UMcoUtKP+d7rsqJeyqvEL?=
X-Microsoft-Antispam-Message-Info: nkR8kmgjJZhpfMnA4IjouPmaSYiY60ugNkjc/9xfirJtIr8UJ6SMbFgB+17VJ+1j6CHRh2tvLpGX+4o5vgKUL4TpFEYq1mPpb0GGDv+zNrENNh2SASbGaXSeW07yj0g2EXvklD3sXkxBvTE9+hWAGwh5OzRkW15q90ViWYgT/e7tcjaCseLmqt22NxN737Bwk/VPCumDvOUmVKnLsYFj6wt3Txlq8VMA+djvJ2w0/ZAl8Kj4HP6BnByQqCuSjvbr19fWd1MeNYnPx3qJNnXlOs89OZ9ptoFjE4Mcle+C+R9bibqJ6rKY/H479wCIUuozD9hYtUlWHYVJMgNQ0W5Hy8daQP0JPIWahKU+fK/aTn4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:D9RdqURd+3oJVlUxxXsCnSAUJc+z6mcIzsmqSYTUAxUrwc12OcSMcfa7dZCxOdDjFtVBnaooznhzu/MqfHnb02/APPtkHiPO7nEGgVQINAaWo3QMxFoPv+rf/kVFSvQx/+ZTx/53uSPnYLvWB1qUjMSFnB18/tZOLuedtxvE0GKu6PPzmokHfDXBoPTOGr/Uj5T8k+NCZkENFup8yCAnSwjDeuYaOWrfEhd+GXEcWx4hW17W4mmblOihlFKpzC7rNUkftRK1q4gCOg0gZ2mNDP+rX6HWyp3VDcNV/jpCAjw1lYQkkui8zOmXTkZbBYGmD4WElWxi+qfPW37zZON9d13isVYHHRr1hRM7R3fm63oXx8vIxCxK+zmtClmOlW/X5jFcZ59QdIe7qEpD9izAW1gey2P378X0ZxUM9u3Z7iFxvWrnVEg5A/iYeKZo+//y6DKvPBZchIsCXL5q72EstQ==;5:K2u425s5P9SeT6DWp+PImVQRbJfYjSvUcDRno3PaWN98qAY7PyXzhRKzcOn4qhl/FV/o+koIjGhF9vOfXx6bAuF2tWQ7uF4rQVXhbnkrEZsumVL7jrqZb0I24kW69PvpJBH9ICipKiwJGPazfoWzVCG2ZHaPUWyvhDK2bxesGKY=;7:MeqsjAl95Egr3W68/opZ3WZS0/U6qIS6SdrdyyYOQ7g6YrA+l8v85bqsfqERFsLYZWIGpXVYxcfLC6DuoPdYqxroktfNhB5s1ER21lPz8X8me7cDCH8EoBT1IMbnYWOUrV9p+K7LbkhmtibicUSIhBFaxbRDUbfJ0l/kkJ+vFqAtqn9YSF2K4ks4gafWWTwXTUdLyL0D3lFW4pEcnYt9iHfLC7TW9XvtOO0fP2rDu4L285iDW0NVjwPtoQyxkJyQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 06:19:37.8686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42310688-cc23-490c-c1fa-08d5fb6496b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4a878c03d562 ("drm: bridge: Detach bridge from encoder at encoder
cleanup time"), it is generally no longer correct to detach bridges from
encoders manually. Document that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..ba7025041e46 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -104,6 +104,10 @@ EXPORT_SYMBOL(drm_bridge_remove);
  * If non-NULL the previous bridge must be already attached by a call to this
  * function.
  *
+ * Note that bridges attached to encoders are auto-detached during encoder
+ * cleanup in drm_encoder_cleanup(), so drm_bridge_attach() should generally
+ * *not* be balanced with a drm_bridge_detach() in driver code.
+ *
  * RETURNS:
  * Zero on success, error code on failure
  */
-- 
2.11.0

