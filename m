Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B61C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8039624641
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kig1RURn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8039624641
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeFVRCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:35 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:58464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754598AbeFVRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g1hW3jx51Yn18BbVs1Iq0mtW7ruC8dEvNf6TYmoR/w=;
 b=Kig1RURnqtqMuJKwciud7//dlRs3h7//b77ZRuDCDuAnBsH40bm1CVX7r1rkq1b6rNqJelJHG2gmZh2aQVQtH//ZW0RQRzAGQ2Wfv4gTAiHc353p3YFIfQD16UvQFx/zMGMYAh+BZTcocCp4D6jnCRhXdhciS7JGvbMq45zrxuM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 CY1PR12MB0133.namprd12.prod.outlook.com (2a01:111:e400:50f7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 22 Jun
 2018 17:02:24 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/3] iommu/amd: Add support for higher 64-bit IOMMU Control Register
Date:   Fri, 22 Jun 2018 12:02:06 -0500
Message-Id: <1529686927-7665-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:805::19) To CY1PR12MB0133.namprd12.prod.outlook.com
 (2a01:111:e400:50f7::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7041a69b-4342-444b-076d-08d5d861ed49
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0133;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;3:h4rUJHV8vTpOW2JXqcuBC9gOicYAI2cj7OSnpGSN3G7CDX4qVcO5B2RiU+0VSRVXTc/AXMs9yo6Qz4G7RU5AQoH0THpW6ajUiNbrlpNNgLauyJZmcEgEEjqq0Op83skX+4UcFVhFRvo3xYGgDlwNDnog/usYruC4HOUbKz89CKYkCo83zKHzqTIKpKnEzJywzFtOIEik0rSGC+5U37tIGHNzOy7VYdWr6qbe1e6J4inyWD1qYWMASD5zxjg+fJM5;25:b1sr5+bqlaUnq0fxDNUVwxu+63MCZEhup74+hEvi1t09alxIlLZKCpLJwRwuqUY28vUIcjLQSBrSQr3ScoJdjks/xB4U3S2JTCzP2Mw6wSQXrRzi/NZJzRsq0VCFdkjfFKafxnX+cCnzfxanIfv+NysAg14x/ZXkKhinlwiLQ8rr6kS9uw55Tx0bHC+TgQF+6MfsZboPxFCrynSiYfs3/6VH+yVUaXAIEkmeeI1kgpcGX6PL/Gg41/AIRMk8T9DcEwEvNQ/UMXauafe2ZN+3vQQkjvvq7JRVX2bXDOO+qxSzPobc+0N5NpU+okd1QhRyq1vC8ENgZouWXsL6z+024A==;31:V6p2+8tj09vLS4H+D/nqVLffjnOydo29OsGohy0AutqU0AWG3dfB/kP1T7LaSBQp6e5PcXriT1YgiqRc/hVhCOKzX1Pp/h1FZTjBqObVXvKbHHOyZF6EvaU0PISygQHbpXZFBCWKQzX8tU6twUmMjXVvRSSvQS2alzHvdokMJm6e6OTU6QDxbHmADz5uLBHRXES1H2NO0l6sX1aXwDVca325xZJCBSyG5fBirBedkBU=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0133:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;20:csS1BteMUL1nD2i/EDq4Bu8Flgl6EMFGYFoTxT8q1K4rwtW1nc74W773bGlcgBaFy3Bs63OCzClLeaf4QEEA3Jci3C7p/KfEsucE6TbBwvIQXjYd9tSjijqlJWAQFdh61T6zzd6Gz862s7HIISZ3MSUoauD4LTqJnbBOvQ9VcWBZTU5pE7Wu3sLp1t98aTMzCuSIwYeEhZEglgIsnpFBea/2JnMiE1rrf1tEk9y07cpLcX5bEOttW9Xw+xoi7FGsCrfmIaRYi/hl5+vPrhAj3A5q+2DWyF2xXh+qsiYTRL+sqJcuWlvyWL37z9HEAkuSsZYgNSQzbqoBungv7B9WjKRwoQwq5BlCljZX5hXKmbJT235gSEfaUbX2jZyvP0nzlptq1iZmhJygMEdKCirQdEtBYeG6ot53aPqioLaQTRVCjlpTSxZ7WaS4DpD2996MyERoEvzEECFq+6DMnscDTAm9u94tx9/Tg1iOuurVMcDkcX5NlCvmzqn551a7rtwG;4:/W/gxu/JB20dquRJv7oqPnB7wwYOHAMkyHJC1LfalMHFbQDQ7gVy7Ebi6ODe0k1BC0qbXLxtfBw1N3pOnnYDTHUiiismOGv/54H9/yCtTQ66pJ6gGVTN454Tz8IboSsY88w1fCHk58SDAdWm6fHdntUsxr3RXaIX8eGcjHWMivYfyCcnuojTonowTTsJoN4GK6bDBshkYFCl9YMpaX091bFi+MimdaExcflUqzGgz1MtgYd4xWxcOgKIImf8Wf/D+VJ2gp/QNmyV1nkXKc6XVb3qp7AHjIFD168i1decDc2bYOJMTSaaf0X00osrnKmG6O5pdBvNvToGvMhJk6rACg==
X-Microsoft-Antispam-PRVS: <CY1PR12MB013345C099E88BE56435C932F3750@CY1PR12MB0133.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0133;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(50466002)(7696005)(4326008)(186003)(52116002)(26005)(16526019)(47776003)(53936002)(6666003)(25786009)(386003)(5660300001)(6116002)(66066001)(76176011)(478600001)(48376002)(3846002)(72206003)(51416003)(956004)(11346002)(476003)(44832011)(2616005)(486006)(106356001)(81156014)(81166006)(16586007)(6486002)(446003)(50226002)(8936002)(86362001)(316002)(68736007)(36756003)(97736004)(53416004)(7736002)(305945005)(105586002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0133;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0133;23:ZPXbY2Pjz78l/uCx/1HQznhFcQJTDNsoQWaa1IGj1?=
 =?us-ascii?Q?3NcGNbG7HgH9OpXp7dnWm+leT9lnvieQrJdX3C4MlD70buzhHMdAkKSzqhkZ?=
 =?us-ascii?Q?TTFYfNaUO+1uPrcW32huYfsboL2aTpDN46pFHewvmM0XjaBJsNBS8qFSWUr+?=
 =?us-ascii?Q?DlBeoZhgyn2XmB6bVJr9SDANLrvQD9wzmgEe6ktT7Ub7X9GQoCEDIzM9cBAT?=
 =?us-ascii?Q?Y7aAHVPUhFnaUSw80wv46sKcfgiIQMCLi1lXSVEEX2PPZ35x9jLHvL7YSLDM?=
 =?us-ascii?Q?xRHWevkZyUzwGlXcFh5SSjXAHpxdmA8nSHGwDQoid+yMxYv//DqHKjXoRUb9?=
 =?us-ascii?Q?7y8qFeP47Wj3X97S5d2KS2XREDpH7HqnMOAuIlWfK3UkvlPsos0JWDtI+bYB?=
 =?us-ascii?Q?Ueru8szFrjo2bxQxIhrNYn9Wif+q7sIgvJ2MqwRHJRVKEO0UTD7oagMxrLDT?=
 =?us-ascii?Q?4UJ0gOwNQLC2DezlUUjst8O5Ipp930CSVd+oO38f2wlYpZ1AeRJF85Yze2nx?=
 =?us-ascii?Q?qMOSZc4iRZzScMWTcoNprOQJ4aRJbs/wabW1nBX7EepRK0B6cH6OITMcEytx?=
 =?us-ascii?Q?gfE1H+2XPpwcKIjkkqDfp0MYwtFHWn0nPDBAkaewUyE73hgbS2/CRIi1sa1f?=
 =?us-ascii?Q?KClh4Cm2A0WSH3MhKrDkvZjLeD5EWw2ZvSE0K0EZ7C9r6V6vj8BrauXPyMy9?=
 =?us-ascii?Q?TOVPPj4UpukCql7KrQDpKLZrif3Ausuxezs1+w/6CxFbL9bf2FVfk909t2ZA?=
 =?us-ascii?Q?HyxImRYGJymXXzZVVVRiOJsuHGVYqfskSzYbLVuVHggIKZHfST+sPWo4Pnak?=
 =?us-ascii?Q?bBc/sS159onemIaU/8SigODhcKAZ2ogYLj2JFeY71pb+XoH5+PjIL6AvEWPK?=
 =?us-ascii?Q?t9iXX8CMc9BNAW8IKPBmOPmRq4CGBWsz8XpMWHn6FOUAD2EsjYcHmk+awnR5?=
 =?us-ascii?Q?JEfE7IJD0y4/u05ZTt05XsmgJFe+i6uQN95ZKUY5ziRPQHkYjlFKakn2LdpZ?=
 =?us-ascii?Q?irgzslP+BhzqyEy1HsH2W2qHbBSTK5t+vOaXHj/HO50S0fTii1eQkOhpCs4F?=
 =?us-ascii?Q?/Ts9sRfcZ8rgkeXxOQ+MdEqfGx+a137CTz2QOMPLb+r+oSYIOysF1w4ypq1o?=
 =?us-ascii?Q?auAQU4XVHs99FOSC7ypaK4W1OJ46pHJry4Y/ZVRxIhkx6sjJ1slm+PT2zo4d?=
 =?us-ascii?Q?miE/KgUVfGt6xJUnVdSEC8S0LmumQFXVOo6?=
X-Microsoft-Antispam-Message-Info: Z836bVjjp2OunOdfpk5pKYnhUne8yZU9a38dFhvLgAEfvC6fgVgVKov+r3pkqpn3dp3HPM8UwAjaQU0JT2RjYQ54nTDOA9HfSuqpHiUe3VXNKBPd3xIV4s+sPZo5Tf/Jql1DMGTynSfUDD6U/6jDPIUwCI9XCOJuN4ZHqP3sqtGD4ndoc0D2s8DOmtzX09xflD22p9sS0OxcCLeuw0+2SeyNX0TnSl/AeZ6gmAD0P1Hy3BZbX5zog9zhGvS00i/wZaUIyyZbgFQlB1J8c8IkSBadQJ3fRqNxLp8jHKcIUsDEsY0y8SQMEnedvV3xweKlVUGye1v4YbNLU6ehAKbSfdIlum9BqIme2vDIya5JJQw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;6:F/6sjuFdbD1kWBBvzYAM+MK1aypmnpYsU5B0SbJ2XojCFFNQ9vvCmb+ra4Uiz2ZDTkB88EQMLaUce/u3DWY+uxS5Gs5UPvcgbzf6XebaUuqjk9fQK+B7RajrVaRCwmAcv5hqnkKT/GibuxlXzT3skSvm86kwmfchJY4yIwczyCsoJ7lGX0CXmltEJeW/mLjzbZfPCkl0As3hIb+aGDR53ZIdYhEnFdJitSNnwgw14HMgLCiSWm1ztJpXGSCx+ubiRXhCzU/f0jzaDuGHL6v9vo/Lb+IfB+45CCERJMlEjbn4r13sVN2EuPcfIPN+2/XUTTkItZvqVYPY3RZ7zCIZkhD/jBYB6hALPoCzlPXkJQEdGyayhB0ZyWaMJ377kwTyCNwKofJmpbZyjZmVZgLpn883Mo1FNoQ49sq6zZI7MMk3LpOCzuoaB2hsRnl3TWrCcZR6Ajlc903nvSjQGKj+Yw==;5:NaTw0Jf5zkN8vBExWd2lr4sdyiREEBS+ZGT36RLWDvY+4aBmyvwVM3orfTHdHCCiAmPFHh99Lt/7V658HTp+DYq25OlPfAhE0o1CDLBnFJjU0f82ExGc6qbE28wwZL6KyR+D2LNJVrbS/kxo5JVxU3Yg2yewapuxzf4BAoTMwZA=;24:CFILBlYOlt+OAIG9cL+H4Misl0uovtLTASJqKBAC2YnH3CbH9tZRs0AJtrD8M2vgYHAX4XxqDRBmGbDYovQtpa4WGxOyBsRvFZSpKDLlyOE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;7:nsOu6/WLK1u9MWxwdj8ADgnvrbXlkxxixSwa1BQu2xpzhMIf6xRab0ULWQr1vT9nUp4ZBMgIkBlqBctREsaO8sdflKs5+aZNCcELvC6Y4NWiu/BvMR7T1VWSgrXW4qUabcx+QovTijzUuzLmo8Xjcurjad8U1+LkTEiWbZ5SdHWEb4JqBbcM2S/kfspPR2FA2Ih8qPdWZUXvatcbnqBje73jI8gjqrx55QrWOEd6MJurrSsU8hnptinJpqAxE9/O;20:wABcUKXi1pOi9+FmnYF2Yi1n/ffgCm1wyvjfUtRPAjGBVYoNpJBJfeddKM03JXpAYrBAVJTFT+CqWs2WDnrchOnLn9OY0oOylOxPzCse6n4rX3OLJ9MZyNSgxtW5SNL/A9sa8l1ZaoGZyVCFsGden6mnIv8UpHUhzEabqbVixlvjP9iTBCEIrt+NMFFVv+rJhYvjpTrJm/0DkVYuVoxSLZyRki6yjBgqBH4aG0PZy1cFMHE6FjipT7+dKFiqf/N3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:02:24.2953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7041a69b-4342-444b-076d-08d5d861ed49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0133
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

