Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CAFC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2220221721
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GIt6juWo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XPi77NN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2220221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeHOD0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:26:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728144AbeHOD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:26:31 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7F0UOnZ028091;
        Tue, 14 Aug 2018 17:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=msuVjdyVfTRbspscaCDwIy7tMM2QtYrgmrKRNFFQspQ=;
 b=GIt6juWoRAuoQ/eHrtOBOWswvnmHcp2oluRtAtqJEoVtzj9tjwsoA0Z53J+9O9nV6JAY
 CxxdzI/Dq08sZ1RMAu4eMjXle3+wjMHyzY8rKrPoqd/uXK4uwZc8JJjP9SqQt7303os6
 YTAEz24Abvt05gaZVWyexfBp+WejkTEtWaU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kv6hqgg7w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 Aug 2018 17:36:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 14 Aug 2018 17:36:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msuVjdyVfTRbspscaCDwIy7tMM2QtYrgmrKRNFFQspQ=;
 b=XPi77NN+JiTx1ADpNQleVwh/AY/CKp7MPzKQhyYQ9PHD6kCPh2V2FxiijPqEhqF31DnZqTK/3fDUXZ7SQLD2pOTE2Vss97KTtNlqd/6paEeOZ0d0E1jFIxApAds2wOMwJmQmkSnVfhVz2lHmJ8RKx2djexWEe0s3alp5NRg/Ozs=
Received: from castle.thefacebook.com (2620:10d:c090:200::7:b884) by
 CY1PR15MB0169.namprd15.prod.outlook.com (2a01:111:e400:58bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Wed, 15 Aug
 2018 00:36:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Date:   Tue, 14 Aug 2018 17:36:19 -0700
Message-ID: <20180815003620.15678-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:b884]
X-ClientProxiedBy: MWHPR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:300:d4::16) To CY1PR15MB0169.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5cdb32-0da4-4c4d-f667-08d602472af8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0169;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;3:LRPc4/4L52F3p92MLwHhcDS1GgNCWW+aDFitu4cOjVbvhMKnamUv9GJab1wWcjzsCqj03dlDRg68gVv9JyvDJ/1yXVtgwLDCKOOS7AS6LOnlVvHW33wzYzQ7Rc/exldgfArZJFtSTriKzInl7FMiv0teCM2/i41/8Ws3utRGDVQ7WxhpxM2YbNnPoL7b1nLyrPJpqgUwRbruKAKJYF0HrpUYHWb+1UaqQTjF3sQa5x4rCDnMAtlcbrgq9egnvGTk;25:o6pCE9DuT7YO2itXB/7za9CkxvdbemYmvFSLo6KhggXzUWum13ceyNPdMJDv/42pCW2mZYxsMB4JAT0tjXzGgM9b51vkuU1uq8YbKAgMqrM4SEoQEmthkD8CM312SpvV4Vy5F2lgxJdBg2uo/p8V7I59KyO+YXXYvx3Oc6YkYUnS8lR/eK+VUIV+Yq2atKSjXnPe97TLP0FEeV6t2RGfWncFnw00ikeblESrqAfbnHkZjCTTZFJdMwJacIuUUw9BKzHXJyHHjK2CQJIQTbShPqxh7aGsBom7XnLZk8rabmJq4nu24fhZpDldYPI/jrXRxvTnexmeD5sRsDl0gt+qYTo/yr1ii/DvM9uJRL9ShRc=;31:m+Z7eYGzZhhQ+/NphMfs+kKsEs6kieQKrnEbykxjDEzHuxmf5GgP2cJdt5Blv7bzzXA2kVyra6X65PlamIefPqc5TycnqwxfuG8VoEZKQOHlZris/BP1AO06/hOepdAtYeFqXb+pm+uY4Bt/+eEKptpN3EnsD1QWSzOrIUx2HvkIm6ZC8xbtHmt55G5BE05M/9OauNtwbvWdH/VtHxdg+leg0WsDWEM4qI0WCCj1vE8=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0169:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:mSQhI7zsP3mdLBOemKIuqKayUtIgKEhsSM0q0Uwfdf0Pdd88mW5NX0S8+JylweOwb2bf3aNJt16GMxZHLNsJAzSmfCMQIawZv8Se/XVGWNT61wiDIXBVECAEacTyADwPpMDrPT3leHqZejd4It5MzYRaZ78Ex3J9j9AH33GmInOL/Oil2+0lHZvNoFJE7SM6w5sIu+7iMUfL9Yz1MAbgPvGG0lQmA2M73bq366YznMUqyciBL0mC1SxuNeeGrZrl5/GEhvg7TvC4Eu3xZ+Aw9shGZwceEAycOntz1SPR11t1/f95jXwrIA4k3KN/kjOiJCIzjOb9dC5rUcUq4mSd7y8dwwuLUsqXoAup2q/ZvpD5c85+XueCxl5Awc1r4Y6EIHwEjVzIkEpQyLfmKsbz4tAz+hUWSEu8i/q4ako5wqy9lqHl6fwkifnLz3Hbd6j7YUbZRHJaTWtqmcV2jZcDgKLED2zD5P6fSt12e4e+1s89+k05you/2GX8nG35xIQS;4:SDCWh3T5go6v3z/O9XgDKjc9sXEf6Ubzc7jDscFuoQEB2yVhcNYNNG1urUFYxchTfhXQQtPTDk1n4oVxcY41IoZJ/mjRl7ZGG7H80ivSbE/FGYIRvFaGxHE8rtdXAWMEUD+vvXwKStmZWvuGjh3QlROxslxdUscoEeTkVqLbQB7z37LCqaqIPnrTKXuAh6ZzkAjcQjgqKvAUne5tEFvMkg0it4oXTOdgArQR75Cn9jSIvXzgyQCFmV383gb7VLuvOvKM569ohUm7ZGOHoNrrykjaQYYiL3j0kdGMYR9wslpaoEWkr+Ysh64PRyf2B3ucBNN2hYykEXn5r8Hx4yARjE7ido+i0TBNhX9P1oocHP8=
X-Microsoft-Antispam-PRVS: <CY1PR15MB01693AD09F8CEF42E6CE2FC2BE3F0@CY1PR15MB0169.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0169;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0169;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(316002)(2906002)(52396003)(54906003)(105586002)(4326008)(39060400002)(69596002)(51416003)(25786009)(16586007)(53416004)(52116002)(36756003)(305945005)(50466002)(7736002)(106356001)(48376002)(2361001)(97736004)(68736007)(8676002)(81166006)(81156014)(6512007)(6486002)(53936002)(46003)(8936002)(2616005)(486006)(476003)(386003)(6506007)(186003)(1076002)(86362001)(6116002)(2351001)(6916009)(14444005)(6666003)(47776003)(5660300001)(217873002)(478600001)(15650500001)(16526019)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0169;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0169;23:9gjqIN+urvTUoRT2aLAesPJDWHiQEbdxz+geewpDi?=
 =?us-ascii?Q?DPwxGkqOnPa1hF3rZWf1HoQkVgoEw3lNhGxJuouV872ZHII8NtH+kurZ1v+E?=
 =?us-ascii?Q?hl/Ky472N4SYGyPEKbIvoQOFAkojbAEUWuwjqUFxD+BKG5EOgjdDLGbOQ1N2?=
 =?us-ascii?Q?7XIZSrPI2a/b+cWXr3LaZha/IbKEy0JvnJNMLVUIBGT+k8mm8rQNaD5/lgXG?=
 =?us-ascii?Q?Q/woNmfQxx7O2Y9TuhLDmlh1BhG+7xoWPThRQ6Z/Oj+0fdg5nFbQY6DRrexS?=
 =?us-ascii?Q?nP5qNNzwPXm1v5CUsoIfeZj8Z6sYRyFY1bTp6mCaZXVFE9wTxxxd+k8neCQI?=
 =?us-ascii?Q?Le0cEgpcpf64iYryrUMR7XPmmExWrINxt87vX7YCChrKOMozaaSOJHxSkxF0?=
 =?us-ascii?Q?Ql5mDVr6WR1tDFMh45zylqfNfbwCbM9RTAX8NITp4ms24+DZB0FZMEV/ZtIG?=
 =?us-ascii?Q?mIWIEr1UoDZde2tGS8r1ZWbn0eZpGOMz37p1dHJLLrCLWjjs8QP1wUfx0MoH?=
 =?us-ascii?Q?Ld1nymHvpBntr7clzdbvFQtvGfm7TvknQPQ/sSIARB3TDYkjDwK66UXtKdbp?=
 =?us-ascii?Q?a+sOT2KBcKorHDv3PmMZ9F8xkZH2ixOQ5CyxtCXHnz5HymJB1yhN651+MmeC?=
 =?us-ascii?Q?yqfxIW6LOC9rGzAWIubBPKUcqF/TOGAkQscqBvNDQnqKmSxOwGSqUv9qAEdR?=
 =?us-ascii?Q?5ap8Ki5zz0OqXmjE5zvc750MzdMezaBSTF98SIAqaNRh/58XtGt67ussHf9F?=
 =?us-ascii?Q?OrZP0JxR0Q9u6CVBE04aVSluHdwmAkX4HtOpPBE65uM7RxGxxKSBxsCK0XSW?=
 =?us-ascii?Q?QyEDsWk+2EWyKxTcujSlsnAnRD9RkGfxp7NQ26TX+PHjlvGHLSzIucjH8Nvb?=
 =?us-ascii?Q?BV+tlZMj/kEUBPMMlUOoiq3uAdfLh7EtAn/JZ4Yxj/prQ/BUyBiDF4yFxM7D?=
 =?us-ascii?Q?zNuWzc1axKvzq4CrYtbOWsFTFFFr14fU8y6SSuUJpoN/m6OFo/XBvbrSBz0D?=
 =?us-ascii?Q?wJS9v7xpPkh5dgl6vQUASrI4V8WQLA3cW0DnPf8inIKzDUakQQ1npPdtqSzo?=
 =?us-ascii?Q?Ykn7PpymEiwiaQpCmwAu92XnvEx1DkvgmG614187u76Tswts4Uk19a7TXaNQ?=
 =?us-ascii?Q?xLx1KWAQcIFbn/1Pe6WGDiY7/9uskvi0t2TJGNxbU+vJzXQyvbCA3r6MhOXU?=
 =?us-ascii?Q?QZ1jSVKBWapMlB/lF/rZCWUshsM1ncJQbgFaDSKQWZTV66kyiFi/2I6iowip?=
 =?us-ascii?Q?eOvxE1Qq70S8Ua1E9n8B8/YVw+2dGR5S/FiSPORBajkWTzat/6QI0UEnRvBe?=
 =?us-ascii?Q?Z+4ug40elL3iq8RbGiJWUA=3D?=
X-Microsoft-Antispam-Message-Info: 2PeScSO2SSc+G97qv+lO6DngyDZE56ROYGJf9Yuou6ao85a9bZJ5FY7BsOR+HHjo2bjxEKr2IXf0BNSDqfwUzYK2/jfy8kXTYF3cNWQKZuIxpRtsokdNQOZmmkQxNoY1ur3fOR9+rcVaob8RJsplEUS2w6CVv6riHJ02xw8DZITzm+NiuvEINkipfCgPG5/NmjsLttZaBbzw1nbNg0ZA6h1u+bl+Uf52wUoOmKUkM/1wYb73bU0y93evADBOuw/xJYPLCMr/CjXsR2B9zLLyiV3n9q7ALJeKSZBVQbdaAag0JMPDMx5+dRP9LNVeI4B8t7yKBnLMqZyGztRh1Jb2kVI3DXzTESys8Dn+FHL/It8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;6:PNP9iFYjG4NKNz0a6v2813dmXWpJJRDtSu7XUM4kBqYGCr1OwIIV0+z5CBpWP5Wm9gzJKbCpVmEerc3uz3IT1SWJ0N9iA06lpZB8jRXzbwBUSyYhlzqzyfrFGxsELXSW10oJfDQqhBJMJN7ZXS7OS7IUZL7JuO9hJP3jX3nG3KtaYXrsaNGHq6EuevK2NqwcSzr4c40Bdk3+t/m32SsEBMkEARokF3qxc+opeAtb/E+A1mF69ya+RqJVLHfGHfcwmvzrRNcQcmIWtNLLBtlVOE+ymTkEn9bfXyGe1nI/Zf0jUXCUkSTFAA1I0ElQIb/P1ERdfYBR95aTf2V80GSRAdv2smD4Hc5CFjuUEp8gWzdMCm7lQXCploM9tEsfnbraJur4pakhbpEsETbmO6ThCe9rjsMny8URINtNTd2IupswJWkINE2YO7TMt4mvQ3wGScg/iH/go3NriS6nl7zyRw==;5:E+bwtcMerAGyiDw3dGL0+uhGkkVRiQ25l/oEUv2JMgIy5OlpSD3t/WcbGV3Mm2XboUyHWmH7IFL7GmbE3jLUKDMokIi7/7sJ43dzmIKp46ZwmgQVhKv2bATgUrD3webp65gYeHxiCSofxNnMIjjmY1iRMYvBDLhXSa8ZvEW3Xlc=;7:zolwcDrarTkfExDwFX5HbFMmg9JLP0edLmIz3hcDl31042Q+TU5Gpt1bhHpITFfVkISzJ8YTcn8rmxd3aDEFJPKldkwZHPm64f1pVgnMaJj8u9Z5l3OYLOvrVRz25LWpzdx9xPIz0gewklHwv7LFlYJu6Mtd/cAQrQj2PyKFEPIfV+Hq9/HIQSXcrgVKjU9uQWd3+aVS2IrJo0lCxcMlY/LBzLlSom9rlEN3hMA4W+XSnvZwOiITEB/Y3AhZxX1X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0169;20:/QgKraNlG6dhTjbyQ0kzePKJDnL7dV/wei6PpnrH3d6IchiEwhcnKyKAS/Nvol3Ulaage2AymD4HKmM7VRP8F8wIpfjOVmcGnzZOCqOkaRgRNAXXYsdMwPjS12Ww8aVXTnuMmGAUYch4Vd5Q7Bwj6gd2OOJoi75RWNbI+2Z1bZE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 00:36:40.0458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5cdb32-0da4-4c4d-f667-08d602472af8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0169
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_12:,,
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
---
 kernel/fork.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 69b6fea5a181..91872b2b37bd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
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
 
@@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 #endif
 }
 
+static void memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+#ifdef CONFIG_VMAP_STACK
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+
+	if (vm) {
+		int i;
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
+					  compound_order(vm->pages[i]));
+
+		/* All stack pages belong to the same memcg. */
+		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
+				     THREAD_SIZE / 1024);
+	}
+#endif
+}
+
 static inline void free_thread_stack(struct task_struct *tsk)
 {
 #ifdef CONFIG_VMAP_STACK
-	if (task_stack_vm_area(tsk)) {
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+
+	if (vm) {
 		int i;
 
+		/* All stack pages belong to the same memcg. */
+		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
+				     -(int)(THREAD_SIZE / 1024));
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_uncharge(vm->pages[i],
+					  compound_order(vm->pages[i]));
+
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
 			if (this_cpu_cmpxchg(cached_stacks[i],
 					NULL, tsk->stack_vm_area) != NULL)
@@ -352,10 +386,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
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
@@ -809,6 +839,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (!stack)
 		goto free_tsk;
 
+	memcg_charge_kernel_stack(tsk);
+
 	stack_vm_area = task_stack_vm_area(tsk);
 
 	err = arch_dup_task_struct(tsk, orig);
-- 
2.14.4

