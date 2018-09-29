Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA112064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="PXqXXD/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA112064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeI2Or3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:47:29 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:13984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727639AbeI2Or3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zz+lBilSnEJgq2y/vaF26fFkEuG7wy2mfyZX3x/ya0=;
 b=PXqXXD/QkLpyOt/Ns+Ru3SesKFKcV34PrLpmvyy/hDSlaIV96s4tOjW/tKYLw63jT35aTbUoN4zXrck0huqdtV0QIaSkoffsViHT4gs1Q/j1pGAZA2s+nQ13YO91RbuA5yKLVXWp4f78H7vHwV+OdmB0vTTWz+BfUUzDXRo3IjM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 BN7PR07MB4610.namprd07.prod.outlook.com (2603:10b6:406:f2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Sat, 29 Sep 2018 08:19:55 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH cryptodev-2.6 3/4] crypto: cavium/nitrox - NITROX command queue changes.
Date:   Sat, 29 Sep 2018 13:49:09 +0530
Message-Id: <20180929081910.17652-3-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
References: <20180929081910.17652-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To BN7PR07MB4610.namprd07.prod.outlook.com
 (2603:10b6:406:f2::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee3a853-61ea-4223-e3f0-08d625e45757
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4610;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;3:J2eZGqGzxWOYfNJRk75MMGTjbVr3b3UH6Aa5IyicTko+qOOyX6TYhrg4txtLJS+PzuH3RGGTNdgLy9J43NGB7FkbERkcpsNBC8RskMlD1O21egQdloWXCMlRPfnRFhRGJzG8FjcSEOojLezCvku3TKYW6nLWFDdSVxeaHhM3IRFRFdNKbrKoMkiU0NhOs2k5Kd2S6NYRZKlv5zadolD/XVC31ZPeYO8uqc8lcwlvRHJdyogU1ISFT4ezQ8bNwavG;25:kvF/qPjn8lQK2etJdq4kN2of8zOL/3QPt+rj0T77BXg6om7kw9O/eCDTeKjUqD7JX3NwWRI48fP6EmzFqtVHzKK3ysneI+fahd4nWhIi52KyC/xYDOtWFgMD/YQdSLIFQq43aid5MStXJXfvvYAs0el5fya0bo2EbRrCtPEuzmQB8ekAm5gtLeaHjXin/qRA00ceZzP6at6eZfgHOb5HlD/hAeVniWv5tP1f5pvmFexVbCT6IGulGsC1zy4Gn55CEWiqqZ5XbUvtmA06aa9nk9M9mgWFd3soQIecDC3weGkTH0udZGLK4A6Dfemmay0nn2Q6NAmd3RBClFHqlZmNZA==;31:3XA3izXi8t1jIty2PcfI2vqjMM/n5UcVCDAA+CVZLEQHLFui6khn+JuLr4tRHEjpIHgwjfaAFUSVbJq6o5B9SBUeCK1gXWnuGTjCAowLTcOIQ3WSMooFWPSIp8JimqQC/MmPOGMMf9A7K9iIDO51bQeap0ohEujU2crCIUfalV7mcJgLbfrxuJmkXiDYZ+8SrLrdfaWDKZNg8WPgLjyQkYnDvEAdELiZ0ian5Bsmafw=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4610:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;20:sH2wq/C93OU6FM3ZTO5Wf+Zvn1JYEhaVlP4mT/fEZt+FyoYTFcVxCY+M0gZl99h8rg41U49tJYxpNz6yAdWZR4aZsSr0CAVSR3AweGlYOTp+r6RDnTbVpPrnNWX0TJdkQXjtofEJEq1QA+G5K6fLJWHlWsy0MIdN3qAOblsDTX4KmP8DCaRSMn9YPb8FP2R7tMJgiGTPhxe2Em78IwR1dPLSr86OpaTxaFXybvXpMOXpa+VtXrbFocNHtAmE9jX7yGhw+d0sqpkP2CoXZxbdHhJL5OBij6Hg/Wnq4Dl8lXZR+mO/2brFCN2wli6coPzEeL1Nljep66ELfuzH+6Dq+kvG/vAj01rVi87XsvTVm9w6n2RbkdEGDZUdb+Mb+PvuSwojzNUAD3vPKTJGaDQ3ww5yJHAAZUzsuwavygzSEg0BtM66mYiZ5mE094YtytudhmtFA+Qc/4JpXoVFRGX1sT0bnN/lPQKDxElb4Bv6gjHephkIeuSGNSW/DWyKw1c1;4:igj1oylGuAX+5JQd2+rtcIMNgVBUxT+1Q4NvHNb4TCPr69JaEoG0cEjFuNrCyGH+p9g+yS9cm3/zsxFUJyAsRMfVPoQ+pcku1MZEIx+L2eUg3Co76u/MeH/a2qbd+ay7te5PEiEijIYqDb6cWrgqshoFH+yS/9/tN6IBgzr5FAiBsz9/9fuoGJ6A1afYw1qp79q+TCy3+T2sFQrsbYTB+ZNjHUL1j9ed0Bg8WXr3gkHJU8EOVcLlpy5eGjXxU6aNEq73X7WyX6z3FTPOKbs/7w==
X-Microsoft-Antispam-PRVS: <BN7PR07MB46108BE038B079AC2D663344F4ED0@BN7PR07MB4610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR07MB4610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4610;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(7736002)(11346002)(69596002)(34290500001)(956004)(386003)(53936002)(50466002)(81166006)(105586002)(81156014)(2616005)(68736007)(52116002)(186003)(6506007)(6512007)(50226002)(106356001)(8936002)(16526019)(26005)(53416004)(86362001)(76176011)(5660300001)(16586007)(48376002)(316002)(6486002)(25786009)(51416003)(478600001)(72206003)(3846002)(8676002)(66066001)(6116002)(6666003)(47776003)(446003)(2906002)(476003)(1076002)(107886003)(36756003)(97736004)(305945005)(486006)(4326008)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4610;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4610;23:y49IuhmUYHVoCbHaF2YCM9AIUSCnj+zcvD5WIfJd3?=
 =?us-ascii?Q?Axe9q9VpnPBlMl6wo2nmMwNKW2ZOycyM2498Q2t+aQl3eEhkfcnQI/oR3Gdo?=
 =?us-ascii?Q?Ty1tgN3fvB63KcqV474QjT0Uul6yCRypHR+rOKnbq/DpOhqBto77GSgU0mzu?=
 =?us-ascii?Q?EUa4Ex05FAJoxS2zKpzZPCgeaLGTrl0HcBsg/Ls+gfG2xh3RJecbPdEMISWq?=
 =?us-ascii?Q?5ldWErCpXzoFTb/U4c+XmYq1bjpR2qhA7IaBBHY0uYBhFsPQvXIa8hcEiDOB?=
 =?us-ascii?Q?QWkTtXvwszn5w6tdutgB4bo4gokVPRGNNA8FVVHVXWJPiiMWolXAgRYjEexm?=
 =?us-ascii?Q?7Cvp/uMQgWXB7Wj3QqjeV5mJnqW6kDVLjpTZ3dSn3nNCxtRHyhyszoekpxbc?=
 =?us-ascii?Q?6fNI0iUBmfTPH3CFnlnn8jq1+RGfnsHul5x9mjq5lHtkVjQa9W0SuSB5Cv6g?=
 =?us-ascii?Q?6sU91X4SJl5qqaQ30TpL56OcNT3QSrCQRdKgCFdCBQwyWVrtVQnSJcRp/B5l?=
 =?us-ascii?Q?qZ7YBh2tUYMuWOAI7X6cpfp0se7GgjPnsyKrAEn4zANXErKoe69trxHI2tCF?=
 =?us-ascii?Q?DX4TMEB0GUaGY7o+MSo/NaT9qlkwVFEnvg90aQ6Fh7b121CFcpnA5p6zxGut?=
 =?us-ascii?Q?3JPN7gCAKpBOmpr/EisL5yTBJL9dxJg6pJQY7O05o7bXhB/mUm1JOTRA3C4e?=
 =?us-ascii?Q?R26VvSZXv9g9UUFpRSdzs8/EPVowDcPKQ8fJKz2x980hxmk2/7H3bPetGL1g?=
 =?us-ascii?Q?i8dPSKIEHnc/e9ANFzJHtXncrDm2MYtrqiByZqdMNMbkd+L0H7RHzMtKSk5s?=
 =?us-ascii?Q?gSwoHhrf5QlWSpSVKCew0Y6xNc9rZq3tD+WIwAODGeS16C8knOe6pol3La5k?=
 =?us-ascii?Q?eWrQl5CzRifk7AnkIhViIgaX+51ubs30jw9k7eON5ctYPo7K7ID+3Jol4x1e?=
 =?us-ascii?Q?oHg6QswD2yyZLU/NZgfaCW9tyTtzIcc69kW+ivaLMhjl0fra6V59W7SrlX6F?=
 =?us-ascii?Q?b7jBDCQk1DLgQ23o6DRJ9rglkBE6uBFy02mnJVbkCX5hIrPM/FF2fpKh9fJ9?=
 =?us-ascii?Q?tRRQue7znk6R2jRR70cK55AjnkYqYdaiQ1MU8mn0ESrdSAK4xygzZpPYhLKt?=
 =?us-ascii?Q?sas/qsl6rCt/79JhPI09cGADgX9L/PoR5iWyAMIP0JW1fl1s/NmUNnlheJLD?=
 =?us-ascii?Q?vYFEZsPy2LoJKD6/iS8VeKq09HVB4sJzKcmbPZQ7lySgqPIHkC+IKB8Qu8hd?=
 =?us-ascii?Q?vbZTLzNCsjvsHQ2772oRQomMWp5P0/GBI090qWdNrR4LghxqcSUoyLdnsrSe?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: EoJz+ZX+EcfbLsGZbpgR7WHX6zBmxPJ80NJklIsKPd1X/TrjE32gKTKB0q8B0XWrQR71NRgthc5DEnnA0AOgO669EkKCwul747j+cQ/S1Oi/8nNDE+BSh1L3ZRHSL63rfDz+OGBM2Zojuh3WuKNiDKoVtt0vGHkidsHokFQGrZPXhDl/wdjd0naM/WYJqNbkh81IN/wy54anCJUX9XX2YoNsWhEuyR8mI/upvJA/6znlADHppsWyM4ibLu7oMDnCmiJuAJ//02sPDlRCK1f345hzNJuqhBSASlf73Jw/Gzy0K7PxAcD11+myrM693Bm7E4kd7/eRfePQ3UiGAAf2Bj+0kH1vUfdyM2YFRc8vJEE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4610;6:boOBXAe70CxtnoWgWFYrOT04Iys1gXtlijBGoXTA0fyqGjlEZVRFQO/DUPw0nctn/c7vz++n5FaWrBH1NxUhSGd/ws7JQ4xUVGYfRaFhuuhDLOC3RyUqkxNWwnXzXvFmSPFx8nz8b1uufsAQy4RFat8ap7rtFsHfT8V5J09Ey8ssRXwJCL8a0b+mdpqTugIz76NNWhC3T3F+wVkgdRwPbXITw9jDTxCSD32FrXcDc1cPNYQfeBqJWAq1rQfgcrFEL3VCnlT6XBuj/ygR4QvHYhsk/56g/dvsyPy8uw5VPL2Vlf8ktqcEZganeKoMXi6D5MBNTKpbSfp59ZFkHKBkFuafymuBYTaSH1NiHvMGMnG5bcWhXzGZQjVN3k/tYHf9enwl+xS6OoSn8R/H3C7MxgPK+bWOJ+L7wx2c3hfZPskUUL2F+yHsY4qSXX7PLvPPCVLap3XEY2L8QZ95eTeGVA==;5:Hyz1L0xFdrFFGjXODcIgC6OyylmQwrc+2h61XG1b2oSjNqFZZBL8HxGUcIfArdu0pENR1VgE5ETJ6BZh2uvxp9LGI8Ukt8CPR4MJ1WM25323Ke3rA3zShoiZD50z4yYsq0V3nNZ59vHrsx7QbGPNgWfVvvEU49IQo4dY4X8L89Q=;7:FMcBlCweIat5bAKwufAbUqam34PgkU7XeMgA1lcT9rw/KEX0kqL4W2tCCXys6+45Y9VUUQs6DEV7q3rPLWxvOCHVs9iwdZ0K/UqGirbjjbRh7Axg8dw4PvTaKkHI4UDffTPw4wANEdt397ewBCOlHlS/Hmu+sQW0t2SfZWtCdnQZtiA24zO0ecDUOW7yM1//EL65P1wnur1IrYSzBM9aMEiDzB1LuxjdSiF2fN/TpPCwQNgSc5vayfiFbcPp4PhB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 08:19:55.0490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee3a853-61ea-4223-e3f0-08d625e45757
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use node based allocations for queues. consider the dma address
alignment changes, while calculating the queue base address.
added checks in cleanup functions. Minor changes to queue variable names

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_dev.h    | 55 ++++++------
 drivers/crypto/cavium/nitrox/nitrox_hal.c    |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.c    |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c    | 90 +++++++++++---------
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 24 +++---
 5 files changed, 94 insertions(+), 79 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index abb5c8ac54e5..62fb75923bfe 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -9,44 +9,51 @@
 
 #define VERSION_LEN 32
 
+/**
+ * struct nitrox_cmdq - NITROX command queue
+ * @cmd_qlock: command queue lock
+ * @resp_qlock: response queue lock
+ * @backlog_qlock: backlog queue lock
+ * @ndev: NITROX device
+ * @response_head: submitted request list
+ * @backlog_head: backlog queue
+ * @dbell_csr_addr: doorbell register address for this queue
+ * @base: command queue base address
+ * @dma: dma address of the base
+ * @pending_count: request pending at device
+ * @backlog_count: backlog request count
+ * @write_idx: next write index for the command
+ * @instr_size: command size
+ * @qno: command queue number
+ * @qsize: command queue size
+ * @unalign_base: unaligned base address
+ * @unalign_dma: unaligned dma address
+ */
 struct nitrox_cmdq {
-	/* command queue lock */
-	spinlock_t cmdq_lock;
-	/* response list lock */
-	spinlock_t response_lock;
-	/* backlog list lock */
-	spinlock_t backlog_lock;
-
-	/* request submitted to chip, in progress */
+	spinlock_t cmd_qlock;
+	spinlock_t resp_qlock;
+	spinlock_t backlog_qlock;
+
+	struct nitrox_device *ndev;
 	struct list_head response_head;
-	/* hw queue full, hold in backlog list */
 	struct list_head backlog_head;
 
-	/* doorbell address */
 	u8 __iomem *dbell_csr_addr;
-	/* base address of the queue */
-	u8 *head;
+	u8 *base;
+	dma_addr_t dma;
 
-	struct nitrox_device *ndev;
-	/* flush pending backlog commands */
 	struct work_struct backlog_qflush;
 
-	/* requests posted waiting for completion */
 	atomic_t pending_count;
-	/* requests in backlog queues */
 	atomic_t backlog_count;
 
 	int write_idx;
-	/* command size 32B/64B */
 	u8 instr_size;
 	u8 qno;
 	u32 qsize;
 
-	/* unaligned addresses */
-	u8 *head_unaligned;
-	dma_addr_t dma_unaligned;
-	/* dma address of the base */
-	dma_addr_t dma;
+	u8 *unalign_base;
+	dma_addr_t unalign_dma;
 };
 
 /**
@@ -152,7 +159,7 @@ enum vf_mode {
  * @nr_queues: Number of command queues
  * @mode: Device mode PF/VF
  * @ctx_pool: DMA pool for crypto context
- * @pkt_cmdqs: SE Command queues
+ * @pkt_inq: Packet input rings
  * @msix: MSI-X information
  * @bh: post processing work
  * @hw: hardware information
@@ -177,7 +184,7 @@ struct nitrox_device {
 	enum vf_mode mode;
 
 	struct dma_pool *ctx_pool;
-	struct nitrox_cmdq *pkt_cmdqs;
+	struct nitrox_cmdq *pkt_inq;
 
 	struct nitrox_msix msix;
 	struct nitrox_bh bh;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_hal.c b/drivers/crypto/cavium/nitrox/nitrox_hal.c
index 4627a1976176..a9b82387cf53 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_hal.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_hal.c
@@ -119,7 +119,7 @@ void nitrox_config_pkt_input_rings(struct nitrox_device *ndev)
 	int i;
 
 	for (i = 0; i < ndev->nr_queues; i++) {
-		struct nitrox_cmdq *cmdq = &ndev->pkt_cmdqs[i];
+		struct nitrox_cmdq *cmdq = &ndev->pkt_inq[i];
 		union nps_pkt_in_instr_rsize pkt_in_rsize;
 		u64 offset;
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cavium/nitrox/nitrox_isr.c
index 4f4334929f35..baeacacbddbe 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -335,7 +335,7 @@ static int nitrox_setup_pkt_slc_bh(struct nitrox_device *ndev)
 		offset = NPS_PKT_SLC_CNTSX(i);
 		/* pre calculate completion count address */
 		bh->completion_cnt_csr_addr = NITROX_CSR_ADDR(ndev, offset);
-		bh->cmdq = &ndev->pkt_cmdqs[i];
+		bh->cmdq = &ndev->pkt_inq[i];
 
 		tasklet_init(&bh->resp_handler, pkt_slc_resp_handler,
 			     (unsigned long)bh);
diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index 7a721c7c12a4..ed08aa9380ee 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -17,30 +17,27 @@
 
 #define CRYPTO_CTX_SIZE	256
 
-/* command queue alignments */
-#define PKT_IN_ALIGN	16
+/* packet inuput ring alignments */
+#define PKTIN_Q_ALIGN_BYTES 16
 
-static int cmdq_common_init(struct nitrox_cmdq *cmdq)
+static int nitrox_cmdq_init(struct nitrox_cmdq *cmdq, int align_bytes)
 {
 	struct nitrox_device *ndev = cmdq->ndev;
-	u32 qsize;
-
-	qsize = (ndev->qlen) * cmdq->instr_size;
-	cmdq->head_unaligned = dma_zalloc_coherent(DEV(ndev),
-						   (qsize + PKT_IN_ALIGN),
-						   &cmdq->dma_unaligned,
-						   GFP_KERNEL);
-	if (!cmdq->head_unaligned)
+
+	cmdq->qsize = (ndev->qlen * cmdq->instr_size) + align_bytes;
+	cmdq->unalign_base = dma_zalloc_coherent(DEV(ndev), cmdq->qsize,
+						 &cmdq->unalign_dma,
+						 GFP_KERNEL);
+	if (!cmdq->unalign_base)
 		return -ENOMEM;
 
-	cmdq->head = PTR_ALIGN(cmdq->head_unaligned, PKT_IN_ALIGN);
-	cmdq->dma = PTR_ALIGN(cmdq->dma_unaligned, PKT_IN_ALIGN);
-	cmdq->qsize = (qsize + PKT_IN_ALIGN);
+	cmdq->dma = PTR_ALIGN(cmdq->unalign_dma, align_bytes);
+	cmdq->base = cmdq->unalign_base + (cmdq->dma - cmdq->unalign_dma);
 	cmdq->write_idx = 0;
 
-	spin_lock_init(&cmdq->response_lock);
-	spin_lock_init(&cmdq->cmdq_lock);
-	spin_lock_init(&cmdq->backlog_lock);
+	spin_lock_init(&cmdq->cmd_qlock);
+	spin_lock_init(&cmdq->resp_qlock);
+	spin_lock_init(&cmdq->backlog_qlock);
 
 	INIT_LIST_HEAD(&cmdq->response_head);
 	INIT_LIST_HEAD(&cmdq->backlog_head);
@@ -51,68 +48,79 @@ static int cmdq_common_init(struct nitrox_cmdq *cmdq)
 	return 0;
 }
 
-static void cmdq_common_cleanup(struct nitrox_cmdq *cmdq)
+static void nitrox_cmdq_reset(struct nitrox_cmdq *cmdq)
+{
+	cmdq->write_idx = 0;
+	atomic_set(&cmdq->pending_count, 0);
+	atomic_set(&cmdq->backlog_count, 0);
+}
+
+static void nitrox_cmdq_cleanup(struct nitrox_cmdq *cmdq)
 {
 	struct nitrox_device *ndev = cmdq->ndev;
 
+	if (!cmdq->unalign_base)
+		return;
+
 	cancel_work_sync(&cmdq->backlog_qflush);
 
 	dma_free_coherent(DEV(ndev), cmdq->qsize,
-			  cmdq->head_unaligned, cmdq->dma_unaligned);
-
-	atomic_set(&cmdq->pending_count, 0);
-	atomic_set(&cmdq->backlog_count, 0);
+			  cmdq->unalign_base, cmdq->unalign_dma);
+	nitrox_cmdq_reset(cmdq);
 
 	cmdq->dbell_csr_addr = NULL;
-	cmdq->head = NULL;
+	cmdq->unalign_base = NULL;
+	cmdq->base = NULL;
+	cmdq->unalign_dma = 0;
 	cmdq->dma = 0;
 	cmdq->qsize = 0;
 	cmdq->instr_size = 0;
 }
 
-static void nitrox_cleanup_pkt_cmdqs(struct nitrox_device *ndev)
+static void nitrox_free_pktin_queues(struct nitrox_device *ndev)
 {
 	int i;
 
 	for (i = 0; i < ndev->nr_queues; i++) {
-		struct nitrox_cmdq *cmdq = &ndev->pkt_cmdqs[i];
+		struct nitrox_cmdq *cmdq = &ndev->pkt_inq[i];
 
-		cmdq_common_cleanup(cmdq);
+		nitrox_cmdq_cleanup(cmdq);
 	}
-	kfree(ndev->pkt_cmdqs);
-	ndev->pkt_cmdqs = NULL;
+	kfree(ndev->pkt_inq);
+	ndev->pkt_inq = NULL;
 }
 
-static int nitrox_init_pkt_cmdqs(struct nitrox_device *ndev)
+static int nitrox_alloc_pktin_queues(struct nitrox_device *ndev)
 {
-	int i, err, size;
+	int i, err;
 
-	size = ndev->nr_queues * sizeof(struct nitrox_cmdq);
-	ndev->pkt_cmdqs = kzalloc(size, GFP_KERNEL);
-	if (!ndev->pkt_cmdqs)
+	ndev->pkt_inq = kcalloc_node(ndev->nr_queues,
+				     sizeof(struct nitrox_cmdq),
+				     GFP_KERNEL, ndev->node);
+	if (!ndev->pkt_inq)
 		return -ENOMEM;
 
 	for (i = 0; i < ndev->nr_queues; i++) {
 		struct nitrox_cmdq *cmdq;
 		u64 offset;
 
-		cmdq = &ndev->pkt_cmdqs[i];
+		cmdq = &ndev->pkt_inq[i];
 		cmdq->ndev = ndev;
 		cmdq->qno = i;
 		cmdq->instr_size = sizeof(struct nps_pkt_instr);
 
+		/* packet input ring doorbell address */
 		offset = NPS_PKT_IN_INSTR_BAOFF_DBELLX(i);
-		/* SE ring doorbell address for this queue */
 		cmdq->dbell_csr_addr = NITROX_CSR_ADDR(ndev, offset);
 
-		err = cmdq_common_init(cmdq);
+		err = nitrox_cmdq_init(cmdq, PKTIN_Q_ALIGN_BYTES);
 		if (err)
-			goto pkt_cmdq_fail;
+			goto pktq_fail;
 	}
 	return 0;
 
-pkt_cmdq_fail:
-	nitrox_cleanup_pkt_cmdqs(ndev);
+pktq_fail:
+	nitrox_free_pktin_queues(ndev);
 	return err;
 }
 
@@ -194,7 +202,7 @@ int nitrox_common_sw_init(struct nitrox_device *ndev)
 	if (err)
 		return err;
 
-	err = nitrox_init_pkt_cmdqs(ndev);
+	err = nitrox_alloc_pktin_queues(ndev);
 	if (err)
 		destroy_crypto_dma_pool(ndev);
 
@@ -207,6 +215,6 @@ int nitrox_common_sw_init(struct nitrox_device *ndev)
  */
 void nitrox_common_sw_cleanup(struct nitrox_device *ndev)
 {
-	nitrox_cleanup_pkt_cmdqs(ndev);
+	nitrox_free_pktin_queues(ndev);
 	destroy_crypto_dma_pool(ndev);
 }
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index f325b48ba904..d606c7af4667 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -382,11 +382,11 @@ static inline void backlog_list_add(struct nitrox_softreq *sr,
 {
 	INIT_LIST_HEAD(&sr->backlog);
 
-	spin_lock_bh(&cmdq->backlog_lock);
+	spin_lock_bh(&cmdq->backlog_qlock);
 	list_add_tail(&sr->backlog, &cmdq->backlog_head);
 	atomic_inc(&cmdq->backlog_count);
 	atomic_set(&sr->status, REQ_BACKLOG);
-	spin_unlock_bh(&cmdq->backlog_lock);
+	spin_unlock_bh(&cmdq->backlog_qlock);
 }
 
 static inline void response_list_add(struct nitrox_softreq *sr,
@@ -394,17 +394,17 @@ static inline void response_list_add(struct nitrox_softreq *sr,
 {
 	INIT_LIST_HEAD(&sr->response);
 
-	spin_lock_bh(&cmdq->response_lock);
+	spin_lock_bh(&cmdq->resp_qlock);
 	list_add_tail(&sr->response, &cmdq->response_head);
-	spin_unlock_bh(&cmdq->response_lock);
+	spin_unlock_bh(&cmdq->resp_qlock);
 }
 
 static inline void response_list_del(struct nitrox_softreq *sr,
 				     struct nitrox_cmdq *cmdq)
 {
-	spin_lock_bh(&cmdq->response_lock);
+	spin_lock_bh(&cmdq->resp_qlock);
 	list_del(&sr->response);
-	spin_unlock_bh(&cmdq->response_lock);
+	spin_unlock_bh(&cmdq->resp_qlock);
 }
 
 static struct nitrox_softreq *
@@ -439,11 +439,11 @@ static void post_se_instr(struct nitrox_softreq *sr,
 	int idx;
 	u8 *ent;
 
-	spin_lock_bh(&cmdq->cmdq_lock);
+	spin_lock_bh(&cmdq->cmd_qlock);
 
 	idx = cmdq->write_idx;
 	/* copy the instruction */
-	ent = cmdq->head + (idx * cmdq->instr_size);
+	ent = cmdq->base + (idx * cmdq->instr_size);
 	memcpy(ent, &sr->instr, cmdq->instr_size);
 
 	atomic_set(&sr->status, REQ_POSTED);
@@ -459,7 +459,7 @@ static void post_se_instr(struct nitrox_softreq *sr,
 
 	cmdq->write_idx = incr_index(idx, 1, ndev->qlen);
 
-	spin_unlock_bh(&cmdq->cmdq_lock);
+	spin_unlock_bh(&cmdq->cmd_qlock);
 
 	/* increment the posted command count */
 	atomic64_inc(&ndev->stats.posted);
@@ -474,7 +474,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 	if (!atomic_read(&cmdq->backlog_count))
 		return 0;
 
-	spin_lock_bh(&cmdq->backlog_lock);
+	spin_lock_bh(&cmdq->backlog_qlock);
 
 	list_for_each_entry_safe(sr, tmp, &cmdq->backlog_head, backlog) {
 		struct skcipher_request *skreq;
@@ -497,7 +497,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 		/* backlog requests are posted, wakeup with -EINPROGRESS */
 		skcipher_request_complete(skreq, -EINPROGRESS);
 	}
-	spin_unlock_bh(&cmdq->backlog_lock);
+	spin_unlock_bh(&cmdq->backlog_qlock);
 
 	return ret;
 }
@@ -578,7 +578,7 @@ int nitrox_process_se_request(struct nitrox_device *ndev,
 	/* select the queue */
 	qno = smp_processor_id() % ndev->nr_queues;
 
-	sr->cmdq = &ndev->pkt_cmdqs[qno];
+	sr->cmdq = &ndev->pkt_inq[qno];
 
 	/*
 	 * 64-Byte Instruction Format
-- 
2.17.1

