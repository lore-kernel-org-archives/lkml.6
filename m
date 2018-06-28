Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3D276F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H4HtrI9V";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TXdy0dfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B3D276F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935964AbeF1QvM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935748AbeF1Qs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5SGiPIk021776;
        Thu, 28 Jun 2018 09:48:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=whOWnZ8vlzRb4MFPGcMC1P+5gEEOwt2DmR99r08RYPY=;
 b=H4HtrI9V62edFeoxCB4JcXVHTcMpJp6OvVsPUDfmFQWXW4SfoMqCyq+BEgUWFICUorw8
 y7f8TEtrQ9NUIfezJtVW+LOyQwqkj7RZYQKkecMHNa4AWup+T+ealQ+qNTM7J29e92D9
 31K5z7BPr6flFzM3Vcs9QWnVT1W4Jgh5e3Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2jw22p8ex1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whOWnZ8vlzRb4MFPGcMC1P+5gEEOwt2DmR99r08RYPY=;
 b=TXdy0dfwX1pmi+s8F6Rnbit8aqvTmsomb7P/3BClXP61P2pxsSSLY3sRmz/+o7/LjSgO6L/jCNMGyeC1DZ5DRcKDW/tLYyEkyPluA1Gd5JXizdh+wTnXDDStittmJUB1Z5P8Osrtyzh2T7YkYEW+tUKMa9RWWpAlcxwG066zZ4E=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Thu, 28 Jun 2018 09:47:13 -0700
Message-ID: <20180628164719.28215-9-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195db4dd-2795-4c30-cace-08d5dd16eb6a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:NKweAdf7gUta8ymT3OX21NBSV5cCA4DNtzSB/ld+xKmlnDPDGmOZuNG4rnlYNtKrTso4Y4UsRtmBcH2nJwtszB8FD/0fePsetzcmqM25ZfZO0kI6eVogY7+rn8lgygiVpVUteLH4abyEvhXNZ3k0TBjp5MOebEbuyTnpB9b6OFinQvUJbtw0N1TXq60WpJbZhyAJpk9Ro65BEpA4SCBjprvEtkdTqD29bLHjMVg+iX9HxucWq1dtcwGY1Iz3OlZI;25:WCDp2HRWVliwEM/2S6BJYw+Kq9DegQ3PsfPHglQ0PUF53sp69wm4bdVVUG/SxnCWGpwOMIiT3w+2+jB5UMqwTF2bcXbDt+Mn3d3o4Xs8/h7NNbn5HuiIPpGr6bHnLxpR5HdnIdWf+ojmcfcj6EI2WfnYpBnphzbELxhBrIH7yswGa5LNyWvP1fmy8WlHXQ212DzrAtNQsCocwibfqiITrxOaXOFQe0ddrr5SequQ2X5yNRUtGnZiCOeRHNDTeWw6/yqz2a5Nkmmf4a1kgsvZ+/VDb63+EFGq7Od2xh25mvXznwfoDsQjzvk2yMSO4PbtjzmkGFdJKvzV7Qne93JuVw==;31:ehBQT5zqf0+CjUkKLFNSMXIVMjDtrbV2qOIbK0SASrqBbJV2sFubx3jKyUoCnmPcYLqWveROFkv4L1N/kfAWgH4+c4pCAAaxFAv9PpRPfHVS7xYSobzJIk+O0caS/MOel/URpXhn4KGu9ZgX4evTDIf1IDntSyh3SnmLhNPT1YAaP4j1BG5e2epGMPH300EwN+DtrC5N8gubP28FIuY8uZuOPmYD5bEQq6MVj8Sy3QY=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:YhL783JlKKmjonARO5Eyr5Y0XyiuXZE0xo4evX5aHc40zC5na3S5ev2rsm9N+Z/DouYGnoBCk1crKRvLArOJfJd6QZYft36b6FFjGz7l7S5C81+zeHWTdQ5viSylr+kok8KzgfWr2F1ppuTooJJfkMVMZuDRNCkBkXkipdCfSTsKibvsBSp91nIxDt79a0RdEiMe1vcWkV3ad+Cdl5PpT8lwrQuU+PtumMCncj0aDjuzaRevcwM17NcQ+YW/vRTf6lezuBm6iPJBsefvBdnvlEsjJcJamITKjl/IwLSH0ajVy4uYKRV0BIVzRnl8ZvY4DMloJlCMjvBkKplKdrsZFsw87xnPhwqC6hLCqURfdEdJx14/AUdgMb9+eo1l5Mx79MkSBYvm8FTYpoIj6PUubM1gNoz11mEBA+TzLBbR+gEHITdIPmgR0qeZAseQWeo1Jk+EC4oIuWlMhVySvmUiJIqgN03hn1x/t/CYnrtfZtt29b6uhBVOgu3l2k0bJzhR;4:lO1xE3Dm0mLGUSmRHEeW/dyP7sIhDA9nzFweJDCzhZDB8Ml08KlFD5I4cYBvXuPGasH997ii0/hHqX7XHUrnyjoLFKX4hqzyFOxIyO1WrVr7X/aB07DK/s19QLmSRn0u90Of0u7R8EOP9B4qCZ7YFPt2oxLIRjn1Qi8j4TRbhBroSyJfdAnC2EKf4OLFS0J8IvJdmXHKLpNXuXc727co8odA1PtDVgvsZj3bnbr3y4zgLR4EDtQEvuoVSv5D2Fj4IhYNjHAw1ZEV5SVynYBfp54Bg9d5908945a2m5q37D2Twe9OlJxDgmWbabSNpQ19SHXGztcql6PeeuQ/koMqKC5CvuuZ2tWTSZy7L4OaoZk=
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081A010152C11DFD9B07D8FBE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(575784001)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:7GxijQgRDQXvlmUgRJddwZwDLaNVkVKvUUeKCyQcY?=
 =?us-ascii?Q?QUNuVf7eMafizA7t69cIc/mJ3rhBH7tSt389HSexwmpiLsqH/t3k/Wm0LF5b?=
 =?us-ascii?Q?bGrff5lnpPlGbTx1dwRkUzBJItFAjVnuFWgQXg8z/NWyn7ZDUn4dM/oGTTKQ?=
 =?us-ascii?Q?JtKhGCRWlKFzkNIvyYd2P1LABHrD3AKv8YMVC9CzN0dPqgCuaqy2CzMXqzAa?=
 =?us-ascii?Q?IPvW6xAOiw3tsGjXEGIQLsAh3fApHX9feg05Yi1Vi1SH7BMk7Ziph0zfLj+X?=
 =?us-ascii?Q?v/VCRCpO8R1ROGVvkTECUb5Ru46Mii2G92vCeLiNmdi140nr3j/0Txbv+JTA?=
 =?us-ascii?Q?tyYIrJ0mxYXQpuVZALVnS5e8TURR4z0Ei5I9wEV3Kwj3Bv4dWU4AzRc8ej/B?=
 =?us-ascii?Q?eQI6W7FByDlzf1hdrqCkc0aox5jTNV8U4p2+DxIAX1lo0U7ZkI0peI/4P6pU?=
 =?us-ascii?Q?fTQWq6ZKswInWQ5sq+qDflii8RvRTFGogOPrxXb7lppmBwg7UoFIxe/a3IBT?=
 =?us-ascii?Q?uGFPf2VOLyiUjMaPUPdEUKqHO8O9oiIDrT3iYS0s7jg3X8IiIixxcLaeQj9l?=
 =?us-ascii?Q?7XkwhUknWCCgmBqyYR1Gpy9Oy97/KNiIvcOWNXeDKEFo9M9vM7QTiJLlop5Y?=
 =?us-ascii?Q?SUNXramv5QdeRWa5eLbrIpQ69D5EoRtrOrqYXWdZ3Z6sgNM8CxqfUOgM+M9T?=
 =?us-ascii?Q?A9UB4CVI6yPtzfM21xN/9gDvKhoMsWw0Q5qIZMqWGgz/9dDJOrNGFw2hzDtS?=
 =?us-ascii?Q?plEwrgV/uhk5woUo221bTLw7HGyiqlAyA+sMKJSIdGQ6J5li1SVX/ATNytar?=
 =?us-ascii?Q?4dgVwciu1qBP6MfLFXOCbJ7a8DWmpoqzGmLHYTmF2nZLQZhDTssmhmNz4oCJ?=
 =?us-ascii?Q?Tx4VMwJ0bP0ualpd6VNx+scQ0p7ZcO9/pxo2wN4+ibd2TuZp+QKANoyA8JyD?=
 =?us-ascii?Q?F+TYSkymxF5ab6G5DWghf+7Ts7m5xU7ZuVPxDBUhsnE7PynSoxo2v1+t9ci4?=
 =?us-ascii?Q?+/FFaOXCxbKL97F+Dxpsg6ScWRxJohhwK65ZJcYjzlY8Tq2x9lKXTTqaYp3y?=
 =?us-ascii?Q?od9frICLh0k0VC7m4yecbsejbrCP2WMlde6jvR9g6yTJUBcD/PjuBUFqLE6A?=
 =?us-ascii?Q?zVGN7jQIKEOv4rV8wynR+csuSIOiOFJNqJW2xm5tNUZi3hLwnv9qw+UCJe5m?=
 =?us-ascii?Q?uwIjclk1WrXWbcZ1xt3ryeAW70hCqNiNdFmNgFfObwHwSdoWE3Nqw0gG+kfc?=
 =?us-ascii?Q?y8G38JpzlzQHhJ5JvQ8mgyrgeetx03jSfzRMaQDQWZOk55Elpd8iEUGbEWTg?=
 =?us-ascii?Q?+qpWaqKfcMFLCvC/rhCW7M=3D?=
X-Microsoft-Antispam-Message-Info: gar9eREDm0+ioB8wGw3CN6sfio022PAVgXII4JBh8/y++yZPmj7fz3A1ZXCUxJ6qEzG0R435sYBudjAJ32CJGJruoZfoZGXgaoE6gX1lzf/hGDmZj749SQao8tLVO4W365TYEYq8MXnzGn2cSFq7mKxwM3KqQJbU4+qczD5cT0H3/e+Y1ZyMIQCMClF24LLZL3SzYmaAxjuUriIZmid2+AB4Ylb/VD2xvuOP5TWoA89q2Xut1GagdphmHGIz1gnqVxV6JsB3F6c6P15J0Ne6T3lmvB1BYrBmECSxw/+qUsOuPx3w4RfZhnKR8YTZDrErwUtW+Ez9JNnKe5OPJFcTb8jXqjznhAHslwrVtALyM2o=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:DTH6OHcoEkfyka05SbbigUSqbhw6+TT60tz4Hgy61DAn2XMqL4SvHuSXnW2vtMLfDUimTJT+AIFHXzPRmvqXbtnoUQVgZiamo/kzSdt6kYRdEjF2/QQhUP8uQ0rym+c9qci7A6tt2Yl/5kZQKPUuUHgxcRcfTzDbMVqG3+5tWUEd9H5ypjhbGN13pgqpIR8LF1t8TZ9ZO9ayJwrwkNZh7AdiKlalVR9fIW0jLMgiHizJpWdJmadbLOgxqQ9jFMXPjRmJMfy/2WtMXX9wEVDQC/yk8tDVVBoZ5rvP7v8mV/PIxJfIIgmhpHTp/yenZsWfQUBxPfhIHbF4jUgZf4nD/Y5iHzF69p0MZi6uCR82yIPkWxDvQQ2xFtIod+SGMcx+B+Mh2AjhmMcajGBkoj7W+bsrHBa2MNLvc397infAvX1H2dHpZaQVPLZO7uMXrGlfNmcSoX6ooaY2AxGDvxFl3w==;5:yf6Zpd/9sBbr9VrncfEkIDutlXbSEoC8TJTsBne/wzMmDbZJ7f22m/YxpOFNgmGwZrW/W73u13C9O4J/ICaITo3n1jVueceehx09bQqTgQr4zPe1YW41wcAT+wTpHuPLKF56ykOCiJOt9v7ndga3i+P2I1VfWYNRlnGtwquoSzw=;24:FO3x9/wHMc0igcq7jrmJvQn5DiwKxy0aD6K3YfIWJYZwEPcCVjuDjISoa4kg+dXgHLNLIZsIoj9LHsoTPwEEVBv2Q7U2Xh98/KV0gZgOk/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:bp7Vc9YwohG9O9Dx2u9ZIYYn1lDXski1WXa3+kpM7ucKA7wdxNgQb5T3YjjfMX8iWmoRw1dy2uf2vi1jbucIrjvM2Ew+KLVn5AElKN1gsVY35MKAQ4pbNVwI+KkUtedeOzGRHMOTYyo98UqQej59S1PVKNgjcy5AszPej3rCR3ExcbljysPcbvE+iIyw4ZsIAFiu7tOCZc6P52Ur8Az+Zb1duev9LVRcbJmtTf8i5rmW6r3+FhLqOuzEx2B1UkoS;20:+MWQZ9Dw8lHIajtNIQm1i7BMVD4REwY1+Me6j9a81H3kkZ5JA4j7Oyu9kcxWulIxijMfP735GhCjtI+OcvqxMtpAi135amcBjJ08dCTKG8rUAB9ge4foG8e2azIn2kb7R2/+SOPtSI4xhCbIpp+hqH805O3JwrI8tzAzODlny58=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:04.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195db4dd-2795-4c30-cace-08d5dd16eb6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_get_local_storage() helper function is used
to get a pointer to the bpf local storage from a bpf program.

It takes a pointer to a storage map and flags as arguments.
Right now it accepts only cgroup storage maps, and flags
argument has to be 0. Further it can be extended to support
other types of local storage: e.g. thread local storage etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h      |  2 ++
 include/uapi/linux/bpf.h | 13 ++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aaaa6d7e0dfc..1fdcf9d21b74 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -771,6 +771,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 
+extern const struct bpf_func_proto bpf_get_local_storage_proto;
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7aa135e4c2f3..baf74db6c06e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2081,6 +2081,16 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2163,7 +2173,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 14a1f6c94592..47d4519a6847 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -629,6 +629,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 73065e2d23c2..ca17b4ed3ac9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -193,4 +193,24 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 };
+
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* map and flags arguments are not used now,
+	 * but provide an ability to extend the API
+	 * for other types of local storages.
+	 * verifier checks that their values are correct.
+	 */
+	return (u64)this_cpu_read(bpf_cgroup_storage);
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cc0c7990f849..a0f5c26fffc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2127,6 +2127,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_current_task_under_cgroup)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+		if (func_id != BPF_FUNC_get_local_storage)
+			goto error;
+		break;
 	/* devmap returns a pointer to a live net_device ifindex that we cannot
 	 * allow to be modified from bpf side. So do not allow lookup elements
 	 * for now.
@@ -2209,6 +2213,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SOCKHASH)
 			goto error;
 		break;
+	case BPF_FUNC_get_local_storage:
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	}
 
 	regs = cur_regs(env);
+
+	/* check that flags argument in get_local_storage(map, flags) is 0,
+	 * this is required because get_local_storage() can't return an error.
+	 */
+	if (func_id == BPF_FUNC_get_local_storage &&
+	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index e7f12e9f598c..42e39e0c6c80 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4652,6 +4652,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4674,6 +4676,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		default:
 			return NULL;
 		}
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4696,6 +4700,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static const struct bpf_func_proto *
+cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	default:
+		return sk_filter_func_proto(func_id, prog);
+	}
+}
+
 static const struct bpf_func_proto *
 tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4816,6 +4831,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_map_update_proto;
 	case BPF_FUNC_sock_hash_update:
 		return &bpf_sock_hash_update_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4835,6 +4852,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4862,6 +4881,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6664,7 +6685,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

