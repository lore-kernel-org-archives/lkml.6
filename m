Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064521A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lkzoOXTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3064521A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbeHFVmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:42:07 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:22570
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729976AbeHFVmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b2eAL0Jz9nVMx8ybjIUf6Cl+GnGDdmnLRQufMr8i3M=;
 b=lkzoOXTV8i8R/HjXYK/ERyt6xAzy5XPC5BofedL8c9KUB3+DZxxp+85xaE56S/LKP39pyihp8ggRZHXZrh+O+qJYVnma2tG3yiwVkPh3+hM0POJSJl3+jcnconfys6LcWA5yZhkNzWiNbc2a5jUhidiyGFi29EEedonQJY9HAcw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:31:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
Date:   Mon,  6 Aug 2018 22:31:08 +0300
Message-Id: <c5d67c9647208302dc5899b3d88605fbc3e3e9c4.1533583611.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR07CA0162.eurprd07.prod.outlook.com
 (2603:10a6:6:43::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbcf297-9feb-4f55-1d64-08d5fbd3356e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:PUCyG75gf0CTAZ3584TNwnVbnqveRP4/Zf579jLSr5nfzR7DYvg5hSRiNini0s573UxeW1fMiyqRvjvuzhtOZLxneBriGOdyipQ45vPy+8F5GT3IRGBrktFx8wUhR1mdthmyJPxEZqwPl3yTEareKOIZ79M9whhoDj872r27gcXobesnL8Ct5YjWErRpxfd4s/WzYR5UgN+DdsvRGkpLA9+pcWHs/qqTBF2AUedYn5t+XQgTx8h0cD4XkQjmRl5T;25:UAV6XBLb7796L40cybXuHLgwHnFRwEYULx+un7JqNvPNvaqiXk0v2v8VH0nrfe3ArsqRTsXF3hu9uoJYhuX+fd0YAn7PlgCzVt0qw0bUVdqwUVWAnUjo5Kc5OydbuclvaEG54rFL3RV910nhClTKMT2htq/03k9AZAHED+l4ouPIrjX1jmlRaCG20t4dG6xlPoAgiMUIS0Pu4UstWiXjjbWZxQ+QgBXl7dQS+5BAbP0QoZXdNqaB2A86xHz3fUWieVuFsHBf5qpaad+SFFFwfvc7BBIzuDytp3lEyRnIymfeZPE/xM92bpqJU/iGPbga/nI+QGRp+ChWulVcoSX8HQ==;31:EniSCVTdJS52JqGgG9F5XbaEtFc0NBK18mKRWf7HJb8c3M8Pzg4/vYq+lYZDJgWSuJlV4HQIwxHsjis27I3SxLoGggnNOA0/ZxwenXGgQoQPNyqx4klXvRBqKf4GNAqUwoWGtgbLq2hB0DlEVtGjF7e3o/QiN+udZkVp3Gxj3bXk17/bMViMfTwoveYDtUup8PDsDU8CRfCbT8Gc8Hs1n/JmSCpahARhGPQE3LqOLkI=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:CzLoIId3Q8vXff05JfbbYSanleKmUbYipURS6rlcyUbBkCpBal4cLjWfhIEbjT6K1WPm1kGoiKOQ1iFy1Ls7R/yvDht6HSa/Ig8qelWJLTBeE5EvUBWleW5pdEAWGvaXoqPQjnG/O4AiRyhcyguyqJwOek7mEuoBJaHOA28sWnZ0DGiw0ZKJyXNlCJu/bCUpCIoYWszLp78kARfCEJGHMHBItILawF6ZkjXTUJnnn3ffDtR9PYxxAjtK9OQDrOzkSogj7maKKikGFD7tX3CGOTGgAw/DbhS0C/FdmJDTpXs7f8v8uQ+TYtaBn6Ydu/UvWaKppGSughA/2Q97T50+RtjnFSNMgYYcFw5oCKXqo1XGv9vK6sK5Sw5gjHhm43dJMW4m4VWAUjUdbtaHQC2RxxAr05KWaqRcwWdivsFliJIWL87BfdTapWVStbPJ5OnZnsR4Iy9SU1GPO9pzwDrL1r7rllrn1r2cP8/r7e3OWnCcMzkte+8eNCYMlUtWofYp;4:xFoVJxoty4nQSDcUn9+u8RVYbZLkdfIFJ90AS5Vh98aDBNtPpdPkRGPIBHddREvraIeEhCBMOBa4GUqLcPyxTVGF9nRVIAlTHDWhv1fSL4D268xKqlNc1hOn2pW+/rIw8onrUJMX0Owc35dPfER9zkt40Dk5M1LTCs6vy9KFwEdvvsFyn9N1L4LZA2Rccb/U+NTEeOh8vcTuIpzyTNEFQRQI3/nuv8+ZMyuVVpPBgbBLuhgafC2xRp6DcGuwoEtvqe/ld5f7K4GDGMoIlbTJOdTKGSRg8TsW9bvDwxX3LedX12mFm5W5BzOYDFoE0BAR
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290339F81BFFD828CF8345BEE200@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(486006)(86362001)(575784001)(50226002)(76176011)(316002)(6486002)(68736007)(14444005)(386003)(6506007)(2906002)(6512007)(50466002)(51416003)(5660300001)(478600001)(6116002)(16526019)(3846002)(66066001)(25786009)(26005)(47776003)(305945005)(44832011)(186003)(8936002)(52116002)(476003)(48376002)(6666003)(2616005)(4326008)(446003)(118296001)(54906003)(8676002)(105586002)(81166006)(53936002)(7736002)(97736004)(110136005)(11346002)(956004)(106356001)(81156014)(16586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:2Ee/9o5m0ppIPUcGdazGgg3/BtXHqacx8d8mK8N4g?=
 =?us-ascii?Q?jNTYHe6fhmmB3JGzdfZnToc2WFjnAVl0P6WpBFaAH3rKShKJDLLxb8SqeDnY?=
 =?us-ascii?Q?/7OqzxhRwxOMbt8J4KiJJkzIVbhauAEG+MagCPRGZPjlfYSxk/13DniBxaqe?=
 =?us-ascii?Q?vp0he6PqHXuF3e603AG9oTOQkb7ojS8FvZjzFIRBX1rJ5PC4zreAAkhCCBcH?=
 =?us-ascii?Q?CAqsXrgKHOnTd16l9RK8NL6b6SryCaSBpNSVtP6GL75j8v9SzZBQeoYkyQ8e?=
 =?us-ascii?Q?zv/cgCuLhwaX+T6EdotwEyCtCb2mtdYgbYWZImNmrf/6uhLPegkBmSyHT9Rz?=
 =?us-ascii?Q?3mlSgwD3BcLGLn/E/cCrW8umEREiEQMeHsp0ohMrU9EGIegh/3rzy40yRFER?=
 =?us-ascii?Q?4MdDUe260chJ3+pkn1VDEsYN+tek0xvX5KbG/peeYA4B/2tkXbDU4Mto+Src?=
 =?us-ascii?Q?XcTooFhUyLcdZWZQTEvEZ0J2FE1L7o2JhCupYzAD6tFUpuv7wQVxTqrDyskb?=
 =?us-ascii?Q?c5Ep2MnXs8R8WsgeqJ3dR+Ay8DLEz95nyk0zr5W+1xZtEx79gCHszJTCEo/H?=
 =?us-ascii?Q?TyFrt9JllBJgH4CKHyDhUqQ+GfJ87++9D1CQw+JmDEWcpft5SRlF95kntGku?=
 =?us-ascii?Q?KZLBnSeUHgbwlLAP8xD1dagAet7++Dza585ed8d49xv8wRfYkfRmyMr23DLR?=
 =?us-ascii?Q?IBxZl7M2soiDkp4RNQmcwuyPBRPVjGWAICnjuzj/fkuHO4rx/FVikt4qlEDI?=
 =?us-ascii?Q?iQMW53NTikuy4eunAOaPLJg6igp9Ys04in8Y/Fo6ZE0J7ZVQuItjyc2gI3QK?=
 =?us-ascii?Q?VPgz1dvHZOGCxd5GUCoHzA8VpkMWO7Emwmu+s0S7cG0yfArO47BkJNFQ0riY?=
 =?us-ascii?Q?wHEF7yMDYhegEfhwNVIgcddVLKuAAI0EzTrKOtNy3qGJSXY+ZXtjmF3LRSgu?=
 =?us-ascii?Q?1SZMUJRnYV9RBZGbZf+P+iZLLMeMx1wCdGj69V8P06qcHrJlicmeOFJf4vex?=
 =?us-ascii?Q?2htHTWu/dPgCV5DNfQJewvkOFepMj+VXAkCYoPLVlpZiSHz25wn3DyRZU+Ao?=
 =?us-ascii?Q?AYcdSe1TIZbQ2n2u8Rd8h04jNzEmpdI85L0lVIGpL7Wo8LHoNs3tnz9vO4tm?=
 =?us-ascii?Q?Ee8Unl2k8BDtP0iyzitWfdJNIRvTubQBX7fY4l7tF5X77kuwxUkURs72X5uJ?=
 =?us-ascii?Q?Bpmuq/kI2kdzL1gnB/qgtyF2zFODfWde6USHCKH4f2qcBbBoIRIBIW7Fm02z?=
 =?us-ascii?Q?C8AT+neJ4G2RaTFjYrVKdvVkyg5ISKzy+6OlQIyrKAxGw+f2KaqSiQdETQiC?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: MNRwLzQpG4AeIHMQLUKTnkqLiR+XcbNI0H982N177LXpWwd30qTESifemnrEYZSPBQHXqWzLCyKrzOYID7VRbGYq2zZlRogXej2hGWetvYxcJC04SPaW0mtrKEex4pbDjNZO7z6mlHfgTft6zJ8dTcrMJbGEygHPYiCnjM1s6ihQd9tUI2Z1XuchoHJ7cOJ9PncqT4aaLXF4DXsXQ4GqeS6YCC5wHiidvOjuvsAHd5cbv5LBXUBJNCIRJAryGkWsXkWmG/xeqkwK9O3ivpadkKC6S+x2CnnSv204S1TXCt9tq3zTWqWUOEDU7TSoXolNun0s1nbmrP75d90nyb0u2TMdWFXLrJxSJAhPibzPrgU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:3c8H7x3SmK0v5D9xjVtNZlgXij8yON7uQVjypWkTgytFerLnM72lZqmhZqNUwDFlD897iSmiUI/fVjeavMj2z6URy+jzkfw98TYF6D5i28hfzemDh72E5AUJJglcnnEn2ZKyP+ViyhglL91sqxPW+8xcnFjSD2M8tpCD0jFR2isZln6gWW5Xg1No/fWYd3HWdHAJiRNDhxoP6k93sIure76g0L9ZdB/wf7tykCu7jGXqnnafZHqiA/SrmwTlT8NPnkTmzfTQ6/Scm3SMF7oR1apDzMyTXlHFwp78+422ij5bSmWmfKklrif/UptBylW1USN4pcUbhqjjfzv/GL+YeE1Z0J0QGrKYiTFitHjLn2Vurlh01fPiiznBt8pobyXhr9Vv0+igl/LpWLM34TQOB2F/QGYSgkOg0dwKuxHRJhaNXz1ar6y+Yuobb+LRR8ELRGBnUc3kHsstWyCq/r6S+A==;5:ygDENSLA9hUHo+VjmuJWX6v3A0EQSiFm3kOpTqbmeTYEQeMTOrsf/a1QkVglsLlZju7P8w7wIuZRCkH9v/2huczAykSAqRy5rHjpi9CAUq0jKEfOzmH+mr9xHt6Uzt1YtUZFLVdsVUilkac1/KlNCgDmQn6PftTTw+gXZrF/GCs=;7:h0eV9Fz07qHI+HKBNJhlLGcAp+jM+Pv40lWojTFPsYOc+xD1s00J8E3wKYNQhF5gIimdT302pDrH1m9B6mE0aQA1lD1lg3xhOfYitzLugR4ReZUTrom1o3dC1WYCjGGD6y9mwpflBLEAJyEm+CaWXmXLO4mMyblllDO6zPMLTGjZ9UKBldjJCbjQfoAEmC2gSsHNOSC9ebIdNS4+eZGmwQZ15wP4W/RieTvbo6XgdU7zOCRzyhrqLXNEUuYxxhXY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:31:28.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbcf297-9feb-4f55-1d64-08d5fbd3356e
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

