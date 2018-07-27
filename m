Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0512B20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4gUkhgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0512B20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeG0LNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:45 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:24435
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730425AbeG0LNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK4SfLilJv81OCmzrpG4Ca/BAxE9XLdRtI0sSxBLRT4=;
 b=J4gUkhgkDZ+2LE74/IDb/EyKO7xd9gNQRx2cQ2H/EraeS5FlUdJklCyL11Dz5jPSQQ9Anmv105tzhHsyHWupq/nHBWNv11Y27OQmXERMcaZfb6DKrlsha7GLAoNlb0byP301mMyUrfYN++FAGHUTu890WmncAqEu15vbTYNP3As=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:29 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Date:   Fri, 27 Jul 2018 15:17:59 +0530
Message-Id: <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5bb641-7da8-42b6-02fd-08d5f3a6ac66
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:/FZct6wXEOtCJyOe/SXP7pF0+jxxBxFKLWoia3w1HoDFE+CGL/Z6Zojw//s/QP4UxitxAdUSVQQnjDYjY1QPfS89NZB3VDjQDI2s0A5LP6uaiEmRz1cgFT/prkLjpWm9V4xHM4w5Ln5O/7uArsFjBZB+cJhZUrRimsjLLU5Dcvl8ergu8XASkSktG3MlGKlFF/uMsCzdu+Sk7mOZeROzYGSErVpmsnauRk43VlNSsUhyYs9hsJPUrAmKqzObKQ6w;25:gTiotlB0Lntn8sb643IrkHZHaCnQddg6L12ehsb8KDV9X3eyKxd9HVEnbF/8ZSh04LNEzbp/YBloQ/frVIEYe7pcHx5R9z9j8MLXdxJru84P6N9TQJhWfvlpzcYN5zQwJlGSk0kNEZAkIPBjGcsu0e/KYCyO8INi5GUXtTnqCi7dm3sRT0iM1mu+PTJSrInLGIGPPrQmNmkMoXZPy5EZd1Ls0Eh7qjfiPYooJJGo4hyMTj7rnqyy2IkCA1IdzKtusNOgElZ9G9oK4av3sLePAqeasSg9uQzzY6esEnKVTYGsU0YDnOEV/uelX+AV6GT3B6C0nQVuKYypJjxFh7RYPw==;31:MjrjQ4XQqafZMNQquc/QcbyME8z2ZYHdBE6Ad6XpU7t2IokvqKiiCiU2q/V3UR0gqpXK8GqeaNWkh6xxXmj0yZ3I+kEKTkd+uWiGpaj32X8fxgRCZc1kQfYnem5ybhURwEW3r4qU4c3G25KqvqSd3ElViXecsSosO3G1Z8hrK07NSNqQ2oOG7v0Y6yo0d+NrBQz/FigvzSMO1ux9ssQmF9+Kes11xCTF4Ksa4XdXPL0=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:prPCEiyoqhSDSsNpycXmws80JbTnYXtW8Q1JzJdtmuA/IHwCuVwsYn6EOAy2dfHRv7l7cyWwgLsiMfYNlGt8UuZ++/D7RQUApvZfVtfEzkCnRBSwlt6xPUwKDFffHcjZX+7v4APNmNvf79w4Z4DyT36SK9m8TgWU9LgMmjSZ13O9NlzY3Mkkb9CIT9bOWYrPN98BDbiLMeUeHWeBu1Le2mCcEuNWYbSEKZt+nq0WWq8RtCIUoUmfMIp00AaaBAXjfhQiqWkjt/2WRzclwJxF0lOr78236JLstvRa2vW+sXx3+TfmogLa4dwG6E88ZeRa5LYZ7exGsYPgoxc1t85rb3tOiZG3ggm0EQEc/YuAoRM7YukECL0CTTgjfUgnjOe3tDuZlz6MhcsJoPXBnfFskuxpnr9mLY/IaOVGypz2lJE8IIXTyLrBIqzAxA42r4QUDdlreDxcIgLqURV/urtIQ1yfckPyuHbNGl8nQuGZoSsDphfV1pDLGPxBLbuRzyV8;4:w8ZQVBf5Ob4myKfqA27CA5PSD8kbPp5FZJ148UI2vW32d95DeyyBkmeIAuZ2Y3uJWYrv5nPQQZdg7+E6iemLCjx7xgZtnXZ6LHNwQO1lp664poLgMo1vCbbkQ9dtH61CNLdA6jXo76oh9pQK4wo629jBiLYAzZcCaauAaovSs0ro1iesjtJDeED6RJQtD+ybL5C7COq9dh4Bk44h0b7QpFYCropSXIOzXPBsI6wCioySBnV2RqYGMzdXAky1b8mSiR8WpoIeL9dbyh9Uj7sv6Eu3O4WVdMqdRmoNDGUZrkttXCTT4zw8b3m7oDj/J1pV
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2557B1A20C4B237527A4D1579A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(14444005)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(76176011)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(11346002)(55236004)(26005)(446003)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:XLmGWn8jIKFr5KE/0ba0cESDdDM1bb9eHQ9x2EX?=
 =?us-ascii?Q?7KO5uWPtfxF9vM0lPCe5emi3eS2xgzFBq4UEWOJlqy57ZMG3ry7dcHwIt5RZ?=
 =?us-ascii?Q?GkMkKrTQ4FcTGYTwW8zF55rnWXgMMEUBKpWwXgkiHHirrPaUV1xZtdSulo0m?=
 =?us-ascii?Q?IXmsrCF2QTmD1LdnL97DfqPh7tQOKXq6VSP7dAaNzCE+l6Zvmhr/m4WgYMPK?=
 =?us-ascii?Q?y4W36nfOzen7ZaWm80jK1vlKosqpPQurbPsdC7oxnB7JhUu2jIc/RVJcHncy?=
 =?us-ascii?Q?7549M333s2x8spfNAcNdI2FdxcvaaJ8dvPhhHLu/6VVAwoH+sYfttzosyBci?=
 =?us-ascii?Q?A+Q1ysFdMe1AAXt1iESvZiSBB8yofeq3+GY0kjAt7VCfjJkcsgEdIz+scdcd?=
 =?us-ascii?Q?duhPub1f4TRoStunlXyvx8CMctsBYGvv3aASuBIrVYLVbTQDoVxMatLPLl9J?=
 =?us-ascii?Q?TpUyqmH8+KcxSgmzBLkVENPWH+TnrLvJykb6hEXbWL847Q8BHOebwNi3Dx4x?=
 =?us-ascii?Q?/BjrnXR1Y+KT0/Fs7nrLbZtmTOMv3sTfGsY4ypSZkP1D2B+BJ2RTKGrkJIfg?=
 =?us-ascii?Q?vRGk5qulp4JFyTVQt/cvQDbL2O5NeFXbszl76ZiasgAedRAETadq/lrcwoaB?=
 =?us-ascii?Q?bNCc3ruAhnBR2HHhp3RX8BsmK8+OuxdorwrnROrwsQswzX8ThsWLvweSu3Y7?=
 =?us-ascii?Q?KzFC/JUtzzIH5Y+lW/extvtN5OiTMuPvzdHmLzQ8mKoFtK0CuFsigdkXRpnM?=
 =?us-ascii?Q?vzQVUGoeE0m5Mvj8+8cxmWHGreXyx7yD7JdSZ37oCvI9T4d25A5oni+VgQmf?=
 =?us-ascii?Q?ESIGrNCk1i05XB5c8D78z8Z1fXg/tIn/TbKCwdTkZZ312NFhGMATlkhX+zqs?=
 =?us-ascii?Q?rD0ULZFRW/fvySAwP1m9TDwXSUTKIdxta6RbSJyEhFnkMixvl0XpdJBk5Sge?=
 =?us-ascii?Q?AFXXEYbZ9hloMcJ8XmmxuQhdKLZbQMgCPvtPXDaKSAwiLXlOlB+pKC6rktZg?=
 =?us-ascii?Q?SwqyxMFrgobtWtk/Bs7Ok5eKi8S/DmkrhwyqTPHzm88yjkYwUh9gPflK7lHZ?=
 =?us-ascii?Q?LyxYQqVGDvoEJH1gMyaflznuGpW25TZwyZ3v//gK8hQ30p96rve5JZbzNN9d?=
 =?us-ascii?Q?XJ6VZKvpZ8ZZCMW9ZegmIyfl6j3oaXok9b1WrF8FEj9xJRwuZ3hzYzI7Rt45?=
 =?us-ascii?Q?DEofVxErLhBm4/X3p6D9EiWuEnl6ZI0ZNb7smKtKjyW0L7rWmRn93LPDLTRt?=
 =?us-ascii?Q?ryEhuR7K1zzv6ftniLo17vdsDTcGS6SKv97bqVOqJzyHcrVtX1YdY8OU9w9z?=
 =?us-ascii?Q?P070H/WBDMJ3cy8Yy7gso/7yoi85M4jOY7vr7cToBbBi+?=
X-Microsoft-Antispam-Message-Info: S4Yd+iNaL941E5a2xxdnCM0h0ieXy84ukRY55WBZaxud7V/MxtG62KAyX5/3qAU4FiZqNPExqBtndCd5WcNpZi3qbCC5NqU/XLkI8BvG53P+SdmAvtzmpf+BMVOSAks69YXjjas1tq9n4gBnouwUJtVQbwXXJ8IX6yj/u3+yw+Agr4jkbcHN7oxDK+AT+DMonl91z0TOlCqR3+/mKkC5suO4PRykjkEH4WQNz3DYJrsds5gSp3iPEdlif4Pv3dhndBuLdml5lnPvZF/+C58tO6oNjVgf6v8lIfvNwYnhQgoUyPHu1fEeUdNH1xVTzk2XsvuYDBmL3Vey7iFUvvhS5MTMzEaGeUkQTLW80sRr9nU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:k3hSUWRCE7HmbjrBfxZOazGviqFMHEq9leOxXFx50d437gkbsui/H7D5EEyaVjv0SIXHaLWr5NoiYL//M+VjN2kgXVj1TYFgZbzNugf5J6TTM+8az2Ny43EmXxfQW1PLOvQ7TN+JcAuWOe5hOiqWQUFYnbRpXXY7vb5nOvxI2+koEMSoK96vJqvGRVQSjl3y942/7v5PHEAN5bQ9bsEdT5gDy7LfZsdTHz75UW8A9pm+Oy6htK+nxbLPmWIDme924ilq0uMtlOcyoEcXFvk9nWwjv/qPSR+OD0fH3Vd+QtYZDpS8wc6TElMQ5cyqjTribMFoyBZnfaCNh7bF5Y/1UNf4igzcMkNLAs8btaBQJW7rKW87E4HFwZ4DdrEuUvNDlyTY7eH5eWl0OT4b4tFPRmdmQdTx3oQEnHjhNsbzDFb4KIN0pKjt1lllHNDXJjsOd0T2gCOahIMGEuqLKvN4bg==;5:DCkcoqJFirrbt0b8kS3mRcHWF86aXfl58/tgnlWcaQeo1L1abrNrVxZ7OWfiKPNpqmLESb/RnU+2kUSzKqybk7q70xzREHiSzMNlbhJ9WX/NGp2Ys4n5ZEafKVxZW4RDyOXtYUEIsIZK/gxtxeySIXmwqVfF10J6SRDPraKHjRU=;7:1CbSjMfDF9GNDRi4NGyC4LkRKnsjWmkbtOkrsIchFIzNYHHTP/XfzrDj/3f2HURtP+YOixp3fc4dCK14E8ga4imNdScqJQbOMsaXteo9cZOFsMSSAFWLCX23zFqTR7Y4QFyF3XEvCJBfx13xZ92QL4YXjK7ZKAWllgyBDMOQFL8dRty0fSB5cQjfw1MBuw+HDPFY822I0q9Pvo6CLGmyeW1r6x5FoM/TqTeDtuPAmz64Bm4V6LIfG5yN/EomkudL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:29.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5bb641-7da8-42b6-02fd-08d5f3a6ac66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MPIC h/w may not support all interrupt sources reported
by hardware, "last-interrupt-source" or platform. On these platforms
a misconfigured device tree that assigns one of the reserved
interrupts leaves a non-functioning system without warning.

This patch adds "supported-irq-ranges" property in device tree to
provide the range of supported source of interrupts. If a reserved
interrupt used then it will not be programming h/w, which it does
currently, and through warning.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 ++
 arch/powerpc/include/asm/mpic.h                    |   9 ++
 arch/powerpc/sysdev/mpic.c                         | 113 +++++++++++++++++++--
 3 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
index dc57446..bd6da54 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
@@ -77,6 +77,14 @@ PROPERTIES
           in the global feature registers.  If specified, this field will
           override the value read from MPIC_GREG_FEATURE_LAST_SRC.
 
+ - supported-irq-ranges
+      Usage: optional
+      Value type: <prop-encoded-array>
+      Definition: This encodes arbitrary number of start-irq and end-irq
+          pairs, both including. Interrupt source supported by an MPIC
+          may not be contigous, in that case this property will be used
+          to pass supported source of interrupt ranges.
+
 INTERRUPT SPECIFIER DEFINITION
 
   Interrupt specifiers consists of 4 cells encoded as
diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index fad8ddd..4080c98 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -252,6 +252,11 @@ struct mpic_irq_save {
 #endif
 };
 
+struct mpic_irq_range {
+	u32	start_irq;
+	u32	end_irq;
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -281,6 +286,10 @@ struct mpic
 	/* Number of sources */
 	unsigned int		num_sources;
 
+	/* Supported source ranges */
+	unsigned int num_ranges;
+	struct mpic_irq_range	*irq_ranges;
+
 	/* vector numbers used for internal sources (ipi/timers) */
 	unsigned int		ipi_vecs[4];
 	unsigned int		timer_vecs[8];
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d503887..cbf3a51 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -155,6 +155,23 @@ struct bus_type mpic_subsys = {
 
 #endif /* CONFIG_MPIC_WEIRD */
 
+static int mpic_irq_source_invalid(struct mpic *mpic, unsigned int irq)
+{
+	int i;
+
+	for (i = 0; i < mpic->num_ranges; i++) {
+		if ((irq >= mpic->irq_ranges[i].start_irq) &&
+			(irq <= mpic->irq_ranges[i].end_irq))
+			return 0;
+	}
+
+	/* if not supported irq-ranges then check for num_sources */
+	if (!mpic->num_ranges && irq < mpic->num_sources)
+		return 0;
+
+	return -EINVAL;
+}
+
 static inline unsigned int mpic_processor_id(struct mpic *mpic)
 {
 	unsigned int cpu = 0;
@@ -873,8 +890,10 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
 	    mpic, d->irq, src, flow_type);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return -EINVAL;
+	}
 
 	vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 
@@ -933,8 +952,10 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
 	DBG("mpic: set_vector(mpic:@%p,virq:%d,src:%d,vector:0x%x)\n",
 	    mpic, virq, src, vector);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return;
+	}
 
 	vecpri = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	vecpri = vecpri & ~MPIC_INFO(VECPRI_VECTOR_MASK);
@@ -950,8 +971,10 @@ static void mpic_set_destination(unsigned int virq, unsigned int cpuid)
 	DBG("mpic: set_destination(mpic:@%p,virq:%d,src:%d,cpuid:0x%x)\n",
 	    mpic, virq, src, cpuid);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return;
+	}
 
 	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
 }
@@ -1038,7 +1061,7 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	if (mpic_map_error_int(mpic, virq, hw))
 		return 0;
 
-	if (hw >= mpic->num_sources) {
+	if (mpic_irq_source_invalid(mpic, hw)) {
 		pr_warn("mpic: Mapping of source 0x%x failed, source out of range !\n",
 			(unsigned int)hw);
 		return -EINVAL;
@@ -1210,6 +1233,52 @@ u32 fsl_mpic_primary_get_version(void)
 	return 0;
 }
 
+static u32 mpic_last_irq_from_ranges(struct mpic *mpic)
+{
+	int i;
+	u32 last_irq = 0;
+
+	for (i = 0; i < mpic->num_ranges; i++)
+		if (last_irq < mpic->irq_ranges[i].end_irq)
+			last_irq = mpic->irq_ranges[i].end_irq;
+
+	return last_irq;
+}
+
+static int __init mpic_init_irq_ranges(struct mpic *mpic)
+{
+	const u32 *irq_ranges;
+	u32 len, count;
+	int i;
+
+	irq_ranges = of_get_property(mpic->node, "supported-irq-ranges", &len);
+	if (irq_ranges == NULL) {
+		pr_info("%s : supported-irq-ranges not found in mpic(%p)\n",
+			__func__, mpic->node);
+		return -1;
+	}
+
+	if (len % (2 * sizeof(u32)) != 0) {
+		pr_info("%s : incorrect irq ranges in mpic(%p)\n",
+			__func__, mpic->node);
+		return -1;
+	}
+
+	count = len / (2 * sizeof(u32));
+	mpic->irq_ranges = kcalloc(count, sizeof(struct mpic_irq_range),
+				   GFP_KERNEL);
+	if (mpic->irq_ranges == NULL)
+		return -1;
+
+	mpic->num_ranges = count;
+	for (i = 0; i < count; i++) {
+		mpic->irq_ranges[i].start_irq = *irq_ranges++;
+		mpic->irq_ranges[i].end_irq = *irq_ranges++;
+	}
+
+	return 0;
+}
+
 static int mpic_get_last_irq_source(struct mpic *mpic,
 				    unsigned int irq_count,
 				    unsigned int isu_size)
@@ -1219,14 +1288,18 @@ static int mpic_get_last_irq_source(struct mpic *mpic,
 
 	/* Current priority order for getting last irq:
 	 *  1) irq_count from platform
-	 *  2) "last-interrupt-source" from device tree
-	 *  3) isu_size from platform
-	 *  4) MPIC h/w GREG_FEATURE_0 register
+	 *  2) "supported-irq-ranges" from device tree
+	 *  3) "last-interrupt-source" from device tree
+	 *  4) isu_size from platform
+	 *  5) MPIC h/w GREG_FEATURE_0 register
 	 */
 
 	if (irq_count)
 		return (irq_count - 1);
 
+	if (!mpic_init_irq_ranges(mpic))
+		return mpic_last_irq_from_ranges(mpic);
+
 	if (!of_property_read_u32(mpic->node, "last-interrupt-source",
 				  &last_irq)) {
 		return last_irq;
@@ -1632,6 +1705,10 @@ void __init mpic_init(struct mpic *mpic)
 			u32 vecpri = MPIC_VECPRI_MASK | i |
 				(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 
+			/* Skip if source irq not valid */
+			if (mpic_irq_source_invalid(mpic, i))
+				continue;
+
 			/* check if protected */
 			if (mpic->protected && test_bit(i, mpic->protected))
 				continue;
@@ -1732,9 +1809,14 @@ void mpic_setup_this_cpu(void)
 	 * values of irq_desc[].affinity in irq.c.
  	 */
 	if (distribute_irqs && !(mpic->flags & MPIC_SINGLE_DEST_CPU)) {
-	 	for (i = 0; i < mpic->num_sources ; i++)
+		for (i = 0; i < mpic->num_sources ; i++) {
+			/* Skip if irq source is not valid */
+			if (mpic_irq_source_invalid(mpic, i))
+				continue;
+
 			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 				mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) | msk);
+		}
 	}
 
 	/* Set current processor priority to 0 */
@@ -1772,9 +1854,14 @@ void mpic_teardown_this_cpu(int secondary)
 	raw_spin_lock_irqsave(&mpic_lock, flags);
 
 	/* let the mpic know we don't want intrs.  */
-	for (i = 0; i < mpic->num_sources ; i++)
+	for (i = 0; i < mpic->num_sources ; i++) {
+		/* Skip if irq not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) & ~msk);
+	}
 
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
@@ -1958,6 +2045,10 @@ static void mpic_suspend_one(struct mpic *mpic)
 	int i;
 
 	for (i = 0; i < mpic->num_sources; i++) {
+		/* Skip if irq source not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic->save_data[i].vecprio =
 			mpic_irq_read(i, MPIC_INFO(IRQ_VECTOR_PRI));
 		mpic->save_data[i].dest =
@@ -1982,6 +2073,10 @@ static void mpic_resume_one(struct mpic *mpic)
 	int i;
 
 	for (i = 0; i < mpic->num_sources; i++) {
+		/* Skip if irq source not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI),
 			       mpic->save_data[i].vecprio);
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
-- 
1.9.3

