Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4789CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB9B2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mhlfOM42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB9B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJDNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:46:53 -0400
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:16224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbeJDNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzTwxpVSZMNR++gW9uYgo5xNKy3mTfFny8s2Wrt4Ajk=;
 b=mhlfOM42ULzugEvawhOgYfzFOP+tw7BifuR/8EaQUZ995ZwE4OGgq1iIH1Rw/ifKk+0ZPYyzkmTfWM6Qb2A0IoUT1Ae2LeSXlEqPvnTtka5CUjqmVwP3GiK63eGPqIHXZw39AimsyRCJu5Li5ZBSmimDGhcwepOFd1GVdi4IN2w=
Received: from SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) by SN6PR02MB5120.namprd02.prod.outlook.com
 (2603:10b6:805:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.23; Thu, 4 Oct
 2018 06:55:02 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN4PR0201CA0041.outlook.office365.com
 (2603:10b6:803:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Thu, 4 Oct 2018 06:55:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 06:55:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g7xXJ-0005YM-Ss; Wed, 03 Oct 2018 23:55:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g7xXE-0002IO-PE; Wed, 03 Oct 2018 23:54:56 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w946sqmD020558;
        Wed, 3 Oct 2018 23:54:52 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g7xXA-0002H5-7b; Wed, 03 Oct 2018 23:54:52 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 5426E6050F; Thu,  4 Oct 2018 12:24:51 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH] usb: host: xhci: Set the controller as wakeup capable
Date:   Thu, 4 Oct 2018 12:24:50 +0530
Message-ID: <1538636090-16288-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(48376002)(39060400002)(16586007)(336012)(36386004)(36756003)(186003)(6266002)(110136005)(103686004)(478600001)(8676002)(476003)(54906003)(90966002)(305945005)(51416003)(2906002)(316002)(8936002)(4326008)(106002)(26005)(356003)(50226002)(47776003)(107886003)(81156014)(486006)(2616005)(81166006)(1857600001)(426003)(50466002)(126002)(106466001)(63266004)(5660300001)(42186006)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5120;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT027;1:lYa2+Nz+/6FRKNXt8ooo/1F13+Ef0JY4NlxzzBfhPJTrD6Gud47Wy0quzHCSzAV3EIwpKLvyNTuFFG03jTN43yCLKeuz8fKz/w8OlZFhbUSqGulnfUZvGkOVzKducDLo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8d16c8d-ecc0-45af-3a66-08d629c64f0d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5120;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;3:kZRhDLJU3oJ3saxSf9JZVOLxKLkBVIwxRYf0XiP0PmIooijCmQ37rTPlmye/Lf2FQR+tcwjW8Jfh4WgZyeOYZ+ISm+rbepVDhRnkSWQrnQ+BrshT18StFN23C8UKJzErx+zc6dZ0vZwjZft/jkYw1UZ1IiKTvbFViXhJLCAmD1aBMshDL7m0YMjOXBkinDhJUrfqCgQiizosPV0kCv1/dB6+nxFH2jeUjCkts6yrx1gw1Z5L4qsHPFR9aIc4OzdELNop5yqSWyugX3dttpLJ3p58nFCowaKZqCZsFed93hkQNa13wSilSbuDPz5+nAWOZrgfL/EenzHYGsj8WGqWAWhMKsoxpjpIHPZVRSaMdQU=;25:kq+VDqPxuTlH2M9sMxXQMp26raIyNKtywUA7yooVdWKQsZEj/Pv3Gpx2qdgQeHaYEoUBEzwvFSlSB/hNGLzDpvEGXyFtbb5ta95H7HjPVt9Fd//GHZwCKzq6z0rOzwRBxIZxTlHDBisQ1it21znsGZBZfc9C0FmBxcwgKiGUweGre4TjmoxqOETzsT5XA5+ytekuxCZgpX2VRi4xnRRYEyiJjqMEXuJAuzYTyQf3tErGGggCgLV+ZKEpIi9yLTZ/8REjj8QkG1WGQnD5+H9YJ9iW4mKS7KPZAx5c2N704IdHxadsxaIwbO48Alejst27y1RsGct+yh9ZFtIYtO25rA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5120:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;31:xkhTGV4Rfa0TK2YV93zp+B/AP976kFh4OBfXhibZW4kMrwcamT+FjVb9jNcLzhHVsNmvcV/Jur85fJ4/qlY18/6b40OEZEwl8uyE8YQ6rHdahbvqGG+w0HEZ0pghn5rCZXZvRJ/T9YJSAdMsMC9U4oMF0qOpUSnO5Xy7MhzOpU0YkCeYZXhl88k7NyeM0TDMAzSq9LqBxiem8UTl98/kGFA+Oa80DnIEOBQPuis8R4k=;20:+Xv51c2gCGiOW+PfUF4MpyfMNfegr02jVbswwkRZxt23bJwtk7MXVbYH1K9aV1Q7bIl/Cu0UvoK2Tm5+2EEiig9nyx27TC38hwG5WuC3iOmhtPzYx39DoIouuIgcJCuawPGd7Q+2ZnScJxRRcp4bfUX3FnipDTaP38SRPk1ZOcZXU9vi+zq5AHJzMSIoUW6r5Kehobv3oGmM9eY7fMkrkGdial84paN2qXRupphfhYMyeTgdNQtmAOgztVg2UhgjWWGGd53hlQWppA1ddb8ePsZK9g6x3lk77YpNgx9e3dtgyzJNb1xDW0Flh+SvLgWFPtVwfhOPiNncmW9WxaDKryI6H49DhLYRIY6hxz202L215DxP7FqjDVlKdf2wboRQne6D5CZSjim1Nki/z/gaAy2NPitTfv1XGapaFh8uatzHsBMC8uofPY6lD2x8VAPiO8j8RWLj92unuXTQgNj6yqfNvJoIoq38VDieYoTxKZAQ8PThTXTWp/kTsZrtTsQm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB51208D86544614D7EE6C47B4A7EA0@SN6PR02MB5120.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:SN6PR02MB5120;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5120;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;4:IKX7HblrmXKKdSR/IhR/yb2+ZtdAlIeZw9FQ6xv+O1EYSBmv6RTsePVnTnxsVKU1sUiTpJCDBvNHmM23wLQOHeZCugsSaXQFsYNDpcVhf9w9bLIRbCvKEjKz4BoOyCcLwl6hE7GS1Pchvsrhf0M9QrXIeQ8sD4BvGucPe88qvVJTBTIefaiytHprlVd3WI8LsAvlzBkIVTez5GTZVTF/gzia6V47Cbd6p05Q9MbTdZ1FLHfC7F/dg44r7kuhLvrD7lTNYQALsPffhkyed1swgSDMv5TxMpOeSiKKZ0djdGCPeSDJSA6FRlSmI/DVwcTh
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5120;23:zkZJDZWjdIMKQdQrCSSgnYGco3G4Q24MmGCF3TmHg?=
 =?us-ascii?Q?APtJptIzsDap9rLbZlGw1P+3/OUu+S+m59TgJghSnITIjZ76RM8UGqxZpEL6?=
 =?us-ascii?Q?/uZayzPdW6bZ8cM6Kc6QvVZDp7hLUMUWGV2B7aMHoqo/BoSxvT9veTnZjJal?=
 =?us-ascii?Q?3q1IZihXtQ0VaZHnV/QOMjAFCbTYlBHKV+dsVGR3FJm+3wgUaHP8UgofLQDi?=
 =?us-ascii?Q?odkLZAaV6F6SFb8L+NMWb35zzLUxwnuqNRMsXQZLe+N7FeLe2pIEsEDcf63Q?=
 =?us-ascii?Q?Rz+6CimY93VAwI64vT8St1udRMvCzCFZ47WQuCUr4Y9GW50kzAmaIgSPnWCp?=
 =?us-ascii?Q?Yc3IVUGBgZKKyqpqxcV0YTqoj9Rl0yuqHinRiXx00fGYotPvsINdYtvEUtVf?=
 =?us-ascii?Q?fb8MiOlde2kNjhQKUuyxq7tXcCh+VZYMJPUqAP5z6WgvPPQqf0RpPatotQ21?=
 =?us-ascii?Q?ER/c6QKQi8W/KyUhbqL9SNq7qMWPV/dSQ58UaKhhxlWoDO8ArtCJxUrY+Eks?=
 =?us-ascii?Q?aidf2o/Mv/IU/8ZPCtHqw+H14I7XEH6agVHacN0yIMacK9RotexP4ryQU/R8?=
 =?us-ascii?Q?rqxR854Dwb+ZHgsZCT3DHsk9pICO5HZzMePWxdnLhlw065+T2Ih0ZL/s9cdS?=
 =?us-ascii?Q?1utHHAX0dJv7v8/+NOVmvMqV4mLIFnsN8lpsIHyU0oXU45dMZ1INZWcwhbBW?=
 =?us-ascii?Q?UEY9dehj7JDpReKUtXfERmtYkegWLIDtK6Zi3BupCIxmH3BWkpRJuXYrproE?=
 =?us-ascii?Q?Vt+5yOw4ASyc8U/ANbMHBk0tdwTyJepcUcjgTSxoYM4KPqNPXctIvrTmZmHN?=
 =?us-ascii?Q?ploDtIGizBRgpAsCycme8IiCocuAmVKq0LO6etfvaSs2Fr6Rnd+i7GM+R/s0?=
 =?us-ascii?Q?oi8OHTtGawwoMWG1wfQc3DaJoKBWV+4dKEyPhB4FeDzQbCl+JSS2mUQqXBoh?=
 =?us-ascii?Q?qnv9sNh8ACi/aoidYvildQcscgUBq4WqqEOYyG+a5u1Mq5S5XTuRGwMB+2rx?=
 =?us-ascii?Q?WKFrBu77U4eeb5cnb5ZCrYt3W4BGnVOYP8J3dvbSGsf5Inr+PKymIMjXH7l+?=
 =?us-ascii?Q?LE95PbqYjCozT09yfNii5HQ5JS8AU/CscfAdLo3j3Pk8qdBuDlIZZkikM/Va?=
 =?us-ascii?Q?3WuVEcyPPw=3D?=
X-Microsoft-Antispam-Message-Info: oif5Lm94stkybBB2ho/BIybbxwK4hITce2/McYI4oLWLsqMTIACrQSK3+XNxn1VFcoUWFnasCK69KeZSday1p6ZMCtRam8kp1gIhB/MZJ1wcJzxsNvlI3QWrQdeZzhh4AebPFI01+5xNwwRwdJ1RD+tQ2j8siKxVCBO0UVsdmm1twjIVcDKQB3tLtvl7Y2cwcMIj0uNYXyPo8sLsR+mhz2xoAAkiPTFLGPDpHLzYMNPw5YlljAB9f/hutay67umuP1Bd80L4jZmLUYJJUsy36mqhl2h1XNXhL68PAsO/NBiq4WBUOTgPfHQ803NeWjFcrtq6xISmoznzWAwWDJv458dhtWMHAtniHSDlr7fBL8s=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;6:+GbjzBHRT1/QULBDXLyvGuUwspNJdB3IotPWVac3PAogzYPAmssMo74VLXqBKowkA7Pz6LmN9XO5C3laEcvrqDlSDkLaTqX1L+HvQ60aTMe8m2WyQ874THxlTEzWJJjqxv3e02bbj838xYF/vYjwiVNJd8ifEhDqWK5KEeYHUfSugYaZWSDFROSeJN8X+z0fMhldYqPSZyGTiGOg47v8IkkLm5h0YEQEDLtZe538jXICzlinb5yb9L6O8LGL72F86z1I8HL/qNWZzrDtmK4EG5xSpBVcdI+v8qYKx5mcusLSuZIFOYZrtwJKzUkkcxOBR56Ru3EWKQmduzN/Ar5MEz0kQiVUJ3CCgwn94a/2RYOgf2IG1PmKhZN/X1xURbnkV/VMqHJK3wKmdQkn0Sots5lvz9u0Uz29Lfi2FsbWGzt20JmJAgaQ42TCwB+v1Rqtqh2TkF9eTHmJKQpnd5HF3g==;5:am2BzAbDdai1nOx76oeQEu9GucOZy0hlwvQ7LpyMYl98DgWbRbJVTs+EqO901uKRUiyDBzkMLfpFHqdbvF3w37A2rcm4ReUdpz0FQ9hvy8ZSgm0Lzy3/z8LNgKbkRBvn7odZJZSQ12gBahEf9RjmX9anafg8SiB/PiDNXFXP8D0=;7:6Hn42DVYaDeP5hmSUYMBKlhmAPqyP8Prv2WDjL44xWv2qhX0Vv+TrHORDGwv3W4iG/5g9cbm7D1V1SC+CPDDPTg5IIlcpy/V7Q9q6iY+1GFyxCtoQTX1hIm+fbhwQcvf1n+08TmG2sBTx7yqRYKw/mMF6Mp7jWtqNgDyDvOvLHJtISdUoWTHC5K5b+srjpPVSYb43LIRHFScABZpAp9E86ZyeGcMBoubHZ8xPczwNwJuE4yYG8UUc8hMIQRTu3/0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 06:55:02.2752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d16c8d-ecc0-45af-3a66-08d629c64f0d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the xhci_plat_probe() to set the
controller as wakeup capable if "wakeup-source" is
added into the device node.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/host/xhci-plat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 94e9392..602e95c 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -210,6 +210,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
+	/* Set the controller as wakeup capable */
+	if (device_property_read_bool(&pdev->dev, "wakeup-source"))
+		device_set_wakeup_capable(&pdev->dev, true);
+
 	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
 			       dev_name(&pdev->dev), NULL);
 	if (!hcd) {
-- 
2.1.1

