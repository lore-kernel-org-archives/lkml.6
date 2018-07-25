Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44311C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD53720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="p2XdC4Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD53720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeGYK6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:58:04 -0400
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:10955
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728644AbeGYK6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBNdgngxV6F5slvk6l8KUn4Gw+nIUof/U1bct/+gEzA=;
 b=p2XdC4YrqSl5GmLZFxLH/x2LWmQjEQtxHtviB0BsPaM7hd/DXlI+r7C+rLlQlvbRJPJY6wImJsgDhZDo2Fm8Nao2iUP14up50xBFQzsInoZ29v2GQs44SgOiSbZ4coXwSnOJ5NRoihATqs1iFo0KyLQVCMsZ8YTPjxiIAbVLL1k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Wed, 25 Jul
 2018 09:46:52 +0000
Date:   Wed, 25 Jul 2018 17:44:37 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next 1/3] mmc: sdhci: add adma_table_num member to
 struct sdhci_host
Message-ID: <20180725174437.64e888a9@xhacker.debian>
In-Reply-To: <20180725174235.1ca764cf@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To BY2PR0301MB1574.namprd03.prod.outlook.com
 (2a01:111:e400:526e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994cd71e-74a4-4993-6478-08d5f2138d70
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1574;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;3:DZaNYVBpuwHWmj1qyggoofzvY3LFUPW38YQ0C3uA+9AsYTQGtfJURLqjPCKJ/BnfkOahKctmoJsLXNNGHENswDJAHH2hwpYDkaU0Sb/U0+UgR0KZLG/H0DtQP0Rt+og59wuCO8TRqz57hJR/tJLb8AQlcvzPpd0Q7Rw7x6cHKVWUGD5AoeWePq4nmQbxf6JfyuVwYjldCHvRCQMI3crBfxyYEyEsYMrgmxd9clYn4B1oMqIA0rv79Bihf3b+aPId;25:c7gIskuMkW8CFsRWJPUUOjvAxGOuGJs0u6l2vgofYqqIekHqf75i9XGmZdMjk2EFMMRRLXfxkgmfP8rz1/B0xUiS/H5L+9FhfDgmrwPrOgY6hQo/eA6MaZfi1XBvH1oCMhJrPTPKWvnM9Em04oNcXRy6QtTmUKRBep8cX22X7NTa6WxuJ4PXROFNeljQimqhYW91ee/6rUe/Q7aaJy3CozXmcnmPUilvHZpTnSPURdizkZgxGzxxxLLyNdO7dCw3hi9Guy+O0aN1QRFKbXQh60HVOfVihvs4Z1aylK0gRtdk3/0HziLPXQl9RJMtx56HmIfbZ5cgzLkjXyvcOSr5cQ==;31:uyLJ4KNw4BnLESKlIMKExF9AwsR5biTAEiUHB2fW31StAYXwR0Pemgszl92kuoCN+tHIwDX0OOBsNwGYGZariiq+ZxojFH/KFgRf9KaBGDH2Sa9lAG1r7k15cRltvAf2tdV4ay4DG4jOW+nHI7wPOtZ2YVBd+0sZwsLtrxWlFMqFaDMHPqVAkdANxsevk+/McBMFGnj/s/DplEdwPiS+rVRjB0chgksYILzcu323WEA=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1574:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;20:vfdYzV0/XD59UY2lS3DExAo02Ygo7fDZNt8wANwbVKAtn3cOsh3mrG/4hYQymzJHql0fg1HxiVNNrng6WxgsxzoYirDPBlyfnF794dj2zUkdPcuN90tCw7j70RQT1b+ypO/pkoqswlvzrJ5NycBh1W8ER27xwVO15AGp5BS0DpGIPMBm7POgQ4aeCMv1KPdprzZ+YgmAdTBSGWYXFLWr10z7OmfooOGgzxVqgkZtrktIbYlyrkewv0EzN83UHkfcvEw/6jTylcXRCaRRzMFpd6tsLwoVPXPe7VIfgIi7entjA1Y23jcar4z7X/mr6yLz0m87McfocDoW+tLx0c3iKIqUmSssdSaJNAwd2dQ0dJaSUjO10bRE4kOK4jmeFYzOAa5poEcY3fzDsSCnDOzQS103Pj5VCWLkfvnCohcn6I7/zyozL0mrzObIbkv7HDmFP5cpfHACGWmISh0Tjxt4379Dy/JkrnVY74IBpSVJMMhADood17jIj2iI8wRrHEOr;4:eZw3Fh7vi65xbFoW7+HEu42tGmfzJBCSIBE/85ga+HaEzZbF4PYoKS9n9w8FukSJKUbvv6t0jhKWNqv6Pn1yHbbi94gilcEG2P86WUcXC8r6qbfh1FDW1Uef7CmWeH1O+q/aZvQ+fqCqTijkT5W635yqeTvHThOq0qo3RTERfNNu8mYsHWTbKD7fOw9xpUV/pVQAegm8fpxXvz6f+cuSyyCXHcbemP0CaQVsDA7rgjvhM8a5oQrHzn+Yo+v4RitOqs1JXxWgkiEIzsNQjYvJ6Q==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157401F5DFA995B2F618B653ED540@BY2PR0301MB1574.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB1574;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1574;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(6116002)(52116002)(72206003)(230700001)(25786009)(106356001)(5660300001)(478600001)(53936002)(4326008)(68736007)(305945005)(6666003)(105586002)(7736002)(76176011)(7696005)(66066001)(6506007)(47776003)(55016002)(26005)(186003)(16526019)(2906002)(33896004)(81166006)(8676002)(8936002)(81156014)(86362001)(3846002)(486006)(446003)(97736004)(50226002)(50466002)(956004)(11346002)(9686003)(1076002)(23726003)(476003)(386003)(110136005)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1574;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1574;23:oyRXPsrACnhxjuMfv4l6QoFqtwIZekhhmqdhljH?=
 =?us-ascii?Q?AHL5lFivIJUGUULT/gf4tvUxH/voftbcoudboaaAYp9XTipkoix9I/DaalL8?=
 =?us-ascii?Q?LV1NXXLy10adggP0Lbws6FirnhQ67LZKEp9P05hSbgmEJiCuiFNUEpQHwmFu?=
 =?us-ascii?Q?gbCAV4R5G942f3DEL5RdhRsk5SM6gkQK7cIMckgDTUadcG348hB/bSu3kF8W?=
 =?us-ascii?Q?hPrW7Zp3nuTyLk45bMLfVV6G2+MT6vFxh7dbWr/+rq1FWl9RKNQKSXg4bVDn?=
 =?us-ascii?Q?o3MwZ/EIEz6LnDi1N9A/pPOclO4DvbB8LY6+XpwmpYFJ0JJL7BC21l8r9Wl2?=
 =?us-ascii?Q?uHOZOmbMFSvIpLYOyb9xozutnOo+Auc/W0D1j59d3fvn5yWPpyqTBEKP5pnm?=
 =?us-ascii?Q?MgNZE0Yz3UcD/yHqP9IgaPwGPjNKHJJFzIFifIgohKyLYdgj+wZyMK/YZOtV?=
 =?us-ascii?Q?/mrVYTUvkSEmirt3j0F92HxgsC/KzkS8aVCdE+wUE0TZs5s1ZgVlrJWuL8F7?=
 =?us-ascii?Q?hO0derLv9OhNJasuC82zDd6piyl3TOYAh0sQTeQmzx62QPidLvcY+KhTzPhw?=
 =?us-ascii?Q?6wXZFfWsmGI5O46GySZxodKFY02s7AIPEqS+RwptWBcCErIFxjkmJuDwRtE3?=
 =?us-ascii?Q?RxI900YxTEQmBfWwoGAhBh5yLvPU5WXSUSllpxg9TCqYDiFkKLjcEvd4bWND?=
 =?us-ascii?Q?G6v5wscgacc4nGYj8L50RY65Au+84BJiUfS77hRtz4AtA3ITOF3F+j/BSn2a?=
 =?us-ascii?Q?ocSi59eiNL5EqnSToZOupBHxpgmdT3EBpzNV+FI4PM5iJKb/MkBfFJe/yVcb?=
 =?us-ascii?Q?yq77w2yyZzvUI5dDTlVcRwTAXeLQVlLlxTDMcVljboihV1bxZ9K45WMWADxP?=
 =?us-ascii?Q?6a7m160v1jT2aagyT7WV25e7KOhnU6JqDN4L/NZfmu80sJ4gy22tvZetzjdj?=
 =?us-ascii?Q?Y2Xl8yqhPA61sZtemdqV2000VLA+4O9qzcjXrSLAXvF0oFQITREQ/6DFdtFz?=
 =?us-ascii?Q?UtmxbnzIvPgKyUN0hBMlvDHI3MTzRtcb0OXd5UKGKpTX6bbEZHbUDs+mOs4q?=
 =?us-ascii?Q?5GG44+5gHUccP80erEaHHNfpGMpZ28S/v8YY+4siiU8YJKVBKG8G/bsUNsPt?=
 =?us-ascii?Q?B78KJbKQJyh7EBG0zofQ2GPggJMEafaO/MkakcxRPoJToaWrkE23ZJiGtWki?=
 =?us-ascii?Q?pwY6NqZ74m2+0dmoS9pbs27qp/WOAK2hpKFpVMAUxi+QRo0c2yCD4XsqiFw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: HkZHnBt4g6o+tXFiv8GGHTkyHyzhzXMO76a4/v+4f7HtpununSoAbqdn/g4t+Ao1GUpRPdgXC1zxJwQl3TEuIOTTELurrYMuLVqj5CBnj+cfe9Y3nZIFEChbUh7xmszFwqT+XoEshK9J+G7YBwMVc6Q1pMlMuhjI0WhZaEVPLRKLpI6jmLsv0qbe1WT6iXhLZ4yfL6EMjDcp9PLRP1aonmONQQTqelJLONIUoQQjys0qZC+yFYKUBvzqxATRwqB0qaW1hXls0V/xK8nJ/hOuQh27GKGa5VDEUYzj7RXvpk104Fpmtrff5x3Z278MgNnU4idXuUC3KOvOvrerskRE7KiPcABGKVStM+CFXolsnmg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;6:ejHTlPM0M9I5ftaEh1OJYEeAHEfaWjT6Vbe8bKRwO11TtfN3lx0/SqJ2gFzihiyOb0VDeLX0K4rWw1NVVFZj7qsn1lVcYdLAqoDFkjp/I15fVOlSI2iT0r+NCrwSSkUzbrYK9pt/vWQKQqmu9DGH91y9gdjIOwJaOlMn3cvxDn/EzElKALRjmPmDPuQIIWfJNCEypvGQBkVxPgVA9TB/NWvdusCSTAHaCthtdOFYZQcIJyjFX8/3C4h8TTDroee2d+8BXLYm9AEbbCxAoTo1cLbaOXsGJ2b2mwMZJ92TGW/6eZFSoAqX4p732+I+B3IDBhb8uGt7fPbU9zAGVA1ixNXwQ3YvEGuEaPC4Mx2E2PkdG0EKEm1SPXxBYYII/VG9bKCwJ9bLHhQz1FrBoAbwjEf777xw/OkezNo63FPaq30YHWSrVcHvBrOdHmdVjR6PpVpPYk9Ae/2rVW13MpxdQg==;5:FOzT2+WbaxBq5EmbDdfmMiFAtSgdippbcNn2cKq0ePq4+6QZB/QihwPrfDYew4txSzx1ELQlKWAeqgjBR+azMTe6WOYaeuZMAAIBMdeJb2fJPgJQuDzyfdMuLH7zDX6mwDejo4IVqoZTVlcwliWJt18IyBWss/jJlii5BE+6OLc=;7:Uj8laCsjevaqlSgqUShUt338JSx8XkC5CrzCdO6S15OZqV8MU6F+dPgs/Oc3f67i3RNXHfDHhhXQLyQvmvOPoCqvdXwlOxEqjQySzwiPDy7C0CRpIdzk2Tr3dZpqF1DbnyAWg2ZBEPcLuS+ZJUFbdp5jxr4QjkaQ8Ey/77eS7DQGSWiFJZRVflfHkwHeq8YsoBWUX2RVuH7Q+sEVbixZUGx8Jemyrd8IBt48282qFHEhuwoAoWnTF7OmKZPmmuKl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:46:52.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994cd71e-74a4-4993-6478-08d5f2138d70
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_num member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table number.

Default value of adma_table_num is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602ef6f7..14dd4a49e03b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3316,6 +3316,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
+	/*
+	 * The DMA descriptor table number is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor.
+	 */
+	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1;
+
 	return host;
 }
 
@@ -3561,18 +3568,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		dma_addr_t dma;
 		void *buf;
 
-		/*
-		 * The DMA descriptor table size is calculated as the maximum
-		 * number of segments times 2, to allow for an alignment
-		 * descriptor for each segment, plus 1 for a nop end descriptor,
-		 * all multipled by the descriptor size.
-		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_64_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
 		} else {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..d55fd7033e93 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	u32			adma_table_num;
+
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
2.18.0

