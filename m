Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B62172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="hryB7nsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3B62172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeHFL2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:28:05 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47294 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729620AbeHFL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:23 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFX1013915;
        Mon, 6 Aug 2018 04:17:48 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0113.outbound.protection.outlook.com [207.46.163.113])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umxzKTRtEsoUryMr2vykAbiZiFQs7XfXtSMhVZiz/Ow=;
 b=hryB7nsCt7EWDlXS4hht2GaTCtxhUSm9iECVqw5WnoiDvQPo+Tep1FIreCYhijfyaLwO1BRcFTLlytFIPqH5IqaPh12F1SZbWeL2ulWz6C6OkP0eRxyvvgJ4GRZLWjHLzA7Y0hZ91LIS5K+M64aEsaV8ubRxs7OChnqpTXKuCoE=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0974.namprd04.prod.outlook.com (2603:10b6:301:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:45 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id EECE4302F5C; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 10/22] arm*: disable NEON in kernel mode
Date:   Mon,  6 Aug 2018 04:17:26 -0500
Message-Id: <e762f762bb8a7afe92b522f2345fb126f60a2792.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: MWHPR2201CA0047.namprd22.prod.outlook.com
 (2603:10b6:301:16::21) To MWHPR04MB0974.namprd04.prod.outlook.com
 (2603:10b6:301:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5798e42-b993-4362-ad4c-08d5fb7d7887
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;3:H06Bs1SNw+2Mj1IClZaht4ZVgWbvS55i3YF3lLuDATZTRV00/gVpDvqN/1miQ2hpupaiMe6h3dWH9N2OpXQoQBT5RiwXhdOkj2lpfaIx4C0NZQaJpMHLqgW8BLQLYJqKX/SvzKm2wdw0Qqax6qW9/kmGdaxj0pvSIjrG1RoFGXK5agDxMMeRO6ZBuc5KvFQKEMdABT46yLhNeenXX7aXoU1wiYKqw1wUNiViDmRoyRXVFd4bvniB50zyZv5xy1yS;25:L5ekkayRNv75JWC3dPbElz3LwO8eiSIFkeZAdWA3CuEpBPRYrKxpV9Dom3D21UhNDTN4FBY/vduxGIrOibOG0Z9DYoCTeM2vlBP2a8AFcZolULXs9i0gVaDbs+MEdxmo2/CZlbRqF3kCzRvpGf5meE1NN7N94s1flUNQya5l0l+hwnsxFyxaaNTvSEDgeWTYw6cwPdRMTJyj+YZ+IHBYTUMZIuiQGqv0tPU0BsmQ+QJKfwvkT5uspK4uSkyfWNBKt5sEJT2vwz3MgxsKBMfcC61vdks61Qi26uVjXbpdbNjJANXTeTJ57B55ZmBtEx3fIGwbWVppoFZoad7oxTDMQA==;31:sZS21wC9a9g9Lx8xLd9K3vFRI0WtmyaC1lImYb2O6mqZ8rGqtx1ds6xq+Lz6kZZhFM11q1++EFRhpg5chKJB+fzbCQ79z3G6lyTPHPLAt0KnPAl+R7nx/yj6j+CDC12USBYtqG/ESK5mMcUhUyAZiUvcvUfvwz/bIkSrZGpxOh58FusKqFiTIHG1gRTM9b3I0LlXYBDGYAyQjg0GoJpJTkg9GSh4En0rJOsdery6xlo=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0974:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;20:XT5+yarLtEbbm6kThxQOCWKHXbS242ynSEQcneG72teNLE9x3IJ9yFmluDVa7TW+J0vaeTyhs3LNguHmlR9lZ3fFtQSDu1J0AmTFVGZjrmXSkFTgTJKNM5Fg31b+IMo0sciwUWe+x7oFNqy3xDUxB8tP6QW7kYJ3rQdi1UjPhcME4LdVdOmOav2qhpK9YGGr/5qFhkSnB5Afwu84lHx7qisYVAKwvx3ZuyfgdlW62srzJq2Hs82UNIURn0J1HF0GwbDPKGEwnGECZpvG4XFRkCzh7TVBrSlFAe5Hk2e45q/JyGmIP+TyBr1v0i2l6GiyJT6hKKNv7DhiJq7dXU7x4S6eIwNXkljDcsh2Ku/T3sLTaTkl7KUjyuVTcbVfK513dkUW7S/eEaigVnSCilE2/H/2RD/n5mJfh5SugXzSME1oLC25U8DKchzdB3H8ANJ3YebQCEPdrrSvuAGPL2p8VCmBGVVSR9BXNHgw3LbcSB9Ab8mhN1FRQQKwVTWLRzT5WpOGKEzramGLXaMJlF+av1p0AdYNitVkbaS4/z9jBy22y7U0m2crId3wxeV1w3Ty4wf8sxChLK0MQo1PzhpAqdHv+xjzUVfcJFNbnpbeWn4=
X-Microsoft-Antispam-PRVS: <MWHPR04MB09745FEE9973264848A04DA8F4200@MWHPR04MB0974.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0974;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;4:vSGxWG+xUeZfWsHUJCfEG/SBw89JRfRwRPvtGc2VbjI149uzobpO4U9OjQ39cPaEb4AGzmu0SOVqRFGPGYZvxNWOkuzqDLnTg0Of3g2VwOqBApauc6T/bHlbiZkbKWmKGANb5nN2gkUrgwjoOdS4/G2wbbsKJ61SerOaLp2aGnexWX++KJ3CBlumHINHeCs8lCPOZiYk/Di/wyD+t7OI/EC2ryLQZJ7aoOhXOIvE9TP5C4Rm7z3CdjhUGnA16Bwd7FVxJ6E7YAKWv/VCaiaeB0tN8iChGtIxO1T4ECGy0aB/Vj58oLtIyrlmvGqlJsVwb/MFqwQYvrq56Qz58kRo2sbCFruXCCsVm7VUhkGzs0k=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39850400004)(346002)(366004)(189003)(199004)(305945005)(7736002)(386003)(51416003)(118296001)(36756003)(53936002)(48376002)(68736007)(76176011)(2906002)(16586007)(316002)(54906003)(52116002)(47776003)(42186006)(50466002)(50226002)(81166006)(8676002)(81156014)(8936002)(122856001)(4326008)(14444005)(106356001)(105586002)(478600001)(11346002)(446003)(66066001)(486006)(6266002)(476003)(3846002)(5660300001)(2616005)(6116002)(90966002)(7416002)(186003)(26005)(575784001)(6666003)(52956003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0974;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0974;23:0fO4jt8ecUUMbvZAbsal/QqUPRk4PoLi9uxrBgEhz?=
 =?us-ascii?Q?dOisq0a/4VdsnOIPXUqZRXJhIOUs79GCT3jhGnyfRpvlgUtPV9XewCaZlGCJ?=
 =?us-ascii?Q?/egyCPOZhEI9VAKyLzjtg7HZbiSnTnk/Y6w016yCIJSh6FRyGgyGrhu5dJvZ?=
 =?us-ascii?Q?TwCqpl8HMAvBaFugXmAo29X2d8JCy20drMPh0wyez0A2KmnoTWGHOZmluw4M?=
 =?us-ascii?Q?sSPpQz5rmfHImcMb9Eqp3o1D5ovrH9GJqGw+ibIqSfaoLxlqdvGQit/4BA8K?=
 =?us-ascii?Q?THcMdssIVnRkuDrEEdiPWoQC0yAqiPrXVHUI6D3VhxYhRoCPwqjG/4XYhXYw?=
 =?us-ascii?Q?Zg6Cd/Vz2co2LVDf686umoi4x1fgD6bcMxssJL5Jiz83W39TCY6zDwDj7GEc?=
 =?us-ascii?Q?bsNseeiv5RAEtzwCBFvMWQgAFufYI3CraJAS/OxFupcizqsokL5dPH8vu3BM?=
 =?us-ascii?Q?5FZuFjbQYYTZPtJkUmBXtVbWuYH330HovEK176xyRMQLHZJYXO0fhxaPGrkx?=
 =?us-ascii?Q?roHbPFAs0H/dSxqLTYKSZSUEK9fbp9lA99ibGiOpzupcR5GcRp6tQBXQCMFs?=
 =?us-ascii?Q?nnwIpK+X7Hzg+ukDj0lqkcOwjGF1O9IB2ar/U3PIoajRjNWm4IfKXbgMS+Su?=
 =?us-ascii?Q?kGgWsyQdEpEh8DkY2W/GybslbUJ9V32e3InWwn/9eqszx5f0CY9oeDhJ28+s?=
 =?us-ascii?Q?YXPv59EG3sngAPE870xmkuNv9qjZdHtkhCGmlotteqGCscyk07BvCf3UwN5v?=
 =?us-ascii?Q?YjaZyp56wBM3+kP3un2UuYR6mfAXyd71SaELiVlgS7vOrc8AnaAhKDZ4ifOa?=
 =?us-ascii?Q?Rui2SRdelyyQ0W2T6wWz0tNLRj0SYZF+Ny2XTcD1yJkQAte+qTG5LZUcLIl7?=
 =?us-ascii?Q?kW5bKq5XKvjyQ2CyGdPpX17eLmCEBkvfpcwoRg0jL93vmdShceP+fC5Kq3To?=
 =?us-ascii?Q?wiiDHDNJqTXdFPvxYrAGz30Vav735n8u79th76u6Yi2d0H9lfxCnylE3MXL5?=
 =?us-ascii?Q?Xx5Hxpd/7cXaBl0QCM0HFWVRjcoA59XeiwROIe2/R2ahQ2cAVz3OE3Ph+Cw2?=
 =?us-ascii?Q?aCNmV0Ea63fxBNleGK2Jm3wBosq2+BAWuF/D5uOepGCwC5Ie+oG1/wbVO/Qi?=
 =?us-ascii?Q?TTBSrc6U+HbOQ/Hks5HNvIVNUeFc66hA0KDHtaZlU/4n8LH9ZxAFf8jhjNrB?=
 =?us-ascii?Q?ieRebL1sTGrC2mxqyjPQigcpU4iJX41D7ualpwB723E/U+/MnW0oxv5Wg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: WHP2LE4PJXC+t5bPnUiLVWLdf49SMPYbqQTpDnbYyovmUT8Paz+vSrg0Dk29FVCs5LJUcld6pMZMhEckxqkr0UjXtrDwbtVvRMAQUp8D2M+JHX8fhCmiAGTMUje72q5zm3I/PdwQTj0NPlQ9hbS841AAB5KyaKhMgEzVyp4lI/RjHhn3QKce4qNVDxJb86tkSlXUEmsga/DKwypgK2ofPIZxwc+908KXsGPenoPqdRGE79ZZVCfdbHptoVk4ccWdzH2kepo7Ysg6bBCeVQktlf94gTJEGItRUZsbaoOvgSM9pT7lKXG2y4rgz8EPlyby+bpnU4rm68Kti1niy97RkoQg5dpe4g3NRwLRJZautsE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;6:uv19o2TDntjC7pn8pJTE2Kr7q/01l0yTqlxrOFGIXAfvpKlrR5r3Th7jmWqx5IWKf73pbFIZ7s9HcZGWSE43Er+doYDdIM9Kh4iT70OAj/zQFmd6B/ohC38qZW//q7lQodGlP0WMPUYbRc2ULtv/baosunA6WYUr/XbcFIXOZPZ9mP5tTvwruWS35A3H+J2KGakFIc+SOjDeF35hSpm3zGFBXyIKCpVCteNBXYBHiMQTOAAcovkM5ygKBtxPDfmRGGsIzOeJ2FYPUxiVdT0xLzoa+FNpP2ZaLmwagyqVBAJaMjs8CapbjTk6T1GZWrZr6HR7e4sgicaMbeD4LNo5B9qBTe4iEIkxymc7Tns3dV6+SejvbO/0D5akDXthVt2kwpPvQDf7daGjh6VlfoG7N3jSwGGg1eqN3HsLMwphZkznVZzMOo5sPoXUCdvcdePoZalR2XJAcN7SASHgyfEjBA==;5:uRbjVC4DxswUZTHLBjtWEvLdSDjUR3+28TKT8pxe6HFkPu4p7aaYeWiZQom3rk+DQ8aukbiXjR+FcaHdfZnQ4toGniumjd3DXHFvQlEEHwAEgrweVK9ZpGfeqvtZt5yjIVpMOj/ncgOCYVmMz69n5CZoTnuXsokaAWDh5+uMcxk=;7:Qjeeqj99Ap7qlb/aYlszO1b47GXU/q4DHNyb6G8H+nq20elBEWw0XHYKw+nBBTm5dg/dVkpi+VblDJ2QxxMR3Sp6vPMcCM5GBIVx81wNUPzBnA2ggDN1YVE2UutQBwV69apxb8F/JqOYFEQFXdTrDbXWaksqv/gCl7EiS6wDXOl5RrDtZqqv0o82xSIpmERFo4HlWe28LqihL5zy11y2UpEGstEgJKbjFaLsvbYRnBaPWjOwR3U97CpkCiWgFvhf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:45.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5798e42-b993-4362-ad4c-08d5fb7d7887
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0974
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
NEON in kernel mode is used by the crypto algorithms and raid6 code.
While the raid6 code looks okay, the crypto algorithms do not: NEON
is enabled on first invocation and may allocate/free/map memory before
the NEON mode is disabled again.
This needs to be changed until it can be enabled.
On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
stay on due to possible EFI callbacks so here I disable each algorithm.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit b3a776555e0d465df138d254d6dc3ac1b718ac6d)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 arch/arm/Kconfig          |  2 +-
 arch/arm64/crypto/Kconfig | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5715844e83e3..8c40f7d73251 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2158,7 +2158,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI
+	depends on NEON && AEABI && !PREEMPT_RT_BASE
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 2cf32e9887e1..cd71b3432720 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -10,41 +10,41 @@ if ARM64_CRYPTO
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH (for GCM chaining mode) using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AEAD
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_ABLK_HELPER
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
-- 
2.18.0

