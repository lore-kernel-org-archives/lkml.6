Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6CFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C5020881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1fSEpVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C5020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeGILTl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:41 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:51708
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933207AbeGILTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfY5RYQhQgu+isysu/060FKeJFwq+ihpMMXav4s+AUE=;
 b=i1fSEpVgU9pMH2ZH6Dk9iJOUBtKhTGaWLchRPfytQyLdAEANfN4p7OGXJYdx8sUOUeCo1PFOnMBYs3PB9OxJTMsBS9bERLeNd+guzS8c5TjKnD+0161Q6YLOqy5CyObEaEhKYLun46S0VS6dNwXuQouEOatmWxoNsdRwnqJKQLU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:25 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/7 v6] bus/fsl-mc: support dma configure for devices on fsl-mc bus
Date:   Mon,  9 Jul 2018 16:48:21 +0530
Message-Id: <1531135103-10699-6-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a604f963-abf0-49b9-096d-08d5e58dd66e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:9IAl/R4b27FuSAI/bUQVuhjG7+Oe/hbfHw8HupjtlieAzTKmImvyXsDNZm5UWu74b92Fi65ZXt176yI9cu5mpraIU9vbl8ez4y4GODeinXiaKgNJ4i2OSXH2NeIL604xIEToaaIMRsje1W3q9TdOvn0sRmG9fCTP2ZMsmjPpTF/1tW+2ghNC/bg4aiFY2plN3J7ePcmcuhpiV2wljBtwCOkC1MwGQZ8LqI5d2u1Eb2pJYBv7sYvbIvnlC+65OJgJ;25:i4OSn+xA0tPfAYAirsKyilt1s3dOVGfDqNbUOiSVgOR/JFCv8GUiTcLxvNQK8c4SX01cD3nJL2Y9o9wJSovOgF5sO5lzHaCCPWLAAq9bqdKPQGxQ64ImEMhvrlDleaJo6iDECLYAjnNvmqW2YB0+5kw2jXu9Z7UabKMfJnQXodYUIsWh7N/2bKLXj2EPSU4DLYP9gOcD4SRpB9lWeEmM9f8586x7DRb/6GiwI/1NlU0ksGkegQ1UiDIgYcRil89mvutRnRbgVVaBLSMdkddtHaluz0kGmQQzDTgDqA+BHxo7uJlJmk6Ga/1J5l7aIKY9bBzdCViEwDoCT9F+/TOVDg==;31:f2XSYSkDyDbPsNlJg9pm9ZkB55U5xmZ5skGsEpncjjATTBdOti2f/KpRU0gUOtm2QxZr6ZU495IaDBHE9uqqSZwsmGds7o9z2ml9jmmQh5s7rh5hsbbaOW4zYXjjhdXbxlrIkv6leViZFY/zUDA7FAf90VKpE6jyuURhaytpHgGHRMk4mtwk6k0uL0OhsXC39ODh+7PpberdRpD35EMTwtr9EWZxytAf8m0coG4XUaM=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:B7UbW+9kPl6xY1QXcfLGpsqSCvbn7UXNlGtAS4UcGBr3rExOVtt+/WvL9/EeUVkR7GT+1vapDnpJHkZmhriuOyC4j4p/fv47r90c7gL5y3o1pDLzHXCUm0iR8rzkcHXWpsJTIL7my/NSqQrJvWyHueu27up/ubh+DFeWX9PR17LTvumL8YivY0F7wUUWe2b88enX728J7JRerI8NxiiELczHgL0zIasN6HCaaTKIRzqRr/Gszl4SnR8XncKfIPyvyJewoPDkZ6qkFGATSynet7pc3vWLUhzfwOLHV7VVFsm9wMKkV/ubpD/DKJpiJCGP+vEaVH0GQvcQD7m5mdQ0XJlWoRSNkmsRI4st9Iw3NrY2IEEPhoxLNywFA0bN68+JqlsUAaNjsdpIbot5JgGsnrULlt/vjwvbyXWVpvhl/QdYl44/AIvUOUCOvBLQk+z6pdOj7QmVmA9XwmKpQmcNP66L+yhWIxOzKa2Wqli5Z+NXFMjiFdPTp4tsuw19dSWa;4:OGcsvGUFTsi3b87YMMw+4g5NLuzd2buXZTq9EUdDwH2ZW0mQLkbK/HM9wOnec9V4aIiRsMsfpcZ8Q46OLljyYLDsEVB/uWuZzCeOj74KBfk9mLGV2RJhjabfsSTugL0hGO5MT85Z7cUWUYjBhUwTYjLsmSY9LkymgcBK9z2QDShb/K4y8ndcYXLeC8eOAkq6yIR4sYRnqWvKJg3U6WULmqFXjyiYzcGMIJm/+qTo5WRaX/swWuIa0O3CRgg61T/+kJMG5f1AgX9R1G/u6cGouH6MytJ6FhF2mvlTOZ8nqTe9oYr9mTNCvSgY2wLB6v8Q
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427B56F52EFD159E94B8BBFE6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:3uuM8SjT08fKlYSqO60jb5MNNaVJS5HP7+PCFeJ?=
 =?us-ascii?Q?WZcc4gyA7+FXjEknBkhUmMEji/LB35HtCwsDDL2lUG4yutSGpaXuEkhMdutF?=
 =?us-ascii?Q?mhnPARbMDF03MpMqqx5A4RWaB3+qxHXJkRlcb5cZpUQud6dFHuTpQloFfP98?=
 =?us-ascii?Q?LT11ScAkE9GniCi3BCALWg0tM+InTm15UpwsO48M9W1eMKxRJnCjTuTlAMcM?=
 =?us-ascii?Q?4ggX0LsUOirZVe5N/Lm0jBu3gXo5Hf8bZwzf5Bv9BEl7iez17cK8OxKpUFor?=
 =?us-ascii?Q?IiPU23ZSSxyy87iJ9WUSfBH72B1UhRsio1T0NdG7KH+uX2fdlPoB3rBLIocl?=
 =?us-ascii?Q?cy+Bp/bUElqUdvg6Tv0CceziqGBnETVOet40QMhQ9C50l2oQ2muB/1PHeh34?=
 =?us-ascii?Q?ZGwsTCD+B7WE3jlLRjupGpb5SNZQE8ZrUod/zdkmNt/8ltkfKxxVmnoNQnxv?=
 =?us-ascii?Q?UISglSSbFXekj2h8oBF/4Sa6HfDhI/5Nly8jQl9BhpBIIACGrqaFz1FJNPHh?=
 =?us-ascii?Q?69Vkx7qOWUEJ3X/N1Xevs/37+KCCcdgvAt/TjdcOG6pUld0ZDIufmPed1yVN?=
 =?us-ascii?Q?bciQXAJt0VCG6vWl4MEe0+ncZ+R2W/EyxrQDHnIxWLKFOUnfq+n58D/QPKMQ?=
 =?us-ascii?Q?q54va37OHi9LsahW1QnHVFbKnVb4A1BNUi/U404SsjZf1cUdLKF8YA9ycsGS?=
 =?us-ascii?Q?olqQdJ2RccA97xrXReKwC3rVN+3U9crJDHqXeNFLQsw+Z+kSx7N/A5W8LHV/?=
 =?us-ascii?Q?UlcckSMI+VYKR2jpFuLmDWvVFdVlN7Q6ildc3LM/XFBr20ZzxjJrAetlrwsN?=
 =?us-ascii?Q?4seCFh4lBKUpQxd4EIeZ9a4ea7lnKvwOInHhP/q+99RRZVMSgpJ6XwrmS/2e?=
 =?us-ascii?Q?zwSS/wJrmXe0zIzgp/HuIjN2W06zajG/SaOX5LmR39eXpHSbmUzGzxltNzRX?=
 =?us-ascii?Q?aKVIQyMCOYAAujKdOME1Qgo1bmXyU6FmfGrUN8y668CD2oo9352U1qsoTFNZ?=
 =?us-ascii?Q?TIoLJM87L4eWkEol/wCcglPBJlYWhUuFR/VtdIAYFBvgFNVGrXy6LTFfZkpF?=
 =?us-ascii?Q?Sd4ecCLu3i3S1RycWRQ620lkkoiZ4+n/VXPErD1FPN5DFQ/nfQgaxdsktsTf?=
 =?us-ascii?Q?G+sonRo5GyM/BCLRs9JBLh0ZEZd0tOXonMUqRN/XyE2dqpZfPeS+DTfR5McQ?=
 =?us-ascii?Q?Xz518KNTKsCdB5YO/y95pzymQ+3ZCCQfvqTZ4ydsc8yQebrJWXTKgm41R/CJ?=
 =?us-ascii?Q?iC32Fkr0xHuJxt40wi5jnq/LXIBRfBFlMC+BYYQpltQxwU3toBZBbC7XX7kr?=
 =?us-ascii?Q?6EuLL7OCtphR/ugaDyPSGHJcsfDgqqUcFIqcFMg0bI3iK?=
X-Microsoft-Antispam-Message-Info: YGDUwnMReEZprTqfzb2a+FCg4PBxumVtaJFKO5fFUdYDv4ALSqT5FUMR5sEDuTGmGsR5Z+SxOqlMa4w5MZeK/3G599CKIQRjl9scz0foEgwoJ1/3thLpEIznXu8u/w47SHZoBLCzPc+0I7bu/SlgK1xizdvQA9LAj7o3zXGQrMKJ2H77O216sRPl6e+itwB10enqr9KiXfTLCJl2AmN9snlJhb7rxmp0oSHCSmWuLnEONS3svDpioivBXWEPUBNqWAtJmqxdmrXeOvg0J33gG1Idxudd+/c6eOfXwHTNWp7R2oEceOsPQV3PIcviA/P1FBv6wIp5KmSnr+Md0cOGHD/EJ2UOtV3NzTOG9V19yxs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:waVk714+YWl9MNrI0OqV6aLhMpqLS96whMvjUXzkPEdVHpHHYsZVSGSVn6cIr2LThaD/eHPKhVRX5CHwaAZGcOWlUUTmbuPehGiKVTIukJewmfybFmOuJwL0b5BJz4R4hV8+OEiGDWYGKd8GtXP0AVPHfS7qR6iyz7Kvcddvf2JEKGGVgzBdC9OhDy6Z9lIr3/JTEobWbLi+TN16wCmb8m1NH7dYRo2HDLqahASvl6kQ3bo5Pgx5yGooGqBcdtDCOu256j5r/UM4sPvmVlrZkYClai3hE5ljJwFU4VLR1vI6G1lC6wDU4zM1d5xAeNbFmDH38fOGtAYJOnMBDdPM/fxXWWCzpILW+2BH2zhaTYW/RReWVrRcIpEWqmX1yZNvUJ1wnXtSqSN0ieNy+Q53SBhjf5EIUIuddVMULsMjLc2dxGCdWCoLCFyykfxBMM6pBAmqvV5h5SwmxxnbY72YBA==;5:t9mhjJZMyLY17LMvjt8PJ5bl0hK50rszWWgncSFkLlczAIPjIy7O629ewY3rZrNbNxipAHz7/6nnte3/hHkRVp3IZSoGDBgFsoFzPsp94IK3aDxjkV/s5b3DF0++KoAdxL3nzRyTVVdAV5ia0vNUERgSz7gN/uBOWAF/jVWfmNg=;24:VZV9zt5KMt7vjSS0IJwQMGAf7lBYO9F00kLrygTh2dPa3v23C7Uwsm34F7kNXK9fzIwwaj52LA7MysrZQZou2C+vSv4xBFOnq7pQKYZVEKA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:8WMoPMo2wpi0WGee6C+kYUQLF6qV34iVngUsL2XkfrT/V1k1TEnxXcKSpA1KwXXxPooZKOzTH6AJhhJTnzl1+yfAQWt3/VNplsdGd+yeoZtbtLLSQTSpDtRp6FBwQVslMm+cJ8Vc0nFmkqRxjSsUSp2ee35QtHCc00rHhHg/dqokMmdY2QYcp/B81g2Jypp+tcLOZeS5papIegzDV14Kvco4MEDxjYRYRMKUoUXcCoEubNOp+K3e5ZOx553f+AyC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:25.1094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a604f963-abf0-49b9-096d-08d5e58dd66e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of dma configuration for devices on fsl-mc
bus using 'dma_configure' callback for busses. Also, directly calling
arch_setup_dma_ops is removed from the fsl-mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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

