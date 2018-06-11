Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D24AC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC55A208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XeQBMHew";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZAbIiDry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC55A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934116AbeFKRzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:55:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932914AbeFKRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:54:57 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BHn7FA027817;
        Mon, 11 Jun 2018 10:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HPmIizF7jwP7eBORlMTK+69azwYZjJ+UfNEg/ErOo6U=;
 b=XeQBMHewNuB6nS2aswi00JXjHGxh0OncDGDoyzsgse0rP3J4wyCUAHyG/pK25qT3HU8C
 mRKe60tZe8Ay3uDBhHF6tiH7HKK73uM+Rs5OQvlfffAGEb5huqvtDhxiOvLSFouJVyuI
 tDg9PRTSAxEjL4D7c95Ky+YVwEIEWMbMX0A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jhtjf0kwq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 10:54:46 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 11 Jun 2018 13:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPmIizF7jwP7eBORlMTK+69azwYZjJ+UfNEg/ErOo6U=;
 b=ZAbIiDrycEwfT4yAQj4d48xaSRxeUr3OQSL6mMGQeQDs3Q8PtY7f+LAx5tyKMkgqzKS3F1Wg3vXjBd6UXogAKB1HPbz4+Snkw8DwEpNKjCMWTbRbMXCMZH7/Q5ExezMwPBDVjWSjXZUdJm13LfZeNzDTU9nzn9sWaC+8gDQ8suY=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:49ec) by
 DM3PR15MB1083.namprd15.prod.outlook.com (2603:10b6:0:12::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 17:54:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/3] mm: fix null pointer dereference in mem_cgroup_protected
Date:   Mon, 11 Jun 2018 10:54:16 -0700
Message-ID: <20180611175418.7007-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180611175418.7007-1-guro@fb.com>
References: <20180611175418.7007-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:49ec]
X-ClientProxiedBy: MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:ABHFeMLQGR1UXO+ZXXEkEMFBU5n+rgEi9DuRhrPQfAbphH0KVQQX8Tcb+wTnOl01wNvrXUa6V5/0GqagcilxSDK1oLO3AGNyHuKzh8Re4zmlKd+eVfDZvUI5AyUZeMho98ryBHKG7KeH33v9nXqeWBz7J2hsyM5k1gYrThkc3Htt0h+UhsrUlDiYM02hS1FVf+GYbA3Snhb8YlLVWEv72VEOZFnhQLx3J+ODuhEqgBa9JCI/a9D55J3B55pnexBf;25:ZPduZCrC3shsLvohRjSIRL8HOiraLHIVuGTCg36C41Jx49X5XfI1mOFm5dNhOdLc8mdMA0M4RMESnYLSKt1TJZKuhmkFvMEWkD2v/twGQnbp9CJh+dLOtuXaF6iWmDwq1XA/xK3XxBL5l7bBu/1argRSTRnpAL5qJCRLzoF+tFej2I8D0Qk6/gqC1Am3lhEqm1cId2M663oMG5tRlNbqIgmuBQLHl4lWY0kNqguADDqvRP7SySq+D+SgVwvbGSllXmpl/JvI3+VfKjNSPgmWwwRgNVM+aq58vhTMpnQ6MQN6iit/gc83NeMPG2v2GCLxmwUTGy05ASAdLY5Hf06jrQ==;31:W4ZJ27UYpCtXH3Hi7hyNGjQduxzA6hcR+qXhLpkIqV4nmniOOdBDGbWlRVhiJZdyOaJPdWiQUGC/RSaYe5P0pdg2XOZ+z+hlSN+KyelIh94VW1ADvzzIwp/7plxUHdUBmdZzSi4j+q6Cvd5sMe0vfXXdMqsW2HQCDmRzwJGpjxQ8wIdNNTYj19TzdAhehJQTyFGTTd/6+bH9aWcsalZrZ5rP0pNh5Qq43IbXUH0cft0=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:Kz98tuvq1qhuCYUHBpmLzv36ON37ER4pWFAFjekJTpZltlyJ7FtKP5OBcB/1numaiDmY9fqLbFMk7tP6sn2yP5zNgY8teysV/9pNs8XkdKWYvroeLXJcvO3e3RM8UgwZTLYiqa6RrH84KkV3qr/YeBLkmBcrJC63mUCtdvdHuEA/ZNce5KuX5vay1Syj5SWISOy3+kl+F6EKoBjbmcueCI9TYoF6rjrrI1mW33+PazAzM18SdYoiMUEIn5JMknLuIWii5yscXgITtud7z9memFRHD6nCk6v2MjwhA3rZOPs/ZwzKmeGqHhnNa+F7QmsIg1QO51Zgv1YJRBYSDIrq/YaDQgkmxFyJ01TjxXeBMan7JQkFg9qeiX4GeUMbTkt7FK0z+xljp/5Rcsz3HadOCB4wTS5gbW6KzDcS59n2w9KvmCfMJLABQBPq7KbJnTL/n30ZWociX6dKBcAl2zE2hoBGl574CHM7Ne84jho6ERz8/q5RRfXiHdKjzGbHCf2H;4:CAyqFxd7RCab4v5ijz1x+jVfpEWXdj2yUodYpux6Edvui2frgr6aOf5FHus+tPdCaaPivLwN+ptNaAU9ypmhB0Hqg3/+J+xdonLEJP43jKbGI2TVGCkmw3RVDbXxgnRPoAjwzaL05DgJ4pu7bsX+3k6DEAkNuo+iBbUN9ggoSdbCF/IFlggGp+7ESk0G8kryvL3Kg+VE9yR0krUeAyc68wDquMaMcp1lBrWF4ShuHA37uuxO78GNED9Hrp88FnRUF8WlxHpGGYrLtcGlXq3aW6aW4cGFkomy0D4Qjd2cmEWgeTpS2898QoqfR5hzNWfjZerwjhUUeAz6pYGJcAdMarxvudcYeohooAEV5Dn6gbAbdPx6YUXndORLLIzO/ixM
X-Microsoft-Antispam-PRVS: <DM3PR15MB1083947ACE4FD0CDE97A5EA1BE780@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(53416004)(25786009)(50466002)(68736007)(2906002)(6116002)(48376002)(6916009)(6666003)(1076002)(86362001)(50226002)(6512007)(53936002)(7736002)(305945005)(8936002)(81166006)(81156014)(4326008)(47776003)(97736004)(6506007)(46003)(11346002)(105586002)(486006)(446003)(2616005)(476003)(106356001)(52396003)(52116002)(69596002)(5660300001)(8676002)(16526019)(186003)(386003)(54906003)(76176011)(16586007)(478600001)(36756003)(6486002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1083;23:4XJLxaQUnL3iHE9jmD6G3SaU5BFDIdk3IRASDFHLG?=
 =?us-ascii?Q?wY0J92lqLSOzlaFZeva/cJLaNRSbRyBFbpa/DgF0S3zcVXjdYy8+s8lkraLq?=
 =?us-ascii?Q?jWdsC5KfbBp6j1cUTuwlbrboYuNtIqU2HPArTruC5XU6L4POB8/eThMGSjk5?=
 =?us-ascii?Q?XE53fW2OWDyvXh8BkwcKeR8XgF8VXdwA0QxZafHCZOAKWOwd/s/xrh0Qyzqw?=
 =?us-ascii?Q?WNeEObmAW/XDyqDiOYexCW5gG44zoEj6gfHop8R5uNI1mAde0I1QlpfQHVDx?=
 =?us-ascii?Q?beYA1Ye7MjloIafC1U22+3SgGgWSEHl9ySRyWNjo9DWB0+XhZ3JtVKCy0hPx?=
 =?us-ascii?Q?tGxLTYA/rd2qJ4M7MW5+pairP8v7XAWl57ogtm/3shfkTicRCW6kjdj2llwJ?=
 =?us-ascii?Q?7diwjAIt7oVzdU4ZUNDTOdLKgYdqa+j4OuZXjvOTaB+swSIvAo57YCTma2+Z?=
 =?us-ascii?Q?sATfoI2Vd9l4YsR0fWeEq31iJdwLJY81DTHTF0eB+TZajpEGTtXbwBibIAsf?=
 =?us-ascii?Q?/n1DNh7k4rHA0Kz9RFpuLaQb2neg0+Fgbyd4RW+6a9owJD+kAUKFL6Ci+otK?=
 =?us-ascii?Q?HGmaeTqFNGEvm8Xk6TJw2qgY4jIKzK43gDPkecrK+4XZP6dNSSjLawXXLZyM?=
 =?us-ascii?Q?RTw44NLZ64T10RrL8425xq7QyaTOny0dlRVWHel8wmvKDZeZI6b51wBz0IB0?=
 =?us-ascii?Q?GxSY4DxPLsnGCp5RxYId7+yzndn8DZNVL/4w7K31o57Ig6fhs4roFx4opStP?=
 =?us-ascii?Q?3i9RLosy90446RIHDA4+EkiKCKSxvHlqQnf45xI1P7RFrw4Kn4aQkmxtX/Ji?=
 =?us-ascii?Q?YbQGoWKwX3ZV87uuUWL8sFTFo7erCOk3xazx6WcAvYLgp6aHy/AzA36zU4eB?=
 =?us-ascii?Q?1L7V00bsudUpCllp1L9iC1ef2bCySeM7ils6CyYwboaojKFH4YJGF21TdO3o?=
 =?us-ascii?Q?Av76zqjml5DfzqOMIzZQXbbFzaxN29+o5QkqWMvklbvi+mrRRHaaXeDVWENe?=
 =?us-ascii?Q?1BFOz6S1DOaQid1Q1gFJHoECBdM0wxu7BLZushjc68tpQQpcBgbDgjurZ1hA?=
 =?us-ascii?Q?GVJul8OtBHa2sTGtlm0/8X2/WAzL6Wm7cSDnEpP7FZlFm20IdDoiLLIFiNZp?=
 =?us-ascii?Q?8nAugsaRdZqicEmmIwSdUwqn0RzKFJrIwCyjI9LPrrgMYi6+9UynSTzJv7oe?=
 =?us-ascii?Q?YS2xZw31klgAsoiX7sfj3IvFgXIVyMNXdOoOij/pgiDR/gbuEbQz8xIiTIvP?=
 =?us-ascii?Q?PAXzKQJgSmVobQmxXs=3D?=
X-Microsoft-Antispam-Message-Info: Fk5hFLvUh+u+u6g1hXq8ODkclOih4SHvRHUkNAxVlLcKJ6ZscF/SWPZgodEhXjH309U0KhuqmYzNim6oJyzHWMN4DVinFqdkxg2H0FP1HYQIsJmU+79s4nxKUhp+UZ4IWDltE8zL5nsSfw1Nj9gTMT6FRwmZq/jCxGJ/u9HDkjCZV1AXnw47+Xyw8O8HSHDo
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:7QiPpfhUdnUere1jDcLnT2Z9IL2rd5ODa4HorHwoEt/j30EXGGNM6NUHmPSbDKWSGSCd9YQ+MaVXOYW3XRdExWuZ8cgMAGNgr5So1t2LT5bLQlGCClf9/4E2qFZnWTm0Un++UNvxU6sUBbew2DXlzjYUzsMthBFMeiXuqNA0oyr4pRo/5vzZZdIpsnlSKGzjamuTW9k0g/rQjGsmZZWcrRzNAtgXLmWfsUMGoZPf7MfQs5KFO5kloEqx30eYrjfm6hI1emxO3xcnSDIWiFeTpdNR0wVUhAcxT9Wvnijq6ttXfT6e6BkG04GP1hAZpTmziNiIyLwaLDUus0xNRhIF3j8poUM79t7hF+zURloZ+3scH9R97M62VqwLUK2a5zWoO9+XxTopf+MObNTNHJJmD8CJHixNyfuHBRtMWu3sWdUuchFIFnQj6PB6kKPa76m8J+4Atk2qslMoPDWtA/jcpg==;5:hvxoV1BiOGZRxQx/ek06Lf/lUgQBvYo+1L/oMSif9o8wlHKCuCJntKA8H2f8G8X+oZdJdXQ3Iy67j2arivwfrgOCquaOnvVuiBYspb8HHbnsj6/nNsTJdSbwYGcpx0c/l4Hkl2pmG1lmEJruPYS6l4e2BQllSGU97BN1mipYl0w=;24:UlCOipR5G50EznC2eKDgDwZW7SNwhuZMJJ9Lv0mGe0jg+Sb6jJIWATUOcIWd0QLPHLpxPcA8GgfVH3WNMyRqMv7HFCtM5vtrkvX/ADZAJBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:TIjjib6auMQvN6HP7DKCtLM21aFOBwr09jeE3fTi46FoDWxqzcpKlpuCbQuEPia2MMJs9brhwK+T739hVDaVD3eQa0FDE4SDVYl56cuWvAraJQYjFmfj0lq4K6szXl8WxZ7WFOVqo+V+lYyErOqjd8nXrDyNQeNm3urrvC+7ldmbtkWUDN4inYAjRXaBRZDM5SBXfd1w2aPU5z2LorwrOxtJ4fBMUFo3Wxyzaz21bSSaOtTu9XjISk6qy+CK3dw9;20:i8Sq9h9DSbKbcJtn056n+Wcy2981YDwJcIpZUEwWkXuBkAQdQloj3i3eB+RILTYDdyGfNKoumu9fgGSG28tZNeL9q+zGNmABq09Ptw9VND4l/5yparNa/3SXXktMR8FRfi8+N47IruI0rTgddYXVFEwpNndM9i+KDOusH9guyLg=
X-MS-Office365-Filtering-Correlation-Id: 7cbb3ca5-4cf9-43a5-fa80-08d5cfc468e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:54:41.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbb3ca5-4cf9-43a5-fa80-08d5cfc468e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel reported a crash in mem_cgroup_protected(), which
can be triggered by memcg reclaim if the legacy cgroup v1
use_hierarchy=0 mode is used:

[  226.060572] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000120
[  226.068310] PGD 8000001ff55da067 P4D 8000001ff55da067 PUD 1fdc7df067 PMD 0
[  226.075191] Oops: 0000 [#4] SMP PTI
[  226.078637] CPU: 0 PID: 15581 Comm: bash Tainted: G      D
 4.17.0-smp-clean #5
[  226.086635] Hardware name: ...
[  226.094546] RIP: 0010:mem_cgroup_protected+0x54/0x130
[  226.099533] Code: 4c 8b 8e 00 01 00 00 4c 8b 86 08 01 00 00 48 8d
8a 08 ff ff ff 48 85 d2 ba 00 00 00 00 48 0f 44 ca 48 39 c8 0f 84 cf
00 00 00 <48> 8b 81 20 01 00 00 4d 89 ca 4c 39 c8 4c 0f 46 d0 4d 85 d2
74 05
[  226.118194] RSP: 0000:ffffabe64dfafa58 EFLAGS: 00010286
[  226.123358] RAX: ffff9fb6ff03d000 RBX: ffff9fb6f5b1b000 RCX: 0000000000000000
[  226.130406] RDX: 0000000000000000 RSI: ffff9fb6f5b1b000 RDI: ffff9fb6f5b1b000
[  226.137454] RBP: ffffabe64dfafb08 R08: 0000000000000000 R09: 0000000000000000
[  226.144503] R10: 0000000000000000 R11: 000000000000c800 R12: ffffabe64dfafb88
[  226.151551] R13: ffff9fb6f5b1b000 R14: ffffabe64dfafb88 R15: ffff9fb77fffe000
[  226.158602] FS:  00007fed1f8ac700(0000) GS:ffff9fb6ff400000(0000)
knlGS:0000000000000000
[  226.166594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.172270] CR2: 0000000000000120 CR3: 0000001fdcf86003 CR4: 00000000001606f0
[  226.179317] Call Trace:
[  226.181732]  ? shrink_node+0x194/0x510
[  226.185435]  do_try_to_free_pages+0xfd/0x390
[  226.189653]  try_to_free_mem_cgroup_pages+0x123/0x210
[  226.194643]  try_charge+0x19e/0x700
[  226.198088]  mem_cgroup_try_charge+0x10b/0x1a0
[  226.202478]  wp_page_copy+0x134/0x5b0
[  226.206094]  do_wp_page+0x90/0x460
[  226.209453]  __handle_mm_fault+0x8e3/0xf30
[  226.213498]  handle_mm_fault+0xfe/0x220
[  226.217285]  __do_page_fault+0x262/0x500
[  226.221158]  do_page_fault+0x28/0xd0
[  226.224689]  ? page_fault+0x8/0x30
[  226.228048]  page_fault+0x1e/0x30
[  226.231323] RIP: 0033:0x485b72

The problem happens because parent_mem_cgroup() returns a NULL
pointer, which is dereferenced later without a check.

As cgroup v1 has no memory guarantee support, let's make
mem_cgroup_protected() immediately return MEMCG_PROT_NONE,
if the given cgroup has no parent (non-hierarchical mode is used).

Reported-by: Shakeel Butt <shakeelb@google.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: bf8d5d52ffe8 ("memcg: introduce memory.min")
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1e64d60ed02..5a3873e9d657 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5480,6 +5480,10 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	elow = memcg->memory.low;
 
 	parent = parent_mem_cgroup(memcg);
+	/* No parent means a non-hierarchical mode on v1 memcg */
+	if (!parent)
+		return MEMCG_PROT_NONE;
+
 	if (parent == root)
 		goto exit;
 
-- 
2.14.4

