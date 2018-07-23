Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1584ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A98020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EBF7tHz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A98020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbeGWQEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:16 -0400
Received: from mail-eopbgr700054.outbound.protection.outlook.com ([40.107.70.54]:14571
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387852AbeGWQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC6pGsLy8GNSXYqwcZND1tUJe1Jqtr92XlvOks1726U=;
 b=EBF7tHz0VXomtondz72zgKU2WYL1hS6mm+7jA72HyObBg3X9ft4pT6Yuh7yu35zsCLdiFbMM6RlpKI/usGYzUNx23Hs0DYB4+HzHp3EpLRP5m9tUpsRJMwJR9eefaNxPli6oh+FagMmx5a3GEoHq8Mb2T66HgoYK2pPG6Czeclc=
Received: from BN6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:405:60::18)
 by CY1PR0201MB1914.namprd02.prod.outlook.com (2a01:111:e400:527e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 15:02:27 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR02CA0077.outlook.office365.com
 (2603:10b6:405:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Mon, 23 Jul 2018 15:02:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 15:02:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43463 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLx-0008L6-UT; Mon, 23 Jul 2018 08:02:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLs-0008VL-RS; Mon, 23 Jul 2018 08:02:20 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6NF2Cw6013225;
        Mon, 23 Jul 2018 08:02:12 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fhcLj-0008RS-Sx; Mon, 23 Jul 2018 08:02:12 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id F111E121473; Mon, 23 Jul 2018 20:32:10 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/4] iio: adc: xilinx: XADC driver Enhancements and bug fixes
Date:   Mon, 23 Jul 2018 20:31:59 +0530
Message-ID: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(72206003)(336012)(52956003)(106466001)(14444005)(90966002)(47776003)(486006)(44832011)(51416003)(186003)(26005)(476003)(6266002)(2616005)(126002)(426003)(4326008)(103686004)(478600001)(356003)(50226002)(36386004)(6666003)(5660300001)(81156014)(8676002)(81166006)(8936002)(106002)(50466002)(316002)(42186006)(16586007)(110136005)(54906003)(36756003)(48376002)(305945005)(2201001)(63266004)(2906002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1914;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:WlLzXYxxGxe5pKW63vWQILg8oHjmGH1q8ERmJ5vR5wlBPQYwgDphrk3bc+Js7EkSOyR5B4D/b4gnbk0tWQqfK3zEBhEQiubz5M49+UpaAsHiUjVoQVwZ8cQdifXYdmRU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2256146f-63b6-43b4-081b-08d5f0ad4dad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1914;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1914;3:MzSNZund+xwUYJZLmK7KFQraikHEFGhZMMTOiYOVf4UnXVbJTTgmCrN0L1Sz/l9dedfEG1fm1k3oMW+JEhyE4+PbGNP8b2L1oaY8sOatgMRmWryQvyNS2etZLICPVyGCTc+RDbR614RRjyZgL6gNgbkmoPfLP4SYGF5Cq+KeNgIrWgp6YMkY5tczZJ05nRfq8RpMOjt/VE2Gw86DKoXVIervu7jD3Xz7MYz0pI6Wb3foeXL8GoWBhF3QmDkmp1gwGV6dwcAzApwyUXoFPcagc+p4wvqYLkDdKo4H2xZIzXSs0QXDC0yEOWk5zgWNBgD9ffaF2ugUq823qzD1KU62ALI51AeHcoeLau3qFi0jdQU=;25:rDw3zoS4/AIx3e7OGHQd4EKMqUoLZGwpC/mFbyTQCkSOk0LEpnnMxXaB8OZFMsoK4s2OqZN7abqwyLvHASWrjj7q218cq8gYYq3wSQQB9YxuRjrlSRgouiNWndLffwQftJ9makRRWbClmF1w8dqaM9hlZ1ks6QP9EbZTbO3HIivDXORetd+4Fu/d3bWt9phBWOzMsDm3TTsTehuNg6tQX7hjIx9KmM7jlavlIrL5JWi+Y4QsnL3bieTZEpu3i4l86CAuISswNio/qdM5aX6YPKJ05dZQqZVmJWqon7/QCzb9HC1dOt9GqlUWeImu0nM9THgEKc/uwhuOeFfRJAWYTw==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1914:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1914;31:up88QHskdIrEyvnqdjrHJsYXvI7am6N6+i13mL7/dYJVUYXJOQPUrfodNv5DOH+sleUmOvEnwMs6WysPNR1IupDPXyw9PeSaP8oGnrYtCYIcQoX2a099EQupzHyVZnf0NFh3b0AyIA53zBDtzZouK1YSZ6IbzCRJL1GqyRPQdDKihxkfr5unTVmthzrCo6mXmbvkgk3JA1hoxm2VO2geH3nCv9SmHe28aEuiNchss8Y=;20:6JO9H1Q93X/XsV6VhTbeQ0dWtz1JN8c2HOK18k1K3LBc+UvinPZp4gKAvsK7jNV36SwnKTe3EMdqBTOApzcrY8ASUwOX533/8Z93uiJYC64vDF8Z+pCtFJSXyqckP99XBkdXlt8+oe6VYpKBH/l9XLx2z/8mplPqE3810LCMTyW/3HhqmkKTISlukger7nTnG9sQJsS4rvn2depXJ4UCVR3rizYjSAwPiomQOWjMCFx8oCLDV+BRBsH5YhuwX9FD156/FmGh9B2WLxdPpjJxeWqUfapzgvjOdajbdhS9TMNoDnpXYiF9jLVfptDKvT2QJ30t0Hh6MaTS05czzSRWHSgf7yZOkcrjcNKP/HvEpkDtYWE6i3WPTuqqZzX2O+5UvlAOpLD5s26zn5d2c6WPtJMB2UYyPZf56jbnM87xtPGsK9bYMWPngS0wkADCQBqyZwCgKzyzX4CBO5t6SGLRm1c0KbeXYG5SG8lBq7zZ8HHY8H9m47nKeJjLWUidVw4G
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB19140CD6CC87C50040BC2DDBC1560@CY1PR0201MB1914.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1914;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1914;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1914;4:crHcBN1yxx9tTPhOMZMIF+Gxu8Q4KPVkNOKuQLy9yWBAlN6s7oY7baG/ykt4fxnZvmfRThjPL6g1Us+5m0i+trk524t76ROs54/pGlwVFrOK0nNzDBlEGkzJi89+kjW86iJftMrJ7JtBiFTzAzC7AiYa+Nl1PPASt7s1vFdR4Hq1UgyhvZl4L3+JouODwR6rwqpsC6hL0XXN5uGugLVmCjUFoxcvBzpRqfEtsQo4uXEYDJWCJB4gYEdXJ3qwS+xQcxgu+uLWVtZatTY/0V+W8A==
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1914;23:/obHhapDtFG9ok7Vqmuq9zwoWWO8cFQ5m6jM0dM?=
 =?us-ascii?Q?PIRzOwLF9VyPN5hfFGDPYX6wwfRM6Q8DbikSxcstTJuJUl7upRoeLrVQ8UcP?=
 =?us-ascii?Q?TtQyhIS886BITDUmB34SqxCmkyLhmjN8E0Vo2eRHE/L6KWoFkf6tbg+iXLqt?=
 =?us-ascii?Q?O9yCJAxJ8uohSTln+tOgOuum1c48minsJgF34O02K3HKCquPkBQNSWxXFIxE?=
 =?us-ascii?Q?s1Fk+KYwbqTEduUgvCZlBU0P57Bw7FSBK9J6lgYDzkktuwO6bjOOqcHF9ndJ?=
 =?us-ascii?Q?teseJT72glKVp8N8BU6hOdGkeoUmUOUf4pQXu7JsA9P2y5ULbO/UyP+2LLxn?=
 =?us-ascii?Q?nVzEGYufFIfRlqS1ZZYxpjxRib74EDUJoSK0cY6s4V5u9+oS1h4f7IJ6c6pj?=
 =?us-ascii?Q?nrwHAjBnV0hsFuc5orcVuabUBBmof+vNh/7KY++dtirJJydj7pnoANsBbLDt?=
 =?us-ascii?Q?u7Ysviq75eIOiDUFhWuwY3MvIlWT4beLnLW1vt40l56K4M57RL46b7SzU9Sa?=
 =?us-ascii?Q?PROZiLn2cKr57cKYJseW/azKVd7Afrv60/N/vhnvjbyXsIblFWKgLhrJ0JF1?=
 =?us-ascii?Q?2vzwbTlPdwGe5BJr/krl+taZvWb4mBoNgo48/Lb3lifni0e8Arkewwxpw9nC?=
 =?us-ascii?Q?SeacVp3124VQ4P9rf6AtiaQJM1GBQW6t9Tuvu8yfC994o4Py+LAHMom1UurB?=
 =?us-ascii?Q?7qz+9AJIkrMjK/6BfpXm74HHXgKtbLETFxXyAEWN/U0tZQtK7XDoeYb+LGNi?=
 =?us-ascii?Q?tnkSl8X3OnAEA1lcEBNzaViyBBzRqNQK2wZ0Sp3WnpPhoHUqFcyGuylq/STn?=
 =?us-ascii?Q?cG3ikH9v5YnNSLMsh2I+b63Me76DMksZvlF0nTYppiDPu/Dg+dAnHg1Mee3s?=
 =?us-ascii?Q?Pwl//IuAYD0c6Ztxf4xnxMVImhg2Onhl1W93BwaVwSQ9zk40Pt5dSqLNW/Ei?=
 =?us-ascii?Q?7KVsdB9LV3Je5zSJxAdyLYqdj+nrNOSY6kkxx11hZerlwITGVngFg6FPD6eN?=
 =?us-ascii?Q?OBzSVm8H10uTT6Zz6vNY/P1WvwMkPZJrYlyX7TQ2wUmp3MncEbBEAlxIPqZ3?=
 =?us-ascii?Q?oeR1aCM4DT7XsVsF3pp57UHbPUbFTZ4+sAA6yLLqotUKiXtYeVie73q5kwK2?=
 =?us-ascii?Q?Ur41BelZa79J8vDwFv3r3ZkxaeljfmzumUV+VffDu06daf2KhhQWJOMzFZYJ?=
 =?us-ascii?Q?Gq6NzwNn6N3eHs9I=3D?=
X-Microsoft-Antispam-Message-Info: 6kHmPMUeAvnlmY+XWkJYJkr/5IJJzgdI5sMTLuR8KolcxBcCGsuVs5j/o5ph6WaUbLKijyw8QeJJM0AIQa5RSjJ3iq9Pey+FcnkhKrR5Mifmr3jA/8VIZchHMKxKyi6IjLL7zAI46ViZo2ic8t2dwQv5iXzHOcPGKB+scFC8NzAbdSkwXUs8yY1WVXoQsxJLF7CNhn3WB/MZ8T5d0Wt7bVn4Rtkix5AoS5LKsPFiIloSV1bXiMPsgIRyw11/zQnGN31XRSTGa02PjiAN0Geot2UcPGgvKE9XNQpKiM0pdj3HRdtDQAAKSLA2+ES3NAP2G2lwLCkCzFSXbRGewYjb+xFKna2pX+UN5/CeRl6ILxc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1914;6:iwZNKv9QkC5zfQV3HAqyBFRa2DUaWpkeHktjtdVsfomr2lmdRWASFHxbopzDMZl7ia8uYKxfXgnkDm7GPlQJ64PA1uaoanXDqHrXxEAXF7vzKCTjni88J1gzOj6gt3bVfHdEH7Pr9HdI3vi96dKYcxrfdKTho7ki5jWgbkSMrCRaxbEdP+D566r886LYRcRt+pAS5LSm/tdUngEccWYJGjBs1rrQxN6JWF5HuD1e1NIRTVc1VxKomW63V6vByAdzPgeQd5e2mYszYgRlA4K1aF/3b3tAHWwAVJ6pY1jq6iU1JhfraH+ctNVX8NclG1en1dHK5IdQPsxd3obQUMK4PfT5e3w14ivBBwVcu+eYMDEHNLfTFUs0FVpkNqDNCWeLLXcW587qelOkSXtFX1X0W2y1eTDep+jdt9PehB8xri4pSkl6Mqr4zkSfSQVO1sbwBzuELz2Pn6bnZSLdtEAIqg==;5:GFHtw9uiPgQP+bA/CjlEso6EKn+yua2C3Iqo7tQanIeYTrUuQ7p+1W/0nlSHDBLb508A8SNljGTXjpS328ZcmBrzeGmSTgRjWcqd7rymFmm4LSiTQ8+cHRaPYOkA+kHBVqiShZ+j/H0ca/kSQyGc+f4ATjVE0/jxDrBGXa2Oh1A=;7:gDFKi8lIPMDyFPcDLhJ3VSa94NMGFCZN/6WklylUIz9AKqKaA3ynDaFaIqQ8sb17GMb2mZGtrMQqR1vUiVrP1ivtRZTArBYyvljyK/k8V0VsAOEHaNPeAx2ekDmxjYOR0k9N1NI+xzWTJMwKl28wnm/M/6Vzunjp2IobCz5OUhsoyce6pIrSJ9artH27qHi/ZGuMCqkMQafs2xmkPOKWSYhwiUmxN57X1q+6NWX5sQ31nFDZGKwfkwv9Q+5zpOjo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:02:26.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2256146f-63b6-43b4-081b-08d5f0ad4dad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series resolves code style problems as reported by code analysis
tools.

Changes in v2:
	- From the first version of patches, 2 patches are dropped in this
	  series.
	- In the v1 patch set, 1/4 was not required as the issue is in
	  checkpatch.pl script and not in the code.
	- In the v1 patch set 2/4 was applied on togreg branch of iio.git
	- for 3/4 patch in v1 patch set, the patch is broken up in 2 patches
	  in this series as per review comments. They are now 1/4 and 2/4 in
	  this series.
	- 4/4 patch in the v1 patch set was basically to resolve coverity
	  warning for platform_get_irq() in xadc_remove function, but that was
	  causing potential race condition. Fixed that in this series (3/4).
	- A new patch is added in this series for moving request_irq() before
	  enabling interrupts.


Manish Narani (4):
  iio: adc: xilinx: Check for return values in clk related functions
  iio: adc: xilinx: limit pcap clock frequency value
  iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
  iio: adc: xilinx: Move request_irq before enabling interrupts

 drivers/iio/adc/xilinx-xadc-core.c | 40 +++++++++++++++++++++++++++++---------
 drivers/iio/adc/xilinx-xadc.h      |  1 +
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.1.1

