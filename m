Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37296ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15A820833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VJoHUbdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15A820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeIRUhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:37:24 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:63664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729156AbeIRUhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6hoY6MMvfJc3SkKYQV5cjuuFXq9c4UWBmL6watwh7E=;
 b=VJoHUbdxuxk7HHa6ZMZzUEJKAboF5UyGDVi2S/kPiEkCWZJ1cxCknjFgaEVU+fPZUC1tPwius8zKcInE6U/4Gpmh+4KI1fa0dOJpxPZijEGySFooJISDn81dxMqkp+2COcDa9hQqAIxlUXIbh7/1dOghMt8W1FI1FpUBHZlOGQA=
Received: from BN6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:405:60::37)
 by DM6PR02MB4763.namprd02.prod.outlook.com (2603:10b6:5:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 15:04:21 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR02CA0096.outlook.office365.com
 (2603:10b6:405:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 15:04:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 15:04:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2HY4-0008Vo-Ew; Tue, 18 Sep 2018 08:04:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2HXz-0003F2-Bq; Tue, 18 Sep 2018 08:04:15 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IF4BoM028865;
        Tue, 18 Sep 2018 08:04:11 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2HXu-0003Ej-RV; Tue, 18 Sep 2018 08:04:11 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0997A12142C; Tue, 18 Sep 2018 20:34:10 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <adrian.hunter@intel.com>, <michal.simek@xilinx.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] sdhci: arasan: Add runtime PM support
Date:   Tue, 18 Sep 2018 20:34:06 +0530
Message-ID: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(189003)(199004)(5660300001)(4326008)(52956003)(81156014)(16586007)(42186006)(106466001)(110136005)(63266004)(47776003)(107886003)(8676002)(36386004)(6266002)(316002)(478600001)(54906003)(26005)(72206003)(8936002)(186003)(2201001)(81166006)(356003)(36756003)(44832011)(126002)(486006)(305945005)(50226002)(90966002)(2616005)(476003)(426003)(103686004)(14444005)(51416003)(106002)(1857600001)(50466002)(6666003)(336012)(2906002)(48376002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4763;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:cJocDn5Ny2tO6R5/ZAZSBTW7/AnpqUL14dPASWsYbh1WXpuWSfV6476v7zhFrkoLN20sEIpMEfUpUSg9GP5ZRdMv7XHlfq96uK6QxSRWBqj3D3DsYNdtsLRJ3T7f3mxy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ccf107-845c-4755-8101-08d61d780394
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;3:T/89YfSjWXhcie8vYAcluqsWDnHi4LXihgExXAmbafSbmmIzceEzOwOSAVParIVk3S2zs8z8W/DeDm7yqzOP15tA+dyLabeuMqWeY1ZrPO9akNTpdoMn+4j/yne++Oe+eFNPHN0EI4BgWlAyYpv9rZk3iIkPKXO3MlLBoKC9iB+nxPdNhZORY3/rdfGqaOkQQzwU6GDTKt3M5fue5rbThulHYBZK27lzo65aKpeBXs0kVzCwEk+zjap6A1N0PxjQVcZAQaq1hPpm3ekjJXkACsyzXm/ox1h+KZpkt+9VX3vjQhXvgsusR4FXg3p41UEzk9N0PlYfopTbbU6J8HppyNDAJ1u7D5hNb46SUgwh9lI=;25:6/cDGC1tl1b+oi6Teq5fW5jNtvOayMVfsu/0uLfMFvphaEOHmTbi1ryZNvkAtFDnbU2LOU0rWo86kx6LCkBKrdxpvwxQxMnLlJrw78FPmBYvHHA6eXwy8lVixQJIX90HaD4+lTqzqqNV4ADXL8MVuuG5hQ5slcog9q39ipsjv+KXlzJxHmcTdUtxStPnwy3laN09FJwzEV3Kl0UkvGRtyxNBxH/0NZ0GnBQdjjTj8jPO/X296TagYoctnZ+6c4jDkLnpss+y50s4qiaqAsdNizU4NRSc4a/G3yKrUwws8D94ylY7ARXKse0DhI+3c7ebtEOs7pDu7Go6/tX4AMfn+w==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4763:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;31:7RXbM/RVBzhPl0nxFvTI6i2yhT2Wid1etOS92QvBpS7ETn20agpVutj11qInBhHrcvkavV7Uhn+yxceSdBYOdbQzP3Pm8yRfY+fc7L7IxlbYf+LfHjl9l3h3kljJZQ3dnn/V90W44Vcb0nY8adLbK6b8/pgkLqrRNXGOkAzT6pMUXnrU4yE/DGvAuzOmORwfyRxz9+yKoFv0a2AcwlKJfsVAekVac+VgeUg7rY9WRq4=;20:bsBFSLzfv9bvMzZe1O6vGt6l4rmwT+avi3qh9uHWBGN9HjmuxsnU/C36vpCm0OoXj78UzaXrjmuIXFDTLyBn6Zr0/F/Cs2j2FXDNIFSorjq1gTJrOUdTYGApii14emZ9AP17Ep4nVcwOUcN6yGWspKDIB0P2Mbvhr1BGvgPzjbKxnRgbl7/3QWHnt1KBc/2mPi5Ef2ACPDbAtArh/WGfgXDT7+0WiZmX0zI4eaZECabZd8xtU0dlh0c0+ZZkYPjObEvmOWA1CDh55edy+KKgoeLtBH8lOcZ+vQ92aCicWv7Ei7tj71LRjLnYUnwQ/JNuw9Zf8beBE+07coZ9NJLn43eqjOjcooJXopCYn27l6GH9I2cvTfkdTQzyrSELzEbHuZZF+0AqQHBS94uKLIv5+Vi99CWbZ0o3e7jksYbDcmAtbS+jG2/FpdaHjc0LZYsBdkhgKB4vblMwGofVLA5T4jAhoMEMsnmvFYLGj1rsGr6TyIKlkgB6Glq86p/YP/VP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4763D3920FA1D4DDABE34062C11D0@DM6PR02MB4763.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR02MB4763;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4763;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;4:OOq1P/1dFFsMAcZMjArubjROQMIb/WiraLKQYP5BvhSR5bmdkqRL7rrQKETs8nrEtTZqC24b/Ne7ovXqV+dHRwb5bn3qbbw53CUcvZML8g0uyT0AjhdlI7jWFgtixyIJ4g7rsCPYqjboNNNYltNBnjT3AqEBs8z4M5Cy4AqA9jtRF0nBlSKIFH9D+2sVxmI2KKnyweMZlbUWkbsGxUQ6FWahUnJdk7vAMDqTNr6rwLsmzEXcvCEUab2Adxuj7/Q4/sstm96gwuOdBHm8cZsaaPVmrVAmelKZETnWVZ0Vnc7J9oFODfGqCob79NMm6SBY
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4763;23:ZtvJhl9Je06MAXBqD+LGKoEis1H6IwrTuGLLTzAga?=
 =?us-ascii?Q?pFxoxPuzwnTPdEV84TxYB4DbbWaHehusW9ZFCRL9DtVdV/p05ald26I+U4Ds?=
 =?us-ascii?Q?NBVvN/gKjrLU1bbmHPFSfGsh1ba+Q6yaVxiz0Z/gz4dfOA6/7VxiCskbsDfB?=
 =?us-ascii?Q?TPJmaW3wQnttaFcs4xYeZCTnby+IDrJYO6EDL5LSSM80xd8iCeKG8oJeK8pK?=
 =?us-ascii?Q?u50dyF8MpNhh1/bBd8e0dE5IgZjjk8S1CWysSHoyIJmz/DUjZedTfjD+zK+v?=
 =?us-ascii?Q?c/w9fZqvEsjAiv8Rp2b7A71XKUrSDwZm4wWeyM2millEuYXau4zl+wDw6Wye?=
 =?us-ascii?Q?FtU9n0vjYR1CYvRGCSdDArUQ7oK2NLesV60KZiBz4EWTVxc4IufWT8ZCGRsw?=
 =?us-ascii?Q?28pmOTGH9JYRP06BZPuEye6uvRExfSNwT/jMazIQCMJfwkkmtQCDMCoDUlE0?=
 =?us-ascii?Q?xmQat2sEEz+2QJcj5zzp8+KJgIKn4udTVEPvsMHyt7PFbaU/KZNq3OA69GJF?=
 =?us-ascii?Q?rmQYfeP+acBfNHwa3/e6gNhORaGP8JxF38vMm/51KV8/z8XpihifVY1x9NGB?=
 =?us-ascii?Q?VP8YawpNb58mqNNmsRCvi/D3o9t5um6bg0kTWnb5sCfehPLl6UH1dOHBE22C?=
 =?us-ascii?Q?Tlc3/okXP0PqwDVqV2J94BRzwWmfeNAKAb1TA5tfbXI/TKSqREObfWoaJVf3?=
 =?us-ascii?Q?AjtNAYONy0V3o3k6I1eFM0pJnz8Z2LUpmN5qNzCL5xW48wNa5amZQ34ZYmwD?=
 =?us-ascii?Q?Y4LjEAeN25N8tZJFMww7Jg6HlHeuPvVD5rNHvbADvcCfaCfu1F3jMe4I8C4G?=
 =?us-ascii?Q?S48o6T/bx5LZgwyVn/5aHOebIYyTfDKFo178/VjxkYsYXa0yOCOrC1TtGrUm?=
 =?us-ascii?Q?stUqVaDodJJK+b4JL1DfZAhPwh/y4Cpr6TpZE7UhCY4avvHttoCB86wgDUhW?=
 =?us-ascii?Q?Mb+3CrM9Ap2MtAThKlNZH62xbLpGrkqSFlKZDPAAM/JrTHa7v0l7IkTcjKHA?=
 =?us-ascii?Q?cpWlQ9YkUqXhLg5zdMRkkuXRWYbuY0IPxHYaR8o6/AT6xjzFXpML1+QeO+d6?=
 =?us-ascii?Q?7jT2WYTxkJQbz6hcuKUAWU+62eIfNvjN0CtG7FK38gbePKsfbWI/D74UrJnW?=
 =?us-ascii?Q?VPSFG3Q2c3qSJ6bUC7wY21tB62dt+beMPD53COcvcxL9k/guNCzSi/M3wimQ?=
 =?us-ascii?Q?uOtkvI3V1Aj1TblgEvHZI+n0veLuWYq0ss2?=
X-Microsoft-Antispam-Message-Info: j6UoqBRuu1UzUB9oUx5FhmcXRR60rfwwH66FXSV6cj7FHXJ7vMvHtrC7+6npxSRfGmR167M5rQ0cIvtjpRb30qxhD7Z9vkdrRPLFoyX2CW+VsVG29EpKVhPXDNMNL4BNhc8gCR/T/RrLMsgEGyYX0IMSuhc2Z4YQwSJquetKExa12P550kGZ0Mu3n0cnFMzFZTnV1hqljKZ3HeUZLc1oDcRPpBuK9k5rp4uDstov+Sj6geGA0LtyBc+moW9zcYbMlywpenHbgidgN0ysaK5pfiDV3NU8GIeA2AujIPyIZNXXouKWUs9MePnV8V+BPoKGIVsP34eP2noMiSPiixHUny+6i/G5tsxKKZ5bTYUbIs4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4763;6:AAaf4KLYMrb5WCsMzit9jUE8ttoMYnWdBRKbUra426EKAqpODFpuXtKRYDOBjpyOudohN9s9KuAM0vFHp55RTmtzA9XRdyRtsmmNYP3tgdMbKvIVs2kOP4+RGWmJzsInAiVOv6SDHLaqlwO8vKM4fqobkmdYqcIAdmD4r8yE/RYxJXMF+dE98BSDBrYTJmdkrfk/Tu/2GMACSx4wXuSDysrztM/F8ZLn8sQByKQaEKxsGadVwcwGND3tKENSE/tnQQZLHT8ScBU43pasC6Ok61cifAbuhIaexpjXj39+/2pXaglC9ORtc8n67HbUgEPSXQP8qEFyCdUbeL5omNYSNHBWpgW1GLWPEk1czVF4dbV6mE1gEYHMyTR4LV1H/IbqZxfrgYT6xN4QsGlKdbPJjW/DE91CMbOl72rre+E8Q6+BfSaNdaXxqRJqzWWXELJT9p4pIWXiCJhRmBG9pS/V5A==;5:Bqa0UniRBSd5Q4cJl59kK5JPP3gpNlagISDlqlgrMeSml+zkE9co8zHK2JrXCRt2WbrCbSwJIrnxP3cx36jmpLt/PKDAV6aX69k0DarrMfNK4Gr0+7eX7FJWJ9FApUK3Jrorc/J4NtNqwGkdBn61JZVQ3QRb7viCe6JpaMKsRpw=;7:p8qEw5N95HSi65vezCbP+NDtC7/ujx0YWCp1W4OqrLdwZkZc7WLBU6Nde1lVnMyXMY3WLE3iY/hq9ivjdIGqgM7g6cQ+i04anlQ6S7tA/wYxK1CysGsZQAWz4bOn6AvPxaR/RPY0XHoPuuKn0+//vIb4a/ikEsLqMF+fFYVfbJeTzzSNuX5rjDr0D7YsMEMumLRxfFGSimBbDMOLNAGBo2ynT4DpdYTiyPvBFmOORSKGIo1k2GSc96SIuIYyYf9G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 15:04:21.0348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ccf107-845c-4755-8101-08d61d780394
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support in Arasan SDHCI driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 80 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index a40bcc2..370ada5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
@@ -30,6 +31,7 @@
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
 
+#define SDHCI_ARASAN_AUTOSUSPEND_DELAY	2000 /* ms */
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
 #define VENDOR_ENHANCED_STROBE		BIT(0)
@@ -363,6 +365,70 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+#ifdef CONFIG_PM
+static int sdhci_arasan_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (sdhci_arasan->has_cqe) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	clk_disable(pltfm_host->clk);
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return 0;
+}
+
+static int sdhci_arasan_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_enable(sdhci_arasan->clk_ahb);
+	if (ret) {
+		dev_err(dev, "Cannot enable AHB clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pltfm_host->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable SD clock.\n");
+		return ret;
+	}
+
+	ret = sdhci_runtime_resume_host(host);
+	if (ret)
+		goto out;
+
+	if (sdhci_arasan->has_cqe)
+		return cqhci_resume(host->mmc);
+
+	return 0;
+out:
+	clk_disable(pltfm_host->clk);
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return ret;
+}
+#endif /* ! CONFIG_PM */
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -455,8 +521,10 @@ static int sdhci_arasan_resume(struct device *dev)
 }
 #endif /* ! CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
-			 sdhci_arasan_resume);
+static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
+	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
+			   sdhci_arasan_runtime_resume, NULL) };
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* SoC-specific compatible strings w/ soc_ctl_map */
@@ -821,6 +889,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_host;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SDHCI_ARASAN_AUTOSUSPEND_DELAY);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_forbid(&pdev->dev);
+
 	return 0;
 
 err_add_host:
-- 
2.1.1

