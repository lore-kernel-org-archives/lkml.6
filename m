Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B706CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C825E3E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sNc7dRwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4C825E3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbeF0Pbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:31:49 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:37431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754448AbeF0Pbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df0cUYgXRkl6/nzcXbaxbIZKaYYw5fHq24tP0QaJvrQ=;
 b=sNc7dRwN2G1OnLde/aDLDaeIDV5M8oXW8H9emBJZ3kRuQWCy/pVwmtLbmteKxfrR+YXTQdxnJuIY6MsQjYRPsfhHyBG+HyE5sctgOGhSamFqiA6QofDv0wOQJ/vSOFhEuL5ff54qer0C1xV6S44iorouNoLqa1z2kfpCZMMSo60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.20; Wed, 27 Jun
 2018 15:31:41 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 1/3] x86: irq_remapping: Move irq remapping mode enum
Date:   Wed, 27 Jun 2018 10:31:20 -0500
Message-Id: <1530113482-85632-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR0102CA0002.prod.exchangelabs.com (2603:10b6:805:1::15)
 To DM2PR12MB0139.namprd12.prod.outlook.com (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 047a7cff-b629-49be-be97-08d5dc431532
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:SeURWmTtD+4I2JtlwHy6KlXcBWwW10r6aX1vCVvgomBwNruhHjuerPyFDUWQNfepO8XaEJLYl5JZ4bH1gfcEBfNzM7IPLkp7rP9Ymldom5abr3TMaxPmQtUeG1d8mCGqaawaHv8Qj0htTNbGs5n2GXug6ShPPE001IxNrJls4uxujW22ktBEmCoRuy1NSfMA/fjm8BVjKZo3SZDxuNSOGOh1a3/kb7Jwg6RqrnmUW0o27Dm5ydgsgPSLJJLEMlBa;25:bxESeSUxRT3f0cCWFBsitdSCVkiTEDMG98NvaPnDeqXkWBgiRvITTmlp9fMs7w80uhsgkfDj2eiXWln7aQnOMCSbS1Rc7AqssbPx7yiIQsX6miZj6072cosLsMEzjKuvs6v+gf2AHedUkgQZH+HAT1anQHOzXw+pnm9PlP9BsPwc8JnUZV+6/C3obB3RPM9wVhPBopWIdhPUNCpnD4p5czqeiHp3Rq10D3VVWyx7o9M0GwGPu7a6rkd7ZbrII/Up1cqVHzqPjneFjrliIkn8Sta+wl9e82oAY7mJygFPyKqxs8BMhFib/Mj7tRg8N4dZSZzbquQovRy36X9i04VegQ==;31:y9HFniBcQZlNF6jEzI7fqTfY+oLOnWuXEUCCTjZScsyApYf5sGp7SXfOxfLIQFITnsDrbJwWEPPCVQ+NkgkDMmWZkVaZiFoUEmtEtS7lL7o4bPc5BgzHufaux8r+I/UWtvr8vdT9u5Ggam5t6UQ1u7xD7x0K7CsApc0U0+gIgnL+2fqh1EZ0QW/X5vz/4MNQNyPER7ht/m7J6sGSEmy9yfvKWLTj5bNjtDpmMhtwngY=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:mLTd65dGgZt5vbldEO4SdR6DUvtS579gJkNhXfY+atQ/GerxHjsXVwmBDRHmC6kcm9sJyEDm5djWz5OSX9QmF7e1FATwNsiRkW3f+qvKK8A0EPbi1M4vLssqK+NPE6VhdhIExFn4DDWGKexd71h5WL4yYcRE1cx0QxN9LrzbVeQ+e/AuT2eEFqdslfo89N1IvsjIDWJnntYKDT8ST0xACLdX4M0JtSvwK8RFAAyohkmOGRrvJOlzxnYBKEFBhFlPsfO59RogBfP1oz7L/BQUWgmPW1pkpf6cgYKE0eQQ29wLsdiN/SPlvGVa7dEEDmDKULAAJEWBMy4iWM1vRQreBpB3xtyryWUN40uh5XtsD+QJDdccAD3nQCC5Vxz814AivyL0fFeVEHK6l7URcB2HPG49Xm5Gx8JKn9NKbIVWkse4LgSqJivuPXLS8WlyCVgdz1ssgyEyKiWH7QBvzFvNgSncxDsrFAx4yGs92g+JyjLl3e1XiZdIPmu1BShqnJWn;4:PwDYlkOHYe8ls9JzN14TVOAv4KiF7zzwG+R4AgGvTYoWKUCjwMrt90vjRG3LTYOcRrip/ca7tCEnxIJu81WTK0TVfxJQKLe4bBkArvhMqv7VLVSnDrwHig/RfRgBHWTN1/0wIbRkwPr40q2VWhaIo7jHBrfg/Z5sR2DvS5rTLHw/8EO6bE26mByY3BIYKkP/PI6PDu3IFVV7dscm4KL1exMEsOKid9R4Q+cEESOXYSUa9o6K51868sNC/wnmyjiKWthFiVcaJizJ5hEPvfxQbj2PzAsWsK2IMyLCFxr6dsk0cZYpREhauTwUH9Lh3ZMM
X-Microsoft-Antispam-PRVS: <DM2PR12MB01394AE3DC915DB262AE9837F3480@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(7736002)(76176011)(16586007)(86362001)(44832011)(72206003)(316002)(5660300001)(97736004)(305945005)(53416004)(478600001)(54906003)(105586002)(50466002)(106356001)(48376002)(81156014)(6116002)(47776003)(26005)(50226002)(4326008)(486006)(36756003)(8676002)(81166006)(186003)(8936002)(53936002)(446003)(476003)(3846002)(11346002)(68736007)(51416003)(6486002)(16526019)(2616005)(386003)(66066001)(25786009)(956004)(2906002)(7696005)(52116002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:vKI7al9d/4hSRm7GcAKb+0oz9jLv9dJdv/HuiSEQC?=
 =?us-ascii?Q?F/5M/r9kTZ3BpIdaUpf7HcoA1X7gPAbg2J2hD1+9gAfb5CcYF8cJKN7dZ1En?=
 =?us-ascii?Q?l9Ix6naKV+n7838rJ5UHvpUzRFSqgob6N0u1BhWCoJCLzOl1gQWgW+ZHobUH?=
 =?us-ascii?Q?pFhTU2rJVAhuaPvhjdaWmxrGZhnxFoeLS2qvnNjZowEwnWKqF8UTZ0Hhf/fO?=
 =?us-ascii?Q?FOmD3BIabE+Du4KeL1+nWVOEjPUwk9rzQICBByMZLT8hKjVY+G87pJrsVOC7?=
 =?us-ascii?Q?8vRXhRbvpSR+VIy2E0Ad586JchFznWNbYOdxkYleLNWz3v92TaUxVeRzD5nk?=
 =?us-ascii?Q?ME7FV8U23ohK9r9TXdP9Pk2llcI5iD5CC9j7tqO3Ivvg3zyUzonPQPVyTHSV?=
 =?us-ascii?Q?/M43ZJjnL5OXigll1/pOBHYhhs31Z6PLvMf5A/9SOH9taoq7XaPLv6o8tVcB?=
 =?us-ascii?Q?Dl5UjfdhKYk/zetlpWgLPedu/qlZQ6Nny+9UrBp5J1YDZ26GCZu0d10kOPN0?=
 =?us-ascii?Q?ISIeV+06SnzOorTzhNIpZvomHaO4WUip/ZgijZJjQcc+MwwyJf3ouiG2tzGy?=
 =?us-ascii?Q?IUhoUJ6k6eg1MoPDVNUUs7xigiWoGair1eyxmNy3kF/zLpXke5z267tZBZpd?=
 =?us-ascii?Q?O8+45O5VCsJJihLJuBHqqfaw3K9SUkA4f+nr6ZXIMscaWDgNAUFvMPli8D2q?=
 =?us-ascii?Q?qx+Cp/YBRdr5A3iDaR/LQ/cLF5YEjAMhhjieAVRRKeDXcQbSm/JQ0aDCFvHQ?=
 =?us-ascii?Q?xbYzHKr596tQROvOhVBUdeQxfTwFwiMDH43pFClglA3/14pi4hHnalX+TB7P?=
 =?us-ascii?Q?tam4ejcM5tdpPWhxRx2zdFwFePZixnNzyPlHm+ntGG7zjCTo9dwOhTmcmTtv?=
 =?us-ascii?Q?xDKg98biY+Gt/iXtJqot66sABmMwuZA0cFMWXSwWmZ2b2aVdSYAGSX/kBq2n?=
 =?us-ascii?Q?ETjD97xU0BY4QwyQu5cJvTBYVXQvid+Afd3gq8OUZGL5leWLTHSGXD6HfhvJ?=
 =?us-ascii?Q?pLrRjShXvBLkfDqCYyEEFUOhq38w9XuFbJgm/y96G2Jn1d/X6xxc+qpUlO2w?=
 =?us-ascii?Q?42R3hi1wfcsmeIrDcagqc6z52ma1yPVSknV1DTbxo7+CZTMcJix2H6/fsKdT?=
 =?us-ascii?Q?vzVpvk/I0OWgTSGFTiCtvYbFROO6w93Y4nlS6vq/5NUVltG3QSS7ovuPtrYz?=
 =?us-ascii?Q?wxUsMa8l9r+CMHBPIFUHjC7FkyH/nAio6Pk?=
X-Microsoft-Antispam-Message-Info: k19rEwZ4i3+J8TokasdFEKDzkMWmM3/PvwnxlALwEE2vsC8mTgvwFhKMYeaVE4LVbOyL8Gtsi9VxPJkMB0FmUUPFBfxlOS2/9rKodM31wli7ic4UNuggJftaHBijQY54pJkKR5qguxPJdPr4KoZlRd9On0GWzRimNvPjdwR7JTI4lRjNxym3cStDJdkMtFT8/2118D76SDHFukJKWlWc60+VG72YsPgIEfCl0t13ju0zp1/ii7kw5SOo08kkL1MRV49Af44FL0QNduqp+6qhI7qYeNGOsSUX6BJVrMNhCuzNDVhBNHNDn0NdZg70iaHPdPrUdWSuh8JPR5bsF+T5XDHbE5+XfNng5y6re8cQTdo=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:iTJVMYdkCKS3+TpSRECTHfiGX+3dM20UnIoHcTjWpVw/ZVGPVaAH/ftA1ZVYJ6bwvjOQ8ZzKugJ6/5n2djctehKZq/DIyeAR7f1tmRCBeCu7irq+1TpPAT0d1293jOiiAxo2cdwMA4yr0cc8gR9v1E1bW8wjYxG0FP/gunY12WDhulIl9TPHQ7w+jmbKt6vupRFnsBELpB85tKTJwpYdCA0i8ym+ACaM4qpkkNHVgJaD+u0EsCZ80h22RUCaEVSspvyoLdoTE+9IU5WStbanN3SMcyIMKKeeeDT/M5KjGPOLi1lX1fuDOGLRja0vikAYkfpyVflRiNvrattKh5xDPS3YQU4OV9DC5pb4UnQdd0Huxo0sUDAYcH1iBqNkaZOEJILZwclcYNsUq+iG8unwcDRNsWLcqgm1bwuCBLXbHP5v7xNNENe76mv02inLudoB/qmLtaJT0KBJqM4dD8AL9g==;5:P6KDz7vlWJ8UpjQh/YqsekPzlM9txY2qXr4+sDV4DXqvAhSdTPjKbXm1M2iiizgzwztinRF+92jbHc2NEaFcX0agUav0VGnn907hzBrUIafcmZP/J7+Gr0SmkfUH1tEEZfhWFT9679yKFG6WjMHW1kA4j/uj/uDHoB14YYKv27I=;24:wa/lGUAuoQWwTSEbXi81tvCtcNrYB1537PMPOczgSpZiU/MNBhGXge1EmtbKnd8ccBgY97UOF7uO2UWyU949yWlraN8CaQuFgjFoHEKKlQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;7:hZHggwtWy+v1Q8O1vARl36vMSlevpITdvszKFuDQD4G6yPbi7KqSqbclDcHdARUE+Wjg3+s4+mKZlpt9tWifXy2AL+lL5unHaZjwz8qIpee4gs8m2bcp1ef093vJFPtC4zBBsjSxxcKmzJY2y8hWHUcRFvoQpm40pngDC0nf1fpkbtAIM2n+c1pVImM2u7GcM36DsI0yoHbro6c8eXTm4B3vltb9AhHml4RBbeeytNWyg3TkRavMlrmkoNVdgc/X;20:a3AJNt4WENnQPVE1vUEy2XzWZLqTAG7h1tRdAAMDhCSGoHtadjIScsqL5WawA9uXoOgqAMutokXUhFAmrNq7BAr74mP/p0GG0wuVHcMbfDb6lv0XJi051Vlf/1Sar96bOwj8vpr07JaWvAp35Tq2tM/uqbQxerhJdrixWsl9JOgYbo1Xo/u4a7hZq0v92YlLMadYEC7tuXLE4wchdcUJ2IxICqptAUdyXKY/JoT8LdL+eJVFiHW+gPVnTo9rYrTR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 15:31:41.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047a7cff-b629-49be-be97-08d5dc431532
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum is currently defined in Intel-specific DMAR header file,
but it is also used by APIC common code. Therefore, move it to
a more appropriate interrupt-remapping common header file.
This will also be used by subsequent patches.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/irq_remapping.h | 5 +++++
 include/linux/dmar.h                 | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 023b4a9..5f26962 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -33,6 +33,11 @@ enum irq_remap_cap {
 	IRQ_POSTING_CAP = 0,
 };
 
+enum {
+	IRQ_REMAP_XAPIC_MODE,
+	IRQ_REMAP_X2APIC_MODE,
+};
+
 struct vcpu_data {
 	u64 pi_desc_addr;	/* Physical address of PI Descriptor */
 	u32 vector;		/* Guest vector of the interrupt */
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e2433bc..843a41b 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -265,11 +265,6 @@ static inline void dmar_copy_shared_irte(struct irte *dst, struct irte *src)
 #define PDA_LOW_BIT    26
 #define PDA_HIGH_BIT   32
 
-enum {
-	IRQ_REMAP_XAPIC_MODE,
-	IRQ_REMAP_X2APIC_MODE,
-};
-
 /* Can't use the common MSI interrupt functions
  * since DMAR is not a pci device
  */
-- 
2.7.4

