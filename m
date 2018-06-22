Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FAAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1904D24645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oovaPQ0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1904D24645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbeFVRCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:47 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:58464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754593AbeFVRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9bDyIj2OSiU3YqLxP7tU2adyl+mvrLF9DYwS3zfTWE=;
 b=oovaPQ0F4CvxbWP8qK1i1oC/ExwYNqCybg71NRDex1M/glhAzhBBiAzpXDy+te3d8PGF/pWpNbw4dN/YJuSH3mIhpKQZ+v8/G9EQSvljmsuvpzpnuOulWfsB7TU+a4i6JAqtVUP+9X+xFMrGsOkP7Z7gKCS6kAKcuA3SNB6T5/k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 CY1PR12MB0133.namprd12.prod.outlook.com (2a01:111:e400:50f7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 22 Jun
 2018 17:02:25 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/3] iommu/amd: Add support for IOMMU XT mode
Date:   Fri, 22 Jun 2018 12:02:07 -0500
Message-Id: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59dae8e0-b77c-4ad3-c177-08d5d861edb5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0133;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;3:lAYQmX/xHiA1muUJ2u72FLQuLfDzY1nutug0qCPIBCxKWF9+Si8MRj+6v3xgAR/o5TGC0KhO8FsOOkKrIUgKEaEmjzHlAY3+Q+87fd27piI0v1EGO8w5feBiHgxbhdKXcgv36QCcMK2RePDdC/MSusAgDBKa5sgG+17v078T+4dDZ5oEP3sy1feKBSazJWWHnlqgeAUb9sLrT59hDxAYFuFHn7XI8JeZlPFsj7iHEHw0ArQ8RvXUBwVX47j+UZQ9;25:xl7CAif36l7YPxqd+jgmwXa6LISUU55Bs0dNp/OQXfMUl+2GlvCIot6U7lz7DpJK1FvRiBFr7ISi7AgUNj7QtH0o6wU8WaJQIjqy2zMsvPjxsuf4gzmN/SEY0yEY6hdww7nnPfApbjqkcBub1pS1IO4uAuwFfYE+vdi1W6mOhHr9eYLDXoDio4iRx7d74kdubovk4DQnFel5QONH5Wd27GT9RzrHan+qh5Ot93GapQqzQ2b7MUarpKk9+G8YjrGZFJWVIGeY1/f7G6cHGT6ohfPKv2/XbYZqc+AaeQz4L/5k5ZCx5oyd/gTK038T6stntrpLzPVYHnsUFikWfzgbdg==;31:uoLKeI7GKnvCHoxrhQgi+8QmrSuKYumj4UfM4zk/LyTA2y0VBV9tLgN+us1fygkN7th7d7B5HqLhoV2AKRIEh8vmhlWAOgcbwsjFfH+ZI/2i5hB7QoYtegzAuJlNUl64VcHduH4gTjwCnUIBA4bYg6kNLHdG9RtZIHv5urNoDiboqSZqEkIS2txi3keDglDnmgvgo7D69k50ur8piVXmZI9+fRRN6ZKrJmaxyuf44x8=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0133:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;20:6WNkO2QlhnRHTHrc+E3oxOh5dFc/QzYq0ABiay75FCK4N/GHu7txCH/uhFZpCL2dU8ZFWA+Z9TitBnLcD6ZqdqHFVIqlJrWenufQ5a/rt6maVkqVqY7y6f0iM+Sy9QbPzkpJ0+cRCywm4O0E+8YsvsdpHtlb+awblLG75qBKKc/8Q6iS3xI8q06tS41+8a+75DTaSjA6tjGCgnPC5jzD0k9zPPnqbbdk3nWj23CbE+fQ+BiVpVGKEtL9w4UMC5k3qccHLzIKUc+f4Nx3Rx//brq4f4g7rHOiE5245WaE2UnsBXxDcwvTwwLRILWlv2P02wtqIJjBUVrzBH6wdIEuwmVhgTvgkoMgL2R5AVqchMwmY5b8dyV1Pds90MWKauuVXEhsuMYULncrp0Aj8zszfj/exnY632dck0MLJ5lzqBchL+1xIGfwFywryceWonKteQESjrdTXgqAS6kXod0UFFDbX3QdGvV2qvXH2pcmr0tCmDXZ84bcXHQqh+qIEfuU;4:aJku5fJZD3CEPGFqVIZWcbjeUIqJRiw1lJtk6DlQOsUoFVXBAfzFb/bkRL+9XAGhpsfqx2PlcsqHUeS4MlrVl9G1Dp/K8WVmlXFa+2cy18TRk9N5o5waKNssiaoDGDKhVO2TXkvJ2CF26rAvgxsOPkKjKlorQs6HpKI/8O+v2qhQgrVQKDlQeeqsIE5hHp4fPAORtHozOQzChzxR+nOAmKyLARpTmEcdM8OhWw3ofO3i0N8TZzSFoQgFBUEBKoFotLHSPtM8wq8/1rWnoL22ltL8UUFAfCURhcRjVcdWdgQFSrRHcsASNhPahB3pfHB2M71v8r1o0QfkfrDKLWf12A==
X-Microsoft-Antispam-PRVS: <CY1PR12MB01333E207C63640548794769F3750@CY1PR12MB0133.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0133;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(50466002)(7696005)(4326008)(186003)(52116002)(26005)(16526019)(47776003)(53936002)(6666003)(25786009)(386003)(59450400001)(5660300001)(6116002)(66066001)(76176011)(478600001)(48376002)(3846002)(72206003)(51416003)(956004)(11346002)(476003)(44832011)(2616005)(486006)(106356001)(81156014)(81166006)(16586007)(6486002)(446003)(50226002)(8936002)(86362001)(316002)(68736007)(36756003)(97736004)(53416004)(7736002)(305945005)(105586002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0133;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0133;23:wWzU+/05HRJ2Y/weZ3ly6PAIDV0JEwpN+nBRLgSvA?=
 =?us-ascii?Q?wMLDOXsu9XdaLwu9Uq0t2nyf0hT+aBvQmEMiEXPaEgoYfPVwYrOKNxNdHiNm?=
 =?us-ascii?Q?MPSJ226TJZK0KYHqyUL4WnmpTKQVmNi5l/DoZUhp8qk17pqSvaWhimRIg2+5?=
 =?us-ascii?Q?AJBBAgpUflVVNNEHT9RLT1x1ca0d7Ci/VoiZ4ZajsZCbdEwpQoVgYS4WWILT?=
 =?us-ascii?Q?sgPLNQ0n/UsdamDv5pIec16PkkOLf73MxyxSSL2LUOdMcNxQjdeKc0GbCu9U?=
 =?us-ascii?Q?ppREp/I9SpaimPLeJXua+4vaZDk05Yu9KhVxnFLFuXZIiMCkksqxKX90JxJa?=
 =?us-ascii?Q?f4cHAf4rBu29j5G0Uo9qLiw79fU6WmYCdV+d3cEXC1nIPLE00NPZgd87nopm?=
 =?us-ascii?Q?427FB3KViDkFFFW+SDlCD4yJjgvwG+acDVYpc8QeKRMZbxg6Ai36/6VhsenC?=
 =?us-ascii?Q?+2kwTBmMDiiUGsvETqC4gDlsQJ4gZksNB/KH5w2Qphd2XMIU/+GhV2RwWOI8?=
 =?us-ascii?Q?EcTYsW1C53jIIwhjrt6Xe6zxnF/y38hHu71lsK6Tr2qNeWpvIpvmJ6+rZxHZ?=
 =?us-ascii?Q?11IzOqGIDH6TUPDslMibd17zvv/aepyuUjmJtrkbd7qbme4mDIMuoN9x1hI9?=
 =?us-ascii?Q?sInj29lXUn+vc50ELHlKxFl0wbzqtRE6lbHIB22ClyE2LAyXeeeJk8GKwiPC?=
 =?us-ascii?Q?2rxRNKaH5IP5NAx8rXrtnlM1jR77ae14zBH8BYPyaTsI4GV7SUIiR2jKX1hL?=
 =?us-ascii?Q?zAN3Bk5Dns82MMoQkFfpKKonHq3x5vh7ocvLU2TDSz9iPMfrJ+a+x1m28F4K?=
 =?us-ascii?Q?uRwfeHggE7Oy5e8C6bPfjfTOUdUp8E/Xq2mWLGL7lcQBqAZudAL05GNwn0v8?=
 =?us-ascii?Q?l5CYhvwy2cPhDKXzCk0IPUdtaEsxLVCAr1KGTCJgCyPytBlJU7lduHxoXt8n?=
 =?us-ascii?Q?H2MyIMYhaqUhllpTodWCd2s6vsVkTxodsxkEfwIXGJM9kIIBras7OiiOkw3J?=
 =?us-ascii?Q?dW8gz3eol6MWs6maKxYO93mXX54tMzGAS+lkz5wRiKvWnb7nbyWZpxu1JY/X?=
 =?us-ascii?Q?F9J9y0Try+WWamymejmuI18BSOYWEmDCquqgFlzTlXSI3GByXYjt39NB9lR7?=
 =?us-ascii?Q?l4v3Rcqvl4DydWuFVeTyb5tCrs6vZ7ZeaVpr6ym9jy1M5Aq+oLVglqROHy5p?=
 =?us-ascii?Q?PeU1zATMrogNslacre/YI9+P9rubRS03+BOlVn6fnXmkUpEKT4Xh8LXmQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: pqbU/npzSkJ2OnOLSl6Z8aDUJVPuzGRvah8asLpfbOmr3D4xa/kMWCd/tSP5dyf8lLq8FW+2WTP+ZV+akYIO2VMbjS5ReSOTnCSSsSpc4jkVJG/95k/bVTHI1KcJW7o7SihXoun5psSfkZxbt9jbaJoE3lhpJY/ybmhyipgGqdu2sJODXadYw3pK6MeWVgK3KOwAhqx2rHsnS+vWx5VIsDIOF5AeRasCYBuzK3ybFgYyuJrRdcIIOZr80f5AeLbv+Xl9cSh7HhqvLkXVk3WBbS5LuIQyb7LwObGwZZqJBu6rtsDXxVnfxNNbC6C0/LuR4cGYTz0IPKLFpD7xXi9K8kR1yf/NLaY5NKd8xBUzvUg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;6:l2SFdEbW/uQ8Nnj9m4FHwI/VrPjj6Z7MkC8ynJyBoZNNALJDxtgG77u0cmRUz1uUPp1rOcw1jDIp2AkVMPKCekuSusXaO9EVnF8/vvJW8ce0/85USpm6YDiDQLdFlGaHQHtA3jjB50CGKd3ueOsVmK0SKmKz3OQtr56KmQLVYqZWrfZTl344bX2PyX4IknXkYj2NzNPkocWdjc4/y6HBFeYqm47tQnDMijXUZ83p44+i5DVhG49/M40ifnYHe4JCqTOIvanyJMoEy1+swDHeoA1H0TXDV8TuakX0lsDV49efDlO6NYererv7UpFf/HL5xsjccp/Mb/0TXvOJo8zZNBW1DmZVX5+mvwP09rptM01bZWqb36XjpBZ77G7zAn9Lowlk5tYkiTkObG96O9eEcfRwYxtmcAmMwMvtIIr3KaaNawUNMF7UJkNYgW96BEmlokmVzsNivuyuf3//92hTOA==;5:elVIJBGFoViJYRmbPQR+MgSUOOibeMeF6ECFzlKMW7tXAiYwKv6AtHrIyKkalikeLcHGr7ajeySE8dK9414NpYQUJqaLKEfnJ4wNb2tJD1NEoop1ymqNsSHHnC4dD8AlxvQT4TPyFo2ZM76JxqkuvO7vh/+j3XbXFVV+k8DncWE=;24:08iSJjv3iF1uJinxG5461G7IqEPmszoh9yefPEeIkfv9lJlX7myDE12/iR03w3jCUl7Mn4V+a2AH5etEHsN8Hgf2h0Gl71DfCYC2yX37WYk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;7:zhGkLA3wasBWmBiqandi2gRUB3ll2QOJpSxaMe0X37vLUMccEh5tlRLmtpBQECt1dP57qUeZvRowCN0aXrE/8G0AleARHlJ2O9SYbhqe2b7T5q6w8EMdB54jEib0MAN6vaPMTggwy2SqpysmBimiyOvJiOzINj0ji3+Ij6qf8mW4E3pnGJV3Pc0ZQa7wyKg5b11JhkAm2HrKF92z/ua7Ke32Ppff3w/RcdyKxW0YqnJuEeLpQZ/q1h0/gXDX4cmp;20:9DIjhaSuQ8ItyAO1Gq9D5I+4+8TvIy7VI/0ateWrC26ROQYfvjAhvHCzqUjc7b3rNuxVE1PRXB3UZ/mnV03kK4I6hDhn3lme9pGmcooWfBw6ssD/ZXCyYSLQ/j6pd3IlvqCJQlqcTywrPrVJX2veL9p+UvnSmOP+3jjw3JzIEfybl9c7ijFT+Cz7J1kI/QMHgqWZKsjNvPf2BrWJjMpRzGcvCvPyUOmPqC3u/8WLxJtVWBho0zRfcZpBi6+IIkLX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:02:25.0058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dae8e0-b77c-4ad3-c177-08d5d861edb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0133
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
index 7d494f2..1c6f813 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -153,6 +153,7 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
+int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
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

