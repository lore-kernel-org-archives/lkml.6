Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52937C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E719F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z1Wf7pXM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CVTtJZ5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E719F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHVA63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:58:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50224 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbeHVA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:58:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LLYGVk010571;
        Tue, 21 Aug 2018 14:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=sjNTnG9VNjXa3jh+emY2eBDGTtdLI0WfMhnhtZC4Fks=;
 b=Z1Wf7pXMvzSjdOdEMiT/E/d+VCZfQJqx+y4yvt/YLA7EIbiHxLy9A98GKQyZuLXsxcEZ
 Up7397CAwRgr1OtmNQexdC4KT9wZq+qPUPrTerGWchtXE/+JZFgZKapq8VQ/1rWI709h
 V/g57SHJIP/9qLKTpkQUQYhFrvWLvJuKZ3Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m0ssj05p6-12
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 14:36:27 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 14:36:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjNTnG9VNjXa3jh+emY2eBDGTtdLI0WfMhnhtZC4Fks=;
 b=CVTtJZ5yVnNinEavJgLGDmsBy6S7D3WqNVe6n3w2ClRL2BWAMvwBp4y+iMx63Szc92Np8EgbduooNtwP6TvKjur5e9HuOEaHeBOMRDIDBIYlGXR9J+F1Oz2WUZx9ujBls40J4U6lLFLY6y/GA8VDADydIpW5ZY9jVsnL4eXQJnE=
Received: from tower.thefacebook.com (2620:10d:c090:200::7:b0bf) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 21 Aug
 2018 21:36:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Date:   Tue, 21 Aug 2018 14:35:57 -0700
Message-ID: <20180821213559.14694-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:b0bf]
X-ClientProxiedBy: MWHPR1301CA0004.namprd13.prod.outlook.com
 (2603:10b6:301:29::17) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32584ca1-365a-477b-5fc0-08d607ae2003
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:tgCPoof/SYN9Sk12hWJ/AB4u2UEj+8JsA0iXHsxOWQS7fI6jM5H+osnpNr6BujSUd9nk/JNYK1Uxj9k19DW1FljmLjU8R8inRnKdOhHI9gFJEbr7UDwWneUNmzPRNN/SDNFraTeNqHHwRtzudnZPnRftQp8nCQ6fbPPbKYMk2wKbMbWQDDtVM7fnKtq8xs0JiIN78+HAlR1xK3IsorTHCgD/0+NtCpJY+vKuYLHNIzlwqx/7t3DsZYbkrCCF0lmP;25:Gra0fB8batYaxEjUY9/vMlu//vz7FNn/8Fh7IMJHRBgtdxUrrV1w8MhdMeMurUi3gm8qlWAE3WEJStgXTyb/csWrDq1draEFQeTGk9Ai1GaWIvTZuC1fKTlW17XUE+6PJjvpBSxcnDfjHiKEYkormV6J1S/TwF/CtsJ1IS0v8Gl+dxrWVM53oNATOxuRn66E27ipjev8urqfYsWKTF87Kdf+4x+J1wpv7PFjL+pUzLZ2PUo+u4J3T/4ng7OecrUOlNoh+6LbczsxNqiGU1Sbth491Aynkt3p5hrWZIhu0VuDnTNm4DgyBsnvQ0SM14lVVQBw/nPkVabLEdIYD4KfCA==;31:IEtIgeOmtuqNdLvQtaxwl1K0mbDK6TI11RGxq3nZV1pwG3vVwG3XDWFZ78gLw87Of4G5opXblF6sefDNey8RAumWByHSmqdAiagywyi5ObyDgGVMApi+IYk6fCp0fSTmuV2fVF53EWIXKp7ckhe4AndKSI4SBYMI43u9LXpdLaAQ/9fEXh1albNYKtemjOCJhbcAbupK6Vtgm7dS1qK8nF+Euz0BtmbCipwLurdM3DQ=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:m8uRvxeukJFtxyc96wzVrIStgz4dCprSBl1pfs5/x56lbP+/FQI7euC4j8HIbTFlxRQ6rnFAWqEocIbzGFQDp3dRazpXEr8I6H7JsN++q8xDxmIxgZjMOWQUKRNQrIiujt+ohVDnGwy41G43lkoGWwvggo5wvdKnxp3nSexPqk4mLSrhL30jwXb/ZHS+/43K1EgBOVqOkhF/tuZajLD7U6fpUi1G95i6pmbAfUWJN6VxvkO8AJuVI0hOBonD9Sxyd1KjO9t0UV0jWqbleZdxTNHd9DZSgUy38oni61d0X6KLjrX6UlAQdppWV3ZHXcCg/OOqWGcUYONb0p9wCJGwQiAqtgZt43nHV1S1QyGBYu9izN2LdZ+vWBmw0/ScGDxEk82YOppHFnX6SYjRlsqMMgFLou3IbXzyRUqiLUBVwdgwyrIBsQSvw+4AkMVDbkAZlEiinMLBTg4hnY0shVmAbtsg+VlLTAFwexBbMlZTZyMNru4nr+4U4txneVHTdn0r;4:55stgnN2YYskx0nvMTwXkBmuTEd56MPytlaRhuL0gEval+frIrrc7GVKsZCU52o9OjMg7KZ55oZYtf+EFbSpwtP29QwIiGknaIKMyicaR1+Gb3M8myVZMxGwgK/0r2HJf1iwFz71aCvT7270L5dZ6p3eKzsSfluEQIR8W/UxUEYJZWhNj7By/EnLL4ZKZMGpu0Vbh8wJEIsTmiN4suXg171QXdiDfSkrQPVxyVX83ZLrOYsa18fBMv6W79hAH4XfjDwZqlJPv6Ja9+kX9eXBCHXBpz1tY5EyqE9+QPcsriImaDC6VzpTEYYXULuKs4P6g9KNIho/0f0SbXNlXCy/yP+4SFvLEqpEaeAnaQZEeWMZGYwVA1MUzBVmxTSa4CE+EiFWYjgc0T8iVnY1ENr2BY/KyDPH8gD108z6qtlJxts=
X-Microsoft-Antispam-PRVS: <BY2PR15MB016632BAFFD81B875E94DC08BE310@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(53936002)(68736007)(39060400002)(50226002)(8936002)(15650500001)(25786009)(1076002)(2906002)(6116002)(4326008)(476003)(486006)(86362001)(16526019)(14444005)(97736004)(6506007)(186003)(386003)(46003)(2361001)(478600001)(105586002)(48376002)(50466002)(54906003)(106356001)(6486002)(2351001)(2616005)(6916009)(52396003)(305945005)(6512007)(8676002)(53416004)(69596002)(36756003)(16586007)(81156014)(47776003)(81166006)(316002)(52116002)(5660300001)(6666003)(7736002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:xDn2hDUrIy8rIoN/UWzwm8K419ygmjqNCFVbgjoHm?=
 =?us-ascii?Q?5HBDwfasRgeyTqZGZ+ForvgS+RUHUhrslyeG03Hhs64G7Y98EY9xdHVMLOqD?=
 =?us-ascii?Q?sS71J79FzHdpcX+tHMqre8cvAqsZcNRzU1W1DRRvKJmDNxE3XJs6AF7pX9bI?=
 =?us-ascii?Q?IUitySJAbPE7fSETBIU8NIPgKNm/DUOG4kyqN+ZvTRVkQ2//UIp95jLHlYnk?=
 =?us-ascii?Q?CfS7AZFBMv1dMyFoxBH21shM1kANSNIFJRZJiEK1XVvWfCclKOl54NSe7B9Z?=
 =?us-ascii?Q?M4urWf8NM/51P7uxDoiYxLhtp1z1B5RRwyLRcvEAcOEpU0yhtkP6KlzZyPhF?=
 =?us-ascii?Q?k4NIdJw9drZCSvQDyNr1+nrjXy0lBm4QM6XKcNf3V1hkwq1ewr9epnDl01lg?=
 =?us-ascii?Q?sW2I+EltkZYK3AjtREEZGnEDg/Zz7HEYXOYvxlQZgAsHMsfHIBOU11QH6w6p?=
 =?us-ascii?Q?chk7fM/fG0NePrttZmb4HS5QDX7BGsF+EMn7+uuS/TEJMC3P1CMNfAVPULNU?=
 =?us-ascii?Q?vW/crT3ezFCyf5kZgw+oHLyW5eZaJ7F3uROpqLlIT3fgCPo7KZBvfXmk52BY?=
 =?us-ascii?Q?1ZBh1jDHfXXCqELRnPHTyappKjJ6MdHKSpmMt0xxgZg73/UPggB3XQUCfQLr?=
 =?us-ascii?Q?LGb/M96bvGFtGxB31eicvzoTSWvKNIhaCqk3EMEEjgKZTvSoW7aACLumTIgH?=
 =?us-ascii?Q?GUX7DRiGbaMbErS2V5MEc0eEerBrZ+pEpXR0VGI/0ghJKzx9pFkoDrZsvK15?=
 =?us-ascii?Q?KmZaMzA4m/FhwMzNlO8rRpg2jQG+xcK8fJSM3ioJi3FLuOOKhHu1ZCnkDTrM?=
 =?us-ascii?Q?zTwoagTvdmFgJFVvcFNdhIa2yeryOY7T8PTPEQd2fFRFQdghMi7m8/ZmB71/?=
 =?us-ascii?Q?QcUT8+uaPRlxxZB4Yx8XjnjS+91lqZHcXrXhP25tPNLFRotfX8Swaq6X5PDk?=
 =?us-ascii?Q?5Jz8YHJ8zV7v5+0mCsiJLCrbgNOyAyhN/p3HLTYLx8DBSLOKqbXoN/7Qn1Yl?=
 =?us-ascii?Q?ZaqFizR0yoNqvPyTfc5ht8Jroqwskuth7xuu03B0Nv+j52gTzOrB/OL8IVLn?=
 =?us-ascii?Q?2mhbT1JyAk+RZ5R1b4EFKBzY9jVlvVroSByBVTbGTFVecdyWsB1iF25rLY8I?=
 =?us-ascii?Q?zXHDV4Qj2NNIBnWDECtj+9XSpf2VvXLyqTfHzw4HanENl+XTns4M8GX8j7HD?=
 =?us-ascii?Q?wgF0ERd4lpaiDcwGTWfbDyph1hjiBVceqxjEomSJxgXE37xCU4TXdRV8+/Hr?=
 =?us-ascii?Q?vgsg4d+WUQlsTCcLbfqLUHS13ukYQcTsdcUYSutiRvDKIGJ8aftHlYECjZH+?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: VofNFfZc6Jw7ubo7iHtrzdrYe8mHfx6XsmwlrjvXh0DW1jIN4iRbXJtNQXPogvRW0+QlKMl96jJk2LpfOgCTR7wRbhWjEadUGifLdhJ/dLbct/Q3y6vgqIXHvnreD/W4BmBzDQBDM5Te/NilpbNvxS6/slpX9caLWNYIFhbFV0dnNA00zqzjdeEqtAPmPIEZhKA4JdJ2jzR7Yl/btj/WG/5/oSRT414cGhh6KGV0RfzYS3dDCkTWO4PY0B/6D3GfQ5YIL9W7KfVzlOpdeLriBfKmJwMpwu0/mW5J/cjHa1nFJ6CijJKqk7I6AZ0cpbpk2fauoV1ZIsuG74i6wobUdVzv07aXfz6mJ/IB/fbJKqg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:Gy0Gf653+FwrZlXeljEJFfWrSfimS9bckK1nCoGLW6fi03OhHqHf+GmKFa+242Cx6pKKvmToUldC8VLczApDCShfXj5i7c4RCLY2xC2cjkpzYtsh7+z3U5+XbF3wq7T3nEoRhTrTzpcwnUmEkDtbuAkELjniyaVJWYRf+KVwk+OCHFlbMO4CTrtp6cSvR5I7jiswFMEnAcNJxx4t3DuGcK3RmmepzQqOCJ3bRDp7flKd6EJefmGBqj9jNSG9LwxiOza10Q5xVuxzWXNKCMrP9mBvusBkLy14+tIbl/l1Cw1iEIfgU9MiCoeAICxQxmT/dzorcr4nL1QG0T1Ntxa/z1wreGVGep2Ux2C8aRFb2V1K2VFv1XVTXxkl+xYaS62LrDMCt3NrzyL7gsR8IPwfuG+J87+vxdM4feK2UB4Jjcf25Z/tyX9kcDqOCdbiS1mE1rxKONeEakRLSYJaeeASFw==;5:mpLMpwPCXauoiV4/erNnVBHXurphdUdL9knHpJNBvXFI2jT+JnXMH4V7Iu6/unTyOFGFqcp6CkHlhb8wvGMNe0ktPV9prEbWYorjCaGKQmh2G720AedmgjhDPeqh4QfmUpVl+q2CuNQBLzCn+C2ai/2F1bEqCsW2dTlccFIiqRQ=;7:uqeX9r5JeCdC2+/eXel3slh4FaACnvnl4fWdc2xg1AgCzbxZvYsuRXiohR/qAH1AWrGlfXffu4l3BFsHnd6YyInlecm2ciicx3eaCCG3ZwjirckR+kXLHrFuCoAuIyPBVjLi82o8RcRhvVjzxmKe3dIy2sQPnJlaFLjg8wIEwQOgtIl2M8mhUlmT1V00xDGaxxoOlbATJ9w+IdW+BNbGOEuSabx5lAQ3CRC3eh6Vbt8bn6w6DZNUfYgZrjhZ+48k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:58lLBuf8Ra/4oL0auhGtXhyjuvdYWX4SHXZ8o6ZcvIWIplQikhX2bCA7miFKo6elnSBQp2AyqHezxsI63btJSesds9eF5OPDDyZrdzfuKkrsiDWsT2m3FwReasUlp2GHwTS61pyon/jn+y0UhOV6L5PcP0uK0shvDZGSf+PJDu4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 21:36:15.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32584ca1-365a-477b-5fc0-08d607ae2003
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_VMAP_STACK is set, kernel stacks are allocated
using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
stack pages are charged against corresponding memory cgroups
on allocation and uncharged on releasing them.

The problem is that we do cache kernel stacks in small
per-cpu caches and do reuse them for new tasks, which can
belong to different memory cgroups.

Each stack page still holds a reference to the original cgroup,
so the cgroup can't be released until the vmap area is released.

To make this happen we need more than two subsequent exits
without forks in between on the current cpu, which makes it
very unlikely to happen. As a result, I saw a significant number
of dying cgroups (in theory, up to 2 * number_of_cpu +
number_of_tasks), which can't be released even by significant
memory pressure.

As a cgroup structure can take a significant amount of memory
(first of all, per-cpu data like memcg statistics), it leads
to a noticeable waste of memory.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 13 +++++++++-
 kernel/fork.c              | 51 +++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e6c515fb698..b12a553048e2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1250,10 +1250,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 			    struct mem_cgroup *memcg);
+
+#ifdef CONFIG_MEMCG_KMEM
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1289,6 +1290,16 @@ extern int memcg_expand_shrinker_maps(int new_id);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
 #else
+
+static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+{
+	return 0;
+}
+
+static inline void memcg_kmem_uncharge(struct page *page, int order)
+{
+}
+
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 5ee74c113381..09b5b9a40166 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -223,9 +223,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		return s->addr;
 	}
 
+	/*
+	 * Allocated stacks are cached and later reused by new threads,
+	 * so memcg accounting is performed manually on assigning/releasing
+	 * stacks to tasks. Drop __GFP_ACCOUNT.
+	 */
 	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
 				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP,
+				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
 
@@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 static inline void free_thread_stack(struct task_struct *tsk)
 {
 #ifdef CONFIG_VMAP_STACK
-	if (task_stack_vm_area(tsk)) {
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+
+	if (vm) {
 		int i;
 
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     -(int)(PAGE_SIZE / 1024));
+
+			memcg_kmem_uncharge(vm->pages[i],
+					    compound_order(vm->pages[i]));
+		}
+
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
 			if (this_cpu_cmpxchg(cached_stacks[i],
 					NULL, tsk->stack_vm_area) != NULL)
@@ -350,10 +366,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 					    NR_KERNEL_STACK_KB,
 					    PAGE_SIZE / 1024 * account);
 		}
-
-		/* All stack pages belong to the same memcg. */
-		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
-				     account * (THREAD_SIZE / 1024));
 	} else {
 		/*
 		 * All stack pages are in the same zone and belong to the
@@ -369,6 +381,30 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	}
 }
 
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+#ifdef CONFIG_VMAP_STACK
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+	int ret;
+
+	if (vm) {
+		int i;
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL,
+						compound_order(vm->pages[i]));
+			if (ret)
+				return ret;
+
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     PAGE_SIZE / 1024);
+		}
+	}
+#endif
+	return 0;
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(tsk->state != TASK_DEAD))
@@ -807,6 +843,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (!stack)
 		goto free_tsk;
 
+	if (memcg_charge_kernel_stack(tsk))
+		goto free_stack;
+
 	stack_vm_area = task_stack_vm_area(tsk);
 
 	err = arch_dup_task_struct(tsk, orig);
-- 
2.17.1

