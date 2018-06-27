Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DAE25E3E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hntZbD4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DAE25E3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965623AbeF0Pc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:32:29 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:37431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754632AbeF0Pbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxbgb40604V/Uz8gC7tkLzGI7DwCufNKBCiqEALxwf0=;
 b=hntZbD4KHZHhRYiRjW/7mLK4PmjaNR2Xgjf2BvgzTOonrwykCAKubDfPIdquFsQBBa1Wfh5OM+tYTOxYZV1qFnFYRbmFDrN3Q8yJb9IaO+nBhKe7K/Zf5E5MvAxts8IJAvtBsJPhEp9M8vp3AJLQvB4V9l9uozt/VYY5NcnPyrY=
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
Subject: [PATCH v2 3/3] iommu/amd: Add support for IOMMU XT mode
Date:   Wed, 27 Jun 2018 10:31:22 -0500
Message-Id: <1530113482-85632-4-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR0102CA0002.prod.exchangelabs.com (2603:10b6:805:1::15)
 To DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29784af1-6f43-4188-9a3d-08d5dc431614
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:p0XTModYTHgTSlQatEiZhr2Z/eP6vLsODZIQp+4fUHY5OOm15FUfEQifKIiD+48IExDqyrpCUKnPupD5jKCWa7kDRJtZucAvKvOCszYGn4oEExB6F+tWVIpWrIIKibXp31IA5hMH5JtILE33OMly2FImtnxPIgJreX5Q6viY3gJzKsWChuJZCb6D9sHIQyOUdDDjiOBEZ3O7mcb4thcZBOPXZlRa1xtPSZoRv8nnuxKc26ufxXUICZnV/nIqtb/D;25:NotOznsHSA/e5lvGP++iRUsdw3fjpADb52eOtT/WN7rDwihlG/8IHw7v1e9WZKE4R2/M/pDn7IpOWop53oqjuqTLRgFQWjhn/MCAsRWU9mE+s8MeSvvI0PnijBEOogCkL1pWD4yiP30xllaFczIpK93uAHcfDuEDfa/xKtKPcZaQBDVyjT3+HeOIIunGEAti2iD2juBtCjpUfbz1bqpFXRMTccLl+FhikKFhoZ2I3Jghj702rl/fpopoIUL3Sd4DuZu+vH7/V35ZjNeCmOCDuRMICgqNjkyycqpG5yA3OlP/u/Rqda3UDBC3xT4gmgPgRPxDrSTPE03oUnrSCEQSkw==;31:Jpw07chaI1NMPCQFv5RiNg1bQmelP/zcsc6ZJAl1H1W3etm58QDo/k9m1PUX4cXumI4xfHab+lQCZ0/NZ/fJowbD1N92KvgxsKQ/UTT3pw0l9gRUpJzU0OvB5uP54I+PPfuRp8GAoWY6pQul9jKIr90xnlAPpIR7I9drnk8ZoWpRoY9wtvErpj7giwwa3vHADIeTWR9rUmYRn6ydExHGu+Ar3AwhvYwe3sUK7hgAMTw=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:S+ogavu/CZuvUSt6S40A0SlzIUeEUqxaZhYRBpJLse00JVYndWpwugOhO/FIr5x3lZlPM9mDXpTgMhCbklXDers0QFZZe7wfIVSAY/FL7NNLFM9M9zFfGtnQuIrG7SWYz5W7cAh3i/zP1bYakLjgJr62o6Pau7A3OBo6pu7kyQ4db+hlzQ1aXJT2RXtQAYHH+01zKhSJMW2FH4aQeOld5mdsb4M6LD8K9a/Vy+oXG2anHPF7m4ez/C7zJKMp4gP/Ado+6wFkWBLoKR1Jr5gC2Qs9QMLRCDPNyEwr8gEhOfUCjQ/IqT8FNCI1RF2Qmkq2x74DWKU/zdXiMRdbzM6kZ558LTK+GAOLofC4wO0A46xADjvvJ1LKvqC3H7v7WL35IobFban3pd2/UCRIEyZoFb2/trsNcJSjwQ7ZuZB0PU5zQmdq7K1FDlcroSIWrDMoyR+WBWiXLVcRNbJyKmRAub96syExTDfsUHyFRWpgtN8Nm0zvl4eVOOxrLqtdGAQi;4:T5E5+eSDlUSX/xXisGkaiHETAp2/aseVru7wUaSyofV2nH5tdWe3uUj98PK2L2nes7yoeTrhDzFJrgn591CNfCncLpRyFAYyDLBw3UcggjRtAsoTfTHSginatYdzdbQ7CzEyXOgtfrSTbe+josu2NM9JFGWAnE+0XpoRaoFtoVKs6JiufWISEA/14WE48x+TnKSw74kGEw1eMv2bjb7/LnkiPmrTc/bhTEUPE/MWU0ejCsd1IQP3FhU6wThxjov5MInOBi4RHnfcvRdxv6rqWrptwHiq3Mlh1nkjivMbTTHc/8ThAK6Ls1EVaMKDjvFLPVFc7dYIR/wRuspPjm84RQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB013958801BC919738ABEB5F4F3480@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(7736002)(76176011)(16586007)(86362001)(44832011)(72206003)(316002)(5660300001)(97736004)(305945005)(53416004)(478600001)(105586002)(50466002)(14444005)(106356001)(48376002)(81156014)(6116002)(47776003)(26005)(50226002)(4326008)(486006)(36756003)(8676002)(81166006)(186003)(8936002)(53936002)(446003)(476003)(3846002)(11346002)(68736007)(51416003)(6486002)(16526019)(2616005)(386003)(66066001)(25786009)(956004)(2906002)(7696005)(52116002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:MPT52eu7A2GgUJNcB/kupZv61fjPicOHmpzs+2VlN?=
 =?us-ascii?Q?+Mgz2LT5wX8dnACc6BI3biKPaeYjRwugShaE5LLkIjDffpVmM4kG7ZpcgKpK?=
 =?us-ascii?Q?Lx/xIHJhYIyS1zWZG43iGi2isFBD4jdVTaDKrEa/nycw4JjJlXVeLVXK1eNM?=
 =?us-ascii?Q?ae8b4Z9DGFEi/2olfjf2wgDgt/z5wpetGZ3rkTq3jtKJriUpnGS98M/XgVCt?=
 =?us-ascii?Q?vUZ26+Z8n1p/fjgGAppDk04q/pyQ8wJmAxTkRibv0Rb/4MsNYgW5ehPs+H08?=
 =?us-ascii?Q?B+m4hjmAtIdO0QL7ffHMFiAjdWYAvbN3DFHWzW7YioeLn8zxI0CatX5pjKHr?=
 =?us-ascii?Q?URfiQC8n5niBwMPEFd6xpspCEaZ0HGzMHCU8bOr1dJZW5jRoGzTPc6ScVFmp?=
 =?us-ascii?Q?oI3D/UQaQauWXb4CviF95PcBO6zd86gj8yO+ZxDGKgDEuvOnlTjZ1IXf6MAc?=
 =?us-ascii?Q?HiJZSeXCXsWCeEOvFqdlvL4p+dK0gNgkZY0PhxwMYU1QMp22PHTrgVM2/AfC?=
 =?us-ascii?Q?EbSHy4l3oXBcded5JQqF+IhG7Th0iIQB6CEWh7NRAh0+gWIhzSwPdzsDSJoa?=
 =?us-ascii?Q?9FV5cpcEGXw5mZLXHYjJw/AlUwnVV2ZadNYJFhynL+jhfs3TcCg9IVLXmLr0?=
 =?us-ascii?Q?YBsJLofCbdAGZc8czTlc2CpgQRScEvXfk3WdG1uBW3jcrfReaHQmF6nbBKIE?=
 =?us-ascii?Q?OsRchBnf1ro+14url3ai7wsovuST2x9mMYnHm/ZGlC/q0q+y7iRGz+4uKirP?=
 =?us-ascii?Q?k35TBrg633Ww1s+9hWLUypyEa5rCTO1LVryNwbl3yqX8rM9gjI3Z54PhjfuS?=
 =?us-ascii?Q?UZKY/r3WiGmVOqli6W3jD+nFgw0bP9cRWF+QWDHhBpJbW+F0NUlxeA9XWXuK?=
 =?us-ascii?Q?F7ted0/OmqKqXJ6dRSOC5B2lVozXXw4FBptaPXAaXeVpgu1WdKRKole55oaV?=
 =?us-ascii?Q?ykLZmupLaAlQaPTTNzGdpuLWDqwHq7MHJd4W5Q8N+PJjYp69QAQWIZMGfLV4?=
 =?us-ascii?Q?9G/mUz2oWO1IQW0dd6Um+bxYqLBXuWQkD0Idm/NMW4xNzyjZkGqd3cEkNVmY?=
 =?us-ascii?Q?GKCrPlXL8KHJcOVP2IXNaJDVTnE2e/HiScEEYhpUlhwyWlIZRCoCfM77He3y?=
 =?us-ascii?Q?zQz0BNLy/MMLaI20DptoTuyxQEbO494GztYu7q8fLQtRiZuwTi5TBOWBEkW9?=
 =?us-ascii?Q?cDPASjpy/lrZtN+DmiWxGcaYxF7xM6/kcbp?=
X-Microsoft-Antispam-Message-Info: 4twkQMIjSvb7m9xJorFfltzBDBDl1oZduFBON3uQ77JqDQdi09I339HsojU5MS6AQCIIwiRweP58uh33oikKCNKthWWMc476rQdgUyOeClFsUB7+woAHuVfJm2ZToNMG5pdb0SHAVhWFIQsE7C0CUX/+/uwQUeFkqOeZSao6v11zrEIJa5g3WaSi9Kh/cL4UvQLyELehLGaBpGXFbhrJD/6i7plzkDYzV7rw+2UMvOqZwzEhgFqHJ0duu2Nv6KO9AakqUDEjPK5r//d+wYLsLqn8vLr04jThm5I/Xrp4bYKXgerhoXsc7KtmnI7/TCFp+Wz/TThpY+cgizyNbv0fuegl2ukhrnySZIE33U2DvlQ=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:ITbaLfALJt1nEnONBrkhUEtahyZhgejEKRDqQqO4GepS6itvggISbXco7IJQHK4kG+bMuij48h1eid6BUpuhytPIsbLeXA0ZQRRzod15USutzVCv+8rIAa4R1h52KyVDz5nok8yc3Il71+YJ32HDe2hywU1MyqZgVEtNA/kTAT8w7CPAMcb0sYaDE1xqHuD9Xp7jtEgTg4fo9U/Tn9GUgyOg9WojDwIFWqJD2BGpepvXDAF9QnSXMPwDVwqfpmHGYtozwO/vcYmkQdsY/ZgarMwtUrvjTAEgREB3QQuwL9kf238eDInhYCTKKlrd4J0AcTxP5gtcB/QAZfohNE5LHXoy7ius1VKR8QW2Ymokftj50aXsUNXq0y3N2NnBPRR2tuDdhc44a0B0Caai1ReXI0kOPOD3J8DNIxw2eG8sC4hHxB4tyQ2SpfxQqW+Zzl2ZX3vtwW5dvLh6CZCRdnfwPQ==;5:p8ysZNqSlc5We4cppeU0Y266AQORonl6wy6hfOMNKW7P7x8SrZhSn3qB7NMe1nzfWgBNjLj3b4ShiRPrSlx+C/Imrxr1wA5I9sZM6JD/bmK8K+dIpR7VxZ6KMAhOSVSWaxnKYp3BZLaho2yi4D9FdLrO92842EKIBVw6oUTpEvY=;24:x01jYOV/jO64VaJ3p3rex03ANDCMp6AXMLI+Oe+yNguPJ24e5oR2bC33s5M+aB4NvWAS/Hqfnr7vbR/tyUVlAA/YffCOLxoYqVXY1uFdRiM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;7:pd0QGqOKUP8eK/NKIJ2Bbj6sba3xtc4DuuRowtNfNF1hMYNFQYciV7FjXiLulJBkHT1pOdcxKoUPf+gjmRLs5BqNMUmpFBFcLhK6XfW+PKAw/XwrYbRHardLHAKluFKMOhXuWvOWYFtIkzFTCLOL5dE9PWzbxZx9GJH31BJXgzqrGRsK3qlrygYhJpQEi7XWzgopPTr/PTcVxmAE2OrOyjHUAmLuKp+hR6ckiLG9qdCL60WxjkalSwUOqS/Y62uj;20:HKG/IS5Mqxu+OIcYcsciZ69Ex+fp8q+07XIhjbOZght4DVCNHqr8IUl+YrBbbaYD9bZFINVsrEJ+npBiZ0ezJ8asAL33he2p6S5dfse6L+xr4gcllsgFOp7bXPYnZohZVCfUE1lJsXQ7bGrQNOtX5qZ9qOrRrA3XSl/wWm0d6+j0+ZV4gR5zLFKO1mhx0P4JgBCvY/xzQn799DrNimUXUtM6oipSZflLE6JTRsKZ52nbumCrwFV7DCzUgmc2BYcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 15:31:42.9918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29784af1-6f43-4188-9a3d-08d5dc431614
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD IOMMU XT mode enables interrupt remapping with 32-bit destination
APIC ID, which is required for x2APIC. The feature is available when
the XTSup bit is set in the IOMMU Extended Feature register
and/or the IVHD Type 10h IOMMU Feature Reporting field.

For more information, please see section "IOMMU x2APIC Support" of
the AMD I/O Virtualization Technology (IOMMU) Specification.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 21 ++++++++++++++++-----
 drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++--
 drivers/iommu/amd_iommu_types.h | 17 +++++++++++------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 92241ff..6b2c9e5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3843,7 +3843,8 @@ static void irte_ga_prepare(void *entry,
 	irte->lo.fields_remap.int_type    = delivery_mode;
 	irte->lo.fields_remap.dm          = dest_mode;
 	irte->hi.fields.vector            = vector;
-	irte->lo.fields_remap.destination = dest_apicid;
+	irte->lo.fields_remap.destination = APICID_TO_IRTE_DEST_LO(dest_apicid);
+	irte->hi.fields.destination       = APICID_TO_IRTE_DEST_HI(dest_apicid);
 	irte->lo.fields_remap.valid       = 1;
 }
 
@@ -3896,7 +3897,10 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 
 	if (!irte->lo.fields_remap.guest_mode) {
 		irte->hi.fields.vector = vector;
-		irte->lo.fields_remap.destination = dest_apicid;
+		irte->lo.fields_remap.destination =
+					APICID_TO_IRTE_DEST_LO(dest_apicid);
+		irte->hi.fields.destination =
+					APICID_TO_IRTE_DEST_HI(dest_apicid);
 		modify_irte_ga(devid, index, irte, NULL);
 	}
 }
@@ -4313,7 +4317,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		irte->lo.val = 0;
 		irte->hi.fields.vector = cfg->vector;
 		irte->lo.fields_remap.guest_mode = 0;
-		irte->lo.fields_remap.destination = cfg->dest_apicid;
+		irte->lo.fields_remap.destination =
+				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
+		irte->hi.fields.destination =
+				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 		irte->lo.fields_remap.int_type = apic->irq_delivery_mode;
 		irte->lo.fields_remap.dm = apic->irq_dest_mode;
 
@@ -4430,8 +4437,12 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	raw_spin_lock_irqsave(&table->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
-		if (cpu >= 0)
-			ref->lo.fields_vapic.destination = cpu;
+		if (cpu >= 0) {
+			ref->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(cpu);
+			ref->hi.fields.destination =
+						APICID_TO_IRTE_DEST_HI(cpu);
+		}
 		ref->lo.fields_vapic.is_run = is_run;
 		barrier();
 	}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 7d494f2..f6dd63f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -153,6 +153,7 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
+static int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
@@ -827,6 +828,19 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	return ret;
 }
 
+static void iommu_enable_xt(struct amd_iommu *iommu)
+{
+#ifdef CONFIG_IRQ_REMAP
+	/*
+	 * XT mode (32-bit APIC destination ID) requires
+	 * GA mode (128-bit IRTE support) as a prerequisite.
+	 */
+	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir) &&
+	    amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+		iommu_feature_enable(iommu, CONTROL_XT_EN);
+#endif /* CONFIG_IRQ_REMAP */
+}
+
 static void iommu_enable_gt(struct amd_iommu *iommu)
 {
 	if (!iommu_feature(iommu, FEATURE_GT))
@@ -1507,6 +1521,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+		if (((h->efr_attr & (0x1 << IOMMU_FEAT_XTSUP_SHIFT)) == 0))
+			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	case 0x11:
 	case 0x40:
@@ -1516,6 +1532,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+		if (((h->efr_reg & (0x1 << IOMMU_EFR_XTSUP_SHIFT)) == 0))
+			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -1832,6 +1850,8 @@ static void print_iommu_info(void)
 		pr_info("AMD-Vi: Interrupt remapping enabled\n");
 		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 			pr_info("AMD-Vi: virtual APIC enabled\n");
+		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+			pr_info("AMD-Vi: X2APIC enabled\n");
 	}
 }
 
@@ -2168,6 +2188,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_ga(iommu);
+	iommu_enable_xt(iommu);
 	iommu_enable(iommu);
 	iommu_flush_all_caches(iommu);
 }
@@ -2212,6 +2233,7 @@ static void early_enable_iommus(void)
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
+			iommu_enable_xt(iommu);
 			iommu_set_device_table(iommu);
 			iommu_flush_all_caches(iommu);
 		}
@@ -2691,8 +2713,7 @@ int __init amd_iommu_enable(void)
 		return ret;
 
 	irq_remapping_enabled = 1;
-
-	return 0;
+	return amd_iommu_xt_mode;
 }
 
 void amd_iommu_disable(void)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0..aa892fd 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -161,6 +161,7 @@
 #define CONTROL_GAM_EN          0x19ULL
 #define CONTROL_GALOG_EN        0x1CULL
 #define CONTROL_GAINT_EN        0x1DULL
+#define CONTROL_XT_EN           0x32ULL
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
 #define CTRL_INV_TO_NONE	0
@@ -378,9 +379,11 @@
 #define IOMMU_CAP_EFR     27
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
+#define IOMMU_FEAT_XTSUP_SHIFT	0
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
 /* IOMMU Extended Feature Register (EFR) */
+#define IOMMU_EFR_XTSUP_SHIFT	2
 #define IOMMU_EFR_GASUP_SHIFT	7
 
 #define MAX_DOMAIN_ID 65536
@@ -437,7 +440,6 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_RANGE_INDEX(a)	((a) >> APERTURE_RANGE_SHIFT)
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
-
 /*
  * This struct is used to pass information about
  * incoming PPR faults around.
@@ -810,6 +812,9 @@ union irte {
 	} fields;
 };
 
+#define APICID_TO_IRTE_DEST_LO(x)    (x & 0xffffff)
+#define APICID_TO_IRTE_DEST_HI(x)    ((x >> 24) & 0xff)
+
 union irte_ga_lo {
 	u64 val;
 
@@ -823,8 +828,8 @@ union irte_ga_lo {
 		    dm		: 1,
 		    /* ------ */
 		    guest_mode	: 1,
-		    destination	: 8,
-		    rsvd	: 48;
+		    destination	: 24,
+		    ga_tag	: 32;
 	} fields_remap;
 
 	/* For guest vAPIC */
@@ -837,8 +842,7 @@ union irte_ga_lo {
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
-		    destination	: 8,
-		    rsvd2	: 16,
+		    destination	: 24,
 		    ga_tag	: 32;
 	} fields_vapic;
 };
@@ -849,7 +853,8 @@ union irte_ga_hi {
 		u64 vector	: 8,
 		    rsvd_1	: 4,
 		    ga_root_ptr	: 40,
-		    rsvd_2	: 12;
+		    rsvd_2	: 4,
+		    destination : 8;
 	} fields;
 };
 
-- 
2.7.4

