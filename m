Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4134EC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98D22146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PMVsx7Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfBAWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:09:24 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:62528
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbfBAWJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAlFs8vIEjre3QL4wQyH0AonXzbUYX77T+xn1Em08g0=;
 b=PMVsx7LtDtsCtQNTFMXRLMxw0Lv/gRWT3NX2OTh90Gm0VcFrSA3RzlYSHZhEbIK0155yMPe0Zj1q1X1dfVgAVkg5gBGGlkOA/mcFIyiFhkFXt/NzULyGbGLMa0W4v1nU1RlH9ULsLXn91FhyTfON4oflk9BltkZb7tXk5LXQMfQ=
Received: from MWHPR0201CA0054.namprd02.prod.outlook.com
 (2603:10b6:301:73::31) by SN6PR02MB5023.namprd02.prod.outlook.com
 (2603:10b6:805:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Fri, 1 Feb
 2019 22:09:15 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR0201CA0054.outlook.office365.com
 (2603:10b6:301:73::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Fri, 1 Feb 2019 22:09:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 22:09:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40513 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzq-0005vs-5s; Fri, 01 Feb 2019 14:09:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzl-0000P8-2R; Fri, 01 Feb 2019 14:09:09 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x11M8wXt027119;
        Fri, 1 Feb 2019 14:08:58 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gpgza-0000LK-KG; Fri, 01 Feb 2019 14:08:58 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 1/3] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Fri, 1 Feb 2019 14:08:48 -0800
Message-ID: <1549058930-18644-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
References: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(136003)(2980300002)(189003)(199004)(486006)(81156014)(9786002)(11346002)(2906002)(54906003)(72206003)(478600001)(106002)(7416002)(36386004)(50226002)(39060400002)(44832011)(8676002)(81166006)(51416003)(8936002)(476003)(76176011)(107886003)(7696005)(77096007)(126002)(186003)(106466001)(26005)(2616005)(2201001)(36756003)(63266004)(6666004)(336012)(356004)(16586007)(110136005)(426003)(4326008)(446003)(47776003)(50466002)(48376002)(316002)(305945005)(921003)(107986001)(5001870100001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5023;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT035;1:EGSmQpUD9ZU6YZkkhb4bVTvHY+zCTf3lyZDUVasyYK9XOfo1SXpPfiCG9hyGJ5I13WLtdIeTDGc5iQDKCQ4ebeI1aC3XUXPTTr7lK0R09KtdNPLvopd+3u6j1lEQJp4iRxgLjOUuL42sDm50P3SZbUdgyfk+JDNp//HLN6TLtzs=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19dc6251-8b19-4530-f53f-08d68891e74b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB5023;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5023;3:pem+Cdw7zSd4DSvpBksr1dEDwTzINUO8wH36OPOOHe4vfUn19EGVCzOMrzzxDw6ie0TeWt+kl3xQIKjD2f9Ci1QJCCsNbnRVMPve8JogAisa0tWVEgTSLZ/O8MnQRYiJcPCD2nI+kppuhbfU49Iq71/tyNSCqP7QjW9p6l2x+9UdVYYjKFOmCaep0U/4IrlMedIPH0mT8f95jBBMDuIf4QtHPWc/svfxZfGC50t2E5gL4O9JTY5TlioKF15j+7e1mrHhS3LGTvFuhTYR5jfB75U1rulRXW2sZ1TZJbyG21/jXWDFfO//3t7sFSUwSsHyVziTCS2nzinqOM4ew6RTEKqWqg2XEmtrcIpabupVISXmIiLQlrH6vikWjtLZH/M5;25:r6deKfqV73RTeewa+HlhOEq50u9QuTbYSE60/M4EfK9Pd3oW2FJA1WNz02M+NKVvhj8BPXqf3H5taRo4WfDiXEDMnk8x05hzJFdtyDjmQy3a+Nxk4sMN+Rvo9y0qrAICH0LQqpCLSTiLYKQGzVlmMFj9p8y28JBBJp5dHeFrbfst2r56xRYeUo4JSkOdRHmTZfO4Wx4f4xiMflayqUS6bXXY76Nt73lZ1bbSFGGlHF1xLdbdDB04OxPXe/cnAhVP1rMcwv36QNQVuukzCSbO/C6HThcaxfi7dooTb67h0ebYPsJXVhBx7+JDkM/XaA+5qA2hHjBydk1kypPT73Owlw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5023:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5023;31:BSSRtMyDKet9JNzMp+QBY0SdMLfQclh3s0QDN21QLjvGT6Od/reySidKrtcXZAPcgS3ZAbTMjWZNi491yH5lwsLNGHgNCkvqBoEKEXP1oZEeB+mRvCObLZ05M7WwSN018LT+CSnsLUPcc/CAQNylNyxr4hR3lUMt70WDU4mPTAe9qhMDMCSV0lJ/UjJmox/pGNKUk7TjZE1p4TnoK/iB0zEhBj/5AHrgMO8uxH74psQ=;20:ggG3r3g4dJowKWrv8zp8yCJ0HFViv4FsLFuKKLmzfnuzu8w4iPaKwKmK/13rVfTVhWAVwCAMLdUnwSHoxXeeiydZdZXoxIeW4cIB7GQOECu1tXKoz1P19UxbdTyor4YzvfQxYR3z4R6XwwbyHEdn4a7IdLdyYukNL9i4sXRZSiNPo+wakiS8fBzUwy9gQ5gHaXAaVfPXavYAzdtHH3LaizvsK+AtHvl+KtUZJNabUcrCWD0q3uAHJkuoeRm6//T0hZvsturuPR1S8S6y2Bi5mh+y88KgAT3KlidmWdF/mspb3z6RpSLYK3+gCr0QnpxUwxsfohFT1w9j5SSVDOU3TBoT55zkMWEz4yV/+Hzqh1OvnKM0HScdExBbn1iAYZYyS1vmV9zc9O1BPHMAevtbtnchiEsUp4F+MyYcU2O6r2Atpaq1tsrZcRPC90n+uctWgs8epZxED6d1d/M4VAR5TxWypW7SUycc6yTK/AD+0Cq17x5rjy/HI5dcDfFeWHzn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB50231E063966FBBAF8BCC8EAB8920@SN6PR02MB5023.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5023;4:lKQNu0x1gzDBmJw8qbTInH0s9lAdYD6YyMmUGp34U1K6c0Zi3WFQm0sIEVOa2JHjv1QGvnyA3fEY+G8u1pVu9Fn71iqd1MoKvqjfh9q1F/MRygxqGZ6m6d6KdYdoexJ0wwhXCrIUDb2aZuiL0j9BOKKPzFEAx28JM3z8tuUNifCxrG/yZxQI1Nc530vBQLuBtATOyBF+X71gje2HyElUv9oAB4dw3wxrJDP8tQq3TvfG1IaqpS0Rmi36rtf5kAQ2jQjDpk5fjeGzgk1V8Mr/s5sJ4sAny+gaK00WLpOYx28=
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5023;23:9rI38PhE3UiiMPzytoE0fNxUNdi8HmJxS733pHCCw?=
 =?us-ascii?Q?MjjBeNp44jsvkE8zMdwLSFA8tjY3yZpi6AQbuQEA3l4r8IWvMCauBb431t20?=
 =?us-ascii?Q?x9c47YPgjjrMPDh0GbGxWG0hg5z1VvZg5Znfz0QJHUhyfDxCAbLWqzC304fN?=
 =?us-ascii?Q?4zGAHH94Xe9AEAvXlKGEu7kmlzLWI5xq78QL79wFUks5ZrEG3miCiVfitFv1?=
 =?us-ascii?Q?zGmjkXkRUky2XhFAtMD+SlRlGfGCOsvtO60weKT1R4+rmGQZGgHpSiW9iOLc?=
 =?us-ascii?Q?sKa7RToo0MnpcCF9jRZ/AB65F0m6y+sK3ggegdld0tZNVrxh0RgpSSjHiFlj?=
 =?us-ascii?Q?dodqMJjbp32T7kH2JKwRcevPGqevcgs9QMH0FWs03a6WUsdUQqPuO1/Fipqn?=
 =?us-ascii?Q?zcuiIONpbhR2XSZMPy/tOEZPLfF7u6UBShSS/zf9nNESh0mfahnFzyrohyNj?=
 =?us-ascii?Q?0oFjBo2FqVJPtANFyES9DZDvmaO2P+As4acET/RRVbtPjL6wu6eRyOFUxnIR?=
 =?us-ascii?Q?yw12txUBcydsWgMwi7HHsvBHryx3mZtaik1wTfVGiKtnp4gkG2zMfY4MYrCe?=
 =?us-ascii?Q?oE0/ek1YWHw4PPkvjVdqlnvo4WQhAIBkFo2+mObZgcyNcCmSr0p4Q8NmPhzW?=
 =?us-ascii?Q?g25nlpGqHqpRrq+IaeOLxhKw2hsjF6YDcSPlHH6bhLtrR4xE3vVqPEDcruvi?=
 =?us-ascii?Q?qM/FT94583xZXliWQjcVDIxp0svjaESXnaxVMLM2IxQUqke2N31W/5L7dlrq?=
 =?us-ascii?Q?ghsJquejlrpPsPV+JDkjH2Y0RaSsDCP18cQQOh9e77I38jNuZa95u2hYOyLU?=
 =?us-ascii?Q?FD1eoJR4rmqFXhYyu6M5JUhxRj8Qxmlq//O7jPW2cPl/eKlgZ6fZgn/r5NS1?=
 =?us-ascii?Q?BvKrbuOUR837Ogd14H9G4W1v9mwtIeAlGo6CWPmFU6u9ERehEAHLUyhX3gKL?=
 =?us-ascii?Q?LmyedtHCL7X+rBrjpivDCgpj9O8rsNm1pLCPTuiVRPl0VNJ/TzOg7Dw1Ll0I?=
 =?us-ascii?Q?iO1E5TLevxQYsfSI5XhJZzgqG3EajLeCWPqKih8egVnrBumzU1YyBUcjM/99?=
 =?us-ascii?Q?DuEPLAKfF6ke0I92JPvyBuRaEqWjn5O4Otl5+bREdiJQUtdPfJ9butMHqFo+?=
 =?us-ascii?Q?lnCss6/DJYwzgez2jXgYj4A/q7mCIV4oVGBSBqu1W1ewgx2PPC471n8pWQOQ?=
 =?us-ascii?Q?NEgwccjTjfUt0rjJi7Do+MNf9Ww3YcVSGXY/iOV/GSptPA7pNo+yvc/io/Vo?=
 =?us-ascii?Q?Gktp90r/ko5MHLY2H67aW23Ic3+1bM57sYOLMym?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mmKVG3tpBAbtuF1JeYsuO0+YRwOArv624T7Z5M/Est0MIfDXoP/N8aQ8/37RXIgMNW3rCLAVITVK/olm9n96P+JLbnWMxSeCuHZZkW0Ch3yfUBaRvnKEJqDTIZNgSh2KDHeZB2xRxcTyLf6YoxZqer87PE0Oyx3hbIOepubyOaMGUfKsorWT5ObKBi4W23K7vYlR5sfBGHRNaJQz6AGUe662rWhEHL+Yz7bnYCmL/NVhuzD17jNw4cWz0FZHyFmc4Ibt3GXTSMddyU/InbcY0/kQQe6BcdjTF6W1H9UPshQdMENL1VQd24jjEktfnHwcdvqByQVzxmSwiBcuB4RZzG5W5kqD42+QD1biy862+qQN5xlIY9sgEgNmb4U8oJo1dApxjGp/xSymepuHUSoteimzMlLE5SAMGuKAm3Uckhc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5023;6:IzYYU4/H8nOMXZ267L6FMiCUN2SKfm3KU+1KMmKbl39Z2Dl6N0LR2/J+ncSND5ATGllI7XqK81pDb0c45vFZkde+pyFdonnKkg+MdjWlmmUakkMGWi8YXxNHtHRBeQMwhEbLup4ekclKOIBKPrrKOGjnRxhGADZ08tnH4Q2CKKL5CBelvvfukbWYkgArUOf5jYEyoi4IRCl93nh0z9I4LOuqRLjHX+Nv0JIxRPzFQA7DZASyNVnyMVPjQSpAflm/spqtzeajrbz+WDd1rYzL5izSlOgCCxvW2UPisRZkEroGyn+UBBFpUS70FFn6HLoyH1uKK7a1+AbuvIbbB9mw97cZmV1rtwgtfJd3389zvuALYrbS/UIDUWUkz4Da6IuI/hA4rfcsOAsKUHQ5q1eKKEWGB0WPmqxFGcAWGdaSbgmw7LWl9YceDo5nRSUrEkvTKeRkBB1DXtSzbC4lwIJHhw==;5:rfIr+VwkqVXWB1YGGB9Zl52GhEEYtCdZeNWz4O/e+ScYg+uWqQz0lvUaKhtBAQYHkw2PBx6HOluJUxyaMcd+0o1sA+eGWpVlu6UP1LeonXLmyO+aMdBGbY2c1bFE/HxMVwOQQJf3CSJGx93bQFJNcgSwcnmIyrUidMN07527jzyB2YzhjPK3g6EpGBDjSbPBPCIWNHa7K4XkxaJN7lKFFQ==;7:a4ShTMKTlVPGWiXmE1/WnMUP+7jLFFjPLtq9DRMDUop0bMGLEhl5Tro0bwoCZsNBWlk6sJLFQV2o3XG05XjUi55COc03GCPUqoQSn9o5Pb03h5gzRoB7kLNyM8NjjRefSXjJGlOsccY6lgU++Vql5A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 22:09:14.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc6251-8b19-4530-f53f-08d68891e74b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/xlnx,zynqmp-genpd.txt           | 34 +++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      | 39 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 0000000..3c7f237
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 28>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 0000000..0d9a412
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	22
+#define		PD_USB_1	23
+#define		PD_TTC_0	24
+#define		PD_TTC_1	25
+#define		PD_TTC_2	26
+#define		PD_TTC_3	27
+#define		PD_SATA		28
+#define		PD_ETH_0	29
+#define		PD_ETH_1	30
+#define		PD_ETH_2	31
+#define		PD_ETH_3	32
+#define		PD_UART_0	33
+#define		PD_UART_1	34
+#define		PD_SPI_0	35
+#define		PD_SPI_1	36
+#define		PD_I2C_0	37
+#define		PD_I2C_1	38
+#define		PD_SD_0		39
+#define		PD_SD_1		40
+#define		PD_DP		41
+#define		PD_GDMA		42
+#define		PD_ADMA		43
+#define		PD_NAND		44
+#define		PD_QSPI		45
+#define		PD_GPIO		46
+#define		PD_CAN_0	47
+#define		PD_CAN_1	48
+#define		PD_GPU		58
+#define		PD_PCIE		59
+
+#endif
-- 
2.7.4

