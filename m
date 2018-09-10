Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VX7nKoat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2712A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeIJSpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:45:04 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbeIJSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raZc3+yJvpdhlPARR9k2QZGxd73wTqQLphSnoHPT7Yc=;
 b=VX7nKoatjTQuQx/2lmA9wcvhiF8L/OsRn0Tg8YQwJuRfP7vxNw2YA8AIKozPm5wk1A5d2VO/j8/w3pNwN/cRvqDtAxtxX9Lz8N2bu8RmtM8O6XX/kCEnP0BURR40Me9X2IMJe4DWUk4jcJ5XHxHCGDhFEDuBKIAa3Ae/VA/itHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:29 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/7 v7] bus/fsl-mc: support dma configure for devices on fsl-mc bus
Date:   Mon, 10 Sep 2018 19:19:19 +0530
Message-Id: <1536587361-11047-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3602b0da-019d-40ff-1b1f-08d6172460fb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:G8dGOlh43ZBxSBpLNx35z4DNZhmihC0aDZXrYzDK11KKNvnUUelySlNu3y5HDeSyNnsGQe3oP9dnqMiJ2ybfM5RuZ+8feyhUDlwYZyhZ7Bua6yP1sG+0fKDLTRrNLNW7RCzACn4pTEYzmdK5I7jH9R42hLmDLms10UD36PSJAjzshKP8ND/kgVpj1zRM//PZBg5+SaCqZg0tAojb4OKGQG6qjgnEg0Be+U7OeBsFWPQHP3nWo/HoAP0lE5vqS4aO;25:wHXUA6f8DersDiBfcq4gDQmLtiPQ0j/Zkt1ozAcj42l6jbA9uk/Y+AWRQNydGguZ+NfPnynWDM8ax/aO7VdNi1vPDVrvSa6fR2MmPflDmKmU3ACRBAJ+ToQhzpSbPD/jbaAjHM89LYlMQcqHVKaNB40jJvEf7qD+d/tSSox+0S7xpWGaLUHcH8yIeGJFeMY3S8HLTUreAJEFKH3hmnCZCtT3xijJbowYV1DnkY7IaqH0LFuHOMW9SJsazR8SzCdEL6xRGgrqwaxG8L5saplNd7GlzosVVDd5jLpk3Vun6usTyfF/uhiYHo0TmS2xGB+0DS3qzTN3LiovA/sR1VAyCw==;31:tkGadd4r0ksEjiR6XvwZijtimzy78ID5/Ox6YdjqkgyNKkhle8GuoXICoo/NgY5KDM1FqgtiRGmhY3OW1EisAsaBAppnEvvqalXC8DSuFzXnftNclkzv2BY3XXKXbAuyneiOIN56GogUrz+1UOqkdN9+AqHhbKmwJrZWPIQU71L6xWh++hH2LeaTQTNjc6wn/k4HTHVA/KV5PUQVCVf4qv3lIyszztca5E/G7/ewq9Y=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:d8EfWwXaszxU/Udl73aBXPa6Jb/pxrmJV6RAso8G+4lGH+LSK4/WfXhm8GCmqxm688jOKltrQXRchvw3qX/++qR9vdMbzHcDme57ZvPoHXIHnrkhGdsjXcLRayetua+Li2Rruh8lDWREp3+BPV4UJlDLyW+DFwFVsyYIp4+CwX/VjfQi5FtAARjKJA34rXQEMV0R0lzDTgat2z4GlS1iqaaVQQKkr+GyFAtstXieBTYlnQmPRp0t6QiVygcsO72hIBYI9uY+OUsT9jO+JIgs4wsxwZBfOMBrrPjth/mG6w1qGADPikU3VKjfUJcfJr4NBMfiWP1E2KOzlUIBfuX5iV76pIrQ8PVJaLuIkb1jIR8L+5anvLkQnuaGf42/YqlSruvU97Ofu67eSBXmS85ZuBkQQCnwB3wsWJAe0C2WJhyouJ1lV87h2MB5YPN7gRnpf6TvP7NY1C+abd0JPvCkbYbC2rGJ7Vijj3thPaR09o+GVTtHdB+pAJU66w5qxsC5;4:ZJus+ZPhpCOHp8YHfskifRRIhEIASPS0qXmgS5Vx2zzifRkeem6DzHyk3I1vTpF5bc4hdtDqTKVlrfK7hnkedyCkaDMICNRMjkkHY6tsZFx8US+ulgV/xV1rUIVf89nuc6ul+dCvq5nmoHWzk9it6lAbpR1MESms4CYe7YTQvgK5Wa8YQDrm3oZUcGa9u55sRpoOeGou3nbG3nkVEHbh65qeq6RT3POvSYy32efu3D5x4UoaXm+yL8IZu6XFRWsfi01+zVT4dlotQUWj9zkPnFslu4UFEIJ1stt07Mgvec71vGM7oDP3HSgKvDViEzB+v+UE5Wxhp/iNoomGo8xqk0IGOmY3sCVOISpNC2cWMrQ=
X-Microsoft-Antispam-PRVS: <DB7PR04MB44764A585FF555C42DB36533E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(6666003)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:1l84GhW9X0esR+Fsykb/vVwhR78V1/Z6zAFIL6miu?=
 =?us-ascii?Q?4lRN5FehJd6SaK0v9mJiryk2XBW3agoOYvixWIosx2Dcgk23/BLKVzrGU9HK?=
 =?us-ascii?Q?7tC9baTPUasAjtY6BeW1dmOvEgrlzCyGEKhFPFGhgWjZRgEtgadhpCK67SuE?=
 =?us-ascii?Q?4mm7iBkB4a7UrRnXcXTOAkfNHMj0TVawpOs+eU0BHw+oulgHeXkqv5zMGlyL?=
 =?us-ascii?Q?S2y5Qsj3JL8MzkEUD1VNpcXEkNdzZVqh7YqKRnfy9317O6wCEG+vFDXp5PT4?=
 =?us-ascii?Q?qMuXEKOW+J4uSB4Oy9OkZIBijtIPU2/rf5LTZnXjB//1S15empJbx9szFROp?=
 =?us-ascii?Q?GKMovQ5Lnqb5Y5N1F4ax1oArllkL43YvBLtSjUXj9FrgqT4KoTWITZrpyyWK?=
 =?us-ascii?Q?OW2oVgWylpaOP9mzxpegqBcG4rpweWDsVVbbPljZ0ua3xPPpZPwtIMnvmM5/?=
 =?us-ascii?Q?PLzvxHki8RnZrGLs4C/2emylpX5ZpAuGCH6lVnYiFYR/FxVup0MJogfClx7D?=
 =?us-ascii?Q?XB1T/MkBgWSf65IEJUv9ptAmM7+nI7FUC0CIPBeqZ+DpoFpOrOajdr/NucgB?=
 =?us-ascii?Q?1TQuV++Uz9ypEWA6m2G4LgV5aOT33aYTai8aRgrlyJIns3ZC4ONNk4uqOtYQ?=
 =?us-ascii?Q?kCQAA/rQpuvjTi7I/DhTsIDCMVNzYKtGyUKKNW80xfaI5beuvZyHbZ+zID8i?=
 =?us-ascii?Q?sUGaBGIWP2WIsaBeHaMQRS8jlU1wTcbk3kaZep0d6aNhmPNt6oOF1zq4lkM8?=
 =?us-ascii?Q?DUnferOnkJZnA+RHxypkMcIA4hpyO1ypH/mFaEsNL+blruzbLtirEIlWz8wi?=
 =?us-ascii?Q?GKhUQfLEnadQs3becVe4rCIaIJj8TqnEvLRPNGcxNQ2P1wmOUVrBGQKClR1g?=
 =?us-ascii?Q?AQdbbqiJioN4cQxM5TEloNPyjT6ryCfVXmbHd71Ujhx/6sHO99NLrejQHL3F?=
 =?us-ascii?Q?gsYCY+ydnaxaQogyo9sAlh5BRE1lXlquTOWBofYfRz/PdROnHrFf6m+u+2BO?=
 =?us-ascii?Q?pKib+io+H4Z+XQJ1K0AdPlh8lmIP/LujIFraCCudEZyk5IhR5pxWOmr/QBZQ?=
 =?us-ascii?Q?Bdtf8Ivb8crreZELZYNvfaS3j0tWyd/GOH3pJAfwcwhafTm/+3bRip10VyAb?=
 =?us-ascii?Q?o2M/XNk7rUNkdEYfgFecd2nsRFY7SxqzE3POQVNvU9Q0X60SqyfjijwIyV9+?=
 =?us-ascii?Q?b54hFtZXAii2GlGeftkrLBhJgbXhEx2wfqTwrETGKvRnejlroFJIBRKWI2ZW?=
 =?us-ascii?Q?jAhSRHr/W4rvhPrZPApLyGtRLoga4pe/a3daIf6yhzVyBacWge7xKF9utPom?=
 =?us-ascii?Q?TUpg7df0IIQJIo8MqAw1bpkj/phNSK4QZAcEIPylYRo?=
X-Microsoft-Antispam-Message-Info: +NnCThQswcuODoY/+RbjqBvPAZqvxtJ0SObWmIXaccRpmT2uVKIncV3sF9vcJzyt1qgUO0poYIb4JwsO7/y14DJkhlkd3+6JQGif08t+OOjD7S1vVrOfMQmWFwKyn+gsjjBZPbqIvwS17Akp7EajjCPjT+cxdGyeUeX2f4QoIwI9KZAYAkMEgzkFDRsf89yPvTfLxLdYAyH68Ex5xx3vE2GgAO6NZO/o+6mgx6o11NOl3HdIOL5jaRzAuBYh/uLwesu328IRULvx0c1dTzKGaEdIvIBta+m2HvruSubf/+LVzn+nupdVpGTcwwqZYFFXj8fHl8+gEvSjtbyO/Dka8ZV93hvh0RDNjqr1oSRKV64=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:oOaxRJZg/BVBDE5JFKvlFi633ffUDSDwEgX/kgTWrvETdk9V7bQBkuL5GtbTXQR9Djuwk3XgmZJfg9Gwz4Nh8X7MYvavtt1SGiVWWmU5+SrLeDQy2AJAqLOrLZMtbYboo733XoI/woDXTVTq9LuKpNJtdwu1HxdiF4ePxmOxStcgfDjyJX0WYDpYoUI9yaLaKTEfuPgl0s4/hOpSzO5DbWhlJ2l0kXeE2Q/ooyVX0tvMtcBtOeeuQA23X+h8m9DGWZHHeSgTXINYs27HLFOxM6zxzVigAPma5V1wnnZoMA13b35LoPXm2I7sCgZiiA7VLnHwJTHoFB3lwux2s1Ak/v6gQ8keuELY1CZ14q4zDmPT8UVVVcgWc+s7wK2pWaExiXENHsKoS947iBqm2yYQ1OhkPmOSHhbt0cXDfLMcaltr59F+kkWki8NMt5EYfXxInfrqxX6fInaDc2mwOFOHPA==;5:wI85OA/oPDWbu5UZG95vTIcwgpWUehwvLvKOxLpmTrxe0bJ2R6WUucJQZii32H21ztbofUfU0hD94SjHn40d7TBipYh26JoPh1pWJB5TJrpy11R9gF+B8O2WpcmvyblIvCKrr0a3PpKvpbYmQyLlasA03HsSSghTYJL01O4ZeDs=;7:U6XLGxRv763uAZpRZVs50pdf7HwdJk+poaiTSUUXUgGWVy6fTeg6kUgunIy4BPIXFlNdTHIdXk6XGJ2RBjfmVX3TzBuhuM45kiWMJXGzu1/ytLjwOfoE9HPYw2jnEphH3i9QtrRs3HCZKE56T2erwyJNgfWIGUw2wMIRic3fYctPcdshRNN5O+2Vk+XXKZ1S1rtG2+yzjVO9s1wVapfo1K8xBCR1/WinkFY7NsOIZUBpyoyUw7V+TG3yoj1oXJLS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:29.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3602b0da-019d-40ff-1b1f-08d6172460fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of dma configuration for devices on fsl-mc
bus using 'dma_configure' callback for busses. Also, directly calling
arch_setup_dma_ops is removed from the fsl-mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..fa43c7d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fsl_mc_dma_configure(struct device *dev)
+{
+	struct device *dma_dev = dev;
+
+	while (dev_is_fsl_mc(dma_dev))
+		dma_dev = dma_dev->parent;
+
+	return of_dma_configure(dev, dma_dev->of_node, 0);
+}
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
+	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
@@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1

