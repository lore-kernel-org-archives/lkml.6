Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B23CFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527952086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D92Ks3Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527952086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbeFLVlj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:41:39 -0400
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:48446
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933958AbeFLVle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dSlCMIaD8Bcpoh0QHE090CpOwA6uZzHwT+HBiAvTXw=;
 b=D92Ks3Uufv/tXR2YACAoH9ipRRZ4zaMLrMtgPYu+B4K6t7A1BGJhQTliK0TX49ZStvurT4laKdV+5hC/DXginRPsK20xcxI8xo98+L/SnpDPmDuf/pV9F6c6Hsy+zr/RuuPBiqUjEe/DouzsFKoG8unL1MO2Hi3E3cwvi1MHAJc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [127.0.1.1] (165.204.78.1) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Tue, 12 Jun 2018 21:41:32 +0000
Subject: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From:   Gary R Hook <gary.hook@amd.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 16:41:30 -0500
Message-ID: <152883969032.1936.15155267369758178246.stgit@taos>
In-Reply-To: <152883965482.1936.13657625103232933481.stgit@taos>
References: <152883965482.1936.13657625103232933481.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To DM5PR12MB1452.namprd12.prod.outlook.com
 (2603:10b6:4:d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbcdc142-e388-41f5-1701-08d5d0ad43ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711015)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1452;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;3:JYXYsfBZ1v56UI4fna12XJgTI7Q8qXWDRBlHEonCcsgZfWNXjdM19J+6bMna2ZXf7EPPN4zCm5ek12OBVnlAzss6Z0esaNWe+J9Y42/lbuXiqhaBfsFS0ikWuq8pi2minWdZ0VmclJuQQ/5TXM1v5+mwbI+3YyHa4pe/jcWnFZFuA0+7US9W1blQTJtgHc57+a4AK+xfZoXyo9DJjGzRoWaeUJy09olnX3OSlueIG5VJmxv/IVJ4iNlypE6Iu552;25:HQoiFK9YQtH6HR/d64od8AmLHEmviMlq5yhT/rEGGlH74+sLtOAulPzshQdUMZdk8NyPSkn6Rmil6V/3MCpdB4d/cZ4ijojS63f5L9pOtSgI5nBid6AHfii+vJE7a2bdYXyjqULI155OHHYn0BW8dFmeTRHSpF4eJYIMoB+WjqVGX9fW5a2NK9iYC8ueq0s0aAQh8hrdJS5Cr4unH4f/ELwoWp5IMybIvAsqAHM/CIppEZrdbFBqq7YQ8qKIISrEfV+JNyWJSRfcdw4XJgj9mtXrBf5UCZXCQGZI0+DfHcNCQ+inxdI840TMcHb4TdO2A/kOQNTWZ3qeqpxS/G7SkA==;31:14seiHCVaPI8cGc0CagboxqROBlsXb4aP7y0ZZ66apWbctN/cJO6u6lLnNRgPV9FzWiedmY0XvHE36J7hZo74iJ8Qo2oWONAr/iX9Vt4sz191VodEF5dlmk7CwVeQkar9s2YH9jE9a5Bfh1O9YvhPX7jeH/9ZCOmU1+18fHlcZNb4JZBAx1ZtP7N6f3GyDjFfBNOkIcOYgoEpogfGx7UdMucJxRvPZZqRy+OENjbyWY=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;20:mwvpbopFxJKmj2DJn2wgZHwADGA08B2Is7Z81RAy8F6XwLB7tAKkMUYe3tCZ4BXV5ZXaS3FitCfvpDjr+nkamwXVV0m5V1ey0cNbXtS7lSk7xdVlV7oNU3MgwCAeMWt6o7/bTValLzYKpiXrPDlKvfH/so0Z7veHBgfGRFi3t3+oHag6lHmdacBRtEdYxDTb66KUi930DKXzyr90ggAzdLoPsveiKqpttPt05rREkKqqhesuYi3aUX6z1GvF8i3PT0P4U5e1SujzGMC5o1yMH982ZGZzAOhmy+q6Am826wdtfntsvYDXxhKoF/GekFIxOq+bU35Vg2D3QbtEtfAxLTiz6UWMRTewUYXMhMuBU1vxMx6p4zUW5jS5oPqJZTtrnXP9CxcWbWEwniDpKMjMjzr3lOdD3zZ57Ps9VteAnGL431O6JdpG7NvF2aaEBUUzQjWSKmYruAURmAAlv1HA8wOCAz9ZOXC5VFtZgSmdz4EZEScatXqy3h9az3k3PP2Y;4:fgf7DzWBYtLnzkA0P222q2/R1X9Bg4Cbr8dm6G24hW+6rIat3CQkMLU3ThBTjr0k+8WQeTXNv3bznqRXT6JhPyFGY/hm0jSvZjjYiaWjTSWXcXD0q/iQ9S7Qqgq7/U6tFf7Z+t2Hm4xm1+DzrlfF4o2Aac7dDJpj+Rcqm+oX9WQrnx5TREURc/5LVU6vExgt56reFMGFk2eLjML4IHg3FDXWhS27jZajmq42hH/B6ioNK5oNaeri5EDkapkNNLJOxSy5FSCj+Li0XB4ZNzF4tyxVRyLCtvyuGJSqMemmQyV7srEPs372qxg59sxlgz8E
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452CC17A91021155A6F4B6AFD7F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1452;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1452;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(23676004)(2906002)(486006)(58126008)(68736007)(50466002)(52116002)(2486003)(6916009)(106356001)(11346002)(5660300001)(2361001)(53936002)(86362001)(956004)(2351001)(76176011)(16576012)(105586002)(230700001)(72206003)(575784001)(446003)(476003)(7736002)(97736004)(26005)(77096007)(33896004)(386003)(6116002)(81166006)(81156014)(16526019)(186003)(3846002)(478600001)(8676002)(25786009)(47776003)(103116003)(305945005)(316002)(6486002)(33716001)(4326008)(66066001)(8936002)(9686003)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1452;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUyOzIzOk5lTGFWd25Jekk4UC95c1JRNlpGVnVIUDBq?=
 =?utf-8?B?MVROcHhua2I1bk4xNEk1eVcyT2trbmd0d0tVREVMN3BZNy84aDdEcG1MQmJF?=
 =?utf-8?B?WnF3VnZCNjVBL1RwU3phVG0xSm5JN0pFOG9QN3BWbDl0QmZmWUt6VkVzNEJj?=
 =?utf-8?B?bkV6K3NRTGxEMjZtZU52WkszSjhFMi9teDgzdUo1UFU3SVV1WW1UcUwzMU9i?=
 =?utf-8?B?UVBYbnVKU2xNMU1OQ0tYWFdsd2s2VWxiM0FPWUIvQVFiOEl6aTk0TlZLWUU0?=
 =?utf-8?B?SzVGSE5DWWZYWGRRMnVoV3JYV2FBblBINEpud2hZTXRLMkNpbHE4UVQyeVVD?=
 =?utf-8?B?S1lqN2ZRQjJLSzhJQ2dTYStnbGJaM3dPeVFxdVRYeGgzRnI4dU9nMzB6MXFm?=
 =?utf-8?B?NTNEeGVoZloxMXFmOEJHRCtZc2ZxeEFNM2ZIbFJMbzd4Lzlmc1FYZmJJVkhV?=
 =?utf-8?B?Y0s3SDdFcDc4QVVIMnNrc1FjRmVtczNEOG84UlV5ZGdvamZwcWMrQ2N4NEow?=
 =?utf-8?B?REt6THFwS200YmJjMEh1YzFmcGpMaXdHWjcrdTN4ZlVub2hoUzY3K1R3QUNO?=
 =?utf-8?B?aUVkVHlNc0xYaER4S3VtUjFUSmFsdjVVWXRZSFVpYzlJTm5WVUc0TDNaRVpH?=
 =?utf-8?B?Qmt3U0E2ZEQ0Z2pnSmZFK0t4b2hxWXhyQTZkWVdhdnpickc5eTRuTjZzTDZN?=
 =?utf-8?B?dzNtZmNiZHNEYzRUR2JEUlN0ejhXcWtrZ3AycVdtTlI4QnQrME5RQXY3Mmc4?=
 =?utf-8?B?aGlidXNucUNrNFFrbHd4QkdWV2ZURkgyTTNQRmVBaFZPTHpIcThOdDEyeTZh?=
 =?utf-8?B?cmZrS3hQaEhPWTJZeFVXWlA2UEx5Z2syOTUweENVTGVQbVg3anU1MTV6R0VD?=
 =?utf-8?B?SGVnM3VKT1JyTDhKNGhUS3JLN0JmUi9KVC95aDZ5bTZqTlBhQVJoMCtGUURq?=
 =?utf-8?B?NzltVG1WOTNtSGYyb3ZPenlEVlhtMEdMdS82RzkrV2YwMHVRU0dwS3JqNW85?=
 =?utf-8?B?dTFQeHYzZGNJd0RFNjlyTC9wMlZPQ09iTmxhMzJwSmszWWtMVGxhbUNjYTYv?=
 =?utf-8?B?NUpKMmh0MXZlM3dMb0NNRG9uSkQyTjBvN2htSzMzS09PekV3VzJNWkZNOE9j?=
 =?utf-8?B?d1RybVFQOTZiNUMvUkJwaEQvbVN5WEhuYTkrWC9XWW9GL3FvV3BlWS84UElN?=
 =?utf-8?B?R0ZzR0REckFIOFd2MzZNdzJsRUlVRTFwZlpZZXRIbUhtdkQ5S3F6bFJ5Qld0?=
 =?utf-8?B?QTMwc2poTGtEemQwN2FBUVFUbWVFa0VaZzRKZXcvbS8vTzhsTVpHMnU1b3Bs?=
 =?utf-8?B?aVc1MHQxUVN2bVdXOFFFNFAwQm9iZFJoRml4cElaMVdGUEFMRXNuazZ2RWNq?=
 =?utf-8?B?d2dLVjdBd1dGeW54UHpjTUlDeFpEclRHOWZDQyt4UWVZNmc4Vy9HYzFzRlVy?=
 =?utf-8?B?N2Rpb1Qzb0RjTHdsZkpURENKQ1BhTUorSVdnN2V6Uk94SWRFOVJlYUVWbnFl?=
 =?utf-8?B?UGVORE5qdVhxYWU3cDdMV3dPWnB4RWtWdTgwV1JaZUh2TFJiQjlhQTJiTlJk?=
 =?utf-8?B?MmpNVjViL25sRkxjUHFiRmpISlIwckpCNlVUeDI4VE00WmdwWWk4eHc2c05E?=
 =?utf-8?B?azlGV0R2YzdjYzkrUGhoR01ueGhPN0owN2FTNUtsSE9TV0pXbVQ2dnFCeGVn?=
 =?utf-8?B?NnZkcWU5RXdZdlBKRVBEZVhlRDRMcmJMd0xyaWh0a2RQdlY3NXN0VHZUUHBE?=
 =?utf-8?B?eklDSGh5TExrelNiOHFIeVVFR0Z3NTVvcVljSXNEWXF4SHhhNkVFLzZqYU00?=
 =?utf-8?B?eW1nbHJ1T0EybHpXTENGRS9Od204S3grNFYxajBTUzk3Y1E9PQ==?=
X-Microsoft-Antispam-Message-Info: Ml/QXDqty1qodpugJWcWp3mSzqptVbWiw/XROAzQ2CJrNXZGDUWKuItIBSBl0lL7q0U+ODIdFIziCEwk0QDSOHOMWZMXXLgCF4Zmpd515p32yc2gVl29sGEhjmtcB5OzQXyavzGZPiHmftd2lJw8dR2cQ7VTzG8UM58HaLLPTiRiy7HOsJQ5mcheS6Vw5Bac
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;6:nf1lA+zCEuPOVJBygjf2JG79IBGCwu1so0xFr4M9GcAFA8yhmBbNfWq0Q+vEJSpJMR6cHwErRqj4wx9MGUr7gojJ20zbZ9TYZ4eBFbAKX68vDo8GeSbvBwFUYzdcmnXrmj7TqoH9u3LkrSDldIyNjbt21WngIFbV/lg99xFOV7+Q6huvnLNT3075mw6z6iCh1/kNLaFM18HHEaOkDpeviJKm5hf4e8Y/qNc9X5Ybg9sEqUxXDAuRmaMpEzX2uFICAGQxawzQ12MDD1dZl52yNKTKrhWyGKQ2UfPKg8EjAX/WnnJkuYSnM6BfN3TI9T4K63peLa7id8nFELI0z9xCTXkTA1JCbpBDbKtCUDjR1npQLTFFan9iWAwqrADzMq5AMMON9yrvSEk3ZE6Zct52g5+LpG78Jjb/PLn5QpK4sw3q4qDo67zK3IlFpLR17K12SIcFzsDE9Z3Qiyqln78W3w==;5:ZDc6a22x76fEuUi5ERcenpVCYuhvxPQ9OVtCV+ebGfeLhGWwzcPMaDWxAldHr9/0lY4w10QcRtv5LcCGQp8JPw3idQCvca6Guab8MLl84hR2gYerklPkpcwz7iy16+lZ4ygZgpvUWQJDtzRXn2d+EaVw+qxbRDm+h6E1PeH56jc=;24:jMS6tz6WDi4m3uAsFUev5urTGpHSshcs+41o9hkiYNY/LqV6UAW7dBEjuzqtK1I9h9uJQNuo6AT6ESrPqq/2rwaBoDqnpUx/dwu35VrVjIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;7:EptgdoOBsSJmEu3NVie/+geCO289QG5gb3wZhP4YOhQoWTl/AhT9RbBOdHeBGsXIvvKZnz9m78SCGZcMv0K2dkMiep1ggoDY6TjfUvHX0+bpSpbc5p6/7ua1haasghrqe/A9fjLoBEtT1erfphcZ8LRI6N2kKTWA23DKrCSYNO+c2atjT+C+e2X5Mi/qwMWjFTetpI97tR6yJ8YZT++BEiVB1djOHA8ww6ZQczohPWgV49oOdI/jWnLBEYXjI2UF;20:dQcP/JZ9hGzxFoBzK9GRCdVvl4EY4XR0h9np7kwSzri/GQvaaKo81q6I8+nSBNIMzhKOV+983vf8rd/uxRR9w4/phJN84TIM3a6AhzcMTba7sP2gymVafnsng2E90yI+uEt+tT7CjZuPonfniK4uRCGGZ9nFb0dR8V8Nq9oHuGVjqe5FOGQXbUANltrAc6KIJgh30V4cu5gyPwavG1uKtkxhKDQjbt2zsktwQN/y4ITFjLEbHFlT+mvPpSb5gfMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 21:41:32.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcdc142-e388-41f5-1701-08d5d0ad43ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the AMD
IOMMU.  Add an AMD-specific Kconfig boolean that depends upon
general enablement of DebugFS in the IOMMU.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |   12 ++++++++++++
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu_debugfs.c |   33 +++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++--
 drivers/iommu/amd_iommu_proto.h   |    6 ++++++
 drivers/iommu/amd_iommu_types.h   |    5 +++++
 6 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f9af25ac409f..5a9cef113763 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -146,6 +146,18 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEBUGFS
+	bool "Enable AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && IOMMU_DEBUGFS
+	---help---
+	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
+
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
+	  Exposes AMD IOMMU device internals in DebugFS.
+
+	  This option is -NOT- intended for production environments, and should
+	  not generally be enabled.
+
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 74cfbc392862..47fd6ea9de2d 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..c6a5c737ef09
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+static struct dentry *amd_iommu_debugfs;
+static DEFINE_MUTEX(amd_iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs)
+		amd_iommu_debugfs = debugfs_create_dir("amd",
+						       iommu_debugfs_dir);
+	mutex_unlock(&amd_iommu_debugfs_lock);
+
+	snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+	iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..031e6dbb8345 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2721,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2730,14 +2731,15 @@ static int __init amd_iommu_init(void)
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-			struct amd_iommu *iommu;
-
 			uninit_device_table_dma();
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
 	}
 
+	for_each_iommu(iommu)
+		amd_iommu_debugfs_setup(iommu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286a0ab9..a8cd0296fb16 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0cc189..cfac9d842b0f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -594,6 +594,11 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+#ifdef CONFIG_AMD_IOMMU_DEBUGFS
+	/* DebugFS Info */
+	struct dentry *debugfs;
+#endif
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)

