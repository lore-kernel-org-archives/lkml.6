Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E69276BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fQD1PTnD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="StsmIDj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E69276BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935741AbeF1QsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932809AbeF1QsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:17 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5R013501;
        Thu, 28 Jun 2018 09:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=mZL6RuR5lFwRI6esKtnX9NLl4D3N7yaT6z9WNfMdweY=;
 b=fQD1PTnDP3pndaFPrDv4ixun+JNIjnIf+onsAUWBhRFK8w8DeRqlobGnFOragl6RXO1z
 Hdm2Og1DssPn9THYMIHXEUnRW1S2Av8yk+ztKFKsCcjx6gOMldcfX/aaeLUGVY8FVsqo
 PJAaWpqXCknD5hbC+1t6kXSXn3aWe53hk6k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZL6RuR5lFwRI6esKtnX9NLl4D3N7yaT6z9WNfMdweY=;
 b=StsmIDj/3nORugMpWLCa8PQXsXFc5Kdv7eGXylYigyouMTCGQFF/qWA6TWzV6TJDJvgtLDcN9k/hT0eg44dHdRwt+1aHRCQvE2x/xnikuBdX0nl8PTUTzix99cJaJTjLh8hsvZKh6QnzgyFWnjJezuBYDEMzMbaooTRFdePwJvk=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:47:56 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Thu, 28 Jun 2018 09:47:07 -0700
Message-ID: <20180628164719.28215-3-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a15fbb6-54ab-4aea-2ec7-08d5dd16e6eb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:aEItz9Mh0T5sfjtbU10mRg+VkOy0ZoRN8No1LbL6SoiyBN43rn7rnKtBeudkZ4yLlwE0koqvVK4W75QTibWDuy1jVVZ96d0NzsH+K53GptQiU1236zILPvU2AuKRycznfUcK2qnQ/IOrjgcHmzDNfzc6EhLKA/S6qOkfFX1fgSc/c5G6wbxbHgvN5Ezj8FSJ3ws8KG3ylUBKhV6a9OYsObMM6CHnSeQDz2W41Smjrl/rFzHW4OhwUKCBnYzOE8uJ;25:7VKKZyPskzgQW7JUibM/P59trFjUAKpVmJpIqdnxG29JrgfqwqXgP/yMZkizcynitwYXQgBpMESBURWHw3AVUtwYBWmAk6ug5eSlC4Emk9l1xw/LQh7XHbYqzUgVvrKUy4YSLEgznQJxclyfjNq1VE9uw2fhlZ9Pol8M2kSuro3OfwQyr8l1XkakwRoZjJVcyR/hsPU/xUnHjTjDEfJBoqI84lK6k3awZmnEN+s2ny3S+nhHdXvGQws0EclUl3xglSMjmZQB7H4wasbL9xrW3yxQTBxX5RR8h2jBj8SBKgHaHHyAvrYP30sBfTyd2CB8S96pT3F+1V6hdjmpDk/LwQ==;31:sFFj/DcDxaPNBHFWlijLzhKh2seGopDODxK0SSWk4Gsq7zMEmaBhPCTLtsZQxghhTNPxLc1F/HsLp07szXp3CGUywrsw1kBDDCi8PYYlY+RRvPgrntWraLV1zxlDYL2Xojt/ueQenjc296afdQSH2zxd7Sf1WeD01AC8buVc7MvBwFI+uUaCGmbELqoBDaG2Vp3khxR9BMnc/aQc3fsqBQFcwFhQtzqTbHkkxtGCtEo=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:WoUeHnQvxSYtCCHyPdKFnV5MOb32oVH3SXixoI5Vr9XGQunJWUGdoM3aPgn+NygHj/DdUUyQJh3kMP3ZL+pktcIybyETqGruSrRQS3Xe9fZRKkBqLhAX11+oHJ5EfAbclJeKtdYPtZnkPVxyZ8JAP74i1RnU+eD6CmtXYcdCOpGFixQHUJe5V/VxOD15LdPFjIciNsrp33fk6uaSK0crDR24NHRIzV+K1nfggtLzdEQ3VGrw/GNMVFkvTtWaTsZseOjblC53KE+DDsABrdnJb4Dw+mjVjN1A2Katyq6D5CiQQA8EpLIe6jTd/xowIuF01UTKAqJCUyGz9L/f8bZjrf7eSUT+ewiiN7Qi7Mf7l+15Mh4xqeyOFcf45+aoJDjw4KrY65+oYoiJpsbw7o7gsr0xZgdQsliUg8s8bCh7RZlJVmPpT+FnEBapCE/TWBqMitS1IwUngAvkiJQ3av7r9xW+UePkqKJhNLC6qag9nA3sCfEZMsaU+xqeASxD+eto;4:YXz9sXlJmjca0j2dvqZ/T/JKcJsjl+24oO+mARb7P3d6xxs5qzIcPLqPQbUly4gMMJufrJYA7yMJ43S2dFJm+H5LTPTkKNj1sZeWltIMeIi8ftNWDeiURVmcHmGoxPHILjX8YebnqKTn8auRI4OyEIVpdT2OBbyAb8+ofsanGJLQWNeSyRzfXUV8i5kaebIqRI+LHltOiCAsuDzCkGRbb/C7fe2VipGyBra1Sf4i2geiZgVtjPw93DNBOSbQXy8aQyn54G7gFTwGuW+zlED63XsfzB4FEowatJ30sn2VZY0Hp2hw9BiRucUur6FSD+S6iuQhQudjl25cn04xZJxzCw==
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081177F20CDC3E0C79B810ABE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:1AjAbjVqRNoArP8SroqH0fKOzTqFEFhp+1PE3efwf?=
 =?us-ascii?Q?CVrh6xvi6cjb/8J9OCHJondscxNdlPM45UzygQNxn0lQS8c3duxhv4K9QyaN?=
 =?us-ascii?Q?T3Ba9IHmbOb2Dfrfo99RZ+dT6mISR0YQT3r8/HAuwaNEQLW37G1HqJ+rCDjp?=
 =?us-ascii?Q?1M3AUE/l4k0ZJQbDgOMhWF0lqBXXCR4c9nvi4F+fmk9UcHhfmqzEI56e2J1g?=
 =?us-ascii?Q?+7B5N4sanmZIq1PUEn0XhniMQbzsl7u0fnB5dBbgyi5BV8RE0f694Nhrgvds?=
 =?us-ascii?Q?wLCalI5yPU2n+B03sDC40l3mN+qD5lMplWlMQpw/PjTuSsZQ7c+5yk1m4l4Q?=
 =?us-ascii?Q?jI+UssBA0wvLMKDkdJ/vY+hp3PVJcUwvME1uoo8nxBB4f5/Z7dFNL8IKcGLX?=
 =?us-ascii?Q?Yl8zqSFnJtIV6jdyeK9/Bz+jnmQrba6kNWcBIuPxC8mSA0QSEzt0QJdbCich?=
 =?us-ascii?Q?z6+Sg46QO0NfoOJjOqg9odhm5FiamlCYUmEwBwEs6norRSq51WSr2Jlug3hD?=
 =?us-ascii?Q?tajrs5hW3tKnhJRYrlWdG26rdllKfWBdppFl2w07rKidfXNaJAXqu6rcAruX?=
 =?us-ascii?Q?vqAyr3/wpqFgWBgzFo5uGB1dZgQvwqk8AGGoO2YRZRQBttnVVHKoSvwi8l1E?=
 =?us-ascii?Q?3XJAFGJ0sRupWB1/c0/yph130rDW3FZJzU3m0D8awdV86pOPb/9o+afniAZ8?=
 =?us-ascii?Q?hu/WeA5BpDw0mZSqCDdqwsphL6aDDd5vciv78CKrhd55nYjgUdfq6IeEOJkV?=
 =?us-ascii?Q?tmhjfP/dcUUToIIEVmvQ1o5b3k67oVtn+zszIokwsmuepryOJym7erglRtNQ?=
 =?us-ascii?Q?tbQMMK9CSOCCrGpmsOs82/BPHVZmzMBfz1rCDGCfvSrDjT2/dhz+jbQ8KhJg?=
 =?us-ascii?Q?x10FdjcURMpgZl4RvwMvwnhy9IMzndT3nOQ1iWoplQOQa1Dd1Q4s8PvvRK7/?=
 =?us-ascii?Q?qwQLk4LRLQB1UF8vOl2GDrZGXXxGRMSKCCTdGb6v9m3Wf+q1XwtCSpFQfRLm?=
 =?us-ascii?Q?LlFdV9WJqFdaN62pz/TrQrY0o+UCkJJe1czXqqcTrCDrz90hezaNlAQapL01?=
 =?us-ascii?Q?M5R/6RbUoOmX58Gq4OKcGPtO7EsYstzkU8MutDTUyVrm43ZM2AGHiioCtYFm?=
 =?us-ascii?Q?D2L0kUdwkIfEk2n+VfosMKzscn9vfYGdefkbtQk7DOcONiVdSIJCOpFMl2lP?=
 =?us-ascii?Q?+UPc8NTu+QDiNSF33g5bhTPo47VuUPsOmdxUMS9KwBWZe9ZSQVzLeEJB6aMF?=
 =?us-ascii?Q?8FMbZB0N9pPaN2F6DdRSOBoHZ8QZljSHDQBT1D8N/Yuzrrax/hMf1Die+MJU?=
 =?us-ascii?Q?V/I1ki6kYGL8yreS+NFFJg=3D?=
X-Microsoft-Antispam-Message-Info: 5GZimjQu8MwBUeVMneuD8gKiSXoxreT8OuiZGMo6EjJmMi6bCYCExAvqDn0yMGHUWi6SqFa1HPqdMDrw3Fp0XM+mRXPLK+x1TJbvHWkJCJwwdLdaKWhWwwkfiTTHnFQViC66HI6G96GgbLCUsNATmlNnyE8WU/WQTi0Fi+tDJIWN/roGb+zX4Jna6cmWRnMX1v1huGsgjA/4QinLKDXM+3lKbgGKbVRX4yK7tepMe5izdzzenbeH5RGlVlJRSz1Gr9Rf/2MZPj87QNTrO6ytAIRYmznqTwIx67d6CqM/Ny+ssheadEb+Cn99Vdbz0XfLDsOWuIeR/gJEqcb7j1r8jW/tyImhEtnC1QbJw21WRTI=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:8uGJ0JEM9+FSF/ql8J4n28vclKHbuegzQX/I+UtnnTI9XHNJ+wQT9lcWRmmokdztyg/OY78NLlBHCtk/vPPEfqiRsdjtQEWlrl0t04dbnph2OIc01aEq+T9x8taui/uT6GYIdSz4HIhwaNUOAIKX3J6WX7P2srpwUkp/eqEbtOSJZCXiJafNTlCJzNmuqgAJK0vgmPzlW82qNek6Rt/jq9x4enXLNnkWQ0u/c96T9ehskIyUxxMHiVEAz999rCYpsxgNiJHNWg0cAmSdgH/rb9MRwG9gk0bYzAjjSgfpO1qDvqAPiyyqwLz0m6iixCPLUP6VQBiHL2nYgHmSzM7czg3TqfdN//S3OUCzYHNgfUEW3fFXYZ1GcTZ38qVyalrR8pxrA/hPHwJDLais8wPocpjwEB7NDOlmhTlyOR8SHSUbxIentRS6A1rRGqaI7NfI5vCUKEiUtVttuJecK4IDIw==;5:TXKQZYjH0v0m/w9EpoB2twp0V/D3AO2FdKo7CnYCdZkQ238Axgtz5jOYdmjfA4UGS2C2Ggwl7zKps+WXnD8MN0Ft2WW4La7wgDpv+baBhU0oqCFHat74tOR4k64ncCHLtetiII2S26Q2Me/jyiOZAPxXP4JjrDdS6H5Q5jI7k0M=;24:+Iwdwbn6HsffwYQ3Tw/Aqg+QbLYgr82jBoEh5smE9O2gUdc2j70yQIf+eelATwL3XC+PJ9QzlPqeBvKDRcOa6sUOWx1Tb+xMvZI0e0FhlAI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:5Y3oaNEMiEyL0TwdongclfMfFjmhhAiCpiAJapKbFUs1m+7NyY6C4PVmGnCskzSzqV7I8sa1iGm6H3z8Pal2OG6e9JvsofidpDqIh0QJYucob7x4x/IZj0ElArQsEQpm7vU0sFT0kGOof3Bz1AKKdNKQ4dgXOhgnY7Ao9nRFeG0E8iuVPy4o5D5an6OubKpHMGGVkpqhljH8GuMs/y0xV+QFZ0oHKsq8YnpfNQzQgA0I/IPH6+TQ4c+T+xVbWfDO;20:o4oJXJbPKNeAtgYwn5CCBE1pqag7bYfJcxRNMWz9sStSdvIFFDp1H9z/I81FGXzKWTZSAEff89eHsXJiCe30f0RO+GII6GYjDZtbHQ21GOK4U/ZtWuCGBZRvWu0WoJlYLcwUTxlO87uSOOa5dupp89MqYelGxSZ9sGZNWGxqRwA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:47:56.8640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a15fbb6-54ab-4aea-2ec7-08d5dd16e6eb
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

This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
a special type of maps which are implementing the cgroup storage.

From the userspace point of view it's almost a generic
hash map with the (cgroup inode id, attachment type) pair
used as a key.

The only difference is that some operations are restricted:
  1) a user can't create new entries,
  2) a user can't remove existing entries.

The lookup from userspace is o(log(n)).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  38 +++++
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   3 +
 include/uapi/linux/bpf.h   |   6 +
 kernel/bpf/Makefile        |   1 +
 kernel/bpf/local_storage.c | 367 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c      |  12 ++
 7 files changed, 428 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 975fb4cf1bb7..b4e2e42c1d2a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,19 +3,39 @@
 #define _BPF_CGROUP_H
 
 #include <linux/jump_label.h>
+#include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
 struct sock;
 struct sockaddr;
 struct cgroup;
 struct sk_buff;
+struct bpf_map;
+struct bpf_prog;
 struct bpf_sock_ops_kern;
+struct bpf_cgroup_storage;
 
 #ifdef CONFIG_CGROUP_BPF
 
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+struct bpf_cgroup_storage_map;
+
+struct bpf_storage_buffer {
+	struct rcu_head rcu;
+	char data[0];
+};
+
+struct bpf_cgroup_storage {
+	struct bpf_storage_buffer *buf;
+	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage_key key;
+	struct list_head list;
+	struct rb_node node;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
@@ -76,6 +96,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type);
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -194,6 +223,15 @@ struct cgroup_bpf {};
 static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
 
+static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
+					    struct bpf_map *map) { return 0; }
+static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
+					      struct bpf_map *map) {}
+static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
+	struct bpf_prog *prog) { return 0; }
+static inline void bpf_cgroup_storage_free(
+	struct bpf_cgroup_storage *storage) {}
+
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e4d684ce3f5e..4b3e42e5b6d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -281,6 +281,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
+	struct bpf_map *cgroup_storage;
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c5700c2d5549..add08be53b6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
+#ifdef CONFIG_CGROUP_BPF
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_LRU_HASH, htab_lru_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 59b19b6a40d7..7aa135e4c2f3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f5496d6fe..e8906cbad81f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -3,6 +3,7 @@ obj-y := core.o
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
new file mode 100644
index 000000000000..940889eda2c7
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,367 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf-cgroup.h>
+#include <linux/bpf.h>
+#include <linux/bug.h>
+#include <linux/filter.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_CGROUP_BPF
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+	struct bpf_prog *prog;
+
+	spinlock_t lock;
+	struct rb_root root;
+	struct list_head list;
+};
+
+static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
+{
+	return container_of(map, struct bpf_cgroup_storage_map, map);
+}
+
+static int bpf_cgroup_storage_key_cmp(
+	const struct bpf_cgroup_storage_key *key1,
+	const struct bpf_cgroup_storage_key *key2)
+{
+	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+		return -1;
+	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+		return 1;
+	else if (key1->attach_type < key2->attach_type)
+		return -1;
+	else if (key1->attach_type > key2->attach_type)
+		return 1;
+	return 0;
+}
+
+static struct bpf_cgroup_storage *cgroup_storage_lookup(
+	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
+	bool locked)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node *node;
+
+	/*
+	 * This lock protects rbtree and list of storage entries,
+	 * which are used from the syscall context only.
+	 * So, simple spin_lock()/unlock() is fine here.
+	 */
+	if (!locked)
+		spin_lock(&map->lock);
+
+	node = root->rb_node;
+	while (node) {
+		struct bpf_cgroup_storage *storage;
+
+		storage = container_of(node, struct bpf_cgroup_storage, node);
+
+		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		case -1:
+			node = node->rb_left;
+			break;
+		case 1:
+			node = node->rb_right;
+			break;
+		default:
+			if (!locked)
+				spin_unlock(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock(&map->lock);
+
+	return NULL;
+}
+
+static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
+				 struct bpf_cgroup_storage *storage)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	while (*new) {
+		struct bpf_cgroup_storage *this;
+
+		this = container_of(*new, struct bpf_cgroup_storage, node);
+
+		parent = *new;
+		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		case -1:
+			new = &((*new)->rb_left);
+			break;
+		case 1:
+			new = &((*new)->rb_right);
+			break;
+		default:
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&storage->node, parent, new);
+	rb_insert_color(&storage->node, root);
+
+	return 0;
+}
+
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage)
+		return NULL;
+
+	return &READ_ONCE(storage->buf)->data[0];
+}
+
+static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+				      void *value, u64 flags)
+{
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	struct bpf_storage_buffer *new;
+
+	if (flags & BPF_NOEXIST)
+		return -EINVAL;
+
+	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
+					key, false);
+	if (!storage)
+		return -ENOENT;
+
+	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->numa_node);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&new->data[0], value, map->value_size);
+
+	new = xchg(&storage->buf, new);
+	kfree_rcu(new, rcu);
+
+	return 0;
+}
+
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+				       void *_next_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage_key *next = _next_key;
+	struct bpf_cgroup_storage *storage;
+
+	spin_lock(&map->lock);
+
+	if (list_empty(&map->list))
+		goto enoent;
+
+	if (key) {
+		storage = cgroup_storage_lookup(map, key, true);
+		if (!storage)
+			goto enoent;
+
+		storage = list_next_entry(storage, list);
+		if (!storage)
+			goto enoent;
+	} else {
+		storage = list_first_entry(&map->list,
+					 struct bpf_cgroup_storage, list);
+	}
+
+	spin_unlock(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock(&map->lock);
+	return -ENOENT;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_cgroup_storage_map *map;
+
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->value_size > PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+
+	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
+			   __GFP_ZERO | GFP_USER, numa_node);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+
+	/* copy mandatory map attributes */
+	bpf_map_init_from_attr(&map->map, attr);
+
+	spin_lock_init(&map->lock);
+	map->root = RB_ROOT;
+	INIT_LIST_HEAD(&map->list);
+
+	return &map->map;
+}
+
+static void cgroup_storage_map_free(struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	WARN_ON(!RB_EMPTY_ROOT(&map->root));
+	WARN_ON(!list_empty(&map->list));
+
+	kfree(map);
+}
+
+static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+const struct bpf_map_ops cgroup_storage_map_ops = {
+	.map_alloc = cgroup_storage_map_alloc,
+	.map_free = cgroup_storage_map_free,
+	.map_get_next_key = cgroup_storage_get_next_key,
+	.map_lookup_elem = cgroup_storage_lookup_elem,
+	.map_update_elem = cgroup_storage_update_elem,
+	.map_delete_elem = cgroup_storage_delete_elem,
+};
+
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog && map->prog != prog)
+		return -EBUSY;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		return -EBUSY;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+
+	return 0;
+}
+
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+	}
+}
+
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+{
+	struct bpf_cgroup_storage *storage;
+	struct bpf_map *map;
+	u32 pages;
+
+	map = prog->aux->cgroup_storage;
+	if (!map)
+		return NULL;
+
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (bpf_map_charge_memlock(map, pages))
+		return ERR_PTR(-EPERM);
+
+	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
+			       __GFP_ZERO | GFP_USER, map->numa_node);
+	if (!storage) {
+		bpf_map_uncharge_memlock(map, pages);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+				    map->value_size, __GFP_ZERO | GFP_USER,
+				    map->numa_node);
+	if (!storage->buf) {
+		bpf_map_uncharge_memlock(map, pages);
+		kfree(storage);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->map = (struct bpf_cgroup_storage_map *)map;
+
+	return storage;
+}
+
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
+{
+	u32 pages;
+	struct bpf_map *map;
+
+	if (!storage)
+		return;
+
+	map = &storage->map->map;
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	bpf_map_uncharge_memlock(map, pages);
+
+	kfree_rcu(storage->buf, rcu);
+	kfree_rcu(storage, rcu);
+}
+
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type)
+{
+	struct bpf_cgroup_storage_map *map;
+
+	if (!storage)
+		return;
+
+	storage->key.attach_type = type;
+	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+
+	map = storage->map;
+
+	spin_lock(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock(&map->lock);
+}
+
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_cgroup_storage_map *map;
+	struct rb_root *root;
+
+	if (!storage)
+		return;
+
+	map = storage->map;
+
+	spin_lock(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e2bf834f13a..de097a642c3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5140,6 +5140,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
@@ -5148,6 +5156,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			map = bpf_map_inc(map, false);
 			if (IS_ERR(map)) {
 				fdput(f);
+				if (map->map_type ==
+				    BPF_MAP_TYPE_CGROUP_STORAGE)
+					bpf_cgroup_storage_release(env->prog,
+								   map);
 				return PTR_ERR(map);
 			}
 			env->used_maps[env->used_map_cnt++] = map;
-- 
2.14.4

