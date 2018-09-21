Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E30214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="BdIzqtti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E30214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbeIURoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:44:16 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:23472 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389879AbeIURn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:58 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:24 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 22AD974130;
        Fri, 21 Sep 2018 20:55:24 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="293141294"
Received: from mail-ty1jpn01lp0184.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.184])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHnQvTZrTiHqNBH5gBdwfGvJ6i8eJmu52SiL7tv8w0o=;
 b=BdIzqttiZc3Ep+sAc37l4DTW1IWE9cb5qYZADOvtezktaVP+Re2tIxag8eFX9xCBZh1tOLfeRBa3UrcVW2hL3ngXuWJ6no3coD1m0WMQq6IpZZFKUwpq0uNpq4TZOLlfl3oWOhQSg+Q+Gm5Aw3F3ggKTOi6BqB8zXqkdjbZ3Pq8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:22 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 8/8] phy: renesas: rcar-gen3-usb2: add is_otg_channel to use "role" sysfs
Date:   Fri, 21 Sep 2018 20:53:24 +0900
Message-Id: <1537530804-19399-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b148fd-de51-4508-14c5-08d61fb91c84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:kn4TmWQuWxJOn0w6vuY53pNXUlA0d9YL2m5dgDa2/NYYJtnPV3TKhcuHyatZ/a5jjqH6hrnoxr1DSkjCfRtcGi/YkgpY3H08tdLFIPqsCiOTw86tJj+ZBO3tHY7Nw1sBYW5MJV7jcNEH1KzGE5cCv8KmnpjBP6Qs+5rqhJqQPJF6181wQ3kLaS26eBN0xbjyth9K3N60I8125xQTwNkYdY8+qEZrH+tLN/WWIurVTq3hzAutdRv4p5s3V4y/BVAj;25:V3SvOiyNtTLSCpQrOuZ2Mgs4gnXg7EtfDDc1ivwBiv7v1a2raEPraZT/gmrAUdNKzNWm4XcDy7oLBgetdYAlGDtdmcbH7zQ1mQajhKCk/gj9U04SH7+jph6EL2NWnq8/C7IcG89b+rklV/x2KLesyGuJ18ah7DP6Cv5ebLVKE5itHESKplrKeJRGvPi8esej/oOT/J9ivvoCDd3dQ6OTofYARmOrVke66zaRnE0YEnh8v8YjrC5hPYsFWjsqcnPvPsobZoMb1YFgEVtqHltY/Awy1Vw3MAF88lS7Mmo3ofxtV1kws0vaamN9RGKmAiRK4AiTdWKU+VOMDTete3WdAw==;31:6lEdyPw4tpT9ETnQAX6VNUn6PdwzX+f9vspamJilBthWZtrRfGzS9/HuLKznLA9KbevsNV5N29EJfGOSR9/STfKN/wAZiww4Wm8aPigr2nL1rXN9yaZGFYmarl4gZZRA8d/rPro7avwFMDj9KcaH0wLcWbctaIDwWTggXVa7cg++odrwiyq2wnwYeapF790orAbVoIWYnKXX/rmoXyG5YW9TijyAZC+TwjW2HpJh9uk=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:PtNA6hDepqHrA6MoPj6aye1mehG3bj8aPVNTV9SZ3CzlQFTR93RefHsS97V2TYjTtmQPAUpGaodMlg9gK+zPPgyYUx8tHYTNNm5K0lcQCrkkcP0fuIEtISnEyVzYwUCbOqVxvR+LLPjJ1gHs0SJJOnq/vy2p/xweDoeXEmfr5LeWbnkbmo/zvy8EvAaIpHI9cMv6R/B3BeNQ8+grZCBo1yPevoIDgzUjaf/MdOGR3waWSQcEz7j+LPeHjgJTqbvbom1QvZRmF2+LFcYwzCbImFqEyko5FJdTBJv55vEBuzBw/Uo8kquMvg050pbzPL2YkxfOPjpH65RRzu1hYD9W4NeMYszXey5SsHj1q+8g8+IPQnnEq+0TVtA6EZcS5UeAWDG12aF9LPq6NJL05k6IBEKTf3bAJS/wWMqrv/IOygZ6k5xmZCSgdxHIZA0Yl4HcR6TphdsCpsLTPBegf+5aYxdCFcUEfwePnUtAlac4kvyIqXgmZNRntxXufliG3Tl0;4:Kc8YTrV4STeGNCctxgw3hENTwNvAfiAb2q6YFAUOLpKUeS+dw8wCrgSFFRpxQu5AB0ZMVVX3UmGGkkZD57bY5YBZfgBrXzprzpqhdTXLMoeHsjflEyYfQ5xAIsczVjJDUwijxMa8sdStEq7uptuhKTGlrcEFdfMdET1zCBGNlBXucRIN1Pge2/rwD/siekmlTVvFkWz3pOdBb6VsFO4Sge0Z6paCBSUZVpoSZR74jYBjSkJLnWxmmOQi+DIINzwcef2+G0J4N+4V0ZdZi4pFbQ==
X-Microsoft-Antispam-PRVS: <OSBPR01MB229622184313D74FA046FEC9B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(14444005)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:14htaXDLNpKtuPO3b34tfIL/YfZBcFGStUSCWswcb?=
 =?us-ascii?Q?iBzC+3PohIKQmH1ni+eZWnL49pcR8j2xx+Ruj3sN9sW5tUaFpLO1489UHtEv?=
 =?us-ascii?Q?IqKZdHshnYv4watzFA5geydAwiDd5b4RkoacO2gtWBrRiaeCQP7x5jW61n5i?=
 =?us-ascii?Q?fyU4vHJTy+8PFvoF80io1fybbR0v6ATv/T3ao+rmGgo/8SbMXwiWCe4axrWX?=
 =?us-ascii?Q?3KxbHfpcD1PsKspj6epu/71OCUoOw8EH2E0Vdcex+bDgnLwHQQMRUM5x+PJ6?=
 =?us-ascii?Q?+8dQjhHKMCNJULMGsrKC3AdoeRwZBwtFfBF/VxGvjQoHbDEYKPZ6C6MW23xo?=
 =?us-ascii?Q?oJ6RaNmhfA5QZTS/FGXQM1ZoNyvV/I9INYV2HT58m9XuKYqwNLXUFMsoL/+j?=
 =?us-ascii?Q?PdUT5ljdPSeMm4HEI8tDPgBfyV+zLaWorAfW6pZWJHuNOWl1NnqXswPoHKdX?=
 =?us-ascii?Q?+7rMeOQ0w7ItJWvJuQZ86hji081I9/MJNQt6zVSorf6yk0D1cAqo91BHXIx6?=
 =?us-ascii?Q?2tgSrpmDZAIjDM/Pm0rUDku04W+2nYUAFZBpUlQu/WVO2JpQFHjcNYc4PXkz?=
 =?us-ascii?Q?/embwjpQifBLqEtV3kb8s+Lugmv7lEw/dNoz0CQEn0Mp0wP+n3t/XxWJhDeS?=
 =?us-ascii?Q?CVTiwQGbYfgmi2V5izRuXGkYjN7AB8zWE5qSMsMBPZYnHmbiV+8zPuv0cFjf?=
 =?us-ascii?Q?48CddpZcF9Oa8ygBT81E7RXbxDVnpChssNOV2StAJkJnCsewnPy/u5dG84N7?=
 =?us-ascii?Q?2fKW8iu6idF7XcoZTdv7222ZOre/yNGaukxTmfpzjpQA2MYp8z3HiDS7i3YC?=
 =?us-ascii?Q?eZawqtAranrKHram6bfO6mblFTrZZ/TsI5UOjk+Y6GoGPDyApVLV0Mp6K6AS?=
 =?us-ascii?Q?3p7RoxdzA1sZa3BpcoB8x2nwilvCq/cT8diXHDxMQYUXiItPJjlIScgnyUXN?=
 =?us-ascii?Q?3oJ4kFvNQicIkuLLcgZc7Jm0lxT3lCoe2kPA2TL9tSVuakS7QK19f6PDGiYX?=
 =?us-ascii?Q?3GV/ipT+pgU5qUvmjH6GeHVq3EWXga6B46kFj/f0gwDFDNQbrJUbqyj7LffA?=
 =?us-ascii?Q?GlrFKr1Oe1Odu49vd1Y6M0w34SM+e+0+7LaVk28jeR0x20gJVPyVqS3LmNAA?=
 =?us-ascii?Q?UvHqqE3bnviiv5j702PaZLTprp9kHsHCzUMijGHfh6O1iuzhVBcfpyoAzbaT?=
 =?us-ascii?Q?hrrC59TCMbybBe/vBLFAE7pQ/ihW5UoJuct4QtS310uJZPi1pXfce/qlc9PM?=
 =?us-ascii?Q?ePNjc5pl33sECrIOhQ=3D?=
X-Microsoft-Antispam-Message-Info: Xcp2IRvrALJQdd6qX9sTrRqZYdBhYQrkZFcnW2pengsTJSYoWeRsUMlw8TfZI2FiEFUM0wyCbGwwL4HugH1biii2VG4D89kLTjQ1B8Hd3H6Uvpdprm0Y3dVyxJOTafEuC7c8MScH17mBV4D8VNKMmT6zLzJ3ICcViuxELyCmsVIq73ohOTZRCS8q6vVomUSGNVOMKAJlptfYuG9q6om4YbdxX/M9xp7DvGri2FaPUEI+TQBwwDa0fB3aREu2Jiz9DbbjS7farXBR7jjH911SxV6PZ/QTP2yeHIVWsy+RZ7hJcStbHRInMvR9vTn7aqf8lImfWZL3PA9v5o/ujTOd8Xc/u9AeywGedjo4HkAyrPA=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:knAg/LkyqEAOaWlWMB5M10z3KtJ55I0m5p21Gvsv5v/lfj7caxqYKVyeTW31GBFOOCvSS6tslUogt3h69O0eQwdvks31ynMHyEp0JnZmkKfvb5JFwmTAfa/XtSRdnQdKIKWLUb20zNBvXjteGjSjKcoQYnzpeno+YQBa8xbyGKkzPY3laNOnJzKjxny4hQUGwhZiHXY73xodXsq76xLS2uTHeJJgd2eVOjAwRLsCDtXRvN0NLxoxrYTBISl8IF6rolP5I+KLMNn7mkdJ/dsaflX3I0SZ9+um7OarJxXANZk7j/dMlOzM+WCjGzXf9srLMW+Zx0MlvHWM4cIq8w8hXXydGVc1hhAC1JQ5E/jTRlluBlh3rsy2S3kHk3P/M8vPgks6037vKtwxWJFdINvvCZDUJSLaeKDxMN+vy0qpYOc8IGwQdgOvvTG7GUQguKnqPx2SL/HmC+W+W84e1N82cA==;5:Eyr3StYOeKRxXNDROFaCRlGMH92J86fl09UvtIl9jUnL8vmGPts7JNbc/Y0USwgpJDdZWfYyHKqiAd4RSnmOgFELdcPlpgC2hLZ7MVIqdjsCYdmdGgT4U3bwAJcTp6lhyCd5PPLoLPBhoozi3RzOsgVVpzFwgg6m9OzYWn1iI38=;7:vqPbmACRbxLFPIefio4+pU1Vorori0dL4O/J+bquNHEhvxDUAS3vQw9G0DyiFLCx6eo6D0gCogt43buJpLwgMLShRGNCAvDi8BmX4YHfztjdpzIVQFTGbUQNXY+jTwQ+nzfB/6pmY6tGLBPLcYOttejsm7H5rqJEWovbjB2FvUqWS0RDbpgM0sZyeqqYJx8Kv4DYoINW67p3DmJP3IawwsQ8zOCn6+ZNAEhJvHogNdLuiDHR6DeUc7y+HJL0rHEj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:Y3PL55bnCjZQDCn8/XD8D2WblwUDKti5zgpQsoka5G8HFYWWtCR/cWysf3Lc7aDneBlvdw5rT+QIcRbhgBqkO96YG+ajqWUMavZb0euBqsI/U8YkAQYKX65WpRxYzpvmXevad1IOXGVs/sbnqBVCNEBmzPQ0SqwQTLsbvv3RWzU=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:22.5951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b148fd-de51-4508-14c5-08d61fb91c84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if a board doesn't have otg pins connection, this hardware can
change the role by a register setting. So, this patch adds
"is_otg_channel" for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 3f2efe5..9903aef 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -86,8 +86,19 @@ struct rcar_gen3_chan {
 	struct work_struct work;
 	enum usb_dr_mode dr_mode;
 	bool extcon_host;
+	bool is_otg_channel;
 	bool uses_otg_pins;
 };
+/*
+ * Combination about is_otg_channel and uses_otg_pins:
+ *
+ * Parameters				|| Behaviors
+ * is_otg_channel	| uses_otg_pins	|| irqs		| role sysfs
+ * ---------------------+---------------++--------------+------------
+ * true			| true		|| enabled	| enabled
+ * true                 | false		|| disabled	| enabled
+ * false                | any		|| disabled	| disabled
+ */
 
 static void rcar_gen3_phy_usb2_work(struct work_struct *work)
 {
@@ -244,7 +255,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->uses_otg_pins || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !ch->phy->init_count)
 		return -EIO;
 
 	if (!strncmp(buf, "host", strlen("host")))
@@ -282,7 +293,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->uses_otg_pins || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !ch->phy->init_count)
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -320,7 +331,7 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
 	/* Initialize otg part */
-	if (channel->uses_otg_pins)
+	if (channel->is_otg_channel)
 		rcar_gen3_init_otg(channel);
 
 	return 0;
@@ -444,6 +455,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		int ret;
 
+		channel->is_otg_channel = true;
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
 							"renesas,no-otg-pins");
 		channel->extcon = devm_extcon_dev_allocate(dev,
@@ -487,7 +499,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to register PHY provider\n");
 		ret = PTR_ERR(provider);
 		goto error;
-	} else if (channel->uses_otg_pins) {
+	} else if (channel->is_otg_channel) {
 		int ret;
 
 		ret = device_create_file(dev, &dev_attr_role);
@@ -507,7 +519,7 @@ static int rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 {
 	struct rcar_gen3_chan *channel = platform_get_drvdata(pdev);
 
-	if (channel->uses_otg_pins)
+	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.9.1

