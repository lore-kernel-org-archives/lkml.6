Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeDZWeW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:34:22 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757127AbeDZWdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/24] drm/sti: provide an .owner device for the bridges
Date: Fri, 27 Apr 2018 00:31:36 +0200
Message-Id: <20180426223139.16740-22-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:DlGkeKOrktMjRyoeyxMGbFK0LsBOeW2n6a945lAwD+q9Od+GVXTcbQLiJigUuOd+5hCm42h81rjIH3zYPq/egJNKEtTv8v2THVjO6Shinpq4Ffig9zOWrbLTrJrqP/2MRLKa8l0BRQZkwrw8yE8/trHRF9XreuyhZgABr3WA320yvqDTJBWQqDJM7bgp84D+bThVXV4fA1qt2/+63AH3n+CgSeeps9XSPMvLXf1MYtAoZ1gMmGsrRkLaH4JohKWE;25:9z9iWi+yG+kie/TXLnUba28AQbWvxLAvl4Pa6wz5iUcnOR4ji990E23YMj4IKbrxWm7aupVEKUo1qVk100qVsfkRsfKG1D+Hruivo54VjxqM3JwNXkJMatGtOCTYmk7CGA0o6DmrDVUgei2Ahfe6D3N2rmFuEzbLUzwJawyOe0JasBAfWdKGjL+CBqeSLVHTeo/XwPqn814Q6AemSmY53TxWnRWr39RWUMZJXo+8sVC0B0vlIynOlHHdl3PF4yi+G3kmhTitJWVGU7HDO4C/yXRVN/Oevf8mY3xROsfbWg2VUjOWag7kJIpWXKvDYqIFQvKM9+T6DT8ACWnoK+DG0w==;31:v4zPVEbIevi7D+skper6gSjgAAjslxDEa8QxC+3aPJ6VGIFmv4e2ovyDlteBhTWATdrJ26uaQwdQY4rIAP/kyrer0zC3KHw5SLa80atE1mXmdlbNLLVbSv/VU1kGs3M2UDHmFAojKtde6wqBVPX28cq0fGM44udrrPYDL/A8k2S6wnXjWzmeIZcWGKK1G7GA7QYwQGomYmp8dTHxmzD+cVqK9hPfH/3tRlynEebtISA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27827B9B0FE735B7E58D5655BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:kXK/vablJbnqzwNu8+rQ+G+/pcZfbHIdfRCfOkTc6qMEZGM527tWp46kzLWjod7GUPVaTN3bwYrdKJDZ902hWtfvLDlsiUjXfxT0DZDrfGEosUDzNEffUqXyU5AgAYf3uZ5XSda+MsRaD8klIvM60cA6pbXP9320G65+qcmrDQvTZA/u2C6PPm0RzeXuEtuLSbW7f0ALEGUg8Pm2HWnXjctPyNUwfc4M+UxJ/LFXnof3yoC/XCebRepaPxwMXIb4EEIPo6TRgUd/ZZ1v50zdjw==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(5890100001)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(956004)(8676002)(76176011)(26005)(6512007)(486006)(6506007)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:DBGvw/QTLUeAEDQEOAzlcye7Gu1ZtAAglRnNZmG?=
 =?us-ascii?Q?9wJtdyGmX3zuFD4zoPfcGJcKgCEmHXo1/h29+n9cNT1fGwwZUVqB3euu0QRH?=
 =?us-ascii?Q?7XqnJVbfRG7EoU6YgW8D/udSBvQ9VXWhVGM3FovccfmP5hBlNftV4iclBCOM?=
 =?us-ascii?Q?15iS1YCeXsGOyh7ueaBoR8dT4ap3JC0RSguHd0HrUIgrs4zC/fNmjy99z+Ed?=
 =?us-ascii?Q?ldEf+5V3xmaj46mxGnGKc7zzlfMwuRysfYCH8/1wgaOcaOUv4uOku51wTbqm?=
 =?us-ascii?Q?4mmjGk+huo2FShiaO0UdcNBC/GiD5Q6nZWHmT0NdH6F2KUfStGAIgvF+W5UU?=
 =?us-ascii?Q?Q3yEKR/6e8UeCzLCfKUQAexPYzzz0iJJtnXKt4pSKFiNHGdSrW7WGbqzRQws?=
 =?us-ascii?Q?EDyM7/kSjzbIOXiwVBdRz1icaaoORwlGFz6iSgfKIkRB7QsooWP/xyz9eL0K?=
 =?us-ascii?Q?kLod6HqwjXLPoGuSnJRgKKLfVQX3/gyU24mZmm7pQYUtD/FYZRneGsj/LnUp?=
 =?us-ascii?Q?GSoQ7mNqZGSMRskn/MWFIbJReMbul1llNi9q7fndFdkhp0bUQh0x8sqyMRsj?=
 =?us-ascii?Q?+W8eAj/mXfVai16rD9TEy1z066Ke4rFUqpnphHIDr80pYop9a0bE+I6TALiK?=
 =?us-ascii?Q?qLixMptH83+53XfjBTuIur58xcJIR7rlZXtOyGTKAykSCjK5PlAod4SOJfuq?=
 =?us-ascii?Q?ziCtweYixrNFIAXdgG9A8hUm0uJTVkTw3yVf4EVHtORkPCzU51hGOize3Zv3?=
 =?us-ascii?Q?EYJaJFtXXnbIiVSV8FyfKQMnyHGjprBTTxz4eOLz5bJhMDdtHcvC1Sc7tMMu?=
 =?us-ascii?Q?yZWzLyO72eIUShQmsd9CNuyCKMyOstU0EGpGHA9hc28b0JaPLYaaU3+kz6mr?=
 =?us-ascii?Q?+Fh4aX66kWdiVFZVNrHH4zVCkrFFysIBgkgKPIfNo3o2/Kw7EOduhyo9ZnDp?=
 =?us-ascii?Q?rUFKVq6FzSFe6jT7HD9zd4CLAftW95tlvJJE6ftVEyevxAP+GR4Bragt6Jiq?=
 =?us-ascii?Q?hhRZbBEcJDCFb/ca+COmRaykzR8rzdMJ8MZUDars0gTi2Yjc6alHASd9JdJN?=
 =?us-ascii?Q?d+vRzNhqbVnB1kPQuqF7N/dEwOtH9aJpvQIhnCkyGPja/GPGAgSgIjwpUFaT?=
 =?us-ascii?Q?yOqIu9LuqW6nVBq9dXtJ6fbEbiRKdZSOw3MMeD7ih24vuOcNPpxZQ+yERUpQ?=
 =?us-ascii?Q?nYzqUNsmUIQtAwiWYjYz7bjawxY9g5vIg0JPmn3jj0ipMGjBH9OtWhhk4W8B?=
 =?us-ascii?Q?/SL77TROl6wqeZTdVLJAtCv05rg8AiTRccANaQ2nffwq2yZPaTE5GvD440wP?=
 =?us-ascii?Q?Icx6UXgMx/mv8zFFrybaGp1a0zplc4c7RPQIObyd5cGHBmAsWYkBIpyOwYo0?=
 =?us-ascii?Q?b1TEpd4Cyo/y7v/4KM9LgdK//knY=3D?=
X-Microsoft-Antispam-Message-Info: zFvbeSU+ZzdY2jtNBWU4fcFomBTisH2K15XBnCsMOVXZ3/f4mf0k5HP+wK+SYUSNpbJuqGPt+gZdHh6kq0tXWA4XEAagNcoH4So/+aBmGxjRY+kIBYHN3pH9CYDaPeFuyxHNYE4I34J6dFFKKnCU96HSIalmloqscvgSi7PJ7TbnLeDoet+rnuA58r7/YVQf
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:98nLd0pshqGofTDWbyO1CdhUOsmsof0wnXBGTVBZIhMnQQ6EQL1Y/1QlSbyws005Vboin7rMVHN9+5s1KxBT8xfwE3QWDbee2QO/caApgsVHX86hY9E3yYSrRdFbvL+IGQPvbUz3rwOXA9RGirhzxgX3toD84JyFeJddG25kxF9S2/AlKoF1Vxl/to363dqxVdCxb6pmC+JEAm2VTbeXjXicNVbTo/iKal//J1uxILQW0dalfEGM2sSUEmYjCPfN2m5CHyoyR70LisoO8tks99E2Cr8lV07Iye+8kEkU1SkG4am1Flqix0KZngv8fNJlOLPrgiiHX4EkfmaBmd4MqjfyNz8t3J1LkjCL74g7qgSgXuipdvinHdBkH4eXN0Wh6V7bUGgCPPUzC/ZfWL0K/Uu+z0f0VRfEgXi6owHIDqm3PPIV4CWx/uqjo/U6bBOgmo4xdKrBXaBuzkv7/q9BWg==;5:DSzV13dtDl7ZLbApCTzCGV3qsxFitDJqK6Kt7p8BroBIyKl1LlBHpHY/pzf9HJjRoitVdB66PYYcG8yfGpWFP0keWd5+t9p91n9tzzp0nrS+NdgEC5yRl6/1HG9ZKDU7Y3sgPRPOAjxA5HaOlV/EbjGeABUvPKsMhJFIvMRAv9g=;24:tcnB5BNb+IuXyxAgLfeO9CtTM4a+R7QxCHvXhV0HmT4LVtgSIH6R84J7MqgHo9XebwMGqgMh5zG5xMM94m6VeAle9O6RrH5WdlVjU2ZnokA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:ceJxcEWJwN9BQrhtxjP5gnjNmXneYuB6pcJcYNzCSeRAcKNof30bRKoars4yAIptpzYIyJwHFnb3f/LqWxa+fazt7yqtOxDSWUlUmuEjrJT5BaT+24843t3kSBmzsJugaxUdzpiaEnwMkcpesYigrQeL73NJCJegpq3rSpwNeEdwhMpkav3mxnj6jHa9hhARkKVDCV1HghdRt+pc2LqWEmN4TuCng5ykPQDh7eZlgDKSxeNYZFM+45wlTieg6qdP
X-MS-Office365-Filtering-Correlation-Id: 5b7b76aa-cb41-48ce-951b-08d5abc5a8c0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:56.4643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7b76aa-cb41-48ce-951b-08d5abc5a8c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away and providing an .owner will become
mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 2 +-
 drivers/gpu/drm/sti/sti_hda.c  | 1 +
 drivers/gpu/drm/sti/sti_hdmi.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index a5979cd25cc7..aa390053de16 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -460,9 +460,9 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->owner = &dvo->dev;
 	bridge->driver_private = dvo;
 	bridge->funcs = &sti_dvo_bridge_funcs;
-	bridge->of_node = dvo->dev.of_node;
 	drm_bridge_add(bridge);
 
 	err = drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 67bbdb49fffc..f45623628c95 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -694,6 +694,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->owner = dev;
 	bridge->driver_private = hda;
 	bridge->funcs = &sti_hda_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 58f431102512..3989cafd1c23 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1270,6 +1270,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -EINVAL;
 
+	bridge->owner = dev;
 	bridge->driver_private = hdmi;
 	bridge->funcs = &sti_hdmi_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
-- 
2.11.0
