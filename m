Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D3A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D3A2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJPSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:00 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:38784
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbeJPSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:00 -0400
Received: from SN6PR02CA0020.namprd02.prod.outlook.com (2603:10b6:805:a2::33)
 by BYAPR02MB5287.namprd02.prod.outlook.com (2603:10b6:a03:67::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.26; Tue, 16 Oct
 2018 10:20:13 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN6PR02CA0020.outlook.office365.com
 (2603:10b6:805:a2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:13 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42270 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQr-00009o-7Q; Tue, 16 Oct 2018 03:18:33 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQm-0002Cq-2R; Tue, 16 Oct 2018 03:18:28 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAIRGM005759;
        Tue, 16 Oct 2018 03:18:27 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQk-00028h-KJ; Tue, 16 Oct 2018 03:18:27 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 5/9] serial-uartlite: Fix the unbind path
Date:   Tue, 16 Oct 2018 15:48:04 +0530
Message-ID: <1539685088-13465-6-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.387-7.0-31-1
X-imss-scan-details: No--5.387-7.0-31-1;No--5.387-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588128549533;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(76176011)(36756003)(336012)(2906002)(106466001)(5660300001)(45080400002)(73972006)(426003)(105596002)(26005)(86362001)(356004)(6666004)(126002)(11346002)(50466002)(446003)(14444005)(73392003)(2616005)(498600001)(63266004)(476003)(77096007)(9786002)(48376002)(47776003)(450100002)(305945005)(2876002)(316002)(81156014)(51416003)(4326008)(486006)(50226002)(61266001)(81166006)(76482006)(83322999)(87572001)(107886003)(8936002)(16586007)(55446002)(86152003)(54906003)(110136005)(82202002)(8676002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5287;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:FkSHhgaF00vSyHGqRAb7wfn3QxSKJ9/xpLwCGBeXlhn6p1awJbcDAAtVIjhndGuUw2ah545G3dQQgLyA2nbM6uHEUGFc272Mqo5jjT4shRPcDs0BaPPJnLJ29DaMBkZB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf8955f-4b53-41be-9ed2-08d63350f571
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:BYAPR02MB5287;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5287;3:LzwZzJaYHyVaWsRBmHvn4I85RUhtYVX10sL+2RHdAnbCwEvCrykeQbURL5S0ItqPpeAzbhP4sGCNoJLabeq2jyWLLzm1ku6VnxWUYbc9JZvqOSY9oDFM6e/bsNTGM1vmUBUBb9e6irfLpVbaukrie06na2E9Hof/EUM+1fSAcBVMg2x9bBXM15JCCaCMGlF7NeWrtaAwUMrr8FRR+aefXoq54wu3IqwsTYYKbtD4Z/zx+NWQSkBRc1gp47iGslW2XwKg2pfmvH71PsLntQ7DaAoS3YA2blzLL56ioj/BxvcxmokkpZ3xcJNwCDFL+92dymccN09s3q8ikDSBrjTomPV09HuvzXlAXzfxxDJBXGA=;25:SJdo6WHXgIaE0svTyr+LLJJ+/b4Es4lIezSfK/BAf2XkzuYVZUq9WOyfLDSEYKnJriqCdr3pzJkHHS1W3uEjvQL6ydpEGRtwQQHeZy33S+XxvIsnzNUiDOqNatmwFjNdlFNjicNHipStAzXQ3uDkEUg7EPN85KXokAvJ4qDElYB/NXqF3SWtrV3s4P/KDqiVPHaP7uM6IxGs2WnjNEnrrR0UysPRfWWbMjOjHKQcnyUQhBD4rfEwxhs+aUiTlDlSZWUc0zGRk0hduItWpjE1MPwgJoT6sl3q8eKZYeCgVkQRqor4OarTSrMzB5slAYSGL7WzyNjQKFkH3nMyB1DmjA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5287:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5287;31:y12Mf0UgCK5YqShX+ErMtql4KTbO+k5BqrbdNtzUlOi1Ry1ke0O/bzqBA1iTBBcuuDfTtSLsFQCxZjekyKwaL2UthyxfghBnsShazflfqUFrXVg3JsnpFPQWLReYRV/nDBmQ1n1UqTG/vc0PNqOuEp+vlDaHhHkyGkbNhUrD9K5OVEUiF4jAjV2YLyZJy0Cj/cC9VlQ86z+ztK/Jg91/twuL5VQkwYvtcQGT2wN7hRg=;4:1dNWo9Nfut9Z4WOaCloilCBn7y8QZwSlv+lrXNWSr5gDQJn8JrhJeyATRzqvabSkOsSvVTjhs4zHPBQApZctqXWEKzaAS6yFAb8GrDd+sLdDIWi4T09vmJaU4AHgL1/xHN0ZJeuE/pfvKa87CzoVYS4DKwKbKYH1WScF5vGMxUcYvhiAcrGQZRFnCE1f+nfIG2pGRqZIHlWcC968QBlqNsKrSS69cZCk/dixciSFTuSQbTxnGQninkmzQjcXWUFmWf9kBTvuwNZkpV+OCuGc1GMMcZNxSSCH0oFsaOap6zwHJmAvcaz+0/GTbOsblR5g
X-Microsoft-Antispam-PRVS: <BYAPR02MB52876F8AB05C32E1C581E6E087FE0@BYAPR02MB5287.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(6096035)(20161123565025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123563025)(20161123561025)(201708071742011)(7699051)(76991067);SRVR:BYAPR02MB5287;BCL:0;PCL:0;RULEID:(400006);SRVR:BYAPR02MB5287;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5287;23:1n2RDr0PANo9gCTNd578HyUMCPzvbyB+gcoSSfYk8?=
 =?us-ascii?Q?ePRC/sc1IGsczHSSMV3Hthwn7P5QTS0kIjeMaEwK7+WQVbIAl3wP2pTANiXa?=
 =?us-ascii?Q?2WkRZSRY+nCb5sXBUo2gxYIBf/ZVrv9SnaaJ+gSwuAC3idtdVFYmpGU/g2M0?=
 =?us-ascii?Q?KZguKB9jR2EyQQcG/6fqAjVD2xXp1gJOmdIFilvUGwYxFGEW+24s4BrglWHb?=
 =?us-ascii?Q?Vy7L7WlU59K66Vzd1IPeRjhqMQUD65WtFgxyao5TZA4t23FbzO0q+6s+23su?=
 =?us-ascii?Q?s1tmYDkzMtL4VIUGAfIykIQN9GmGhAuOZ7er1+Ut4RIlCtqYJvVpbVIFX+5Q?=
 =?us-ascii?Q?A5j0uJzSDO/Hfn3pywcmr4AZy+6hzGfubyfL9kS/wjsZ8g3yXSpEOfV8jAcL?=
 =?us-ascii?Q?NgthvrZBPMMmeLA8bdl3vUnHfgWwgjOPGiAUVOxrcpt+JKwZusGaZN8jqBFy?=
 =?us-ascii?Q?EECGhCYDDhap28ILebwqXK1pWBMpvNhxok9Us0ZQQIrdKnZBwU9DqHfGQYcL?=
 =?us-ascii?Q?CISFnfsUMlv+GDEOq07FlYOKoiGRIm7tMPSI214vsbOPcTTh3TR/ljQU97U7?=
 =?us-ascii?Q?gWmV2UCzcMF7nlq+z78iRAryTU22IF76VdM9gKIQFfay1zd2RVLyy22QH0TL?=
 =?us-ascii?Q?tqPJX0M/SR8ZgEHA7/7nEZ2dJs+GBRz69dC03nBJTAfsPRR79HCjlJdrp0f6?=
 =?us-ascii?Q?J5m7+5tdodDNNNBBU230vNikFWWYAQ+qiBsMRT+/MLZzA9nYg5lfAy0wirkM?=
 =?us-ascii?Q?mVCyK5xlp0SN2NGNhBApkkRgY5LMPfYYDEksEUOe0nT745rjlaz6nvV7Lvkt?=
 =?us-ascii?Q?ClM9gJH+10GQ8Rph0ckHjpgiPXRVHRWfeyjjT6y/INKRq7Au6lv2xJTXjL0Z?=
 =?us-ascii?Q?GCFFbPiFoe1xaUC69otD51FA01lr4j8ioU4LS146gdASRZO54vZlEe3F7B13?=
 =?us-ascii?Q?9p2d68Cz87eq/7mGe1h2/Op4DNoLPJ3l7SWmGo8SoJy2qhbf2JmhM69n8RNo?=
 =?us-ascii?Q?Z5y9tInD4D6+8G3gsLMf/kbFsclLMGo25BqS4bl21lQ+ZAi7kH0OVt6wjm/K?=
 =?us-ascii?Q?HnoU7F4joQJkscrQe5sh43++Cw5JQkOfu95asb4zWLJBBoP40eylICghycXw?=
 =?us-ascii?Q?/LC/BY7cflNUAiRKUq/fMiXqIVBPWhIZXvQhQjh+W6xvjS2fQO7QXFY8eDtN?=
 =?us-ascii?Q?gDXg8OW4knhcjrDY8dpV5AEuR9xVpBv+znOFD2mwfhNtOTlmbN6rcIY5pT1G?=
 =?us-ascii?Q?eI707NdHeusGFc9B40J7YDRVzlB1lz3LIzgiou2hbF3/Ucz24XAx/xwdrz5e?=
 =?us-ascii?Q?qZxAU3DhQ9j5toWoKlG1+4PWxZGN+2S9ldKXGlkbtFI0StRbusqUGQaoRr6Z?=
 =?us-ascii?Q?ZGkJ+vE6zcajeJBsMltOBB6f90=3D?=
X-Microsoft-Antispam-Message-Info: LKwrgXEyp+laiOlFlZcb5egPeFt7GQSDJGb4TjTkUoZ0Kl7yGqk6kCbl40H7RtPhU8BUpTJkUBk1lfHIxpTtGj/IPTJ3fL8WCD3qqnptCl9HOSjonI0JtMD5IlZivSpLl2pHwjYRxoiBleAep7xCGODuJWq2qVeqrSoAaLTS2D3cmRGGAMEjZt5HdY7P7P+jFTNuDRXom3nyaVguB7eAbFRzt0AXngG2cIovr7oyLTKgxmpyeUQpS+d2falseBT3KJVBjXv7Pk7HdylOertD5WDpVGUXGudht/DNHLDQmhMyUgcrEmnSz7ghwxy5k5tzp0BW4UECDKrIKQeTNAUOEMuwEyoq4XjJigv0aZ9fePw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5287;6:a1HAYi4jRoJhvDn/CFJdvlawJUXEdv47p84ZHLFlM7U0J/zMzALUfgirn2zTv7/2pQSU9Bq2BTh/RuEtDSK1eVLcSW7esz5lc6vC4bMS5a2X1Yib0PdcwdKCCK3Nx+SL4+IkVAFX9twIge1LYC26tX5UC2c0WCx0520AI559z2mYIijtIwXohMwNnHOvHELDdGx9tJXNg+yjJOlvzmVxZ1dWla6fTxCx/kfqcgZDFuVcHgFuqvhK0ynqAxZanAPmhZOGaqZm4FEsi4egSyjiGqDcwwpfV5iE2aLa/JmxQLbGKOw0rnsFYUAhVcn5OfKOSJJvqxogI/yH6q2imFZ2JaAqrL/QE4NyO6ENIqMeRc8Lr0uNKZlYhyvMA9fxyO41zvvH5k4h345lhcOWGYCtLgTGCiezmlCExYVefeu6lWrLtI/uqFq3otNHT1e9dMaQH7Mj1TE4kvldZR6gNh6Cpg==;5:BR/u2+HsOFHibJ9//qbKh9ANeMqIDvlyzw1wy72TYoVdMHJMA4lV8ETitwRrlluzyOEVEMnvofYv0gyEsrgi4Qoy8FNbjVFxzIC04KgDoDIWfVIzKS7F9fe6ofvvu+Ms9C0xhr7+cC4x/QJLN6S6W97VtVAxfrgADS6PS4Ei4mM=;7:HiBPjZxh9eInOsL7/PxLxzqKnwF4qJUAQuDaN1lGzodZkEZFzQSfLr2WYftJQee8v4wpHFhSiHXWiE/i9mNu1Q5RrbehgGWwOvIS5fJIfAdbXjG2zAAxy+Katsw0qNH5xvpqHjWMRXyOEKdlP9YZa5qOBlelEiND0UujBgwLl2D861GKV0tL4QgUuS8eV25+jkuK14N6E0tzts5TVSDvkdZgg14u/nwbyZmhjlXCnynj/eeOWSXKtyxBI1ACqzDc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:11.9799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf8955f-4b53-41be-9ed2-08d63350f571
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the clocks are not enabled at probe but when the port is used.
Remove the unconditional disable at remove.

Fixes the below
[   77.660196] ------------[ cut here ]------------
[   77.664749] WARNING: CPU: 0 PID: 1992 at drivers/clk/clk.c:622
clk_core_disable+0x78/0x80
[   77.672892] Modules linked in:
[   77.675930] CPU: 0 PID: 1992 Comm: sh Not tainted 4.14.0 #23
[   77.681570] Hardware name: xlnx,zynqmp (DT)
[   77.685736] task: ffffffc879e2e580 task.stack: ffffff800be30000
[   77.691641] PC is at clk_core_disable+0x78/0x80

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 58296eb..4a7989d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -857,7 +857,7 @@ static int ulite_remove(struct platform_device *pdev)
 	struct uartlite_data *pdata = port->private_data;
 	int rc;
 
-	clk_disable_unprepare(pdata->clk);
+	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.1.1

