Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17854C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3DA2463F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PxpOCqjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3DA2463F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeFVRCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:02:30 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:58464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754593AbeFVRC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u5rIYw5psk1rGVlXdA00NGbZyilnA7IfgQGpvQG9Pc=;
 b=PxpOCqjrFSVYmeFWhc7n3dXeYPmplGPQSwZQpEs9SLLMCHylMK5SVNEWKQkIatkHfHmnhviA+jhgm9eR1mu06SJH81r+rjxikovhH53yY4ogPh5NajntIIvggQlYwVoJDNi+XyxW2S0p5ZvSDQ/pLQjNSMOrvubxpakOjTtKXqg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 CY1PR12MB0133.namprd12.prod.outlook.com (2a01:111:e400:50f7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 22 Jun
 2018 17:02:22 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/3] iommu/amd: Enable x2APIC support
Date:   Fri, 22 Jun 2018 12:02:04 -0500
Message-Id: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:805::19) To CY1PR12MB0133.namprd12.prod.outlook.com
 (2a01:111:e400:50f7::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d344aee-0109-44f8-33b0-08d5d861ec4f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0133;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;3:gqPBIPUYE1hpHA7WT3a5jFlKqLIg9WB77YyjbO8uIuShY/lNVgbKVc5K+2g37nIjmXDKd+ffSpWyIoyNhA/Cb8Dd4Q2yH0dzxnyF+Wnk1JskSWrwV7HpFFnqYasAOTtawr+bB96sDrjiB3ESJgiGqbHv6/mTk8TDZwxwIc0uxPezUEigjjqr6zakDe/AluqoZRcufPpH2eg/zDcrBBt8JCt7bslJJkSE2FRDBqtoY/v0b+Xfqtchyk/S1IINeKXi;25:RtM5F5iJzYiF3uTUbOSJvEe7iEmMVB/Ft+lP0H+YJS/MpDDl11HmXL+IZJrKqWpL4V+hwVpWCRarmXRn0isYyXVC5LzUl62Olds99Q7g/GZXn7o8JLQuyp56+dnaLv54wZxQLeODV34YAaMVGb/i+RzbPntf/FwA1usVU/upIpgnWvF7XoBWim08MzFCtUYpFUbkpFl8qaVvxw/NJy8Ww1UJ85yN95JcmvekyiBwx01kKmZwESuaiQ8amwGoagHEB2ep2EbD2Haj4+H4J/XlWbq4K6xBBoPC25S4jdZ9Efbqz+qkQpTvQfb9URp5vc5EVLh36NQwzKmB1oFdaugomQ==;31:KNMN6QF0a3Gpy2WVHokRFEkz44M9jX2ZtFN27pilehO89dCh8VvWF+ltRuMBgb5B+phgifKi27Od0dMuKsIix8mx5ARr+SVkvnCaYg1kisM21XhZFOIJKI5STgLp9NRjAcZ9Apfzbuy0eEpYO7CDh4N0e0gsyJr72xU04u9ayYjAdm0Ej3kCIi2PcWFKz60OAoDdAQJRFZAhrG298DohD7CJ3+gNGZdLg/iroeQDJy4=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0133:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;20:a9YCLNFhbvXTGRSKVX8XX0+3xZv42Ei5jRZSGnNpUP7VJBkKK4olhA46CeBEGAzMMXhKY21H+bdVSBsLzkFMrCVO7/bEAfMZ0TB4isXaPyYrrCTKFGCFppBelkMdpdkKApYZi9PQA2ymg197uhD7uHa4vm4sRcU6x1uuM8T+hMLEhmrMsRCJmeA+WlhQsPDykYzcZ153B7vbn2C0vv6FHEIpDQ8m06vEp4AUJMv1pOJf6STQSRYXHD15ltW2OuJ3gNhvydPsWo9InNef9YPQaaIUEv63JO+VIzymqxKZGy1uTpz2VEqq1aJOeNjgnBOs7IB02OfPtd0adMiM1bwfir3fKpcRL0Tc5P+WHguN5gy7GvO4fXgs4dzNO8mPylEpvCU8Ti3w2omRZXWIy3cdMkA6ge4nbSMkcz85WNyg+ih9UbBpMcRMiLdjltbpxFXJgE8xqrkHSuv9ivezEl0wNukcfH8Bsu+xKUpNRJKarCccuwlrI2BUQBB7FbL7Xrtj;4:KYs19Ihv6QsQ54HBTtn/bSbiml8EY/zgGTwkqZlxgG7T7P+Xm47jr/zdGfaSgiWRuhhzQcGfS5LRzWIQ9jz8PV1UFFbbjGRXbI/0ZW9KRKVc1wsUcP+lF1JB1U1lfmFzOA34Yj9fmwRlS25NVtsuc05jZdN3C0yZnNHePXGu/IwI+d8SivcNGxx6GLKDAvl59b0/5hPjnjkagF4wkasOosPUAgfzm8QZnY/o0K8QltQFrqJXDiw/02tK48CjkFtan/Y3clwV4U6xOFpi82R+gA==
X-Microsoft-Antispam-PRVS: <CY1PR12MB01332DA3273ED72533379168F3750@CY1PR12MB0133.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0133;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(50466002)(7696005)(4326008)(186003)(52116002)(26005)(16526019)(47776003)(53936002)(6666003)(25786009)(386003)(59450400001)(5660300001)(6116002)(66066001)(478600001)(48376002)(3846002)(72206003)(51416003)(956004)(476003)(44832011)(2616005)(486006)(106356001)(81156014)(81166006)(16586007)(6486002)(50226002)(8936002)(575784001)(86362001)(316002)(68736007)(36756003)(97736004)(53416004)(7736002)(305945005)(105586002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0133;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0133;23:syFjz/vAjt1vltm8CfCShF1QBbr+fORD3aMe08K0E?=
 =?us-ascii?Q?X6j1PqvWe4Tnz2TpQVuJbGnfGMRh40n1zSvkqA4f2wL78jyGDCbMIvfrRjur?=
 =?us-ascii?Q?H08+72UcNI1CQgkfy43nwrFG7Pr7NNcIu/4dVBSH6oc/J4XTywLAaNCtXd/P?=
 =?us-ascii?Q?RNWjS7QWmU9XbaMg985oA/dF55uPdGNQh9fL9hmddWXxxDANpK2PdLvzApSl?=
 =?us-ascii?Q?yyuuJXA5qGNdsb+FAPr5OM3RPrwe2JKh085fXyYfsMtAIMXedIhi2GoqkgoL?=
 =?us-ascii?Q?JdcLhJOTDG+MkWlZmdaQpRUW7MoeSwBVM12XEcgbx17NOLp95uLvPNUMINzC?=
 =?us-ascii?Q?QGtfXpm0iSeGaAVkfceqk+iKd8OeMSxVHO72K4pq8HpCDCAf7P8XfYSmXRPF?=
 =?us-ascii?Q?59CKt1aSVyxWlXfrBAzZ9j1QHqAdYYMbI04u2bVzHJFRPk/3j5cQTbTpc0bQ?=
 =?us-ascii?Q?LXVc61BsUg6rVvdh2KLMWmE6ogDcz0/SrW+Fau2RGmMZga9iG7i9fiTXk5EY?=
 =?us-ascii?Q?soWbRPsvI5LAdKXZ1QmZ1mPqq9G/6ZjvBEroMZ9BE8ElvA04DBCZVpiqPUAS?=
 =?us-ascii?Q?bIahhsncTvTiPhD41GPDY6eT3PqLcmuL7UVSos5o1VowVMzMGKjSjHAYefI2?=
 =?us-ascii?Q?lfQG90UvViheXKWsfE/DUWrPXloq0H57fEBPX/dCPg5auWTpExvgPK/HaJKN?=
 =?us-ascii?Q?/tkqCqao+PNYegvZIOS0Gv8R12+Ozrp5+WyBWE698idMLtYQ91agHBnKG6sB?=
 =?us-ascii?Q?zTE4vhWZtaV8fcw3XvyNxgR1qMil/x/KgdydDAZ+P1tv6zPUhtjPayp+4S+B?=
 =?us-ascii?Q?L/q+LDSfrAcs0V/LT1lfbgO29MrL3e6S9P2yZQr/BxiFi7ouF3ssagAHBQqF?=
 =?us-ascii?Q?dP0XdlbVl8ZRLDgJj02mR+NBzoRvcYfk9jpcrpolD6iVhwoZ5+AX+rfE7oR0?=
 =?us-ascii?Q?HaUlxr/pEKoEWEy2HdmNudUu5OXyxZIBl8IpFHaqUhd69G0Xv+IAkVMnKMCD?=
 =?us-ascii?Q?huay9zvzhUM6iHNr3Yqs5FQeCa4+sVZWqcWZUPNcT0MAd1xURoHKlzIf5fCw?=
 =?us-ascii?Q?krK+5CZ/8KrosFd9MwWgoLTADjI/5XL1y3HhiZKEC9SmNHmb35AVkLwSJUPM?=
 =?us-ascii?Q?P7Nfohaw9yw4eeqxpxgOS9OsR0r25BXchyv98cxJjxu3IEiT4X936DZqOpny?=
 =?us-ascii?Q?tyJIdx+rGOQAM0GI/WBiuZhNiuxwp7VQnyq?=
X-Microsoft-Antispam-Message-Info: wg57zj3UqaicEUtvPK7XH7BIRANdZwIrmPI3pO8E+497cdprYSiYVUr2xNI1AiDPmD9LgmjRpdRVKXm2mtihNspK31kUKOmXeQ2botKgqYkdmRysivhIzhFsK4gDK3SFEfxNMq2Lsb21b5kNT11IDQNKfmIQFeRgq54qN6mjFtwrRXYd/gaHQkAS/fCyQV+lF/yuuKJWlDZJw05bWwBV+LnEN7ZkZH1xQUFjKaopQY3pI4P3a51VSrOCa44nFPyzCOcCd90MMu/cFWX9pS8Zuop15QsHFfGo7zCHRX/YdkQ8yzfr+UmcT+4L8cDtzAXBty8n206Bskxq9X75FOnj/PgfDxTTbX0oXJNnToemufY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;6:aYjr5iKT9Lx414uVFyt1bkG7Q/OmOGg6fsJx7NXV7O0AhP6IteHYvpZrAoV0eLQD4nO2LPvSLRGWBKrmipfAMt6VEjmrse1wNFWdaiJGsCkQdsB4CEyb3QOT8JN3r2HlryRRlv15nry5q1tEWDRlLCqa2hjkojRk+rmvtM3zU0eVVNOs20m/Zz8QTg4QXW79pcJVXP3DInYrZStPEC63Y2zJwuYN3QgcTiNVD0P0pTvIogcX+Ho5lqtZLV0V9gy9/TmAQ/gqx/jH3kbYCOMJ7afzLA6mrmnnDjCLfXk7soMgWfR/PxXSmIWprNpmAPV5ANQuZh3BhaW75MLLXaP0FkJPpsjhZ+gHSdOhdZ0rZUyGeder06hhTmta7dkqyPdUFWCLjR9Yl850Y2ZNn78lXjK/8w8U+mXpnQSXfE8VhLvBtE2HjIqndEP2y7f4DsIgNlHaSa2tTBnEOhnoCgQvgQ==;5:nNQICn2sbuzn1e/rYu5bSnLG5p2p63TRKm0zVj95y9+tV9GAoeOsjwUfgvJbyltG4h7o763qz8YZG1z+M4liISmPpghrJZMKoWXhniG8lns5FGfyR+m2S0ZW38a4poguOTamWapAAdZ6JP1DMhk/KTSsYGsjt9ccSyjiwrdn60o=;24:BbyDL2a+JaforJ3/K6P89g4C96QcKgQS6/TLor8I5TLevpwhj86CBOLN/A48qjpspwm/CyLOIT2O5aqdlMtTjAxj+O2jqwYGkeOBdiQRveo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0133;7:NUoOZQUiErN4mddaZNbS5I8YK+cpxBKOq0DIIivxmUMZch7cfoG6hd4zda3cByz2Xk12liVleuMwcr/m5UMj+5++BiYNbhEeeCWsPm1IaGHE2YA5rb/NryylDdrgZsPHfupg49r9lMW28P9n8aRLN3EjK3jJz5V3aQ6xgBksmragTIcl190nUbWaxTE3s8Zfr12ujh9kXV3sNT6CGNvMIX5Cwrav0dHC7tclYxTD1tvXPjXthr33YAyNkQFe4gTo;20:jX7jnpBoSvn3Qjc+ydw3bK042qfUfrjJ46EISfYqniAKS99kJNaz1Jvomtdu3YuQsUgT17Ypvr5xEhqqwPtS6q+fv9gfNlvDh3itF+Bx5oR+kQjJ0QgJgrhmUbvrtQWA31R2UkBAWOs7u+1Lh/lgNrCb7VlOd9++I/VaVdz5Pz35S8QqvmTKq3Jx5giDCo7vqKLLIFJukFbkQ4qP9LpZg82g34Q+xqlopxgSrhvFGPrQGp1keydnbTR5Mr+zZ3Jo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:02:22.6380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d344aee-0109-44f8-33b0-08d5d861ec4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0133
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

