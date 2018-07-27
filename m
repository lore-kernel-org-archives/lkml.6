Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB862089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xDJcAGNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB862089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbeG0MMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:12:21 -0400
Received: from mail-eopbgr690044.outbound.protection.outlook.com ([40.107.69.44]:27190
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730784AbeG0MMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nXQR88Hb0Zb3QWsbiQuxFsGg2QMQV2xCgLqMFMGwHw=;
 b=xDJcAGNbxtOn3VIgP+v84HsAJ0nStRF3UqKXyC2E7C/q6xXJCRfRFB0LZ3ZNPVr54PQf+huwcHLR+Y7A/8Xap25Z8l8mYB60gGPPY7votXPlFg23I4TzRtsb/la9MC4OH0ekmdQ7T4CgH33jfT/R6XcDwBoguXzEkOmKaLWYOT4=
Received: from BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42)
 by BYAPR02MB4455.namprd02.prod.outlook.com (2603:10b6:a03:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 27 Jul
 2018 10:50:55 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0101.outlook.office365.com
 (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Fri, 27 Jul 2018 10:50:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 10:50:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kh-0000O4-CJ; Fri, 27 Jul 2018 03:50:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kc-0001O0-8l; Fri, 27 Jul 2018 03:50:46 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6RAogvP011876;
        Fri, 27 Jul 2018 03:50:42 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fj0KX-0001NN-QE; Fri, 27 Jul 2018 03:50:42 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id F040DB20796; Fri, 27 Jul 2018 16:20:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <lars@metafoo.de>, <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] dmaengine: xilinx_dma: Minor fix and refactoring
Date:   Fri, 27 Jul 2018 16:20:36 +0530
Message-ID: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(2906002)(106002)(316002)(16586007)(48376002)(52956003)(50466002)(356003)(2201001)(42186006)(63266004)(5660300001)(110136005)(36386004)(336012)(51416003)(103686004)(8676002)(81156014)(8936002)(7049001)(305945005)(81166006)(36756003)(47776003)(478600001)(126002)(486006)(426003)(6266002)(476003)(6666003)(54906003)(4326008)(26005)(186003)(90966002)(106466001)(2616005)(50226002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT019;1:bXCB3fV/lzoDMv7xG0CeA32ii+NdgPuSBZGKhJzdB2dbPnXSPe4EQftpX1IhBg3x1LjIARESN3ViQgnxVaMY8+ehWL4QX7MIpWb0/v4ypX27OGBakpR3vfZ0J8v3N8X4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0880a94-5bec-4313-03ed-08d5f3aed39d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:8UmQBYw6FDgg/p68WHyZxsaBsuwp/6gju6ii4ctM/DJ6M29iVpDAhxw73AZ8N7fYoLiJV5ySEL9qKqQHxWE8dA4AdjZQm+BpeHAVY8twOcbrrYNzO84m2QCnl9RqEi/9dwn/p//3RAUIS2tTUPL8MX588xf1hCEaKs5fr536R8Edh7jWoKMj64ZIDaA7kNCFuC7Ei0zCBtYOCEG1Xuz/A6yMSd/8LVIBrQTtZzMTU7RdDXXPRBlryHjAYbWKRswL/GpQOw+xutVEPzq2ejusGGiKVrBLAkutGLjjgmXjwvAven2y53JGFlRa4PYkIRE2XlE3cerC+LoVGyyKJNl1X/x2S7Zj7ST4YBRRDlFEFUg=;25:ud/PSDkVAegoR2mGpSE4XIK5GHgBCzAV4seRVkaqOC6+4DgdxRc3NFwYNFWUsz1xZ20GZRJ4plTQ/EoJV7IEBJ+woq28h3hcB2JdwKhbI0fCDobEebulaSLkdoOG+OzA3EshJJ6JernrQpDkiOotZgac+qD+O9C5L7QOl1R7w6J5lEQSdZj8BgGBwKKHwBvU9QT4DUVs0xuvGuVomccWAZ+/EkimzT4jeDg8TRjgjfQlAmlS/tjPGRwqlzfE0Q6Uu5yPDQjZrkGSQHo0ZlT7QtRqWirNcqK3qhIfAck90PJDBHkwga7+O+6Hd8gm+3KJfqz1DLqo1xcZ/+KmNnm5Kg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:4P4VbvERZAvxQIl0H09WBp0sfJmUBaEaKDhbAOrSYs5FhQ6LU5a+5XtVj0pLKliKXjxoxZvti7u5/M00ha7LINIa8I4rpittueUn1fcWzjkeTWIHHifz4cDNxmel+LyAWKr5r0PS2JN8TFnnHmwrlTXi7t0nUgsMOHzdtc5qKQ6V8YhpuxwoUnd7lXm7Hz9ea3hlmsAgmtGmbEGt+Bt/l09Hkc1Pcj+QeQZFyc9Lx/0=;20:DNeuzcYadODn+8bk9oVpRKb9b55W92rbeT+/xG94J/CzWaNgW3PB2qoWC5XLzdWhoY7Jz7zyV6XMRWvIu8G99MhEdyxQxUSfJmcNL/a7PoScRtRjecPjHnUI3r4m/LnzXKxU2dR1vSUEwWsUYgrQpgdsMHM6WDMhtUFhTjszOjECOqyCrbSiqM2iDksG7jKbGC/F2b68OLF8tRonRuEcfSNQrMqSeJtIWvQIZspjmHU7d0gwQ5emPOOqtQOsBNk6hxqIhVaInfGv/TbrgvZV8WTPJt5RO+6NRAnUxpeZ38NuVPiQCcRnPtQZapWzoCv2H1f5hijEOIJsmFPtcw8VyF3+swBxnJrbLifomM4u18Tj47JyvkP6G1s0RWOUZRv7epmHUcLVKF3YJiKKW7bu9hAOG7mIFPTdcYAylsHEEAocqtsRw7O4t7FI1gUT0h63mRurd0/JAY+o2XGaxe2rmIEH9CKmFOUlQyFG6AovdpgD04+0jZo1dB98I0SjZGga
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44551D283CFA7A78D614761DC72A0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:qM9wvI1RpaIv3MY+XutqnNf7N1ORNaZbKDvlckr7cWT24KCoRP/TDiPIICy6ZVte10ED6QdoL4P1xpBMZPpyLbA++H6F+V7NVm3KhUao6wzOBBySGTf9h8vjfU2SIRubOX6GsfmuEjzuuX+SCGEw7LugbCba9jLmLCLm4sa0+hsiEFsKWn5BDqKa7NDKpnzuKEwaOznckFJ7HNdyo06XvexdYIZuPC465SrrFEPDTQO9pIlgUqLJKKDINzqbpx6zSr+J4LfBqzr6bJEVZHDlTg==
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:FMZBoa/WMYSFoj5/5cfIPa3L4Gnc8z2UQ9uKRQDA2?=
 =?us-ascii?Q?Tz4ICyn5IFiMbcenWJf/CnT+HcKGwEeojcj8D3H5/5aHmJ69cQ/+Lh4ZQ76b?=
 =?us-ascii?Q?SHdt3cS0/E+4ILFc6K2nHUQ4Y4X2IaKQyUx97laitV0hYoQqOo4MCKM5tcId?=
 =?us-ascii?Q?JxPUeCSF2ssPbO8IarmmDU+Q7QJLvxBpAU2TmhLh0nQwjU44ojuYTpqwP9HJ?=
 =?us-ascii?Q?LCRp3hnsTzrBE1YiN/bioIKxOj5d2r+qmgR3xl7Ju9S3k054OcQHljYNiJkV?=
 =?us-ascii?Q?ZsVwYpOH643+3wmoByv5H4+pM16j2cf+Bb0ZyNMV6aD2rzKDZJ3liZtYElNE?=
 =?us-ascii?Q?7282mILo+AZqv5/qBNmIY3kVdlROK28oyL9dd0yMJ5siyoeOWoBKfOPZkVTx?=
 =?us-ascii?Q?7Vzvnt1iD0FzmmmbWtXbduScs9heWhDIkdMlCSOJ0Mp+Z2RrxjJVdivxJuJO?=
 =?us-ascii?Q?7RlyutUJJ4njza09m3Bek5AbuyHw4Cs3sqroDaOzqTyvQE/Na+mvuK5sSUHx?=
 =?us-ascii?Q?igxRb/uAgTH7TGN3K3jHxLG6pWLhUmv7TPm3XfTqVboPRp8Pm9yqVCMWz0NC?=
 =?us-ascii?Q?cebzrBP3sMAYqjqujrtOkxApzz3X3P1+JaiFjwGlg+1/KFS2ZU6hFvk/95PO?=
 =?us-ascii?Q?WmOYKhhLo0GJjGiSRnV2xwk8ZsQj/wOxbgF6lFHOHD2qFFhxHVoh0kvw1+Vj?=
 =?us-ascii?Q?b+WgNXoypprJxeQqkZa6wFpxp0OUkdVo1a7aH0/G9zZKx7D7t+QU0GMW92fH?=
 =?us-ascii?Q?MUkoavv4md2zYoxWQWttrcODK3wpclvVYJFWmWNsCf64PDAWbmvOTQAgallV?=
 =?us-ascii?Q?Xiff9EBSXLHYpDMydLmE9WVg1ff8MI/8IqEUX5JdLEcg6Pvna1eDhayKKLQ0?=
 =?us-ascii?Q?CVTFXtduuvsMhqQ/KB2moA6s6UjZas2BGtYOxUtcuo2/lO4Pvf3zqcTtGefe?=
 =?us-ascii?Q?CKbdUtNwnjGLzYO6uzmIumIgFKyvltYx9wl9qAjL6Cn7KXAwIkPYgrFo+0w2?=
 =?us-ascii?Q?5yGYQfXdz4Qkxna9g+AhXNqXg0BG6w3KXyTfAK0rm18LumlmR/3eUhfUbfXp?=
 =?us-ascii?Q?2CFMxAjFvv1R7hlkccKj1M29bNizazO3HFUiWuHqbI9uNPth4ya+EGA9wFLW?=
 =?us-ascii?Q?ZYGfF7MCMU=3D?=
X-Microsoft-Antispam-Message-Info: Vo/lSppBVCd2cuprQ3fmze1QIj4uMhfFQRaOZJQRFgLySoqe1C/6kNsfIx7QWhqF1p4pw4kk5Ddvk8CvfYvuBh8+5GU6HhZltDV4heDiLX292mzBR86+ctTGtQ0sYF0vBekVn5guzobt/haHkvYLcNcxEIdJ2+D9skt845juJ41R2l1WIChjQIuF+RX79jGfg0fU1AzI1eQJ0VWK+Wkx3MCINmzSm751+ObY6zOi5YAeDMQKCNPq3/6q/dt8I6wOTUr2DDBFz0Lvft6Q8BzLeQo/vuzFroc71My3F4DKqIhqJo7aHi2dFWW95ab2eOUQECzShW6IVgwr5lM3MvA3Iw+cjvtZc1w2YRPFDeLeGKQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:djzzhruGMHcZy9FlhDQHdiugNmDMZs4msrzhCJUHnBQDr3sc+YBwq/+M+agVWZTx2YuDRmT3R2rfv/Ckyw2f3FJHPEYEahUfOkeT3j6aHhUcgExJyfMu4pYEsCUbTJX4BLspOE2VCDZLvm6Mj4dF4nvwPcv5c5V2uXRf5PR9mGPaPQL0/yZ04j7ZI9xFhk/qccd4FaNVNB0AI+A2R+d0Mf5jple7Qvb8nbaU4mRvsqf6T+EeZQvcoSEV9jMBQXApmvqNgxCNHQbS0T9q2FM2hdQx6LzXzA/uEcHBouGmnMj5bzt+gMpOEZexcMCECC6A688P6OFJECRaxnN7h0dIZxP+t2u3YJFuqngXZ5Esz5L2PBaoy+ZSXUC+BXZcBaOTbHeBmL9sG3gsR9FPzBzAthJGKk9ok/1tch1uAm685vFUCTfpreELIDtV04q06KbEkM8y/iWwOrTFi5BK7DNzFQ==;5:lFfB/xJIjh9tF1aoncgGe+w8xj0sl7BIm7kJjhEW29qxu87W6QOyTCqbQt08xb/f0UMZpbmmk+fW1bCLxmoX69bsH4Ii4vIUlYfaBiEHaM6rQlMNaV+0+YtwcI/+I0d4RClipgh75uZ2/f6mLR7issL+grA6sPh006GzFwbzpwI=;7:EtDPAq/gF1dsVRquNQ3bF5r+flRn3HwUB5REIYnazwb7BE094439aeye7/Oj9ls3vwXZMjpI/MjKDdswBoJcyX4xt5WzwFyeuS4d3SCXzIfrY0ShfqADEcNNPsr6E2f+V4u589eyYvI1ZvkVLmRorxpsjLJ/Xa8QMKZVC8GZhfA3/hi6D5MmffaH8tNppO+b7tg5+4+m2dDRiMKP8KeMskD3RM971lzdpSDlNMUlvjYQn04IMfpb5SvBVDPgJKcd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 10:50:52.0590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0880a94-5bec-4313-03ed-08d5f3aed39d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes 64-bit simple CDMA transfer.
It also does some trivial code refactoring.


Radhey Shyam Pandey (3):
  dmaengine: xilinx_dma: Refactor axidma channel allocation
  dmaengine: xilinx_dma: Refactor axidma channel validation
  dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer

 drivers/dma/xilinx/xilinx_dma.c |   46 ++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

