Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1842ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DFA20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WXrcwMms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DFA20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbeGXHJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:09:05 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:40352
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388207AbeGXHJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/AecUUhBEkyM7g4ZWmiNjEgfbASw6v9SfJk0/gugNA=;
 b=WXrcwMmsScHQMvG4vbwWKuR4Wiwrv8x/FaGg/uxeuGP52J9Wzs+iEqpCuJ8RGNPQZoEUP38cwKVvevbWGqMf1vTxLlr5lii/oQQqVBwY9LpkOtxhgLohjLF8eOguIV1e1BeyWHhhTK5xF261PPctkVqHKcSN6jDixuDuB/Rfkjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2556.eurprd04.prod.outlook.com (2603:10a6:3:84::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Tue, 24 Jul 2018 06:04:11 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH] powerpc/e200: Skip tlb1 entries used for kernel mapping
Date:   Tue, 24 Jul 2018 11:29:45 +0530
Message-Id: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::19) To HE1PR0401MB2556.eurprd04.prod.outlook.com
 (2603:10a6:3:84::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2dc4c3-24d1-42cf-2e4d-08d5f12b4764
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2556;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2556;3:g1KO+6cDXkcgwuxQJlDEKQu6KyFBQ5yoHuNYsSfoI+KfO7xi2HAws21Lw0/qV+Tnxei7cFey/CV6NUA2jHUMmok9iEzSZduUYdiGmp6Bu0rGkXPqUaXNmqxRoExDHQ/x+AB8jj9anownLD0s+eKLzj05TrlfRA/IKsaNxujU6O0Xj2hhvNgj7YIE4guVHrqldyHNRHlL4T1N1KE8gY3snlO9IwoshvRS7fkCJU0BWlbqARLXEjUyYruGtsyPK8cu;25:iU+FM7uUQNbLQJg6HwdFQpzdbFT/vUksBDqH44NaV6YdK/EzGtgO1e1xfwLgpeY5Sj1QadqIcH5LTMoX8Qg6kkOo8DXNWQZZMV4sxdsXkIJTjFAI0vKWj1CarBX5iJzjPnEaIlaYeQaeqsAV+ZpVrH1ZrQhLxEzVAMFMa3WGhSQX2h1pH/WclzXSL0o6pCT6Ah8F2Hx6uM2Sbt28LgXVVTq9mL+dqrQuZzF3lORiasRQv2y4R1blNCYH5p9R1+eMzulPdBEldjn0pka9lTOFzy+ImWOVJSlxB+3cO6jhUch8k5YiHddDNeryi+A1CNpm5Nah7FJ6LB9BoCSSA5foqQ==;31:5g5lSoDn/TLLn/RrvMg7L0/eWC4nAhi0A/CXSIdIDNOuRtmGCnKBmx3P0CuHBvtewSYRAZwGWrhvLHyiq/GRcem/jPHLfLV3y5ekDFC78Fea/Th2eW403PAM6WdSyw+M6pcDjlOrxeOf40bqhA4IS/hbgxYs1WA4IAq+IBSfUPfwn5iC7d9WUuhAT2y3jFlCS72yWcxG+eCWrPE4eHctjpRGwX7tFoZk10+HLxlv4W8=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2556:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2556;20:rVV1Pn3JhKPi407IoYPmYtsteB4OSSxeHk2zf2pcCZgb/unKxJaaHANYjQDrnOnczyr4iFitb4SVL5s4MtqkX+DD7qOzNrcO+7lhKIrbFrB28UzMKKlkAG84nybOPj/IbZBXnwUxs9IJqSWWfy0Cm96MAZL/oo3QuxhjrqiYBp4TCZ4GG9WqCPuJwl9u+PmMf+ApltigkQ+dYS+hWYPyfi6WNd+2jyU8P/eHEC3at6fNGP2QT/duGFl9YkPtUX59Hs3AKVssuTLUVgFHD92OpS6uXjq3ZKjX2378kCp9zX3Ohjs3uorfeGw/KIS8hoKZOPQU7CwxHiWGTOMPcrBd+bdtm0Z23ZewwWmZ4f072hSiTQPkI01aspOSAt9H4GZoni+OfuGl87AVn0LvJSRkkpwgL/ODOe5TuR7507BT4DlublA4aQxo8Vf8LcIMBypkwdvDyqSa+7X+L3n/mUVCWNC0sZ9mMFalK9GC2+Ma4iDEbJ4hN+tEDkJSgg8HO059;4:hpFWqoHVFWfUDCUnkXqgCCAFg5cY9OZBCLdgDoR1ShBYPZyZswcMaPoD7x5+eh9rPZIa2PfD9UMgt7gcaLa0XTsfMxyZ7EWeRCjthf4zMbltECvRIojjjcHT85QrrM3SmlJeSvtu84RZsQSRyMDAvqXg2dOILmUZpV8dsB/BLmDdCEtfQ/9Yb/o/flWfFiQ7gXaSR+jizbiPLksY7ByNtsYb/g4J1cSUgtGJSy9O3nJw2y39R4r9QnQM1FuRvMLOmhcJBL6cMLiCENfjvEzW++av6NixLJRjw3xwsiY5TaP7yw7tSlyADIZKqPXhqUPI
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2556115C98D92F321A7184DC9A550@HE1PR0401MB2556.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2556;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2556;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(486006)(66066001)(47776003)(476003)(6512007)(956004)(2616005)(50466002)(48376002)(6506007)(25786009)(97736004)(4326008)(16526019)(6486002)(55236004)(386003)(5660300001)(316002)(16586007)(51416003)(52116002)(8936002)(36756003)(2906002)(76506005)(5009440100003)(105586002)(6116002)(53936002)(3846002)(106356001)(81166006)(6666003)(86362001)(50226002)(68736007)(478600001)(81156014)(8676002)(7736002)(1857600001)(305945005)(26005)(186003)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2556;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2556;23:0U58MBc5C4qm6G19bwa9hJPqus1rrsLMZBtk04B?=
 =?us-ascii?Q?Spxd8w88jT+4SYvCySJboaAwtftReWgIgXB5JMx94PPtw6J0AVqidalpU9T7?=
 =?us-ascii?Q?l7V7PE+pXdfWGTL8ZqFtrNlrWMwuQ91O7+mpuBS+/ZQgPqCMbI+rhxHfG0fH?=
 =?us-ascii?Q?ZIU6NzrWlumrFC4dsOyOWKdDnZwV9p9ur1xjS94Rtrtigm7xK0RKSR9mwOC5?=
 =?us-ascii?Q?2GLLtPjOXJFn+tXQXOvcRqeA2OPSZEnuwM45OXlu8I3b5Hwq3S79q0Dbk4Il?=
 =?us-ascii?Q?9HxPUJL/noML2tf51bJlD6aaN5TJ3XKo8G6yJi4CvkEygxao38pn1d+d85ya?=
 =?us-ascii?Q?JA1gY5r5hmXrchze3WSf3ttdJE+DNtEmEsFPWpmeBf6foiHQZCPH85l0kxKN?=
 =?us-ascii?Q?yWH8Sgez4Z/h3LgHyfckwvMHhBi0DDzHp7l5Xi+BURh+AcAT9ChMLOoW/CRq?=
 =?us-ascii?Q?cl7cM8T3s2gbv6Fvx3UO5UxcCfshdkD8W3kr8aBvGb8Y+erBH7Mm9jtfJoXh?=
 =?us-ascii?Q?iNYrUuImFlk2uoZsUqs2+miq+5yWEnYdKq/OvLrUzEFYeGzkHGWfd0LDjfAR?=
 =?us-ascii?Q?cAbP4vQZAYVNvXQxvWGBG3YqnYBVN+I9KuW1V8oXrKtw9BeuTQcPgq2Cllk0?=
 =?us-ascii?Q?f6KEBKgn33CDy/sc+oiXTVLBHjijm5q0mmHGSeva2ckL/NLGDRYOFoOrYSGm?=
 =?us-ascii?Q?CM3sSOlKe+u6aHCNa0JpXHHXJkIcrQtvWGrr9NXH59mkPkyUE3LwPl+HhHFC?=
 =?us-ascii?Q?+bs1whSMj86XuTtDERk6GW18EJhjxI69293buus1QsQVcKqPGDFnG6al7/J5?=
 =?us-ascii?Q?+/GW1KXH0A9EJQjPGxPGCCd8hLk2eO9WsyhxujAHbK+rBbpPkhX2NYG9K9YI?=
 =?us-ascii?Q?/mQfZxrSGbgXzK1RLbVc50H0Rn225db/G81jopChIIyzPJOwVrAA+zAZOty7?=
 =?us-ascii?Q?Pzhhq/u/E+pGTZL3qWbv4zELI/SCJT7wdmMCnZmMrAN/q/qi24O8ryw4tu/A?=
 =?us-ascii?Q?w+NZRZF7WAwFARKfA2ONUrNkNMjQ3e8iPOnweAQH0N2ZECcLMvyldyp6isaK?=
 =?us-ascii?Q?ajIRdfok6ZpR089pCR2Tis+MC/tsD1ly0B0+ligIy4aqisnxM2cBRPh4YjL+?=
 =?us-ascii?Q?CmynGGZCrKHFEjfCBhrbiiQYovWrVDVAr9I8Migh3CvGC/YuQrVo8HOwvXO4?=
 =?us-ascii?Q?jHZVYjDS6dZEc2ycnKxZefhKxs8DZXQtytgznFtVAIJJEJLfyDR6H8SxHhA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: UA1tXXUoikY4d/BwplKj8MmmIgN/7yO+AF1dKoGPR/Xqnw4yM9GmciTyrjB1SrcXmChFWmMZ2LVow8sRb2LcEXMVZvY/Ncs/BRFHnGUc56p7SoYMUZASIUOFKGmuDCZWSBDfrQ6mGYjtHE1E/BCMNYqAavZxRX8n6AhSlY0sNMhcGWJRn7wSpmY/8omnfR/0p1J4moV70dEz7G1AS7mJwwM+RbXIclmmmc7nFkH9uvO1Y3EoHI52zQ2NTAJkE6SUUJkflblUXVvscCwJloSJ4mOsr8Er8iTKEC5t0SJWdR0+M926cWEUBFginh8TU/Gc7ahthFsH0QaS+0ydpXvzqJYco4VDDRkCXhd0z1Dkn4c=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2556;6:BDOhqA/xxuF2659hGJ2gKSUqmZxtcmgYoBk372tXkwdZY4Zdjlz1RqLaZruD4N3foPgjkZ6m/4Mzf581h5rhwV6FlviuvPSCOxelkkyF80n+YyQPleO7UjgtKodojwZRfWrZ+ltfr4n3cjRVUjXD6SpaxRI2dTQQl8PEQclJpqn8T7lR/M5uJERWST0j60P+ryypOL7MrudieXdUg5vfEQgZozA8AG5Zn44W+EuPES+s8N4pKp+VgFJij82EujyskMDfEmSURxOgObYSpeELnDA4T5vu5j31uWtStDB3ttz0XNq4fvi69pV6Dfg31hDFhsAJOXux1mtZiEuiekaQr4WF8PxA4U497wGL40Xiazbll7IbYrn+lM3p3XPZNLzoY9xlbfXPkagtbH3iMlKi9DzXH9lDjvhS0gguNm/uAH9xrx16ftm+AA5PDwh5QMhqJk014YiU0+/gpJk5Dz3vxA==;5:WBR8DFZXHGSC3WNnx4wGv0hyGG6AC5DTeZsf5azZpspR2rkrFIAJ88FH7pwYXstyqm3G9NCIR9C6OgLzLjFP9kZmueptToFg3oMrwJxDE/hKWWo7sIaFWvwcd/DQtKmgdHFNospHXPF46n16W6R7LPHtzAKomHPJEbF32xMAd6I=;7:ep8NoNTSnBLkXBAdRH1RWtQngqiN/XFaTI5vfm7aqH0Q7zHDMvUu0ySyjrvmBWLz1XM26mzFqaYWGGLL2GuQrgrukU0ok27f5lQLLWfjQaeHYPns13SADhQLlrLtkKhYEAAmqPyWZoYqWUC66Eti5swBmtegXILgFOlVvHS+DQAXHK0sVvXpQOHMOYfIYswP8kFEnNxN43y+w2hWYrwxI0PlMlz8ZLl6PGMmBIswhEAXPtHzx8qbRMyiyTKsqkSr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 06:04:11.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2dc4c3-24d1-42cf-2e4d-08d5f12b4764
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E200 have TLB1 only and it does not have TLB0.
So TLB1 are used for mapping kernel and user-space both.
TLB miss handler for E200 does not consider skipping TLBs
used for kernel mapping. This patch ensures that we skip
tlb1 entries used for kernel mapping (tlbcam_index).

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bf4c602..951fb96 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -801,12 +801,28 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	/* Round robin TLB1 entries assignment */
 	mfspr	r12, SPRN_MAS0
 
+	/* Get first free tlbcam entry */
+	lis	r11, tlbcam_index@ha
+	lwz	r11, tlbcam_index@l(r11)
+
+	/* Extract MAS0(NV) */
+	andi.	r13, r12, 0xfff
+	cmpw	0, r13, r11
+	blt	0, 5f
+	b	6f
+5:
+	/* When NV is less than first free tlbcam entry, use first free
+	 * tlbcam entry for ESEL and set NV */
+	rlwimi	r12, r11, 16, 4, 15
+	addi	r11, r11, 1
+	rlwimi	r12, r11, 0, 20, 31
+	b	7f
+6:
 	/* Extract TLB1CFG(NENTRY) */
 	mfspr	r11, SPRN_TLB1CFG
 	andi.	r11, r11, 0xfff
 
-	/* Extract MAS0(NV) */
-	andi.	r13, r12, 0xfff
+	/* Set MAS0(NV) for next TLB miss exception */
 	addi	r13, r13, 1
 	cmpw	0, r13, r11
 	addi	r12, r12, 1
-- 
1.9.3

