Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F529208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Iwfpy05N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F529208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeHVKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:35:10 -0400
Received: from mail-by2nam01on0051.outbound.protection.outlook.com ([104.47.34.51]:58880
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbeHVKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vuS1NhXzm4Tf4phVFuSNdRPoyQgEsOW0WNH33IVNXY=;
 b=Iwfpy05NHJYYJxLf2Z/ZcD54aOa3ATX4D/r6VbRkeLY3GBuxscnEZyVxUNAvcJqFWCLEfVCQNBul0BofE0fy0bYorXDYlaACZmaH0g5qLxrvOMyb/ufiekek9zXwGNhRNYcw7Bi9Ib32b2X9QQ4OEU73Qrp2tkd9xMvwE/C/QVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1400.caveonetworks.com (115.113.156.2) by
 SN6PR07MB4621.namprd07.prod.outlook.com (2603:10b6:805:3a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Wed, 22 Aug 2018 07:11:28 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH 1/1] crypto: cavium/nitrox - fix for command corruption in queue full case with backlog submissions.
Date:   Wed, 22 Aug 2018 12:40:52 +0530
Message-Id: <1534921852-20954-1-git-send-email-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: MAXPR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::13) To SN6PR07MB4621.namprd07.prod.outlook.com
 (2603:10b6:805:3a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625d6870-5590-40c7-16a7-08d607fe7c1e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4621;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4621;3:Q2lYKTTCkiRKtzBndIaBHpSdiGgW5eL6S71Tr0zGRq9xzh7K3OaFXeMJDwVfafHFbEH5iQ10LqBobi3p6AbIOunGc2YM7RL1Le6ZDquzpzZ7ZkhH1eFWjzWvUrr7nbwpVAMBjOHyinWGSZKo4yOLJ6AzBu+bQCAGra8JgC6S1sDtu5Qrp9pGN2t3ldTeXaCZBaEu1NdKX72iIC5MvuCAjosDzIrtUYXbruqCMfLQyGScN1eB5mkwCkR0MYrtA4C3;25:K1O+V0GgKFAl0TrRDBprhk2FZCrqe6MVb74FThpd4LzX0egYbMP/u13tV5KJUBr89UzlX5uZX86Tkyo2TeGN9Q7RvDXTImmkaSJSyH1SBvRskvJYDL6cLOHyy2cNo66BxZY0VYy5iATez31rGLEHkZiK0eHbbl0ozS5pyIebW/rvZxjTbmyEBhbe8Aa7NNytynUUqS8ZaKC406ffGkBzSZtJFJPsJOI+2wpsIFDOSilWUOzfLcbod3fVMM/LXqr1hQ9y8AI2E2XY8gDv6G2r+hhaypC2X85IRdloaK4RONdiSDaLuiCdHr0G7d1rVc6ubeyUbeyyPeamlbayKc+SoA==;31:Fg4zzzsRIirRlsi1iohJa1iZ7Rn2IL/st5cNcfieK0Xtps4uSqBe1WxaOqJTGCk+JRpAPKaypLWhfLuitEayW1NmQlsG5dDodQIUzCvc3h6zBShfSr1dt94ILnx7y0jmY03Iul6YQX5HMUzbnB0kiOvlGv0Or6g35oOjsf/hHRcESgn6svy58xxf4tgwb1rB69TCTk4S/7bIsE1jFKutKDxzzyZaxnQ461nzR1Nil5k=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4621:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4621;20:o5rcSSw64q4rALpV/02M7hkElLzaHZSEbpcBlOlBI2yDKASZow9h3q6POd0AxkOsvBWRTFxjijnG/rdG+QUqB9YzsfwqNfaDaJs/XRPSdRRg41BK4BOqkcrPa8qBaCzgS4bg9YOE84SxPZ49sVRgY84afAOzQzrzqQtQ5MSCQJ99mlL3RNAOXBpJr7Daf1RVP6wY2lK5sLPEc2wCap0IBAwDcT8eCfhZsrZgLMe74qBBO2rY9DkMtw4+D5hwctQo2BExBrBlqlgLCwNIg0KIqsRqfnXoI9doNxA/K6z+cou8+FXXPxZX7BB0sxYjyL02qBzpdaYpEvMmj+4iVcpY+kPxEGTNcR2oHzjpuLDADis13tdUFVs/DLYYnEG0FVH2aaahawhtQKiq32EAkqILRIn4Qj0JHby1PrbEDVJhFU8BWTJ8gDiQle/IdeYFOptuGTmEJ/0kynJJGW3Rbo4UUj36L58MUMSjsrtJXBimanNIJ00t7N7pceoOBuQoZxe5;4:0TBGItm88K5bTKQaRnPyxjGFIRpb6E2miFUt5TWwM7dnM//CWRLce2FxZnndQE6lls1Zgxge7pI5A/+g6KbLrBT7jkLRrv6DuApF8zvE4SdTL8QrrSwEto7r4eW386jiLf86mRvziegiagaHW82VekpknrKOf1f8GHXjQxZDLCDLwiT0A1gbdn6Es0KLouCmO5cISh1DbcFFteA4JCmkReYt9ggt5rVoXc9XpL2osR1I7Ut3dcO74/P+ORpmFXYzmetqsTVkbuTHvoyjIfMGQQ==
X-Microsoft-Antispam-PRVS: <SN6PR07MB46216C7075F2CAA6A8C40BADF4300@SN6PR07MB4621.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR07MB4621;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4621;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(68736007)(105586002)(2906002)(50466002)(66066001)(2616005)(956004)(476003)(86362001)(8676002)(36756003)(25786009)(486006)(4720700003)(106356001)(6666003)(81156014)(81166006)(53416004)(305945005)(48376002)(51416003)(386003)(14444005)(5660300001)(7736002)(52116002)(478600001)(8936002)(6506007)(186003)(50226002)(97736004)(72206003)(69596002)(53936002)(26005)(3846002)(16526019)(316002)(6486002)(6116002)(47776003)(107886003)(4326008)(16586007)(55236004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4621;H:hyd1400.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4621;23:TCfU+R0gbNU2or0AiOHgPjQa91JkLI9Dv5onkxX/5?=
 =?us-ascii?Q?t9SYwvhF6TfWp0glTBA68qCRy8M19jn/7UZqC6RWnVNd52yda+2mrCMwCDiZ?=
 =?us-ascii?Q?iPIWos6ITdHyWHeOiR/E4lUaw12GGlYcRBZFKA+IGX6ZJSq2SUDer/CbDF/G?=
 =?us-ascii?Q?D5BSKUaMpYuL3Pz+3XMnXtlHaphtHGV2zxNwdWQQMbM8gGNIQ/TvdlVfsLEY?=
 =?us-ascii?Q?FyZZnaPwnWl/9J8myD36j0STqnIRIZIMY76SlvEuD+daw4Y2xQhIY9Fy8k3k?=
 =?us-ascii?Q?XGXK3uQ54sLarBtMbb3iO+05719QccXmUJAaU/hgItri+3XyaT+7hOz3rX3I?=
 =?us-ascii?Q?7R9NjxPA5TX8vtbfgPpltyttAnqbRMgJWi06MxMGFfue7NcAwCDwOSjnA4d+?=
 =?us-ascii?Q?Lxv6Pe8LCKSc3YwN9v0CGFbjyJ50ph2UVrmJ656bcps89+RAFzxD+jFakRZl?=
 =?us-ascii?Q?U0wDx18gmbqVzf4XM5jI4c6JoIkD8edJ66ywNxPxBSI6nk4uQ2fIbiwl+Kct?=
 =?us-ascii?Q?GePPtx3cnaj3iYZtCR1gYEBXF0EcjZ0vTPVQ04ywTALtbCvlurXy1vpMHBSz?=
 =?us-ascii?Q?rLUedttCFxdYBVj3LHLm6/E0b9ZnpfaCUv1+rtw4Dzkt/gzM7nD9j/d/b++Y?=
 =?us-ascii?Q?9Zpse2Ac6HLUWCvrYCgAnsbGaxzoExuih2P70uD/DCMe3V4HqZq/VBinqaSZ?=
 =?us-ascii?Q?fkQj2z+/kkJeKGd+7+nwYdNa3yNRQoD1ZtoXuEi2rRQOfecyXi6F3hwWeX/G?=
 =?us-ascii?Q?96J0o2fp/obKvjSXPP/lp8spCuWCCGTURI/tYq6QjLTGHlZ6+zaLvwIBHTgR?=
 =?us-ascii?Q?YDqyZpiBM3cvzj4jFFXgE+ZxK78cuKJzHI76MhpiiJ1UlYO3oMX/iQ0F03Ux?=
 =?us-ascii?Q?JAoFKKFp2t4i7k2XuoiOLH5J5kG+CnqJBNjkSiDVr/3oLB1lMgupnOnWZ+AO?=
 =?us-ascii?Q?oVA9gtW08isA7nDNOsjtJ3R2sjoV+hsbrXelb6/vcpVj5o2IBiAgSigxMjJ6?=
 =?us-ascii?Q?SMNq2xWlZ5VMtO4OTQ7JR7od5y+9w8B40bUrINcbuXN7kg/+NtNSvQPjmGa5?=
 =?us-ascii?Q?zlDRenEwgcPwwATYbgb4IMrVX3ucvllHYnFvfao5dFFxZ2fcXGQ8brvFiFqo?=
 =?us-ascii?Q?I5ybRRrmG4yLJ1EokA2k2oF8uaHMbzHvUCL7OpbVx1Dl5yvcmDmZuar22VGF?=
 =?us-ascii?Q?P7Ji7AKE/vDJgpdf1mZRhgibuuGxNnwANiuSiLYACReODJStIvpPu3x4SHoZ?=
 =?us-ascii?Q?QJkpL6KlVMCH77JKwk=3D?=
X-Microsoft-Antispam-Message-Info: tDC6YRZl2wyguLTP2PUexNxe5ov3Ju5y7XVBNEP+NbvLhtM9eqhxdxlc0becCAf5t04FevDBwd6kinD4myVNiPejh15LOOejAWwYqAQLU+eWeJ6JIV6OD9YZlclq1UB8qiuxSkEcFrdrP8OwPVv6RvEDg0IQIDDVC5PaQPp02lQNpzhtaSHmS8cYXIfgG71XKQANp+69skhKJRpSaZpaCsK0FqRtoLxEOpr6hT/VZpppHEcrFyhyMgzxTJEUYSoC+z76SbQ52k566LxK4GUiJzsjAidQBAr1ABDBTK2gaye5WuXOUbcZPBjGma3now3iwtziR5nFHUdrKbrKfR5AN0yzO9rHPmGx3JDEGbwaCMc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4621;6:wPfrxx+nZ7BPrOhUaPwdB15MzE8yLvMdx1nFMboWAFcNNQKQr0cGnzlbpI71IVzZLNmfu20hxSf2xui4cH1slQSbI1ZanB64nZk9MyivjOm2MJgAHNyVr0pzzYxXih7fipTHxMi+2638RR2QzLGBeI6bjPZ9s2N0t4FC02Aj2trnIVtvHafY7vmi4tpNSSeLDAhTminDndoTwtYwTXBcyGMY2yEmW2bzmkWa/t8pcAE4tF0XGl8YQkH/qmOTBjFaXVfSqWIR5Pc3sPG2CFJ3Z1/wz2CQgFdJJb+jolQranE/uKDT0LELUyXFvPYbdJGhkSnXmFeUr6nt1kwn1e/ZUiTa3MA+IUlSqgpMREAdtY0dRp9dwApY9yzORZPSttLVP1TU6sUR8/VcfRrLi5JwlLVEXopwzBfEVhaaFgjYMd3c8UWbYKpKXB1P8ZvcgsSW+nDXox0tLwgQlU9wWYCfdA==;5:NGcMZlr5geTySUqtXOx0fjIRcEjojssbk/+Oca9ULXGoGN/O8xUka78kCFtfRrRKqXwFUu24Ucd0U5msOxapE2YfzMkqT4hR6Tlsik4mLUFNrzQaEnjgd2hrr21XoOfThO+S0rkyjoyEfOHruGSbnOfgA8flV9lIRo5UStAW7l4=;7:OGDrnrx3JzCU/t/av+Z4yqHBzRN5XYO0e38T4eV7YEdCCoZ8dEXs7sKADAOACKvEefT8mE/G2R1/LyO5SBNtfdnpbhvv06KDR+L5OT3VEkzpfkl1xUERTNGTVRjgl7Dk+4/wQxVmfASWeDZPLsCBmV2AFGiY0gzV0eRw8ODcAVaXvSAOGlNCRWSyM+/xFq1cnNLwLBw0282scb2x4hiCrg4799/XF/KIIR3ih1UVoNFXOwEVb5OuhsgEZ0+u8YEK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 07:11:28.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d6870-5590-40c7-16a7-08d607fe7c1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     Earlier used to post the current command without checking queue full
     after backlog submissions. So, post the current command only after
     confirming the space in queue after backlog submissions.

     Maintain host write index instead of reading device registers
     to get the next free slot to post the command.

     Return -ENOSPC in queue full case.

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
Reviewed-by: Gadam Sreerama <sgadam@cavium.com>
Tested-by: Jha, Chandan <Chandan.Jha@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_dev.h    |  3 +-
 drivers/crypto/cavium/nitrox/nitrox_lib.c    |  1 +
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 57 ++++++++++++++++------------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_dev.h b/drivers/crypto/cavium/nitrox/nitrox_dev.h
index 9a476bb6d4c7..af596455b420 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_dev.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_dev.h
@@ -35,6 +35,7 @@ struct nitrox_cmdq {
 	/* requests in backlog queues */
 	atomic_t backlog_count;
 
+	int write_idx;
 	/* command size 32B/64B */
 	u8 instr_size;
 	u8 qno;
@@ -87,7 +88,7 @@ struct nitrox_bh {
 	struct bh_data *slc;
 };
 
-/* NITROX-5 driver state */
+/* NITROX-V driver state */
 #define NITROX_UCODE_LOADED	0
 #define NITROX_READY		1
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index ebe267379ac9..4d31df07777f 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -36,6 +36,7 @@ static int cmdq_common_init(struct nitrox_cmdq *cmdq)
 	cmdq->head = PTR_ALIGN(cmdq->head_unaligned, PKT_IN_ALIGN);
 	cmdq->dma = PTR_ALIGN(cmdq->dma_unaligned, PKT_IN_ALIGN);
 	cmdq->qsize = (qsize + PKT_IN_ALIGN);
+	cmdq->write_idx = 0;
 
 	spin_lock_init(&cmdq->response_lock);
 	spin_lock_init(&cmdq->cmdq_lock);
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index deaefd532aaa..4a362fc22f62 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -42,6 +42,16 @@
  *   Invalid flag options in AES-CCM IV.
  */
 
+static inline int incr_index(int index, int count, int max)
+{
+	if ((index + count) >= max)
+		index = index + count - max;
+	else
+		index += count;
+
+	return index;
+}
+
 /**
  * dma_free_sglist - unmap and free the sg lists.
  * @ndev: N5 device
@@ -426,30 +436,29 @@ static void post_se_instr(struct nitrox_softreq *sr,
 			  struct nitrox_cmdq *cmdq)
 {
 	struct nitrox_device *ndev = sr->ndev;
-	union nps_pkt_in_instr_baoff_dbell pkt_in_baoff_dbell;
-	u64 offset;
+	int idx;
 	u8 *ent;
 
 	spin_lock_bh(&cmdq->cmdq_lock);
 
-	/* get the next write offset */
-	offset = NPS_PKT_IN_INSTR_BAOFF_DBELLX(cmdq->qno);
-	pkt_in_baoff_dbell.value = nitrox_read_csr(ndev, offset);
+	idx = cmdq->write_idx;
 	/* copy the instruction */
-	ent = cmdq->head + pkt_in_baoff_dbell.s.aoff;
+	ent = cmdq->head + (idx * cmdq->instr_size);
 	memcpy(ent, &sr->instr, cmdq->instr_size);
-	/* flush the command queue updates */
-	dma_wmb();
 
-	sr->tstamp = jiffies;
 	atomic_set(&sr->status, REQ_POSTED);
 	response_list_add(sr, cmdq);
+	sr->tstamp = jiffies;
+	/* flush the command queue updates */
+	dma_wmb();
 
 	/* Ring doorbell with count 1 */
 	writeq(1, cmdq->dbell_csr_addr);
 	/* orders the doorbell rings */
 	mmiowb();
 
+	cmdq->write_idx = incr_index(idx, 1, ndev->qlen);
+
 	spin_unlock_bh(&cmdq->cmdq_lock);
 }
 
@@ -459,6 +468,9 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 	struct nitrox_softreq *sr, *tmp;
 	int ret = 0;
 
+	if (!atomic_read(&cmdq->backlog_count))
+		return 0;
+
 	spin_lock_bh(&cmdq->backlog_lock);
 
 	list_for_each_entry_safe(sr, tmp, &cmdq->backlog_head, backlog) {
@@ -466,7 +478,7 @@ static int post_backlog_cmds(struct nitrox_cmdq *cmdq)
 
 		/* submit until space available */
 		if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
-			ret = -EBUSY;
+			ret = -ENOSPC;
 			break;
 		}
 		/* delete from backlog list */
@@ -491,23 +503,20 @@ static int nitrox_enqueue_request(struct nitrox_softreq *sr)
 {
 	struct nitrox_cmdq *cmdq = sr->cmdq;
 	struct nitrox_device *ndev = sr->ndev;
-	int ret = -EBUSY;
+
+	/* try to post backlog requests */
+	post_backlog_cmds(cmdq);
 
 	if (unlikely(cmdq_full(cmdq, ndev->qlen))) {
 		if (!(sr->flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
-			return -EAGAIN;
-
+			return -ENOSPC;
+		/* add to backlog list */
 		backlog_list_add(sr, cmdq);
-	} else {
-		ret = post_backlog_cmds(cmdq);
-		if (ret) {
-			backlog_list_add(sr, cmdq);
-			return ret;
-		}
-		post_se_instr(sr, cmdq);
-		ret = -EINPROGRESS;
+		return -EBUSY;
 	}
-	return ret;
+	post_se_instr(sr, cmdq);
+
+	return -EINPROGRESS;
 }
 
 /**
@@ -624,11 +633,9 @@ int nitrox_process_se_request(struct nitrox_device *ndev,
 	 */
 	sr->instr.fdata[0] = *((u64 *)&req->gph);
 	sr->instr.fdata[1] = 0;
-	/* flush the soft_req changes before posting the cmd */
-	wmb();
 
 	ret = nitrox_enqueue_request(sr);
-	if (ret == -EAGAIN)
+	if (ret == -ENOSPC)
 		goto send_fail;
 
 	return ret;
-- 
2.14.2

