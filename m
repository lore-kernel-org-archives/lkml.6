Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0BC20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hyMRQBcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0BC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeGWKp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:45:57 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:44192
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388083AbeGWKp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dGpd66jhEso6apISiQaFJu5TVvSKsEqdowif2s3tEk=;
 b=hyMRQBcZIzSUC5d4p3yoeJJTaxQ82a/uBFoQRWx2/1eZ67I2CN5/OSonS77+VypsRwbwR8o0gejO4GiUhfZIxohpip+Pe+BN6JKjHr+Nw1NL3nTJj2NwHirQaW3nqUvjXQiJQY9jlPywfCv4YWktt0OSn/c3giBmqCLuAf+kMxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 09:45:28 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 1/3] dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
Date:   Tue, 24 Jul 2018 01:46:10 +0800
Message-Id: <1532367972-29707-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:203:72::26) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41066a21-8e42-4dc7-6677-08d5f0810806
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:AHspo+dY4FZmazc4LuR96dz8nGB6sAt4U3zvV1e3Q8NDZ0xrowjU+6WzFhVWO4/WWLc9O//nY18XryN/dOn95RwqAKhKjDVVh66jzboG3SBCIs1KibaNe1elMODQqA8ly1NWf0ljW5+HuKuY+BLkQTxzwdqVtNDat9kS7r0ixHovYSfTodhbU68ArDwickxm5uL0Z0jd48Gl9rDlB4Torl+7eSew5NjQu20CZj206xITujMHaFEHEd2tmfaZZhZW;25:+k5SAX6nrp19OAITcr3VnTDoapgNzmjx9dfjCI5T208uV1tCi+ZAWG0nXr6khFzRYmRflfofNzzaCoRiqfvnl4fojWtT0qhTRECIs5C0naVnE4ABdkUKRiljFKMirnRR//EPgCtFehRYzgCIWrZ+Z4SupS+QhQHZiZH+TPi64vr5THd6UOae6PW+i7gK62dd1czx9OXu+Dm0vzQ44xYa3X/hNT66iInIYW9v5w4EyFsVNTUhyoILSQ0AHHFWW93UAm171YGnT26KtamLaUXVSqABRkyQS5SRDaRKwtv9rxzfJ4k8L6H7hddZYGWIsYXdKNQ3FdMXmkjMZmUKyQ7/yQ==;31:/Y3dZnUBa//kH27Wp02cj8ztcnprdVKmULQ3S2bC3lzV1p9zpn/axqM6wcRZi8endKTBOcl51llV6/8UNf34rXia+BOQuu+hwI52nxT2NhlwYfS4fF3EFWbhpnePfZtVCFyV4Kvdl65cxPKo9D/j64FSm68cMI3Th2s5M7A8Cbz6C9KQfFs7VNkbpD4KIpj6bbDMBS5DedVr769xkQ6lsUHbxFWDGtXUqnpYh9ITCT0=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:RvU6N6WwulZb0KIlc4NH1LBYLfjCiGLT2H43wcG/h6DaRDVfsywwcuBFtr01FZm7kgl7EgUFvhX/342A/CEIV26ZkbPJzGD8VjJxqFOv7NlEa08vQmSRXb0mjvknkSeS9RLrztlndGSyKeQkKl3qa6DK2VKA5pP/RDavh7OxTlp9KqD1cpJhr14DmA2KRjrpV2CzJ3Cu/u9cIGS6M0MVMTUKutfnfL5+JFjoOl684lqGVJA9CYLqZmxESXdk4xp3Wv2qroYHw9Va1yKFtBFzNrJjfmnM6GqTpqexTWbZP3U1XadaSlMBrJ5iCaFXTwlrXAiTD5H4LrJAULo206bjH6rOWQMlV59Z953BEJodZhbnGot+NySyVxd+gU6Zx6BGRJqoH5/Wysl5IC3VkGBgVy15nrImvZuCN9uwysc3MeHYQXvUo/8zmXuhPUWg2xTPjaehavoev5JX95UiNud+cG96Qa7AHx7na/0I1xrOgfqPiX9xP+g7QgoDHak7nuZZ;4:LqZrayEuk2WYN+/yePv3MJbYD+G/J2Rr1mNhCww9KJDj4/vogMA8o7Q8K8GuLvNAEDlFCEtA5PFWcLzEOG7hisRp/CBM9PRAAW0XelRrbHb1ZzVW2Rf+++8Ee7wbdo8KRnPhJDc2xpEAp9vLVGoql3sYOkiOIcDlKzlvJOwVMDjWRN9dmzk3zzrnteDTmVl3VbfC2AuAk3tvM2XvgbTFqRpQC3h5VP0/pxxBH7qzLwrZvXQLAFBLmG+6NN2FfYrvobe475v5WSAOsVIVByDo6Jvzsml45g2RUzpOYtNp1fkEqlbpp4+gx8B6Bocnex3txtoBRHPdz8TmX8QMLeVfQLs/e+w8QUWYGpIzkC7EpjM=
X-Microsoft-Antispam-PRVS: <VI1PR04MB323257AB2E98DBB428FB11F189560@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(189003)(16526019)(6116002)(3846002)(956004)(8936002)(66066001)(47776003)(53936002)(478600001)(305945005)(26005)(50466002)(48376002)(476003)(2616005)(6512007)(25786009)(7736002)(4326008)(11346002)(6506007)(386003)(14444005)(36756003)(50226002)(106356001)(97736004)(446003)(5660300001)(68736007)(6666003)(105586002)(2906002)(486006)(81166006)(8676002)(52116002)(81156014)(186003)(86362001)(51416003)(16586007)(6486002)(316002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:MjA+KuMUAYRdOwmdMdnKTlvTw76sETVA/8P5aT5Kh?=
 =?us-ascii?Q?s3yrCnlDcqFrqZxwo0mMfhqnMLpV90Vx96edNmjHIjTq01403fqUfMSnco9J?=
 =?us-ascii?Q?orkG+ldqjmMkygU+NELwTO8cRrTMA3bsSBMjFY6IcgRZI5gwgTsper8Jfld+?=
 =?us-ascii?Q?TzGWMqocywK2zJyOHnAih528GXfTw9Ux3DHy/bqfT27ZIDnfUz82QVPHpNgW?=
 =?us-ascii?Q?JaIxyzRuDwOijq8OU5GmOM7FAFrq86FiPujKUrBPAjnwrE5lTrKTh9c+1aZc?=
 =?us-ascii?Q?s2PmFIDG2RLpOtFtR8lESR15etmPZUzruRLwnOHBC5l51hRNILvf6hLEea+2?=
 =?us-ascii?Q?gaXgg44sPDe5uDM4MLs/9CD4JhfsaMI7IAQ7KQPQ1QqgIq9VxYvN5Tj17dhp?=
 =?us-ascii?Q?w8Bdq93reS50t6ds6t4n4eh6ab8hIdFHaFc8mPFi3HzPt+usmPBYsFzu06d+?=
 =?us-ascii?Q?5gcH5BbqYZIRsmm3QHbF2gmbqLEfucwuygP92MLMKrjnqtUXiUpFEJXxZ2sK?=
 =?us-ascii?Q?jUMsxBG2+Mcg1bSATJgHoAm7UhF8DK1bHZJPx8UpiWk8d+5MlcDg1hEbWdSs?=
 =?us-ascii?Q?iqX44NQmAQVBOBxeoGD2mFgTWmgBj6jTtHd3xj+/mpIXJstIOqa6n+12eLsE?=
 =?us-ascii?Q?Gd5MoqOytwX7I4tl4L7fvsJyKq7GjQ5jCW7qWASw2PnXzM+6lItpEo2VHR3n?=
 =?us-ascii?Q?OHG6M28dpLBVGHeCEZG21MAiABsWZIwQa4+HJTAwoH77mQNXLXfObVYNrsCc?=
 =?us-ascii?Q?3y9sOPC/A8vUk6xvS3NmJqKJZ1z48xSFSXR6jtePB063deCQRN4JnUi1LH2n?=
 =?us-ascii?Q?EVs3X7X+03GksDIqfPdvm0qBcLtNSjZjod1Bqp6GVX5CSUw/oxpPzrkwFLsE?=
 =?us-ascii?Q?+MTXGuZz6VCCKMrq4plJjKvCQE3gmDA8rfJw+uiaswnqMUBOdTm3YmrUX7ZK?=
 =?us-ascii?Q?VZktrsgB+5MpGNXOsk+96BettMbBddMAqJeubju4C7v3mDuaCHfH7H0rObF0?=
 =?us-ascii?Q?PjObofXrDs9vsfezQGpvBcmBURhepBYERNCkxeCirS58EZ8+q/tj+bNmrXn6?=
 =?us-ascii?Q?JI2vjmdTSuJVYcf/DYPXoG55TYq0b/zPFzSE1K7+JyR4UJklH2K/7HSOFZ6X?=
 =?us-ascii?Q?4eIlc0Nz/GAGUEFwRh6AtN+381RzNyDrgsRVqRlWs1hlWtxWWiTGQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 54mASOO+252sI26KZAhaMXa1s0nc8D1ZsniUrTQGdKMGesH0bDlvOrSrA0ef4xpShu6mSUOoGAh29OeLB+c0pkoA4mqwc4RT9m6OMeku/bL3/RQNf0omYTlCXZDMWRSIfZ9sTe2ntWH4cHmtWqpch2E1ANVYUZEhtE7mlsujJtCVF11q4WvwSCsBpLbPXmyFgZowUn78Eh/0YAqxABrAlDNQviMUtX0tpOi/K6rM/64imDnC/tiWS7XBAbjIUK7UH4LCmkRe6oT8P3mDdVa2DiRU91nTiUgShEg1lRSU8IRVO8V4ArowjPREISBq7VJWXQ/oVJJ3vbzCrLbunjBnPN3eo/Hkkvh8vy06NlZrGrA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:tkRWRy48MJHRuwaFZBgGhDOxrgHVsPNV9Pel+sUrnEjpdu4WV2gxOcCpUM60cjtOxCkLxFDrE8IMO3z93zjMAfVYH17qOaCieYp2YM/C2ZXVAho63+Qy68TfZTjG/KRHrEGhlt0b6o9me/YAK7BATsW6SiR61L9HnaLcb8mdrAiyqkByPETzjs2MFtADffBeFimnUGzCXbFxlBwIcTBQyd5ZfHvAOSWs970CyJsgzso508QGd1wLO2fMKYk4WXb8s96Fc6Of5mXLCeP+2buJk+2f4TCDDLytzfsdPX0hTpV+NwdEQrB5WcJAoVG/kQXggHzXI2oeOi9evCCvmW+k+XIgsqvrjCOhGUujUEZ3B2ZrAMoT6Sf0xD37RKEetLBMPgi3h2BUMNElFO9UcMvQzJNtHu8dgiBIVDKTLzXVMvBbiQO+gPLC2uxDacejzbXuuwtKoToutQuDskDFB6rvsg==;5:HuXSZjOBmgOD1Ldp9ibNS7VmIwkb+gm2Ws4yldoFFgYvsOjnJVUrTSYk1zqR6ogIRsRv69xvV/+y7fXT08BMjfXaQVncjm//Upzn7FLTckF1wAhzmf5UMIARvjOqieOlX94Sl2utK4//9jqtAvwfnADqfYlqpJsaLowr2JJEt6A=;7:0mpMEANkwuzCYr4Gysz+NnCWg1XkkSQNuI6I50uTgEEbX4fXKeKZOgkXc+ZJYiMYWvNgOCqhdKB4DgL4X+4vXhbDsiVckcKlHpBeou3rpWaFvUlt98GqMHcl+C43nDPMYhbTgYK0b+33deTtCRCWdnhZyoXFmFjii45brV4fU5aZah6GpYi5ZPRvnGP/ahSk7dz+gNpnk5etRs0hBNMb1fRkgqNwDUcfXJ12fd1fmGMJBpwbC9emySmD3vjYTVYa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 09:45:28.6533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41066a21-8e42-4dc7-6677-08d5f0810806
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro SDMA_BD_MAX_CNT to replace '0xffff'.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3b622d6..e3d5e73 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -185,6 +185,7 @@
  * Mode/Count of data node descriptors - IPCv2
  */
 struct sdma_mode_count {
+#define SDMA_BD_MAX_CNT	0xffff
 	u32 count   : 16; /* size of the buffer pointed by this BD */
 	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
 	u32 command :  8; /* command mostly used for channel 0 */
@@ -1344,9 +1345,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		count = sg_dma_len(sg);
 
-		if (count > 0xffff) {
+		if (count > SDMA_BD_MAX_CNT) {
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
-					channel, count, 0xffff);
+					channel, count, SDMA_BD_MAX_CNT);
 			goto err_bd_out;
 		}
 
@@ -1421,9 +1422,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 
-	if (period_len > 0xffff) {
+	if (period_len > SDMA_BD_MAX_CNT) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-				channel, period_len, 0xffff);
+				channel, period_len, SDMA_BD_MAX_CNT);
 		goto err_bd_out;
 	}
 
@@ -1970,7 +1971,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
-	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
+	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
 
-- 
2.7.4

