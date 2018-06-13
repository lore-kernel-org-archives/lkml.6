Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB80DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1D208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0F5qNTjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA1D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbeFMGgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:36:08 -0400
Received: from mail-by2nam01on0083.outbound.protection.outlook.com ([104.47.34.83]:34321
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754416AbeFMGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbjDuRuyazbib41YlXnR3MN85w5AMscS21otGWI4QCE=;
 b=0F5qNTjvEcFMast2j8cf6FCLH5wJBLyKfKqQ/8SwvRfkJX7ANVsajlYQsAzMn55S59VrevbRIqIOZBPHwIo2JJ1HpY4tnaViA8REf63Dg88lJco6ZYQpcsBMKxkVCGwxg8FDM6NVM9/qJ1zX0LZEb8BOpasbXHBtMMWH/XJzXhE=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by DM6PR02MB4955.namprd02.prod.outlook.com (2603:10b6:5:11::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.19; Wed, 13 Jun
 2018 06:36:03 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.14 via Frontend
 Transport; Wed, 13 Jun 2018 06:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 06:36:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNx-0005SE-MU; Tue, 12 Jun 2018 23:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNs-0001Z5-Jj; Tue, 12 Jun 2018 23:35:56 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D6Zsdx031109;
        Tue, 12 Jun 2018 23:35:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fSzNp-0001Yg-Sm; Tue, 12 Jun 2018 23:35:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 0D5C6B20749; Wed, 13 Jun 2018 12:05:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] emaclite bug fixes and code cleanup
Date:   Wed, 13 Jun 2018 12:05:15 +0530
Message-ID: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(4326008)(478600001)(26005)(90966002)(2201001)(48376002)(47776003)(7049001)(36756003)(54906003)(110136005)(316002)(42186006)(16586007)(186003)(336012)(52956003)(50466002)(476003)(356003)(486006)(126002)(2616005)(426003)(81156014)(36386004)(51416003)(6666003)(106466001)(50226002)(6266002)(106002)(103686004)(2906002)(5660300001)(8936002)(81166006)(63266004)(8676002)(305945005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4955;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:dxq5Q0Ny7bHwQHRnRvqPl61jDwhkcA1CVU2mwDSuLJ1/skw0LWlTFrlAutGVec2ldjVuC7IvgbZwd5XVHWbCGSA1g/0nZbZQ0RphLn66osvk7WIX46yB28jAPQ69AxxC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea984cca-f556-47b7-72bc-08d5d0f7eecf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR02MB4955;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4955;3:xyALGKZk7zQQ1rWfSxBvzkuqiR3fQZfZvTMZr7WFCNOBvmlIOQXVHQhWE2h7/mQqGE5vhByjfrpYrJXjnomcXcb9fOlZkmoPqaB7aacFYZl7SuZIEtxPg8UIJF1MYif6F/1bCgyiJTpq5YvIPzIS0VUtGcM0r3Nkp+YrIo0MRPYZYgYMeAc7wUoL+eZmAl5U9LE6tT8rdo6BE23TDcnI0ye3vbGyD3oSDH6XcT/Ak62o/IYPQl1YIDG3FaD/EkunnQdv2EGhaonYAoYU6+Oq8BnB8duajkd+d3/spt40u3rZonKVhqJ9WTNUky2+d4vOVwzDYI+FUW40oq4o0kQTGBHKJWl77CoXHwqbrH6iEyU=;25:Z4PliNZu6383eQ9WPQalXYGU3GBWUkYQ11Y7EqCgXjt79+P/KQXcYk1/spdJ59SXo6KLRAH8NBai1zVSQ+H+KOEZwedlCWIbeda0nn318hdX52UNmgEY7nVz6Wct1ztFrFWpibrvIP+jP8owItQ9DXLZzxl96AHCaSx83AE45HeT71fJlx+AgWW0Ty+Mb9hhQZM/ehAnVmdVpoHFlHifVKSYP9ASmdOtlgXrvg4D3QqWVc6SDlaWpLx7PkPiDitDy9FgjMOAHZcA5JDllKnrYOamuRXJFMI0ShHloXJUgQwOEfZJvIyEXtRboGoEXLEIM3zsgAKsb1uu0Gihvj1hgg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4955:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4955;31:vdySYthmcpkGBqJbIGOimPEBirhxwmCk7rZWqRJ2tat9WH86URRPPrOP5/zw7Mz0GkTC9BtuRByG3P6hun0s1niTgcwDfa9opQS3wbcy4E4g8UzPq0+uFDynyQo+zUmNEzP2Jcnb8GutCf87mAUe5vFvrGp8agAGdk8ZsOfwWQwslTxJYutvazn0OV6tgQKCnxeeXjBopdt6Qsnd/Owlumm+aiFxqVNDnlAp6X3//uc=;20:NtJ3LAEWICOWQx0ywLbA3ePjeQcqaKD8XC+nQ/wA50DM0cAgy5YChV1VOvDeDrFbRL1PQIWsBqXD8Buure+4qLnP0CQM6lsLQSrgMICXbeHjGO2WxdjXkNhHt1JBYuZQoygdKSCBRO5JhPz3GDqICwYz+GKB3ozmoQESvinmWgYOpmEWyiSk6SItZFij1NeT2e4pAog0IxcsZz18cBA2zfLJGMPXt5Efo78p7T95jfa49ZxVngCXZ1aNv+n19XLyTGvOo9VlohFGf4yJuebAHZtUqBE3/GTVgdM1RK0GFu+HGoLOt0pBWOdUMf+XzdCKmt6CC+ZBucmMWCakU48V/YCKJvOvBA50rmHPILiWkEsusll2J1k4RAANkP3/H5Y11wuUEoqIcsvKqiGWfkV9XW+xBGIL8fDTA8egNYwO1ZuMNbhb8cXHktY02izGgiGMfrJobLRKA+1bzHw+mgtO7nsG0kLPV8srd3F8SmjQ2IxJxc5O/zzg6wnRrePq5E0O
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB49555421F486655D09876795C77E0@DM6PR02MB4955.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4955;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4955;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4955;4:tz8AU1CY9zxITE2QFrKzoCdhK6Vr7I4lC6FmgvUjxv0FjComKCfk7dbNb5cVaRTKHUtgj9TqbUEitbnhCsSDAZqnKbEY8OJf5RahaoXHH5j1ykv4j9bWmwYSeya8918DW1TfU+kafMqwRoq+bNoKkDDvbE7+rt9d9i/6dP7xGhtAo7E+HfZerxO61SpVNwEv3+rOIaT5XD7cKTpCYQrz8ZLa1wdDB3QQDYv1FU12opsVC9qaNNzDo4AJodI/8EiCvqpCnDJlUtfipIp0l02aMg==
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4955;23:VOBxbBTAhPSvXcbC08uvSzJgcRbcImooudMQNmIpz?=
 =?us-ascii?Q?SKE6tylLndWS2O3ZS+jzxKVNgO0ndG8XDKe4sAAwfAHjd46PqsauiaPs4Pq+?=
 =?us-ascii?Q?ZcmDf5oN1mPQFD8T+NRLyKdxzuJcE8sk50ZMOzxz993Xtg3wzwW18U2KxZo+?=
 =?us-ascii?Q?Ym2AtHAUAzY+v5THqU5GcBLvwxBX7MLGxvSkc+6CFLqBIpocLuqhA2jmExr+?=
 =?us-ascii?Q?8XCl+60kes0DNvKShUd4PVw4PaUwTBCV3bzXDhLIgl8outcapXuLqTzp27aI?=
 =?us-ascii?Q?XC6EOV5amIw6B6+n58Ru5qYoVPqD8PIYAs7Yn5EDLRGaQmkP2b7F38T8z/oj?=
 =?us-ascii?Q?a5iQ4XqEktFQO2Ml+p2f/3HZUVDBwZgkEcYBaaH74oXTceIjZYtxjksyzSoJ?=
 =?us-ascii?Q?5HTCgJxVvTfNjIohkfkZmiPgWVGVZgpcKugcSg+exrpUz6QEDXH++yspLuP9?=
 =?us-ascii?Q?oY+6/EET+v0i5lY0H1oheSW2UGpjDB3wq2pmyBvBEe5ihiv+d9TKbKyJP7SX?=
 =?us-ascii?Q?a+pD2AW57iLCs7jzECc7oWejYuDfMHHRwOXKNKRDbeuSf/Xe901CLk1JHLG7?=
 =?us-ascii?Q?yik1jTS1Sm24FAe11JI3pi+vLldsWeLrVzUC5NaJVAp/ahKUbQBKwvuhbE8p?=
 =?us-ascii?Q?KplWhbU/tBsYUeK+QxxQoc8BdEavrHvnSLDm/vMR8ICv/aHWewG5mo5gNXLR?=
 =?us-ascii?Q?nemjuGAjXVsawaZ41sgJ8DUL/tJQduIBZ7HCEDNlsEpIAZGA4N66ELacJjDW?=
 =?us-ascii?Q?EeV+HiESSa8tJtrHTdf/ghxB8osxh53LAczzktHrcW5VyiDXLSknQuQvUP/z?=
 =?us-ascii?Q?qZgOpvGjIpqjt6J56v7BPpnwU596IGNkRTsIIpVqT1U9Y9TGduApYc+CJwqR?=
 =?us-ascii?Q?gWKwWjRBmbiBhOtBna1qhfEnCKNOZVtOYdSeQ+4oRl+UywU4oJMWU/qd85H+?=
 =?us-ascii?Q?VSqQ6KSC4wbcvgK4aM0pPTpjJf++E8smRJD3ughDlnkqZIS+lBTboaWz2N9V?=
 =?us-ascii?Q?+6dKoobnvK4tmAj03aP+wDdkcN+uzdD/Lf8Z2e/zdMeAhk3timwPNteb3N3b?=
 =?us-ascii?Q?gXm74iHTEt5kM/hnDWZpvJonQwc+5uXd7zm+JHUALL0768wejEllLDWJCEM3?=
 =?us-ascii?Q?KZ/UNL27CY=3D?=
X-Microsoft-Antispam-Message-Info: sZVO/EO+KP4ZhzVYUxDF2ps1LMI/w+59GlNfzyohr9SpKIb+gswodYQj/mldr7h3HWkWknlZTzZSUbfXokG2nf12b54NrKDe839up0NOd2CnfcrjzNj0cvW+D3RdjEu+3auk9ZOdV8BEDLKKrZyvcacoKHP66QKjzQ++zEmXd2ND+sNOgE10bzadWi/yQ+Qg
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4955;6:rolp6MzYir7oh6Fm23DOzLueuhiyPjZhmEbhlmkU1y/vi9POQOsm6mmAXXigso2V8PdS2MpjhAVjFVHtR186m0ipiBbgSjz09ikWxQmozx1pIwgpHhaWrLjkxrtqmK+GNDs8AryCiaU4r7IBMTZi5Pe5aLYc/9yTPSJCphCXayROZOcpQYo14ExY78KTs20DNPCPjaQQl5bUIgSr8Q502ZFvg7yIlT1tzeWZdT9Sjy7fXLx5JEvnjnYNK3AIRf3ib3pzPf7xi/eUNlwSK1V8bmXW+ci5/pdtqk6+qW8jTLDs98uWEDp0Bm1Nb9ecRfOQFGtCxLKVMaishDuNVHYc19oWUZZcs0LPWd3ySFsX/0QSPcdVj67SqjL4SGueLWfPEunLtMweiy0RFFd5odGqe/Ty970lt1orqSE5vNnKlXXF1Onng0TgeW3wl36tYskfs/IyIRhxNxWPO9x8yqOYVg==;5:thFcp5hNMARZ4sYeA96CXs/YLcpIcbB79eOHW7Pt02vtobnUyB1zkc4d7aWVAoex6jNDt2cEEYeMv1fgp8p+wGu07rLvPqt/hfYhZVbdgIPSjpPySPoggPuqBeka+RDiNs4cZAPwjacypF9Spx4/YsFqDx67QgwJnuK201lTIVI=;24:aOcEBQ81Kl4SH5jzhGruGMHVCzTh2QPwnYcs1B9Owl2dioPxPs4Jmdk1Hyk2HlXongMhhNFsc+HXdmqF78c/cVOTz3YP7SqBad506RRu8zA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4955;7:UNOqG+XbW0gYtg4QOGO/u66Z13qR/l1dEF9XEYHku/oKZjM7PvCCmSVmXq+GniSnQ7vFvFMNL8gVAf4VylFwbbVp0G9Tht2jTSP5dm0tGTbinvs/cLG5Gt9RYxkD0C7tP0ooOe/vd9RQIeynlIMCDciN4m8c0nZwYGNAwBONfYCcK8d4txeBXsIi9kxhvyCIJYSHuEtaIHO/khgKAX1W5nxuBbSKhWPdQaHaM4fU18TVar/idcZ+ZebbDN4Mjxch
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:36:02.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea984cca-f556-47b7-72bc-08d5d0f7eecf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes bug in emaclite remove and mdio_setup routines.
It does minor code cleanup.

Radhey Shyam Pandey (4):
  net: emaclite: Fix position of lp->mii_bus assignment
  net: emaclite: Fix MDIO bus unregister bug
  net: emaclite: Remove unused 'has_mdio' flag.
  net: emaclite: Remove xemaclite_mdio_setup return check

 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

