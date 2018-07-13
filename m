Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A4EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E07208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="REg4E6+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E07208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeGMJNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:13:23 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:21632
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeGMJNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkP1Ow1Jh8Gzq1nDRFEGK99xa0orVTlwrQnp/5ji378=;
 b=REg4E6+JQlY7lGGt6qoKrJ3AY5Wb8Iojot7E3JuCYsfip4wdMoadDkbFFf0erZfKuxqJyrfYu/ZFBSBFKbf/H6fWCNXQdYHpm47luewma+61VogAle1LI9VYtn43CDkTpwVGsog6DWPVobm6WTvvjg2WmcLF1QtTHIPjFw+MW6s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Fri, 13 Jul
 2018 08:59:26 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     marex@denx.de, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] drm: mxsfb: fix runtime PM handling
Date:   Fri, 13 Jul 2018 16:54:45 +0800
Message-Id: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::28) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e712677a-e841-4911-f7c1-08d5e89ef1ed
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:BZcr+OY9AIl0rqOcAZJnD1aTAkCXoFm3WbgSGDxKXKy0jn40SbNP+LFh6OPBIIyfy1t+zTA3nJwTtfOcuQB+OgOmovxb5olqH/7dsyl3KNAyIWwaGX9SDyH3Z26kD0mXehjVyHgq+gTMuIc2hVUWEWYYJPyrkbdx05omF3VhIdamjFoQ0hJoN61VStSwwspFvs7bw8Dn56jcj3RRXilj/azOcMi5xbe7tz2rrSYF9uKyxYXmm/14iD+zI/ruUPJn;25:7NM23L8eRNZcgmuvEe/RmT0T5xGiscGRnTehVVfhhk8OpWqNeXSVcp4fXfHGQfRIyuQREzZLKxRGUE3FV8vRU01SC0g2HxeYEYI1tEp9/XnizQDMQXVrmqNunb7FE3+3VFn00nmAyyulQib9mHJFX3RKkVhz8AKss+bK6vHA+HpA7BZpd6FECCrQ+hDmCIPle3ayN9k+Z9vSatmYgWBximLy+vxFsSJ1YOt6g8KGUekzBiXdF0/SFysosjbn5jZDMehqCRmcH+fnVT06rIR0IDdLOV5ik/NKh7Qr/yKM1BpMUrHLZ4LlP/VnIDebQuRfoft/7OocMq0IUuHy8LoBRA==;31:UQaWt6QZEnffifApB95DR/SJvOBGKYhes1ndsKp2fHOOOvP0T/ZB0vHKLGqbJHRAf0bDufCiVmROOChuuZpdARpLXofuklBZ64y9Mrnod+HIPjwyK4mpytxsyZZExDYBUhdZYdMAySJSZ2UGhQEGQMKyF27Md7gQooE6jrgy1mcwR6U6GuKc6xAQmQL7myOC0VYhHlB69lugGsUeRMq4roiPzo24y/eaa2Pnfugbmfk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:yq2qoy9af3N3irO9/VBSK06s0DVR0k2EUhzspcrp+XoxK82aGIxuc3GTUsi0jEK4uewJP11vNEhuyM1/wh5M/zPPSFHi+YDBm7LP/kwPYZank4UkmU+T4YQJtKjOq1JylVvEEaR62B5XhnFndKSvT76jp/4PQjZvF57mhoiTJLNkqPgeSL+EsEpAnEH3AaQ+gkCYuebd1RUdRnwWTbqUhdcft9tW2ORl1Jtd6I709tXrK+YvWOA1s9N8haHj1qBvd3ha7O/TSecPhQNB3iqMpRcSDa3OfkkIFPOueqS4EWr5ru4Ay8/IVdALk8tl02Ux8Jc/3lnkSmHVRIjYEtpwgO1xzlrotGdMiIwJVciTpjO74IHC8eHXTMFHgJfQvHURmtu6KMz5LzzA/rnNbaH4sTOrn90i6Es/VAWOt/RhLnEIOqQkkx9HvlInWksHYPEez+CNBXTYtaVfk6g2k/+52e4bOpDaBEDRV1R5hcYJEsCACcrxwaSFae0Z43leD54P;4:N81ifyL2fbEFFRtbuTQ+zqE2CDiFOgVFKjEpkIhAwdui/jss4Ak3uTjqprwGawmoDnVpQlqHw+MXtf68D8EqpLcqPKgaFgoHWKRo+sVk9gTmCZLfRzpBcLzMAoqJIIGhlw+SFYV4HcrsVLBFL3O+NPSc+gigHCdMsIrso4gFxSYXqrXktYM25UTJODXwkico3pG3b75aC2UffBDSbbq0iOEIRHtSNNanLwuNTAGMUxrPFQl8rWQaDOpgr+nZlrgS4cCzZkXdFGAllmrVnGS0i+bsFMXWO7kUq1d+v2hPe+LyedFBImswijML8RE0S9Ov
X-Microsoft-Antispam-PRVS: <VI1PR04MB132770FCEF76B85B5F9A183BF5580@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(305945005)(25786009)(81166006)(86362001)(8676002)(97736004)(6486002)(81156014)(316002)(5660300001)(66066001)(68736007)(8936002)(2906002)(16526019)(7736002)(14444005)(48376002)(4326008)(50466002)(6512007)(52116002)(51416003)(50226002)(16586007)(478600001)(47776003)(2616005)(6666003)(476003)(956004)(36756003)(26005)(186003)(1857600001)(486006)(53936002)(6506007)(3846002)(105586002)(6116002)(106356001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:eTgkE0MWpTKII4UB7dH2pnCZ75z6SAa9+7GGz+/b5?=
 =?us-ascii?Q?w/YE+NY7jqEOLnmBq/YidaP6kuyWD78j0uylLolwxUR0EuJZ5vdZFMc8iq1P?=
 =?us-ascii?Q?3fKHwAh4n4xHa7Am0DUkLkf8cMDtK18m+Jz+qzDJ43YK8OqNNUXZ6qvWbuAe?=
 =?us-ascii?Q?43DNVfQVesQn5pH163x4ZtzM0SJRwa8ta5OiiaM47AWQorzvBzVd9Nr3+YCk?=
 =?us-ascii?Q?HcArm1NAd893UtWoM5ewTmHxlC4TizePceFQFlFhAjiEy80S8cTtkMRquqCg?=
 =?us-ascii?Q?5EkPMCJ7wM1lLoiwwgibqfPWMoncPEZR3mgjbcC4RzRT8QO5k0m983L7eJwJ?=
 =?us-ascii?Q?o15ceBLHSzYQ8ISrAKfv4Yb8Tcosi4U5CA1uEPIlOAmuuGfQTi/OURLPNlMC?=
 =?us-ascii?Q?tijEwcF4SY6JYicWD449xJCGr+tX5RAF2slbkXgbOxNI36DAnUuW7fhbOA/L?=
 =?us-ascii?Q?TaMxHPy06kny2Pb13B0ybMgs+F88t8T5LylNxL4P/yHpx0iB3ZEo5jbFwW8E?=
 =?us-ascii?Q?3L9B5935C2MU15yt38Hv1Val7tuO7FURD4IKhIW8g46C8zz/qAKXEIUhr9aF?=
 =?us-ascii?Q?fVSlWTAudFlmmaRyLi+kKjtg9INUek50I9jOD3pQNvo7j2Pwxe1cKPgBnxKL?=
 =?us-ascii?Q?tuDfUiFkcaWs1zkDYOuEeRB0XXbat7xEZVSohFPM7e2AU+Crwg6Aw4qPqb1U?=
 =?us-ascii?Q?gc9ZVaq2ILuXOwG5qcn1Yz1haoXqpX4pgogBItksTzPcpBx9oNa92meF/QBO?=
 =?us-ascii?Q?2BPt9qFtYMAbleBYY0viQFLRQ94fAjH4epeGCm4yufLapuuC+WsFObJJp1BY?=
 =?us-ascii?Q?9h80b89kkFc5XVev3tE5x/OAr93r6zDrBRVTPWAab48PIv8v9NOZd5+/16Q6?=
 =?us-ascii?Q?MEh61KMUOwT44W4bxj3VXuKiK0w1mP0KKISlakycVcKABAvz9aj1SNrgMqre?=
 =?us-ascii?Q?znAjFZ6oqIp2nzU0ETI/rLdln6j0CTB/xW8X08avGSiuu21b9na694c5TMYf?=
 =?us-ascii?Q?jGF1NHTfyj8LN9kh1qe1Wnmw24xmy03vs2+MqXRzoFTJtA3hWkLRYrGLYw89?=
 =?us-ascii?Q?LDUPGYw4+LJcVMDfUehfh3Dy+/47PXhw8bejKlIenar8gK5u8HUc5qZtC7DD?=
 =?us-ascii?Q?3FLzhID7bQGKs4bwFQGP3K8axsfannz?=
X-Microsoft-Antispam-Message-Info: RMNs/0VQjUP3rzVz8R37fiyHDo5DGUwspSO5+n2WVYbS9oFvF1iBPLvoaphmKpS27yJEC3CQfJu7WG/UGJy5i0p4WQvuoDsMz8YHGFrjTlropoVxfUvIdPZzfonuO2mlBPyxVPGfrqQ99cFg8IKZM8vV2ShLUyD4LCkjSyeQXTRsfyXjH00LnxsNsDuRl7QZe+6FXzqi4c9d/q8dI/vTSWrBvjzCloe9GN7j71HklNWSEvymv129KqX3I7y14/2tqL24Eu/ph4blrf7wCsEwN/BkRqonSITrdfonSpjKvZlVgMmaVakLkZFBlWl3PkFd626mSqoDiyaITxiMHcT3ibZSUpHv4c8bAucABy11hDU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:p4PdT7wsNMMpFLxZc440PYN9FHbC2aiKqW946xrAylku48KmpYFH15ITsxcn5NWwf8ek3+jZOXX9H9RpWFy3PTHQAF/n4LBIe3l0Y6o7aZ6JbeWOJ2zMyCC8Z6i/MMrLZ04BZZUXMrRfT7IE9NoYp3sYRy0lJ4mQj/j463DGcF85rtpiKj1yIAoVZEMOaT2bHCm1xl/OZPmDGiOSrooHy7iDSYfkF893wFPQiVkcXHXqAOUsNmXfIfCsAyUzDZeAmho24HnS3pMimEUEPEDedhVFFJdeJs4eweWXMSKBIsap1Q+GXnvbw1zSkAe0pjJ8R9ObMBITRWRP0+FlzYlJZENz4j3sGyia0aYUsIqVWvzs12omEf6Hb/f2UNdDa/TuxxVKh8STgU5SZEIiavJaOv+umL5I6KJdggehG29EIZjYDr+jGungABWxx2iFFHoZPxTT3lF+KDniIKy6L5uO3g==;5:8EmbnZCQ7VPuqc4TPTyW/VlwSOeFzb4fAUkSw5j42X+kL65bvxXQvVFKJPROs8G0QjHKoE8MVYQ9s2tVyZKbkEvjsE5ZIpyM9b0af+GmqmZTWZUmugccHbL4g08ndXTsdhjmW7/BJqY7S17biE/9CBOXU0WvEdlgkbkPgNhlkn0=;24:qkPf+GyEDG2m2LYu0+dUspLb7fBhoAMi9yopAO5uQ+aKfgQlf4Jp731zEgvK6w1+5AAO/qzS9T++u8o84GF9pTv1TM2y/686p7R8jMyPwNA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:NTmvMUVpVmMhc0S1lQPEOYKYemG7GQqeOIrDTkb2ps76uci2WKByM5Kzi6vL81Noc2HJ/1aVB57/CIR3RYZOCYU5eFrLNFZRpf7uyWc+EWZV2GlZFoBnktWxMDg3KIOZL2vYTWVIJolT0NGnw7yXWAzx8BDktBNP5TTaq83uJIyrz5GWojlUnnW77r9A6qvZUdhfKozp9w8r87SuXA/vLZmhjX2dPY0gMtvAwyo7lLe8Pnu1C2OXy3EU+2lR19/r
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:59:26.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e712677a-e841-4911-f7c1-08d5e89ef1ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As display power domain is combined with lcdif node
on some i.MX platforms like i.MX6SL, when lcdif driver
is enabled, the mxsfb_load is called to enable runtime
pm, and a pair of pm_runtime_get_sync and
pm_runtime_put_sync are also called, that will cause
generic power domain driver to disable lcdif power domain
and lcdif is no longer working, the lcdif power
should ONLY be turned off when display is disabled,
so move the pm_runtime_put_sync to mxsfb_unload
and remove the pm_runtime_get_sync in mxsfb_unload
as well, in this way, when display is enabled, the
lcdif power will be always ON until the display
is disabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137..1ba179b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -235,7 +235,6 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 
 	pm_runtime_get_sync(drm->dev);
 	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
-	pm_runtime_put_sync(drm->dev);
 
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to install IRQ handler\n");
@@ -264,6 +263,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 err_irq:
 	drm_panel_detach(mxsfb->panel);
 err_vblank:
+	pm_runtime_put_sync(drm->dev);
 	pm_runtime_disable(drm->dev);
 
 	return ret;
@@ -279,7 +279,6 @@ static void mxsfb_unload(struct drm_device *drm)
 	drm_kms_helper_poll_fini(drm);
 	drm_mode_config_cleanup(drm);
 
-	pm_runtime_get_sync(drm->dev);
 	drm_irq_uninstall(drm);
 	pm_runtime_put_sync(drm->dev);
 
-- 
2.7.4

