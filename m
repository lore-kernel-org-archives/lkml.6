Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF29ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C682064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j+ZgFQPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C682064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGQUd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:58 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:2880
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730027AbeGQUd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE114//YUPYxbjun3uPhuQH8U38wde77z/JGyfmsCXc=;
 b=j+ZgFQPn9Q4HKcLU73pyxD6fj2BOl5Fh7/0s9Q5pXfKlOdlSlE3B5ZJwOzIDn9k4XITtoh4BZB54dT3WJCHovfwwF+gbu2lfYvCzWbKRlJEdU9eCtlXVSNKFVEXInnkcRSX0tbnDP4OhdTFQYbaDTKPnZRf8NOvs77XDdbatU+A=
Received: from MWHPR02CA0053.namprd02.prod.outlook.com (2603:10b6:301:60::42)
 by BLUPR02MB1617.namprd02.prod.outlook.com (2a01:111:e400:525e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Tue, 17 Jul
 2018 19:59:33 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR02CA0053.outlook.office365.com
 (2603:10b6:301:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0001ae-F2; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-Ar; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-Gd; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 06/10] firmware: xilinx: Add debugfs interface
Date:   Tue, 17 Jul 2018 12:59:03 -0700
Message-ID: <1531857547-16652-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(486006)(81156014)(72206003)(26005)(186003)(76176011)(48376002)(426003)(44832011)(77096007)(7696005)(2616005)(476003)(478600001)(305945005)(5660300001)(966005)(8936002)(356003)(2906002)(51416003)(446003)(9786002)(336012)(6666003)(81166006)(126002)(7416002)(8676002)(50226002)(2201001)(106466001)(107886003)(4326008)(39060400002)(36756003)(63266004)(50466002)(16586007)(47776003)(110136005)(14444005)(6306002)(36386004)(54906003)(11346002)(316002)(106002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1617;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:2VvbLX8qW/I26RQ+Dx+chgmltny/dadtu0MCKDKaIGId2H69myWQCcxyb7kVFZNzjh98LmZ48LPfMUetGbAhNkuKLa4P3Hi1UAOTq9zvJ13b9gRLi6caV5w+CYiOyWGL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e2b740-42e8-4ed0-8946-08d5ec1fd0cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB1617;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1617;3:74Xg0g5TKIwzvOcQY81+WhHQEV08mujCTCy5FCfOiL+mb6n4PJk/NQXoss8+NL0dBL2s/qh82Y8vKYmEVbVUP/wdY1ZSSpc/Ija8Nas3Xn2eFcHPhra0XHZAFxmlv/WKs/CfbfRf5h8wKhLbKdVLoixJkn+VtBdBr8B+VGRwoiNWKqchr0aLoNyM4Djw2Lu8k/AIUrJovyuiUMMEJ10YzvSxEj6868y0JISLw9a8LrzI6ZqSVziS7X86y3FhLKBZ7Om4nka62y+mkPGU+tMKtI2t7nkB5HCI3umMfmiHJ5C7ozK95PzgUJqcA1mhvKj7Pjl6lJJGE+FzDknBwgzJ4OcBPQo7eIxfRLdeMO/1VY8=;25:4pMjaj+NUN7PKCZvGaSPV7+enJUlyssUr9y8A++en9RngH6W6Yagtt8RUsX0PKTC9PSAY9eclNU3W+zuFyUCW3wTKvVnKfE9wXqJkx9WBmizjxtuCKdn+ooeJ0kmBkspW90UHzwLYl/g3GxCEagykskHgZSBCoMq7HfAt2TICaWs7Hk8/T+1p3+oHaHR74oVkF1EJVNNxTzZTcBEUYebAyeqaZkShnBIUwK9SPHkRRxn9mLqUWu3cTNq5U4JT+ZBFJSHiI28NDtGbayZUrF6iuq2Kgz8eSgBauuEPrAXlEbZNl7oItYdF98sF+D6HMT8IXE6h062x6FyjEw5zBhVcw==
X-MS-TrafficTypeDiagnostic: BLUPR02MB1617:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1617;31:d5ejaDaYolK/k8W/aG5gAauMfK+pRHMqXGqJ2EnXMgsPLGsi18mtU56mrOF0Nz9VUT8bPL/rNxhsWQOv3bPn9gvVtwIJUZrFzAmTU99zFV47Z2ZGty791DeNMDz8SEgA+kGo/gjV0DsI4EEea5kfMgwaHw4B7akmqK4O4T9CpsP9NOqWyMTK0B05JR9TNW/VwU20xnfpjh1X+O6H/j7KcxO/Jf8NkDobh6wwh+SNcxE=;20:U6rspIdnI6zdUqOJtsIsYRJyU/OsDTiahVelwvMl54cxUGxLPTnowjoPUO/nyRyJHjxrOGruU23A3MuKJd9b8oi0xf+nRVo6Vb3f7uSglnJxHQSFzWcr6NuyJH0ZrZcZorIOc4dfSqqXwyE0BBELtzEV7qsxY3CQs5bNtl1OnvKN+VGL3171IOrXL1+JZFEIlDQDWKphJNq3TpZnZMV0MMeun4qJQqg42WtqIsjyOdD1XyB93jIwpi2j32g6YJ62NMkJ+KlXnwnqLLRih9AEHwWVPUE6s+HW2TSXcYR/0qHsIaCOWQsOrj1DWJxgqC2gNZofWCcJ4ZazuUaKlOUREYIpSB4iC5TCDTKS5KG7OKOtvca1A7qAyx68iIZEKwxHrPhqeVmcx4igXx9TJpIjHBJxJ96bIqj9OAdWjGpsd82nm/zraE13uPQ9kIi3IvYrAn6hgobJzIxDCpzAT4Xs+lf97fqG7SrptYTQqY5arY7NP5t5P9QkioW0GiIjyYW/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1617CFD1ED603977B4C5BB07B85C0@BLUPR02MB1617.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB1617;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB1617;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1617;4:/YYhUVMYsKexfI9Hj207rjsIcHtiAyygiXc/Rcyib49RJTh/ZYUBfr6IZeqp80ofAUauq77rD9xepdCEjK56vgIQW2ghH4ASduin+cz9Qi8CYDEdhtLV4AhLwP95+fUO7UkXM4D3072JaS1oT0qn/PJYHEu64k2p74Miwv6YEHHtANMv4CgvLG6L7AjoYvTRRdx2Xy8no0W7N14Rm8XAV+SCawsb8/q4/zs7lugcbvgGEUStNuCzIA9FyxiFtjK5Cwq7G3BhXXCvBbw/qv1dCVjbtkKYFq58gG2fdfhioz2OQq+lus8Ua3hb8vuU26TwYxnOOQbq+ilQKF4ITEekNA==
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB1617;23:mMTl8T4DQ/tURORlIMZNm85+KQfidCEq71LNzZNSd?=
 =?us-ascii?Q?e38J+qpcajdsYiGPvkUYAPgvpvCpF6zNRoNYltaayK/UkeDlCpeBNe9q6Z4e?=
 =?us-ascii?Q?hH1eIjDxnhHaVgKLuYmkh0rstKAZcqTCay8LwmMKVvLiPPK4MlNWXs5XeKSb?=
 =?us-ascii?Q?DRf/HUKUfkzSgrC4DoCVfo/DrIZmu02bLZfzzm/gKK5Toby4LIIoZXuBVrGC?=
 =?us-ascii?Q?bfi4gS8gpZvEe0U8CtXu2HumZEMOY0nu67mBcycQUiFHRiBZsMMNX/wnJwOg?=
 =?us-ascii?Q?2S3iITN4fDbdPPxoJ4dMkcgmM9bNpUHKiwfOcVCJOZ0/XpxmKHZ00y2HtRiD?=
 =?us-ascii?Q?gbVxtombNnQy9lD8DoFy6kUgO94FwW/GcfyV/OjpRWuK6KjtVrfkjW2pkZa/?=
 =?us-ascii?Q?KC2pc+raFG22BcpDGGhdS1Sy/1M4EzNWd2mG+BXaQNCz39bvb/8XqDBT532b?=
 =?us-ascii?Q?oZp9kBNNeV6aW2nPH6Lw6YkWAFI+14RB4JnLw7cqy6xbCPtEOdqGC8G+H0vf?=
 =?us-ascii?Q?DCtK9I9TS+AlxOZ6BABmCFxtrN63LcyIsLHlc9IeBgXG9LuBCGBenhvsTnJD?=
 =?us-ascii?Q?in+n9mlw4DpHxnnTOrGjto6jshsnJvfaDeQR6R4A3lz6oZu7vO6R0VDUQIUV?=
 =?us-ascii?Q?nQGQ2WBSlfAA8LfPVPqXuNyFpMs5l8mIuYiXw78bJa8tDGPLGxJgETo50+gb?=
 =?us-ascii?Q?PN1TOZlU+VhNpd8Zlki1mGtW/8VaeU0b0jAoAjiWC4o0Eo3y4RegfD+ciQwW?=
 =?us-ascii?Q?onlO3u7wcJyoc1lbfPuYPKWD9IPc/xZ5AZFpREmG/L91j5v1xtkMWv7jb4xN?=
 =?us-ascii?Q?N5A+caJkE3LZQxZMNUZDuwolMNngShNW1Ao3jPfFSkNHEJem2f9ORQ4gsiyC?=
 =?us-ascii?Q?HGqovJ//U7dXZ0Uii9dO+S1J+2vkNcPRJAw94+szBxPrExnUW5oaBVDjczl8?=
 =?us-ascii?Q?zLSQIsJ7CxE6zii/uyTdj9wP1fjTR1dnPGYj5r9qa47t9qr1KkmSSz1ELcLk?=
 =?us-ascii?Q?NxksSe9nqBxS8J2qYUdw4RUpaAYG6XhWcWRcCJG5DnH+PfPcaHiihF1atBKF?=
 =?us-ascii?Q?Fh5Hq7FscOWcObt6rezszqAYtqjCabHs39u7mG9baPeopJFK903IY9irxt+h?=
 =?us-ascii?Q?5ifx/Qpk5mGEobgfprxm9gmvRAd1ZH2ZBT1+NfUZoJsV2m7/B4aiZy89u2BA?=
 =?us-ascii?Q?XWKsQQ+9FrD9pcdnohQYsfrqERsT/8UFSSJRV3nzDiu8wscMRdYcJ2xuGWPn?=
 =?us-ascii?Q?1/1RGuf8qPqgLCpreXPZkitFL8wNPNfR+wuQZrzrwr/f5QLljwTVu4iSmqMv?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: iC7YdBSVEQI1Z1I7lnAETYBpdRJCNWU+rkIIVjdYTLVuER+UBfcJnUKTZx6xSjjkpMbbMuV53j2KgkR9Rjce78S+qoM1BaOBeje7Ask/2moXlkaBiKXzlJXjVrK400aFQZLvwhzTaFuWSj6xakcaR2dSYVdRbSHwLfKhHkHICW6rF76NMXWavfHZn6A+voT8YirunF32VY4+cjkvcju/89lctCLZh10/sMSaUTpzSQTeKbIYsOwHqQNiE4BuLEzoK66wvfDZCLep8sGMJuqCtIew27MybOX2eieSPvP9uW+4g/Jj9T781MmvXUuqOdUgU0fFf/VybdCB+mYehkrR23NPEphA0NYXwRo0RJelpb4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1617;6:9s/yYQqsThK5KADSS91RNoGIbQR4WLA93RIP2qzjBd/BN4nO8vwDg9pTJ6vGtKLkH4lcWvvenHjFKfOHdZgZFGKtRwiRZvK2L+GcUBRn4MTPC7gpaJVOnRJ3OYnIuWvocqyBZYstwr1Rdl4cMXaALJ6jbLW0BDA5mi63ShNFtGFo3LuUJOQk4Gtol18b3uHjf1eKBWuBTlNQO75Wl5NLOsVxtPb1z4828uyAw1SeGij6ULUklGQYYm7yJSvLQtXAkMK9FkcNp+L39mjeumftnxq862OPfasZn4hVAVSy4IuH6OO1dR9ICLu3T/BWK6/LnlZ1nfceRX0QE+0qZONGF1Pb1LNiakkhIBRSjyYwl3CxnWAZXEvJkwLC4iW7ATNKf0HbTK4zJoKB2+FMSEpgg4UnupfrJKPv84huArGf2L54NQkYbfx5NhnGyvqFi5jQ07lFOHPmS/ht9dhbdGQcIw==;5:3s+cgI9z+6EGryrxfpqwg5K3GzeAKYjqt0xRw35t6D5lyuwWBxukuJxh9jbZcPymhc4AdW4JQ2Z53BDxU4r9lg+sk+MCkz0PUHVM7pwy0Tf4/U2xAlQ1tHDKzAi/8ZUCSnNqEtlv7p/qHw/VN5ZsqzuS66EpHBnAngE3hv+NIUU=;24:yXhoImImUH2MREwND2UtVErQWZgeg+VdPbAuoWNsTBbxNn1HAtWYg9+rB5FulrjuHbfslvax9lL40GzyfOL8TE7Mbkfj6B5b5YI8m+1ryXc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1617;7:ceLOn2f+hfu9v2G7lGtCUu71TxpvZTiFbH2gU5q7XPO8JUoBmTaRc28Ciqn7DtBjo4zMlMH5h0IMj490oR/0jH6MiP0qHbQs+D84/0nNylhiGXHk5Qw4PKeSy0ZxF0+D8/c0OG/YBGYkJ8ZZHJSTnOb+YprLTFxiJdCuxcGRlg+AHzkaG4BfQAEXiM+yUzVUcKZmBVYGFpwZNaw8Blg0efD4xcf3lVIiNIWrrl7uEMGT8MD2sKzrbd2COSC/+uJn
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2b740-42e8-4ed0-8946-08d5ec1fd0cd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1617
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 64d976e..8f44b9c 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  If in doubt, say N.
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..fcbdd6e
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 41ed800..7ccedf0 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -551,3 +552,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4

