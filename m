Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeDSQ2l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:41 -0400
Received: from mail-he1eur01on0133.outbound.protection.outlook.com ([104.47.0.133]:30364
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:37 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/7] drm/i2c: tda998x: find the drm_device via the drm_connector
Date: Thu, 19 Apr 2018 18:27:49 +0200
Message-Id: <20180419162751.25223-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:OsNsWW+hEPQcfCXJhQHj5BJLjxoiv/BLH9pkI9V3aXICbhmTWreQWGv5ruvYdLeM32QdtVR47qWcHd/zFZTgxaqXKXf2wdH5lxiKY0EHnO8peUr/6VO3oeVlViQwm9YW29ASv+P+ND+llTXA1VcHShFxt0O7v+sUGWcm8b3RjQj7jzGaceHoOUM8Rsa3ufeQRIcy+c2gVXIvJtaJH5z1Fi0CANGxTjPPzUvihAf8kbz+SayNXSWFSgCeAe2DnfTs;25:nxyA0eSXANbXv3id3UOh8/aYFF5hvTZSN6I6Da99vS2MH96Rp9QQeaPyHG/iuZOxnO9D81/iZzRaC3sKgxJla6xDndzhJk0EJmSvJg/0og//prN7SgcennDNrEcfwvP83UI3xPa9ghm9I2j3XsldW9NOmr4WlpxYpSV+JChaL2WPooMbiL+49M+rAKHKAFzsbE1eFsjgHofHjhcbHvpXN2H5MZ5B4/cOOhhdwRh7rv1qJUbeyz6xPeqrQ+atWeeFvHgIjWfvMXP9DAcESB3OvaWhkkvl0HJnN11bGY9iF4xBTvr5OySbcaGt1ZEcBM7DoAa/q9oNsqSZf8DN/wKgPA==;31:kOZmublG4ATmT1RevkoLpRhx2AXiBDWgIcVIFua49ZHVuQNDriPnW1FaMcY9HzyrvLHc5qGhJ0pVg9GmyC+/tnKjEepJYDA6a/ePbTNbRK948+fhfSnkuA2gk5BsgsR6WouGWTtHFY53hrGMGfihKnAa7nvvKcq5vB6UaW4LAzq5Dt3bhVnJQsYc0klT/Nd+Jzs9lGB5jYEr3AN6U4dlWqkLa430B+nIun6UijkPOCM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784E7CAD702E700D01A51AEBCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:9ATgtmFMgIvifoKrd4WPCLHUb07TKiplsjEOUGKkJVsXsOFmMGmWXgbRWTOfurqd+Ap9b+t8nSU3xtrSiztgTok2YL/2Cghdf34Zs2WekebIgZuES76lf5ASAK+7tkgIFVOvElWlZPI+aFlmO+OxtPeNfbSRVduFTli9L+52kOT66FrUUEy0diVLbTMbSQ5DsdfV9WbIN0qqFxurkpS8nMnJssC9H+MKV9h3Schj4urqnnRkvWL/oeF29jckRocR8LVjUWQKHMPXQewTkNT4iw==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39840400004)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(59450400001)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:7vS/Rjt4+bznOEEG9Ul+XeLPMK5Zx5g1Yy4OKE3?=
 =?us-ascii?Q?JlGCIfRrk4BAbg9qYYlkhuTKD5ZndUZbK2BCGQZKs/YdUbi7LfdGZi2EdIaU?=
 =?us-ascii?Q?zMcq5/da+hRtKfm2OQieGy6xJ6y/M1EZbqUj5ZuKIfhTKclTOv2TOO1kQK2y?=
 =?us-ascii?Q?tkKT2ej9TcayBgVW5hU6JDr1q8ID9AfHIoyht7gYgyp+cxS8QtpVXwNA3TQB?=
 =?us-ascii?Q?0dJOQ1G+nbFa1eO7fZ+88LqGl/c16BwnEx9xcroveeP6bTqmk40FpqjYl+1U?=
 =?us-ascii?Q?u+UFKwbyQ39kwfB7mJmC+v3SHuRhE8m6PVcTuzLZtG/YvGZdwSOrwjaHmn7Y?=
 =?us-ascii?Q?/iCFRoucQeCn59RQGpQNCexs2rZvATFBxopZOQxG/Uu/xpp4EZS3V73cJnwR?=
 =?us-ascii?Q?OEckNw3v5orah7URAYg6n735fvWcPbKwoXHQW9qHrcGQGsro6eQJEO8mzJ1H?=
 =?us-ascii?Q?VTQ3a2J3CxtZr2FEtjV2fuFWtrN18FgMyDCfcVZjTrUHEnk5/giwaV3xwupq?=
 =?us-ascii?Q?AaNNFnS36vofkOoy9RXLlsnUVuRNeumdL4Rqd+BPFT2ko76arFCH2I7m2mmc?=
 =?us-ascii?Q?z7eCB6tlVb2eE6oVnocq0iSeSAYNq9Kbi2TUm1nyeaX/gChsMIH5tsrWnBp1?=
 =?us-ascii?Q?QeejBhc/js668WyOHVuZIgQ8IARVm3yUprz532oenQwrrcfZCAD7kSy7gw5b?=
 =?us-ascii?Q?EPbFN1rL7z8hqIAnvmFsAx8JeVlRb6Sf63a181OEdm4YU/RT8ALFlsePqK8z?=
 =?us-ascii?Q?2Lo03Iy7rncNs9eTkO4ww2IvZ/3NoYDC1dBE+WNnvpZDC/+zcaGz9k1CnCzS?=
 =?us-ascii?Q?YiJ6Azt2Wna5XIiPDG4gXBxfuhM8WISnKdXzjJTWUPEiOHhBTenlmf7348ID?=
 =?us-ascii?Q?36+CYVLjMJaIKSZ3mQxsbu2Dqk4GknqKx5I5SdPFWWy3yzlYwA1nsbc1lgMw?=
 =?us-ascii?Q?wqdTgFdnx2aD5jDDXnqrqZYxyNOxGHyBx3/svyKb3HH6xSWygFXe22JDQT4x?=
 =?us-ascii?Q?CQLWQoY5qnPJH0u+PKllz4BtvYCBYiqGwVast+tyNizUTGFUjHLgh+IenLKo?=
 =?us-ascii?Q?31sg8zM3eI5PSzy8AgD3WjRv1BXAZ+Hw5bjhMCVXmpjbs5d3pOiJF0YWnsNt?=
 =?us-ascii?Q?OuID2fux8M3UucRznz/UEsYuWMXrqZ6RAjEn1L94toqNKvc8MW0h/VA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 7c2w0FrsBqMUFhbpCj3BB1RjO0cDSsZj1lJ/XoBCrFEVv/gi0A0lUi/PTHjb5D+AJIGBEXohNEI75ErIzSyy//wOIki95VDNgjRMES8j8PyXpov8XYY/deKvxfos79564etgZPo++7ovcfkyvjkEdkwIjNGiZN7l0ioTmfRwG7xUAAyfvRg7uCe/fUQPPV0F
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:TePwQFhzO5ADiKCJL9KUn9x2C/+jJbvQTtsCMCdCj5FAJF9jgZnsrCZfKq4kTg/NUwbWB9uIW+nzyNmAeu7cGQmp/g2kTCBiQHOtjD6ZraMvO/sU3tcC/Z2mzpLy1TWn2U2NRKh8EMNDQQKx5SpfIRlJxVvAfp/rDHsLTtLSWFzpunwRELEpoNXgDRB+wFGSvkOJSQyWzap9+iNlgzR1ma9xEmoHJklTI15fR+f9ekGxnjIFXU5DrfK0rNCb3Xjng7nAUXx2IODPssAp1JQMBG/PEqWup06+OHP8WGGd1Q2jvn68iDYa+dXTTCFDaG+jpOfdROrCK4niKrNqjwnjAy85j8S165QTTr0WvCYYp1DiSbBW0iAw7J7hysZRu3lBH+1qAX5OsEHbplPuMVFOiyfhQcMSulvK37c7Sw1kbYdY4qLqoVv2o123t2MiC8N/lRbr+hA2PqPiYeK8ImSA1A==;5:hB0l7Cv/UxNqAn4IzrVAvmmUvJ+Psrewl94tklHjc2wcLLtXO182Ce5n0pW5S0tMH3HYR0dH5a/y4YwVcacuaMkYowtoOPfJZcw18eKbfVoWOj93zTwVfrYa/20/yX/a8bf9FGpWnwUu3Ev2Qp6kF3kHiHrSbmrGNA5bKaH1tz0=;24:qfXOlwVQd4VTI/guvpruCkm5F+XkN75m53cB9frS6fw/cyjtdjGuBMcR9GyrT53bsXZbH3FmW+y8GpDxpjEI/VDrc1+IIekfpXgJIlBxi58=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:fxL2kF9ag2q1NwSzlwtTdCcMKJC5o4x78U7lunBLz5nmU/ERYcU1TqUwcTfJ46h8mnWaUyyYKFGNv18BaaAG01B41VXJHolTokNfdY6+d+7vtf5Usi+Z/nIE+DilWI3TMjcDyLYpAY4moupL7xYCW3/bbwmsf+bvLk1StuqHnJs27n4DGiZaqKDhQQvnXIWJ5sS54n9EO3azwoI4OPASdnX8COZKBCtltYgexLQPyyQciFjwLGLw0sd6IHgfL0gy
X-MS-Office365-Filtering-Correlation-Id: 148c0c8c-b3d3-442b-6e0b-08d5a61298cf
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:33.4427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148c0c8c-b3d3-442b-6e0b-08d5a61298cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for being a drm_bridge which will not register the
encoder. That makes the connector the better choice.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index cd3f0873bbdd..8f6e013f2b87 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -630,7 +630,7 @@ static void tda998x_detect_work(struct work_struct *work)
 {
 	struct tda998x_priv *priv =
 		container_of(work, struct tda998x_priv, detect_work);
-	struct drm_device *dev = priv->encoder.dev;
+	struct drm_device *dev = priv->connector.dev;
 
 	if (dev)
 		drm_kms_helper_hotplug_event(dev);
-- 
2.11.0
