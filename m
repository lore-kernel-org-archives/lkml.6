Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FBDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C08020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DZaxx5+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C08020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeICQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:34:18 -0400
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com ([104.47.32.81]:62088
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727627AbeICQeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmtwEw7kftSKKlgwgbjtyNh7dDKwZf8QjolAiZDV03M=;
 b=DZaxx5+dXqZlo/TRQZQAJcOH2OONMkwe+4UNSkEp+f2KNxONkwXUFMznsXDJmptvoT4lq2KX8plUau2BI0xcp258NJqzbkKgGQJ24nG0/mOsRwE3SNqcXWAXyCzlZAtZdvnpDAhaGDxGFDLJBVv1ZqoPzON33hcDDopMrdMZtJM=
Received: from BN6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:405:60::14)
 by BN6PR02MB2673.namprd02.prod.outlook.com (2603:10b6:404:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 3 Sep
 2018 12:14:18 +0000
Received: from CY1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR02CA0073.outlook.office365.com
 (2603:10b6:405:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.15 via Frontend
 Transport; Mon, 3 Sep 2018 12:14:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT059.mail.protection.outlook.com (10.152.74.211) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Mon, 3 Sep 2018 12:14:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fwnkG-0002qm-KU; Mon, 03 Sep 2018 05:14:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fwnkB-00077L-GQ; Mon, 03 Sep 2018 05:14:11 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w83CE7Wl028690;
        Mon, 3 Sep 2018 05:14:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fwnk7-00076u-0l; Mon, 03 Sep 2018 05:14:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2673C60509; Mon,  3 Sep 2018 17:44:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core 
Date:   Mon, 3 Sep 2018 17:44:02 +0530
Message-ID: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(63266004)(478600001)(5660300001)(356003)(8676002)(305945005)(36386004)(2906002)(106466001)(90966002)(6666003)(81166006)(186003)(426003)(81156014)(26005)(51416003)(4326008)(4743002)(54906003)(48376002)(103686004)(336012)(50226002)(8936002)(106002)(6266002)(476003)(2616005)(126002)(42186006)(110136005)(47776003)(50466002)(107886003)(52956003)(16586007)(316002)(36756003)(486006)(39060400002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2673;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT059;1:PAGjqLqYa+A9m0MGWGzUinaaa9GvwbJghYPuMj4tILO6kKRZ0rSzuSyVoWqT+KxExLEibWrbdRZAgf9Xz021s3o0KILXF76wl72FfkJexQ07UT14RBLJkFC2o6KLh2/c
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d6adb2-6fc4-4b52-a5d1-08d61196c572
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;3:AxnNlbaKYDXSvteT/NTE1n96zOEZNwwbgPfvO0AJTassVr3qPwVs+ZPmXmpjfVPHkOwHKmiiH6OjxNNgM7gIa37FmaN8sp2/D6yLfJMBmW9Pndy82Lw3N5mAbs2a+mu+znwiQht7czbk75ABZ/hSjQwdeCrdl16IJyWJuG4zZf4GdKZLAkRF4UMInesAm2mcXcvoeHSV/F0VsLfn0TzFT7CqFqsxZhhrDJ52pDrgMoxcW/SesFx1rXdnBp/4NqLfNO5DRDDlcLYVFSMLQnfQbF1VURcGJEKQriUUIBu2w2S09loNfpZw/Zm+GvzT2XjUVTIuIl46ac7ScRpMbYJVzPOb8yVCQDaLhuPCLR36flQ=;25:hOareBtQFQ+x6SyNL5t5TkLnM4N3JDKW05P/JNitHIkhzAoYl6BoH0HVBo7o5pzoynUqdDIvWjJkCebNLDsEV/JRsflEfX/HVHhiv2igYvEZ6imTJqOXomiM6x2dTR5OyABuoDyctufBeH35NFoRrCBDhvw+fHX70YA6wWajO+zrsX4Lr9ZCkI6HCsqeE3VDG1pj1iB2cGAw6S8kN5gOpz3g/Sc7oKvYngX0moQS3j4PXUCmetFj5Q1CvDQ5oOVZV5VR0cCH4OMuA47zvM9rJnN3cs+5Ds7ROnHcftq6vdxdMyOjTHTXp93BP3+3v4pNWMZIxgpxOix7/gwggUGxoA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2673:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;31:NhMFt9OQPlEnMw4N9MVYxfucQtWQ8+BZGJaKoNMqgK+5JwWeiFuf6sUEScvazAZux4cAyEAfYkV2lAPbZbTS6IkxcrZgpSI6sRnEbWtiSMRDEniOD4tsKfiqlAAleJxKzfVaNGHiYZKXO3BW9TwA1xlxrFgfUydNfHs+sF3V3YrfE3Hb2aKC1ag7cD9yHroRajcrsBQ6zBigdsEQwuVrWEmx3wbGSKfPpUR1Gd7JYV0=;20:qxMgVHEF0+YSmlTxg1iBZRBBc6ebINDqwWpfcfpt+fT5fZzAcuMGyBHBYLO6chjn6BBcSBZ3JmcsW9t8mdFCoI8tLw1GFSahDkzPC3PKAQC/fn55a8xDGlxH6BrtQqNGEWJDyzO6LM6AgX35bVBnBiDMTC0SwQta9c9GXtfJJr5Uis8TVDs7aA1jbD7e6CMY2dupRAUgYB+z/KhwK79ym9LIgewevNwV4kj5adC8FElQbjvm0FOu5tRzHDPtk/qErDag4K5podwry0VUTurdnxgBLmX/nYMjoy+jOeAKJXd7wY+RP7VCBy1/wjWh54vxTe9OhpQbNrp8Xsh79Bjpyleq2GUzVu2YQ05+pVUUywdXboNs7l7Eies3Lh6LeBBQvcqTQPpPK5K9TS1TiTkBMxQeKJKN/NVFlRoKd85UOIXywDgyoUMvrjT6Fjo5hODweHy2NelpqOQbTXKQ/7KCmWwWSPp66Xi+hkJ1rl4C78cm0IiubyOWMhknwPFBIQbZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2673A50670DC0AF5F8B1FB3EA70C0@BN6PR02MB2673.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BN6PR02MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;4:33eNKUYFkrfO+yU/SOQBN487Ae3EmEjT8vmE6dmlg1q2cb3AE338Z5Dn26ZQO5FB+JhCH+qqbI99AzRnCB/05JL24TwyAy1SRIDK+CDkG4FtxHHFrPmTt6VRBsemqrwzTohmaEB6x5nbg+8uG0l1yM82JdU/dzCDEdbOHRKePvXNA1g2gTsvh5Fz3ceG1fDdFIG00kvbbkhiBKo15NXLnkGqVUeWtXpUpV/d02SfeUdoPAzis4ZUd0koUghjVXSQnTj2rdsRHhmScBtufOyclQ==
X-Forefront-PRVS: 0784C803FD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2673;23:/s+/zvsKgB6tpq2dxlxNqsb0NvtowKmui6a+sG8vC?=
 =?us-ascii?Q?W+ISQ+MkhRiFG+/80bu91VabvkuNP/znx1giqXAcvzrr8uiahFnsrcle0MrG?=
 =?us-ascii?Q?xiZPgnDAO6G27yhkJ/WnoVCcOeyDJibNlz5KLA/fhGjqo2SR+DoFoiqnFQn5?=
 =?us-ascii?Q?NSpse0lHw2jvELF4T4+LbFp2cC/EK08VHG+8Mznz8goL6WYzDGAHDiPoNRVO?=
 =?us-ascii?Q?Yt6oKqzuRWZqjQyF3OEvFcWgB9BMKweO6J+dhD26i4Q4oNbRXPpTkDdKKDSl?=
 =?us-ascii?Q?p9ZMRpo//eyWiV3/e8AR0lFnxuvg8fcCq6qT6Bl9Sbiyddfpu0bwy8MHzyPk?=
 =?us-ascii?Q?LNcdiQ9VnnKMC0yqoQ+l3e4SYTNzcmrC0qW+vYc0tMcm4gyVI1hDXl4PAuxt?=
 =?us-ascii?Q?E5Fmm7KJkQ2iB+VvuPBKYq6Ix5wMSx0WHA+TFqqlZjtwq1CgXU5XUgNQ0TME?=
 =?us-ascii?Q?Dtb+ZmHLm7W8C0UL6jEMlRKwKm1NxpmpdpaFSdEHEwmU3UIdhW7VeP9WYgau?=
 =?us-ascii?Q?QMhycCe8oHjX1NpdYm0Fn9u2zP4eWeZjkqGlK0QQdHDQIBLd9/4zqcejhMC4?=
 =?us-ascii?Q?JdyRM6/QqDYZZbiFS7QWC5GqZYgNerxKuQRAGWc8SDKsM14A0UsSlt5tGLm+?=
 =?us-ascii?Q?w0fxT+ptBLHo0mLF9TnzNws8Z6gIEP2T0TpuqQ4NV8R+nVkis1FOoEi1necy?=
 =?us-ascii?Q?CCnW7WxWDULV7VtclVdHyZEn4QdDe6AD0HnkDsnltuC4j2uiydO/EFpJb8nE?=
 =?us-ascii?Q?NAi8z3gNaJ/urmoExHQMITvonfP27WtOTgPSEwtkhM8UPGs9KpdtM8vmGt1b?=
 =?us-ascii?Q?RjBdzYP9XKHsbvH8bUkSJBSvwE1AXcL9tOuYVNOHKr1s7g5gqGwcsdRMPm4P?=
 =?us-ascii?Q?fImn9nLujlhonC4f3v1RuG7dGKCHuIolZGyb1FNYwYXE4B3fqLYp/8Lf5MdF?=
 =?us-ascii?Q?k15U25Ujkp2sHiDDOAxq4uY2OCK2R2jaEnaBQNEkkfRInNgPTsSson+zBIy6?=
 =?us-ascii?Q?Lk0z70qdXmUSVZbP0+3PB/xAwOxZYXcieV1CrRXFz7rEzsO9wIUAShYwtkKK?=
 =?us-ascii?Q?VKgL2gJQY/s/9IhKJnL7rnHccSsdyZYH5BdeaUw0WuZqn8Kl+PDdWlzFtwAQ?=
 =?us-ascii?Q?Cizy1AcpDKrrYhvV/XGyzE7IkZM2gSR?=
X-Microsoft-Antispam-Message-Info: IJe1nI8hTgqeq/Yi4Y7Ve7WIGGRsVYnr4+ddvBnxBCEPIZXZZU+5GiZdWFCDx5V4gDMgT6Nyze3G6f9oE7LJhEoTFWhulCOc8hUnS8Ruqy7gaVQCJb03a479MVYG3rwvcOgFPhDdWDQz7SdqhKGYpKAUCnzml7ghrE+0g75NSbhTEdOFM9j5oT6VnZuE3XXmY2r/y82mnEnG7RoAdWxGe9arAiOXOqHTn0pOBgFR0zkn69/fv5ayby6J5TEK4KXtznez5uGCFKnzGv6/fW0cce4OVQyIEqoW71Law3KzaYYsELfPBjY1814vBzgtWX76OONsdb/W0ApyK2r/4+FXdXNTIddnAdhX3VWsoigAjJs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2673;6:fkgY3TOIPo3xK8jbmSWdK74hVTNtbWhD2xcDCnAkZWjmRSg0U43GLZK6BzmDLYcL0ZBWq+2bqlpTI/ZvEc0B3rRzIGjqeeUDi/kDIUcrH4460JR4KawTC44bdqpiyzI/qgQ+6EEPzn/c/0CZiP5VT1IvuBqv/85LWnJ4j8AYe7b5fKJhz3/3KKZSUL/9TKJLAiWxoAnqVE8GG9vSg5JxPMQ0GmD+h0Hu/4a95EOjEDWxpRDqip1LL8Wuar/fLZPysoGQlSAweGV042luCDZpa1inRRUYTwKhZ0z4JtdMGIYwSz5K2tL3A2PJVU8+25wp9BzSs4zPi51xv424x7b27lc1Sn0DvFy/mZ6AzZkW+99KWH98j5iA+mt0Vzl6KZKGUh/LNxOw+o6APLBywdyyD29Ptso2c0fFEPhB3KUrVfKdUUfToZPOw7GFj0vsK/zgfVrR0M1Fr5kG+ZmMz4R/4w==;5:hp9MDm/a30WJabF43aDzI4BCBwzLknH0qKCMVYCwcR784pFfm5hbmJLLwLVtDaDhYZ6Sc7waqH8+iZX0/RcJGrRX/Ws2sER+Zodf8gBR99b3PV8ZorL8a0MiE6/sXgqPv57YFFDmn0ltkPax6lQdynTsTPITXvubeQHGC508R+A=;7:2pT5NoKNmNlwkiWBHpkHc+M//QcurjyAoG3DSwNDH4LveAR3y/z7hNC706wQeF9oGOyyn5BFLLy4B96NOo/eXrwnxPzIP/QGCZ5Nzed53Es7UmbbwG8X9l4dwZMworWvP+5YDV1ZqYm771cPmGPzqUqj7AfeWhgikXSy0q5+WdxYBx7fx8OHLM1mouRg6foHGVtmvuv6wybUXjzq32NVPmIZ16MOTBjjmeUqCQkUIo6r3GLrU+0Wm3LCI8qIcmrv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 12:14:17.0364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d6adb2-6fc4-4b52-a5d1-08d61196c572
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP serial input output unit (SIOU) is a high-speed serial interface block
that acts as a phy interface for the PCIe, USB 3.0, DisplayPort, SATA, and
Ethernet controllers. These controllers use any one among the available four
multigigabit transceivers for high-speed communication with their link partners
outside the SOC

ZynqMP SIOU supports multiple protocols working at different reference clock
frequencies to operate simultaneously. Each of the four lanes will be having
a dedicated PLL associated which generates the desired frequency required by
the protocol configured based on the reference clock input given. Using this
driver, user can select the desired reference clock frequency for each of
lane 0, lane 1, lane 2, and lane 3 respectively. Each lane can be programmed
to have its own reference clock or can share reference clock from its
neighboring lane, this is called as "Clock Sharing". This driver supports
clock sharing aswell.

These set of patches add support SIOU support by adding zynqmp-phy driver to
linux.

Changes in v2:
	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
	2. Added CONFIG_PM macro in phy-zynqmp.c driver

Anurag Kumar Vulisha (2):
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core
  phy: zynqmp: Add dt bindings for ZynqMP phy

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  104 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1579 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1

