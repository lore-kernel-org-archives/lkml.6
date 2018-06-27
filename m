Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12726C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B127E25DE4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kDQAKxkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127E25DE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965637AbeF0Pcr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:32:47 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:37431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753314AbeF0Pbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g1hW3jx51Yn18BbVs1Iq0mtW7ruC8dEvNf6TYmoR/w=;
 b=kDQAKxkKzak/20XQIh5i8KWm7cWs6T2lXhVZDctDNEk3j+hvOs9inRTCcfaiW875sJV50/BeVBhzDwGuTVtGXrOxZ1p/GpRjA2XFR0poXN0wPNojxx+KIp50HN3r/dd4TioDElA0mHE0PYH2BkFoKV9RIb2cH2Nubzg+/3/hvFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.20; Wed, 27 Jun
 2018 15:31:42 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/3] iommu/amd: Add support for higher 64-bit IOMMU Control Register
Date:   Wed, 27 Jun 2018 10:31:21 -0500
Message-Id: <1530113482-85632-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR0102CA0002.prod.exchangelabs.com (2603:10b6:805:1::15)
 To DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad78591b-3ea1-4ac1-11f1-08d5dc4315a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:V8Nwp5TK2ZimqStTFHgC2mWCrzfxALlXCPKERf+QAaa81w0IsoH9I2erSG8VdA+r5rrxCIe65t7z9DxoHBb6e2DiOTfj40QFMSTkwc3wkkX7kpdZo8wEl1+b5iClVV1G9qznlUaILxyhUn/qhZCFegl8ae5kiDoV/3szmsLK4QqM+jUN2YbLNxUtWB+8fJP3OEXYh+kibesM9j0IwL+YSHOuCh6vUa6BpCFbm/IS5LW55ZSGJ3uftb/iOe8lwa/F;25:LwurRLUAg0r+1RRYKHXX624T+Xq1ejuPy5/Y988UCWQ6nEjRL8e+AMqxr6cGmunu5y3AwZn0vGS1LwkAgxBBGBx8Qe0jjKnAnD/puDDKMBg3oWanBCnV5n1Dp+WXx7dL+717Ig3w2adwq+O0jnwgb/fEl8VyQsZjyc1cT+SVKa21vziONtfYgX7EHaH9q6icKZqADxVQPDQs0visbdbhRWXYL720PNC1DG/ebcOgJ7MSE0GqOJp7oq6qIzRiIPzQP/nb7TlvrG92o1BPpOK/NlA7CpckIqdNmt+OciWcqSrHoivD+tAoN2vv3n0hvZhIU8BhdbdTyUF/yfmtve1Bjg==;31:s9/rCr5ZlcbwDK08yHrbI03SMWJSMbfPnMrraGsbKJ5VOgYw0qPibRr37yX+3urTi6dE6lQwc5y03z4d3MP+9hazIkTr7vjmbiKKbZtP12Y2q02V7pB6HZf5NU33XsQ4qupLN9BBlriAQbnibM7fedr986FcVFrbsW83G+cKxDmfacilmiwCp8VBx4Av38eZ3ZzBBtqk3XvW8y2dgMFkbkKpJqwv18RQAPsqWnMYmYM=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:ziB56nfnvySp8qRdBxA3nnDcBsytenRJ4cXWOila9Mvr3kGcPjfMxBP+7vlQmeNY+rdNhzY7q/+/zOKcYDRDCgG+dz4aYf4lrZd41me5QegcG9KVMmoeKFWzbB1YLmxJhxs+41PLzzRJU/F7YUxFF1/uWaHsj85PQuRQW7iPWWsx7k9UXViXv21n534yeKhJiGq4Hi3yfcgApA+usqrDBo8TqsrxItteVqbN7a+hVNEtWJ6kivzcc1GJ0L5tHYeP8owsnKPJ6Sqh6+gyYjtXtvLQCmt+6hyoR1usRRTVm6OVawjLNt3tZOWLRysWj87td6d+eVbUBEyjpB7EzuCNLQ8msdf9q0ibAAZ0KjhsUTJBUVtFMu4xbFlrPzi48WXlfVybZzjWkApW3tEllxFoUeT7UltbCCfcGVJ7s6FvNlR3O7G+L8Unz3xViNOWn7q1lH3gmXzi9zc7rfrvj4lzymluAj9R5AQwLJCIkI7uW+PYea1EI6N05eUIAedwjwM0;4:ak3PBjCs0DpjLGdfvkZR0LloV8Ts8Necp44MZegRyX3fGv6SUySaI5amEX+FND/3l5Ka1LXdtGAMXACOtgsTHUWkznN4GxsW5aT1olKzii6IXVivkuHxpkV+hSJGxoklRB5cMeonDT11loxpqli5fLRnFBcLRu2JaR8guexO0njL3/Ek/ekB/RvFHjalMlYH6FRPPqVXShoUyiO0FHXptrpGsRncX1fsDBYf5qRE7g3tMoj0gfoD/OdVIVEm4sUaYe9LZxGv87xIYW2O/LZ2ZnfRokEWesvrikSCSxZLg+VYQj6WZTj6h53jsECWCZPthB469EvGLympMPR2OabgFQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01398FD87AB504E43C6F1DC2F3480@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(7736002)(76176011)(16586007)(86362001)(44832011)(72206003)(316002)(5660300001)(97736004)(305945005)(53416004)(478600001)(105586002)(50466002)(106356001)(48376002)(81156014)(6116002)(47776003)(26005)(50226002)(4326008)(486006)(36756003)(8676002)(81166006)(186003)(8936002)(53936002)(446003)(476003)(3846002)(11346002)(68736007)(51416003)(6486002)(16526019)(2616005)(386003)(66066001)(25786009)(956004)(2906002)(7696005)(52116002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:Cc5nU8uecwFaXafhKkhfrhZnFHO/DROMxTvVLR3SL?=
 =?us-ascii?Q?F9/EQrdO/bc29KiljC/KeXwASNvHffDSoMAAoGI3lja219+K7Mou+164q2NT?=
 =?us-ascii?Q?jBEGgi4kaoLlAS5cVWGh18FOIW/aqZRphtCrx4CXJBP2Z7+n7Ch2/1ssXKF2?=
 =?us-ascii?Q?euRb2JUzInSSYcX/HzqOBuDpXnUFTQT3t21g5ngCY9QAFJl3wKk5ezc//WaE?=
 =?us-ascii?Q?WMexSPRPvL59rIhVjCo6RmOUk46mg0ipfx1WpYxGiU3nPQEz+Vs7quhuey0T?=
 =?us-ascii?Q?5xcG20wkjEtOL5m9L2YXYU9a+uNfHFdnz+t1KOMGiuOyxyZ/apViMnboqd48?=
 =?us-ascii?Q?JMeIu8XkO1jEl7eeUToIxrY0j26z2jWktKbsiFxS81KFyrpqYWt2tye3BtWu?=
 =?us-ascii?Q?0Qjake5v9/M7Aa30UoexLpZOEJDVmNlYOyyT8zOMDYNp0ooRakJsDGGndXZi?=
 =?us-ascii?Q?5ZqLRSg9m5gi6aA9T2d22dUdJSMesRPzPTk0lEQ4FZK2Yo411qVJBHCtU+Fp?=
 =?us-ascii?Q?1OsPlQTO7Fi2e00voA1dDbwgMd3MzgVSipfg9bR9z2l+2s/cekFCYEQrmoCH?=
 =?us-ascii?Q?occTH84LmHKQzCZDuP/mlzru/quY9wFvWezTKn5hmE5cvQpKRt+7ghuXElkP?=
 =?us-ascii?Q?8jQKkTHXbKZM+AEApXSg/0O+ts7DKTvxkW7fUjFl4UHlyz0uPmBGqSOIWurc?=
 =?us-ascii?Q?OeuZmQw1UiKvpXt+EMU9DKUUB5FZcyQfNI4d1bxAOZJPJ5AW635yDOXcXrOT?=
 =?us-ascii?Q?l64NaL6TQUIHgqO4UaB6f/JNyoMkU67DUEa3LvCm+qN1yq+Avh+6RD797XBk?=
 =?us-ascii?Q?JRY1gBnWodcqDKPu6owqepb9UvoRvkw2T7xPdevVEoZPzCdS1cYhAuh4ZQkJ?=
 =?us-ascii?Q?vM9OssSS05eUXVw7oNY40IuDHoPNFyLsGzJpYFuJ1erT6BSbtHx3zwXStVjg?=
 =?us-ascii?Q?Ir4LU8T2ffk843ixvN/HPGCao6fNcj9eXa/u/+M4cdW3DprMfiF9pmzRPx7L?=
 =?us-ascii?Q?mx7ghKFpQUyQmsCxA1F5Sork4RfhYQ8KLFSPYyWRfI1MjXNIOq8Ue0fxoORa?=
 =?us-ascii?Q?d7k7kTy7ciO/y00Mc8M7N2M5QqfpDHDcxMKb3S9c+w+LEfhVnRltX3gMhfg/?=
 =?us-ascii?Q?pztKkYSSZmXbJdjXA6x6H8aQfDrDlh5SdePAdMuJCvnivB1pRNq1xwtQP7Kq?=
 =?us-ascii?Q?+OAl9kaz/feOzE=3D?=
X-Microsoft-Antispam-Message-Info: M4st7l3l+uU4CYPyehp9m135FhGXtLhufIwCt/C9S1gFhfRukbvxm+CPrLTSNJBustYQ+KjqO3IJkpp7mIG13oPi03OY2XYDZox7R2nXocnm8UeEuARzPXa5ahmH8UA+0PXIgMlsf+bqg3cPFinMcpICkzVRM01y31X2EQuwvBJyQlsn0yFuR4hyqn13Z+Ls3xEJTAd2bOm/SmGkvmKCturkPRxjDW/LaW2z1wQb5Pb3PPC+fyuDS7F3rFja3Fi4VXX5pBNfJD68igYHMs2PUk7ok+nL2j5XBav+Z/0Ci1zQaCO6bARPdYVp+dcNmrHk3qtJQCbF3m7Q+Wa47w70xpF3+orTljz1UEhiGEScmn0=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:CH9sT4WuGrKfOMhYhjy8JWFqg2JJhQ71n249okyBUPMx/0WyT5oaGM8wtnRU3RYGtdXXC/iRIakSdrGAC4kvVtPBWoWuSa8DPY32gYYL7Ly0hsv4neP1Ro7AkpdlPTbqVecl5+oa413lGO+xs9tGlFrf2L7F18GDsA6a+J+Ja8OJLys9H5D9WPhci1z8PDIs0qMuqiSTKAtfEqnx69U1EISk7enYxQ3dkoD0m/8XaiNibHd7wJlZI5ZWpj9+o7DMz5RWVrSe2XqpSJAhFFUuHe1IG1t/3PFIV8QbQ9vFa7DvpMwXIWGBvq48dhDf8HY5062Sg+24sGhS0w5YDlAaPURG8rxhwOQ4ejrbD7SJBBnMYP2Rcyy3WNakfB/27M/GfotP0htCAgHDBVqPsmKER+pSYE9nX9TscJN8Gm3M3XAKXJ8Wb/TknAmf52wq0GJ+MCBqjYPyZgz6y2SzRP9UQA==;5:KKeEjDAUsOlAzixHwv6SHs7WTFWwmpH+6ZWz5s8dCyQXHyo0HfBuc50SjCtV/zNc5+G5hYOxgW4rUjkjPYIFtejqsQRalHxQHKmDD7jPkicPtejvYjQZSCKvYlENc7/4wJSKCiGpdUvTBCMIIKEr2E7aqtP69CQX6qFgBw1yUWA=;24:oGmzTZ/ln1sUpKv7qzgZ7cJObh70hUXiafoLb6/N+VAFRrbrrkU/EnG/F5iHbGWUIXlPBJa3mZGg3s/SGHUetKmb51Cv+lSMGIPRpdcG/vA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;7:gBdTlftOxEIXLbsUsqhy0iURD5TpghMkF6ZbWPQHk4X7ml6OQjEHbrdFM1krmfSvBE1ufdo2R5ZWfCEmRBfDGytcToyJ5DJf04R5lsivNClYUV1c8D5XqNxMytf0+C7r9SJgbk/vedyw0xQ0zI2aJEDv8llHSt5WKuNFlCsHl9cPChUkOvvo92HRM1I+6l4Qfa2JZN2qKYKe4lKEqsT/1SbbL2yZYwrb/aw9SDblBZDzPTPzpBKpBtxH0Ri/+prh;20:Q+S2gbmC+ECG6Imi3baTobgJK5kntuAuI12gpeJXGdutFweaCp+fVIr5vObslfjoEGpxCr+Bj3Y9CLaiVnM0BKNAoRV0aDImowy7OMXSwoe+SoX4oT0/1Jafesnmde9Rn4rQ+ztwZ8aSIm8Scd1KDwjkXdB7J4RsvKYvns/De8RpLPezk7MWd5cYHcXt4YfX5w7oOMo1OJHh9w2sgEHv6j2I+tPhr1Xt9x4Ecq3+lJ2NtAWWs1J5QE3JSO+jRMEZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 15:31:42.2432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad78591b-3ea1-4ac1-11f1-08d5dc4315a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver only supports lower 32-bit of IOMMU Control register.
However, newer AMD IOMMU specification has extended this register
to 64-bit. Therefore, replace the accessing API with the 64-bit version.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..7d494f2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -280,9 +280,9 @@ static void clear_translation_pre_enabled(struct amd_iommu *iommu)
 
 static void init_translation_status(struct amd_iommu *iommu)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
 	if (ctrl & (1<<CONTROL_IOMMU_EN))
 		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
 }
@@ -386,30 +386,30 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 /* Generic functions to enable/disable certain features of the IOMMU. */
 static void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl |= (1 << bit);
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	ctrl |= (1ULL << bit);
+	writeq(ctrl, iommu->mmio_base +  MMIO_CONTROL_OFFSET);
 }
 
 static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl &= ~(1 << bit);
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl &= ~(1ULL << bit);
+	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
 }
 
 static void iommu_set_inv_tlb_timeout(struct amd_iommu *iommu, int timeout)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
 	ctrl &= ~CTRL_INV_TO_MASK;
 	ctrl |= (timeout << CONTROL_INV_TIMEOUT) & CTRL_INV_TO_MASK;
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
 }
 
 /* Function to enable the hardware */
-- 
2.7.4

