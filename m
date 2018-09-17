Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE9D2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gjC3fNak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE9D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeIQTxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:15 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:52320
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbeIQTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbR3fLzO92FLbnn0FpatGAZw4MgV1t8PyiVaoNMXrYk=;
 b=gjC3fNakS5IsPy26B/fuR6xUa5AgVwhR+zu7Qrl0d5EOouzh546CeCMV/5RFFHNmueiGMaFdaS8foWU+LdtcDS3CHbcRs6Q0aWl2xO0HGeYqI4ryKkgqHs11T/qbrHhaCfa39HW1FB0U/T8eL/ww+mjPtL6rlIqlIoC9pDKniks=
Received: from MWHPR0201CA0087.namprd02.prod.outlook.com
 (2603:10b6:301:75::28) by BYAPR02MB5111.namprd02.prod.outlook.com
 (2603:10b6:a03:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 14:25:31 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR0201CA0087.outlook.office365.com
 (2603:10b6:301:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uSv-00056H-ME; Mon, 17 Sep 2018 07:25:29 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uSq-0005LT-Ii; Mon, 17 Sep 2018 07:25:24 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPL4t007854;
        Mon, 17 Sep 2018 07:25:21 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSm-0005LA-Um; Mon, 17 Sep 2018 07:25:21 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 27313121463; Mon, 17 Sep 2018 19:55:20 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming convention
Date:   Mon, 17 Sep 2018 19:54:59 +0530
Message-ID: <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(42186006)(36756003)(6666003)(63266004)(54906003)(110136005)(16586007)(106002)(51416003)(76176011)(305945005)(48376002)(50466002)(47776003)(5024004)(14444005)(316002)(4326008)(356003)(5660300001)(2616005)(106466001)(8676002)(336012)(426003)(50226002)(2906002)(26005)(6266002)(2201001)(11346002)(7416002)(44832011)(126002)(446003)(90966002)(8936002)(186003)(52956003)(486006)(36386004)(72206003)(81156014)(81166006)(103686004)(476003)(478600001)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5111;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:QvuF1UGbIzA4t9DhQ2iG6Po0hdGALJXGTuFHjf6Hb81aA4/vPDxvOHST1wAC2nQDhTfKio22dkx5tkRGpEPoV9MTkpxbU0nF8F9nprt0LNBn3KV+io+XAWbhUIB/2PYy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4154e4f8-1a08-47a0-4674-08d61ca96c12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;3:r+odYkzdPC3xmSY0W+AAJmOQHJXgXPGrADqR1OHaFdBO2gGJiyPmpq1PcTw1eOoS+VWKDE3J9xgBqpl5Igeg0VZrAHv+jCuDIuSfdka9Tdw3rdn4W+Ingn5+4HhLaUR6awZ977OFgzwAjf7PP1O3bSMQzqv8+SvVYjND05Yug4ZMH8tyxt9iVDWp+rYW57k5WI2mUVsEMB0sCCMdsgq5M7joQq2YxWrwvl1XfuwEvn9jchwzHhFDIq+1b59ucmVl80fLZpG3MRjVDbfAzU6OQgyQRmeTRuNLa/3vohZWb2WRzFMolzTBlL8QRYQbflpakd2aBpVdKh+0LKqalfiDEEN7vaeAGaJRCIO0fq8fr6c=;25:cVN4nbLoNwruXsq1zlExjsK2gAZhHwg4WhqEQDpJ3qKp0br6gInW4yjiNQynBy5By7eY/JgZfXBDrlwXR56jSQgFEvSP1x09p4GouE4YCN68xZwxc7h0/LuHEELg5YvFDmkahjaTWqz7PcbeD1pkDvesv87bMDhlrD2f1JnunyL0aDYnJufPq5h6rjwcYu+Dx0I3BDczSFi3oVnepqhtPjl1SNdMnpD2/zxlYIM1z7vulUhhnB9i8mxXbf69bpAJaFOiqB2sdbsI9LX2iPmOdd/FgnFtOEAD1iqrh4vPag3D0t0EH65kLIPeg2+un4/EnsIb3Z8L4gp6v7+PJbt4kA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5111:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;31:hOXFeK+u+iMbRExx7NsHc4go9gugQbUQiathRvD25BeVILJNOC/UGrRi59BdTaKQaT9BLAX8cpcgMHWKZscxQp/CDmKqPBePdwiitf/vs/rBPOBfFbkSK0i4k58l1YghvQkXxhP2QpyJKJr4r64sgjRzGBthzUBzOYs7tl7er6IsNgI59UOIcXwbXv+1KAQgD7nXbsD0Be3iPAS9AI7IW458GsYHt+tsORFxn0WvJQk=;20:S7rZf0lvIUtu6TW0wYV7Z59u7wXvgrdb+AbCqC6UID5iwdiEj7Z3M4MvJJRd2j3+aZm0bH6ykVYRSkEjVI6yacxXBKcwM//AOASQvGc8bYs/L6oCLQW1MIslVYe1qENDkBJRHDBBZFt77zjOhMLKpGuW2xlz4RuLqC9VqB6s5q47TA5aUfFyUckeSLlPANMTSgUx9CfgXP7w10vm7Ephp17vFXuO+FvPGfT9RI0HoBbln54jLtID84I93Ex9hOiKYY11EpftrEROxCM2nk2zKq6wgXdEBC8TYrR5zN5rpl+DjWzUi/JaJlaHJvUB5J760En6ymL79emHRJ7EbTM1Wv8ngR2xCoZp8MqwDYN/7cuf1L0SM8Jt1AwM2ZtrU35dxjgcuMpm2JGStS/PMlxelr9CC/lt3rb9+TlCfcJT+KD52+eGXG6TkrwTJ+F8yfGng2zEir9kC7c9yX8wEi8PVECrGQibWj/R+brJjwfjJePZUiezMEXE7zjtZ35vLQ9/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5111841F7C070E304AB8C4E0C11E0@BYAPR02MB5111.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB5111;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;4:vOB+UQZ4Bn0InbdKWVHYwk3E7U7XaHwXyQRrrpF+8esa9niWmgd4LykbkAwA+R/5DQWyhWLk/yykSD43WLExKg40lxygHqMznMCaQQzTaXsnSIX+GrFp1K9Z7cg0wv9M/cPB7sOdsmTe6YH/oEpfPUmGCTApVUrjFU/bABn1FXsi+LaTgROXuJ3uKlMS7SfstEyKPPPGKyZ7m/5KzyqRx+hL5/nEBTylgO7YU2wvIQu/4vdlK2cNtRI3mCE++EIe+H6pBWmOUdlWVBu5tYijDYNpg91hYQEDF2yMV0FWA/zh4+XjnJHXGK1xJ67PXoSRFuhORaTKWkTqpyhaEt2DU3UFhefaWOnDJBfqo9utck8P6JKHxMIj/3imDvBLljJT
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5111;23:wd7VU5Xbj/1nd8ZCFNmvco/XV0jC2dHmyepR/2Rhf?=
 =?us-ascii?Q?8eakfQETwHxoKX/KLozVVHpGDx6D5LEScro1w/TdtHx1RFrGZqT/GP5DCRdF?=
 =?us-ascii?Q?4no7jynObotx+JQg4NjilSccRN6jvpVDZcWLMnkCpVsrvkAmK8Lz5qhBe+Y+?=
 =?us-ascii?Q?r1heLfiVvRZSHzgU2d0hrboi3QAocSM1wUeH1duCb0hxhA7ZVGgfQopBoo/p?=
 =?us-ascii?Q?mzlHMlyTHgJmpGQoN1Fl0vFvBfamTyBj7vJpdH8PJI7M6vlRieNX9xLvsL6l?=
 =?us-ascii?Q?V3yooHf/594YqaCS0ZcHinZbQy0oUqSpH/pBWGD11I0eRfgYXILlnMjdh6Rx?=
 =?us-ascii?Q?KAKbJsN6A4nsjZ9oQ7YTd+N0Sg5WEA2kM0qX+5z80gmRcffEPugW/DbYTDi6?=
 =?us-ascii?Q?/x5UnrfHCIOeJUJzasMvJpQarHJMGQrpjuT9EPMXfPK5m6LqRLw7EjzEfGXy?=
 =?us-ascii?Q?Xy/etV4zwrwaJIbWEigC5dnp2kZASt9WoVOSjGcnU4iFqFwOCHHKQajkQr8d?=
 =?us-ascii?Q?8iZfMNKtKV9WB6cPVZLCIBoPF0YMr2la/xh29A2mQODA94NWnagfhWMcP6eX?=
 =?us-ascii?Q?F7GBS2e3eTyAYJwdCe4p307TbTb5U1XZtvyrHdhZhbEtvhMalgGsyB6a7tul?=
 =?us-ascii?Q?mdnUvCdMwhRn0RqLmhI5obfWpS+GWpk6NpouIZXwc5dO4BZHz3by2Tjspuhz?=
 =?us-ascii?Q?zA6IIlkjbwdO88Egr1r+JAZlcfIja4YrzlX5owoCydzsdCQrSMNqRBGxiAw2?=
 =?us-ascii?Q?KIw5CujzE75izr1gyPSJyBbl/bN1qQcCuFr0ofKU4GdOqjaL/rr/w+2I36gn?=
 =?us-ascii?Q?A1NhYiHrpKc8b/wIIicV6l/oGN5fcT9ONohpKO//TKhyiCsqzeu8SGI8KMjd?=
 =?us-ascii?Q?btqmp9ssqp3DC8cfkUhn3vGyHWC7glXs83BQRFLKqTJkRupfl1fKBg5JsBXk?=
 =?us-ascii?Q?uKbiGUtsL6/7wtycDJKT/HfWcIUcQb/1pcXqS5y4tgiJiNGEKCQzm0dl4sYc?=
 =?us-ascii?Q?r9E4UXEo5X8hi8RtBJzat+R4cHRu5Zj5VqyaRen35jL9rqUx8zafB+ehHZDM?=
 =?us-ascii?Q?5MbOLDfTKd6g8W59dHcUe8KGdvrPAfD4I+JpgHN/drQ9tl9CdyFSlOjeju2k?=
 =?us-ascii?Q?uT6HmN6I6U3sBvkA2Lzv5FKmuz3QdCz0E+wLcNO8yFgmaeTwPCO3USL7uwvf?=
 =?us-ascii?Q?gFBdkb0wnL5zF5/3y+fMYEJtpnGh8fHoAgdy7cLz4E3I545vAhBo88YX/vgW?=
 =?us-ascii?Q?r6M+N1mT1oFyv5m6aQFmk0H7Pwp6a7hAE5J/3bW?=
X-Microsoft-Antispam-Message-Info: P9JZlGKzamEP3QPCanzU4QV137/UIqqjOG7o+XealsIuVbQL5RzS05TYlgSGzUSvX8D8m+1233JM5JTyazRaNj1gLqLVqrIA+JeZgEWQoDxT2+rethwvOwWKiw6mia5ylkUU4lVhX338OS5WVjfievt/S7km46uy/iR7luOGVjhTtPqtE/Hx/SJ260I6rmDo4Anf8e8y9SdsWeciguc067sUaRhkkOI8Ld/R9lFjLxAfNyOqbQu3Q09K+o4sPUOQEw2oRvf3CkIfRzaDV/uYr99HoDq1livysXo8h+VbfcBBl5wAN4PVAmXvAMkrEotyyJCTF+7jOtIc8R9vRfuLGYfAgPf7Vi+6M5QIYlzOuyY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;6:ykpCzN5vhObthAtq8xOgT+idJw66VDvEvRQtEqpfn0qfBSPTOb5ZH9AQSLJ8k9Nw8vN/oVQBbCAT5oHEseKogoGhNSmiW4W7+r1yMXfG0a51G6GjVtc92toEAqIRms1yHX0mIYRi1Lht7dw/cQXlkTgBB4aziqnoP9W1qSMd0258POCNEiMTTJ+BYrPnwuebj1EGehGxhj2LudMYU3yiBfaqOul2Zz+0xyOB8LE7XTaQnh9kM2utkQ9OGf5798qsTqgnIP3e0NTtPWOVinc/MXFKg/2WYMYkzOyVXhJS3Z7q5qok5OH3zPdoaSwXe3+3teAU3MJz8HH5yT6AruBLzbwWcJs/IZcIKkUNb8TJxW3+5bTzdoX/EncNXjOZkjFuHcRwZHlA2aF4X3tRAOrBZK33oz3m7eewanBgPonieQvPNj4VhWgdzZ8wXRH5e2/6P86zrD/BuzhLIGQCnFzauw==;5:BcZ2Lhf0rAPjCBGjJ1x7JTBHRSFInnnPlPNeK+C8tYURMs39OKdRtU2T55CSVamr7uJ/SexCmB4N3zE/znfkrH4FIY5DEprgr7sZ6a1NxM/W3K1jqHmEqlL91z4lB0Q5Nd2XJB9RjZOfa2FB/cIUssE/789b9VcHzVhQZP4JQLQ=;7:64e8GrTozTHTBRJFioK8uYW+wKfgSvNsKhm5h7MhChAGtcvIi3xn+47FRVIrVJSpwufUhGUCJUCqHCzr6Fs6Fg7yPR/abzqCkHKdaJNpjTt6KQAdkr3/kBnfmYSiTE5Rzf7VAyi0OD2LuC83gTolHaiI+HySjwR3papfYVOU+8Sb+cNJMGpKhEoPoVQt1nl8/wOWxnEetQHRz/whX9uzIIU5pfiMV62XYCbGPaLMB+Mue+3F38+FcRK4Fse6Ezjk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:30.2535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4154e4f8-1a08-47a0-4674-08d61ca96c12
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comments in the Synopsys EDAC driver. Minor changes to function
names and return types are also included.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 176 ++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 96 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..4963930 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED	0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,15 +142,13 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_geterror_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise returns zero.
  */
-static int synps_edac_geterror_info(void __iomem *base,
+static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
@@ -172,7 +170,7 @@ static int synps_edac_geterror_info(void __iomem *base,
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -196,13 +194,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_handle_error - Handle controller error types CE and UE.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
+static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -232,38 +230,38 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * edac_check - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. Called by the polling thread.
  */
-static void synps_edac_check(struct mem_ctl_info *mci)
+static void edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = edac_geterror_info(priv->baseaddr, &priv->stat);
 	if (status)
 		return;
 
 	priv->ce_cnt += priv->stat.ce_cnt;
 	priv->ue_cnt += priv->stat.ue_cnt;
-	synps_edac_handle_error(mci, &priv->stat);
+	edac_handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count ce %d ue %d\n",
+	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type edac_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +284,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool edac_get_eccstate(void __iomem *base)
 {
+	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
-	dt = synps_edac_get_dtype(base);
+	dt = edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +309,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
-static u32 synps_edac_get_memsize(void)
+static u32 edac_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,15 +323,15 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * edac_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type edac_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,54 +347,47 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * edac_init_csrows - Initialize the cs row data.
+ * @mci:	EDAC memory controller instance.
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
- *
- * Return: Unconditionally 0.
+ * controller instance.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static void edac_init_csrows(struct mem_ctl_info *mci)
 {
+	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	struct synps_edac_priv *priv = mci->pvt_info;
-	u32 size;
-	int row, j;
+	u32 size, row;
+	int j;
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
-			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
-
-	return 0;
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * edac_mc_init - Initialize driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform_device struct.
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
- *
- * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
+static void edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
-	int status;
 	struct synps_edac_priv *priv;
 
 	mci->pdev = &pdev->dev;
@@ -415,17 +406,15 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
-
-	return status;
+	edac_init_csrows(mci);
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_probe - Check controller and bind driver.
+ * @pdev:	platform_device struct.
  *
  * Probes a specific controller instance for binding with the driver.
  *
@@ -434,19 +423,19 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
-	struct resource *res;
+	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
+	struct resource *res;
+	int rc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!edac_get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,12 +457,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed to initialize instance\n");
-		goto free_edac_mc;
-	}
+	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -496,8 +480,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform_device struct.
  *
  * Return: Unconditionally 0
  */
-- 
2.1.1

