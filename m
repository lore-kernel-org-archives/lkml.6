Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4506FC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC962086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5NC44j2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC962086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIHTta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:30 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:32256
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeIHTta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O1pAwwtY+ViNBJ5rrNdOEbwp7dfAZ3afMgsGOUvz5c=;
 b=5NC44j2QORbuC2QxYHdUyqKhenx6/sy0WBe3+T5mAGiwxJ3iRuaVIC9WP+W1b7rps0Pm2M74/BECXL2a9cCe8eNYgKIP6SQ5V90qP+j9j3ghQz2UCGEPYfMS2sEuaO6q28B1iN/hHciwlKFitmY6P88pr5ge4uqpqCWJKqpD0Kc=
Received: from BYAPR02CA0061.namprd02.prod.outlook.com (2603:10b6:a03:54::38)
 by BY2PR02MB506.namprd02.prod.outlook.com (2a01:111:e400:2c39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BYAPR02CA0061.outlook.office365.com
 (2603:10b6:a03:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyeld-0002ck-2F; Sat, 08 Sep 2018 08:03:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-Uy; Sat, 08 Sep 2018 08:03:16 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F39h7027675;
        Sat, 8 Sep 2018 08:03:09 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelQ-0004od-VD; Sat, 08 Sep 2018 08:03:09 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 0C97D604FD; Sat,  8 Sep 2018 20:33:08 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 6/8] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Sat, 8 Sep 2018 20:33:04 +0530
Message-ID: <1536418986-16609-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(376002)(2980300002)(438002)(199004)(189003)(107886003)(446003)(90966002)(14444005)(8676002)(47776003)(39060400002)(63266004)(6266002)(76176011)(51416003)(426003)(2906002)(486006)(106466001)(126002)(11346002)(2616005)(36756003)(36386004)(476003)(52956003)(305945005)(5660300001)(356003)(103686004)(50466002)(336012)(48376002)(6666003)(106002)(8936002)(81166006)(50226002)(81156014)(26005)(4326008)(54906003)(16586007)(186003)(110136005)(42186006)(316002)(478600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB506;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:9GUnu3Luz5feVH2SqI7sECC7p/4QFlu0sUSnel0/hlgnP1rxoS6gEoA/SZaxFfwzNUbvcs4AcAqWtfERv1rbU12cqY4+vQgJpgH8wVvjEwcORAjKlAlCyVU24B/wKGRd
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c60efa0-a862-4a43-9074-08d6159c37ef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB506;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB506;3:PiARWVues8FBRTpSo0EpKhboXEUt8bH7RSyHXyXTUqKHs60gAY3EuWt132jakQr/SD8EOFuyx6YVV/SPH0vsOnxpU78D0hjx/mFhgelmtxCd6jsbSKmvNjzg7gbLMmtrzeBi1rVOElE9rGlUKStI/U9NyPdF5Gs0kKpBw/ZevnKN+CUS3wFGgOquzgU2xvN5G0ci3w9baGGuy97oe/UaCSaDOwuoe95/MbFkLckLG26VAzaA6gqIqB0EI318GAwzz+yT6AjUloEeonDTApiBzPGnhlgDsJQ+4Fjee2OJ4xsFGgT5vyvF41dg8Q9hx539ujIzWR2HEJTlP/06F2lR9/qPFn+5tqGbqHkaSfRA1LE=;25:h0ee0WQ7NGQVSy/LZ6zd+hHSxKqclFEotDJaKA2wEFsc6OEagXctA3r9/vAWhq9ZZMPjuT8OQkEi09Yksg/JTIUgXSecybfxQ1rc+4Je88dpASvH9F/zTbhZBHz5xPOIy+QzzbOp490VhGM2KsS0eOiWsdUEjCEch6JR6rKlgJEwQ40dqW3uQPsUWXKdCMkNgtsCldsKcLUrU7joJwSc7ToG89tE1fRWZRdtt6ESe/u7rtRDm/ijVpRYVmCAJvZ0Z/7VYpfT12+MtirU2YHKNVv+3r1bLAoszBKCEELSs+zs+zyz6rg9DFQ+hMCr9FlUnnEn+43J5RM4dDPUEB7uFA==
X-MS-TrafficTypeDiagnostic: BY2PR02MB506:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB506;31:+oXE7FfOKfzyOnTPBhUkcC5TFrmoG+2VTidTHdYp/csz7EnAylW4JgtYXBb2JGHBFEn9vHES8uzXxm2HwDi8DdqgGnsELswHGHKas153GjL4tk1ODkg73I1/ZcyncTbwKoy+VJ+kOVSxjKio3MfbX22ne90AVsRuxBaQHTvnIOX8gFlVxwupgE2HvS0Zh47ovruYVOZA6D9ZUbRa9pOI4Ml+mvLq64XFFxeSzoRjLAc=;20:Bd6x9iWxjKV7juM3J455PtkBU1e6ArZeWWKLFZpOWZwQtYAvIG+MvqsS842aivLZM6B6I6zpCqP8J+wlozP26OMKZhMl7hvn10u8wD2jE4M/vi50LNThMPImzzxahBO4g5RiQ0+GMUQhllq/4ob5Iljc+EPZIuiLGuAaJNOCih2tyJtqw1sTlRgUJTKRimalhAb0JiJIRu0HoIPRJe1KK6411W2nZAjJFKAqKs7i7hBN1I2+QqG1Vs1Fkj5RTZBkgH4+pKTq/BNtuJVQtpEfX8ZbaScsywEPneOB7qRwXYNz7lFLUQpLVuGZ53xidImR4no93eGOWFM//PB1SgKyb+fWkp2KPxmWXHtVgMMJT85bdpcvMNkn4CEwtdCS3XCtgi3bHBb4OHr9bW2r7CSfB1cvIex/7NREktgJxD0oLyvwOhmZvFPkfqCTFU79JQnC58PxuLczvZa/JZYG86hBNdg9KKCeBPy2Q++e+4q2RLO+VxJgzuEk19fDwZk6Tb2Q
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB5068AF14C80B9DB55EA54C4A7070@BY2PR02MB506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BY2PR02MB506;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB506;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB506;4:5cXIxT0PHNFJSSxCKqYpSaf3/a3MHKtQKn7PHbW7RLOxM20UTH5tbHg5egQ48UfyBe6dws6sOOaz1RG3T8qZ99FqQw1fp59SVT+hCunhDmNYcS7aN39qZLlDnEMPlNfLK5mjEiL5oPb4GuzqLThZ/7DWCAxULiUWhHOfu/L7JZc9w+J6P/z1q5Pt3BXanjI83KUdhO7TNQEWC8kiX7bIhwAQjL75+sqIhOaigk9SpGXKFu6G4D3Lrm6OWr8x2ICx4v4+V0Xibd7yz5obzs/8g+i2zaVZV0xbNbR4gum51QWPHKiurOiXzaY5KiuYMH21
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB506;23:E4LMQEUm082IhIjeb3mGBPXCYRdGkmEnk9noBU5jBN?=
 =?us-ascii?Q?XYQTO5HqkMgf92jCBlRzYgJMUTr1qALaLC4hwfLYYYU1AhO9pUnqFXAlRaJq?=
 =?us-ascii?Q?qMHDPsJfb0jKWa9pwDZy9DJYwstc0nvNdU5dsJGwK8hfX9z3dhq2r3SC4g2F?=
 =?us-ascii?Q?4Tm0tMqQLevPFL2fCdSly0sKbZu8VkWP0vpZf4HE0E7p9paqoPhy4WfpHEa5?=
 =?us-ascii?Q?8V3g19PXlqAa0r/O1MVXZTrnjR0Yh2Iuyr9Qyps++b9qszJoIkPTDo3jwFuy?=
 =?us-ascii?Q?UpL+YW4+F9u26LECq/g/ZfgS9epZ0D90aThi5V2J8xGBGblp4qpjZzrmPHzJ?=
 =?us-ascii?Q?i1cPij7MMaf68x+I/K/FfpVh9PvVsjGCrQVdU89Nky97zQGyeal/2rpR1rjK?=
 =?us-ascii?Q?drqCtuxddxIJD4DPgjTVXwxElvvrsbQJ4UndEOzqOAeMPieSMzg/EduQPqxL?=
 =?us-ascii?Q?9yp1gW5zf1MyXm1ouf0RPqKd+Gt6oc8eNE2pKxeuIXCgiQW++bIh3wgo6yaP?=
 =?us-ascii?Q?bPJhuxbtNTqK8EoYXc1rTkny4hqq6BQVkpnxzH2KHIa4t1cT7hkLrxk2Eyr9?=
 =?us-ascii?Q?Ahog/MUnTsgpqKKxRuQ51y1Zh0OMQO6Rdije78vHbdVC+/WvKq8PzEnueNtF?=
 =?us-ascii?Q?u3LDMU3Eu2V8ePXIt6L4t78quvZoh3iW8Yz3cUYYcFz/o4vc3LhJooynIGor?=
 =?us-ascii?Q?6hkiLwl0DuZ9QsyomEWyEAyQH8VRYwMF5iLLTfRRCU7FZuRIzTcs1grj65q/?=
 =?us-ascii?Q?/mDJRB3b2HToEd4TwcR2hv/uPvJrxZbISUuIJp6TMBOosN/dLpWJdW++Q8B+?=
 =?us-ascii?Q?9Hnrb3X9TCUP5lSuPFNJq6ScvmiBKZNFnyiRYnvIqbDenk7xPNEdl3bc6Py1?=
 =?us-ascii?Q?kAoInDJa89XzyGTxzOxVASjmwO9wbADvkjCrl5BD1ZM8cyvhAIsDaXVoyjOu?=
 =?us-ascii?Q?0bw+mHv/mtPVz051zT4FefDAiLkHa+am6Er/psKZYzRl3LFB+5Yq8ld8ZSBB?=
 =?us-ascii?Q?m8t1VSALW7zAUR2M0LSAiY1EkivVHHzXTSTuDPAPoqNPizBYDf8Mewk06RRH?=
 =?us-ascii?Q?68k69HAYahuLyZvb1/1ejAB3vloaPRFIMfj8uZEkvcn+jtwv5zLjlNLUm9di?=
 =?us-ascii?Q?1V5dbDVFFNUsV7bDzlykoJChGgeDiQ2OAUQ7MBOTPArItnQTPpHU9Vi0Ph2J?=
 =?us-ascii?Q?Yk3ogmRHcDZNJRnhMmBjlFyrBd5LB5paA1?=
X-Microsoft-Antispam-Message-Info: mITj1hOFzStYuTvRF5HQeCXgQoCYw+DHeG+3nEnvk4AjIMlwjl00GtO+VeGltWdGE6rFT7+cj11lSauuFiMkRDJXwc/Wp8Vdbwts6SsIubSGRxBoRykOyQOFVMxzHaCONUpkq5x/ZfAi8s0uXZvk/NHow+JeQ0wE3X8JxiHdjwQwejQF8/ekVHhsyuu4CrqMTyT33gYk404H4zG1ntSJ7vj7AKOePFyNfdGqcn90SG1Ah8YA9o2Y729QX7DpDoWNIKiqgxXJ6Oq1nlhQOz8lFGwNbcS0uJ4AxqlAnDM0frJkzc326wws5hxfbFOc5Rfin3+E1Cn+CaVXPAiMyWxd5tuTo10ybgN8pKH4fdEtmEg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB506;6:Ulag/Y2yarFZ7i/058OlfLP77ZhVBsIYELbivSUwvjyw4WGf15GftlPBQPqxIdjMrXyjmxoTbIlQU8BlTjQOQXBSsEdH+i17CFa3qbLD8kZrrl3Ha9JST9Qd/ujjFdLykg+xJ9UsmGAlQ5fJVNIMk8H6M0o1Jb91ITDmnXXRgfPKbRLraG8a4RfohdcRaK5pU8Pg3TQ2dzsReV88+ZVJ1pFpmIPgoKv47IZo/SX/koRDKuC+31lwu0lgeexdMvZ9wQBDnRWt52Rg+ZiM5+ZuNBk9BdTT4An4nRJv5MPp1kFak1+UR9rhV8/OLTRKyU5aDfR32GCUPbd1+QRylfqkZj6/YFYGsjf26tT3/nVtTdG24gx2ZBL+DEnCs0Es+32nOkS0nY5KnBlzVH9Ia1NfIuApA3ZdNhoap3JNN3ldvp0p/GUM70LA976XLegNctoCo+JU+SqT61kKdwYkU+BZyg==;5:QO9KIoGpTGbeKudSwBWkTnN690YOMJxzXqVSmLYefjavHaXtF8vrG8+hN6z3AdawKP5ixzQ/dcVTQp2ef55Ac4F0cngsgHZkat2POH9Bl0grEkryB1rEJyv9tCVwez022YinimKsa6cEZ284NMRNELI2VXjeGKoVBfUg+7fUcIo=;7:sSSzZkwOwXoAgdQAyCRkaT32IpqpQ5jKlH22tKlpTeHlJL/C9UTM0Mkfw6pcx25GRRfeQhlMOrPdjpn2oGs1q57rJSZiZ/m2x+GFnpscHyUErjNenUr+07zwIkbtHXePRCJvAfnxT4JNQJtkEZg3iv9MF8tP0pR9vvtOEWQpKiTHYFNvtzWvOqPL2sTFHZK3OpZmyYS7z1wn0OkURVnpS3+uaT8+uV34Gh8rRzfg4g4fWbVUG3xsxWfLAGMWrzXY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c60efa0-a862-4a43-9074-08d6159c37ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 97bfdf0..c50cad8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2433,6 +2433,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

