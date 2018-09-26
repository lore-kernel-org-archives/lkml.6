Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5242150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j/Ptpwp0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O/0u9SEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5242150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIZRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42904 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727555AbeIZRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBX3aG019774;
        Wed, 26 Sep 2018 04:33:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hV84EyB0b7HqsXGAmADc+Bzu4NVLroWRqLE/qTLewEI=;
 b=j/Ptpwp0sVvwti/4/xlJ/syU7jthdPvY33+qUCSHl4ONDUejLjp4iTiRE6GUAIhibddi
 tAEBTt4Hv4cmYX128uoDZX2XKBEYpsE8Ni0xA2HS/iL5iGvByxXcro8PpHvFdijSOuMN
 sRyTFWRiXy0A+L38fp+YxrMcnSOoyIdCNHk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr4vc0njr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV84EyB0b7HqsXGAmADc+Bzu4NVLroWRqLE/qTLewEI=;
 b=O/0u9SEnxoASls/ruzisxPUATQZLcMiQA5C8j4LqSPi9JqROlRSdt3BESdcKDH7mCa751ey4sg4oqWgNlKkX/lcUV6U3ucHHX7bTffyB0CKm3jaSC2nD/jXM0NfXLf68k1pqLLCZ2mzqo6pDDodSEbfgcmlo0HAryUGKAy0+0ng=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:50 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 02/10] bpf: rework cgroup storage pointer passing
Date:   Wed, 26 Sep 2018 12:33:18 +0100
Message-ID: <20180926113326.29069-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a0ed6ea-26b4-434c-8fee-08d623a3eedd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:RnxT6p/ZxUmaVHakq0nGU1ACtn8jo8u8X/7/ofYUWO1TPw2MgL0aF6ctARtKcV7HWKw/jPwgHSXSOoN8VhlDujmjn0CoXiL2dQZnunvQvuBzdOOAno9F11ixg3xVEWuiGfAuhUiGYLjtYNPPcp++35sSwLiAkYkDMp0V1DJ19xwb9abB9g4U/0ExTayRA45eDtWbaWrWu09lf+7L9v3em2N5cfQzMIpLK4tmQ7ZwBFckFJB6bMrcpheWLT44cL8b;25:7zkuYSLNkb2OvErEdC9Xpum4sHHF2gf+0EscZIqQGHWrYkOAEqDV7B4f19Ud4UwnXQGNqYkFGE/3KOl9rx7I5sTZW0C5b/ZDw4XXMnaI+BMjpVm+S4RFiXO3wf3XzjPMPd5Xq3oajNbZX2lZ//UmQ6GNOEx/Hng1MuYLh8InUTspD6Lk8G43Qp2wpCXtQ0OxUMONR4BPIq8kV/3XK9bKC5gaXVp/A9Y/ahtpBxZSXuo/zaLkDNUHyijZiWMUTQ5sf5rNfMNUQ5KbC8It/fnA8Hn+r5kcPW+cxw323ahVhjGbfxPTRV1ScHTZAaFA1+lrj6JVrWhaCv/BnF/h8aex30DTs9UbutbmVV+qC2mqOyw=;31:vZnGlNE922vq59bsmTMZj7zaxxIGCTIWggAAwtr931X9h95z+GI28ZnNK7KBUv+6Lrlrn00zhZQTIAtdJ9ex51JuzRxE9SlZzAncUyBW1hBKwxuvP2eYlyrlfB3+OhkgIPFbcKoHjsUjEjqHb0yXx8S1qx3ylAc5PlJ/7REsfe54e5Q92yYHvnK8kBM0OD+UHQRziG6h7i79MD3ccnXkxE9NwNe12Kvu89m54YZSmfQ=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:bblLkIf4oafvF+0y60EL5UeSjz6HHWMmMZBvP21eHj8LY2BaPJ98O+J1V5TKRqiqQ90t6IqX5AHfFZxJ261Z4aJNshWu1/n1MWQ+GwLDUgMNe6z85vpuvkfMRs6JZ8PnlVgVJA3e1vpQAU6gDh78WslqlPrvDNRkBP0rjHmX+xqgmgJS5c0enll9n8MVBXePHFSlHWXsbNGEmJKlqehT+0LZL6jjAHewJB4bOFj6Kwkpizw2lQVXOybIDODauS/XqySjbL/vmh3K/B3KJjrgYS/D6ZNrb/W4ZkfXJQYDSTEcy06HvYh579XcDKOykEMg4ANwh2LzN7kfl88U9R99LthTYpPf+k5QYxVS/1kfB1ijWbu65nLQ9aUUnB28lOuM17sFY5CRQ2wicdWE9pI630HA0TeejBB61Sr3+Dbra3a685NxHoPt+JTF4eYONFZwgh1hPOEjhI8KRv4DP2ElDZjC3RosONxFUX2MNcfFMqbSt5mIQfZcdKti+hrE75qT;4:Z+rtwotEvP4xPfX3MrQWCl1BVBQkn/GHjNlxffqjCDLHHyQIREr0WOFFUro6LJXCmhSrD5H/LQ+dCQt0IZGKZgR8NYf2GuYJelMkBoUtxltpTBbEQKkHsA5JCC6bwBo3HcA1fJ3cW222l0IeL2d4gl92NNoy70/QEzI1snG4jpVeF5gLCABVAagdr4xJV4vXDtZ1u2tmkFYe8q3hS751D5oDzpZbfMcB/Vw8thUwbxEKQGOFgANdOqJAtgUrKn52SGes2sl5cxY7b/zVOvO8cIhSIeS6MFfTKRK+aIfOvCHllHoHSi+lHIyop67JzS6i
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162CD87C91BE01DE3DA3636BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(575784001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:f1SOyV7qgWrFtuXISVDWKWfzPBILtYDRmfZKubJsl?=
 =?us-ascii?Q?UVNgRKxT5oeOov/VBg9TKtfmiVdOrVqGiG9H5+L9OTxe1FJYC6zqtDOSSIL7?=
 =?us-ascii?Q?Rb+ISmjR3fb6vFIzw3utaP5IEXQtdqhR1VE3AoBQxetc1uEequ8sJz84Qlwk?=
 =?us-ascii?Q?cFyzQB1XmCsuP2zhM0xxANBEjYCDQkLQAHWzpNsYdUtlMdjlmhhSc+vLwthK?=
 =?us-ascii?Q?Hiuq4/bc2Q1kDC4Pdrem2P08RBc/+O0lG4QtsIRtYyVjcVaAqIbkPDoloAae?=
 =?us-ascii?Q?Rexf0ZuWdooX0bOx5duW/ZmNBNw15rVLyHLONXJjfmYO1ZkhNUNWlxpG7yWl?=
 =?us-ascii?Q?McKthSuAoEd9wcUE2wXUUpbIBA2QvX0OV6h0eXrPVZnEYVPrKCxHXAvK2bO6?=
 =?us-ascii?Q?Ruyd4g9vUkLk4vYujKOgrbwN4kOe/kaSWgTw93Bxvd6mCWd3K7Qt0u22hgiD?=
 =?us-ascii?Q?T/9gMF+X73TnPyr8lIGT2DhscrZphHFPnu5z2PS31r2Nhgj7+AP3b+WI6gvr?=
 =?us-ascii?Q?HbE0O4DX+nmGBqDyFZFvgNw0OSeADVT0laLwprKcaeFYxoShofk8eNvscdif?=
 =?us-ascii?Q?5/JM3AWx4ukDIHeFJFRrzLjcdlDQVF1Akgxi+ZFkwj/DVBAzgg+d9VqBeirc?=
 =?us-ascii?Q?hFNLHGP7brfjnM5nX+YEsYDFetfmPQRk/ngSMLz81RIL0/rSWAfmSZ+9ee96?=
 =?us-ascii?Q?M/DJXkzm+ka808Bn5Z6fg/EhwDsBhhHYE73TL9jClbxUwulZQI61y0lSjipa?=
 =?us-ascii?Q?zSNm7y9KZMg22vkVGmYpWViD88tnv6VQ8sa0yOxfZgVvXYGKZnLbgh98IUA3?=
 =?us-ascii?Q?CpLs83qf1TKyIzASwJNE2TiN9sjt+LEiFHvb71hTy+0Ox++/dKSbCPA8AJ2t?=
 =?us-ascii?Q?kMiU6fVwRKbotSGh32q/bMegTEVjjtyJ/6ZX60cwx/2FfeWbiXIZPASazzNz?=
 =?us-ascii?Q?zARbBHXu9DQ961NZwGhL9ZNFphKJu2XBtkGQDyE+h4ZEywMRn11pSCaPBniw?=
 =?us-ascii?Q?zNuuz+u6X+voO34kKNOHDRPTKWr8J94G7TVo53tlvc4WBn3ERUgcCSGp8UJp?=
 =?us-ascii?Q?Wlz43jgMoGVcO3mTMU/E3ASWB0+nX4OjJU0tcvLP1wW/Xkygsq6OF0qyRqu3?=
 =?us-ascii?Q?7+Rg4dUMvsYH8kG+ESsqn0FnL/UH/iIacZprV2Enw/1roSNRlMjCIdu/2w99?=
 =?us-ascii?Q?WuBvO1HSvvqFrUdrdjYpMy3YAgNdQdXOOznCavBwSH2o0pTruymwZcx28t0l?=
 =?us-ascii?Q?z15HsUNldHw1f6r9sb92TFLTxYhDMcVZboibqk/O4B7Plm/VP5qbeq3EXB5B?=
 =?us-ascii?Q?ZPRElli/j/UHucIk5is0NtMD+GdcZjTjL2UuDX3IKaQ?=
X-Microsoft-Antispam-Message-Info: PYTxJVF5o/hklm9sidYI73LddVU5kyvHbhOi23OxalIc2NZPthohEocXXUVVzJPMhM3gCoG8FQa7oeet4TGsEQHy1DbXL1YqGsXno5nNGLJPwxGsO2RN9R6VldE7dV7Efz2odPyLqST538xO6hTapTdhW8/LX/HEtvKmEmxVyYRqnZBgn8UzahwJvZYHqXRNPF0HG2Js6J8iZfdvf9D3fNOmymSt68q8AMZfmP6IBdQlXTdJI6EhRrTXIWjZLVLoO5ITtPop7foqrtrPu7uAydztQ1be//oIKeA1u0VxSdl3C6y40RTxnRSdQppE6PupCufK9oOgQDRDyRzS2ns0FGPkFG6i/mBQiifiRkF2BPU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:jgJU9OReZlTGckzJdMg5URcFpm4VStcKF+YBwljKMij06EhOCGC9IrtKvC6p1Ul0DEaVoZqFomAWgI/E7YLKjWQrwZsqaei4tdUZt1+SYX+lySDhr8eTJvAxxx2bk6kwzo40EAHjjBcOKIMFTqNFsDMH8LuIbKNMqg/5ugD9AAjgv1r5MsIpaORW0UkC5WsrDPKA06VUAdQ5+Ti0DPv9yDo4AdW6m5EGd0CUa+JPotdzs1VcrqSTFW2BqRrYRjRNa1zw6Ozw7sB2LpUcG1+0hbnDzV4+9P6c3hscnDdyXY1N/DGGeauJGrxNfYgDbpaOy4xw/F2FnoH7yzhQs5qMMO2lNse5zU1qa1WuSDkWbkFITuM+CuarFXyuBjFrlNIlHRKy2MZV8ytPauuSMMJmFqSSbB9LKBFsEP/5XdGFe3/BU86ySpFN4tYpsUEABuJlDg8aRIajSsfc7IKcRxYOXQ==;5:rttbNan5WbHgpFvyHMkmgXKTWJjNM+g2lzVbuHh11NihTJxVZ55J6p/lb367g7ork/Wi3f344IhZ/t23v2AcVPBmdswdDHePXkRKXFaD8PwosKp6Q7oYLEvsMXjbPZj6VnDRuyrpxNmpd5p+gFd0DIHFNFmZFLK+OtFMc7bFzzU=;7:kB+mpXJoQFYbhjIHNyK/EhVXTiXAh+wU8b0mLbZmx+h4l4mHZ12ZqY7rhHObe9hqnz4w3/QqRbYtJQyxzJPA9nUokSBRiynpCxgf/CJqnS6UvguU4hOaqVW1mNJQEexs2RUR9H9CfMLapi+FF3XBMX/K+CuUj2Hfd9BjTYlQB0K6QecFlSxh5lG27/gjgHgjcf7+5//RBxE1Fg1CvwFJjjmRpVU6ZKUXqr/5mmsF5XCF44OS5SoF41czQgG5LD8y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:Hex55LkObPiiuIE2VOBi0iBB77mOeTY3RAp9BAfwFpx6lHtk/CNKkAHZ5d2VImaWCN9LUvY7oH2DY+9GMDaKkw9dtMZWBJGMzB/Wk+o6v1xBCr+jx+Tr06gk3kSLBP1JVzWJcZ4gbSr+ZStUlG4Lun3C+v++O3caJ1HegrUVszs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:50.3734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0ed6ea-26b4-434c-8fee-08d623a3eedd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the following introduction of per-cpu cgroup storage,
let's rework a bit a mechanism of passing a pointer to a cgroup
storage into the bpf_get_local_storage(). Let's save a pointer
to the corresponding bpf_cgroup_storage structure, instead of
a pointer to the actual buffer.

It will help us to handle per-cpu storage later, which has
a different way of accessing to the actual data.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 13 ++++---------
 kernel/bpf/helpers.c       |  8 ++++++--
 kernel/bpf/local_storage.c |  3 ++-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index e9871b012dac..7e0c9a1d48b7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -23,7 +23,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #define for_each_cgroup_storage_type(stype) \
 	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
@@ -115,15 +116,9 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
 					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	enum bpf_cgroup_storage_type stype;
-	struct bpf_storage_buffer *buf;
-
-	for_each_cgroup_storage_type(stype) {
-		if (!storage[stype])
-			continue;
 
-		buf = READ_ONCE(storage[stype]->buf);
-		this_cpu_write(bpf_cgroup_storage[stype], &buf->data[0]);
-	}
+	for_each_cgroup_storage_type(stype)
+		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
 }
 
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9070b2ace6aa..e42f8789b7ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -195,7 +195,8 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 };
 
 #ifdef CONFIG_CGROUP_BPF
-DECLARE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage*,
+		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
@@ -204,8 +205,11 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 	 * verifier checks that its value is correct.
 	 */
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+	struct bpf_cgroup_storage *storage;
 
-	return (unsigned long) this_cpu_read(bpf_cgroup_storage[stype]);
+	storage = this_cpu_read(bpf_cgroup_storage[stype]);
+
+	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 0bd9f19fc557..6742292fb39e 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,7 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
-DEFINE_PER_CPU(void*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DEFINE_PER_CPU(struct bpf_cgroup_storage*,
+	       bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
 
-- 
2.17.1

