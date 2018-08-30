Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C74C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD172082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvU+wuy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD172082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeH3RTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:19:40 -0400
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:64196
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbeH3RTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiMTQiCSFvk/H+qvpVx+KDTuERjqPHEQXaGTXBEozhs=;
 b=fvU+wuy+AnhetSRN7pvWrBeK8It7BaTc2pjHY7qMWNrjnyW03eRu1+/7GkfoFc2t2EJWlC83tk7lVIBXOQRrrWDARj/3BGFm/23NPc01wLbs44uLID48Ux4/+LIQI48SDyKBQwJL3HpeTS+jCfFvzqJN1H3Q3DVqTst/uq+JSXM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from fsr-ub1664-019.ea.freescale.net (86.34.165.90) by
 AMSPR04MB344.eurprd04.prod.outlook.com (2a01:111:e400:8032::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.15; Thu, 30 Aug
 2018 13:17:28 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org, netdev@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, ioana.ciornei@nxp.com
Subject: [PATCH] staging: fsl-dpaa2/ethsw: Fix uninitialized variables
Date:   Thu, 30 Aug 2018 16:17:08 +0300
Message-Id: <1535635028-10469-1-git-send-email-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [86.34.165.90]
X-ClientProxiedBy: VI1PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:803:64::20) To AMSPR04MB344.eurprd04.prod.outlook.com
 (2a01:111:e400:8032::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad37ffb-edd8-4656-65df-08d60e7aef6a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB344;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB344;3:u2XLcKfDDhEdbfG33yY6EVaD3IZmDFC66te3/7Ukp4Fsyt3gJ/ZldFCtvguegOeQq/DsH5kDUkM2tET6XC7e/+lIoFlu9iUZggtjiDcLRX3bSZ9CBhutl/mEDtexrGULMh5dp6RKu84DT/N7F4Nw2/LXQeu2hGnNvShSzYyEceMmdEoMSELIgxASkBWmPooayUzTTUhRkhYWlyF3/fzOLUEm3NJkm+y0+x6KB0kUI6a/2rJOd7vp67pzcRfcN9jd;25:O41v2dV8qrsaR+lWv3oYeAp6VIp5suwpljm1iOwmvZIg3nzui9QOws4/KkJCHnUAvLcIyeeSEtu7aua6/McxKEDGqPewov6uSnKNUqew5k6/Tq3ouvxfJwGAxMS5HxrHAi/CDyy6WnklRyxT+ZfOw1TkqK4NkTjebvU6um42mHDT0EA8LL8cv6l5XrtPwuHzCY/j3XIBjwoMOU8uifq94a35d12tpLDVnsEI1mBcRc7l0iOBINP+GRIR5Cfj57n2gR6h6ejIdKpsMYEg3CEcPkzpIjJ2GMBSop5yZnMoEsnzAHy9K55z7YP6Y4psgbg6S7xHoBmjDrKONu+kcALvbw==;31:powny4HpLGLmp8b2Y0DdhOkZE+0S2AAmFP6tJAfpD1LpB+zOgJFQmvstbT9jIKepCl+GE5pzc3IcsNYHhml5ASk6mTjPr4bLesPH+HO+4jGyjZNZDiYnt+k4LxTrIlauTErYZOsL/sVBLBUFeUuGuKaiySTdO0Wkl1n5EBSEBhHsz/TFuJe7VsvrBXgAU0o678D2On3JMAMChcN73zihwYekMR/J9rf+vfrgWKPlt5o=
X-MS-TrafficTypeDiagnostic: AMSPR04MB344:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB344;20:6Y5eccAT4rh+eamwzc6cpwRk45yXhIMszoAzar97gtXF5zE8T1ioO9j5LVgHhT9JW8re+MZmSAAuhZEp1mFCQ0iN0ndRzLEMzZo4IRzTED5BC+NVSkdn8FT8CqN5iRuEBsIUqkQsSRlwes4i2Cylq0g6Jon8CYNbfgfQzrr90kjpk5fgbaUguG1inQUATQ2j3HY/j7vl7sDk2TKEoxLtDbSXuuQ/4IegvEUQ7YMkgrZ14lfRaFy+sO8qTBWlUKDxseTnLUtKi6/hEdAL36v4udOzUIAHJBGvPFvbO0tOH+WB9+HJ0oIlSl2De58cjaBuqicpm5UZd9yfI/IPCWvoiyx8cCtCSGevhFH4iyHSnQS2cmosvjRk91IqlA/PnzIuvf7RHuJ9tbN/JTnemjJHzhAy91lnyUho9fsVOZujd71dxWkkX4k5qhhdiZ1HK5CPIWTzeMKyt8qsPFfllu4xWWngNlgImAsvsUvvVSA52yRFYuV6G8Jn9AIsMx/F73hl;4:riDvhp8Qgd6FYrdpEtNTmBUQLI4CpnH6p8vwsVYuppAyzAk3MgJ1B6FLcdjLP1aeaQjPVtBBdcXP5z0qbuiCE2mwWGwUaF95/ZAHt9ydM3rSBjRnKlW0vedIrWQznhG/DXwP+m2dUri9dBtc9LZg31U0qMGxcuiPya13EEZiR23VZvX2P11KJAfOyAsT406bBMxjvPxK8zi9Zt/h1QII7FM1ixhvpL3oKTlPgIUhJ3EMM4H9TnEeroLzlZU+DG6KPxFpwYITxc80E1G8/wEB1CIvhLP+IatwwlavNLKI9TFUKnWEDNbbdfAS23d03KOBoYSmJuAdXMSLzz/gB2+gZUX1KfSF921YpmmVzhcIOUo=
X-Microsoft-Antispam-PRVS: <AMSPR04MB344E5CF0C71CC520B17DC6F94080@AMSPR04MB344.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:AMSPR04MB344;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB344;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(6666003)(26005)(48376002)(50466002)(6506007)(186003)(16526019)(66066001)(1857600001)(16586007)(386003)(47776003)(106356001)(105586002)(478600001)(316002)(2906002)(25786009)(86362001)(5660300001)(4326008)(476003)(51416003)(52116002)(6486002)(305945005)(486006)(36756003)(97736004)(8676002)(53936002)(68736007)(2616005)(7736002)(8936002)(81166006)(81156014)(6512007)(956004)(3846002)(50226002)(6116002)(33830200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB344;H:fsr-ub1664-019.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AMSPR04MB344;23:3TkpGlrZcZNuPy8B2f9tYS3ihpY55RN9orfJLcLxk1?=
 =?us-ascii?Q?5i9eB9CRH30t0i+9HVosGqsTbxi2DapMBGCBjv6EtKgQwfQQ7Afi6FRmGUfj?=
 =?us-ascii?Q?zrWDIWO82+TsszTbrBgdyedbdrF5ei4JumEdbOOlLRrjSC35XtRUxv6qgZ0o?=
 =?us-ascii?Q?/YlpqUod6tG8B2cE7qvfV5siwgf0aQym1SDoJ5HazW2GECBHL/VbYrMtsvLX?=
 =?us-ascii?Q?SvPejV76RI8bJWopDRPVr8zJC8w4d+ZQ1Ntzvw+1y6PQcq75eE46hfTwSRr/?=
 =?us-ascii?Q?CsbFT7PNboklguhAYdf2c4xO74GyUX9yecDdGUtI+tobw9TyDe6UB+XI1aOS?=
 =?us-ascii?Q?Ii3+0QMc29hL4A23Q/QhcwgM4BvmYlTL8n/LUT9USArjUrOHg2v1GP053GgY?=
 =?us-ascii?Q?NZ8hsqLZjfQlnDHdmwvnD97ivv8nL0rQ6O+CzuvgT8ZAb9i80lXQLBYCLngb?=
 =?us-ascii?Q?d4fffMDZkfHaPaChPswnGtRtDAAkDWGURhqgX7f3/4qZ5nm3LrE5GjzsM5iE?=
 =?us-ascii?Q?pFUYVgfL+tB3C/ds5HfVSZf/g7u/lLxvAIlY7pWnzGlg3A9x358gXOVu8Scu?=
 =?us-ascii?Q?iUmtpp1H3AyssP5QyLIxE3eP+5zBs9KUk1RQXoTHAH7QUgah5DWXP9/Oud3I?=
 =?us-ascii?Q?0ZK5sIgaLNotKhYmGczsi0ohj3cCtSbgwTBe2wQz41s+IZ6OWDnr9bunN7DW?=
 =?us-ascii?Q?kQeUDcjIb8rFOsyMa0e/ZZm0XtmH77ALIY/FWvVPsJSGeiYAto9b6qJDSrvS?=
 =?us-ascii?Q?Ja75Ap+JRq80je8uYEs2v9y7cGRAhhY84fLHt0pzoaiJasvTcSLt7XhOFO3d?=
 =?us-ascii?Q?DMlpA8eegPoMWC8lPbJC7tQ5VwZsPLJjYpYpmMr0Y8zrABIydQWncB9ipFe4?=
 =?us-ascii?Q?42QNPoNTPZrh8SwEhxgXbtEz7cuYZnS1LN60CEzFqLlpaWo130zZCbgcxImx?=
 =?us-ascii?Q?2ROB5ZXDJ3L42jvFcFY0OEjLRtRQeJEwHmxoI8XGcQbnDLAm/vFBImKDAdJG?=
 =?us-ascii?Q?SL9HPoXZLXr9/f/L9VMfTrud8xCIs5Vhaecbqf6cNMouRmXle+siCmKatEdP?=
 =?us-ascii?Q?/k08TA4eblXmKzEloUqyogXLMVfXpI49Xn6hSxc9bGFJkCRTaqbObqyaJSyW?=
 =?us-ascii?Q?x4pYHkW89YzaJM6Ap9rft90bFV2w18?=
X-Microsoft-Antispam-Message-Info: qpxioandHoEqoiD8O5QBStRz/ICt6EosvV1Ul1+w2O+cr9ts3pKsbMTsbaNAwkIbCDsMIv1iIyE+rSGAq1n9bg/JDDF40Tv77GuidwNnGTePxcRcwtVH5ebAPJUdUCfHdBch1hC0N3O2B5HHcT4IyNgnloXqKeeAbKLTIU9Dmx+QLPw94PXbacHSM9bJEn/aslSobj6+cbV6vU+ZgH9kKyGoZyAaUq9ke8LQt35wl0ZsYu8ybsxHYPqiHI+qtnRwkLkskYYyDvUWLYQgzgFKxm0KedbGuBvk2VueUHIn8IkpXYPBmY3KCToIlbl2ppOi9BYaCkxIw3nW8XchNrAJEvuarpln0HKiZh0bkdx9c6U=
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB344;6:i8B4mkCWbg0J6gv5EJyjLhxdT18q1Q3bwucGQX+CxtVAnQMQGKaVEYB5c6C6jQfwBU4zZ0tDImQR27+nW0BzbS9jRQW0s3OWzqgNq2uihV7cvLM4EY+6fLmuJ34HWNeGJ0k+GzUR8WwPs0zRVWBF5gvhqpbTI3BXmWS3ClG4vgXHKu5LvOk/OnHYGeX+32IpzWr8pYV8i85jwEOd9jKRLEMYvdC6QEkI2RuCMPZ2R47HwPUF+8gylXGK/bkCsmKWyL66zSl8+006Xi/aBeOU4PKTQ50VIljLSavkYgpZa/zjLqtEZfh8F2UFAcuXte8XmJCEaZi9Hq0bEzApTSFiV1fuyz9C8t7RU2rwkJ7rpiOiLVg50EPoIY8aLcJ9hHu7qK+Etz+ISC9XrJHIoHGNoiYfzMuZ1+5kVfkIZ7dioZSilZcqHfGK5LXaZv5mDAgxsai+kfTBYvv9gTyIKFqd8g==;5:qwwGVpGZxIiMo4BmGMQfY3Byd5nUjvo+IOsTsY1GmVBNSUt1HOvDa//CVym7vcji0iCy7xB//vx6W6UPe2RgkXECtMsIMgSfNXUCp+uePbi2Qf6rMPa22iTx94hiPRL2HagvxEVtuIMeFQpqoH5ooGS4n736/gGYCfs4FlxTk6s=;7:EtalXfII9a+Gho/V3FckdB0kyq6OOmG62n/XMECOegU2KQj8xbttrVb3VQ53X4ZJ6ogO3RhoAcaXTyi2uPlYVNe9MDzmivWbWEsnjobw+mT2EsMWVz+jF60Y3zqK7sV6p3XMZO4oH5Mb/GMNf8RoJjtQ7PX5nosybiu9QGLW/NnlF7ROmBtCD2MJLMstMozEpcdTRf/iTUCBryEa35Uwta6rAHSlXHhUgejwjbEoyZJWpEdE5hNhvL1K58ZvMJrc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 13:17:28.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad37ffb-edd8-4656-65df-08d60e7aef6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions port_vlans_add() and port_vlans_del() could,
in theory, return an uninitialized variable. Fix this
by initializing the variable in question at declaration.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index ecdd3d8..c1616c3 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -717,7 +717,7 @@ static int port_vlans_add(struct net_device *netdev,
 			  struct switchdev_trans *trans)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	int vid, err;
+	int vid, err = 0;
 
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
@@ -872,7 +872,7 @@ static int port_vlans_del(struct net_device *netdev,
 			  const struct switchdev_obj_port_vlan *vlan)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	int vid, err;
+	int vid, err = 0;
 
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
-- 
2.7.4

