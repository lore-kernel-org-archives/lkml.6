Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50425DE4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GfQunYlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B50425DE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754797AbeF0Pbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:31:51 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:37431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753229AbeF0Pbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMy3T+yzLucg6N3LQmkndI1FFXKYxjR0Buu8ZZOvv+A=;
 b=GfQunYlP/X3z4z38I7l49dtHI7gPZonsVrgW/p9NZgfgykvYnOObJJy56EYhRsrMvdVxSfgjE9PqUZTACqxC6Xce625K64E6Vcil1C6/9LpVk+L19LCOi+JWmvSr3ahvzxjCIGRON64Be7V0dNKJn8dVuGclI0Pqx5Mqh92mHzc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.20; Wed, 27 Jun
 2018 15:31:40 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/3] iommu/amd: Enable x2APIC support
Date:   Wed, 27 Jun 2018 10:31:19 -0500
Message-Id: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR0102CA0002.prod.exchangelabs.com (2603:10b6:805:1::15)
 To DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39336984-aeee-4e5a-5711-08d5dc43149a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:Xw/RZvKT2DJ2IPCWhlLCzao3eW9i5knpZ1Ca63ZyOSkSMTeCqhMEOuCV5kxTXW/3zIGQTDO+gSc7UBx17tMRTXF5ST6VqGZyyp6g1weQkkKvfykrszr62LIv+WGPlS0XBENg+BTxVcGR9CUp02W9dFIkwMJqFDqkH817PSeyumcyOqe0ttAbQR0SaN28Tx+VRhQ/5w6KjKyoxa2hKsIsQPZbH6k8rhg6QlWIM2AXIqiSsdPGE8B0Yw7SVMMTvSFR;25:zJMXmFdjMW+1f+XukjMZYkcUyXaoUz+b0SVY/blni+8E6JOKnSvFppsGS+Jh+Cwy5Mm+VjMrVoRJHRPgSMTo9Dv27DZ+FUBetBQ8HrtzZtLmKUqUvnvzSmtTrV1fIRyh9IjgSW7WSmUt5cDzLIWN0OUoHqSPcQpNsSDILel00WHtgODCb5BilDkCFMJyDF7iwKYj98FrzBj1MW00anQVJcCvqpEtH1SsqPeG9xgPQAaAbBQdJoS+E3Ue8qRkviAr4YnC9Wjm0eLjXDL3hAGLWtTNBQTlakCtuGUjUqbXM4mkEmlULjGrS+Enc6tVdj1R69T64bsmHCiyHEwgx8D7bA==;31:Lw5GM6/YQ0e0gfrev2jQ9uVy3ne7tsC44jXuKzSYk3ZISKI7N0za2nAzz5zV4NY1blZXrYIdFVyYxlkS9nAAta/DqfQ+biDNM7PxnnKvux4mrEf5unyltSH+VsMcsB8R92wS7ASFmy6KJtrfhXUG9PR98EbaEPwZbZHttDyMyqVHU8h7hP2ATJMwdfJtJv2aAmhd76RMbZwq05h1HIUmEWG5fH6hxWGkZf7dkOHnMC8=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:ufEN7niUxYCTxpXd8NMmcIYM51QBx7meolO9c7uzONO7+fqdvtazDslz0CYP58HsCk10tWuobJldegMZWKpD9B/dVQyRBvm4nJPL4Jcl/6w+ZKgzmH+xRUMvr2AtZFHgYVUmWvoNnlf41XkOstD/ejLWZJteFrsxMTNBoyCS7MTk8/fc8EPaIN/rozPhCtLGRn+TSZD2JbmBcKNie1IZ8o6dPcj+vQdB4wpxBKWPW2tRqRX7bk18ttpoDi2+IwWm4HL5RNR99HOXQe0bWcgowBZ+DFI8Mpi+ZH+yJdLAw0TOlgQpCewuqc+ZzX+uv7NwlraQoIVSZEy0s8BgKpMmpqB+E8QwbFlx/+FbATosjKAcKi5jp1fGyMaxkH9KqSNsBxlhiw4SBgdB+MRWJZAas5fb+V7vkNqrI8JkFt8nc3zNPHvjZrC0O87LCbBvg2eAsfu7yk5LTwO0rMUx4ToQuVpthNgnRXaBLL5goLqCOTvbxyOqTPBc8odXpnjvbwtd;4:wJlKz80lg3Szjjb2gY/1CwT0pERjdA1hhZuks3WruArfZXjroE1qyF14gWSJf9+YET3OJ0BrBQE8FNNT1rxFj1hFogUtfZhQIbRfbMG8UtDEPHvcv59kL1M/rpEYi9UITh/cTgRNVYfZTklPYgzmQUBxCldOI1qAYjh/Hbm3GeXhw4use8UnvIW9YpbtVpUvWXtpohcETJ5BLthGT+rM9UIUAYlFvrpko3W+YiGpNHMy7HXjJIWWLalHRYEi7cPi5Zl5LhFNaCko2npi3Ur/vw==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01399470F6BC176E79A68CE8F3480@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(7736002)(575784001)(16586007)(86362001)(44832011)(72206003)(316002)(5660300001)(97736004)(305945005)(53416004)(478600001)(105586002)(50466002)(14444005)(106356001)(48376002)(81156014)(6116002)(47776003)(26005)(6306002)(50226002)(4326008)(486006)(36756003)(8676002)(81166006)(186003)(8936002)(53936002)(476003)(3846002)(68736007)(51416003)(6486002)(16526019)(2616005)(386003)(66066001)(25786009)(956004)(2906002)(7696005)(52116002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:SRgxlvth14O1xjwLkclISDIxfJ3tH6iMT3g7/y4XL?=
 =?us-ascii?Q?pUoFqtpyBwvRb7a/Mu49da3YIE3R4f4GsInAOmlJ2oXQjiDqG81S1er2zThX?=
 =?us-ascii?Q?R+Nl6P6dClI6od15E8uKGkDJguG26UWM+QwszQIZ6Ufg0mZuMMfcC9wGXsmT?=
 =?us-ascii?Q?jPmmRi90LfZSUqfxtKGtQh9kVBCPv4AhEd3vabGj+c1TpVz8K134MBLcD3l5?=
 =?us-ascii?Q?ESCD+hsjiIilqejvO6XfszEFirXe7bNM5d9h19gOdbgeOJrG653vH4Y/j6j9?=
 =?us-ascii?Q?DRzWrh14VHvWSl5SUK1zebas8np8wi4tTNvarqYEJ1XNpxangdyMzR0evYmI?=
 =?us-ascii?Q?rnWns2OsV6UWdzc3vJlg16fvEohOX57I8AVoB8kg8+OcRS6SE9FEUZeA74W/?=
 =?us-ascii?Q?gZ6bgV41YB8JJvTaz7cs3jwLdLT0vj2IdvlVgmaeB9Cuwbznl5+GUkHwwNf+?=
 =?us-ascii?Q?bQouG0+pFtNFTez8J6RVQRDISiQsPcV77qoTeX2wW982yOh4Ygm8GO2x21BV?=
 =?us-ascii?Q?OlUUVPrxEUo5dX5hPBz/EbLlbZNxabYlCKxEd1hR+ajbIUIW9Q+AZ5/DrSYv?=
 =?us-ascii?Q?m98D3+9fe/p2H6Igfu97Sb+Pklm5yT3bBszoFeuXSDuO7y2XtNdoSX1qGY4S?=
 =?us-ascii?Q?J2c9kbqMVqPgF4q8d1m7epLFkQ/eBUjSctySWVNE+ASloHMEd6mmzlN3f5xj?=
 =?us-ascii?Q?+ApSpV4Xx8g66AmMLpbMcPbKXqHAxWcJPS4XFHpUe9ppNi7enwpjMaEGlYjP?=
 =?us-ascii?Q?aINsnNcb6TJ68LJGSg32jbUhtTK2peO3/j3d9jnS91UHj4G5kvy2tT/wU6J2?=
 =?us-ascii?Q?tcb8Ssur+BEJLsKNVt0n395fUsj32Qcn/udIJjnQeOynfhAr/pOzplemttTD?=
 =?us-ascii?Q?GdirfMyNUXoKW/QvLbUUYIfGVoN9d+TADDsV5iBIs2zGQ/jlELYzsIt1Fp/G?=
 =?us-ascii?Q?dSaiY7Da70EtouJzqZyi9YM4XAK9Y0L+/ATVaBJdG/OccG8yFGpgeXZYDbLe?=
 =?us-ascii?Q?fu3Thz5mP4avmJkZZuJnpXEqv+3LrJwBkqdXfYNUa3Hvc31sQbSuaqNR5l/k?=
 =?us-ascii?Q?h57MwlmJF/uAQFAHaQbAp4UwI0UsDQmiuExdm1zpcBDSXlqQiLptPZs26L/V?=
 =?us-ascii?Q?sM2ghbKFAl5JCURASSp74cX4SUvw0C6eg3une+cPbLLVtNz/YnPqqmV1kAoP?=
 =?us-ascii?Q?fje/bEQJ4Ae3lxQnsxJz2E/w0mfgrdRE94H?=
X-Microsoft-Antispam-Message-Info: LAWVplTpmN8rbqYwwlWiEZhDa0mDmmTqJ6Va1tExixCaR4fIj8rS23FVQzK//fHQbQW+HUorJBv/y0C8fqtD+Dmh8Np2txUuXwVc2FAuOp9Nc1qAI8ruk/imDRU5WCFGTsr0BevLjF3E0mXtjWBSZS+rq2q6q8ZTkEgNaIFMLQJCzgDOtbCn7smdLMkq+kOoZOHq4CqExJJTJ1mTRaDxrQgZRHNHhV9rBJ8m6sxwX/xQFJ5gQiX9+KqvxjsdfR6J8/BJo6zEaO6u/m8mPNRab/IoKbU4nKgRFJ4lW6UygBk3v7xcAQ6klG1wUvh/SPMgdqxGITiXnR13c8DXVWqWM3IRaYRtA7KGOhC8pR4cce4=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:gJ73KB7BtTXsoPmQ83RfWGDekBDwptyc1+sJu68MrhWEgbnt/21FA9ueCKxuthu4i1PIFWyHOK8EZWksx/yjq70KKIrTAb3lDStTZY1eSGkV6ROx0sfKg8QTkG0NrZ5ghJqz1LElHXBnPh+AX6BwBtrH3ogmXhaqxBOMndS8SxYjC/Hej4gCfy2wWBY6dIJgRmZ7X4ZfItPUMJw3yTZhZBfnZWwrIPIgqNLidNRrkeZ2HQOxGJ2/+box4NZBTE0t3HhhJbN12IPshZEl89BKVD/KTbqQhdsr/8k4g6LjIp7ahuJXyHAVMNaNsw7Jldh3dPpxJkDzeFOaJi5IwOB8r2cIhpe5UIW1Gdu9xQ/rzj/r0Wn/6yNhktWMtJoXXci2xv0I89PTYazTVSl78JJd+ht/zGfWor+Jrzkd9Xa2V5pyEWqaQuFjJwlag3LuVVml7cSpMNqZhrm5PU/8FD1oEA==;5:/JX1TF2Q7XBXh8ceQLfFpiAckadENgfQGCxAQKmiBBczUion5wZL/sR+rSXFvClg/IYMM2mI5FfXb/raiYAE6haaui0GSoTLGGJ5WtuSoUH8Dk+R3+zHM26EZumuTom5Ja0seF+9cPj3xfKJNNwSGArtA9BS+HgEF4bvWEgiJwc=;24:7H4of5sYXS/d/L83a7wfjkAbHOc62X00GtMwlWAQ7+up9k42YUBADTs4rrr2JwpzHwLDbotwZCGfIJG0f8zOnbjPyYmJBPhEgEC5gyemH0Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;7:/AelDvyJntwRbO1r2TRAvXL9fRRHArLgggAAXmJ8kpiNbw2xwmlzrKKNqBHurs/RfXcodxbqi4BnJDYU970efgE7d1RerYyeUJoJT296cSZ2M+eYsSlR7uUkkZSjnDJK31mvf0TEiafWxZ7J0nflmglUwXyRg/aGnnvE7yBnw/Q4oInKonOHv/5lbPOamVXv4TIcc0CR1K6oSTYdQ+71hRFbcrO3UuYfj8FvQm2/zSY0Kdz2otJiA+j7fSTmlPnZ;20:/0fn8LovwIur38GqZ4oQRf0XodcbaPJ3idYUP6Bypv0OC3kvAY+KEtI/MFG383BwAFqDGC9D2u2nEqT68mE2yUaEJoQ3iwI52g2m8o8MFOnOXHqg3+9aV2s3pPFPUXxT8RS129yXCgcDiLqHBGZOFFAO2p44i92aj64R8Ch7qEsDPAZRLGU5U/jqXeL/bhD9urftcfmwFuJuqCwDrjAJ5aGw1ImTmxWcmAZmLCjjEarYcDTxttTwI677Y35KVBMm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 15:31:40.5158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39336984-aeee-4e5a-5711-08d5dc43149a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enable x2APIC support for AMD platform by enabling
AMD IOMMU XT mode to allow interrupt remapping with 32-bit
destination APIC ID.

For full x2APIC support, the following patches are also required
(already available in v4.18-rc1)
  * 6c4f5abaf356 ("x86/CPU: Modify detect_extended_topology() to return result")
  * 3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available")

Thanks,
Suravee

Changes from V1 (https://lkml.org/lkml/2018/6/22/645):
  * 3/3: Declare the variable amd_iommu_xt_mode as static (per kbuild test robot)

Suravee Suthikulpanit (3):
  x86: irq_remapping: Move irq remapping mode enum
  iommu/amd: Add support for higher 64-bit IOMMU Control Register
  iommu/amd: Add support for IOMMU XT mode

 arch/x86/include/asm/irq_remapping.h |  5 ++++
 drivers/iommu/amd_iommu.c            | 21 +++++++++++----
 drivers/iommu/amd_iommu_init.c       | 51 +++++++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_types.h      | 17 +++++++-----
 include/linux/dmar.h                 |  5 ----
 5 files changed, 68 insertions(+), 31 deletions(-)

-- 
2.7.4

