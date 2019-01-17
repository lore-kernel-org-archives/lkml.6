Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF150C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AF220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oD31oScO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfAQHDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:03:05 -0500
Received: from mail-eopbgr810050.outbound.protection.outlook.com ([40.107.81.50]:24298
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729689AbfAQHCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPGlAuSkCLmXFrix51WqbphvboZUkyg6fYxRuDySG6Y=;
 b=oD31oScOCCJUOw4JcRKC9k/gTUcBVCNPKXyf5viTPoOr4kWLntYwxJsyLi8IzLze7dZz/9TsgcuOf/BqbaButUlLYY6r+ElX119ZUX0mNoIjLJszR4R/PieXnxGc/99OHtUg15fRh+8o0ZKxSEAyRiFL4/yXqkGtTJKwiwHK7G4=
Received: from BN6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:404:5f::22)
 by DM6PR02MB4329.namprd02.prod.outlook.com (2603:10b6:5:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25; Thu, 17 Jan
 2019 07:02:43 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0036.outlook.office365.com
 (2603:10b6:404:5f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.26 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42170 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hJ-0006rl-3r; Wed, 16 Jan 2019 23:02:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hE-0007Rm-0N; Wed, 16 Jan 2019 23:02:36 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72Pli022378;
        Wed, 16 Jan 2019 23:02:25 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h3-0007MO-5j; Wed, 16 Jan 2019 23:02:25 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 64DBC800EC; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 3/5] firmware: xilinx: Add ZynqMP aes API for AES functionality
Date:   Thu, 17 Jan 2019 12:32:19 +0530
Message-ID: <1547708541-23730-4-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(199004)(189003)(106002)(8936002)(44832011)(103686004)(107886003)(54906003)(90966002)(110136005)(50226002)(50466002)(48376002)(305945005)(2616005)(51416003)(76176011)(63266004)(446003)(81156014)(8676002)(126002)(106466001)(426003)(81166006)(4326008)(486006)(476003)(36386004)(11346002)(217873002)(2906002)(356004)(6666004)(36756003)(5660300001)(336012)(478600001)(14444005)(52956003)(316002)(16586007)(42186006)(26005)(6266002)(47776003)(2201001)(186003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:UfXZelcT+c5mFqBKSENm6I0efSHRaVPqbjizxh9+WflEz493QYwzCBloFWGKC1TvDoaYnSqak78U+5Hlvx6hKoICfyRM3t2dEcyfiCkg/H147r/XcDjil4X5eFKocRcC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fadfeb9f-ad61-49cd-1802-08d67c49c694
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;3:1RtsIToIqcuLvW/VKHO0rn1iYkSd1Rih1B/VwFPFoSiqyve5lXWVgyO/z4/Zj9Mxt8IxFYhnWrMmRgei84UKYsFQ0O5Sr+MryICl9AU/BZI0aOcaT+twkwY0KHlJYXWieHxMYvCvrFhiKPJP9FtIhkZ0T5H19iba3XJBypnjywh6mXJsnRYc8WrMkY7iXATA+RsNY3KxqsVAjYksijUJdzV6AqAJEG4Pb8vQgCn1TjU4MCv3tXNGJoyoj25a145v6fDL98gcACHePrsLXLz5vttk6eTTRDvRG3PYiqzxx25XXcZZnS+nbMCnzPh6WPFKrfkgl4Qra0aF8/DxTMaQsA8t1FnPgPYTAghEDeoEB7e+eLE/boasLmY1k+1oA3ia;25:5n7OIp3V6iXaYZFhc+zlYy6qJE8C2rtb3+01vrwUvJl0mCKXhV7bTIDZVeBAp6YwVxGV+lSBL1e0wjW9mVnhFyLWanwJ3fengKVIDd/B7iJq3dxjoz+vWelXr3UloAp4XC6DPzbeZN3Msp38jXsE3XntpRu3nF4DmXnJvfIM3kIxfUq3ca3MlOsjT4CFyae64xfXtQQORWdRZLsmfAbtE2c9Db4IXqVCEUqD/7wdX4lMt+cMcvA/eQffwZSxaKMxI/LMk5OK1fsbLb2tmQ889u2s9uyC/0EIswXm5osakMExVY7Q333qOHt7OZKFOKRvT40HBqAaC5c9/4M9JCwi6w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4329:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;31:1LHn9YLyZQZyrbWKYqTNJKRT0urR0oolNrieSIdgkBbswihMlcVLOh90nap7qplgFGmVevhjyku/094WvRDUioGzpoOJzLIvjtSYmKpLUs6GGTk1PppD306JL+axg606GkubSuHr73k5CRpNMmel02suOQlWUUMc71BK7ZsXlEBeSHmfciW/BjCsZ8zXu7VuOwE6xOuh+j9xwZzkTTu2z5JSxM2tfKTK2RSB4yHPvdY=;20:9DVTX4IC7pMn2QL7lWcHWHi1Dcv09CkoavB3ByXBqVKWleEcYwQ4Tlnry8ydaMEuLgOHEAgwL1Uqu7Euc4XrbgNznG6/Sdo8XeOl7sbEUwqYNxXfjsPShMe/Fx+41Ac0Ez/X19d3SK9GNZqjhKUWTPvS6Ziq/QlDYY4C2bh8XINKOLCD27Fk5paoEBIL9nVfI7caYCTphAhXZbFnJprrIUApfTRkIW5Wb+1d9YkZYz8AL5eHu+El+1LvpYV43PyCr/DK2OPTWilTLMQAKuB2xhlz+Vayd21kRttgZruj4ZJ47BR6B5vfHH0xlTozfsoeiA+6ZTGwXzFiv73+jw0rlUfv58BJ5sprLKiW5NSeQLF8g8pP91ZyDAuwst6YMnyAMReMi+N860LPwtCZopPgC7ZdV9U1RbPifOtfu7b7iVPhBxtSfJAK5tp+j8TasyEBEad1iMLNFSWegSiGRzDGkQdqM7fyOsXqMdq0Quj6RMKZ9bCnNb/ncCvOb06b+JMj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB432902D914EA1DA695C1034FAF830@DM6PR02MB4329.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;4:0UPX2aD7eqLsDPaYqdm+NWG7hWjCdSBNnXc2ltlrGG/WSUzHw6bHr5lp4Fpb30hF9UXZqGAT4ZV2uQAh/bgqMmEEfvBRQnku3KBVQyK72iZZCGZlFlr5yITGAeBZdSyTnhSuz8vG7dqkuqkkUkzwAwhpXmzSczFTXGAk1NL0fnYzME71sr/RODwxIolisZjusYzweFFGktS/jK06jCcy6fl3F0boM/ugoEMuS+t9CpdE4i82R/csfE7uabrazN+CqqjV552YZ55Ri1gN+BaCifYC2RlaMW972h7syFrPhBlklszhF0Qcyg7O1eIPCyM+
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4329;23:USoYIlxwICE3//6FOJHYW2vpK1v0xTi6BPFL4QyBY?=
 =?us-ascii?Q?7QrFAo1sbGGq0+LaL7VMwb9d52NBdbtmc3IVJee5OPHmT1/M9bIcpdees8/Q?=
 =?us-ascii?Q?Vg/BXdlHdgsSK11TOUj4PkITAOhAvJ5ETOIJQq66Wom+JzpLePA3asXDpOWc?=
 =?us-ascii?Q?bMuEGBd0qA17EzsHDnt+x9LDiE6zdz8S5Pu1ik8aE4ny4tqAmYYdyYE+1AVe?=
 =?us-ascii?Q?CSfUIrwq1YglMovaTps0JtETLcwN/+7DciM6duHRAXpXl2KIkpo9KeJW/8VZ?=
 =?us-ascii?Q?xL7IHTfz/KDMw5RA7MVBFlsCVCWQfi6+RVNthHSrZU8+xQTnCf1UmrSwIh/f?=
 =?us-ascii?Q?4L7LvwOIDKkXxpnmtxsbm1XiSvat8VEUi+msjPGuUtHNRzl+iUHTm4U7z49/?=
 =?us-ascii?Q?YSgeVxyko4HCUsEZkwcSX8G69bNlVSTeKUABb8t+TiQ4aYE/DMQ/j9pw6gNv?=
 =?us-ascii?Q?tb3btFUoHnRuGUeID1R8wsS1dC/AWmT/kV03DfabCAGTg0NffqdrdOGuPt8r?=
 =?us-ascii?Q?gtrKQpx99gQBFtfvA7dVFALL77SIz5n2df3Y3eemVU3FXd+x6+Zbmg8UE71w?=
 =?us-ascii?Q?+WWSb3a4slYLZow6OCuOprVpFQOe6waqzlHOvV2bXseJNOyap16uVJp1C0LB?=
 =?us-ascii?Q?P+TecTwk0Em5vuprxSKI7b2BpqJyZXdrQtTMeBS2HLR9jdS1Xl5IudeYOFYZ?=
 =?us-ascii?Q?5YoJI09qikK1SCqZLo/i9+i9CU4bjVGwml74Zfp1MXppik6SeDdI5qaM79Bk?=
 =?us-ascii?Q?fs3sbHiaRl4qt0MVv2uYdl7I2u8eAqwsETFW2cx0KqSM46PtT/kqwJ8SNkwZ?=
 =?us-ascii?Q?jz8c8zcKBZnNydqIKHYoO8KGYbNy2td7Lqmo7MHMzHly+o7tEm3PcFAKENIl?=
 =?us-ascii?Q?/VtjCu9bqQhSF5gT/i6X8PzCqyNCI0GcUpFJ9IL5STlMftgEDOos2mlggOn4?=
 =?us-ascii?Q?9TBmRAWVGoYEolCCUUWmNr5igIsRqzKvOacYaAUDRBrMfYuIBlMGorCeevCh?=
 =?us-ascii?Q?taomH7qBw+OOXHu6MUPqKEk8usfBqC9II5MGTaiBK0CMwOpRoC+sgBHeqmll?=
 =?us-ascii?Q?N0GbXMeuftvj2jgpUzzbRmLPfk4Ifua8Rv9KbYHuxEB/cdbRs5L+4P/CrQxP?=
 =?us-ascii?Q?cKPR2U0KwvMUeqj4fVzBGbG2ZMUpE0NEDGBiZ0Apfvo/gsC6RIdG32PDRorU?=
 =?us-ascii?Q?jXHaXn1hmsGSmuW6H/7FUWEWGXzMyM355eMCr39tPXO6iDMHY/oCKpwtBguH?=
 =?us-ascii?Q?FX2P5w4BowsaTVD8H0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 82SdCLd4APNgU1JYwIqF2nn2jiSKZ1TAAfLh0Km+F+IoTRFsoHZMY6xVPrEg+6wG1El32TVO4ELzCbJPVfGDBGaK2sWDXrJLsVZVt22utNqugy3iVS/X77FOdKp2bSgM1yR2VBvx+QcnB9wZzv5eXkjVCUlbcvUTV5V/giYEpzXEypG/WG/WAV4oAM+Y1Rv5cgyyuM6Hz3mzRuLBbGTtEHMXOypsScfV0k92sUmt1bLMkmpPLkxNMEpL4EpZucTkLD+OwFlJOSrUg8jBuOMNHxQD2TUmOfIhhXwqe1KYhSO0lcyMh/TEW5lTLmB4M8VoYzzJPX9t7WxR53LwxTH9+XWmNleDT2b0SctRTbeYDsEoPUQAbYMkJNfDno3I/hNpFEd7Z/mjph/7ml47BXtCoLHNZn79a+qK+4QZ9JfeMHs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;6:uOBLlCk9cFikqn7SJPRcEfs6s1rPv6VTDwlqeAa56yVhVHZGhGxGwnJxU8aveZIu6u7S9KWzvQmS/dMFlS8u/3gL+Z7/GOwhwbvgiquZvpXmE9XZVr6DEJ7UcCNlaWRAHn9W2gFIZemccq3G8H3ik2ymscg0H6VRrRUTlY3N8b6hbwW5uReUlAuksxx5uKd8grArTRQQafezFU+kBbDPS0yRb6Su1Ds5pQeQFpwjvu4B/sDXeOStxAZZbeH/7D5Jy17X4byl2SKt6f82VTiobUXbLxgAn4YceTdzOEMvcgeqRBsJmZesJDATtvlGnqBlOCbGTj86ySEB6xqK14nRVjkwGxq4ISIB/0wuMNpxyX3rSLMibwUN2sDPHFm1OJEEYCwPqMPG+QIBg2ERELh8wjWcOo5QO/LHKdkQDIDO34TiczWyLiLpW5TYkmxWJ0lJb5g283vHveDmWwFecmfD8Q==;5:9lR9bX976eMBPNQkFeWo2C1qi5uZTv9BrX7JUufwTz3r1RWFMpjil45VZKCZ814+IXWO3YyHo5OhYslc9f97bZW9zUfCr6s0PzY7sgnC0yRPfQNt3wMUSz0TK1JZkCUi+SzrhfqFEWKKRjXCh6AiAs0ufG4zAKF13CYalZfMKC+fQULvEj4xOKUlOMTl2ILoKAmoelMxlH+ZCqJ7BMZtdQ==;7:5+HUc2/fqiWmcF3CIdGC1iLm/1GWhqtNVTOkvctXX1xtNge7bwOPe+jBOT3YJsZnfBsS15+ijV7IfABhRulhcaAuc0E/oYc9w3J78TJ/v8fDGeb8+lxlHbdTLe7QxWT1d7mdihTAalkrQaqSlr3Oig==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:42.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadfeb9f-ad61-49cd-1802-08d67c49c694
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware AES API to perform encryption/decryption
of given data.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a..332f98c1 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,29 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_aes - Access AES hardware to encrypt/decrypt the data using
+ * AES-GCM core.
+ * @address:	Address of the AesParams structure.
+ * @out:	Returned output value
+ *
+ * Return:	Returns status, either success or error code.
+ */
+static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!out)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address),
+				  lower_32_bits(address),
+				  0, 0, ret_payload);
+	*out = ret_payload[1];
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -482,6 +505,7 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
+	.aes = zynqmp_pm_aes_engine,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28e..815fa30 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -45,6 +45,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_SECURE_AES = 47,
 };
 
 /* PMU-FW return status codes */
@@ -102,6 +103,7 @@ struct zynqmp_eemi_ops {
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*aes)(const u64 address, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
1.9.5

