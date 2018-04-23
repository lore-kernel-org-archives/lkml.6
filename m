Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeDWHXu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:50 -0400
Received: from mail-db5eur01on0102.outbound.protection.outlook.com ([104.47.2.102]:23753
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754185AbeDWHXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:38 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/8] drm/i2c: tda998x: find the drm_device via the drm_connector
Date: Mon, 23 Apr 2018 09:22:57 +0200
Message-Id: <20180423072301.11962-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:vHNV8LbNsPLLTyMUtR21svSNRylqKquD+ma+LykF5LJS3r1weS7MQMCZoJgdfZ+izzBLF+7K3ktfPjWDIC191fDnf+nBjLdtAjO7K2V4xz4ra6wxJUBsw2Tpj2gk7mHJdNuK+JJpSwYkalqTQBaTWPmj513hxdX5YixN9/CnxFo1+DUs5Xk6E4MjbAI+0qwlkvJJD1OG6nfJ2qzwioNWQbAiC5/Uo4o0sz9LJAwba6FzogUgTr4ZhgXUyZ9EcIU7;25:WGvjFFSLpPyOU6NMyyx14mSM+hsWdDaipz9YLuq6Eh9RqArUm4Bf+pisOm0l6ROW0p2xppg4X46pCmevAq4h5+AngT68BViQHE6nzV9ZubAKM7ndMp7Ii60D39huQzMYabJDXwXxl8rbr7OiX/DEd8bfl+XEUAXIaFmbREBg4JHojoonJyFq3m9EY4j4p83ubnrhelxt7XLt3KQBnF1TvQnHdAE3Wfy3XGDsIEkRc/pDa/3MoVR4auD5pMCxeI/uBh5oXTNLQ+LRtCqblgWsITLv3fRRztFb65/pqKlqckPvDb2ZmspJDG69G04p0q+n9hNyHzbgK5PB5e8zgKDMlg==;31:moy/TepVLWYBQe2VOLV63kljUj0CCgivDjKxQILeD4Ot+zORFbO8mTzUH3/V8TuYzmKtMlVz7/64qSxWtu8bMwQXBCXmLGaFWmMaC4GC02/T4PJ7ciCfhAY5MOnnE4vOHAmWjezDZhSOpSgh/1tOtF82BD1V2vUg5ttBT+JVzidf1E5LvtZo81Vt/sXQ4Fc/S3dIP69UJb+XBEvsdawoHYl9gnCdojb//WMh7qAVrJs=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2774C413E240E6D9134ACCF0BC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:fKzvm7o4iCsje8TkiP33ExUmHNgiRH95LnGOxu7+6DcLCow+ColV58erGO/lmtjv8IhgujXb5WzMxU8P96Snye/ZNVW6YCtJ7WTm7JlatpMdoEa5+HwORppUcXtu+bHpr7hVFiPiWJt81OrU3T3Pwt2dYxPwJ0krKJNnRS6+jOpfJtwdqioDBT66yK4Yo11ebBSfYMbxDIbE73LMSFtLOwWEsZrjSdaXT04Mi6tCv2qz7hWGvR8RXY4JcxqX0KmtD7aorkttFRKgfBX0xosM6A==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(6506007)(386003)(59450400001)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:n4GFcMaMY5CAi7zOxITvYc54zO8ygBDnuQy2wGZ?=
 =?us-ascii?Q?URhCTn+83uVs0mzCaz17VGfZwqnh2VezFjl8j2Bwqv1eVy6CvSVIlzx1lz3s?=
 =?us-ascii?Q?oxKpDuWPoGLtkWBhwBcOH/mCkuY9vK28VGYM6W9M5enoIphJ+Wq5ooM2zYGi?=
 =?us-ascii?Q?1vqYG548WUPF6C8cAxsOuRP2l4o0Kv52BBf2B70WDRm4VQMe/5Zi1w4iADnm?=
 =?us-ascii?Q?68zI20stLsp+N0pim445XCxq7jhXPSoVQ+Bl5WGNjb7uqN6CDc8VlljztbC1?=
 =?us-ascii?Q?i/YWE1ZM8JByD0SxZZA8DBRizpPPDyf9XC/O1BxAhjyh3lONcgwW04W+1CeD?=
 =?us-ascii?Q?TFboQVK6Inm26bJhOQb2gR/KBnIWPdVuhHaxSymqua5rA8QF5C9zvcGEjw96?=
 =?us-ascii?Q?wIM2tt3c1UST9SAchLFUb13wCMBFgIMAnC46RYH4p+/K/Xxmi5upLTRXcIWB?=
 =?us-ascii?Q?O5LnDKgpNWI2R2esb1aSMhWdMwbwHeM5qdQ9V4JBJR8qmMiGIsNYqGYrcai/?=
 =?us-ascii?Q?dTIQtNvHGHdEDFzH6RLvJVUlvLYBt+cGAQGk9I7MaZs8EYCcqcpVWiA/GRZI?=
 =?us-ascii?Q?zlF6w+PMuJQVs0svwHAc03gr7TfjvhGH+GnX3NUjnZVJ9QxLHum5fp2NkJ3N?=
 =?us-ascii?Q?6B+1HbCSsvP5CdNYONQnX+97E95omnBxFjpc5mLuLGVYJSGiNqTBvYvRsMdC?=
 =?us-ascii?Q?DEVZ1s51kxcFAmmnBdnTeiP9Zcn6WTCepGGyy0D9I8/6dpKwX7PndwqS3dk3?=
 =?us-ascii?Q?OOmSxO0Nmg5n4frsnXltU6Na2Wb4v/h7gvf+a5hLZ+MZ6dWXX0TsEVdRtlXA?=
 =?us-ascii?Q?EWbIODyHfVRibaklpUSPxZwUz8rxht87FT0ljkI1L8oS0m2GojmUuZXIsxoY?=
 =?us-ascii?Q?+dCXGidif8Klj/g7AGiafyYgluuMNs89q/US4knifK8ktewvKuiDnc7b+NPe?=
 =?us-ascii?Q?oNEftg7iEKunWg0DyWzvJc8W7ZVXJaPm/sIzwz3tu5Xolmsp1P0rB3lBNoNE?=
 =?us-ascii?Q?diiIAz7x2g8jrLXQFmdZmJyw8jHyHeLPX7Ik72o/25MaHi+nWksbYITgV4vr?=
 =?us-ascii?Q?3FUmKy2rczN2/LT41MLNmyPHjhrE9etmcZbU7RsHwgFwQrgKiwRvHcRFU8RH?=
 =?us-ascii?Q?bO20oD9QksOS/OYwuquq8OwTTZ8aP7cvC?=
X-Microsoft-Antispam-Message-Info: x/UDAxgWOItPirT4hOE2NDvUrAlSngbLj+9ef+4G/6AaBFF1TZNdftbzJa3gNNl07LK8g8jQv/7zYKP9uQjhBOjfvFKrixeooci8f1argsJOYsi4RvD6ckeHTQCNeI+m9f0HaEJGhOjfgXGvlww6B5poqam8S3n3KywYpPZgKtq42UCzSw32UgxvlkpLmrdX
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:c+fwCpcAjGm4YNThTyqm80WyDPAleXUU75H17N2E8J2dbqC85BlB7Gd9O+sH+CE/cS+ISeFEtQLOjmfRrNEJKfLt7hFFOX2igulMrulEiGCjZgmdXp5x7UfARvf8PxajUMfPOaeaH6r0/0n/G3z+GdrgpOmJa1OuGIrR7EHBJNqk99TZk+Vrvb7bVMCDqC2ol5XeDdSXF/z0EhBRIyUR4N9AoZ7FKlLhWBkzFG63lGEOO2yrjh/LDlcxQO11N9cepDDUMul912krM3ml2kyM+VhzTcotbhm05/vlt9MgCzGBB5gR35ZiC84/EO2wnNb622SwyFGaYp2ZG90a8HTkWL5BhWttHJhpUOhiuV7JxfG3bthC8M1sYPoX9TEAXkh0OOoVvECzOYVjO1uXoAdxNEX2DX+ccqdz6ay6dzT+d3lM14Su3ywu1jWGLiUSxRZgRZUGKpSUIEBpwpwuP/wUMQ==;5:9PtYFGlbDOhui7/mHE0dgRu717bLKwnGK4Sc9eTuN1naRMoWwuwezN0DZloSVGWmyp5dia3gyIGIfTDAk1kt7vqEhZZBTjzX+aUbeDKa1m1fVBrNIb0AQ9OXVYGUWryFbuqgr8aHnP/JbbQLQeF6Zk4cXiHqIFugQ7grIke8HYY=;24:8Duro8WnD5nZ6YbCUeaFdY/YaZkKfwduo3y+moCrxj1VwNIuR1mfCMqR8MBpWhfryrHfoSH5S5Y9ywlfkHd0rKEEeouLsKM7f1cdh9xdHWo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:ZtWSkB4Z9s6R25gxcPGMVB8yUq3L6FOjUf2t6ka/OpXcrK7y5Hc0vlrtp+cwYrUw5twNJYWPE5I/93AOzPFcB2kyRNZBJCUJv19ynWlqEhBvSfSEYf7cJ0jydgwxjBC706/cd4yDTWJEe7dpOhfdG3jXGC2hORjODZ9Lr+sk7TKFabbw4mB3Sv6KXIULgppQEw2A1ftgjx9a9/AwPv7z0ZEfLTFN361iM3jSj99NCJpOz4V1kcvwTWZCTRz5GlNo
X-MS-Office365-Filtering-Correlation-Id: 3fa39455-bacf-40ad-4e6a-08d5a8eb2045
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:34.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa39455-bacf-40ad-4e6a-08d5a8eb2045
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for being a drm_bridge which will not register the
encoder. That makes the connector the better choice.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
