Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57556ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94302098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeVQH1DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94302098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIQTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:10:28 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:57044
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeIQTK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30D39Mvzuch8OFuKLvgJArdl4Belc/IAr5XGBnbwjk=;
 b=IeVQH1DZhSqaNeb94jCIkOHrLTy1cPgA9d7QMwzGhfKK2BjtA5d10Dej+YHIr/HVZcRSMOpU0ZJDib4ZAeKyTnerblRrQZIpq/KjQkTrnQ+NGyXrLwedUx3YWsAi7szBoY/XGGFaQGY3w/p3rb3+uC7Z9KfKHXUcqW4Nr4Ye6wk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:42:56 +0000
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
Subject: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date:   Mon, 17 Sep 2018 16:42:10 +0300
Message-Id: <cover.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a3d8b7-0949-411f-3c3a-08d61ca37aa3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:Rx58XoU8wbFPem7AJsP91QBKJbz5rsR5HKexbEV4XfbXeZOWsL+yL/PMhJDWM6xVbN0+IqPx/FkAIJoBCNIdxfQY5agy1GwepEIr2W15ePzdf7TLnTLQvzNz40iSC8fTnZeAyill28qCp+W5sau5i9A+z1JPMRurg78NYS72b3NrtxI0UMYtiuYP0O/cQqN4Ls2kuvTKY8/zNduMfxSQlwUPjbqczuOpWttKynDSmoCXa1GCf9YfjHz36+JSPNvp;25:+99MuH5F91HzlbYq0T594R5a1Zz6STTe2OV1j7YZ4gdy8wIEuABzwkaGx7pHI35NSPcd+G7i8G6erSNhjhnIub2KVvELxMT9Z/IxuFwvpNbsNhNPjGhuUQIho3Dv9UAEvn5PLFcDums/qlEXZ0ncS5NjCD77DmsYaCL/8gPg67NRSzxi+60JrtGVx+xxCrZWMYfZEC13PWmKTwqmemOC7cINZDlYnQBZEpR/EVu3G32Azp2GmbcIwjLkDU5Msc9C0pgxDVTX62g7T4FI5kMqbqLCB7h76l42x3E6nUZNe5S4cRVZV/MZZ0W+JqRWuBEbABLapEQ4z6SCqhIQIZJWhA==;31:iPD1wBBqupbYHkyj6BAABdfdMdagHX4y8G4F29+YR+tm6pqevQEMLCyGjtjr5Wy1tqOBBBLRxtS6d6VyXmo5pQW7o5If2ouENHlxQ3x5dKZysMcGhPMAqGYE46uj3L3x6PaQi8CbnD3pgB4BRYseVj46KYsXuZiAj35/PQ+Z2NGztZPdx9gNX6MAd093B/jKRB734/7j4H4NKwiD8W0Y7DLT++CDWFFv8KEJIaNqOkY=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:T2GUareT/oKlPeRBtZrX0izHTzsWJaZnB+gaXRQ89rHUl3EIoqSaJnE4mx3OX3M/VB1ndueTqS9p5326+SnMfBkELUddPjKPKEy1HTVGl+AdDiZ/gmyfpX4EhUd/Vz2bgl28X/xP08e9BGs0YzaiPWAcQGBo5mDRVXV4L3YDxTDUgzJsCWZWadMWiWFTBRl4A40VqxJgCVPVqnROQexHXMdFwxDioMnmEkoyv/7u3kkJKi3VCthjyAyOxK4GhSx9KC3YbnJY3XAkUN68Xy6Ycov0iR+yBU4xmT7p5UFoP6mNnQNbwzk5ELigJkTEbdaiy+O3Z4sjvmZmnFyZ6OCgikvf6f2Nesu4kVjed66VFbLx1WqOZSGw/uwX1kULQdOMxldRQLVYvFdIQif2FBTaey7BZDNeyhEqbLCAz4Mvm1R1SkY4RbPOeQ5z+pjkWO7WMRTgdimgtpddN7IZZwWCmPpnM5PMmWEG9N2/UvnpBHi/ExNOH7V0aKnSjHDtT3ke;4:LErR77QtcEMYI1a+s9dX2j83Nof0dWY+Fs3E9KNq+5myTgfRn9QI99rAaVxW5nGST0B8S/YJVWuQVikVwoP9px3sKT0HrzHs6BVnpD7WMv6KcWS8bE1Sr9xqfsvrfKPvqus/aU6glVq3hywJxnyWC6txYLxP4L1YyQDOD6v0xe4XDtY5bBkN/9F5C0Qthk2opAuZDSTlLG2VIqp6rtiMXsXbUvGTwlteRG3yQAHDGLP5mIJKqNDEKS5F76wsvOu5FPH6OOggBpDNkgMjXPnSA/A88fieZLrEg+O8sz+6zsVHmGvPcw0jACM6PigjsWoj
X-Microsoft-Antispam-PRVS: <AM0PR04MB429019EA8BED858288F87263EE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(6306002)(81166006)(81156014)(8936002)(50226002)(478600001)(966005)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:WRJoJYAjpiiyvhQrDLhbVVb5bhBM0fXi3YR5CouSt?=
 =?us-ascii?Q?vO52MtTFrkZMXcGlLl3JGN7PSl9aOTT6vNyUk+o0EmWKKXfrz5OFrMa29u0j?=
 =?us-ascii?Q?wiehdK/sLUGNQcggwWsQf+FzG6asIqYxHrvmAS8Ja33ujqIiq72M9DN7+LE6?=
 =?us-ascii?Q?Q4XUly1J1cjYwDf0LT7PrReNVSEmEhkJ6Eoglq3WF/qJ91CABM8v47T6jpWG?=
 =?us-ascii?Q?EuBlv7o58RwdS8nViQLgTjyWm5aBmLbqD6aBY0ieFte24rZEk5oeJqZMRo9G?=
 =?us-ascii?Q?t8kHgVAr1Q9v8RYgb0LzwnToACz2hI+Dg30/9MZ5st31aRiL13rXU3P2pgjz?=
 =?us-ascii?Q?YBbZOGEabDicLzScgF5SqA+GW6+DplPcRAG72A9mXUBDVz9+j34SGWlGB8l4?=
 =?us-ascii?Q?LGd+Kj2mSH70sXe7HZOL8hLoe0zmiZ0N3uwovJV1ZQAww8pwNDHdl1kebBW+?=
 =?us-ascii?Q?OddGwFxwnmXWXXdzyqvgL3z6TpcSCn1ccehuoofkZIBiFeks2EHhXk4f4pg9?=
 =?us-ascii?Q?uDgFkn6iQy9Mte9p2AY0SttyGvrOne91B3tsqIbod/iT3eoTuwMjhoUxl0pM?=
 =?us-ascii?Q?tTaSYGn60TEABw92JXiLGtD7rOdCymaWGVGSiy0ulweopUy6AdRBZuBDgcdi?=
 =?us-ascii?Q?Xp7eFmHAzW+Pq5scTuA/XmKV0H8T30rVchHapk2CXjEZUvZ/7JhzFg6pMlcW?=
 =?us-ascii?Q?oSViujOlQiaPXFolyo4VZybOXSKFHyZ3TzYq9DQCofb7Lg/MIq3iSE0rYtWV?=
 =?us-ascii?Q?VFu8lkDsAq6QHaKkvtyxrlHChEblPopK08red27Z72bA6EXF6ujFg7fsVo53?=
 =?us-ascii?Q?5tVAJ5NvatiRJnsbY84LpkZAgID6qh17rZflaQaiZlPd3qQ4//sbWOalHILX?=
 =?us-ascii?Q?ExMnqKjl5XnWieaurzQjtmggLRGJt5jZ0Lus77QZbwSRV+i0+g9prDY9W37f?=
 =?us-ascii?Q?itp96ZZvPa3HbpwHdkZ2tVx23uCHYOekXqrhPXgKHfhcUCM1+4jmZqAb+uAC?=
 =?us-ascii?Q?qcq9tzutkiZPtPUovn4rL8e+x1h8KRdoDExlWTrxaWmzP/9MAqPASfAhLX+7?=
 =?us-ascii?Q?kQiR9+ok3HnhcQlJNbC+Ql9f8He3Lr7wRg4OuqJo3DLWkVgolccIusNw1MSi?=
 =?us-ascii?Q?tVksk0IOdnWzvkACNT++ifpjuAXhT6U0n1Mtw5SBRfAdeleouVTD6Vp8jlVP?=
 =?us-ascii?Q?lL+fnZjGsjbldWkZU1yItpCCmlJt+a5KQsnchQ4CuQGnZgOirPvaXTu58Lkb?=
 =?us-ascii?Q?asR8tcw98SG4OCv/DY=3D?=
X-Microsoft-Antispam-Message-Info: OMEx0yQCTmfTQcn00waU8FMqpZSQafZAH4PaZyOc80XPh5kAovV4JPS/n0m70iWRKVunmZOYD5R+iZsJKWr9aOXYPc2J6eDLOXzev1Om+xbuWzfymCIhcIl6sKdd5Xadj1wGSL2BJEquzZyU7Arh02cjJGSUVX1GLFok5TUHZg/fZtTy9+XVrBZXNPiv33p21aaWTWGHbeYTeHYKRJwjWQ90mEt45pmmgcsZEUEIzDtcWGj5bf0n8FsShegcLfpW8clRtHW74xtepLFOgmsVe/TXucuKfAu8YtWJ+RGRT7/NcP4uIx+zVFQySUwWFx1k5BJQYorB+fems7PpEUHQjIvpCEw/gla7G3XHFix5b58=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:3o9Lb7z3DP8E7e2n8riOrBFcIQo6N2Qpahbi7LEtxj9A8tF7t1Kfbf3wPIk7W2kN/t9646rhSkdMrBXzONaQvJRah7/gjK973u+fZmgI0LebEJdbTK5ahF86ZjDxaym/18ybw6246HJ+8Hd1Y/PBf/M2Xk5ZFrMWFkxMNqtTNrLd/RCzw+KQO7qtGXA4HSox62tGaUWmjD/lcRji7oRFdWmWsNKHnV5LS9fknNWN55FKZ99X+rO7uCjy6kvGPFRnWn0+C7rD8WGyHjtQCBn+a20N/MdhFf8P0OfYq1+N6lnY5kQMqMdNJx5BRl0lrUH1VAeQCwRjy7nTv94YcI+CfpTrK64dpl5AQKy70zMeNj80SaiZzo4W2HlDLnxrTNgotum8/eHYI2cjVHL4CnDXNzrCHtBS2k5J+QJjD3NCz+qGTN8vH3iG3U438NGUeuL/GITjfe9JzMTMcC2lDwba5g==;5:DGQIvenCBtXWfffH9j80AKyZfxWJYrfbwJMZmvVfIOLz5UPjemuzhrXC3rZl9fmf4UuvYjxXx2LV+v+5yUsHORXxzq+JKc0C8IaDOGQZTwOT1RESXUICMsIEwKj0B0jUO/35BVOiiOyoBsmcuvcZsDhrr82gbtP7PkQEtHxEI/0=;7:lnIX3OhUPAQXihPnjOTCIuIzcZQzC+/pqPnCapu/m+ochnqBIdQaK8J/u08OO6x49bdrRwi68yzvd+tUamHM+UUH9lFhwznJqR+ThZRWOMcKCoLuuT3Ri1jHblzsju3iwEX/bZCncsYmPKR1sOL3tvmXHoeliYbHVW1Yabxvl0ZogFUDZp4TPCM4oU3HhSGAncZTeTqBQMQwFgFCvg8j55FrZW6HE9ztLu7QwNuAB7ok2+FmVXsOIz2bUBOLk9ZY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:42:56.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a3d8b7-0949-411f-3c3a-08d61ca37aa3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently doesn't work, it results
in black/corrupted screens or hangs. While the driver does enable
runtime pm it does not deal correctly with the block being unpowered.

---

All patches in this series have review tags from a while ago and I
tested them again on top of next-20180913. No changes since last
version: https://lkml.org/lkml/2018/8/27/299

This series stalled so I reached out to Marek on IRC and he was
surprised to be listed as maintainer and asked me to resend and add
Daniel Vetter.

Perhaps it would help to clarify that the pengutronix people should feel
free to push patches in this area?

Right now drm/imx is mostly for IPUv3 but there are other display output
paths on imx, such as the LCDIF supported by this driver. This LCDIF
block is included on imx8 so still quite relevant.

Leonard Crestez (5):
  drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
  drm/mxsfb: Fix initial corrupt frame when activating display
  drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
  drm/mxsfb: Add PM_SLEEP support
  drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.17.1

