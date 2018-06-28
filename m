Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91759C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162427408
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AESaKksb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4162427408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966181AbeF1NN4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:13:56 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:44560
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965644AbeF1NMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNOmq6mOLRXeLtr8fz9bOt812t0/cXQYkwLv9WyDn2c=;
 b=AESaKksbyXkDqq8/gMu0PIGr0oE/38c3lBuo/aXZzRbF19GepUGUb0gctrp9tY97v7eaNc+V/N8bqBdByNSqHtDJyCVGvS8GZWJZI690EkFQZ84wCwMWvznfdnZeENHmqYK0HA/FoLAW2z20Be/QWK5Dx8f8OO8YAfIScKtmFvQ=
Received: from CY4PR02CA0036.namprd02.prod.outlook.com (2603:10b6:903:117::22)
 by BY2PR02MB172.namprd02.prod.outlook.com (2a01:111:e400:2c20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.884.21; Thu, 28
 Jun 2018 13:12:04 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CY4PR02CA0036.outlook.office365.com
 (2603:10b6:903:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.21 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0006cP-MK; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-JW; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBsli027436;
        Thu, 28 Jun 2018 06:11:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiI-0001xt-06; Thu, 28 Jun 2018 06:11:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 2F050B20955; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 4/5] net: emaclite: Fix block comments style
Date:   Thu, 28 Jun 2018 18:41:49 +0530
Message-ID: <1530191510-10310-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(50466002)(76176011)(103686004)(26005)(186003)(426003)(48376002)(36386004)(6266002)(11346002)(2616005)(476003)(336012)(446003)(126002)(486006)(478600001)(42186006)(316002)(110136005)(4326008)(54906003)(106002)(51416003)(6666003)(14444005)(2906002)(5660300001)(52956003)(2201001)(16586007)(90966002)(50226002)(36756003)(8676002)(81166006)(356003)(81156014)(575784001)(47776003)(106466001)(305945005)(8936002)(63266004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB172;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT048;1:Jn8n39cb5JJHxreSML58X5S+Ak06SLpNOi2yZ0wDW/VcTvbMeHRvU8mkM+MlPBuKBlKcwwYsHNO/z9GNE8IFNl9Us0oN420LkZL9NsU+dAdk9cboO96tbsBpa5V0zbRs
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38dd2f35-55fb-4e3d-fa29-08d5dcf8bdb0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB172;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;3:P1IqKSvHJCORItEmMVWWNZcLYW8mYaTxGGp9cBbmV1chvufVXLajSuWAD9Zmb1+RaPkjyVseymoeuITTMV+R9Zx+1ZExQaChGy7RJsg/4TojsaPT3byq8p3rPCcXQs1ZoazY0y5u95sjgzeySOw/MeHs/4BKsbVNbFTZb9cPpXOOR5njFe3afNdz4QixAewJCFxCxqP5Vcny63vT0Q7/Y6EuerjPndhXxtDUYvkvc/4lKrmc/sneRBt7qt8neHXWO4ouNNN1QI+xCyXn3TTHgMrEhrZvPeL22souQatYKN3q0kLwUATeC5kpyWDRbygnw6thjz9ygPsSL5xdWSa3XHh8S0b3hYHPEqvc/HD01O8=;25:5QC+hUMS0YWOLoXSeqgnmEPzcn1WX9uf/qkrgNHjw4OvvODwHleozdzZiJd848xt4YbJQQwuaASQY1Kt529DVE1FOSipLd89PG9PRNFv5Ussd6vvEs5yR3FpFqMXI6aJoljINyZJBIOHATzc5W/K5jrW+w5WrKvWTgFKPbEBBnSn9jARpo8kx+UaHVRmhEW5o+5BLBLTbxnuHbRUo2VOHexvf8tU5m1XwkBvJAfwHJWVYO5H1LHKbKyrOz+PWKb8XemjC+8iZt1EOPWHJfWw2wt1XRBvv9rDoh1jNwPh+aiTgE3ILgSxWMzVkT6yCVJ/wDcx/Fwnq9mnSCshfMegiw==
X-MS-TrafficTypeDiagnostic: BY2PR02MB172:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;31:vdL2X7mxlGsndTRT+WTERmU+C6y1BuobHbMR3L+AI4K2t5UehZEVQpCFiMQ7P8yeJ+pLJ7gOJ7UjMfsdc1lfAvfjo7qVIwNUn2GKtieoGIJSjgAU3Pz1MnyW0rYD490iYFEWwteEnCrIOA0Grxw5OSCvfRkdNhhSHYqpHGwFg918y40RmgJgquCVtARWqCByKvHUwbpfBLuIr7ZXvhWr0ZxuGfqjJ0TmVpMUeTYAx+Q=;20:iksHvqlP+NW9T7ktv/9QRRXI8gIaXxy40z7G+vfo/A76z56tYJazTrc2CkWHS1ZeOG+bc1KRFbEJVj5GHZ0qU0CGawJUlziLCqa+Pv/RXQj7RUpGzYPifyaQUljRH8VQjfw5XT38nmuEXiUxI3nb6qhIkefAyyk44wkab5DbQ+gnpN8pnNL8oFr0LSAvyHdM2UoxhxpsG/bsfUXyvLQreZhYgXvvpC6Wl+b4asI15rzUWZQgEfRwo4qQNHMAXObEnHQLlOarfKYTw0QJ8VzGo8ypORdB9ApMA2WOxTFha3YsT3UV8D77dDhDTTHqXm2XOTa6A151XVDROeKqZ8BDS4gTxRDxws6z5EQx0j4LQ5jDyGyK5bklDo+Dvk2S4HTMu1Aka0xH0Gvx5+d+6xPMZy5KILzGJKwzyzgAhkWbzb5i0cJL2EFVrfNsgtrhzxYvSmPT2dHziKucu6/Nda4yxnJzLSlCKwhZ/bv8N6dNX/T3pO5mLQ/sxIwMbzww4hAc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1722E2759A3E7A0665E54E2C74F0@BY2PR02MB172.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB172;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB172;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;4:Nls5jZieBTvAtzROef/oze8KMycKn1G/lNUVfYc9zLZnTG6MHIkGOxfpFeHSCA+QFKUAN2Z+W4pTowO1wuUTTKdylWccHDyWAIuBOfpJn9u/n336WDxoMwdxZIbnXnEXwjXIMCMqu+QybIKwvYNs4Aw1VMWQ7/TsS3AD6qEZd34T3ZxdfaypfyDZSTsPL271Z0WvcxeyPuyxlRrkQIhLBqAI7+jU2OG4MEguo+ypUBGso2LJ0yfZXt6UH+B8b457+YxiY3/fIj4CnZyPKz9lBiWRCJAP2NtMbWjTCCjLHfkx48Ob8n88wEcZ7kMaTLa0
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB172;23:Gab9szGY0lr2qDg/38xAvxYBnzZFgNHz5o2cIOL+DW?=
 =?us-ascii?Q?ZbGq7tXLhnieyk5FudbtZrBjsGzOnzWR81zrPsYu9YPXQw6aNVEPpCydWC6/?=
 =?us-ascii?Q?2wlaaGqe0Whp7xCbYtErIPOsxRUmZ39asG9hjTyuxqjiIgaRZol+X/sqGImP?=
 =?us-ascii?Q?ZCbp3GudGQ4gNaddF4d9NJ1Ckhb7BDmlEQE2bN30tpvYlbrftnMLnA0WUUGp?=
 =?us-ascii?Q?pnbGfzzYovEO9L+tJYGR22LsHyTshKpyNNqsk3Tbgx8yFUmHIdRHfPikg9sW?=
 =?us-ascii?Q?aRpT1IPKLlVcy8TA9kba/svzinYo4WlkXHhsodLckFQi6WQO5aqPLOfPbcAw?=
 =?us-ascii?Q?ZjtxjgdE2ltklenzCKrngPvAIV5KBaL54wHGsuzKmx3JbsYQyT30OOQvg7X8?=
 =?us-ascii?Q?Mv3OVBUEAHUF7bAkgztFw8ZCvp0NBqdqeafaLdodNAmo7u5QZuTrxFzt4rIy?=
 =?us-ascii?Q?PvJPd6xjw6YbWVn97Xq8Wn7r2/Mj+Fx5omkGuDJ1DmrTRO0PgxufwIiZHNSn?=
 =?us-ascii?Q?U6TEgdMvG9/PZdzWrrvv40/MBV6DRqmwrtMJul/zr/K1EGInjHEvBQnHC689?=
 =?us-ascii?Q?j9iGp3urbz1vhim3riWcQ8W7ibq9X4J8aPi22ieucG5dZEZ9SdJNM88r1ugW?=
 =?us-ascii?Q?B87ZhzitiezSfcU3mryfEgVap/0dul/zZiKJsHTuWfL45DkrXYf+gMGGB1Uk?=
 =?us-ascii?Q?xsRtfbcgpS5TEWv4MSibZ5dlciaq4x7b9v9OdwTdun5h+zE4QNr1hCaiwEiT?=
 =?us-ascii?Q?BwtJwIGUKriyDcA1+iMUg87d/aDBHPKHd696xUrLkeLnct/VghRnzPPlD1Fh?=
 =?us-ascii?Q?vVGxxmfbT0IwvvrEaXuKiz8wxnNS0wxhEm7Dr1XKg4MdnUQJhcHtnKebqj0l?=
 =?us-ascii?Q?x9oCZLwrer7iCw9BA/el9z3QqmLE2+E5oGNYJY+XP3jj7YqPaANgWGx27B9c?=
 =?us-ascii?Q?tcWogoopWR5CVuVVwAUzqOyjE1ojHzS5UtV/rTjsqjEgw6EkJ1WLFc1FoW2C?=
 =?us-ascii?Q?Dut4q57SfP73FFNfsWdtoVcKQqYuTN+lUAkCcwHOBIFH2fyZQmYvnQMs5qpj?=
 =?us-ascii?Q?AuxXP4A41Qy0X1QEjLE6Squ4bRYai6D89fV6JVyrZE2mmTNMCK2IKtE7ZQv8?=
 =?us-ascii?Q?R5RsaNzYERHzPaZEkoUR9CLYKzKYn7P8UCkSCpZ7omjvW3lrW8VRKeVpzuAP?=
 =?us-ascii?Q?wfKLOAWsGBrkY=3D?=
X-Microsoft-Antispam-Message-Info: nBxpX7VVagAH306oER84p/4XKYLlKOYsbgTp0lhLQP3jpxXPXLeoIq1JIkcdVqrXtCVCowGGjs0HT20jNPATCwLIa8Mbx9epEfnGTchigo/Oaw0j/03PDimfb1ee735IiHKbp5zQlVBoNs+FX6rJPkMYwcRpcJOC50naPKFmT8rlLDu2ZOzgAcsFecFBoEPSWScvJVgE0DKhjkXUS73aEC4cwXioO8oLl+lr+/Z/G1fgZI6bPMvVKOxlHOIghywG+wItRUT6HVl5yiw0xZXbX2PSXjui66urwTWCG4otrRMstc96pW0FNOzLLiHtJeBYrLOyAYzFPDjVFGK7hoMrLflRw5VEeeYLYlGZ/s0KKaQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;6:h+gk51w31gf6SC2a5iUlLRl1muNhnZ98XtKzcuDTm10CYSu/L3gJ7dQ7XL/hsms69/LpP2MPqHUykZ77KUTyF21jskXc12zMlkGkzhnonn++pl+K4UQ9TfcHxv04dTOCcTAlLfCKDgJK8OdVs8cazZfziWeYsoig9bygUAuFEjGNoj9r9oZ7fRN1JYZKt0hLVwzYOSYsI3RCz9ln6DY2T4spqNKeO0HcoONzAYZtlD80W29GwDl2nbIbRTaO+PtIFo25h2eNJ+zU0f08m4txI/2BXyvbkStN5c8jWOiSXKZOteUcc8ahICULVG5jiY55/4w5H/yGKvhG/Xk8lS49y98CzmsvQsDEJx6IY08vSOwqvgVnVz4CRYDwNRajk21viTKQRuAmah/jYg+6lectxurBcxMf+IKNP9qFVqA3MHp8djEcCuMOGPGTy6kuVsQPxXx5XgvK9Q1seOIZn05+rQ==;5:RCZA9UyMQG/VjmInXe757pRQmfOfC4R3L/kW0OWOv7cmoget0o+XNPUB0MFrkumPGLfRP6Sw42RVt44+b7+6ipgYNeMM6IdN7CwhV1NS8+iuD7KhTPWh+TTxQdirGAQveFLQ7chZELOBJ1eI++lP6roIxEvAKZvSR/HUXJA1dn0=;24:uIZ4SDGSJEJ+Vqd8rDhKvzr5gvu1Dxq7TdLNPX2GoYgRUs3BxLSZYNiNYzVw6TTVfx2gZT2wBwWvrrfRhGvnGu7WCh08P4deSCz/AJOy1Gc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB172;7:UaZjvsGgLEyJzPANj6/GKq+yyiX+LzWUPwSIBcE4nZLnxo5JAu7JN0AIL9KrBkQQyPxE1FfCK6q9VXwsM2t0bCKsqk3qGiySGHf32pEq3DWqoqpnAPQu9gRsTEh3V6IFj02SrFHSu/gf88/Uz+tptsuFoc3t8poruwaULOO9Pwu57yLXlHVIuWoTAfc/BsCgFBxJpy2oNYe/FnRtGBy/NallafJllGxtqM6AZoVCEJ/cE+7yCWqOmzXhZ19HkJ/1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:03.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dd2f35-55fb-4e3d-fa29-08d5dcf8bdb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch warnings-

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: networking block comments don't use an empty /* line,
use /* Comment

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v2:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   34 +++++++++++++++---------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index a17f0b6..f96c920 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -70,7 +70,8 @@
 #define XEL_TSR_XMIT_IE_MASK	 0x00000008	/* Tx interrupt enable bit */
 #define XEL_TSR_XMIT_ACTIVE_MASK 0x80000000	/* Buffer is active, SW bit
 						 * only. This is not documented
-						 * in the HW spec */
+						 * in the HW spec
+						 */
 
 /* Define for programming the MAC address into the EmacLite */
 #define XEL_TSR_PROG_MAC_ADDR	(XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_PROGRAM_MASK)
@@ -336,7 +337,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 			drvdata->next_tx_buf_to_use ^= XEL_BUFFER_OFFSET;
 	} else if (drvdata->tx_ping_pong != 0) {
 		/* If the expected buffer is full, try the other buffer,
-		 * if it is configured in HW */
+		 * if it is configured in HW
+		 */
 
 		addr = (void __iomem __force *)((u32 __force)addr ^
 						 XEL_BUFFER_OFFSET);
@@ -357,7 +359,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 	/* Update the Tx Status Register to indicate that there is a
 	 * frame to send. Set the XEL_TSR_XMIT_ACTIVE_MASK flag which
 	 * is used by the interrupt handler to check whether a frame
-	 * has been transmitted */
+	 * has been transmitted
+	 */
 	reg_data = xemaclite_readl(addr + XEL_TSR_OFFSET);
 	reg_data |= (XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_XMIT_ACTIVE_MASK);
 	xemaclite_writel(reg_data, addr + XEL_TSR_OFFSET);
@@ -395,7 +398,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		/* The instance is out of sync, try other buffer if other
 		 * buffer is configured, return 0 otherwise. If the instance is
 		 * out of sync, do not update the 'next_rx_buf_to_use' since it
-		 * will correct on subsequent calls */
+		 * will correct on subsequent calls
+		 */
 		if (drvdata->rx_ping_pong != 0)
 			addr = (void __iomem __force *)((u32 __force)addr ^
 							 XEL_BUFFER_OFFSET);
@@ -409,13 +413,15 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			return 0;	/* No data was available */
 	}
 
-	/* Get the protocol type of the ethernet frame that arrived */
+	/* Get the protocol type of the ethernet frame that arrived
+	 */
 	proto_type = ((ntohl(xemaclite_readl(addr + XEL_HEADER_OFFSET +
 			XEL_RXBUFF_OFFSET)) >> XEL_HEADER_SHIFT) &
 			XEL_RPLR_LENGTH_MASK);
 
 	/* Check if received ethernet frame is a raw ethernet frame
-	 * or an IP packet or an ARP packet */
+	 * or an IP packet or an ARP packet
+	 */
 	if (proto_type > ETH_DATA_LEN) {
 
 		if (proto_type == ETH_P_IP) {
@@ -431,7 +437,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			length = XEL_ARP_PACKET_SIZE + ETH_HLEN + ETH_FCS_LEN;
 		else
 			/* Field contains type other than IP or ARP, use max
-			 * frame size and let user parse it */
+			 * frame size and let user parse it
+			 */
 			length = ETH_FRAME_LEN + ETH_FCS_LEN;
 	} else
 		/* Use the length in the frame, plus the header and trailer */
@@ -602,11 +609,11 @@ static void xemaclite_rx_handler(struct net_device *dev)
 		return;
 	}
 
-	/*
-	 * A new skb should have the data halfword aligned, but this code is
+	/* A new skb should have the data halfword aligned, but this code is
 	 * here just in case that isn't true. Calculate how many
 	 * bytes we should reserve to get the data to start on a word
-	 * boundary */
+	 * boundary
+	 */
 	align = BUFFER_ALIGN(skb->data);
 	if (align)
 		skb_reserve(skb, align);
@@ -708,8 +715,8 @@ static int xemaclite_mdio_wait(struct net_local *lp)
 	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
-	   after some time.
-	*/
+	 * after some time.
+	 */
 	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
 			XEL_MDIOCTRL_MDIOSTS_MASK) {
 		if (time_before_eq(end, jiffies)) {
@@ -1029,7 +1036,8 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
-		 * current transmission is complete */
+		 * current transmission is complete
+		 */
 		netif_stop_queue(dev);
 		lp->deferred_skb = new_skb;
 		/* Take the time stamp now, since we can't do this in an ISR. */
-- 
1.7.1

