Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4623C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40731208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J920f2L8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40731208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeGHPAC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:00:02 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:2465
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932588AbeGHO75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCAeYvlw+oJM0BZyB13V3FJVtMJ7pzTBFZVhjsweCaI=;
 b=J920f2L8FEXyBaNrqovvGKNpux5ltfB2pHCOSSLf0IXuDFEibT3i+X4joMHramGS6RIcHaN50N3khCixxEfa3EJFVPS3JqUKWFhamvcJc4lGXvPT1yNB/SKK77eJ7lO2j870sojF/yigiBFv1Zj6Xkx+N8+Vj28hHwEEdu7RwAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Sun, 8 Jul 2018 14:59:52 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
Date:   Sun,  8 Jul 2018 22:56:55 +0800
Message-Id: <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:203:72::36) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d97c3b04-c619-4ba3-49d8-08d5e4e37734
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:M1SdNCLCSkvaT5Hu+vRx2D6PKwJ8gFbyDrtBonHrT16E3R085mEyeiUD0bXscU800efFfoMbSEGNTjxnNThYvh5OjUsvUqE7MjDByoVHThqrwyEorWvPrKEMEiWcMjGTT13Umhi3IPHvFy83nu0qFx9UzbzOREFClScjuskmwDsTSP4h22Rhrgms9K+5WmtDAWIXAkUlN8Vaj4wiKge/lL8bXs3rt84CRlrIxY6IvJajRTN12+kESYdMtu3KKcZV;25:t4co9xMEGrTRwR9sf5xTZ666akHecgZdbow41s4bGkGRK88yEpaWeLMwAyMqBoV/9wzh/iwsBI5GNXRucllSBAFyJDPwE51HuUQhFZxRKJMp0QTR7vDZDW4bMwHyk8phwQFlpPIKOu3RFCab5urBIferLZOHkjCcf98Ovq+1lq1OMDpUq6FYph1vIsXU0kI7YSO86WxZFPFUk774yCecWYhjULzsMtPijalAqNoQvRNtjDu0GzA46eWvrEF4W6qTdFtDqh1AOcS5Tcj/4d/EczgW5x0X/sH/bPOYWC98A9ZvQAW050tpyinDKApfB2dEZp9+6ju4HLahGtr2eTcp4w==;31:TeXctGedFlwiOQYbsVyhamGAPDbCyU5TrhSe/o68TT0FP0rna8kBRNfgjS551kMFrf0MZmDeNadMJXVCYkdMcq5r80if8RQ34q/R/diIIZl871oHmI/umrwGBnT7y5w0z8vlUYu9bE/BkDM6OvLhziaTaBi2e8yV0W9G+l8JDZChO6UhWQ0iPK3ANliPytIvAiyccghNWEuE2zJgjtZqLEvsYu7XJdDhaqcZM9GAN1I=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:Hmy2HL2X+dwQS1ntdeW3gTHHVefL4X5gJKdh9tBroLGVFi07ZAVFYm7IF7J9jptMqACk3PBQx5Vq1bdMYdUNDTTCHPwOE8Yn7GCBNJAR3UNcs/q58E7w8Q7c4Dp9ozJpxCwE6KULDuCeC/dOrzGVghp4GaTOviIXKitV85oGlx60JPrulUoJDV2aG83ZhneK8wT8AxqfssrmHn2nXvSSbv2kk/dywkKdYIqo9GFFJndPGGKPywFQIGKhUTtx2nt72ugAX3X35r3U5EVBaSspMLWcXoTG21KuV+E7m0BLcFmUoQZIJcrO04VnAsYcOrhW/vIktXiQqGRJvxdbmcxQdZ+XndFGz4oD6c+yQmXyiN1Yb408Tg7+px1D4qqqxiAq9k7uzxaC/+5uwOP0P+E3IXbnCCkhmaZK/I/rxs3ugc6x812o2oIl1zjVI94zJx7ofopcgKV642wyFq3djLfFlIqmI+zbE63/60tXQTKCZZYxCmES4S8ny13Y7yz7Ed2i;4:kVbho5ZcYOH2zAyHXTkkzxrDhRYSYI7a+BORwMX+jIu3/8nOKAa+cpk3SCyg2vkY524f4M7TgzsjH+GHkzPR/ckFECBA8IrLs2ph/y+kDVboGZSBCNbH9G6zN7Cd98D/LjbXTGwimJLBiHeMC9veF5z6Jo2oyXocJHCKuDQW1h5Je8zU6UIyjvxjpm4iA1LSRCPuAT8lwJq2wsKKdJOMj6z4mh8gn/bDxXufjnjmQKmL8p7Sy26m2RC5vY4uf9pSc+AwWBqFDUjz/NuxRjWTxZfrQtgYo8W9PGn59IrONQqJKrUjvjB0Al8QjnFVhhumrLm6ZiKIhmo0EjbQ3eikGk1oHaAcS8qSjeL9yBVeIqSxpAeAuQrswtE2Ef3S3b1T
X-Microsoft-Antispam-PRVS: <AM0PR04MB4211C9F7B9B24306E6A450C280450@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 0727122FC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(52116002)(386003)(6512007)(6486002)(7736002)(51416003)(106356001)(14444005)(305945005)(105586002)(6916009)(5660300001)(2361001)(2351001)(186003)(16526019)(76176011)(86362001)(39060400002)(26005)(4326008)(3846002)(81166006)(25786009)(6116002)(486006)(2906002)(66066001)(97736004)(53936002)(36756003)(6506007)(478600001)(8936002)(47776003)(8676002)(316002)(54906003)(956004)(15650500001)(11346002)(16586007)(2616005)(68736007)(81156014)(446003)(48376002)(50466002)(476003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:TxsXHHITql4d7u2GM5sa4VNOTo4pVHpJInQPlpBPj?=
 =?us-ascii?Q?7CHVR4s63a/m7MgxXxtdj4prm12B23PzgeDY4OR6RK2wKqpzRODUPD/+5MPH?=
 =?us-ascii?Q?2yje8M3VmefyIXPzOqR73yTmYsrDDubGuKp/Dr2Ku4svQfIpuhvQ9ZTaE+rZ?=
 =?us-ascii?Q?m2R4EF/PVkn0/hmZHRXGN83kUxgqwfb4cSdQnjpI7BAFhoQHnu71rQ4+zdI0?=
 =?us-ascii?Q?NI/verhdZOZY8pcGg/8Fq2tMG0HWM3gSYhhoe6xEWqLJ02Gj/x95vssjDXnL?=
 =?us-ascii?Q?daartatgihy4rLi37yL5KJB1f53QaYLzECNoylWverQPs5+TRYb4ahDbP5CF?=
 =?us-ascii?Q?gG7TZAYXH3SDwmlkvTSyRDRGoa0OFeeZWJT8grdBuTwf117EwXeKBopi0IR9?=
 =?us-ascii?Q?ykgqy1HzdhInHddXnmM1TqrWDcctL6HYJdS839PeD6XA9o8svt4TCsQCAYJA?=
 =?us-ascii?Q?FWTq0C69GzvXMPUxzKjfqMw2g1NRtI1x9ukdu+gBU052rrbF5agwpR/CQCx/?=
 =?us-ascii?Q?N0e3RGY7aU3I55MuxR6spcFmFIn3WmSpyTyDv38iWmurM2OE2hq6V+RcRW6e?=
 =?us-ascii?Q?Tk73f7Lq7dez6Yj6ABcglAhZ07dE3P0UH5/0qmQcEqptczGFiklRy4lgtQQp?=
 =?us-ascii?Q?2EszyaBk7eBo/4jxYWwbKP/IIEi3OETqYjhO+WpyqCf8Mu8y1reXJGQQrzbA?=
 =?us-ascii?Q?Wyq9VmhMxe5uhld0Aq36B6THPNdTMjhVK3rRU8UnW2/lFB7x7Ac1e/tjaF+g?=
 =?us-ascii?Q?8fpxubbqfk3ImWNyizyLiW9ylQ6CvM9URXYGLBpFD1w5czywYtK0vcgcymgk?=
 =?us-ascii?Q?h6VaUhnd1uUGYDW28ZLyFbM7tqcU8ED/Fzc53yDW4gU9/D1+1s5kuP0QPvRb?=
 =?us-ascii?Q?BAFq73wtDlZbtn8K2zOLxKk/d4GUFyM/rczTD5EZ5eUQRyHZT9D1pBV+p/Qq?=
 =?us-ascii?Q?Qofz0saGEr6imufM4jtjAdV8OdScJkfH+n0aBNN7h0EbJFYC0NNvBC1HYgjT?=
 =?us-ascii?Q?hqu2rhjNtRhmi+/t8kI81I1isnekxOPPxb2YyRe44R6fLNvivtT2w0Rdxtnd?=
 =?us-ascii?Q?FCthgZdxPyfhK+1TMKoFkcZKTZyQ0xKorfWlkCL14L+/CejuoitfPSThDw4p?=
 =?us-ascii?Q?ub4mwqsnfojfI5JIVk9KaVhhdeH6K4vRSk3HI1Svrzl/h2LQ/f5BY5lxU/nx?=
 =?us-ascii?Q?mBs5LEyypPJT00xpKS9NNOCd7h1pZOWguES7c+Bu22Wy2yQBhC3o+Y4TWvkv?=
 =?us-ascii?Q?NcKQgiwQHgoVz5PFp10JZNgZOm9rM1UYmdtAahu?=
X-Microsoft-Antispam-Message-Info: NbIQVqCQxlVTuqow7RSCSsSExb+R1hLTTAxAs5Tk7ISrmayMlXQ5yLq16vVMrxUP24tLFgPhimCOqlCPas2EipbLA5oJEeRoqKwosl2C3ozaHO7l+Sd59r47fWFj6FdjDjBgzBxtQdFCff+wCibpXD1sy3jx0zzibxxxJqY6j03VkERuD9T3a9+cKG/GVIx09g1loZUXC1iP5gG00n60np0yHXBdAqPmZVTNHSdW+JI+RVZSRzmSW7gmoCiONDAP5mUmNMeqM6vJeBin8Nn8UlYH+F+FW6i+HvzBvJL5bIEsTOMP80OXigYR2axYLU5V83vfaLmUI7TKk8XYz00haZyPvlSLa9ZNYbw7YwCtWCw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:NP4RiidxZ+nKMnApv6NbXzYSMCGj8WQDD3vjVGSMvKEiojBpXqAZY+hbkKuZWGHYecxU05Dftg9ubBuJRve1BXknFFmtolAJQ8cj6Jw4Fz6PKqSyRhsi2l/ZHeN5Uz61YVhSVSdNXOk9l1yCgmmBkUyjQtBSBoBZRAogQHpMh5PIfzlk1leDkvAt6g10P6B1JI8mffl20YcjYrSZNva1Op5bcXaSCUvE7alYIBudDgB+yJJ3KHlclxz3PzMSmBJSSLS3NRYTUkfIzWRvSEaOru0FysB86oMfYoX61ultMowyfK2lwSX4Hjkyvej7lca86UnqNtXzTWwjn/iEnh5XyztFFl23gQOK8cqrF30BN7YBVgy+OCnQToXRKvsctZlAgsLng27CDDTG37Xk/9vqXh6bxOxrd5rMdK0jdrFeKdm6DjWqwJuB9C924K3o8+0FKD/3ctMnwUYrGkPfJiQQvA==;5:foOvovTv8/c8yxXx+AH+b+7N9qMJnM8p+Son/EqhQMkOXfVulG1KUb65tlhVPrf8V35qfKYG9eqmA4Xpj+d51d5ARbCgCFGzqq9BQ25IH90z0/0PgWQO7dWMudRFkS/3/qxRUWHzzQfLrzJ7sRlwXoCRBNZYXVfmDay8V9NZ/PA=;24:11Slnrs/7pknh+oulFSTEFRTeBPTupvNeDpYym1lo3p10lYabvGefMITBBYO8vSS1XFNbcJ9Vkzp+dK2Aexa5qqzCRwpAOZk9agc/MYLHZc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;7:uKLPqdtZi+P5T0SKnpNfEQ2cEPMd9/denh3GC+Xq95ftAANNs/AvNDSNG5fX3IEC+7tddpf0NHnYszMQHIyD9f3/Oe4ndsf2ZtGJ3PHXI1xOPwRKjlW7pkoBmtpjxUdfpw6gtq/TMOGuNvDFrA3+aRP2HTOvZny1oRi/YunEF1BISxlkNHWOz2cIMIdcrmaWlrqA5gBTTMwb2tqRxn5ajC5IDMlimd2AAPmw8F58ws16BTSlzTYyr3pxYCa1dD/B
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2018 14:59:52.2197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c3b04-c619-4ba3-49d8-08d5e4e37734
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used for i.MX multi core communication.
e.g. A core to SCU firmware(M core) on MX8.

Tx is using polling mode while Rx is interrupt driven and
schedule a hrtimer to receive remain words if have more than
4 words.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * New patch
   Old MU library dropped
---
 drivers/mailbox/Kconfig  |   8 ++
 drivers/mailbox/Makefile |   2 +
 drivers/mailbox/imx-mu.c | 341 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/mailbox/imx-mu.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..4dd4823 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -124,6 +124,14 @@ config HI6220_MBOX
 	  between application processors and MCU. Say Y here if you want to
 	  build Hi6220 mailbox controller driver.
 
+config IMX_MU
+	tristate "IMX MU Mailbox"
+	depends on ARCH_MXC && OF
+	help
+	  An implementation of the i.MX MU Mailbox. It is used to send message
+	  between application processors and other processors/MCU/DSP. Select
+	  Y here if you want to use i.MX MU Mailbox controller.
+
 config MAILBOX_TEST
 	tristate "Mailbox Test Client"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index cc23c3a..fa62f07 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -31,6 +31,8 @@ obj-$(CONFIG_HI3660_MBOX)	+= hi3660-mailbox.o
 
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
+obj-$(CONFIG_IMX_MU)		+= imx-mu.o
+
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
 
 obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
diff --git a/drivers/mailbox/imx-mu.c b/drivers/mailbox/imx-mu.c
new file mode 100644
index 0000000..339dfa9
--- /dev/null
+++ b/drivers/mailbox/imx-mu.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ *
+ *  Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define MU_xTR0		0x0
+#define MU_xRR0		0x10
+#define MU_xSR		0x20
+#define MU_xCR		0x24
+
+#define MU_TR_COUNT		4
+#define MU_RR_COUNT		4
+
+#define MU_CR_GIEn_MASK		GENMASK(37, 28)
+#define MU_CR_RIEn_MASK		GENMASK(27, 24)
+#define MU_CR_TIEn_MASK		GENMASK(23, 20)
+#define MU_CR_GIRn_MASK		GENMASK(19, 16)
+#define MU_CR_NMI_MASK		BIT(3)
+#define MU_CR_Fn_MASK		GENMASK(2, 0)
+#define MU_CR_RIE0_SHIFT	27
+#define MU_CR_TIE0_SHIFT	23
+#define MU_CR_RIE0_MASK		BIT(27)
+#define MU_CR_GIE0_MASK		BIT(31)
+
+#define MU_SR_TE0_MASK		BIT(23)
+#define MU_SR_RF0_MASK		BIT(27)
+
+#define MU_SCU_MAX_MSG		8
+#define MU_DATA_TIME_OUT_US	(100 * USEC_PER_MSEC)
+
+struct imx_mu {
+	void __iomem *regs;
+	struct mbox_controller mbox;
+	struct mbox_chan chans;
+	struct hrtimer poll_hrt;
+	/* for runtime scu msg store */
+	u32 *msg;
+};
+
+/*
+ * Wait to receive message from the other core.
+ */
+static int imx_mu_receive_msg(struct mbox_chan *chan, u32 index, u32 *msg)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = MU_SR_RF0_MASK >> index;
+
+	/* Wait RX register to be full. */
+	ret = readl_poll_timeout_atomic(mu->regs + MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU receive register (%u) full timeout!\n",
+			index);
+		return ret;
+	}
+
+	*msg = readl(mu->regs + MU_xRR0 + (index * 4));
+
+	return 0;
+}
+
+/*
+ * Wait and send message to the other core.
+ */
+static int imx_mu_send_msg(struct mbox_chan *chan, u32 index, u32 msg)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = MU_SR_TE0_MASK >> index;
+
+	/* Wait TX register to be empty. */
+	ret = readl_poll_timeout_atomic(mu->regs + MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU transmit register (%u) empty timeout!\n",
+			index);
+		return ret;
+	}
+
+	writel(msg, mu->regs + MU_xTR0  + (index * 4));
+
+	return 0;
+}
+
+static enum hrtimer_restart imx_chan_recv_hrtimer(struct hrtimer *hrtimer)
+{
+	struct imx_mu *mu = container_of(hrtimer, struct imx_mu, poll_hrt);
+	u8 *raw_data = (u8 *)mu->msg;
+	int size;
+	int ret;
+	int i;
+
+	/* check msg size */
+	raw_data = (u8 *)mu->msg;
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "receive the remain %d words\n", size - 1);
+
+	for (i = 1; i < size; i++) {
+		ret = imx_mu_receive_msg(&mu->chans, i % 4, mu->msg + i);
+		if (ret)
+			break;
+	}
+
+	mbox_chan_received_data(&mu->chans, (void *)mu->msg);
+
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t imx_channel_irq(int irq, void *data)
+{
+	struct imx_mu *mu = data;
+	u32 status, mask;
+	u8 *raw_data;
+	int size;
+	int i;
+
+	/* Only enabled RIE0 interrupt */
+	status = readl(mu->regs + MU_xSR);
+	if (!(status & MU_SR_RF0_MASK))
+		return IRQ_NONE;
+
+	/* Get the first data */
+	*mu->msg = readl(mu->regs + MU_xRR0);
+
+	/* check msg size */
+	raw_data = (u8 *)mu->msg;
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "receive data: head 0x%x\n", *mu->msg);
+
+	if (size > MU_SCU_MAX_MSG) {
+		dev_err(mu->mbox.dev,
+			"exceed the maximum scu msg size : %d\n", size);
+		return IRQ_HANDLED;
+
+	} else if (size > 1 && size <= 4) {
+		/* check remain data mask */
+		mask = GENMASK(MU_CR_RIE0_SHIFT	- 1, MU_CR_RIE0_SHIFT - size + 1);
+		status = readl(mu->regs + MU_xSR);
+
+		if ((status & mask) != mask) {
+			dev_dbg(mu->mbox.dev,
+				"start hrtimer to receive the remain %d words\n", size - 1);
+			hrtimer_start(&mu->poll_hrt, ktime_set(0, 0),
+				      HRTIMER_MODE_REL);
+			return IRQ_HANDLED;
+		}
+
+		dev_dbg(mu->mbox.dev,
+			"receive data: size %d mask 0x%x status 0x%x\n",
+			size, mask, status);
+
+		for (i = 1; i < size; i++)
+			mu->msg[i] = readl(mu->regs + MU_xRR0 + i * 4);
+
+	} else if (size > 4) {
+		dev_dbg(mu->mbox.dev,
+			"start hrtimer to receive the remain %d words\n", size - 1);
+		hrtimer_start(&mu->poll_hrt, ktime_set(0, 0),
+			      HRTIMER_MODE_REL);
+
+		return IRQ_HANDLED;
+	}
+
+	mbox_chan_received_data(&mu->chans, (void *)mu->msg);
+
+	return IRQ_HANDLED;
+}
+
+static int imx_mu_chan_send_data(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u8 *raw_data = data;
+	int i, ret;
+	int size;
+
+	if (!data)
+		return -EINVAL;
+
+	mu->msg = data;
+
+	/* SCU protocol size position is at the second u8 */
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "send data (size %d)\n", size);
+
+	for (i = 0; i < size; i++) {
+		ret = imx_mu_send_msg(chan, i % 4, *(mu->msg + i));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_startup(struct mbox_chan *chan)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 val;
+
+	/* Enable RIE0 interrupt */
+	val = readl(mu->regs + MU_xCR);
+	val |= MU_CR_RIE0_MASK;
+	writel(val, mu->regs + MU_xCR);
+
+	return 0;
+}
+
+static void imx_mu_chan_shutdown(struct mbox_chan *chan)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 val;
+
+	/* Clear RIEn, TIEn, GIRn and ABFn. */
+	val = readl(mu->regs + MU_xCR);
+	val &= ~(MU_CR_RIEn_MASK | MU_CR_TIEn_MASK |
+		 MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel(val, mu->regs + MU_xCR);
+}
+
+static struct mbox_chan_ops imx_mu_chan_ops = {
+	.send_data = imx_mu_chan_send_data,
+	.startup = imx_mu_chan_startup,
+	.shutdown = imx_mu_chan_shutdown,
+};
+
+static struct mbox_chan *imx_mu_index_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *sp)
+{
+	if (sp->args_count != 0) {
+		dev_err(mbox->dev,
+			"incorrect mu channel specified in devicetree\n");
+		return NULL;
+	}
+
+	return &mbox->chans[0];
+}
+
+static int imx_mu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *mbox;
+	struct resource *res;
+	struct imx_mu *mu;
+	int irq, err;
+	u32 val;
+
+	mu = devm_kzalloc(&pdev->dev, sizeof(*mu), GFP_KERNEL);
+	if (!mu)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mu->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mu->regs))
+		return PTR_ERR(mu->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "can't get irq number\n");
+		return irq;
+	}
+
+	err = devm_request_irq(dev, irq, imx_channel_irq, 0,
+			       dev_name(dev), mu);
+	if (err < 0) {
+		dev_err(dev, "Failed to request IRQ#%u: %d\n", irq, err);
+		return err;
+	}
+
+	hrtimer_init(&mu->poll_hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	mu->poll_hrt.function = imx_chan_recv_hrtimer;
+
+	platform_set_drvdata(pdev, mu);
+
+	mbox = &mu->mbox;
+	mbox->dev = dev;
+	mbox->num_chans = 1;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+	mbox->chans = &mu->chans;
+	mbox->ops = &imx_mu_chan_ops;
+	mbox->of_xlate = &imx_mu_index_xlate;
+	mu->chans.con_priv = mu;
+
+	/* Init MU */
+	val = readl(mu->regs + MU_xCR);
+	/* Clear GIEn, RIEn, TIEn, GIRn and ABFn. */
+	val &= ~(MU_CR_GIEn_MASK | MU_CR_RIEn_MASK | MU_CR_TIEn_MASK |
+		 MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel(val, mu->regs + MU_xCR);
+
+	err = mbox_controller_register(mbox);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
+	dev_info(dev, "registered mailbox\n");
+
+	return 0;
+}
+
+static const struct of_device_id imx_mu_match[] = {
+	{ .compatible = "fsl,imx8qxp-mu", },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver imx_mu_driver = {
+	.driver = {
+		.name = "imx-mu",
+		.of_match_table = imx_mu_match,
+	},
+	.probe = imx_mu_probe,
+};
+
+static int __init imx_mu_init(void)
+{
+	return platform_driver_register(&imx_mu_driver);
+}
+core_initcall(imx_mu_init);
-- 
2.7.4

