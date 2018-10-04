Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69522084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TrXz5pWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69522084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeJDWae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:34 -0400
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:12648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727816AbeJDWaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCZY73Xk3ZmXiimGXMWTNBwnmHabA+H34FtKHqpqPuU=;
 b=TrXz5pWX+MDyObUIJThoWix2t7iQwQbEno8AkHpIpnwtnphgskFeFcgidkTSkp+ROZ69O3SrQwO1airLBphsv8bwxLG33M1xRQTKN5yVZ4T2xlRdBSAVTaGzsJF4Djasat8xhIr3Cl5HeVbush7Z/CZ9Ps2Eg04wU6ByFQcxc4g=
Received: from SN6PR02CA0006.namprd02.prod.outlook.com (2603:10b6:805:a2::19)
 by SN6PR02MB4765.namprd02.prod.outlook.com (2603:10b6:805:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.20; Thu, 4 Oct
 2018 15:36:12 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN6PR02CA0006.outlook.office365.com
 (2603:10b6:805:a2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:36:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0001Ob-EC; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-AI; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94Fa2QV023971;
        Thu, 4 Oct 2018 08:36:02 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fV-00008Z-KL; Thu, 04 Oct 2018 08:36:02 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id CB6F1121465; Thu,  4 Oct 2018 21:06:00 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 07/10] edac: synopsys: Add macro defines for ZynqMP DDRC
Date:   Thu, 4 Oct 2018 21:05:25 +0530
Message-ID: <1538667328-9465-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(36756003)(16586007)(90966002)(446003)(5660300001)(50226002)(54906003)(110136005)(478600001)(63266004)(2906002)(8676002)(426003)(106002)(81156014)(81166006)(106466001)(336012)(26005)(575784001)(2201001)(52956003)(48376002)(8936002)(72206003)(186003)(50466002)(36386004)(2616005)(7416002)(6266002)(305945005)(44832011)(4326008)(103686004)(356003)(51416003)(486006)(76176011)(316002)(47776003)(126002)(42186006)(6666003)(11346002)(476003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4765;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:Mt8FCA94WEkIlO+B6IZp+CNDRgXh1/FV/aM0fB96FlKEkyDViau5siV84DGAHC5cNVeO/L4+PO5Du63MEtLGbnMCpOIdjgmJufWKr9d6K0oyUlrmXuyizlMm/WpdeNNl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368b4a9a-a105-4f8a-d6f7-08d62a0f1d6b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4765;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;3:QgLMCKZSe1vL99Qnd/iFDQQMrx+jA/dgH9j97Tjz8/tuqht9dK2sPSzDGerGK5LlMgyNjBl28zvLEKqxvXeL+VNorGHP+fwNQUI2WV//EEsowGxf7ZOk8WBDso6NWHOd3zpJ+E1coMrfIbz8F35K7ZCo3qdKI4RdRmKAB3Jv77KJWfkmvkmMrffGvFZi1OwRsb/eESV+G2ML2LREiE0VhX8EGmd8FF6bf35mET/42M3DFGpW88i3wi/cjYrhMc+QS4VVZUEwnp1BP7fCn0tio798m9F+Dvr4U9aVkMkQUMnWobO3bqKo7W8G34+zOQeYKQKavEusefoiaSwjqX4HyWDjBfqHmc3LW4k3I9Jq0K0=;25:6e6lEP9BxUZ2sP3UNjuwS6ik3fS7iyYkYwt9HiF6nW6tQqT0NGNRNY9awNAGlu24rsfUBkoiCJx1dumPC8j6m/7XURny/LktXWQ8Rc9UzwkZ35TYTh+fe0MV/Wfn80TnH7Hjx1RRA4UaadFV6nDgv6btUZFVRG1BHhOFSKI96vrFe9gsP36ih9vOUsKWJY8rStsECJ7zvuE2ZlYild+u73OWifzOj+T2DXWjuPxxgDm4tYTT4goDbwdkvO4aKte5QyLFObgkSfR2BZtqbGF73vFIWMvbcNuZM9I5K1o/KvgNFBk16IPLRfcsnu6VVjuyIV9rcGh7aAmVpfWIuA9+/g==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4765:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;31:40Y2kd+bw7O340waPR/PV8kW0qe/6nPW1jI/tq0k8W0quCHZHzl11k856W7D4B5XKNBSd6qlcaUk0yjjV+BryfIdj8OuPB2hhjMA/Gx7KW8SDpAyCfUbuRSkwUp2uDXojBYJyw3ibi6MOnFnPcIipu1jRmhYWAr0c0u6U9lH8yYUnl+jSRS2ECVsCgIeRrFtPETnjBhpQrtjeE+ZMVWrHousd+GiUhDloEtDXndTyg8=;20:TmE90vkpYs9adR3yy6zmjPBsir5ypgPcH4umHHgC63xQbL+tpEIKJ35HJ9jj6B1BZD236VaujXinRHeCxZiHt4M7qZeKYTPog9tFL9XNqiaCiib4iJrPdi3g2qW1JXMn2ZPyuX9EATkP61IKiiqIxQtyzvYs7b1Xd6t+X9MappJjcg7DCu7dKzFwwFJ+iNcTw0ec0byeLVTUmgA9rzBmctEJP2akEOQ9Een4yZNMfBaGGsjMGW26znVCvR+EP4MS8fQK4VlNnz4fTrPBp4ADgZLtvYekh6H5XhBkbWU30vNcg+3PQdHAQ9jykNTVslc1bxm83c3TmKenVg/IPcEiHRACgilGbY7MNq7Pa+9YJJb8hixOm0mt1WZs+mqyqKQq7CRFFOVeLjEBEEuLsUEiTF/JI1rxFQOxLk9d/vgWORDOwXPgS6hTnINjNbiWXkacAS1NmpvX1WV8THCWRONitkIjWLhYBPm9pyxChESKo55Brd2kUlHD2X7PWwVtHxSe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4765FA89852BB43B2E4EC3B2C1EA0@SN6PR02MB4765.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:SN6PR02MB4765;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4765;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;4:NX1HNePpar8CMqHys8LCL8fjq+aLbVBRORWjQ3CMKjnuPZRJxD5jjIdka8VLh3FK6pNzw++ea1mBzewwtn2LcgeUH+drrgABJ2kqf17WC3c9vH10CTytGRLriXQbdAstkKLLV31SKCb1iEJwQjr1+gW7U2DjfreHk/iBAcKHSUVXAdjeq+5D7Ekli4qr5yEykzePKEzee3OS13HwX4GPlCyxn/eX/zgPfK1zziSWLlOU4qQXixRqTauGoJPJuYxmqJ9stvVEkq22sFpR45Mi9CA6B2dkfC4PCnPdH6YPeL809Y+iUDdlfwOindUlcXcJGOnm3eCQy9rdJvdQwwiwyddUX7hATYr8TKHxQk5c3dM=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4765;23:Pv4p8DXzTCbzw/NwjbeeCDdhS3JMz3P6rrL+lNDKy?=
 =?us-ascii?Q?Zog2/1LDNZ4idDpAbn9rzlgzWaL73OyRnVPwUExaFmVcU8uKaG6xizqqMnmW?=
 =?us-ascii?Q?NuEsEqb0kTCVS4xyySaR4jhILge+SWygJsFj/J30uvl+qztHAV2Q7/Lk/8v9?=
 =?us-ascii?Q?B1TmhBqHurG9k4DTHhpafd80h78abFn+sQHOpVVCNBlfRhaDEbg+kDxqYi3o?=
 =?us-ascii?Q?KO4b5wFvnsTgdZ0EjQjd3u8GOFMdjWonjucoaugLj3GbtHYI3EFQ5dM2hrS/?=
 =?us-ascii?Q?w/OeDNQrMD6Vmq/e+1mGKE0U7d+qq6UcTy5tbMZRMOeblx1mTOcmpkP1DDxd?=
 =?us-ascii?Q?3dmeN94Iy/4SOWypQ2Ea8cxBD3jkndudc9/ajMHTK9wQgGgmQzv8eq3SbXkk?=
 =?us-ascii?Q?85nENjg6gusnsHcJmhDD7yU0aSUd2fx1I6TZbdYLKbYUMH0jAkD3MKohE2cW?=
 =?us-ascii?Q?QsWOFTKtdcoR/+3QzRLk8l+sw23DC7/4DB2cXnh6oyksX6NtZKredahAm9Rw?=
 =?us-ascii?Q?Nlfp9AJ7WAw6gXtpVzy6XtjAFx4uWLXWqAdp3KzSoIeXNjkZIIMy5udYcWwA?=
 =?us-ascii?Q?vrigXQR7OWfOoJ9ebf3lfZZzXBNH8rAcNLwxZtSYgKqWPliCcAUTZAYMx7eE?=
 =?us-ascii?Q?pM7EMqnoFFDAidGybejYPxsDwUboJ9C++BLOX0vafztWY6yMfyqQAJKHPfeg?=
 =?us-ascii?Q?r30mnjZ/C/xomI56Lc7f+o2dufnHpodUoOgB3iueJYFB8aVJ1qZfBFOjpXTb?=
 =?us-ascii?Q?DqQHcpGnStg9JqLzJUzjwGoo3sn0ksMnqqEts40+ST+nzsRxYLp+raFKGfCF?=
 =?us-ascii?Q?tS/C6mTdR15RXKiKc516CRJuiUJuVhrAgZN/eJKZoMwPHCKYnV6TkoePrt6E?=
 =?us-ascii?Q?cBTIdOybgtLTXTICnDbTTjjGLpJGYsZyv0k030LV2uh7iPZ1ZhFeTb7C+DGn?=
 =?us-ascii?Q?nQHkSeTzGw7nZViDcZozUaE0+Y9f5jcS3NSVu7K5MBGgiYUWzspovLL4GBeY?=
 =?us-ascii?Q?6y6pAuYPblFv0DzET5LU+ONs2WkExnqKuYs7FSpr5k+ywSQsQn64KuyB63Z5?=
 =?us-ascii?Q?8i/29YsCytGTBTlL1R8hOVnzLz1KeOFRdSMst8vX4/2y77QYwoujVh1PrBuc?=
 =?us-ascii?Q?h1+s8fLfP8bsS6NghA5xsRMw7HuOZCex/qeNmpAYWflftdLFOge2aBK4fDjy?=
 =?us-ascii?Q?ivdkYN3kQrbOypzxpcC3j2x3opgmg4cnstc8ocvPEZjPlJbCUNBb3+vOAsel?=
 =?us-ascii?Q?2+Xqb50KvQ4r6moRuY=3D?=
X-Microsoft-Antispam-Message-Info: 6Nfn6zZYf5f2Bf//JvoVVTz5MfYee4By4h6drVbYn/q5B0DBrkh/pf4VcIDMIs9PMPIyp4NL4KNj2gSRqKQyDCYl4TEfK7m142NSGkT3vJfg/qmIQCtrxjErvhpC3Zhhh5VvqCAdIMq4uOc5aZMqNcCjq7Qxnp08GIiLky4l07LjyMUvV6Z2imimVcOBZt0TnILu7WjwxodwwdFEib/mbPWHUPBGSYfqmRRjJQ/wk2KXD3hrXMcqmPXk5W6ilXUupe9Yu35p8HJ56YTwqcfnwbJVbQpCODrHrxuDFvzAe/7e8CUVKMbpyAx1vUSF8T1Axuna5PYPynAT0JbEXeCvovKw1UnUj3FJp2CeO4oeXZA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;6:M5SvLaxnCmGl6Yb6XR6ulFr+ieklWzG7+kUA1/9zWuHqQbKOQh+hLMsAlB2elsWR8L5rwv4bA8x4xMVgLWYGQ8+NUsokZEkdGL9/ZgFJkDCm3vdESknqHBI+MdEzEJoB1ZKgxrhjorzTZf+LLt2ilxDZ09WM/7H29nT5EEYpkaBrZI4LEspvuupipk1wPzdpCxqLdX40Cme9O+AKZvkF6VE8x8rGkax/qwUzeXY3CTBEU+sf8i/FtYJFAPYsS/CMw1ZS9RnJeIlFS+7FizFSSuUXXF8AEUYJAV/Kt/os2gajQhjoh8R0+iV7FBXH4sKZx0DM3m6uAMfcOWwY8/CyWFcw7+E31ox/hO7r0xKBJFEw9vg0J5MemYU9w1jysOxYCuqKsTeprM9H5iIlUjHdbbZyFvAwS6N9mE8lZVBaqOg9ucZhXgxOOXCF+Rs+my3XGRqStteNfsE/LBnyibOUrQ==;5:O+cf0HEc/LkfQKlCzAtAPjApxIVLbyOkSg1l55isllB/YHhgsj9O4jtBuUNJUt7rOB1irAMFj7CuDMYlWNkYs0bGdfsHWJPIxpL1G1Kd8UPTZUUGMEhaWYrconKKno/AYG+/xC7yWo7yO5Ppys2fFoiO42N50JgBljmQ1vYJEmU=;7:w2oztlCQi9tGlg/aR6fjcpnC45/C84hSPi61nv+QbgBzzU4wdFi0RNOx4JiGAO0FTWgi2evDuVDcUXMa2uUspKEbbfogYaknrCEXNBI4om6mTkwde9ST7ptTLRsSIwuyvfAFXKEUnIGzZ5ym+aKLT1VQGVYx2MDyiiZP+/nb3B26ShKqxxN4DtMTwrvYkset3n0xI2LwymeBmZDOOp8X6y776JaXCDdr3vvjcaan/D6sjE4K63Vf/0Bs1t40YMJn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:11.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368b4a9a-a105-4f8a-d6f7-08d62a0f1d6b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZynqMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f0f4704..94d1398 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK			0x7
 #define SCRUB_MODE_SECDED		0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
-- 
2.1.1

