Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE31C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3B72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zynxL1DY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B72133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIMApg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:36 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:30976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbeIMApZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXpnrGnim5InV89BSoJZhSpBah3sYxg5WMt3C4OkFW4=;
 b=zynxL1DYurjOUNQHgTr/ug7pjpzz7kHcx4PMIej9WNey4Q3qq4ScpOxRxGAgVGC2Jo9jJslxJxpEBCBN5LB/Dx9Y1/7Bsst77JVwsL1k1WevvxJo2v2u91wdfo8ppygnzP6QsndUUsZUS14AYPSvxoYUx24XvMO7CyekuLFw0rg=
Received: from BN7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:20::21)
 by BN7PR02MB5107.namprd02.prod.outlook.com (2603:10b6:408:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Wed, 12 Sep
 2018 19:39:15 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN7PR02CA0008.outlook.office365.com
 (2603:10b6:408:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36150 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0007VO-M1; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-IT; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwwI027620;
        Wed, 12 Sep 2018 12:38:59 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-Qa; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 5/6] firmware: xilinx: Add debugfs interface
Date:   Wed, 12 Sep 2018 12:38:39 -0700
Message-ID: <1536781120-22794-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(106002)(316002)(16586007)(54906003)(110136005)(72206003)(76176011)(966005)(478600001)(7696005)(51416003)(63266004)(50226002)(106466001)(36756003)(8936002)(14444005)(9786002)(476003)(36386004)(44832011)(81156014)(305945005)(2906002)(2201001)(81166006)(446003)(11346002)(2616005)(50466002)(126002)(426003)(336012)(6666003)(5660300001)(486006)(48376002)(186003)(4326008)(107886003)(26005)(356003)(77096007)(8676002)(6306002)(47776003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:yhqx/HO1F1V5D7AzGZpN7J3XcjiRQjToT6C7mzNIkheKSVgOKpTysQNwHStX5X8daVwfXPG/bbUqxBZVZKxZTDapv8KgsHozsqmOWQiVKNh6QmcL7tMzqnVEzQ0SPPYc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 417a46a6-19f8-4c6a-6e24-08d618e76c6a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:etVam2NCcPmBiHeHja18ae3azx6/Yh9gdbnQRsotARewcvZEgiTXyAd77TPA4lMySEMfLuZa/KKGS8Lf77h5c+ROYqs6kRgkfRc2gjmIfMaUlon5+X4ztLBkOcB24INNFeRLEDlXnLGZg7Js/Ksfi1Dq9b4REVshAG8JmKJGTalFlg84O9SV7EL8HsiNhzKvXuGDe+FFji59o4obowvu4gcmgnBJORP/I2oPLsUH5XOUgtHlC6OPUaRi7QephlVeeuiu53duRErtBinlUHc8fOviX+M/oBw1N5bh/A+mfg5UC2QG2C/TpRpyMMnTV9gUVlEzqBdNQUqJiJGvP/3h1vasNbqybzBRN4v17xF/MO4=;25:KM+vTeFjHvBMb29O8+D5F37hMMKBO8Hpr+Q7s8ZHvc+CI6MhRiRxys3kcocaa8TDdUT+vYz5AFOqksi5ZI+WndKXHP//qXdkgZQz6hGY2tjkgsqpBndTr708HGK0f/8vmVinV66EEa1U8X5XtOJPA9JPVjtcXkGjhylOuf6sVnyvMhDceVjYwjMgP4YDGp/L35mbX7zBQVRP4przavlxd/yAC7XlO7W8zZxFP++yECQ+v2ACMIVJn66GDdt9VggrdLW2xJdOjX5buPflYEFH4mRXpE8/op1lb+V+3KtYm1NU2M1sRjOvGDuTze/96aXSjLVY+BXJjnLa0iyrRWHYAw==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:NbO6lqYhVQvcdJnIE6P80I6jIDVlw7WBxTuqVK0UfOxjW1+gWqmRCqOsnzGXY0K9DEmVNhVfeTuaKmLHtZthhf1h+KbsTjqtCToU4KGsCx5PjYZLKbALgod3EF1QQpJL29zqLNz5KIp5cViSqC/WgErxEDxfe/ugTA3W23r9B2iVdTdP+1RWb42GxDtzmoz+JH6HvJTRm4ppwSSntW1y5QwfcsJLPTFj508NFDxYp0k=;20:+a6YuwLKGGQ3nLvTQJN/8bXsS8xW60HG5DigNanwC3fEby2Zu63pzZkAa/DuWqz1eBkkBZQwEUpl4VxQUhG+KLXCjL5d+qRfA2iiQO2ywZVfBtskoft6CPuhpKYuRXTjRN069grgx80JHJRFsQX2ESoNRZyRewggPTnF0qs9CItm+4FcMV1cYoFsj+gZS5TRo7x1fUWp2K6OhPTYm5nmaIutjmxE3RnvyA6rf6Wc7sR5oBH9+F+WxjM4Ta/DwFoDLX2WlrfFxSGtcSwc+RpZ8B7ATopBw9BRJ+svcQPa7wEDGG0g1XrOj1S0r7A6ROYx5AEx3uovn7Nue2TMjTiAVRAg1ijxBBgY2rAcHdoHHjN0kFXGwV4qz70HJtUuWDIZgu4cZgXiB2hygrB7RoWurkqDcQO/B5KB/1aT+viQSC6IOM6tPu3IgZD5DCr3NKRgloxwZRMTRu7yFGPUWQomq1ZRN1etyAgrBYL1Smy/RLhLINuuvKUyZqwzN/0lcM+l
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51076C90A4D19F765C113A79B81B0@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:xzmLyPpbcpfcpQmlv42PaxwhbHpjWozCIw6LnHwHD+JQDv4jxPnYM7GV/wjmtrnjBbD8M7fJdgKPmC3dpAMe23FfjajLU7sZVIMq1iSEN6Oxb/pgc98gmpPtOXmmXCVWD3ewQ5iEnY3YbX0EuPTGHHZY8C85zRPqIY5MfcnYAzB4c+nI9OW7Vxr/jGmuAtsxBz8FxspQ8Kkiz2KLEyb7baZn8WEEZYOiRN7rXDgNBTdr0k6O6KCjeg8ZDlnOsA8wrX//4ssKypBQts+dJjLLAvqb6XpetCFi7xDw5HfmdI0b9r24pSFQ4JINtNCOmPL3jI3bdQN4QTFCajE3TRm7ncGhK0EhKGkKEwQdvaHKGHE=
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:2zWexxofXmo/LY4npRDVTcVLPZ75reFi/rxhsVr+T?=
 =?us-ascii?Q?B8t53Pg8SP5h8OEBNPcXyXZNBDGzsJMRSy3VxpUhVmiW0x+aI0u0USzCmGYn?=
 =?us-ascii?Q?1374lw7OAOwHILuwYTOdVWy31u8M6glPop/P30HqvcPz7pHTJoy2WUlDdnTz?=
 =?us-ascii?Q?yAzraG5Fvl82pSzBEOnqy8hhm3ZPgSdkzAtmbfEheKswIZu27gJfn6+QJHI3?=
 =?us-ascii?Q?pE0Yqkrjdf/+eFkIksibiYKxCQDNvU95PCjzx2uB9SLce6UzegyhEcexrGXd?=
 =?us-ascii?Q?xdmE/F71/4r95ctiAbHPGH3QD3MG042+3hQq94Eh21/4uJf2BxZ7XwYV2uvs?=
 =?us-ascii?Q?PkQ0k3CZbMM+EkTCsC9OskHh1prfQAIdcJFU3UJ06Mf9AJTo81td2oLvYHF2?=
 =?us-ascii?Q?9a3NwSfTraUQElj8JB5CV2o6HCaVR3v/vXmAegYVa/2DMetgJmFTdG4n+Gs8?=
 =?us-ascii?Q?8bVLwXdQw4JjCdBLbjtKTZ5GcABGG8H6G/0HhTC0UgQKQuOak1Co53zXdkhj?=
 =?us-ascii?Q?w0gQdQ3/BnApMgLL4Se9lWosVLNxpECbKmqrjQnDd9CD0YRaiuSX2TaKSUFI?=
 =?us-ascii?Q?Rpb2VjdGZVF2c/t013KJkENXFmIbVSGu0/J5CMkc6MF9gyhjwg5oSMRGMSWW?=
 =?us-ascii?Q?AuL/erCFDGFxhmGKC4Sq+DlVs8QIm9UFd+cEpc4Aas6YMIM06R/dHhR+Gi2p?=
 =?us-ascii?Q?ANR1tV6Jitb/bhK19c2EpO8KRqlfzYurNcMXQz3FkcqI7MxQX6fl4folD+rZ?=
 =?us-ascii?Q?Y8BuM3juopplCY/FwfftkVb9yWE1H0S+mDH9GkDkkzPqCg5bD7fSt2w2Q0gu?=
 =?us-ascii?Q?+QCEcneC+I3lACbqPV28K8dqdsUZSn61VlKvZpBMjt6yiTqFJOjXpkyG00mr?=
 =?us-ascii?Q?mz38XNPcetxi3S2M4/fCJjOQ4IxLLEnk5j7NQ0uIrCAxvnyo9gj1+DnKCWaX?=
 =?us-ascii?Q?fEHv//gLhuZAfz0VUOqiZTa0L0slidTFl1IG3XOcOK3Mq7s4w9UgXAT4ygaa?=
 =?us-ascii?Q?zXan+TPLu4pUe+8X5tCUcKFr/cr3P6LBaaBk3xmqPKvTXWSLWiYo5F2q0jRe?=
 =?us-ascii?Q?LeCONxQ0VYur3aCnfzNlrhO4rqnCtvnmd24xAMm7gZtO84XtvHDThaNuojar?=
 =?us-ascii?Q?V10pip/eOGZCurq3YU21QXDca32OLtSxZ1nMhTJ3nlWLy4CTpXh5HlOk49Ld?=
 =?us-ascii?Q?KMui3bcXRfMkcztyvua19Eu8SEFeLZms909cUkrUUJ57QTeSvM2ogk/9crDZ?=
 =?us-ascii?Q?7h6bJ1N9BI2oOF+pRE=3D?=
X-Microsoft-Antispam-Message-Info: DUefXxpLQqak5jaQszl3BYraJNc2XUroHUOIVs+LMyFoLjy1oFHzXwN1oH0hBoWt8XB6wtXysBCWsjiFXj30u+LOJ1knYs1aMK1/At11V5qDHCmk3lA4eFxpTNMRCYeeFbLZXXAzpY8MtFCsB4dqKiteYVBwpmjU/o9lF/1JwX1/oDdLx04Qh99YPyOzdC+7IEycsOLuuNB8khP3vB+CJU8PqN6DSNJYi4HrHZKDxdUc15XjhJKGc9IhnpZuvIyOO1LeS2x9q0fPQb8mMCZwhibHKPXTwM+s4UDX9H454kjp4twVB4oeBCRTrW9b4Z+4uwp6VrI9SyTweXbCdoU/yqgp/BsqjdW5LMhdLOjCm6g=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:7OyyRT83Iu3x6bpBvll1gY3oRaQ1X0wv+zascJqIg/pqMMxzydhzIyIfkZD2UQYpHZVk2arDtg0B8WYvseUS5U3YMKAPbATyLgoard9vdsZzTYXl4gfNs6KzTFh100jEbEkk0EMe0PY7hVCwNKRq7okQN+bgNhGabJDFiBIkQsT4lqB41n+hh2NCMrEptfuvToIkugk0AQMNQlNMXoVqdIKni02pO1jSXbvKSkV1PnX0gr9vVoGaI/+s47pi+3gSZlFEMvZBK48H66omy8+XUU28ALqNtCEwx5aD8cxEBerk94zEPe00vzZu1OwQYaFIrUu5IiUl8rG1Ifnijx4At2YJ8JW8T1HZQrktY5KTVJ0AGOf0f9t6t9N9WPT0KBSW9Cv0QCIMYOtJv6KYcPdeY1+fySyhzEpFpmh68BAeyYGFuFrB1Sb6bOe3jZAgGfD1wmhUeNSYzYe5Rog1p5C6nw==;5:4sVG8q+v326wG2aGocYjtH4OZgAnQtimPsrw9NMWvwH+BHTYTK4Mo1OZyjp0VNESE4ye3L33+orvUAyu+vf9zuykbVg5C5sxNzcU3jB9OobSgkRH1zh/PfWH/hdIa+QQMc0zXep6aA7HtAjVQj0emn9Vu/QrSwnU2SFBZdG+VtI=;7:3qoNz9+vNJiWHwnrFayHteRB4F56H9I8Pla+n8VXYOHgaa8b8DGONYZkzuazNrlT3MSDTGqNRe8MhrSlgeCjwn/AKPl47wTIL4pNs2Y+kxYvtFQZOy/UkshYhFMBY1aShFZaS1AbQrd1pHaVkndEiU7Jf1XA3TSy8ZQ3AFKtgDq/+gxYYJJj9NyBfOs++o+D9X8zE4YN4j+5oByrRjJKcySc79toK9Q4NmRRtnZagimZdq24v70FSHR5HzAbIwkE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a46a6-19f8-4c6a-6e24-08d618e76c6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
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
 drivers/firmware/xilinx/zynqmp-debug.c | 222 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  24 ++++
 drivers/firmware/xilinx/zynqmp.c       |   5 +
 5 files changed, 259 insertions(+)
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
index 0000000..d65cfd2
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,222 @@
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
+struct dentry *firmware_debugfs_root;
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
+	/* Initialize debugfs interface */
+	firmware_debugfs_root = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, firmware_debugfs_root, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
+
+/**
+ * zynqmp_pm_api_debugfs_exit - Remove debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_exit(void)
+{
+	debugfs_remove_recursive(firmware_debugfs_root);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..9929f8b
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,24 @@
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
+void zynqmp_pm_api_debugfs_exit(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+static inline void zynqmp_pm_api_debugfs_exit(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 697f4fa..84b3fd2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -493,11 +494,15 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Trustzone version v%d.%d\n", __func__,
 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
 
+	zynqmp_pm_api_debugfs_init();
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
+	zynqmp_pm_api_debugfs_exit();
+
 	return 0;
 }
 
-- 
2.7.4

