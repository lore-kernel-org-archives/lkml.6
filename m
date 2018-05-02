Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEBHmZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:42:25 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:56200
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeEBHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:40:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 2/3] drm/rockchip: lvds: avoid duplicating drm_bridge_attach
Date: Wed,  2 May 2018 09:40:24 +0200
Message-Id: <20180502074025.12421-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180502074025.12421-1-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:KKpRqI7IdME2PBxR13CHbDtVIpW2B59RnJUy8p7pzM569UotPWHmeR6yvJAH64FVvUSTtw/5EBH02wrVSXD43FbpuMQnc4vyq3f5GSplhV3xU5CrfbOaYCjYwR6CYV2msUOnk5WUhb+RDVRJ8OAw8JD+d0XMJIyxTrT7+uSI8QdJe5+2toJXTeYmm/QM89qT2rt84QyEu+UIri9M7F7SJDlnUiFN5kc3Lgi4kixDlm+3qJhJSkI9dpTc3LGqWzHa;25:Cl3IZZHjFTKD+3BCuY3QDp4JXp8wuc1Te682s/TgowmE+Clxv7epL9uDTgMDb7NJSZv/gNiMl25XO3bAKw3sKHG36la2o1NxSsWLZIr1soT+FUywkmNz6g4pllef11Jmk0uwYEP32S80sYq7Va+vgAlnDoyzc1WDr+JD8wY80o1jpdoSWr1Q4rF82ktZv/4OjsupEGTpFfWVrZMneJ/DxXJsFevTfOc6P3qCGO5ZsphwNDS8zCRuLoxfkLx132tJIsZBy3OZNAQ83VrXOs9j9turcfuT7xK7o+D1Jo+QTkbFga0+uykvnZdLUl2BUyeHdWXK0Xg4pX7YUxA5uz3aUw==;31:enyJo8gCu9FHMuWnVLBoQRoGx+Naer4NzUk2sqEVsY1fwDo4Hm9XQib4XIphRIAXoN9C6UdEFu86ryHY1548flBjoTxbegIvjLFzR4DDcHgSYELE5qtqnuX5PMnn4s08zo3St3Mr6PVEISt1oGEL/31vZLLBnk1sk638pwEqVn1giodsud7bOhCt2eBVXfa8TAg/+ThxurDzjwyx4fVd4dfWNKWthUL9/LQs/2T2Otg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278499E92EBA013E18034FEEBC800@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:oa4kJzYfnlWRJOAn4ASgXJfOxxg+/si7o+n+PcZFF90yilDsQVFzVw55BLnwyalaEJm157PPzCYKQSM9F/6+sLRPzUZiGjyWovKkzRCTMcRFJsJeZCbtdR6mRLtl/MMnBnk558JVoeuadMlCRdz8DN0Re90R+o+dnLtw+Q2/mCqBaxRCWykM3ECim2l1la6+hjINCqS5eikTJC9UroEsS1lvO9Q/nTfRfXx4XYFySatBeDIdxPZcBirWMwU+AZ4QBiQ1auQO+b4bMZyoQ8ij4Q==
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39830400003)(39380400002)(199004)(189003)(105586002)(36756003)(7416002)(50226002)(575784001)(86362001)(81166006)(5660300001)(81156014)(478600001)(50466002)(48376002)(8676002)(8936002)(2906002)(106356001)(6666003)(6486002)(68736007)(7736002)(186003)(305945005)(6116002)(1076002)(16526019)(6916009)(3846002)(2351001)(5890100001)(74482002)(2361001)(97736004)(26005)(53936002)(66066001)(47776003)(54906003)(6512007)(386003)(6506007)(16586007)(316002)(4326008)(25786009)(11346002)(486006)(476003)(956004)(2616005)(446003)(52116002)(76176011)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:DGCkGmeOiqBvraiUh3KK2oXHbQYNm6bkZ1+pcwZ?=
 =?us-ascii?Q?hMFpUcMafaemttTZoND7JK6UjEPOMDKhqR87fstObNAVuqHbHzzXFwp0mkyl?=
 =?us-ascii?Q?KZRRMHb8gO+VzIoSNvJPeAIGtLUP2ugxTUpPQdLnI0nJ48BcklXdxOSGiqqY?=
 =?us-ascii?Q?c1GfnfcrwMKYAGTmODRrGRlESyvBeYRO3Rohk9HgPaDqRT6uoL0YKDoXJU4N?=
 =?us-ascii?Q?v2L6RZAleWEFHXue3APGIQHm4lfMjjN0B53MKQNN2N42OL/gR6jqLuuP5kxf?=
 =?us-ascii?Q?/d3iDBs7XQVhicrD9lBkD68TQjIjslBe5Fx4uBSBH+3ZfrN4IGEyeEw5qCsx?=
 =?us-ascii?Q?TDVVjsPFKhgnMn96uXEQFxGanqHznySL8PqQY7XDTQodKcMhccahoSAZSi33?=
 =?us-ascii?Q?RPAniDC/WmBcBT9SIKQuvcZzS6fQHiUgSWFZoWypleY42Rg4Wyikf29myF3G?=
 =?us-ascii?Q?OiyZ4ZZzJHOS3jnDW3yTY2XMa0Rz400bCNuWppPMlTLEMBnmjzg0N8hTBpD7?=
 =?us-ascii?Q?RHrGTx7xKuWHoAARnEryOoqXSoZ6NESgbwffWgbuKUUY2ITRXcrDgRza/Imq?=
 =?us-ascii?Q?MiDXUFzYh5ENhIaoF7b7Z+FFz11yHdYb2JDr40J3EwEA9/Xg5HakUw5Im3PN?=
 =?us-ascii?Q?bFr2FRxQ1Qf2ZxV4ujxqMGbYXFrsOPgzsaoTtR/xpdY1/7xK5IltjCwUaL4e?=
 =?us-ascii?Q?N6JCOHaaKneehaigvClkhkTQDYiXa9ZQx6E6hCYLgB+NaFtorNlD9/X54OpP?=
 =?us-ascii?Q?B1sqWH6VuUaHmDnJn6QjmNfZVUGkmKxFVEZp8nnhxoIFnQEDDBCfIHXSOq1r?=
 =?us-ascii?Q?+UD1fKC1/jE7Q8A+j99MXLioLi69n50U1TGbueAeBqVtyACqbVh2QTcaVIoy?=
 =?us-ascii?Q?y+eNSLPTnYE/LpXV2f5S0K5mJbEWN+/I6KHk4ht2B324/kgOu6CIYnPVl05j?=
 =?us-ascii?Q?PThgWiL3dv/vWQkD2WiNuzwn7bXlOeU61a8ZyCHg7Ku51biDaBXEbmoKcPLU?=
 =?us-ascii?Q?4hQc7Rl4N8Nw+yVujyor6njhBDcraUYesACHpDGlHOdZ8uFOQVJGkWKjPP4a?=
 =?us-ascii?Q?e0tUqkhcO7JVIl0XvBXg/oXgjPONRldYGJA9+fVRDdGYsVbbsXL1NI9FMROW?=
 =?us-ascii?Q?5dSagN/yIohH7W4WmIp2J2n6V1c9+kAFjgHzPZ+h3L2Bow5sxHTruVYbxKmJ?=
 =?us-ascii?Q?5s7XLsQ6+lvUQdpu4R0hkVhDI8mMMLiDwqi1Jy1Lal3exAggYlC9ZHPqWHdB?=
 =?us-ascii?Q?kDJ0KcvmrvLJsU+axjE52LUGgXCZKhkil5te3dv8dMnkguwKQCut9Cw9Rn/m?=
 =?us-ascii?Q?nvpzS8J6UKK2lWrhxt52LdF6ScPlUboXV6sqvV9Vr1hID/VXVJ5BkA7NS/Kk?=
 =?us-ascii?Q?yJRRv0wBJnG8JNGwcRUcOgYQk5VU=3D?=
X-Microsoft-Antispam-Message-Info: lOnXMopcvNWQ098q9IhsGBD5I82i9g0gz6dUp68by6VLxQzAIOiCnrjnHnxXt4jAhnrLtdD/Q1sHs5ohKo2jQN9nb092j8OLSwOJRf0OG/Z9GuKJn+8Vr+b0RCYTZFcPZBT5ZiO6ZPfj6Xd3l4seTSHE0vyyHTkq/MBA34tF0xVSLWTnFGAh7gqtSgq6QvMj
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:uMtwZ6vRayVZRU7tOhiGYj+IT5n7mePlOWN+OMoxBXtjZxUYRF1AhEqzmJw7rBtIQDT/Qx2ZgXT20SoEGkssqOa8HnhcKQdop+gLmeOm06XA2goHY0aha1NA1X0wJ0sXB4fmV0tLlmEsVCcg0O/P+kb883xPEIqoI4b22lx+cTHKfdQjibQw8rpsinAU3+Lp3Ix6cBXTuABaLMnNo6qM3QOfzcXWb3OcNLZoAvK7Z/sSFdnio7zv4QT+6e1slQf5Mg6/JsQdvu/qAnhLV7OrzKAOmyWjPraB0d/tsdHo/aIk6UQLvdNO9PJCjsei69bSDxlQHMaGhsCgNJTGCL7Iijge26tt81Hcbr4UIbFiJ3SC2mqIDEEAfZM7fZYMfZO15p+IvH+nisNE0CWt4t9VDR74MLSn/a3mLY/iJMy3w9991oEd0s503/2/D2qZnZL+ENttAGxV3HPhQCmrK70LPw==;5:Zwvat9cHhWFbS8AS/nL1DqtyfWTJpurzszYBO4eRxziP/nOY8lqhmm921Gezd3XbxTKcu7hX5YSx/5P/p2AVvK/O2zMIqj9/G9LWKjjALyH7Hl1Mv6cv2IbWLa+WK9Sye13oSVHEtgTIseWzHKpN314mCPy33p09V6hRM09lXQU=;24:rGyBDgXLqaubiPp61zdl0B72GfFj7bKvpTFoxpAncgMonZqJoOXH/YbpkrbTNqmuyWja18U1daT0/EO4UN/0A3CURw0Ihe851f1k0ubRrfs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:38Xl7B5DdYLyE1Gf8u/lfENExPz5MhfTOp7WEO0/KHMjNWu2mpsO5QorOlyA0sB8OiwaUn4/MkqQ2Dui3krB1FhNthe6k77Ssfnq7i7AhYPvxH8SywqQ3ffuiq3mW3zamiXVJxIQFpvk4/UkFhw9iVavicMEM6VBQYDhVtkkodGNYhdAbBSQah01ZP0shySkOVjMVifanhpbwN9yNZfrPM0WqsjmaNyxa2mWT/yK+StCny0ZCnzvkYYQYzWhTl5y
X-MS-Office365-Filtering-Correlation-Id: 1644fa97-28df-4f97-2999-08d5b000065b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 07:40:48.4044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644fa97-28df-4f97-2999-08d5b000065b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_bridge_attach takes care of these assignments, so there is no need
to open-code them a second time.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index e67f4ea28c0e..4bd94b167d2c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -446,14 +446,12 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 			goto err_free_connector;
 		}
 	} else {
-		lvds->bridge->encoder = encoder;
 		ret = drm_bridge_attach(encoder, lvds->bridge, NULL);
 		if (ret) {
 			DRM_DEV_ERROR(drm_dev->dev,
 				      "failed to attach bridge: %d\n", ret);
 			goto err_free_encoder;
 		}
-		encoder->bridge = lvds->bridge;
 	}
 
 	pm_runtime_enable(dev);
-- 
2.11.0
