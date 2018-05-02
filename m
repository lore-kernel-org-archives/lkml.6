Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEBHlG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:41:06 -0400
Received: from mail-ve1eur01on0101.outbound.protection.outlook.com ([104.47.1.101]:20800
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751346AbeEBHk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:40:57 -0400
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
Subject: [PATCH 3/3] drm/exynos: hdmi: avoid duplicating drm_bridge_attach
Date: Wed,  2 May 2018 09:40:25 +0200
Message-Id: <20180502074025.12421-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:jLJAulkXpexhTm6zv5J/fiD/m/ap5C/HFmv4v2oXGBW5dOhe2bmaOjE6G2O7PqEPAZC4v29Fe7cpzGtpcqvXtP8wBGlP3nAT/V9g9ncLv5/p/BI72onxIPiNV4F7yBH9Oy7ItWJDLPqVzFaGBidesM0N519bBedZpJ3EuUbB1xaDbjUm+Rou8744gEcXxOo3RVhJEmgJ+sFcu+pKWziNwXLsmr+3PK+mVG/NNQ9z+oKCPQNYam7MFCcvyI0YL3x5;25:jJqHRelwxZ04w6X3RWsH6KYmuR25kD5mVp6XMB39vQ3RcjuofcJn3bmflvsrgl2cSeEES9Sz5fMow9I+6QukktALuCU7JnRBUkHozzzxcocheB2p19lxTLWL8GWqsKLLqnad6HUyIMSXZ9+U696d88RSZ2rOrLziNfNm8IIagU0+R7VJoiT6hXPRZN9pRX8mpPT+FL6fqBQHAMzJ0NDDMqHuSJWbLc/BmO3pvIYslAZInjTqAdJpfFBpibhug9BjfEEDWFXZEQL4Gpe2TOxU1lW8zcNK+YL4FsfcnX0PI+pXbVOXHQdFUoXPvLMhG7RtMQooN24Iwbd7TrCkuT3Bew==;31:JGx2GF7BT9fffjbIGbWiHYq5zqQ6oVRvTVfpD+SEMGZTV0G1oIC7ZE8fN0XaIAgYYaYMQrqpLUZ2zSFIJYct+RHbbezEHjhmPbkgv4UV5bMG+bWpS8ES6bnuYMbgMk75Ck2PjtMpHA6oh6zj9yjMxtBuLmDG3ETXbyNhECiENh2M3BCL5HCGk2g8zmHqg6pdCJ7gDdu2pJPkrnqunczUD4ezRBiPWjGZt4tfEVP2Rzg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784555CA010BD30BA774963BC800@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:7w85Dk1IMqNsLA8xoUZr9/Eh0hJsJ+icEgqRMAYCg4rsb9KtF6rJoeBeAGF7S/m1G0XKZ6usYHITQL5CKYnyV05lgBEFXO3Iy0mbrZHhvR6/RbSVLxykL/hwBMZUme29he0FK+Wut+23sN0NsA62P+9eodrKSOucDxsAZqUhpIo13E+8l7/AsuePvqnNV7DtgB5ZIPibuLIeKjsIaUFErNd/5ls+FRCIhtBWH1ScOa07M4i9by7gUmvUNIvGQ31DNuJroM7iecBAwGlMTMwUKQ==
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39830400003)(39380400002)(199004)(189003)(105586002)(36756003)(7416002)(50226002)(575784001)(86362001)(81166006)(5660300001)(81156014)(478600001)(50466002)(48376002)(8676002)(8936002)(2906002)(106356001)(6666003)(6486002)(68736007)(7736002)(186003)(305945005)(6116002)(1076002)(16526019)(6916009)(3846002)(2351001)(5890100001)(74482002)(2361001)(97736004)(26005)(53936002)(66066001)(47776003)(54906003)(6512007)(386003)(6506007)(16586007)(316002)(4326008)(25786009)(11346002)(486006)(476003)(956004)(2616005)(446003)(52116002)(76176011)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:nDyWtaHWSGrb2B4vkT1hu4WyNYyN2fYbfdt01eq?=
 =?us-ascii?Q?ODNbZ0KSZhzaGQj5bds9D1LRZZKGpGGEQlHfrUxQudeKZZ47q3CMyIgl2IUU?=
 =?us-ascii?Q?R0ZPvI7xw+GgBtGI7WvZ0er+GIqkJsfmmPo7myuBER0TWiP7qbw7SXLGwYgb?=
 =?us-ascii?Q?nGq8rztXM3I4mRG3ZJhZCJM0mbPehQ7D4V4xMIC06aFrIKzcm9mO+CxKIHeg?=
 =?us-ascii?Q?NoyKzr3W5DNlADQNyIsmZM0eIYNZNchHwWybjO0zMN+MLgmRyHvlPquVuxGr?=
 =?us-ascii?Q?8zKFpFnC3Tr7DYOaG2sKw0ITN+tuhk5cDw1GGPkItVQzQbHSLXAt3lPj+Jlt?=
 =?us-ascii?Q?+8UWo1WFRKlADyFSFI260p1NOLtJ2RYN2mK0yGEo97MW92SD97q128F68esX?=
 =?us-ascii?Q?aTecT3iEwzlCrW416ogH1TnzX3jYZA8DzC9ki0jAo9GhQo6tKbykPT22dR9q?=
 =?us-ascii?Q?ELGoj91Z1Ks6/KlYCCnpYZokBnKZKzGpPzy1GEo7vfu7jP/vGOpNNmdBdcOQ?=
 =?us-ascii?Q?rOJqivUZqF0jmr9FC81Ybq54UFOxKTecNRQcIAklNcnr/B7bSSsoFha+LvD0?=
 =?us-ascii?Q?nAErI2viNJD8AuGlBzKKhesGcT00hEj7erZfdGLw9SD/m2Ap6i3Fuevm9uyQ?=
 =?us-ascii?Q?2D/LGBV8/CtNp+ogNBsoJoPpr4d54Xb2frOQoMjpfFY+NeQvzu0F4DImwfmF?=
 =?us-ascii?Q?En6Cm555SNvutdVR3HP+AXfkuee8L3usOhpPgd1/fcAy7fRxk9NMCdnibMpI?=
 =?us-ascii?Q?4oKECv72wmmO1EMQb9iBfzeEtPGBA1Lu89hry4VWfNZRr2s6x5+h+4SCr5eX?=
 =?us-ascii?Q?gDA9drkyUB38nInbC8AHTbuNKXfcXDyTPGJ3ruFQubUtw7W/jFYehOSf9Ebn?=
 =?us-ascii?Q?demL8HWoGOD1yb5TihK5Fll7ob7LHaUVpKZF/apf6HniLhhQqQyD4q9/bu5h?=
 =?us-ascii?Q?NkZ+mHMo6pmKfIjmbZQlNDIX02TRE7uv0PdD3O1SShHEhCtNKWknm6dQ7Qiw?=
 =?us-ascii?Q?FJMhkmrO7oACaFnVeZSv2Y/bFgaHNGjaJsTVzKYoe9/+WdXholqdqLuNrUVg?=
 =?us-ascii?Q?atxjZ/Hs802z70MbDLg7CA4BHBD+79y03ps8/vyadVZS9NiV5dng8UdbHuF7?=
 =?us-ascii?Q?e3wteLchLmxV2Mx7Z/0RRWIczlZq5+NV1mACEUk4B9N4GxwSTmpTaq+3muKG?=
 =?us-ascii?Q?S4wh8+6WOpO7XdBnidreZ13PoDB4KgTvNIwdy4bHoVBWCg7bNzCRM3Nzzf0w?=
 =?us-ascii?Q?WZrScseoN2a22XBqBtMAX8vzV2vJrOVoR6OGBdJMsZtIenopgUBxnf+4OlVb?=
 =?us-ascii?Q?5IKB7nKAfD+dmmu/0FT0uhE79Dle47mJ6hUcP8xM7pZI57jx7IIYQBkhxr+4?=
 =?us-ascii?Q?WeOJwP1r5d5d1VJ2jqw/pJOmMFaA=3D?=
X-Microsoft-Antispam-Message-Info: S8pl67EYDoDdo0ljrSsiGyMHXPbi3hI+d5ZbrbDMFhYTVLSB13uAgitxMqQcx1+5sn489Lcwgxo9Ww52jmj5FhkdXEkw9q1HxFH5lbutIljKRrFTTaJ0uo6MYvsHi2EbHNmnMx5IGLSaQjcdqQqSoys7oxU+1wC6T6OCN+BUX03Z2WWIkzMoMaCCDupOpP2d
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:Ro7ni3LePvr/KVEHQMOPtm83RPVOaea24fuJTA5rCqYCDWFM6XIgdopKPHbb2EA1o7S1kfev8bEvGvC3tMRyiRs1IDtdgr8pixM56kgL32Ld2QhtOm1TyStHVeOfJEbqvR7e4Im3JOaTQWS9QIz6zoXTjLFUJuiL7JRp3YqpdLyUtlQh/9KLmlZyS+Y8zJgxNhjgzRYZWZccAAxlETqcfsNMWvGA3ZpZXiwQyWhFa8uXGxAto331W5UdAXFf9OLp9HZLr/V6SPtVY8L0wCQPrbNgLAP0A3IupzOYUBJHWzyz7wiH50WJlSpYY0sJkg+ex2tyWvCWAPPHqcubm8DFOxoDRFiZRNnM+yGP/OPWXHRhI6WrKNJUgFakJ1+S7NrqrfTjEEkNvjOU6R5FaSqHvaCt857XMT2rJnt3tf3wvlc39Yu0BmmHwwjFmrwz43tQmSuQiPsmS3GjKxSzQcGNBg==;5:OO6qpbKopVrVy+XT19mqiTqG6NWA6YSzKhb4ugdAxU6ajALtxPay84Lyw20VTJGqZSwI4lV0oRZ67OsmEakvgBO0W/wMww1paRgudRumhPI91Zdd0wpuIpnUGW+FvWIOjzv+8yF1YgeoAHx/b/8S+kk6wZqkig39nc0kv75CBF4=;24:mEgQfM7LSuhRGpck2bYXOmNoIWxh6s5TmJwohkLslVj+KH/e3Je2DBwlxqAZCYuB0Fby49laJo4koJZ8MLvUgQoWOGh216lgS84nxZ66y6s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:oBitbS3c3E2AjrNS2SSkl2L34/hDVdVv8HYVfW9cskCzP+Af8ptDl8GRUnVX857wzVEWPgdcJvtb6HDkhmLwI28OLJWZhP2Rr1gBs8Yxk3a9bs3SQXRoL6IBtM8TROJGb6lV4YhLjU7BCsKXfUzVXbRogVLONVclvXsdMQDjJxckdfMCfIVDNOWg1QCEhb4fL4Px//tFDc8iZJnG9nAj7BPDw4mpUg/vhPyaQ4JF/SiofpTLTKyc1WGgzpFnYArx
X-MS-Office365-Filtering-Correlation-Id: 5f2bb40b-3100-4102-6c29-08d5b0000926
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 07:40:53.0919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2bb40b-3100-4102-6c29-08d5b0000926
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
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index abd84cbcf1c2..09c4bc0b1859 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -954,8 +954,6 @@ static int hdmi_create_connector(struct drm_encoder *encoder)
 	drm_mode_connector_attach_encoder(connector, encoder);
 
 	if (hdata->bridge) {
-		encoder->bridge = hdata->bridge;
-		hdata->bridge->encoder = encoder;
 		ret = drm_bridge_attach(encoder, hdata->bridge, NULL);
 		if (ret)
 			DRM_ERROR("Failed to attach bridge\n");
-- 
2.11.0
