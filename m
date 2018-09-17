Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2851ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851E12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0QgU2K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851E12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIQTLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:11:04 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:14673
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbeIQTLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QAhmaXx6KCcyr6kdBHbCSNBB1V8087ar5J2iuHWfNE=;
 b=F0QgU2K78gYetioA+zhNgGCE4sH9rFDu1ltqKRRSEEJGh6Jp8XT/T6oyxMvxJrLQWLSRmx3HjqbHa12BunT+WkEkEt3l3hZwfGw96MzU7jKVloauOiKGC4bYVI/NkJKs9l4iYVzswPU2EwsfxZ5Nb5Yc6Igq05cgZx8yC39T/Wg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:43:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RESEND 3/5] drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
Date:   Mon, 17 Sep 2018 16:42:13 +0300
Message-Id: <ee88148399c63494cda4129b05444b0ac331b7a7.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c412547d-8a03-47f3-9c83-08d61ca37de6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:zseh1xHD4uJ5TpV7bINKtL9vAnbz0KdO1yfwh6aXnTYv6c5ajBxn/5CuT3tHMFW5Su0jwroOvsNncnj4AzyfLHGeKcnjibOgT9I1y+yEEphsKuZhOuz3/f/vidfI97yDO/0GihMlxjdh5Kabhv76o0htDa8Cd3802QPpc2E5+mV21sdAfPMyO3qLbPl7oM8fPWvfDSkwVUzqU+A728g3ArUBWO0RzS52KTEUi/iGSFAj40Ul/6bE2kXGqfDzkQvn;25:P7TVyo3OJYnEi5kNhKQBS84A0KybTMnzwPrbd8ESXTx+XU07AL1/7UIDwIGCidp/iWZnPsvFYMiKMTvWh+drWfKxIGWEAq/Uuthhn8NdtmUJrYeJGAGA1DqxVO/PZml76LuPemx/piYKyXy5vbbvkgvTUBoQK0pGIfYl91ZuCyfFpw0R+84aldeqkztA/wTKMp5cQU8RayPTKVLK2samR0W59Iso+F1wehrvB8lJkcZe56Qgpk2VSGxK4YtrTESPLCavPFtAVLx7ePzxM2KXrRgqYuokYSRGp6eIo0V7v0HCqNcrkw30iok6G47REF8uxe4/xEC9uk7QU7g5IIA+zg==;31:JU/urBkv/iuf3FFd2Cvag3xNrHUUQZCfKLcosspNk+jwH+0wHpcw+7T4wyeKo/MorthdjW3cQRbk+f6LKkOs00OwAW/sCqusKPafrOqLBm6Ftq0XSFv3nPX8vLdx3IJEh79vWcV+cnSCJ3aocB9jSzfdkVIFsQJ8U3u2mAfj/q+5sFIvo747Zp3SwLJxTkoAqqMn0JxNfkKxRFWy2aMyzF7c5yzoIiRWiDX10t1yCTs=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:2yMZhNMXx+eKxNQUTcCxJ5d8h4lohSWAkjEfVAuI5Js/eYCF5hQv0rit1SbjTbHA7Ljn9S0EDUs1A265dXa7J/3mUaFNqhv81A35AL34/4jGlT334PnamGU5pTFluxbUEJ00XtGz5Y173HNEy5f2GvaXO1jyef0JCROCbXEHlram9/8yLtWa6RoNQAfQi/5uR9NCHukn0r1NTqymBmRHH4aSedURbT0Lz3zzhoyAl3j8liZ1dQrNZFwJZaWbxffxw3r5G3W2faX0MBLOgfjvYUHWeYOYwggS4gOHQfcaKVZgZM8n1qoAa+99XOpco3RjOfarmR1NUBjY6SewtQFywJobZRmNDvgDUunoosLB3e6563WzI54ggAjiwlu9JrQsRaYk6dHxBbEKD00TKW/MTUSgTdeTvsU/QvS2U6XqXL/1kQq8ZSv7G1LFAXZZ//ss7JxvmEjGe6zwlXbQegQBOsCmt+2jyYllEg3nNsN+T4EKWVRZRM+ybcctnd7P1fnc;4:6SWPbcFpGYeeNTFWgJUP+kp3GBmcdx4AsPK8lRUkacCoSBDXUnbMugmK8e6rj4EU2DUCGqq77AGg2EM/Jb6NLZyvmhKnfjb4x92V5hIrIP2o8TMpEUQp0Lvqq+vG4Nsd4/hRikM9uGkMMLSK2gldykE9GzJZkp5WHq6n7OwDsL1VTMDJRxLi+W57aJ19XV9lRej+fOlke7Cglh7WLFQYhrQuaesUvYH3nxpTbgB22eB8xr+4BnlDG+DXy8tTebFpXm6YYQeciFgXCshc9ad8a9YyAYcrpKSR2lszNZUywZuPXH93lCGjfTWv7Jl6Rv5c97fVgTXYQ23MnSkS4RjegOV4E32cgY9KfqWYd/ViCQc=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290628054E5DFE8B8390F50EE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(81166006)(81156014)(8936002)(14444005)(50226002)(478600001)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(118296001)(11346002)(446003)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(575784001)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:MOUwt4EzFXlNedLc2KbGOzAFr6IyNoWIBGb1O6gCm?=
 =?us-ascii?Q?2UtXzf623aT6yqEy+hqKmMXvuPy10oG4fHkCYcWstvrnx3lqs2I6PCPHf/LV?=
 =?us-ascii?Q?7kcfCP15bscm4EflR7jD/y9fmgygu76l02zyND0NrenBtGVE8ihG70KLGbLC?=
 =?us-ascii?Q?tKVVq2pcRTXmMrHfaSCWT0sxcbpKIHHJANfqjFGQWCNsmFlPM1ZuTDirtQwJ?=
 =?us-ascii?Q?bs5slI1ztMWdD+InfhXLFav9ZGW3/pNSnwasl0Y8743KQ45JAR8UYqaxNEnF?=
 =?us-ascii?Q?XFvgNTkUoMX8l1YwbBRy2a/TeLdYBIDY+4cIWp98BudM1/4g2QXZTZ2wUxAJ?=
 =?us-ascii?Q?YZsRtay8xs+vxKXwlN2PyZeZTWCa189mAlMuzC6EKSge9Qz5F+AbN6sCj6w8?=
 =?us-ascii?Q?eP9eQ5/idRSfJxUD6qYqnygljhqKgISNnwJwZ9AcG+3+luMG9fo5LtQKL6u3?=
 =?us-ascii?Q?Cpjz6T3KF2jraYfcWhV/L1UCuGLr/2F3Ba0VUAuMrd0LiVEopTsRowwffE1/?=
 =?us-ascii?Q?OlXcW3r+zgO+GjvKTWZpybBCSOpV+O9iy6eVoIcTAnopEzU0vhH4+ZexKlbr?=
 =?us-ascii?Q?8qghELw6oy39VIp/M08EJCi1ep6Mr29trkZZe0SsJI8guDcKRGnErJZkvwDs?=
 =?us-ascii?Q?DjnDhb1NsTLp07VU7tVckFknwp9pyqas794dhSjmhv8f8spXSNkaLRAvrQYO?=
 =?us-ascii?Q?n8r0AB3Yv8H24NB6mfQhQFyH6B1B2L+QhXHEwsfhdwb78nk7lHgJqzXZ6K1M?=
 =?us-ascii?Q?NpbNBdMzIL8FABMvgcdwa2jdX/ZRbN141gLS/Yuiu+EhhqkEifXK3r8vJKw9?=
 =?us-ascii?Q?mZP/PpDDNbM3RRHGunRYWVFo6WL5UXZuYuIzpKV9FBhjqudUQ8tvAzS57SII?=
 =?us-ascii?Q?yQxLAtKTE4lVjD7voqeYr1ABy8rPDRR4BQ1HWsbgyijz3cG3FaS43I/WiQqv?=
 =?us-ascii?Q?mMb6f0eL/ls2Wpu3HsEuBlAdnRPMt8FPUHmZ2VnR6po+4twQvps1764Dna2/?=
 =?us-ascii?Q?u/bsH1SZmdcTdUpH5mzcdZJG/oIaahh2/E1eTI+mlBV/9w8uxEf+YYQuwxAd?=
 =?us-ascii?Q?n8zKhyCx+ieotbpHsLl526jQo4fbpqFjv8TcIotrLQY7m0ViKyRbUSUXFV4G?=
 =?us-ascii?Q?yUfagfNruL3ffO4BV06GMQTBgrKsw2+kPlupGMBr9MpZtOxhU6gUxjwtIh/P?=
 =?us-ascii?Q?e8cpGMmgrVU3gUyfix5KvrSkI8Hh2ASdZe0VhgXyknF8Hf17HK+UWR6eKJ7r?=
 =?us-ascii?Q?ZYcXFPa2RO+kIcCda/ZsnWDmthSrJGRZO3ma55SADx5Q1GLyPfqEoi37xk19?=
 =?us-ascii?Q?h28YyF21bnprL8wKi10datM/5bu1So3of4BQpwVwty9?=
X-Microsoft-Antispam-Message-Info: xtvOm3PKA+w9vq6VqA7theHoGXg9CYl6pl1teO1lrEgUy4kFF8ej64wxwqd7vsPaRwcF4j4pcmHJyncAO5MHlzEAnCFHiQcnzJ1vQCDysXoyxgIW0IFZf0kg4P5U9UNxYAJ8F2G1KbPuqd12jPZDYDAlPmF7sM7yv4d7ACYB5QL7AQYdmbwyxbLDZa91h1h7Gne3SlE+sBZ7j8i2pyzw5pgekIV9nn2ZNQBok1ZmOv3ip704WC9n+883tXHrjqyBzVJzLIonoZQ81yS+E2Z4KMEN61+w8Ix5APDrLcW6B8jq2sCB9UZQKpdVnRGeh+lV6i5CcIRmEo1z3VZZ380dev8GWKBj62ON9j5jkeBkP5w=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:KKJZM7kT7tsdbGnuIRgPsQl39kgYQmopEMDPJ/LVlZ+O9jTL0VaC/5EIrzhbeNasEt7ehCEq8Ixnir/N5+yngYG4IjzrUXkqgTvqlRDSpt4xKE2eCqUwAyb/hkqVdHltEIbJZSDwPOWjzRuT6A0zuT33WupEbeAmmDgGFPHiEE6wRC7kokZakN+9PjX4p9yey0lT4e8s5qrO1r8JemevkWpTz9MSs5EZFV0kRDysBUCS1Jci396o2Jv7DAwXeIrHfC0kndNpI8+PXrP1tUfpkIgol7QAl3cruYmuLF9Yn/VIKmX4djTuX5vx566GVo5Cct4UUc08w+v8QQhtFEK18MBxEYHhicbnMB7I/HotQfM1zhgsNabohDTdlMN+FclDtu5O9iofP5OYTc0IqUbNmugqxJlMa2H0rPwGDyMjdQcUg89/uZpeQRi9OcBLdV5rSWf37buGZRmFjsQwFApjrw==;5:wO+0W+cq4eciUwJnhc9AtD5c4tMvFh7bQPQM2YLC4cXYOBDD9p4N0swBblSLAagc0WcBZASTwR4YuuiJvnpD+acpheeBEIxCTQUuweY2/go5ph8Fb/HiHmQnZ0GPxNIMdqAuWH2V1XtLudFVkmafigXsdaZ+rrUx6D4QeXPCl6c=;7:VsnsnLDNWbU40W8SJ4IKrMigjhQIU+fZIcEf6noRx9AxyZwQVKqksYZKSb+gfKMk8CBFhOnjasmUy58OPADCiaejgfZelKLuyZ7Md/eIPk/dCsDKU0f0tBipJkIQKEo1ihTXOrPyD9gVIrU83ToIRdAUeNPax5K2uaEzTPb5PvKozAIosExypXtsK2OjUJV3AKr681z1VpDORJa+4STzHRY8p7fTY8ayvx+c/R3SgrpWwV2phcH6Cgk1HMfCNx7i
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:43:02.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c412547d-8a03-47f3-9c83-08d61ca37de6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently results in
black/corrupted screens or hangs because power is not correctly enabled
when required.

Ensure power is on when display is active by adding
pm_runtime_get/put_sync to mxsfb_pipe_enable/disable.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137ccaf8..68d79f5dc0d3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -101,23 +101,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
+	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
 	drm_panel_enable(mxsfb->panel);
 }
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
+	pm_runtime_put_sync(drm->dev);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
-- 
2.17.1

