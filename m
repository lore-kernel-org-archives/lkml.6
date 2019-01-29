Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B71C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F812087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1Si2548G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfA2UjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:39:00 -0500
Received: from mail-eopbgr760044.outbound.protection.outlook.com ([40.107.76.44]:43487
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbfA2Ui7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9KFacYqF/RLSQR3qJdWsI+iWk7MojEvOgSu+jBLp/g=;
 b=1Si2548GlERwZojB94Fb03s38wkhs4MVUNg48U8n6NwwwMY082ON2iLEkLhmRB9WOTz1pI8M/VVQ7MBckBlvcm0Uicw4bTuquJ76sACoVA43qRR3Y0vuQjz0GzPHnwAgISIEoKgNlW8o/CbiGan1KQWCPaLqWij7ztCMaaw2xfM=
Received: from BN7PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:20::40)
 by DM6PR02MB5018.namprd02.prod.outlook.com (2603:10b6:5:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 20:38:55 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN7PR02CA0027.outlook.office365.com
 (2603:10b6:408:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Tue, 29 Jan 2019 20:38:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 20:38:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9k-0007ip-Vp; Tue, 29 Jan 2019 12:38:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9f-0007aV-S5; Tue, 29 Jan 2019 12:38:47 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TKca9I023878;
        Tue, 29 Jan 2019 12:38:36 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1goa9U-0007YY-F9; Tue, 29 Jan 2019 12:38:36 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date:   Tue, 29 Jan 2019 12:38:18 -0800
Message-ID: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(478600001)(72206003)(966005)(81156014)(48376002)(4326008)(81166006)(2906002)(39060400002)(106466001)(2201001)(6666004)(356004)(305945005)(36756003)(44832011)(6306002)(8676002)(107886003)(50466002)(426003)(2616005)(126002)(476003)(486006)(7696005)(7416002)(26005)(77096007)(186003)(106002)(36386004)(336012)(51416003)(9786002)(47776003)(50226002)(316002)(8936002)(63266004)(54906003)(16586007)(110136005)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5018;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:YvFunax9TqgkbaOb3hBQ89xtx4oK9if0H+P75Ue0jOqcYZIXleXt0BKmk4YMlpT4u6ks8wrRox00a7AwM4xnXC711REPUF2+fhdoZ6BHM55NsCNBaPOaLC49OkEDX05aR7d2tp9FVO79stc/5GKHE4GVDRgeAf1jepJOiyPfA70=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b6cfc8-50d8-4b32-94fd-08d68629c8df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB5018;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5018;3:vwdAWYc1GIdO0VEiz0hEcQ0uH/2e8377ik4J3mOZFlmJFs3+cFQERav0vODwT7Z95ejCAHtNjBbK79yUPFu+lRXj2JVirGLuMBUID6ponH6/uVf7YdBhFnxkpxwM0tDIBx0oedPhxQxvWakQD6g/fa7kfI76Hpv126Ql6cFseanHU3TLuMv4IQFNvhXr1r2YqLUhPIannsU3sfxykMCLUheR7TyuG3Q72Za13oETfO5wAzZgYeYqI6Ky2LIBE4tC8loopCD4VOe/KEHmzJ2BNwVE3Q9VCzObQQ05cR6fKJs3lgdGtBnMP/veBABTHL67ROTgV0dkmDKrkFSKc8k1PyCfF4Iyd/Wex5JJAarE3VSSpzln/TmvCC3YnMbJqmES;25:o998MgZvNpBIMIAL+XfLCj5lI49y63bz2HVjjy0O1A/A7bLqvUl7NKxbPf1Be3lfvZqnYQWRRo4QWUBywnLaJfK2IEYLVAYNPnza+ssLtUdi5eb9llNVRfAtbwp09bXiz5odXliVK1EPZ0SC0DKiqQz8yfsc72AOfeNr/oON0hyoMZZeAYutploZBrlQnhN5Xy5iQVRemjG7MhvTIKhg/K3pzbK4NagKpbUuBC+u4LEHpeKtjHVmnRrojEEsLhhaT9WdgsXz2wJ7uBbHWB55/+xygwBQNGfjW6OTqgw7R69+JLs9Ibzp+NPyFH/76rHE7EEvuRuPjAiozQCBppQJuQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5018:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5018;31:9/0kQuorZ86WmsdRAoAsuj7i+qKYfMs9nNji6OumWm7iU3nIdCXErC36OIw/cef2fXKbLqM4tuI2YvBVgsCtghqoEPkHnrzRPxoEvhrAmbgKCyf5Vj/H+RjcvxyzZFNGgxRYmO+hVqkGlzOSmVEBgsqts6+MReutzTvcTCU5abBErMcG7xDGcn7d+LaG4WEzqJfYNPH2jmuQK8KEeAQOsi+/x30Zk0zrvp6+SPY8qr0=;20:S3hT2fCQbH/Y6zQAaLZbxJ3i852qs6VjZez/iJ4IsGuRhdqfJHDCbIorwwSq9TEOG1PGS3ElVgqPogEW298X+/BQ0TCPZOYNQGXKc9a1T/i2j/bI4BcplUgitGPtS8gUbVAQ5ntGaSwb5MSMCJya6QQNZrIdT+ndN2XdSYyFrtUtwPfg4wA0cJELhxyqenDGOlVzzCJoiYwqRoXnclt9NUOnxdT3SlVVbgTKWPy7ouWYrPd8ebHJSZMlsX8gM2qs8QsR6Zv1RZE1J/qj1qkt9sPml2ZANIv1w5nifXjejM/9v0j33obWTiB7eSiF3gqfPl+1s1ZzCe3Va7TyEvpWhTWCevMluOJ0Grx+65qc+7lp/Yg2BynwCXC47Q+cOlxeXK902AeTjZmTl96JuD+RyFhIDem4TmVFs4LLxPiy5zDN8eoynfd8fhWuoDbo5EZefhRHo4Ab8cyrC8PXMRQxYsLYP/Esy73DzgjhCPsY/9UqchAD/XKWuiK/Ikd66zNs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB50180AA7616508488263C0A6B8970@DM6PR02MB5018.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5018;4:yvIQ1JdyAqqplN8d81PiNU4YjvFbpNHzoHkc6Kj0mZnI9jwD47KQyLF/+RkCu+X74de9QZp35kOwqzbUUjBJvrsNVQTeyFP+wXM3nbv4jrif2rIF9+Dqr6PD/O0vP4BotD+VZDUJflPc9JSLRGkDfoCyogX/O5bSVG0Qcj2iLyi4oku4zxTPIC8xgzg9JeW3UCySRrIRZtBIUqBg4xz2Wjtp5GZFsrtkr34KicP/whqDJygw8gmvcmgFFrNUo5o4fTNY1pLixcMB5CTVJI55togIZJqPkp9h+kdz6tMr+R6VYsZyRzea75BzPej54a0d
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5018;23:Dq7eo5ftgI2CN8ZlTk+xNrRPJvGHWWJi4jtChkIbo?=
 =?us-ascii?Q?Nfc7fvkpw2WEbj6ardjvspHhj+e7SmXsixv87hb8h+KN4Si/mKBg9uND/5kW?=
 =?us-ascii?Q?GNzXBl6GJgXsFvZFf0iDfXT16tKX34LlulZXQb0S6Kp+0uJ95Ke4/aIH41p6?=
 =?us-ascii?Q?zGJDTI66tqo18JCTS1/UmsLBfivH8g8W76JdYD73ccAhltcyIdcWGhTTGO0Y?=
 =?us-ascii?Q?TguvCjOXeX3FuI4ny1QNCz0QPQHl3QN+YtgRv25Y41jGtMrIJE3fhp8ORMTG?=
 =?us-ascii?Q?ellt5MZRE7YlFZQe6jrIoGYV2bCT+lgxV+COUTXUclsxxLJm+uAWXvL0uhKw?=
 =?us-ascii?Q?oEGs93eHJKNlYBYbu/JN08EbsRrA6+qV+nzhAEjh6yk66fr+D9tKaGG/yVyv?=
 =?us-ascii?Q?2YLmenLLVGI1Q4ywCn4EqEc5H7sDqrRyE3kSeeCO7RT+LXKO208p9rTNl516?=
 =?us-ascii?Q?aqi6SqCy79yK3GclYmsEb/rqD0JRZJ213Rpyq9Y2ezJ91XKikLAJZKnqbqFt?=
 =?us-ascii?Q?/rS8p3Puk0Ao0DOVfcOuucsVa6Jc7LyeUIPS/H/wnbFSqXZEKtpbHmcTVJPN?=
 =?us-ascii?Q?XIieZotibR6GP4Ovdyf/9ZsJg/GGF1YN6Kwtl4DPslV+arSBFgmrkGcgaKvD?=
 =?us-ascii?Q?UB9At/fN4ha+Q9bRcrg4dkE7lwSBnFiadH3u9C1/lyzxO1bDp9A3VqBnon9u?=
 =?us-ascii?Q?02zU4Iq9scQ/IbVJMysAUrwiPnfh+LRoO0Hw10sHWFeqQCm7Fg0fPaAk0H1H?=
 =?us-ascii?Q?Zr6ZDdwUu7sKNGfn9Hwr6w+71iLyqySTHGOTouXkFrZ4J7jlpzDFKfyoIzWs?=
 =?us-ascii?Q?Tpd5ujUoRX1P+AWrjT/LoVTfdui3xA4av4nLI+406b2OEkceRb149LBKRfqp?=
 =?us-ascii?Q?yyGWp8y/gTUA5NSsp6DFgH1ZoEW1JQs/nhL6txVTDXPzxbDbeBsdJ3NQ4AVa?=
 =?us-ascii?Q?bKfaEUfC0qCTIPz4f8lJWVJWWH5PUrGXCgFFac5H3CTjxZyE9KdmvyIBBOuY?=
 =?us-ascii?Q?/Jt4c+1GH4x/EqNDZB1t1WQUGGcaxclPNt30AO/pn+6cyrHToxsYtCv0bYss?=
 =?us-ascii?Q?A9iKtn1SQbNJork8Z4B5EGe7KlOv+Ps4bMfNcgPSudDAVRlvoXyveQFhh4yE?=
 =?us-ascii?Q?5f5H0P1vienTzFIvAtAnIomaD95Qr4RJ/O1PJTcvktEnvy/MbwGGlFTjDCX8?=
 =?us-ascii?Q?ozWOEVx6uLyujHmzA5TpZBnv5JpjyqpoXmSefaLqQMZuUZ0jrPlTXIETw=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UYCVcaIUXtk5O3cUqMSSflvqA/FcS1cdkT/cOirFKctTcCzKxq4sgiFrXwDXSNNa9iyZCmODfrY25p/INrbqO4QaadobOJfSUUeZOUntTLRSoRedks9vXp4CiSNvIBriZIAF5bB6VR3DDjOgO2lAJyoEkpsI//NUte069+Ny1awJGrb/uaKajEuN7FzmZniCzHjOgE8PnJiGnDypydOJZoT8INIhW2GffDB2qtTl+WCtat+4M0V9yC+qociYb7nTu6ejM5E2QiO6nvNqNRNWJeVy+xt3Y+h1NGCjU1UfasfS0YAE00cqqDK8+n6KuP3eYKunTR7ICYEeu5tCcmk1aIlX2LnG2Yv7An2ky2CTzu3ZUbnJ1kK7ArkRF5pbj1LMgEtXAu7fwXlJNtKFPfl/4rr3otPNSfwBZICZb5oJO3E=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5018;6:AdtKY0m5pa8rSNV284hh0vs1AhIWQabFzqgEHEaf1PT75+x4PPDDEMoHNUUbEMTqZoEZkNrOtYQygv1zJSgWHPddF6E2FBW6A4Ed8dPyK1aNcrWI7Cp347DeQnhEarDlAUtW0E54urDAEVN0D+ZgN+UQWAmJRnaiN02Fn1JmU10kL6UFwjaaKG+pHOIh1Mw1euy5x0/6t22DDZpqoaaEyg9d2kJ+t6osm5wYAMBmjljcJVl5FpImk5EUbhN/X5cvunAJxtMJp5FAWfHUkUNua+U1v5D/3ImrfT933zL0msSQ2ljKKTIT62zhfGY8qWpJjpHyX4I/+YHRhl9rdT0EnytjD+1Jfm0KGwCkZ/RZOCD70LyS4+rTaZTvIMV0iePWNdk1JSmGO01zlWjq1d/AliV+4y0eKHCwuJYSY2OsL9g8NkZZN7k/70lVQlrZNB5AndkSFqu83vMdIzZnaB07qA==;5:DsibzuESZnTseWPEmefSrD7fCUINrzTSG65pqmJvj21l2TC5CJxeVDz5PBibWFqbuuTYXNqHbrLhtPL+2BX9bq662mI30NIpFQf/AZC3Ae+8OMtI3Od+umfF2Oi41sNCSH0Nqs2Mb4dUkb7FfStkX40REAfcP5ZOxF1uofkrgzksBRfHQRrqpYBVNoi8IcTA1psZOk6EAfGZEtD2raeEWg==;7:w//7kv80k7ByuBwaRCo4eY15OwZEBj6n8U8daPVTrSqSx+mLnobZiQsA4UjsIaFH+QZxNiJVyF3b5T6g33Mqt1tb/SYRR48D+aj9g54dtPt0l7x5lII4I+EyznOCMfWAlffKCNgturuF/891mrLYPQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 20:38:53.4295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b6cfc8-50d8-4b32-94fd-08d68629c8df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

v6:
 - Rebased on top of 
	https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
v5:
 - Added Reviewed tag for dt bindings

v4:
 - Minor fixes to address v3 review comments
 
v3:
 - Updated DT bindings as per v2 review comments
 
v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox

Jolly Shah (1):
  firmware: xilinx: Implement ZynqMP power management APIs

Rajan Vaja (2):
  dt-bindings: soc: Add ZynqMP PM bindings
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 +++
 drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
 drivers/soc/xilinx/Kconfig                         |  11 ++
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 +++
 6 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4

