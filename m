Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAA22075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vETKwVes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAA22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030271AbeFSQqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:46:02 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:13344
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966739AbeFSQqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crxZ9wk84hed7V+HvNZV4+QiABJEBzerMO9FjE/+DU4=;
 b=vETKwVeswNF6MUO3gck1gtNcx+/03W3Ng06l4OKdP73F3mXRiXBQtgGuYrl7C2daf973wRbaQWArTuuTE9B9P2HLC6NhWOICQEcsFaJpVCmg4EJgvR8RxSQwXaRkR5HvULs51+8iXq/m/lLd91jAvQbN2m9JAjd1aA1tRV3xOIw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 DM2PR12MB0140.namprd12.prod.outlook.com (2a01:111:e400:50cf::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 16:45:57 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, gregkh@linuxfoundation.org,
        rafael.j.wysocki@intel.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu/amd: Handle IOMMU initialization failure
Date:   Tue, 19 Jun 2018 11:45:32 -0500
Message-Id: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0601CA0014.namprd06.prod.outlook.com
 (2603:10b6:803:2f::24) To DM2PR12MB0140.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87db0e4f-3f98-4946-2995-08d5d60421dc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0140;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;3:wT59m6gutQHsGc9h5f5Jz1G/uEKQz64OJle1pwTfHu3q/JMN9wZp7m1RG7XF7ZUel7RV1SylJeZvVU4kzYUU9baiaeplrcr4ukrfDuxb9cV6TCXV2EmZ7TUCJcWHQjctfME6fbXSUpq+DCqN4ATkdqbLzNpNq5AlkAYpdJjmSRyaV0piessP8czTQRkp4D6o+VNzkd9hTRl8xw/gxWxuZmUZpN9dQPUs+nuMMnL8Mua0jmr88hYE2Tb7KhlSoOlf;25:f+vWraDNqyg5vZv+T9aaJS/5a0QPW3QT60t0qgfZ+49bx35K7VBBxJlFJk2B2vvOdQkbshnwk9KpwWeRjyoSuBlxim4Z/1XJBTHD9I9p7dthAssNtLXUMebBgMvzhR/XI0MCF+jCHP206jt6KSTRBS/RYNSyMx+aCHPd07QRQAuAx8JXKf/tlTHFV09TBaYa/5P2zV5UgfrySoXIOIOFL3AFPeCzTHavNVWwT3dzKeifD3CxjJT1LZPMCbCeBeBh83Az5Zv2k64D+i4J2e5k0uJD5BWTuXOn/3P/rRUwAaIGZDnAxN00HGh8tH8XgozXMCpaCRyR6a/m3qCIBVzSmw==;31:qsUg+ZjbP90TJS38e41MjHuEmkTBtAQt6UM3eefLzOSnTBWeyhSPFvGQHR5NI11ah/5MhTAzW9G3l1NCB55JxmlXtSFb3++fhyaHhfcB5CRZ1eMt4tGoS3JZz6WXcuAe3Wlpnhvzusd0T0W78/s747UePwp9dCFfgmAn0tIZuijzmW+Zwt1Xja+5PPXv3AtumgbyLpP7n1ejSGAsgBUvwE1SeVK/A+4xpick3U25cB4=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0140:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;20:KSwu1zfEZPBiKn6qojRff6jGMf+R52nWqvFWWMqz4r5ftawXKJH+RTM7ywnETHwFc3mAtv0pyjnr1KcHF8QnojlIxZyc2GfL94UY5Gmn+fusadjjTd1ny9icARCRow8Zqmn7K3pNfA1YDUknC38YFCE40/8ayXabE5Ac+x2ui8n531rAoDROJ1KHqAgYbHr/VRFkiOD1Ays1oji7FF6DxBbWncjPAqkNX/SADjvwNrzVfq5n2TS4GVHqbCTgddf0P5sFpw7CMWCCMZZJl7+BJMjVg2tbkXaXrGdNoaMD6uvm94XAJKy6Wsuhv2O/TmkBCzoSrW25Z1AEoSNjTJ2nJWTRx31NLTxanrdrMZO8k8kotWUhrtbRR2edglcX6I44U+3Ss515mwN6VEJy/cmVY/vUqBKeaxthiD/taFFC+QLorycX/pz5GB6kEaMXZDiFEP0cJxb/H9Ae06kvMn/fzyGsLm+GCH6e0if0sU8TytHzfXmCyoI6R8i2qNVyjTUh;4:WJjwEoLA3G8UznxHI0Qo4dSoNMIbB5HBDNhKhGxH5vuWL0xNxfzjlyrG1jRFYolllqCnyqIe+a2zLPdes1VlIsHboTBVCjSgEw04Q23h5aMTDmk/5w9D+cB07pltS9O6cbNM2zCU6IZszREfyydBCXMhajRIeTo2U42rcgOKM8OatF8ZK2+vuo1BQM83Pbmcu5CtljccXS2Sn//HejloVeUGPY9pUvdBsY61Kpvey3yJDPmpe/KU68x7CAvMdi5a4iMcQyBLWc5C34pXMr3Bkg==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01403BA781AD3545D2606D42F3700@DM2PR12MB0140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0140;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(44832011)(16586007)(476003)(956004)(2616005)(316002)(81166006)(81156014)(50226002)(106356001)(66066001)(47776003)(8936002)(53416004)(105586002)(386003)(72206003)(26005)(25786009)(16526019)(7696005)(52116002)(51416003)(186003)(478600001)(86362001)(59450400001)(486006)(5660300001)(97736004)(6666003)(2906002)(68736007)(8676002)(6486002)(36756003)(7736002)(53936002)(50466002)(48376002)(4326008)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0140;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0140;23:V4rRk4txq9XvqJBN/RzB7aB30BScOIAJMG9r9w0D3?=
 =?us-ascii?Q?9Ucrh3H65/C4P6AKTJP86580cTsLTD1fC0fF1/WemK/gBTLce6yFCOoB2lDW?=
 =?us-ascii?Q?Oy5IVra2JQlKnL4N1tasYeMl24Gp1lwktuwnNIbkxktJXZrdirqCztpBn5bi?=
 =?us-ascii?Q?9+lGEkIK7hsIAr0lVuhyCJpoMeIYnzCAgw+LVnE89kJt2NF8TJgfFvD/EQc5?=
 =?us-ascii?Q?DtnaxpBvb6xGOuAgPShuu9SGt7b+Ut3o+Gk22evFwIp3RNOWonY7saEIvBVR?=
 =?us-ascii?Q?7h0f/6EeZP3gVIba03v6mkU9NXm3zWQY3i0e1uwjfByW/b7d1BaTA4WQpJXV?=
 =?us-ascii?Q?UHMP1tBn1KjuOa1I1bWGdmTjibwFo1nCGnoYyqCy5UtP7Od5saHZ9Qobog0a?=
 =?us-ascii?Q?aCdPGFG4Wul/yeQn0VjAaMaimjP2BBwqZS6Bbg6V1IQRyaBsa2AoV3k95Ytm?=
 =?us-ascii?Q?PxPIh8pbzA4BA/qieLDKWItfQF/aLviAdSbtmrf5w3oHlqp3z759afndg0mX?=
 =?us-ascii?Q?8MrBkVmUN8dNoow27ocD60SYqh276MBsX6o7ZQVoIIehdJ/lyFRpsvz2VmKW?=
 =?us-ascii?Q?KOhTsVGi73wWyGV9Sh21bmNRp53+LQTbhLavQXBYRA1vhc54rIm/Rc3CRgth?=
 =?us-ascii?Q?+RP3iYoFHBTEV1DJnCNcBlMd/q66QQGf9GkJa40ITcnmRdg8yKCtruNRxsl3?=
 =?us-ascii?Q?jMIWlbekoUbpCwVnWZXUtGuwzMr2oocACCbsuVETKT2ECy5/3VaKe3PsTs0v?=
 =?us-ascii?Q?57Nll7W1hg3C8Qw033g7SNtkubT3EErcO5smD87vyuSCzCi5dZcwZAWWsi/B?=
 =?us-ascii?Q?sNCAeWimsTYvNv8ZyLEZCsrOUbwyt421oxF0sctnecXo2oTpmIhLrn6WBvIx?=
 =?us-ascii?Q?agXTRLxhwHRtcAd3FGp5k1SkppJ98t+IcxqXp34gwbXMWxAktpK6KJRQhg0a?=
 =?us-ascii?Q?34A+M69iuzn4ay4V7a8MW4OUn2tyhdgPczlDN1IdCi8eQ1zn6jKFFgNMcLRU?=
 =?us-ascii?Q?lz8G2S0U+DS+DfKIw35mOGwwPU4bM/fAXxT/6UqkxndozLcgU1mn5PkAPtCc?=
 =?us-ascii?Q?JFKscUCW92jHbJOLTCCn47WGqRPPPkM+GaSxNs3timlm9ysRzQWxBBpPSNmY?=
 =?us-ascii?Q?R+rnEJBYco8BvLKoLBgSSLMxWN403FbX8G/EGg5T/kGZv/yUM076xJl2amdk?=
 =?us-ascii?Q?er9xi0D45n+e88=3D?=
X-Microsoft-Antispam-Message-Info: NuUNN2mKuvW7H2xsboKTU1HbWV0oxlrMRmYtzaWP8Be0wGCMe4EtGGd7iCJoDs6jpc4SR625gnXR0sHK+MiwQGppfL1Q7nkHaG1+Nl7wayJET/ZOflbZsPz371WvRpIJzY6Z/jN0hrsqKjPZkf3KYDZlNuaMTkGh4CkwRS1accYn9JDTNczmgFQZS9D6eBFw6Lsu5vmAdP8Vs4ozYcrx4Xc9yQDmXVMfXYj2N821gvc9nPWJjqhVeSiuqxjUX45ePKJvFq6YrxmIADH0NxTEkLvX3oYi0PaHbQmLpx+xZtf/R1WRd3xQjuwzwWTqwm36
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;6:ooXJ4YwDB/ruOkZOcB21OqGfIEBa4EiHpTzlMlmr5PgclT07ALEjNnwoX88M5TBkK2+32x2Nix543dLCZDJaVJ6pMxHQCHdLwSkAG89NwR1x5jIsSsl1sHhQUcwgn7XeFhAu9xFSlxbJ3WyrzSb+wyvhiUBU73J8Evpo0aTSVFvYhvGG01H4uYXmmm5LZD7CgB4bSB4/5CtPALIOlf01jsvLmmzs/EZmcCA0Z+MFG0ov05DtGMQUvGXQmINqa6Vd8wL1YbOPOniTf/nIClL4qsu4OezdH5azFMjaqOe9yvSksSScU6BfHFcVOKXoQpb4d858iU3bykRUtvI3oHQ4p1XMDtXcf3CaoeyoOQXzUNMhQiPaL+oXLJaSCdBoRCOAb4/CdOgZ0Jt3b10gJS/AtvX3Nb8rBXSz4QsRTegdIbcWEbeO7w4tNy4XJ1kvuUvPmgUCEdV1rRjYCcsgLRLfmg==;5:liRjAe52vqvROkeQEhje+HZNA763pHNIXSQ9W7qrd4tt9uIxXi9BGjAk8bBX/7eTPRUlQWbIZv/KJ7nQv0Owtjgv/B0pLoi1ENp0YwsNdeTn5DGK2KoIa+dKRdEnEQWB+Rt2pQHVm1Nxshs+vrz80gohUyXssAUvk1g2H1NCnwQ=;24:k+yKbzE4DlzyhZGhuMHe5aD3U4W8r7uck7rEqHfQiwWYimL54fM0+8hnF05MAoNXkscDEafbl8BMX8qWtBzg3MedACNWuabhgTFZ7iapEpk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;7:zjqcqUBnDkOOpup7ZOaYxjIidpHNZIbY/TnI1+tU94lrkaHH612EtOWXg6HddVAjomAXPObdyNbS/3BpJFHdbZG1F1ABIbL9FHtxd35zdxShmhcIRJ2nhCGs+Pw+07FJ6QYSOhPLPkMveB3yZlrrXTZeMo6AydB0dJCov/RlBY71ieKN7B2y2/WPmol+XNSOfZmAVBM4N8LaRAplfqVFEUWT2kQwURKENcH8Uv9g9JCQy4T1W8kbJxZFbbAO29In;20:FM1zclPp+Z4D8vQkL7nKjL0/Su/L2EpQtz3yZ7gGaIQdBPzg5gBjVoe05bUrqiZw/sVaopwKRXaZIvDAFKp6YLihRo9cyyTqVUwtDD9DIavmXAnMk9uAuCJ6/P1LCW6nV3P/6e2298C9u8H2xc4gQFMOskbc4Jz+zc13JWjNQCbkbcCkpwopQAkx5pvP4+fY/PwvXR87GBzojjIOj+IVjvPluwQBI2r/2HcBe3aOhjWaiNYk9haQ4cH6W4VnXZSY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 16:45:57.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87db0e4f-3f98-4946-2995-08d5d60421dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, AMD system will not boot if the AMD IOMMU driver initialization
fails. This is mainly due to devices' dma_ops are still configured to use
amd_iommu_ops. Instead, the driver should retore the device dma_ops to
the default one as part of its error recovery.

However, other clean ups should also be taken care of (e.g. removing
IOMMU groups, and unsetting bus IOMMU).

NOTE: This issue was found when booting Linux with pci=nomsi option.
      Since the AMD IOMMU requires MSI, this result in failure to
      initialize IOMMU interrupt.

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommu: Introduce interface for unsetting bus IOMMU
  iommu/amd: Fallback to dma_direct_ops when fail to enable IOMMU

 drivers/iommu/amd_iommu.c       | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  | 19 +++++++++++++++++--
 drivers/iommu/amd_iommu_proto.h |  2 ++
 drivers/iommu/iommu.c           | 22 ++++++++++++++++++++++
 include/linux/device.h          |  1 +
 include/linux/iommu.h           |  1 +
 6 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.7.4

