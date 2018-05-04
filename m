Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeEDNy7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:54:59 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:6903
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751801AbeEDNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 23/26] drm/sti: provide an owner .odev device for the bridges
Date: Fri,  4 May 2018 15:52:09 +0200
Message-Id: <20180504135212.26977-24-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:JVtkgaM37MhYKFaFXU1gfamUmkwGDWdCFuPXGnJny3HKrVvPhk1jg5CMA5qAZeoxI/2yXWaEn+OPjMVA47QKYZZephpWMdzsRFhnGEPrfeJJvKi8cPj1xgrZob6ku2uYpV5zA99IjsJVpGHJgQjeIUBnXENXBOWvrT5BV5fvfff1t7BhNqbuY2CgCfN4ZCkkIUz3Rb+wDKtnCxmpOEy9D0U56KJ8zsyuskYddZkechkOekkOBSdJbCqsuhsXKTkg;25:MKwaDemju5NJgRZjdQj0geWmJqeh/9ZnxB1oGJByxdHlgNcBwTs3F+8Lu39oZpxFerqA2lvp0rvMH9sFLfzFjUTYaG0/NQXi1GwMcd+ynbHEW8lo0y7R4v8u2NzxiQWn/S5ymsUTHpPEng3/dNR2IOG5YTHSnhKay2QzVl/vSefbJ6sJh7z+wbx49KKcjQfW89zds1msnnMPQa9D/1SSi7Dwd6CcAl/YTM7owid04qtFjf4T8TsW2uq/SpcOD/PYjN4JlZOZpUKX4kYDHRV8zb/fUnE4Eo2Z1gF/jucltYDqZQ5c5UmMJ9+NduVgdk5FHLM79PnqN5Ed5dAZwEOaSw==;31:jjATlTle0jsjWkVhGTY82vITXAIle+jI188lh/7jut+gdcTa28YW1Bbj2Yg7NEmNEJZQLqDbEuaB3tg7VVl0FyIQcj3vWSjH8WBqn9z8cQ/cK7eTyoNnnBtLlg89J6Mrokh0ePSgtPbrnTNadsZlIgay+T9+lYHZFcmu0H/hjy/3mKwdf/wXCf7cAZ3ZFsP2Skj61797ZyVI7Gxpp0S2FqDHjl5EWEkW6KMpDO3Vc1s=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769EBC6ED1D374D009070F8BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:MJFQi0latENjbCx2ETYkc5MD/JDARrzgc65ycaQvknGEC1XI1ShoaGA0IuRATEnV4UHSVTY426THl/jorbJF96IbtmZcDDXXZIhbZeKQB2PsWP4HulNFxpRQwgvyFpFGq8+pKpLocxI4PJvIWWEnv8SI0wZP7zVTJ/Wqkh5O0Acgxv+baptfIQv29sQSxuQU1lsscy4mz0CfEQ3MJjwDDsz7o/WvmLSV6mjaPjT7UDIUPUUMkXIrjWCLsy9MQh/g5qEunm1ntamIkpWhUH6kcQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(5890100001)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:5QJK08ClBltWEg9xT6jn6i7gmDgFlyPhik3m1Oy?=
 =?us-ascii?Q?FbnY/9iLs9pg/iFMDcemG5+IOMEW1fY3sHSJTVoZxCL8vLa5JpqbjjU6D7R2?=
 =?us-ascii?Q?vsnDoTnAWosKAnObaP1A7wOnVfbsV9D4tuC0oCaitYJMVRD/X0/AcrrCvV1C?=
 =?us-ascii?Q?fh80G10cqjjb0WwflX72Arj9/KJ9J2aG9rL5RL/X4dBmvuyNFrVFmK8ls0Kd?=
 =?us-ascii?Q?mZVPmTeFEKjZTxcx0bhT8ClHnplqrd0scv2BUMWW6/+EfCEauMOlN5Z+Kpzn?=
 =?us-ascii?Q?bNwL+3Rt/Khuda7nshXUmul3QWTygJdSWuoqVh6Sio1PZvE9IEZmqfNbI6yl?=
 =?us-ascii?Q?8VdtoTFD6+LwkIBGZx5lHEIcp4cSElEo10+nm4Nly5Z4V6M5EZgqLc4WTMdM?=
 =?us-ascii?Q?G6m8RN1OjofSKe2mWl5B5UEqfegMryIBKdyuVJlhWmuzmIi0TUHuBJ/ja87p?=
 =?us-ascii?Q?PtgMWABlPdMeYcXp6ohYULVC/IsZ8+0klgeJJ/sLApBpxZ6cCXAP8QKOBUzj?=
 =?us-ascii?Q?x59TCd4OOwYLbos3SGIUt0koqmnXU3xLTJ8RtIFTUk6BdOvijMyBozRtjnWl?=
 =?us-ascii?Q?SWHtdeOxfQepqHSk1WybXFN/zLqzP/tawQF/uyw6be0vA0t9/sp908yCZHW+?=
 =?us-ascii?Q?s5iYTWsl393dHiIoeXDXPVxTgSSZTjDk54UIfDXsXsi6qV0B3NO9/R8ZwUcH?=
 =?us-ascii?Q?tglsDOnHCYkSqHmz4rXD0q+IJRt2MrHnoyggyYLTEHetsZWSsFOwZMSqYrNc?=
 =?us-ascii?Q?LHaRNTDRL/YWD16oPW86HSUIsbS+9cVSXjK0Q0FH7cWzrV5kuuFnBTV+H2Su?=
 =?us-ascii?Q?7x0zZ+gEdOBLamFW0uZz/pCQpjOiMZ4FpSDiAEsVw3MMY3x+6xP1zD1oWK3z?=
 =?us-ascii?Q?+AprvysPJBEVmQrAwZSvmtykec4tbtXFKKDi1YCO9s+FdNx1XaH5HhsiP2+X?=
 =?us-ascii?Q?M0sgblXtNOu0GIJTEzkx2JqEwDFE+yWLzmtfNhHRHcjHotCBFRGWy/RIzjQx?=
 =?us-ascii?Q?ntSddHnAk5gV6SqV7YprglTKxTHTX4jIL+sedQkIpCyya4o871xRYZmiQBVb?=
 =?us-ascii?Q?/XpBPALcjL6Hp8OWyl4gb6K5L63M/u+Ro1tiHh2xW8ODnGEXRjTggqFPeJc1?=
 =?us-ascii?Q?lWoA1bJHo4/Gw4lK8L4IbZz7D0U0/EdmojRYKWSGmIe6DBUn7GdaM3SCpmYO?=
 =?us-ascii?Q?7KueDQd4ZN1IVRdmG5yu67ZCLZn46/vnXMCyGyt2ZF6WqabuwkW+JCIO6ovK?=
 =?us-ascii?Q?p/z2sMliNz2LX/zxnfhQigliKnuUGrO92vN5axcWNanonIzEfmn4stzQKCvE?=
 =?us-ascii?Q?DrCBuL8Q2nDhoT1vduMGxBVsMtcK9nMP8xnof8WfeVDSKh66snJbg9mquccY?=
 =?us-ascii?Q?dsvFJM3QdLe0Jho7EfE1X6MQ+Ssc=3D?=
X-Microsoft-Antispam-Message-Info: ud2EddZ55fLdOwhX89gvfW6V2DRZqze2ERivrdfiK/cz2AVDwKSIblW7GwGiAtWo8q3Pp9DK6m0AEezON68avDHP4auhOuuvR/RSn8YILldYcm1ONqL2ggEi2+9uYzaqZkqGgzBad9A6qubV2Yi8ZSEiICXTLIOTCRdS14FikeilhEcTQeundChGn+rYgI7O
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:OqWNMEVJ+yX1hNEG2isOGuRIGLz3w6LJDHYEZhV7mha50OzOcDoePCYW3KknZDlMAHAkIlDoYUbYNbbvi8Y7+fGzLjThA0Uf/5ujogpqmlCurM88PPPNs/JWdXuIaobVhemdQ+BKS6sMemMlg7HPbGm3/LMQcd2avnVRsH2aXmsTueqZIGMcX5kScHFIiWj/GiRRWofhSaF1iSl09X7P4URLr7t2WQ8a/Y+82yvaRDoAQfXWlcGg+Mk19OLnQsRNt5nqCHyrmdMLe9dbFP5LLbWgyUpLFBGm162oCFr7Ed4Fm5BFMZNJyydxaKNgwyLENoy4lQE2YjjEgvocsWe4ypfArqn7ARRX2DMCTk46oNSSHKftkqUWBJQBHomQpN6pluruwyYjSatjR6fsMcTJBl5PVmvr7KbAZ4zCdJTUadJpe0bZodn+95eQCE7Utohme8ScX7AhHtfNxnZVJjYl0w==;5:DbWbn4ys1Gpin+uW7CdnbFNH0T8169ls3pFUqZMrRCBg5HRMGGrOY1SKHy8sgB+hMRZAr2d4A+JT/wPiY0GgL4QRcxRkiLG8PspNUkOW+JOoiDA8usJmyoWPst5DNJkjzG/1zfjBDcNc7mjwVRuUItla8zcp/FehK+vYdyQti5A=;24:z2aj4FgOsvdaChAw/ZNzWA9hz12WVvzifQOqfCzpQinQNdvZO04v70YtmLRPh4PHMJXxl5SRdx3w8kfsNiDKsLfNRQNhRCdsUAQSp52Hkn0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:eOqvJyKKLEPbedCudZTNstXbPI/Jj4NuBqkN0NAdPYDQtEhZxAs4u9z+ejwPoUwNdOX0c7wRoyM0WbajHnPhlk0X997Xb4zree2veR1NzFd2+ZuYTaOvtKArIq8XYmNznNLE5N+kDu2ZFRSApudA6N/KbokZZQRW+Niy8DAkuZTgA7FjQifidARB1EdL2eQGaU2/viue+560wMDntWs9Yh3aW/7Nb8wouqvGiLUE9CiDyp5UUV2isS0MuFppsDO8
X-MS-Office365-Filtering-Correlation-Id: 7dd0c0f5-7b82-4d50-f317-08d5b1c6708a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:38.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd0c0f5-7b82-4d50-f317-08d5b1c6708a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away and providing an .odev will become
mandatory.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 2 +-
 drivers/gpu/drm/sti/sti_hda.c  | 1 +
 drivers/gpu/drm/sti/sti_hdmi.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index a5979cd25cc7..f2609725f8f1 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -460,9 +460,9 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->odev = &dvo->dev;
 	bridge->driver_private = dvo;
 	bridge->funcs = &sti_dvo_bridge_funcs;
-	bridge->of_node = dvo->dev.of_node;
 	drm_bridge_add(bridge);
 
 	err = drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 199db13f565c..7fcd24664cd0 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -694,6 +694,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
 
+	bridge->odev = dev;
 	bridge->driver_private = hda;
 	bridge->funcs = &sti_hda_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 932724784942..d1d2e1a1920c 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1270,6 +1270,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (!bridge)
 		return -EINVAL;
 
+	bridge->odev = dev;
 	bridge->driver_private = hdmi;
 	bridge->funcs = &sti_hdmi_bridge_funcs;
 	drm_bridge_attach(encoder, bridge, NULL);
-- 
2.11.0
