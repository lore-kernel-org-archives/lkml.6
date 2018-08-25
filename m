Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 20:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BF20898
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 20:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="MhaF4nCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9BF20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeHZAKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 20:10:22 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:2212
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbeHZAKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 20:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88001YEz9NMUTgkfWn5bBm0W+CgE2oX6tEQrgsi9azM=;
 b=MhaF4nCe1AWlsEFB4rVGtRZQZ4OSBDRHC1idLZqYr2SNvieKLHlEBGwGqZsi3NIO9leUcOKHBCJx6oLiO7VdU/22GeB4RMz1YCXGjBQ+Umbwpb7y4DzYB4UweuG6TRHJDjXqVNp3x/Z0gI55ELXxFdOIbeCaiYFIbJMSniG78m4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=stripathi@amperecomputing.com; 
Received: from portal.office.com (4.28.13.142) by
 MWHPR01MB2336.prod.exchangelabs.com (2603:10b6:300:2a::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Sat, 25 Aug 2018 20:30:16 +0000
From:   Suman Tripathi <stripathi@amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Suman Tripathi <stripathi@amperecomputing.com>,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
Subject: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA
Date:   Sat, 25 Aug 2018 13:29:58 -0700
Message-Id: <1535228998-9853-1-git-send-email-stripathi@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: DM5PR06CA0079.namprd06.prod.outlook.com
 (2603:10b6:4:3a::20) To MWHPR01MB2336.prod.exchangelabs.com
 (2603:10b6:300:2a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76679f0-e282-43e6-429a-08d60ac991b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR01MB2336;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2336;3:h/VxRPb6Om/XXMq3KcVRUI04Ts6XGrvKsnCZ15tNYniazrwHWfgRhcOiWSzXPDnAgWoPO9u24o3Ea0//zHIFoXuFhJTD3rOefM52IwAD2CEI5otk01o+Da6z5+R8PQ7uETurf6Dib7eEzRBeCgqNUf9mnlCqbWTzJmjnGkxg/9DEN1iaJ8MCu+v6KoxVNDmVFsHJ3JJxodkWLEywdLfPcrg0Xzplg1pnWtI1fxKWduyafL+ZBluayeUkFGlB2JDX;25:HOPFaMJSIx/xuwa+ZN+NJGO3d77JnUGHFIVp+fEUrdHWk/kuPPK1HdjVvNyJcDOgjSiByfSGuYFqsTBjNdS9TIapkYGeJ1LUwx2OUuPAmY/H8pKo6H8DlQNEh2BSSe5b9PMUcpttGJbQ86rnQOw7rx1vnhnCyr4DtcN9ryUfBq4Scq3z0wQkkrRYyhK57k/8VSGmGtM4IVKKNTb2onmLMkBLjrE1tLLcMHGl5m0pqyeeaz8j7o2xKp1ROsg/YDv/PA+CfxwQB98oTQ/3U/VlrrhGkb62UUXC/pCPwMjKqVPmPcMxafojVfaIG78360XN/kVqQlDU1fsSxKxTpZRzZA==;31:OTOviAnHkgQwBG3YQgJ+oMN2qXt8mVyMNB1Um9xXOHvTb6ysY8ovSdXFjs4iuv3tXYQVgBZcAAoKwinXa2CnhnlIHYupANJH5C7SccNIDdI3JN8q7JLZyhsqBFqklunTz/iCUeyA1NL8hfvYAQ9Cqm0CYaDt1xOtkl1/XOMHr+jaVEmgY9vt0afdgUCoM84JREYsEKeEK0In1mkrQ5xGsQm1S1vrRncWqBy437/W2v4=
X-MS-TrafficTypeDiagnostic: MWHPR01MB2336:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2336;20:UN3QpKlTN4FWcwKoec+2ixwYtLey3f3PDd7JBzx+COOfZALLGwkyRh78IvcDvdRyncR5NOsR4Pu7WkNkfWM38uQ1heOKaSPkOBxgZr26m9mRy97L2Y65VYnm1sewihnopZfgu5Y3nrdmq4cuwWAfLbUnn0VvHNXnvdkZfq1I1hM=;4:ibvwHgjK3GxR3fz8WUZK5AiPfRgyYsxa90VK3PNDMgu3mNWwe99LBWcs0L4s+SS/w8lBeQEr7rw+pLCFNLO+IwyiRbbxjITrMuamcu30Dqu86LQfiELlxq+LNsctm32vuMBpMGuTeCnYn/WvhJIqU3jRWhAk8ACPmkBtym/95jSzHFQ/aH2G8YCdk8CovaEpp3uFKtOcSTce7X3oLZK0tb3XoAHv7SLsV2pTZNF4bLwocqx7CxyFnvSSuFTJKxQz3liKaKR64e349SR78iCyXg==
X-Microsoft-Antispam-PRVS: <MWHPR01MB2336666342E240F087BFF05FB3350@MWHPR01MB2336.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR01MB2336;BCL:0;PCL:0;RULEID:;SRVR:MWHPR01MB2336;
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(346002)(396003)(366004)(376002)(189003)(199004)(68736007)(478600001)(2906002)(51416003)(52116002)(8936002)(6486002)(8676002)(97736004)(486006)(1857600001)(66066001)(2616005)(476003)(956004)(47776003)(86362001)(575784001)(14444005)(26005)(186003)(217873002)(16526019)(6506007)(36756003)(69596002)(4326008)(6116002)(107886003)(25786009)(6512007)(386003)(305945005)(53936002)(3846002)(7736002)(50226002)(105586002)(106356001)(81166006)(81156014)(6666003)(37156001)(50466002)(48376002)(54906003)(16586007)(53416004)(316002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2336;H:portal.office.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR01MB2336;23:3eVIB0B2NZUy9gydzhY1Q+0WtK/rTrpB/dGGYj+/s?=
 =?us-ascii?Q?8J9HrvdHqMJVSh+SlAq9eT2mZhCmkESOv8TxswfdwW8UoZKcRe18RvbrOMah?=
 =?us-ascii?Q?ZgG2r8Obkx13XnM7qLD2ygZJ7vKCcZ2Zl/1KyDxY5JczOk2rakJecGC65jL1?=
 =?us-ascii?Q?CxahcFJn8CajFc6p/BPyjs6dS5vbW3UVpiSGyOEp0Qh3z+Y1KlxeCVd4b5O0?=
 =?us-ascii?Q?4CIvrRaLFM7d/EycBeocsnYk27jCIf48RfZLUDbUE8u2fapT1fCC+BIqstGm?=
 =?us-ascii?Q?2a2UWvIOnRypqAWzDZKyjd1wZo1atNhI4V87nIEx3zkEceL0VWjZCyfc24KH?=
 =?us-ascii?Q?MTh7NtDjD8DIntKp3zZ3gadIqh30RuiwP6vOFYApDOYF7PmvXf9QVfEJNqPg?=
 =?us-ascii?Q?HLtfSfjC3tUBFPkJM4oQKNLIjDjSbQMt138tG4XMpYG0fdZnYYLPN7Q28n8D?=
 =?us-ascii?Q?fd0H34GvRHseWoO1k2NLcFB50Nds4eMskfSTFNn7PTsWVqb7mfXVoJESIDlO?=
 =?us-ascii?Q?5AaaAsdFSCvlI+klsILVeIMWi/twozVyOgVS9Y4mhS7PCOdN4Oq2BipBNNZa?=
 =?us-ascii?Q?4b7U9Rz/C4+qbTXI9NIhG8iL5xRvGg0mMwZkLXXBz2Ug0e/29nyVXdZyMO3b?=
 =?us-ascii?Q?gQc2qiOVNGLMVMRLzqqfqOmTdWinQR4xGhkSSZZ98AiAm8s7keoCHbFpCzWU?=
 =?us-ascii?Q?YIc8dUBDk8+KQ87m5qdeTptPDOgAuKuxbhacWSUmQIpNe32N2OmIDJLWuW3N?=
 =?us-ascii?Q?AwbWTjp58SNxYhmkHIMVaBVANlzvjgFCGCIxk1b12RJBTxfXYlqN87chGQPc?=
 =?us-ascii?Q?PdNrbuBAkJR4vbbYsNvLnFIxXfK+d39vKveLVEVS28eYPu4w57EbAsixjf+0?=
 =?us-ascii?Q?6n6bwAFpAseo7+KTUzpWN9fAApoICFaQvjfZ35crKbIomnI5570mNrBkdnFA?=
 =?us-ascii?Q?JrCkwT31QyQ6AMxfBUAcQNuvtB9xUxE1SvTSigAJrQ/z2Yhkhmo2GvppkXje?=
 =?us-ascii?Q?WNfnSSZ8VL7wEWsuwjzI1NnUPjnH3Pye22SHST8xE7qY2P9YPdzcMUK4WyX4?=
 =?us-ascii?Q?Jb4CsQ3I/2rpbkJ268IQ9WvQLYGqh6BclkFtGbBmC4e0sgYxnGQCoyHRSfew?=
 =?us-ascii?Q?0d2iaLOElzS2fEoJa4S+CmuHzpFfvMwxbd5vudSArt9fOWSAXEHPuAKo+4qv?=
 =?us-ascii?Q?QAMgxAaQ9r4VZrrM1Y7HHoV9NEz1HSsSlFXlrsmBSZiM2KdGg/I8qcKtMP/r?=
 =?us-ascii?Q?FnIpe4j6P3oUGMXFAwuLF/uTKclSUX1nIQtaoL9D5K2ZHngKdTwSNxm0GgOh?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: M9zhi31yP88Mzhk5XgmCfNkZwbJ8g2aPjPr0vHsl2ImRxN7kzlZiVQDUw3HCm6BZ+jz2Xs0tBoVr3CNvJBRiAptXvtrbqWEwNRPnBr+Kl1uaYCNmNZ/iRruQG0slvMiyR9bE6Par+KWeENDk6ORAuhFZ4C9teipZaaUyB9JVHcRjj45WC7JlftdhSUualEGUWWvCBgkjqV/LfM2ZooXQpnJXEqnUgbYhkVHwyTM/+QHoEk0/HFRbrCuGJ9uBY9oGGqL6fwJ/u/Ex86ytU8hBZWNpkhi9siGW8z0HBRR2DS0lK9BJS+FmaoTGmL9axyNBHk5RzGWk4M6l9osEeXSTAURapT8KKkO9LnQO1+H3GBI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB2336;6:339167M9VBYw3y9bp3AT3/s6R0eJRvRIg8MtS64gQj6GApn1NlDXSs71oxTmMmDzdhRcCY80xyi5eVlLDFn1ti0dg2X2ypH7iaSHlYA3IknwEzYM+97lPb4Fhxn0x66XHezuXD+k1AW8R5DMeFDo5aEwudXnzrUIVSfNnkD5gtWHSUf7c4IcRJnIGFDzqaYPgqybZ0OA66yRuYosMdAfkJAdHX9HeKOjt5TC0k7cp7Jf04++CHGeaVuGPrJXswmLtFRy9r93dy2cyFE+xk5K8SqYWx+sK+88H8xFX3IBeF8E5opeRp9/vNAz47+2Fmf9dVJG0RxO/JpyB/AUoK2GdN6EksrUl4zZAfvzdUZxO4r7d66w/hrsnxzGSwzStEcB/51WdNTmy2KajB3dT9kSMC4f4GVUzQxbFUfKcWaMWHx48UtFQVjSR7GPz0ZT5UPwiR8DYA0/V9ZyI/KG3zRDvA==;5:QRhkjY/5bWO+lujddeCC8AqseQlKHGl7AQvvRMM8zwlfuzGj96buIMsdYuDof83KM8RUfNu3zKi94ppaVMKgKw9cNdhdbd1Ixz7gGztOjDKqvVwCy49+U8Z7eFZaL0EBqHCXrTS+gn/rtw2Llct+SNejt4+OckYPs4ApxwT2M9I=;7:nH+jdY/kwvCpB4FBfFBhe4+4phuSk4O6fC155KYQ2b2Z83XxG+zh/E0sjWoK46VE7AGwVxLkSxv1Rp3ESxUJCmc2212goXVegsUp45KbP0Crfb/GjrWLb3azD9ZXltheIxzumFskKx7RErl/L0FwqWSDjso9ARWkeiaeIOO5/JfS9EtO9ajfXHF1PUgxT3CDLZgfOY+n1kuKGp6Zl92acYU1/iYrF8P5PVnsCPGoMMgObmY/LzQqJPC55KFPl59g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 20:30:16.1217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76679f0-e282-43e6-429a-08d60ac991b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to hardware errata, Ampere Computing eMAG SATA can't support
AHCI ALPM feature. This patch disables the AHCI ALPM feature for
eMAG SATA.

Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
 drivers/ata/ahci_platform.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..0d0233e 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -26,7 +26,7 @@

 #define DRV_NAME "ahci"

-static const struct ata_port_info ahci_port_info = {
+static struct ata_port_info ahci_port_info = {
 	.flags		= AHCI_FLAG_COMMON,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
@@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct acpi_device_info *info;
+	acpi_status status;
 	int rc;

 	hpriv = ahci_platform_get_resources(pdev);
@@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

+	status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
+	if (ACPI_SUCCESS(status)) {
+		if (info->valid & ACPI_VALID_HID) {
+			if (!strcmp("APMC0D33", info->hardware_id.string))
+				ahci_port_info.flags |= ATA_FLAG_NO_LPM;
+		}
+		ACPI_FREE(info);
+	}
+
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
 				     &ahci_platform_sht);
 	if (rc)
--
1.8.3.1

