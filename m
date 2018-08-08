Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D383C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2021771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JbeOsKNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F2021771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeHHSaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:30:02 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbeHHSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QAhmaXx6KCcyr6kdBHbCSNBB1V8087ar5J2iuHWfNE=;
 b=JbeOsKNFUWPD+6YFoUUuVzBp5mZVvg8TCrfH4uZIcuAnN9Hsa2QYIlB15m4uUpd3a4wB5PVT80mzB/JKCYLQ/8njvtXMRNAXj58dmmVIGjIgwpV3VvHzYnVNlZiHj4g/MgJCRJG+h7qcMvcOCPEKTFT24gxWOOu2KYPjS0QnO1k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
Date:   Wed,  8 Aug 2018 19:09:00 +0300
Message-Id: <5b434a3d8b2968552e9bdff9eb5c78266c3bb28b.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3e8284-ceb8-4fbe-fc31-08d5fd49543b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:HCY3JrMiwzZGqdMU+3Ofd4ivnwTTBrgXVR+/+bhe7oOkeScxDdhvswd6FYI7QcIJmfoIL7w78mv76k4+CsfJAJfzfMVvHNeA/Kae0ZCt4v7lWspkcjQz7ZdauDCGgSFE80BrvwKefVHKPohY4ixyDkZFcrIVK56L8sqE2yPrV+efXhRyzlNUO8spuuwJdJHOvsfrOqSY4JHnNzXtd6nL3sY0U/5PnP5S3RSHo71hGaG2bQpj/bOccY1D4EjWsty1;25:XRmKZNU3c4byG6yT9d2BxxUMacFoB08R7MGwGuutPyLWGz9DDln0SI8Zy5aHTAYBl4b4nYQqgKAfczXs1tbnYFH2EywdMOlo/WZxaKidfXOH1lu2UKomcwSUiFZpvB06ynhMwP8mGyyQG76VbG7ymHyQQQn5+AU60vAq5OrLxHG/gDYCmgRwGgnXfyVyCMo/NGUfEawWyqQZXRDTVXXctZoo6x7W2Egxd5R0h+b3EUMhTulytJfpH2TPMBrVVAaZw/Nmoe26rjUpRZ7JEtb3rczXPN5HFfQyNRO6TAu2836VE0ry4nZX+OuwfuDmTKF3C8M+utjWOKIe7VxFc4I2HQ==;31:t4uCYjdEmn+gwG4jLv0DVJ/ulkMSZeoHnqXqOHWqHcqV3W+/suqEiRKlj8B01dwC6bEynnRXlc0BnW0ywJOJnaVTouCu8P2VTDL2Ol2yG9lAHy8AXzxUKy7McEvKn8QHiRGAJ//M5JWugjAerwwxzHWxsCcnYYJh3rdfDFyLN4h9FOJYP+JlyhISxD0LxB3JQ+aYujhSWVoaRahigWZpzujumxkAOB+jcIc/0UorY5A=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:lJfu2OstqSeUl1RiT1IfBxKptXGYfXvpX/rck390XjwvRd9X9/UOQkDFsF+b8SIKjOGmszChq+mqlxus/qFDdbXg+CB3Mz8rxxqcnpQVFqUKc4Eb2tTS+zD9HsJbxHplW10D1AYQlMgM0f3vkHZEVO8MnE74XFn3Y6pyLqXY16USRhHfeGdvK2sNiAMn0cfmkgf96u4sF6u+BBf8+2V2M6cdu9iSObsId9gJQECbQV6FKhVLMeyM9uvouLG6pqmbtYbB+48wbY5B8MvTk0NlXv6VMjWSt6nJnIUP7URGU4xtsDpwloq98HEG+EcLdIRQGJjAcZXzuMuYmkpmUqzJn4xZDQiO8m2SkPfYPkWxFUDF6NBNfVmpXHTh01YIR0jMZ8xzbDOUxP3uPC6yAxJhTpN1lGpSKwa4oZFFrlZM+a66sUAE4WEphgjxrsmTjkgCyRaePrfmNXa767KiaSJLpeodafiBb8AGzvAzdKa1gG2Py1B7tiHNHSLf/mWbvm+Y;4:EIGGgQEOVtLQefZV6qnkvCEpnNSg/DGJD+q130izkHPJ7ZPD1dOhbO2hV6tJ1+kfrDMyWI3YQ8N4ob0ICOcS65MjK5jzEir6wbR2I/TYe61sZuezHdvSMcf1bhFjNx2HltdyexoS3Ik+gpVlfWbX6CCNJvYgqJennZ8xX0drSyYdNjpaKYQYZ2B2yDzlxzIB2BFVxqNUrvoSbVdGaVyNMgs0i98DyJnEX8+n7wTEU1v29ATE19PY2zovlrVWNyg14zg771CRQ612GGKmT2bvz0bg8rcxP+UZbZDxWs615+8rxACbXdMu3UOx6bPMBjnP
X-Microsoft-Antispam-PRVS: <VI1PR04MB4301F83A44424461333A1D5CEE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(76176011)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(14444005)(305945005)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(575784001)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(11346002)(2616005)(50226002)(386003)(446003)(476003)(51416003)(52116002)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:a6W7MBoGtyGyLRWRsAfUmXb44FY52HCrj7WXmy1z9?=
 =?us-ascii?Q?OjDxRMWtGzvswikUOL2Fk1JIyLVWHx+y+60czaNpUENiCjdOiTJKfgnStAr6?=
 =?us-ascii?Q?Gi8L2RBtsfFzjsF124MqYtYqmOHYiJQJC/Cpn8oJHcxFlQG1M0J0lGnDNH/e?=
 =?us-ascii?Q?QyROitQBarTlQZarN7HsFFv8Fpyyt1bdJzxA/m5jWzXILnr+rNlBUzI6U9iG?=
 =?us-ascii?Q?ZyKkbveF27fByo4rewVvvGQ0sqcFPvVcPgmXBbCrt466iykG2KJgW/TdrSo+?=
 =?us-ascii?Q?qGcgCCZ56xIAGmM0XmR1vzNLOUxyeUslaw8W9sLZuJ6lmCTnbVcEgL0nMPYT?=
 =?us-ascii?Q?ouplPDCQe6zjn1n9wF2RAQS6XnCFDK/3pnj48/Wx24bW6vwONTEG/k4zXOGk?=
 =?us-ascii?Q?zQuJt+w6LBeUrW647uclGHukyad4BtXTTpRh8x5Un7iO/OJXBSuqjOwc2Qtm?=
 =?us-ascii?Q?RWDZX39ThZWMkJxurBN2VQkxt10g1X05j8GF22I/d4p6X7IjETeONGyR0SW/?=
 =?us-ascii?Q?0S3tHJ4NDwgFbezjdw1EIEe/5ZXT5kXa1TnJ67k9zm2Ym5uQ0lZI+C2lhrCX?=
 =?us-ascii?Q?v4XXtZPVyCFjk8k2cESQYNqbpI1c8Yv6BDoM9I0PY1R0kiOj0+RtvXOv7pkw?=
 =?us-ascii?Q?QvvSHzVXjrPv0ijDLs8o/AgcO2O+O1isgzTb0uxNbuv80qe+jhPwUcK595D6?=
 =?us-ascii?Q?LkMyuXBPdvSspYCKe+h5sdmfCOKA9NyokRVu66MIF2ERPY0NxIMt0wVdXVsz?=
 =?us-ascii?Q?fwr6I9ByuVXN5mBUEBgTG/+B19N+9bryQQOrje/T+BVKyVlsTb5oQ0pU/dz0?=
 =?us-ascii?Q?YHLorDZDGp2U1qrttsN+v1gLZIIOmCCHvsIrTvx1EZorBR+aZa2Pt4GLJ9bX?=
 =?us-ascii?Q?Pi5EkP+Lp6Rivqrg8m71ZLlBzyY8GlLAkD/+TCdPS8dio3FHf++7L22PGi/G?=
 =?us-ascii?Q?K4o+gJPVUyRQDZEczTRQEa01GGZ0s541aPtijbXVh6HqUYpC8XZhtmlaERtA?=
 =?us-ascii?Q?BI9MqZHdk6v6cFKmXYz7b3RsDbCcjcITdBO42xsbmnVJkRXAqcmv84R9c4qI?=
 =?us-ascii?Q?nwJBZ6DsUde6VZqndED6+ecTeZwAktOQh96cO0aP3yH/bBtF1o8uNBPSZ+kz?=
 =?us-ascii?Q?jXJi6+ZE8znBuJYqARDo+f9JvFEk33/iVnMQ7ax+hb5+RogUpSK8/58FMgFa?=
 =?us-ascii?Q?IYd7pFSKo3TrF3XKt4qGPoRAjSe9Q4HcKGE/J7FX/p6WdzsOz1VbdBsEAyti?=
 =?us-ascii?Q?CaEAktcHOdtmn5mU86w3TT/inoR+1uWIRgJIH8fhWiCj64NWJlpzJ73auJwi?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: zGSK8MwbJewd6u6lmqCaTS1rxJ+Eaz3j/nNDJmQ8CI6DpaSdOo6JD7DET+o8CJ4dhAeVkZpaLgbNjYiR2BtZelsLMpYkUGstDgPAinXci/XtuHQ50CH0QmCUG9hGO0FPZHirkcatM/bB6WniQi48N2H24h87M/TrIj0OjA1NnbuovabEIlEIxzrqeWGPN55WSOlzzpBA8m5ZMsiMMXLzGnp2ZWxzyFP3DSEcMajskBYDGe6UZSO/c6vMM6lzmk6o03W2uN4UoeW68drasvnyr7VzJFXGKX1nQUnvC+LXLwcE249YBDp42ETCtc/Qvc/ldzOakNVE8W4V8KB9N1j2rVkFxCkrSBgRGUVOKhC9PZk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:Yub+j7pQhVGF4RwVglRgjQQ1s9e1UT20SW+GQ7fAf6BAPze5Z50rc3J9w2BuPUmTMp2QnIHxneuGrhE7jwEuCfjQL26A6X39nXpNaHyCEBnedAkJDaERd2tq6rGYkZVtmRG6uSDkJcSKi63ReBfh2giYmcoSfDuioSNij8G73Zb04xi/KaPyA6+LKzrmRRUVIjopIe7VydJPgTxdHMurlru9oXBhfZ8AIl0e6m7NADg6ikNDjbHpA1HvI+m+cXQoJJZNZ/WBd1IOGX4kSTt/JaEQ1ty+WdQmBRGT3nTLmnUB24WaBAdImu7NJoARkqfPZsLUKY+PADMJ1TsKysREJEkMnNkAtis6CeUGRnQo56PpUyk9CKRnZAtm2rUfgYvxJyDs/Gi3Nqix7gKEn6AHY3+rEjh7syk8N2iyeEY8sPrVXK5HhEcKFkRAj75hrQ8H8ImRSQ1brrwblkaQy+Mbgg==;5:VBOXR5MhUkQDKl+1q4oYN46BYpnINq1R/oDi/IDEhzITfYZF/GmlQPW7UU7fEdDLIKStpOHzqOInQMHYkHFwlmkFh5NOAR+IUgU3oCA0IO9nE+cDaoFvky8V+Zzx5TpmvCdz0DoH50Y5CpD9MJpjgSBZxzfJGNvtRJsIQSqYM8g=;7:ULHRbynEAfEdJJlDFeTstpfFeZ6dF1Cpp2otlxr8vzdgbWD1O45fYDkO5o6l4TS3EZKp00Ig2O4fastr2OWETWfSJVIIItXR9K+dXHFpb7upgJBNdjle71/mM3OkoJAWZy8RWf3ufTFpPpHY1xPQmf8Iz4fdPfERt2MOY7quCIpYqVWMLlZaocvdnZSoByFDUTHQwfe9gt84plSy0iqN5SJzlWI8Gk0UKLcPUedYeiHouQMassFujXruC81/gpON
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:31.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3e8284-ceb8-4fbe-fc31-08d5fd49543b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
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

