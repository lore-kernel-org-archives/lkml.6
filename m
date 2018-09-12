Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4260DC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933C72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vxF1mpFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933C72133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIMAqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:46:23 -0400
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:26992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728102AbeIMAqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N/RXQt4pqBadGTRK/wZH83Q0bP12sILNZCnlWFzEEM=;
 b=vxF1mpFhBYv2pddu3vCaDk55rFa8lCcuo92jyesM8SpRauP7j0ea12OCF2TBM+5pp7rMxSL1jJefZfI9JztRgVUdEsadk0saYGGfz+c7eajYu8vFm7gqVqvAWGL4uO03rx7kt1BGtaMLEhI3Wtr7hqFxckgtJqfQkFHYStRM+Xg=
Received: from SN4PR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:803:20::12) by BYAPR02MB4472.namprd02.prod.outlook.com
 (2603:10b6:a03:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Wed, 12 Sep
 2018 19:39:15 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by SN4PR0201CA0050.outlook.office365.com
 (2603:10b6:803:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0002S9-BJ; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-7l; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwm2003385;
        Wed, 12 Sep 2018 12:38:59 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-OX; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 4/6] firmware: xilinx: Add clock APIs
Date:   Wed, 12 Sep 2018 12:38:38 -0700
Message-ID: <1536781120-22794-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(336012)(305945005)(6666003)(76176011)(8936002)(7696005)(106002)(8676002)(26005)(50466002)(106466001)(51416003)(50226002)(110136005)(54906003)(186003)(47776003)(77096007)(48376002)(63266004)(36386004)(81166006)(36756003)(2906002)(4326008)(316002)(107886003)(81156014)(446003)(16586007)(2616005)(9786002)(5660300001)(476003)(426003)(11346002)(478600001)(44832011)(356003)(72206003)(126002)(486006)(2201001)(14444005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4472;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT010;1:MigewVT5LOozU1wOEuyJrkfH8i3BKIIGw/PNhGuxzDosA6wPAK59QNBTB2J1g+IoJsRSUTs0+xV47T73frzLHUs7L/MJrZxtliLDVXAN1RX29julD82dX/Q5d8Ql9YO6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3374f2-44e6-4620-4390-08d618e76c3c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;3:g77OE/xULxCNdkMspXdvBmHMAH+3QwYiONmGlcSKuL1AgaMYBb/MPPEh85yRit0TIoXTZqbC8+u0zNQR785XCiNANFhzVp5e9NUgdeo96iSLWl9FdpvnnPKtVwfjytJppUXSZGh5rl5kJD1uHe07Mn18xZVtzYaefm80CbyQ+lX3ffIhs3JrriW8+TgifdS9dFQPvdGBQZymr+OHpfemv1AOnLOKu3nip/Hfv2q2pVReEx4IxZlkxD5adk1e7u6cgTGsAMeJyqKDn3J94ralGnmvl8B3uJBzqM8W6AurooCe5ig/Dxs/CdOGc8ObmLR3ZpIhYKoN6d8T45WXiSO4ftwASQzmR50qMp0Ci3AfKuI=;25:8UC7hzt2cwpiy/fMW569L9bJ1i26VnoI6EE0m0LYnoV7L7fDCTB/JXs0tUGxVPl3R3eB5r/GgQuoQbLZjwy+fSmG2ICm5OjbI/ulGFLplfKnWdZ30BpK4TdXJnvI3jOWKz8fgWI/rYmgjyut3SYVmEhDLjJYgi96spzhdGeTdEX4uhc6luKxmtlPBrPTF7/61a6ZtxIc6IQWTM22wfWvt2pG6q0H9+alOewH6r1olyBm6mMEpiCMR0m2Mapn9YZ1yILtFkXTGLJnNINhxCLFkdhhyB6bTbIHvXPa5hOEZXNqwB3MEaislhf07jQZDzD/tqVP0lMY74O6035200Ie3A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4472:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;31:k6HDbQR2L5QZc5o9oXblo9GicYL9OyfjOQx6mDMG2TBi4GpeJ93IbvCHA4riUOV1xLXC8mzNYKbgWoBvEbhitjINfUkirvLNO/s2X0kJF9np+0zeEupFTt2FqVMyS1V32pAy4QTzrFpQGwIhbMoDy/1zJIGWfEWXufO6S3UlkHQzXRqP7cgWTeu3GKehd3fhMyXM7oXzD//8xfWes+W2zbNqyv8Rj6DXC8pKctlJ+2I=;20:2EePxveAV1dPn7W3flbEM4pi0onAz07aP3d5oAQL2imFvq5LvUcvif1KXNYh1U/5suqjL61dCsZfA5Zjl0Dmrbr3lHim4WxWWSqOgBRb93b/X8MId0LjUHlwsjz0GULCEXhtuowFPKaxiC39Lkm/HhyVE4D6A6J/aAEjkJZA6FyfRE7Wiz0AlkquVYjaYPA/Ycjw0gdeOF797PN4q0Uz4xpE+JlyjeacJQo09gPZb+VsUEprZqw3bCfWIJu8Xw1Aiv2VKu7RYgL8VmHBQ1T3xLckq4GM8SfOTgCmr99dQK5Bz/Fmtt1guhfjEy44rsLPp63KzG+ObyWpasNAAnYhAkaU11XmeP21tmcESZjEGMzFtB/L7zeS0plawfWPUuSLHSFhLB6QQU/0p91Qixw+Jxdtb7ZKmHhsmHH9hRRxEUaEN0X9pk1c1DrFOnFwuV+8er8ZWx857qrpFnRcJIVOd5qZZrxq9xhO5sn/RgrhokmY8+gihQu9r2Hr7pNO47RF
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4472F8AFF7B0903759FB7231B81B0@BYAPR02MB4472.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4472;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4472;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;4:Ki3JtH10o5V/7ptzc79H1jFNgwOgNDD1K9kSbPq6uEte8ddBWXJwH9spZKp1Ojf3jCpZ2GB0eEeKqGm+BS/JTVkoeb/YXENNP4OTdeADbf+HP1O7Eh/w2vw6xSpAWCgmj0Y2Iz5G/ctlL+ozfGkyqvzRH/JunKM+k7Aw4RXgiNy4P74lttuLEuQXunUusF7oFazy6fp9otEUF6mU0k0vHBweJ9UP8S5RzrSRrZ6T3un3L1oSvigrxnNESX7MYecWdmvYsLblE4xsZyOYc9d9DvEC1O4C6WvdQ5oh1PGZ6+WOHBzi7tWfnlhYm5beH7yh
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4472;23:fr9ATjmPAbhGuqGhAmj9lBRN1OUX1E0DsUkkYnVc1?=
 =?us-ascii?Q?cVWNbvRlG0K/yy13hJ3hAJopTRrMyKa7canIs28M7Z50L10bfzA0QQTL3jNL?=
 =?us-ascii?Q?lnginJoL8FnzQxUJv3NIW+Zo66HugVfHNIws76c0fDphZCKxkRBpyQCSp4IM?=
 =?us-ascii?Q?Ng9/uyIgROcF5kdfAl13jsKaC5ZBlG88/01R2FONc+UTHQbaVc9K7b0frmKK?=
 =?us-ascii?Q?j7PHExvIhVMDebojEjR9EjzDwhSIlPplRE+L8ev5h1LBGkLFu7R8KCMBg93e?=
 =?us-ascii?Q?9Ky4lwnmEg3V5tYeZaQU92Gt38m3S8Qv0JMH/5029y79uZTJeBrhu17BGZv5?=
 =?us-ascii?Q?S/4gnzyZfDmGdb9daOKf1dn58q4hg1Db5aP79Vv/CxeWtUKFoe20/GGZ42ra?=
 =?us-ascii?Q?sLoU5zk79H6Yl9v2cKrcOXLdu4BINuBC8VY4TJxwJw0JjG1wXUQEKCn5B+he?=
 =?us-ascii?Q?WG1pxzQvmt8StAoou+e8fRDp7+gQFqJc/6pbN5ceU2X5HcEXjPkFSuuU2Aij?=
 =?us-ascii?Q?ylxxMgpqMoord6oll80VnvWb/BI6kBohHpIqP/XCi7Wx2B19+wUXwDr04dRr?=
 =?us-ascii?Q?SitODDJUbzsGaCuiWFmBDiZD9DV8Q1iAwpSnO0cYHQSlgj09nPOGrlBs/jTT?=
 =?us-ascii?Q?MlbrnEez+8RvBfBae6Ob6w8PVe6SQdl9j7kuztg6vB5iTbSPS5HiTG7Gjxbu?=
 =?us-ascii?Q?WQgxcxj7lW3YC0qLYAR/MzvJyqrSJXxIagyEuroBdltOZlMaJcb9OvRUR+NR?=
 =?us-ascii?Q?3RBmSyFLD53FhNAXSAIoaLzf3Eqlhb2N8h1PT0Z2jfNG0IEYbX1fcEl7hBms?=
 =?us-ascii?Q?+E67XfKCk+7UvUPffeZfM6PshvU0yPn4iw8HXWbg5CrCMe4k/7WJV74DpQ/k?=
 =?us-ascii?Q?uA+t/RjqiO58bTItSs3BhWajCPFrZJIaD/ZHa/oP29G0HT330bOPzPxIj1zV?=
 =?us-ascii?Q?r7B0nWaQ1LOazg2ufOSFmIRruVMs6nniSADTjK056LIL2xvMw8ZSpTzZ9REL?=
 =?us-ascii?Q?YgDv/hLzZd22uHt1uCZ13GEYAuKytZuTBCtVqWfgCuHx4WqutaarPdERZZku?=
 =?us-ascii?Q?+nQyBuws85KZ/YMSCN2ppHY8tDGM4Qr+MhRTk9qUNVAd86AWEWGf7MaWmBDn?=
 =?us-ascii?Q?GwOG4g5v5ubnbfJq1Ox0g8Ly0eMgkuz9x4neDMLaVKzSyRuAMiALKJIk0iBn?=
 =?us-ascii?Q?LOZtNBZOhQe+aU=3D?=
X-Microsoft-Antispam-Message-Info: EWp3sRGVAbGyj5ZgonOqWgM16J4qiF228iJ+uRL/CAmy+Oak4su2Dku/7LlCV6ib7TaiKrZJGwEWaJq5xEOcIMGpblqalDsxvAxtZcZu5eZbToS0ow7kR5yFNjrLFB8kb78JGakgWrhuQXsTL26AWFlSNOZxmH3W4iOX/V3bXSYBO+c+7hx4YJnNWcLfcZaImtXe+VF7LDrs/oOwzZ6TfYDcmPNocVazWKnx5uOX/v6L5tQRcnRSID/NUiLaX1euqpX06WLk4afMgdzq4fzPCAhmyKA2R0oBYm0uxcTiEMTizN227Ue3NnQUzNpaZ03TMYPSJouYnc8WWGqH5ycxoR+twFtgu0hn5VVoEkBPgGU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4472;6:TS0LgVQPoVZ2PR4WktvwmMBK9pjY1TREdLR0PSHe/8SVyHgKtNPacbTdDVoh9lJ6yrCOkimAz7a40DP2AHnJRWvNKt2zJ3b7evyOKhCdgZUTA9Vzh1Q9qQMpnvSU8kXxdXWw/qRV9+A739WrWcwGVihHxDxtpjMf2kp9JqQMZ35I7VacFEpJS9JI6xO1rFR42UzrvAenZz3oFURC0fZNhlPBKufxQEFBNZfSSDobQ2FAW0J/Z9oUg6ROWl82QyfBAjyNUMiAXSr37+j+UKYCsatFgVRFpQoRZtaj7DdeiCxAi2J/AAZL4xwnTreukL4IX1i4S79b9A3h5uv/SzT/tvXXuZe72a0hsfm4KQYAf+ouV/VylLJkLmmAxuQF5oDYkS4f3Ou31WPwzlVcCmrDKN4uzWeJhF4pLGd55J8X6QvzAo01PBKKR9CnRyowHi5Ts4zdvT1eKMl121NV1eAIZA==;5:vFa+p0PIQU5UZcTJkgSlc/DbYl8f9uV7/8jYT/IfB7GUNsxh3O+bzNrmpTGZ4pxRDHDHymgqljts6BKa80/USWT7Ewl3zCKYSOrSfmfVHyRDgEM2vDK+dniD7ftwf1qk0O87NCsc1XryDsuPrMlil7E7j3Ala+6MfXD0DUNepHo=;7:iUcBdR5gQfgmYYjzPeAto/5p14Pgd2zx4p1EGgr5d2vCr0vxkSrvvrSV6Ii7paiUmWTeg/J+yNjoEggRkdHkbpfZx30cqdLzZnu20o1W+rp5RRXZOzqiKSzIUsUlp0DNPVuqxz4wuxzp+aP0UfpIpnEvyQxHaf+7RtNcvDLx9kYeXJv12tGWPTaQ8YRTl+lVSqlQ3sVhcyROWTBH8PmV8xUTjVnUTV2nNS8GxBK5MpXUGSosQ7JDdRtoWWr/MBpV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:14.9092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3374f2-44e6-4620-4390-08d618e76c3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2a333c0..697f4fa 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -250,13 +250,195 @@ static int get_set_conduit_method(struct device_node *np)
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be zeros.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   lower_32_bits(rate),
+				   upper_32_bits(rate),
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 287f42c..015e130 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,15 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_QUERY_DATA = 35,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -48,8 +57,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -69,6 +90,15 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

