Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6516EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C6D20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5zTuuH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C6D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933180AbeGILTb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:31 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:42112
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933036AbeGILTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82G95c9pC1Xl03/ubgEUrmP+7qVW0vR6KbsmJmk3Fdw=;
 b=e5zTuuH/INQ+PpmNKGLa/DmAKzU9Z7kLum0VvDn5wDxSAABqNKks/mDG8d/dNPXy6DibEbJwkDcmX4chkKa4akQCds3wApykAooQNmtqsMnTj8ZS9CeD25W2XaxXiiQEAv3uWkGEz3BMUK57e9CJ1MVWS+dtcEyHH6ib7q2mVPY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:13 +0000
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
Subject: [PATCH 3/7 v6] iommu/of: support iommu configuration for fsl-mc devices
Date:   Mon,  9 Jul 2018 16:48:19 +0530
Message-Id: <1531135103-10699-4-git-send-email-nipun.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f8e55db-c7d2-43d3-19ed-08d5e58dcfe5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:V11S8dxWPR+8MrZQrLIRf1T3m1MAJIX2l2G2JO742gm1nniofCtnbZcbrabBzOWt7xf6AgiVC3eke5rvqs56nSHpcDuYnopjknbnAod2GwaHo+ax4KiQ+dXRvQ+aWY/JHB+T5kOkaTWSNsJhbiXn6l/TjX+LRb/3Z5Arbvckw9+tL9YqDbLNqrUENCGd0cmgfivcFj5iLLoDw5IPzZKjWJxCFsTQMvhgJtcYRm6BcROyJNcteoiPDp9e4KQyhx3z;25:qZSQqON2Cli4UbkoHeP1sRaUEinun7hLvP12YvLxyPXVeYUKvs4REyXW0n5aNFYAN0j5U+XoNjBNL+V0N19DCEZ+ySGCDd1307FkR2dNKZLK/sc21dNBpvROy5rjA4fO5TMKmSus0Ol7s/SRot9CX55H3JXU/rM71kIZc4ErDeycXA7F0++8qCxb7rBvmovHnjTfzq0nJ8dFRr2a3Ge9mdNGtkwyXowIt15+hukDNAJ2E8HuQeE7uvBlPrr3bMe1a5c/XsHBXWoArHnrbswNSJLW2tIOSOTN0WyjZTQH7d1lmX0L8Ilm5GZCboJVVapmYIWPm9+WO4BhFiLMj2kEPA==;31:PPa7rJESX+vqzNdbKdGpFjUplPtTdSXcTxR82xIkra4JUg0b38C1VeCHX2VMgSDxrIxXsMNMujvgghE/74SunNua9gdJKd0MFg8Kqx7V4wgQS5/OmfA1ZgXB7T1yLkbP78HfkdokOf28+MhbFEfBdMvXR05jSoeN8Xn4iHhOx3ERXYe72a0syjdgqiY62c3Bkk9THb/VA/VQMC6XJ85AFCwEerF7luV0zPqOyiAL7ck=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:aepJecO+MDnzUxuLWZxuigQ9WwTLlsat7p9C4tSSyBPc0/YjXGe3GMD9ynlWFKXI67MnlGFgAbUSAhLsAUC0SC1ZuTCepB3qua3e3aHJ2+i6EE9S2cAyjTg7PejvaKhQ7bk14jrgCUbpRWjaBjiG2SjmpWATCR5ngLs4NLeQ+DX5YWpXlpCF1yOSMmojD0tZrkyMMA86ZsqqYNjh+odkftBLMJNy8xn3UycxX1+HZNi8nd+GNOvRb52sdkKGWSyd3V/AVpIrz0gabdzbvlm0bKzcO29hahNWU0FcUelCIuXRRoIGUCc1UUx43mklK5A1fOPoh6omgzxqVUkIuE8U/iUW5G0Wx8+lBRmHG/5H0Db9IFwxuK147Uk+KDpKWd+MYazkRqpTw2savPgFCxJGbMbMWSmMa6ShDDQdB61Ixy66DJD05Qq/gxjRPQEgNLspWpr5k1QM9qcu4JYcZp3f7e4xkxs5Ie/e/CvAGE6vm8GkPJ+V4Y1IfgyHGxYqTxoT;4:oUEGEiZEfqEEB0fqymqwDqbfpr0N8mhT/8nduO1dUx2ytis6VquCsuXMGvkckN3o2TFw+kxJaFJL+9GfMLxgNTwQeCnbd6dGKKzze2H0raixGdEF/ja0KZM6prWSLUzrktcEQyPQ714YNP8IINo97EOK1o0T9pSgzP/eWrHtaeCAPUIHQUicBfJD2JiOCv780m6gGLIN+eBzvpXCfpuDE67ofPagPMvskS6uy3EbJ333PPiIY8QM3poZlZZIGOV9BUyPuLZwlL3Bo52szpFybQ5skDQ+ML4A9T4KR7g4KRKa4eg+Xz1qjwOPtV/33wfga4ilOatvAPUF0Bj7SpOZxbpj6bt/GT2Qf9og4VqbVgA=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB242760DAF1B9A5F02327656FE6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(3846002)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:b6CFJIF+qj1CLVSl28Nt7t/CUA8CuNtvB9jRnu/?=
 =?us-ascii?Q?sLgu1fzwwCf7vYmdWXkrbAZ4WslrJipskvro+rd34W5p2HkY0/X2kYnjJ3oB?=
 =?us-ascii?Q?lq8nje8H0E4hdsoQhurMWzfva0QZYiYq+unIDTHIT70chG1tks/h+5R2FAb5?=
 =?us-ascii?Q?dhzhx6j92giLu3M0kCQb8SoKTkKQvX2B88+Pv7qx9V3CSqOoxxsQP6omJtIn?=
 =?us-ascii?Q?zrnFcBg5/PRd1TjpcwdeJjNnV+rriT0qBwe6wLonZF5IxM7O8ywLch2FXs81?=
 =?us-ascii?Q?oldiImjO4OYoEUC5XUyh1Db0iygCniqCGPBlUr6IoKwKcvlH9a4WcbraQ5cg?=
 =?us-ascii?Q?Ss8XohQBUIvWUz8aU5UMFjwPKIDFHWVq7oVTYUEuf82NyZLnCA/2hMmYuDgn?=
 =?us-ascii?Q?ZgWVHkHiVP/Fz5dp76h+5usTbzorzz3s63+ZTHuNPWwm+910/gDEyTJw7HA1?=
 =?us-ascii?Q?iyWmOg4iWz1s+XuSn+Rvdw8mbrP+u1xpzw2AG5EYC6WuvGYIB003YLg+I6Uk?=
 =?us-ascii?Q?eL9Ja9o8cHvrplEvI8TVd/5BRInvizUZVS5g5cvSt4xAE/S3KwMEmqUp6mWs?=
 =?us-ascii?Q?BDdHvWfQuF3/aiVbWwioEWT1Ep8tQYpLFKdPbo+AemI/z9l1Qa+jeTMCXmg+?=
 =?us-ascii?Q?FraRydCAf8fzIw1itqjkad+lPJdASMJYSfkag/3TJx7bwrBreO1RlAyEMA+/?=
 =?us-ascii?Q?p6IgXz3syvbFmdEhuYe8LJijy+PaehMnrJWKAIb/+f+bammvOZ55R07aMMwo?=
 =?us-ascii?Q?/i7RvtuFIcFFffvJNszxOHnlorAbxZ7+uZbJ+tz3yFNnek5eUcLUzdoQNWK8?=
 =?us-ascii?Q?4dGwNrIDb3YU2BsYTjBwAxgKS20qmIN2XRqfeiw5giZALy17nl4j8AHDeww1?=
 =?us-ascii?Q?YkwRNp3HWlsfN5dxJNKyFl3aHZMpwyPiYh3uir7D/J6TAOsPJL9cOPfZhNO5?=
 =?us-ascii?Q?5qHPfxS8JzeNFWwOtq52+Um3gRG6bQoJPa2O2lVhsOF1bMPjAsWLZaTPX+f1?=
 =?us-ascii?Q?MRKW3HlQ9NnyqFacqLMvqOmbY7gGZC78FVCDXLmx9ie7t9ETebNANH46GiDF?=
 =?us-ascii?Q?5MsS8vLobvlQ+V5Ak2L1BuBnNYGsFT+h0zm8HHgu9uA3KmL7cJiS53A02hwT?=
 =?us-ascii?Q?g3Cs/jRFoE5SQgEzIx57YPYZ8ITWUXp6/gP6xB9zwUHD/HAomss99HrXVWov?=
 =?us-ascii?Q?+p1D6bitJfcK+j48gucpyg2e+58jJjdXyY2Lo5VS1BZfxo0ZByLf8XowJd8F?=
 =?us-ascii?Q?Z/K4oiEWm/dSfwpfl6ouXkp8G/DvoJLBHidrUchAYR7aqiPaSWF6TVUd72JY?=
 =?us-ascii?Q?4EIaKwztikAO1P/eSBhwNN78=3D?=
X-Microsoft-Antispam-Message-Info: GeEpDC46HzQTkeNAOKc3E3LZsBh5tFTHO+vpAbCAjSDSzSPKGAlHhx0a8fU9cRx/bxZHhErCsHwRGZcawJU+OPZVs4YH6IO8I229oUrU30z+ZsJdI7hDGa/WyosRa2/8VwSPDKTg6zwDtJ1UMWF5p2lNOui4NP9eYsAbycL0sfJ0Qq6Ip9Z2eQSgqMLDkAyG361ryZ/WA5OfQL8LGfe/H1P3Vq/u1NdTifcPF4CLhZetpkjvV+9oJwUMsIHzsEo6nmXGnu6t7KNmww5lu3K0PlhMqWTWNckCs2mF7xrYoVY0LPYU95kyNPBHCP/2fqd4kbyQqvBydngmT2XXMocI8XVof/DTdjSg8OSuTqgoV9Y=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:+CPUPwy/qt8GNMElDk7iHf2i6bAJPyI7+Y4EbpCOUQ6Xpl64tAYu2qAoJ9orxpEq/oSKGk6eUdWWf4DQXBrIUbuiPX4WZAhL7fyD/lVUYhISc0Se929tEPUMXTRGU9cJpZLrIte6jEjN47w51grlHhgY/c5/mV1w8efURm0qb7lmdj2NOAPzRKABhgFKdFOa07zaCMFNEtvMFtUujBK8L+d7SX9SFaaVqXO889OOsv/ABxn4bBEMZsx/b3VV4NeAHT96/DcdNadqX8f+N4lZDi3j+3qVsL7PqaQn4unfyb1JwuqmDP1xrVpjGIbkP5Fu/yKGRXo3PrI2LXkpKQAzNXfyav8S02IrMrpCcXadB3ynNC5S1vcI6x+ziwIYiPUk6vHXOQSJl72vj6maVv/Zv1qbnxr/78Y2EQP7Uj6JqQlv9h7VIAVAYFocZSIbYtflx8lZOITNWAgZ6ef48QdJRQ==;5:BnJ+DgPlNIGteQYD/bcLzyYZvo4fmLHhk77kW2Rah7Si2YWen/rtiLpP54J93jdikgnjqHZbwNxhQE9vORkqo+Y9WnyHLUFZyI6NBs3pFrbpv9FWsrzz2tqFNVmjeUWVUBUT+fteouprwSusBAz0qgu3t3jqHUA+nEdY3oky5/8=;24:pBmWt3yGplJ/Hg/lGWWXfMwMfJyKZzlxLPMeSZL7CvqsA5jZgmgE2UzsHGGe9Ihvzftp851DR7fG+oJEV7szPpB8NYyFtB1zbZA5qW8Yh0U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:VOvWsZhVD70fYeaz4H+PaNKIS5cvYU6VLgwUwL6xR8EjbrMswu5k2BXGPUdcxCGleKpWFSUy/NbjLXQKT3eFXYizBURcCHCgS5O+uDHWqrfSUp+7Zw0PPp5MOJLwDzUUq5jcD0BtDQq6dDFAI8ix/Mn/Q6LAkUV8qpnLM4QxXRp9lnShSWk6CnZPUoPR94ENf3CnM1w8A/51/j0dx8le89xvPv1eBm68xgo/tW4SP+lzFPOaDXf0cPp7O9B/clj9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:13.8394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e55db-c7d2-43d3-19ed-08d5e58dcfe5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With of_pci_map_rid available for all the busses, use the function
for configuration of devices on fsl-mc bus

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 811e160..284474d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+				struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	int err;
+
+	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NO_IOMMU : err;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1

