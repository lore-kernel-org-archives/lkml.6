Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9504BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AB828068
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iVwvD97Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB828068
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965277AbeF2Pbj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:31:39 -0400
Received: from mail-eopbgr700055.outbound.protection.outlook.com ([40.107.70.55]:50144
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751899AbeF2Pbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar8hEruV4TgI5Xyc9PtT3hYmn6PpKXaE7+6lAeJmiT0=;
 b=iVwvD97Qky+hHgtpXpS8rEX8C/aban25+slJ02Y8gakz0Q/4pnl4RKVW0Zxpo6dBwPRlZMP8OZbJCIi0ef023xtGqRs5RFvuLMEd9dD3XACe3dHqjbWKbQ78LFSzq6MQzcIkN72vgBwTC+sYBx5hJZ0+bBxJcG+I8bSB2BnbUkE=
Received: from MWHPR02CA0028.namprd02.prod.outlook.com (2603:10b6:301:60::17)
 by CO1PR02MB175.namprd02.prod.outlook.com (2a01:111:e400:101e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.20; Fri, 29
 Jun 2018 15:31:29 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR02CA0028.outlook.office365.com
 (2603:10b6:301:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Fri, 29 Jun 2018 15:31:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Fri, 29 Jun 2018 15:31:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54518 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMt-0007T0-OR; Fri, 29 Jun 2018 08:31:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMo-0002SW-Lh; Fri, 29 Jun 2018 08:31:22 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fYvMg-0002Qz-8v; Fri, 29 Jun 2018 08:31:14 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH 1/2] net: macb: Free RX ring for all queues
Date:   Fri, 29 Jun 2018 21:01:08 +0530
Message-ID: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(438002)(189003)(199004)(16586007)(81166006)(305945005)(8676002)(81156014)(110136005)(316002)(48376002)(9786002)(54906003)(8936002)(426003)(36756003)(478600001)(106002)(47776003)(6666003)(77096007)(50466002)(26005)(186003)(336012)(2906002)(50226002)(39060400002)(2616005)(36386004)(4326008)(107886003)(476003)(106466001)(126002)(51416003)(63266004)(44832011)(7696005)(356003)(5660300001)(486006)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB175;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:hL8P2+w5trWfZ6R4HZirQCZrByj0UroxXLbR1pNvhrhaT2PRcf/aNKiYh7PNli5IUe7s9NKM71OOiv71Vx7df7t6lfFBLQ3pCZc3FsvYVVykeaEyze1m7UU/9dCH7Jjf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb9dbe1-c69a-4045-93be-08d5ddd56206
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB175;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;3:aOREuaKgl/Gi+j2o6n/AAViXOoqPQcJ3I6AadNRZ517X5kZ/81/VcHwHF73gFqVoovcxV+qBRsq+bRW4sTieBrV8SfD+tw+9j/EpJCuiAdNqzMmIxxb+yW/5XqHBiBZDZVbFKN4fYDhB4v7Nvw5alL7wrGVpsXlMFy07xChXAoIbyBysto0Tso/cl9/AR2NY7PMl2WR0S8ZL43P0aIyp5u2PpltX3wQHmwjLJNeVDlroKzoYcO73fnwkDlZOmGtyxM5gepopSWDT6zkVDnQSygSjUvmoTYW0RtXDKMPytCY78BZxluhg0ct1I9+BYCknMlbWh8Php7oadxw8abw0QwjPupZfYqy5BWnuhrk5Xd4=;25:Ak/f3lRegX8HASADiHUbL6mn4KYMvKFm0T7Uf1nTmkFKzwVwfbIYm1NMNzSx5vbMfG2/IjB/vzIzFR8PRhfGrfIlTQBl33mG2sXJvXx/E8AqK3I99/2uYC4gUJCLwrlyOsTso+csFLx+zZkqtoIF2fOhNiA5NpK6tV9cPnKEHVAEf9Wq5gAP86YhlirqqWnMb4CDqwKTx3naFrQ/hOafUk9bE9oPIqy6odEgmk9SIr8eoKhxOJR68AlUi6q3Fqj9zeUqPtXENUuqgMsB8tH57Mv0gCLRNT/72gNmJkp1gtzZZ1n87DPGBa4MIbMhoqht7Iv9Bt5DTn+YqtQC8DWivQ==
X-MS-TrafficTypeDiagnostic: CO1PR02MB175:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;31:uAioOQ05gppoOoe0P9uBA2KygD8MzIlH6/ROMS2Xs+RKAH5EinnbH1oPpEH+QzYSrqB43omv/HECs5PXU610ANH1Ze276eJfexL6Dj79exsoM5oeddejxEkuMkZ5sP9kAdLmZLWU/DZQ+rac7ESWdZ0RM5WbisLRWYSbeSxEm/F+DFdHkge0VrrgS0rFPMtJisDCBRpsW/QIek/sQx3/PXHuJC7m2rme4CaeRfzhEZs=;20:zyB4Ol8ATqSH07F+IZfSUHF0ZLa3DR3Ixo3kvzzqEybrvH6zz8dfuTC/eRRi4cEnTQqtntCQI6rKQ52mueehlePb6JdGAgwEi5wKOcgtY/r01u5tyUJ0OlOhhD0XjTVg7OABm9hv84AaGIviVqexoXvhJnVRyR3XajiVHRQ+KtRjuPjDFU+hYaqLOOK/G9klAPrcGY002Ghrny3Amj8QrEq3OM6Sn50g/gBCNBrWrthVrgVwPIel+DY5EZaLmiVe7GRpYKCrhfMP5fF2zQ1pfnV7eC4g8QdgqmfIrM1EdVyASNiLjb6kkZ4VrC9qL3do2ha/mbunS9FgDUaYtWonq623OyeO5OT1wsoq5sZzaWqQiy6bGbKrkoQkEolc5kpUW6JnOIp0r68I/mAt7DN+LQrfSXqazgrGjy6eugBd2ObpyR3cuXIqibo2G97hNTxfhzZ5RcWty7//dcWoOI192lvHlbWc0hx7VjSeg+vxfkZLMWnGSb0yPHYcIXT19DAm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB175442AF7FCCCA8E9FF960CC94E0@CO1PR02MB175.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB175;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB175;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;4:Og9v3qXBOg87BsZBhauJXzVKuN4gRJ41bEiFTP8f8B5ZBpRJpdgPmr5LqjDmYJkjmAePDtN8KbTPiVO+o24uj6AQVD+5WsSFFzzBrPzCu4t8jRIAG2YG/MDYMQ2M6wMGJbXn4EXWlXOoSuRYIRBa5ZY91fD3GgWHuFOu9r3RIiDY7GwBmAxJIwPsO8x7gvQbO3dwUzo6jGauw7ge3G6DGD5DVdCdGNfb/0tq4abA6nlWg7e/ZO1u9Pd9TfAF3WHGFHuxrEb8IoV76ePS/o7/Q1MPgwwvMPZICm8AhM7x9Ao8f11lmwgIfQ41qinNOIMO
X-Forefront-PRVS: 0718908305
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR02MB175;23:YUmQGHy2pik+KyvK17laq+5yu4y91juKjshS3nB6Bg?=
 =?us-ascii?Q?sySr5dSaHzjyHgEO5GbuqjA9dAE3pmRLw1dS0YMN3Dd9zRi1/V3oYPqaXFkn?=
 =?us-ascii?Q?h+9x1bsjfmXAd/GBC0ZVKtqKTj4EtP0cQECshnInOfI6CbAiMXKaofwPm326?=
 =?us-ascii?Q?+bX8etsdxUzspwzhKGjQOC1VQoShISi3gze7AR6N0QbKVP04HbzUkAXC5KXC?=
 =?us-ascii?Q?yKyca0RXjG/mtKBh2g+c5I2ALnz9n4jMAGF1X9HyBNlMAslEdMseOwQTCvPX?=
 =?us-ascii?Q?ldX6XjZP3k99VBOxgD28D98Ywh15RuN6TCnBuqbB+kSqxoINo3bAMLYulE/d?=
 =?us-ascii?Q?rUA3hfk8KbS3Y7Kl3jC2LVeznmRUlvh7HbyIr/1IST/7Aa0JXgvpAHakwtKi?=
 =?us-ascii?Q?I2TDgUdSJ+2PcLqqTf1/EY1o9FPfb95tnyT2hxYYz2tv2oMSekmFjO2y58E2?=
 =?us-ascii?Q?qDCzqZfHsfPVc4Y6nKx5K+obw85WZ7iy5lPRANwHKKwWqGpXEAdUgOIVr54I?=
 =?us-ascii?Q?on5Eb3orcIx8pOpHf7W836T9d97ifAlT6JNPcnl/gh00jIL+t/m0ex6+NMQY?=
 =?us-ascii?Q?Zq5W6YE3enHPxalZ+nYQpIouyUV2+PBRad/xY8ngCGp5HpfRrzMttkZgcC+B?=
 =?us-ascii?Q?abT33g4R35GZ3MwsK9Vyu0XU6WlJNW/Z9EK1pa8FF/weCRoee/vw2s4c70LT?=
 =?us-ascii?Q?ASFMLLC7FjGJ8T7ffypfUkbcPp222bPnumQlwRpp6EEmtq9SdepWqWfrBL5u?=
 =?us-ascii?Q?L2G7JWZYqzA/0pJoqsqLs11m7zemgeuI/NyS4MSP9avsJxGvDcIq05LH2IP3?=
 =?us-ascii?Q?//A7Kzpebxv+UUOcOmbjeaUxRkaJUrHNdEX0dHLvvNkCQM0vLwMo8nCuZPY3?=
 =?us-ascii?Q?gVsAzXt6740ZI/Foi4Fa19Q5FDdNEei7yaG9XBunEXtGp5xsdIR8l6Na6KXZ?=
 =?us-ascii?Q?3Qm69OTCeYclUBPiVEzArVugpIV5SMbvA7bw2wg4FkocPlcfA9Eafoc4HSQ0?=
 =?us-ascii?Q?lW4XaJr9ywmrC5WYwNTjF7RNhRYxuFsVftA1146NR5umopB+9oI/H2ebdkUj?=
 =?us-ascii?Q?W1TeEdvN/hBEvLVPvhGyoV3sumHvOjaYmmP0cHUmssATIlUyCCMRAPByzKl0?=
 =?us-ascii?Q?glph34VUdsoGkFWs+NL9WjppfXy6F0?=
X-Microsoft-Antispam-Message-Info: 604GxaBm+m0W/O+aiOXU3Q8Z2wiA1FH6b1414iOPW8bk5jeyUfMGBESSh0zDf/eUJPtE0eFizr20Y8lq0RPgAhn/VmtSLEXwOwZ9f9vi6D/fVXn+79o03zQoc5dmEq3CO89PSiqcjJEVgAO5Np1h6+A4MnuzTUdrM0qlY/S4j2DZZMarotrGlhbpW3IxPH0elRK/dQ78qBLzc55K8ny7GsF/rt7kA/o+G1owDJd6aMYFcRCKPh8YUYpYwx7wspSvxMNya05krXeJYfl9JydpUm7RHx7+DIT5KH1lXlVh0F5rFvpANXGJTgAw10rknV3a5mVWR08ypz551d3/bL3Xzn/3TpcA2A+v5KUfTy2kD3o=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;6:GuouXtsxD2mRgjmK26Nnen3GbqLhcElk3isqLdYv2Kso2jCQjl18c2MQ2S28UiN/6aQP+hBHg76oTwA6hUI83e7p61naaET97UL4/IS2p6zNQGyNGc4mrytUlv3rzY5GxD++UzTVBiWq58nPMc8VgrO/3/eHVyYFC/4Jk+g1K7nx5Q5uJAsJkDSK2yWVNCado2LhyfyD61h8wFPg03XXM+1u0tXgw8S5UBPggFeG+k11W8miGnIwwuk6F6GuCF/75X702ZPDuYRTP3uqzns2lS5sJOcSbOnS8OGBspjXB+aFOo35YrGgFuEYe3Msz32Sfij7Nf7apUwmhri7eAOhb4OQuOZqLr6k06UTQnjkyOvT33p0oKcfEt0X7b3ddd2uTBVuXg/4YeeyAwWqRoXlngRytTHnd9dVyvNDUH0s9quVd1F9wvFftOfb65Rz3D5Bl/DA4OmT9CM1H+VMYGPJPA==;5:sGL4aW0EWrICW91vHhn9spTM8Et+StuudGUBnjtqS5gcLRXHotorNXKEjHkpQInGY4kqsWp+Pe9t4q2Rj6wAU103c5+JXTwMAAqGb/sA6YEu9nGkGfsmkuCMLzKISKVh/Vp1/JVg49qT+dfA6jDsAHhK0anaIDlXNk6L6fEVQFU=;24:UiY6YyTARGwGSAaJRjV/u65eaC8YcWzLSEMm9g1nfjGiJpKBna9WQDuubR5O8Y1Cu3YXkTzwliHp5MZIZrHJDNnPa+ik8zdz+nXTLdm1zbc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB175;7:kFWPcLl4DNBDiA3brFZ+/YCrl2OLxigA92Ahtrl7meJ/PSI6VLx1plSGpvRdg5U5tiXBmmodccAGagsvGs9AQ2Q3P5rHhKf6Da6tIbKuTz08H2YZoBRE/5wv49HLp7eX9x8q0XZFeBsEBRmRa8E0m9US9XGJV8+nqx7jNm7kHI7YKwAjJGTXv5n0DbCMjAjGINsEvws17vPz/tBlf6UNHtrbBJVkeahu3rP52tTwIm/SpILxRwq/4KBzgVsRqFm+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 15:31:28.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb9dbe1-c69a-4045-93be-08d5ddd56206
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx ring is allocated for all queues in macb_alloc_consistent.
Free the same for all queues instead of just Q0.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3e93df5..e56ffa9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1812,13 +1812,7 @@ static void macb_free_consistent(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-	queue = &bp->queues[0];
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
-	if (queue->rx_ring) {
-		dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
-				queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
-	}
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
@@ -1828,6 +1822,11 @@ static void macb_free_consistent(struct macb *bp)
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
+		if (queue->rx_ring) {
+			dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
+					  queue->rx_ring, queue->rx_ring_dma);
+			queue->rx_ring = NULL;
+		}
 	}
 }
 
-- 
2.7.4

