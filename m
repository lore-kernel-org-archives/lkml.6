Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98878C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B992075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LifSGk83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B992075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIEVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:13:48 -0400
Received: from mail-eopbgr730080.outbound.protection.outlook.com ([40.107.73.80]:23972
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbeIEVNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxuGXbis9cr/lF1yBFtO8mkCZ+5MgnkuCptc3Z/sh7k=;
 b=LifSGk83TF2+NifWmvV0EjxAezKFbQJpno/zQo+10mFqDh241jlJPvq7l+z5yvkZdFfAi87Qpkgzf08xr5IqKaXUDUwamnfZeJYuJc14PKmCdbIVnXMLGo7UyeRWUy8i3iTNbEQAMehQVaFCIcUmLKCDtfFVAajOnT6nWEHNOK4=
Received: from DM6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:5:1c::25) by
 BN6PR02MB2675.namprd02.prod.outlook.com (2603:10b6:404:fa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Wed, 5 Sep 2018 16:42:45 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM6PR02CA0012.outlook.office365.com
 (2603:10b6:5:1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Wed, 5 Sep 2018 16:42:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 16:42:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fxat9-0005vl-PA; Wed, 05 Sep 2018 09:42:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fxat4-0007Pb-Lt; Wed, 05 Sep 2018 09:42:38 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w85GgThP011464;
        Wed, 5 Sep 2018 09:42:29 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fxasv-0007Ny-DF; Wed, 05 Sep 2018 09:42:29 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 9293E6047D; Wed,  5 Sep 2018 22:12:28 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
Date:   Wed, 5 Sep 2018 22:12:25 +0530
Message-ID: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(4326008)(5660300001)(336012)(26005)(6666003)(186003)(39060400002)(42186006)(51416003)(316002)(36756003)(36386004)(16586007)(90966002)(2616005)(476003)(8936002)(126002)(54906003)(106002)(50226002)(6266002)(107886003)(486006)(478600001)(81156014)(81166006)(52956003)(110136005)(426003)(8676002)(2906002)(106466001)(47776003)(50466002)(356003)(103686004)(305945005)(63266004)(48376002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2675;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT017;1:PEQ+kn7Fn4k43tXioK89IkloA2hamhZqTqyTTKUszWKzbyWprowQErxGdFNUZunE20PrUUPlaoSWGR2UmCYn0cPqBk8GLRkifnCBTpYvrpXDgpCwudyHojmpaiEYOMJL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc0f23d2-1d13-4bc8-aca5-08d6134e9acf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;3:ya3rLx/vzzHVGbrr7cJDeUrfJgiwxburXLHkSz2YAMs0NlmdANNiKVchPi8O8xubi3JlXIsTAx/UoxfLSK7mY4qTlOU582sNIln9/HseT3YkryVC2Y43Dv9+fHDjUYsgeRJ+shvxd6JH+4U09BXtyxaA20HSxWyBghPoXhUbYOwtaKe3nYQU3Izh1ZQqL7Ptr2ciWg5OS+3ivJQj13juo3LsElwkzV24TDk2Lv1tBBQUcyU+pWhNv4oGl5kXyqZV4WiFcloBHEMQJVs/CakPvP9zLiPrGepsuXs+IhYFfTrAtJovOKqLSEyP20oO60rotGycKXiH2pdjcsbFdEBpp5oQ1BGJgCJ8k1hsdG/c/wI=;25:H4vMNk6+hETzRkrtFJKvKTWVnN4Q1n2VXLBLWDswb+33SL3R8/rqqP+2y2zmhx/d0d54ZFN6S93Hnt+yO2lBnVK6Wy/C8bGToK1nNpnU4y7n7h3QXhQYSVW/hRh3QEzo4WV+qNX8ikFjtXXc3IxiYB03kbJnnbZoY6QbqDYVX9XUk38XiKi3IpTinLoEZJNVOSQrGzsjdGFtgL4tNSIgNvCMOuvsdwbuJXykL+JncmPOkGMBuqo9OS7v20WYk4Q9Sis4JQONo2kPFYraHEs5NkTEWDbEZv6AzA/1/FsDqWHn9XVsfV1ET7a6Sb8ClXzAI0m4Ed9oQC1j0qkBNKLsYQ==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;31:Avdx1SnXqjcfEtiUsZKSUVs42ttXo2X+QUDNcB3tcFkrVev/NsfRu+uIU5Asb1rAjb2TsU3yGcA0+routWr+3x4jTgLC/LHFzFLQNvwC48vn3wTHglGspToTpXv8G9QDFBlcuEEkVHA4uuxETLSTckZ2dAIS7YD6FrSdguu01ye91Oh5E+zmlPx/cvKRNeMomnKuwGwR4UgiXJ9VQHAWxbRmf/BEONUUEMpDGFQyEZs=;20:AM5r2nQYPBQT0PWyj3c6e78Ad6gOf8FK7WGyAfgPGrj2nq/qOpPznkIxoxg+XHfzvNX9WruxriJdvAxUsWJCiWB+PwhJtFKRS4W41P0jnbhEUDehdT2es2dwEIMuWeS4elqpXxwnFzCpn92q1eNH3T3cffkr9p6zNZU9zBL7K/6Vdua2k3dqV8ECvXB6DmHWV6ZpUaMLmAYaW0+ap+dFSIbGrYVmPWpwN+w8mQD49sVRxWNW2Fw/b8KOcRBUKDaXcZyxsctN9wWmzkpcwOh7rRsKQlEBYts5aYvPeoG6Uso1naF/2EorA9dMTopWwilQpVdQnRTJQM1vuiJduqS1TNCGtq/ffCT3cMGVzEQfdx+qR+0CNao1lcmrvoKxk7X884TfYi9m/JkU3S4FX8yh2DRds+dD0yeWUv9DtSGaL2Z0JUvfGznObJ0yL5R9yYIUfvQdoNB9GO+JO38VsaWjftjjZr8kfmJktrVrlEzfd4wR+Sv+M7ifENroKMtN3MPJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2675463D16E4D9AB2662F8D2A7020@BN6PR02MB2675.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN6PR02MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;4:vCSQl6ATzzwmtlpHNtK7yiXR/xJfaguM/BAlvz2aA8CDsUnT1A72jKrWjUvJirvhXiEA4oWeq5MmBm/OfBOLhRlf0wcZblJQMtYyWiqewzDvXeLKY94lrqMk3YjE2/ey0iOUFn4w/74IokVB/ReDGYPmgHhxG5QPevpmNbcFoV8K3nVQtNyV4kUrG+XO5spQuiD7J4QJbWgOdoQXp7aDDNZVBoGQsoFs2wJ7ndq+jOo6gPz/HZldkDX7q/+z0/VU1R1i2h3/kK7Akc7nj576Zg==
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2675;23:YGgiE/CsdYH2JoUMU3vyFCz/Y/l1ThuY0a8U0fT2p?=
 =?us-ascii?Q?gjSbPI30nveqSp52ocMT/Mx2PNfys2ih40AMJdv+MkvrkC7fZZ2K4SneGTra?=
 =?us-ascii?Q?7FFwQMNs1WGhOoPsSHcFurg5TjdcUU7XrfEHdCwkqeG5lpJOe+WN5Q4zNUCt?=
 =?us-ascii?Q?HvqtyzrdRHpz1hqlnC/uq+GupMG9phbVIP4RnC81MxNdspk+6M/6wOrmzbmx?=
 =?us-ascii?Q?ku5mWJ6m6GatgTr+lhJ768n0x54LyNAdKzGcjVqWiPgrGxeARcNzSfKr/OqB?=
 =?us-ascii?Q?kJExdEbE0iZnAMt3YHtqMCp5m3RnNT8SVVXC/ND5ZYp1TqLvcx5CQ977Tt7T?=
 =?us-ascii?Q?sOFXo+6lgiVKIN4IwmMfZzHPiXVDfylCyC+c4z7I8QbiOe1QXSIhUSIBvdLl?=
 =?us-ascii?Q?RP98jj5f+yV13LBsLxCd+zgELZdGiWojUANK64GNkRZLyyKAryoPkGbQGTgh?=
 =?us-ascii?Q?dL+HY11Z6QqN4GKL4ubPCYexKFyqaSbn5+som8mtC5me5IFXl7De2xPVMgm/?=
 =?us-ascii?Q?T5c07BXj0qRQhUr+d0E8HvNQU4vQEeIOvVnV/z3V9xTQMN1gBDs1O2svvxz+?=
 =?us-ascii?Q?DXIIiRsGnkZk4MaAZt6q+2R8iCLiccQbqqCvlL1p6qkS1fdS6ZWavQ3ATE0G?=
 =?us-ascii?Q?K8RJCTlcRE16dyAfoeCQFgtXGsmhwE0YlmhTP2tKpWfT/6WfU0BqY0tnFXrO?=
 =?us-ascii?Q?ZJtRUmfyRyqHorn9eXh6ZmlJej4NPSLqSFD6LdwxHA6l6GkPshL3QaLIADps?=
 =?us-ascii?Q?HwQcLd5JGUrG8n4mC9OsHaBpurfpqlYt94fEPZtwIAzmXnnVX271tImneneg?=
 =?us-ascii?Q?J2a+p70KOmXGoAcRtH+fL5XuP5CG/UjB8uACEBzzog991LRUkpVWfygMw775?=
 =?us-ascii?Q?fYi2gUs9QFUwsKQ9FDVpkNA6Z/6zT58B5SgDnI8YGMzVHo6mh9fQEI0c1aPZ?=
 =?us-ascii?Q?C0dBov/3oHJr/ps31BsWiOv8Rye3DvYrnYSLsqENMR55MdTYRQDEg7F735HQ?=
 =?us-ascii?Q?V4wFKo77zpE8rGOsTt9nYCDAgIagFGckXu7YwtrYWBRPATO1wC6wB2A3vKWL?=
 =?us-ascii?Q?hbniyTsvgm0s4WRQJsaNkOFLgzYWWca0/OwQegF+Cn1Jly9kyf12ERtcCKW2?=
 =?us-ascii?Q?N2alLCZAcE=3D?=
X-Microsoft-Antispam-Message-Info: ToNIjxgjFQps11QiOIwxAa/94piCZWUph4FroTPQCDMUPNnJR9N1d4p/8vDN7vGezfGnu2OM22FtXDn1Hc6lAsAnzVLGauKlMVeAdzN5VOq1vxfek41TmSRE2unSPv8aTvz3z62TD0Yl9ucRIL9r9UdC9wmgowNhDaxCrlpGBuLdsHM/2jN2/TNdcZpjVAyLiCsZIiDNrDrzhSmygO89g+XOv3S5g4DxK6zG6voiYgzCIxIqigUxvmjORW3rdwpMuPp5PgJLq5UqLZO5voxiVyXDR1z+zN1pr9mK2u2L7Oc9PjTOqE4d8JZ6qj8a0L4Qy6By5PNP1XV1dWHWVwqVIQizCH/KXnF/Tlcbm+UIyLs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;6:ZCRUFAJCrIVsLATJKm2+wMHh2KG9OwHKaf9A/JPGYaXN5icbI1ad2duuG8f7AHzTvSA+INaPZNtfy03f2oMe/9rCOcu9hBO4BxBt9Bx9IHDa8zR9Fg71LphzcH1vgdZ9GPQlN0gRwc3MjeekPa1mPOsaHJKxQPyNGdQh6ayPMQH4C2r9HczV/XSdtJ06GspjRMWhiYp7Fa/o9kLiKdT1K4fcIp2Hfk6E4t4JgdDtXnxp+bBO3VRrzMQ0DKD5dij6oRMs4hV7EACWNnUtGMdQPRZpUsMX2wsv1R+gaOAGujWx1vWMWaBwPM7WToB5Kx9FDBAKTbivAlEWGLt4nnHmHqETahPQXQNnxssuTTgAVjLA1bpG5lvvZdSEoz0Fh/b/xcX9lc7f3RXsYY9Qkd+WqFJgMskaX5YlFHxaA0SATexempkfl38GX4eie63I/HYKz2MxIBQE7N161Ybggyrcrw==;5:pFd0P2JWNY57QwzzdLS9RSELB/Zurg4YTxsaG+KvBYvyRYhdIKWoZYDJm7+eOFtvX6A9iGf4CrFRN+acX3ZiJbfiHRqW2UXRCxjHeKEw5uQOFu2JyyyEnoPz/QPVgaeYlOowGm2VO7jBFURu6o+GK+VleMGYeJ8Lu9pvWZOTs4c=;7:fR1r9wdG1tXr6HI/pYrkqTPGw8k1hYvHFbYCnT4Flsd2ILEXvvWIeCsf9WhE1Sr0McpbxyWD6ICcJHHN4RUFe1YCEZqZ/3nVJwdWTAKf04XsovkCe5aPJpjiNoXbCMzEOO9yD7qVSe9a6smoqi5/Mj5eOKSSiNuhCr5yyn3KcIty1vXD+pp+urd7Icog5Fv4HAauEYm/9F2shXY+YM9i8VQGCH5nIVvEiuo+crEzz9XmkxEoNgMS91aKmnQ0rpTP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:42:44.2057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0f23d2-1d13-4bc8-aca5-08d6134e9acf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2675
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

Changes in v3:
	1. Corrected the Documentation as suggested by Vivek Gautam

Changes in v2:
	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
	2. Added CONFIG_PM macro in phy-zynqmp.c driver

Anurag Kumar Vulisha (2):
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core
  phy: zynqmp: Add dt bindings for ZynqMP phy

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  104 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1581 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1748 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1

