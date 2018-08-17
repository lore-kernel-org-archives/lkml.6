Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72098C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D1921A05
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iVfa3HOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D1921A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeHQUhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:37:40 -0400
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:36592
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbeHQUhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K3qHUYBX5tDO0WvbSzlCQ+6nhPJwRy5e+LpvKW96FU=;
 b=iVfa3HOU4w9J60LMHOVTfZm2j4DcZ/d7F1BaXnFhLeQy+BZr/OC4PyG6ZSqi/PCT0UZ/qS7NudRwBWe8gGygVSXIqaX6dmt1ET6n64fSA0mmp6Y1Xqn0q6BYid/ihvuDnqzHMTKGCfwB+Z0VBb7E1iBKrglRduHbx00EfgwEutM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.106.49) by
 AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Fri, 17 Aug
 2018 17:33:21 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH] drm: Use horizontal and vertical chroma subsampling factor while calculating offsets in the physical address of framebuffer
Date:   Fri, 17 Aug 2018 18:33:04 +0100
Message-Id: <1534527184-24552-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: PR0P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::33)
 To AM5PR0801MB1378.eurprd08.prod.outlook.com (2603:10a6:203:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5343fd-4c4e-4f55-e07d-08d60467871b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1378;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;3:LHT0iu4f0DFe4ui31tEiB39F3BHSUMCd1K08x/oYauG8LAw5obfHShtPt2SYpvYLdzjIcqRpu13dip1zcNPVUsHyN8acI5FgIM3SwuL4/gTSrIf3/NT+5P68JoPO0eo8YRIkV35ErP65D5qqkxTsdu4Tb7CMLvTwtjuR/xQGJRatYwV7Ee4cdn+6OjWVFO/BkGi+QPqx5eL1b4wZNCjpCi6iwHVFGSmJdxxOFGLdZ8wBBTy8F//8gGQAA0kn0hsE;25:dlEyKYDZyK0FFzF7PO5wLgpMPcXv+sm9UJqMympiQyT3rbYi5qNrgBt+RkOqCoQqc4lxizikUeJbrZ9mdm4xOV8Lwwp5xkvlDIDoms1GpZSk9WcwNeWOVlRYPadIz5fdiQqU7xItpWiIDKoGLpZ/m8VI7Qq9S10zkAteC4VIluGf4gRQ+ZXPknXiR9xH4eUKdxWJNGNyTWz0doJHH1nflUSJSgN7SLj8yFEQAlPwXGPFRAQB/9Q5u1bLvzVPQYNjC0AOitZZ7nRYMQRKBYLKcSxhxQAtmZFutTyN2LUuO62TZSpmd9AINSaBvP756p63xzex84NuSmlJToLyCK7dZg==;31:RsSZBKYSUVQdrlHjntgRg0eLpqSJsWBKfBkwnf5PEr/8wcTaG/jsFCauX6L5TVbalPO52ojB2+VN7+lwh483h+r5ywSLVhd/1ZBD5yuhbN+ez1D18xOvXReSw5OnGXw8Awu2kDKEXx/I4z5hEEXYomdVcfW7czq9q3LjwTtCst969uJ3w1MGQU3xVgQTv2ZhOqkV6Teu0xeRStFMD3gEaLRukxPHQg/r49ZyZip/5Ws=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1378:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;20:g1Q04aIawojFU1GZJcEY+2a2NWorb+D/cE8J7HgBZztlw3TjTR0ma2EAmkkPgYe7HlQ+2ljNa7WkpvW1ipaDEcNCqZe2G0J1n50PbHnioJ53HUYcufK7E+7Z62+ZK6zOjk+RqyaWJ7VgNQTXw+N3P+HTS5gYklnaMMdQ1dC0/lIOBRvMCbmOeBGunQVYUvyWJzw53Gg3h5VhyfdX714r1P+mwUsliR9cs814FFMIRuEsIQriOKwgNlcmfA6BGSR0EyyXNP75Zd7e7SyBZ5UgK/wvvz1NjAGnbLmMudxoAVVYWhGw29jT2S3+avClKxk19yDG03Yat5ubYRErsTXvIg==;4:4uIAJO4lrQzTm3nfQ4hO+f3tURDrue2L7Tqn2WqFe2sSjCwN6HN6LIxm4oHFdFYdc5Zo+tYZqyaAS3Pa8hO4lWOq9RmuU+Omy6Fn+ZXRCQg1z3TUKq7aogOd/fyD9HztT7hBywYhBkrZqZBJbfxUgMWuntnSQ3cS0KszhMftENicGhx3waVZnM6Np+tJVSO3+iBPt5q0zgn0I5qaMjBe6khWjyNjr6MN/myK3n1HkBvUdjCzCxKYsXWQWH0kb69BjVkgA0FrN5Xs+EAFNoLl1JcC2q+JBBmYyJz3nmbB8wT1kA79Tdlr/5B+vJ4ULDeE
X-Microsoft-Antispam-PRVS: <AM5PR0801MB137865AFDE526D8F605A0235E43D0@AM5PR0801MB1378.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301064)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM5PR0801MB1378;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1378;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(25786009)(476003)(486006)(6666003)(2616005)(81166006)(956004)(316002)(16586007)(53936002)(6486002)(47776003)(8936002)(68736007)(8676002)(386003)(52116002)(16526019)(26005)(51416003)(7696005)(4326008)(1857600001)(2906002)(7736002)(305945005)(36756003)(575784001)(86362001)(81156014)(478600001)(72206003)(97736004)(105586002)(106356001)(48376002)(50466002)(3846002)(6116002)(5660300001)(66066001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1378;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1378;23:hakeitnnuRC0rBqz9RwoqZa4uLgYypoKhBk6OBs?=
 =?us-ascii?Q?B6atLk8y/kWeMyc4+iGrPyVNfQ4O6FHvk2UHaivrPRVdzueY53gXNDRaMAYr?=
 =?us-ascii?Q?O6KK+HnLxpOQ4BpPvRbsx4nuJwakJLDg0pRsqgcVCmu+MjlZqS70mnrkKx+F?=
 =?us-ascii?Q?2Rj1Nv7qRsIGoygfppTx/wo6VXDDkLl99Ni675Anb9TtxtJCGridftAo71dV?=
 =?us-ascii?Q?7o0PVpzp8S9fbjo/qbtCLtrRhu8dqieXCCXumQFasE1nmf55T22D+3W78/zN?=
 =?us-ascii?Q?GgUNdYpMwz4g5+/ZK573szE6VB+Rq/tQLD2mf0QuZjAvtWFwzkMTj85sz5KP?=
 =?us-ascii?Q?ymaqYgY9+buFi9wybXCnuyQN23NGcUtRscn7BbBKwXKRJ2oOeYG+zRhJfaid?=
 =?us-ascii?Q?1zLHi6DfxmVnOj6cdX1en5s6V0GrFdoBrOtPjZ9pDfFyvrBVLJtbeOFu9Jq/?=
 =?us-ascii?Q?9TRvOxvaCTWRiZLULyAA0HQIV30XKsKQOWx27CtsSClZAUrSlUNWI07Y517J?=
 =?us-ascii?Q?Le8RZgZgEiSj4ySbveTYSJ2VpamqzpAExX0BHY1zvyoIWMh7y7kt4CyxO7Pz?=
 =?us-ascii?Q?aRtk91GWGGpcTjADqi5Fudul3siaWt67m3siRYitI5PaDFeCOvTCN+npnKyj?=
 =?us-ascii?Q?RbeKyqFjaqv6uV+R2cyRP3QV/t63I57MCct3NIq3lnpN8GPPIaHfqWa5JGBl?=
 =?us-ascii?Q?7+vENCfG5qUasvRJIFxAW16xSNp3YVNrmhXD6w3mAAWuRQ+FDNvtWDh+b3Tf?=
 =?us-ascii?Q?GVETt0ZjxKgRDL6KdcmdGoC394/mB8sXnpGRHD/DlZsWs5Da6BkimM7mqSfg?=
 =?us-ascii?Q?YhAWM5OYovTNj+wg3FJ/x5H0Ja0y3DSQ30FfSlk+EpvoJsnlLbQhXKZunpFL?=
 =?us-ascii?Q?XuCCIwtryQWgu0rzPyiYf9h3FrrTj/xKphhYPndICdOt1FS3sRw3roa12g/9?=
 =?us-ascii?Q?dtj0mGHCz9vlJms3SAXT0PRdLlgrIu0qFOiwwQT2GSBkC016Lfe16LQgqjwx?=
 =?us-ascii?Q?QYNqdq0OeahKYvD3KSuiySGOo/hHh8zgsReBy4HEENMDlfvQD/IWK89wmNsN?=
 =?us-ascii?Q?wZuePFcJvIT8YMEGRYTsIkRV5goi1nUGyFnaEgMJi01gRkSdUJX8g69RzQTg?=
 =?us-ascii?Q?/OJuKQnA1ovM=3D?=
X-Microsoft-Antispam-Message-Info: S6l9ebe/jqRlpjxMO+ZBC+sit9/OYPNTXZn1/Ajuc99Le0YiA+HHb2fnFF/ExiMAk0YxMlRwvE2K3fWeVhsYotGqXRo2sI1TqB3/ljwwI1Gcpq0rHnf+NBUMRM7XU6/8p28CSqd2fm19/R1azYfx9Cj1UXTBpc5fVHYiOxD+7wT0QLWYp+HRbhcnyJIvPajcjoZ3n0fulGGywcNRYdyoTHQpfaC8IQOU55KLmvnBXfVSFozruRPFqGLu6yjLSy4CwOw/DBM2HZhdci8Ym5OwqJKa+KfFdX/SlsYRBSN8Yvelw6sCCLGz85wo0JGzsPGXtP5bCFlUDvFhYwh+wxgDA7xOnibRu4g5xqQuknCkj/c=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1378;6:6D+lwJCH7ER97WfZoYqHzjOPVjwT3pMT/WSQYaK0jT4uN9Vp0hxJKMFB2fkXJnfXN7ZECUQ2TqUoCyump4y/UmqAUzoLqraO4Fl1q+2TBSMF5r5bmldh2LwWjJNVh0QBzdD/H5iqaQWx2l8dgiEf0drmZKrML8DOpbXvSlAM/TNZTMGGg43bvkiCR5nhV2ZiiJjELm8dKNj0hIKnCwmQ8WW/wG+QSI4K928vSF9B0f70IGl2bhBq/IDV522GqaEWbuuLueWnoW7Vm3eTW7iuffOfWfrKY5VT+aTOXhZ45zjZH8dd5x4yiYzSOEIXG0pidlL8EJWfmh0X1y1emdnN1hcwmphuvCmsMhq1yP7ZMknfK2X6Sp6w+j2zAYk7c2bo52cW4z2w3R6Ym0uEzoxdgduCj/mUvQUTQZf5dHeb34g8kfacM782gAtWTjnk5Q9zZfN7FU+91Hob4vy+6N2now==;5:OMvDJ4ESh6sPppH+I39tKlAaCZppIWRt4+47HbsrK5xw/hJRaSP9nbcsxRVrVUc8DPBBLx83FqGSjAUIkniMveL6CBoHBxazb6M/k+wDwQdGFe5pwONYbxvblVtwFieMeeEG+qzgRCSYerXnI+BSihnRW52LgoLpt/zQS/bguZU=;7:Hz9YXMsmdCMqnuD/bv/2ow6QxlidWoTZT67L2RP8fvoMrXZ6kpf8p23JkeeLzJJluu8BjfAVIWR3WSQN5xQPmSj5egdkpk+40k+ZE+ox5FJmFfcj6XQzmotWplR2+kqbvx5mDu40Y8eKfHvhw3QfcyhcVvLm7FklxikjitI4zArh7ccr4yruEGFl6B+pOqidK5Vh9qZacj4RyLE9YKFR98G9TlLucP2eYbwURHysxc2iLxmTv2JFBqobUp4lPsje
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 17:33:21.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5343fd-4c4e-4f55-e07d-08d60467871b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multi-planar formats, while calculating offsets in planes with index greater than 0
(ie second plane, third plane, etc), one needs to divide (src_x * cpp) with horizontal
chroma subsampling factor and (src_y * pitch) with vertical chroma subsampling factor.

The reason being that the planes contain subsampled (ie reduced) data (by a factor of 2) and thus the
while calculating the byte position coresponding to the x and y co-ordinates, one needs to be
divide it with the sampling factor.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index b127061..47e0e2f 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -86,14 +86,21 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
 {
 	struct drm_gem_cma_object *obj;
 	dma_addr_t paddr;
+	u8 h_div = 1, v_div = 1;
 
 	obj = drm_fb_cma_get_gem_obj(fb, plane);
 	if (!obj)
 		return 0;
 
 	paddr = obj->paddr + fb->offsets[plane];
-	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
-	paddr += fb->pitches[plane] * (state->src_y >> 16);
+
+	if (plane > 0) {
+		h_div = fb->format->hsub;
+		v_div = fb->format->vsub;
+	}
+
+	paddr += (fb->format->cpp[plane] * (state->src_x >> 16)) / h_div;
+	paddr += (fb->pitches[plane] * (state->src_y >> 16)) / v_div;
 
 	return paddr;
 }
-- 
2.7.4

