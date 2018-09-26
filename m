Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D403C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC8321564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cwPFk6zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC8321564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeI0Aai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:30:38 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:48292
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeI0Aai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9njb4YOYYqTi7Crxw8dkfXdv9FqM5Px5cvbE50Q08kA=;
 b=cwPFk6zGGpar3YSGUxuFKzoADRdPk3hfsZrbC4Eh3dwjTNcPOoxyOchZnrKFsSGs2Np4IAHvp5+QGQXzz7RDrL7RtQXgELuojwNNDvTkxQqzMPM36nGsCelssScQy80mJoAAkY/cU5+vMsyc+IMPqdp2C6ECFwEGw4JiS9Ud7so=
Received: from MWHPR0201CA0105.namprd02.prod.outlook.com
 (2603:10b6:301:75::46) by SN6PR02MB4477.namprd02.prod.outlook.com
 (2603:10b6:805:af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Wed, 26 Sep
 2018 18:13:21 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0105.outlook.office365.com
 (2603:10b6:301:75::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Wed, 26 Sep 2018 18:13:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 18:13:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJM-0005K1-Ev; Wed, 26 Sep 2018 11:13:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJH-0001bP-Ad; Wed, 26 Sep 2018 11:13:15 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QIDDlB003391;
        Wed, 26 Sep 2018 11:13:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5EJF-0001aj-K6; Wed, 26 Sep 2018 11:13:13 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Wed, 26 Sep 2018 11:12:59 -0700
Message-ID: <1537985581-32164-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(217873002)(81156014)(6666003)(76176011)(8676002)(50466002)(107886003)(81166006)(50226002)(478600001)(72206003)(16586007)(2201001)(48376002)(7696005)(2906002)(4326008)(5660300001)(47776003)(486006)(63266004)(51416003)(8936002)(9786002)(106466001)(44832011)(36756003)(14444005)(186003)(36386004)(336012)(126002)(426003)(77096007)(110136005)(446003)(26005)(106002)(11346002)(2616005)(305945005)(316002)(356003)(54906003)(476003)(34290500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4477;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:kxLue8AbnWfjRWY1zX7hqj4kTlhLRBqrwHxJE6zre32NB7tTmdLD1WMvgkSwc5AFIPfBBPkgScV6tDvSPYkzmbIq24YtNSy+vheT27+rXf+/POxLJgopJhpDuX/1wuYl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ff5690-5b7c-4246-4cae-08d623dbbe15
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;3:Zq0HKO4RoaQPMRDDiykDmDYfjxLK/QoosD4I11buHHtQ81ZImQ0O5HwFWKUa7ADO9t9anGJfSRiYVhP4l/Lo942voWCXYs/FVhQD6ZS5GGHWsvewm2k+NTh2rDPN/ZYTaVb7zAHSSZeFUnKjzn25Itibx0qnNd+E5K99S0kJ3MGspbC/aTOVTu8s1OKyLHmFApQXP6iFV7fUNdXe0cWKF90QCDpx3XsXeO/OYl/6bYohBvAo5ZSOC7e7JZWiKxv2jwG55BnZlJxnXPvwelAmDPgCfCOCOopatyKhvozMvihIMYmObCxElyLgITSm7JkR9DGVOvGYUYoNmhluN8nbDkbQS9Ef7UtmChTjdeD1wX8=;25:IC7MP5+M2kgijCqxe9HRHsLvNr1JaeWauWx/nxwbNIeg3YTt1GC/CZ/RpRvJdIB2YMy14dUkmeIII9h/3YZmLYyVjqmlCQt44wl5lo6g9y+t4csjGIn+dLokiWxiAvcWcC6OTPlV/dFozKJB5Ew2X/lvOfhcMdu/chyOJfA5yXZpRk0q7aQxlMpQANsIC5SAzUrjbccVJz+qBePTo+ETsRdkq5HU7xRT3UlaF2nkPbZlpcDA9XG1KojVMr6PBXheHBE8RVT6CGj1mgvn6FNLoExN1kDQ3PPcdRozYcog+CjcyjnKnfeMD/QaLdDTuf8t1+9wRHuLtX/Be+sBKmZ5mQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4477:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;31:xDm3+utLXu0+ZwaTh4ESqwkfTxiyfIInHAEBPM7WQ+B9nDP0woKPELZkdYIwDqP3Vr+pwyMC4fmSuslDJ2tcBxvbYA737xxf4nT5N1i5EHZ2zm9jGL/lIGIH6DWvdvISEbK9R2AlpmroUTA0cu8oFZn69EGtixX2OsEqTCqtR+HlaUOCZc+eSQMVA68z1rlK5ROKw5Jkh27ApJ2dfeGbuOqTCn5asA6g059CVXbQ1wo=;20:DTq74LWr53fkzD3AQsN+sUCkpek6vN//M/qYCBJjLQQmOae4UVLkk/X+I1p+jbsRiScSpIKYnkE+5jPaY1/x8uosMzkSKosTdkYmzZugbLqTKtdHjdkeb1f0a40sgM19Ec2zD87gT+y62ZeEz7mBowowPfxiWm313MhKMEhlVHKBBBBDKFP+An8ZlrgWWbvtYOWc4apkq3A4YGs5JTBWgwfbqdKmOeBPf2zx/JAs41yd88FDah0LQKkw4VDbKEZcUO4FEqjy+lIglGoi0Pdmx4hoCOatH6Ul1OxWwQYq4Sp6MBdLVZ6qfOvmgirpldL7MDVDMV0Qc1P9mVzA/egf3/kC+IoC4yMlBjTRjnzEhqUXkLW9+BQjIlsbNVHo73M81ITSQr2BwEYGW5Uof+1wx6SkIH0egbMZAMLkHzjX7Lxa1Dcd2UC7e6BLSTFtxU7Xp3UAhjBoirvJDWLjscrx7E64zAeFNfyekOFkhyVksv1SSO8lazwcXVgC2M9OyY/u
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4477B7A5F69009734E02B099B8150@SN6PR02MB4477.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:SN6PR02MB4477;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;4:b3R/sKLNXSyqJjPkLp/CKvKRsT27cvVILc8EOB79m89uuW+asPf1s1xH/BI0RELiuQMwC+vbmxFhzlJkT1q1CX39rWsu7r+E2R15dseq/69ggCWfITC2OtIlFSFsJ9KIUXGjcTZaZrssj1t0chMgOqsBlQ2dafH9gnoE22+nDXkayM4VXcq4smGX/RwZSKNedprIKAZPUrjEzCQMKDfpPFrh+pP34w++lBreottfcInwG6VzsJHICv9zJTUDWnTd76GqqQyqaWOxBmcq/MIwJOfi+1m0FG0cb97m9MfEXgkAccDYjj8IJGEusbQOtYzI
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4477;23:irKU01qlCVMjwEgmPbrHroay+dEOVfGGJd+66X/M1?=
 =?us-ascii?Q?tfB/tZt9Y/Rn5TFnE408hOI3IWpeSBAAKv7BQSw3DelkHMrOuC/GsCNh73pM?=
 =?us-ascii?Q?R+Gqq6HnceZ3z9wBHk+J3RZeVbhwP2N3tEO50sUY7hvyAvCxchi5LiqU0xyz?=
 =?us-ascii?Q?J+Mo09QZq0L6XtgSuksUloMmXyE+KN2AUaw5KY2DZ83W6+DaoVW8HvLCs0qH?=
 =?us-ascii?Q?TBWQsyjATjdI877UdjNkAPsQFIalVed5/NE/7sDnR0HQGs2U+HKpmhoL0EsJ?=
 =?us-ascii?Q?brwrQ+HR9oYyxVNi7X1GyTHjLE2rB/voj/N4KGhtoZJ6PnbV7R6U36RmaLbw?=
 =?us-ascii?Q?5gqbTPktBw1QFrjlRxl2Z6ZiYPFWRAXcpVp/P+dynwGveJCkrkpmHYN1ZwWs?=
 =?us-ascii?Q?R5bHJONuJVzIvOe08CQiKGvRtPeMDVucNYuw15iIzZDBL4kbvWtWppfShezw?=
 =?us-ascii?Q?JJdNakXyJoXoghfC/ep9ZVXa4JKzHWy064UI2RKbM3mYiSt9jJzdplKFjoFe?=
 =?us-ascii?Q?K4hYhh7N0ze7Oe6+Evp+fCRiaI6GYHFliOnjR3BJxZDzFUS07ok/O4fhws1k?=
 =?us-ascii?Q?ylz0yR6lnpSw1POMRgE3Ubk8N/k68RLYEQVBcnX/SQv2V2OYX4PoGWDjR8vS?=
 =?us-ascii?Q?35L4lBsNnl/ZMaJPxPEMBwJTqJ+vzMYnowFyTyB5X6ZtrYJEDuTvpI2TQORp?=
 =?us-ascii?Q?hV42+/f9T0AEr9F548Y3jcxVn6D/jrs6Is76K7TJzNuitMlQMFNNW9re7o57?=
 =?us-ascii?Q?P9h5Z29+uFmraKLnlbFtuhDfB+q2ALi07r+StHkiwlfavVjTq6WdYUhgXO/0?=
 =?us-ascii?Q?gECtWqn+QqMCTj+xPcDk2C1j0yL4JpRGT0uthvzvsrOgPUi4tpbgeqW9AUME?=
 =?us-ascii?Q?fQCIKhbWLebqMrZYVvxY7Xz4XvA92tW1eF1m5hxSQqZWtwdTeYYIHxPUqeDu?=
 =?us-ascii?Q?xygztmc0AgB0x16gSc1zOPoXccYHF/chLL2nwUciR0wMEBt8NDRTBoHWu9wT?=
 =?us-ascii?Q?o82IOdatgfsK/GwgccKYY6UcB+CZC3atq2tB/lFyRhzZzlzVchmvseafv8uK?=
 =?us-ascii?Q?TxD5uehiop7uRTTHz6kvGC/SUIfR46u1/Og9Gtcg6LnoU+97fmaw1qgzf+g6?=
 =?us-ascii?Q?9F2hUjn6w5jlvVGkptXFa2rjM+1Cuj7b2Vixdx6fGE4nPgq3NetDXmn8IGZj?=
 =?us-ascii?Q?gMXyD8k1AXjH+zZ5IjTbxMdd4q0E8HJIsMMsjqitJza3tThYs+ByFrY/w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 4ytY8vP/YTzBYNLas7mqgdcoXIb0wEaVw1mrko3l/euaQB72llh2SS4TIrYOHFyI2YmZiNGpjmfSbVM3S1+jmOLgQLQhW7fL5Ma1f1x2AX9fdquOAVysNnYWyhTlZOgdOxrBjfjp/ybucn3VUFlxUx+tq9Mm/8ToOpbAKHVXSV4rwrnD8vM6+wCzXEpPScO1YBn3R0bF3HS+DFYPBDKvME2xkuNEYp20TGOKShQM8NP1nKj1Bn1/MweBLuOsT/2bN1ABsbNFVrNKw4p0V8LpMyR4lu3f+9jWvdB/iiKE1Gz9FRZ4X+V00qq8I1dToAQM6dWIWcqCs1R8l5sBvXjwnkwQRGY1J1nlpOzkC0A4Ibw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;6:xL7EgZu/4PztvnraeS/voo9Efu0ABIaloEQJzWHMtWdN3/itx+bfU9nMIs61xqXYkkvbfGk4GZlhwactdZ9726pqCuYRQVxSD8e+H0HosCnHv88WvzwGPwid2F/fYWhBU6eFIt5S0NjIbYVtX2fp1nvlsplUbX1D4yaFKDSDlsw97XygSGRU/4DilwDqNrrecbiRuLGZEFiAVK8Ds2BoZ11w34Ak6qzSgBwxKLAn0tXn7ZZXmIpLH4Ar5FP7X77hdyHiDbAzSOJWzCen0A1/5Qj4ckEcs5KjFUZB3cFSe/dLMwR/a03w41KLhM+VNMlL06FXuxPlMJzmZ0q9EH+idM72NAQaTBWij6tJAksOs5fI860wMp2WTQlKO2rbKCeItNhKNEMXHLvQuEhGbFLUWxQRoOQzG+CReS1LOToWdrXn8dZ6BRSn3nCwM3bDO/QPHUZQ29ayXQ4gbYEmIHNP0w==;5:k0bYU3xR9V7B/5EcivOYDRuIbHTfNHGXB2EyAyhO+DAemTm6/uECK7nIOp/YWjQ7HpAp6peOAeroSFfFQczrj/4mC9uhsKJlU8HvgxcEnndvrb2+TsxYETTkVePMkXnkhrOSCpJnhy1IKauA1k1oUfxzEcBHozx17JVQMxznGjU=;7:pwfech7x9KTJkxpN1/yGdjVSd3vM+pIRnPeYGW9b7dK98jDWOfQL8LqhpPZiQfoQntA5PEZ20DMtYuHlBZjOWNjJu5eI09UbObw72mn7/xjzquf+VhFl822r1XOvWi3ApQbw5yBdTqPSoCrpNNkfWpg1et0Kc22ECcpl+uDCYfoCg0ODKZyMr52SU7F0seCnbZoAhCxSfQNTM3HqiupUbPl9ILiFpsOLIp6UpBaXzLUwJ9jMoBd1YqYK9WvLKiMj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 18:13:21.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ff5690-5b7c-4246-4cae-08d623dbbe15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..671a37a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,48 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
+ * @ioctl_id:	IOCTL ID
+ *
+ * Return: 0 if IOCTL is valid, else -EINVAL
+ */
+static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
+{
+	if (ioctl_id == IOCTL_SET_PLL_FRAC_MODE ||
+	    ioctl_id == IOCTL_GET_PLL_FRAC_MODE ||
+	    ioctl_id == IOCTL_SET_PLL_FRAC_DATA ||
+	    ioctl_id == IOCTL_GET_PLL_FRAC_DATA)
+		return 0;
+
+	return -EINVAL;
+}
+
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	int ret;
+
+	ret = zynqmp_is_valid_ioctl(ioctl_id);
+	if (ret)
+		return ret;
+
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +482,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..7a9db08 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,7 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-	PM_QUERY_DATA = 35,
+	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
 	PM_CLOCK_GETSTATE,
@@ -99,6 +100,7 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

