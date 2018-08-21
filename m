Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036A9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933D62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Oi7kisRU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PQBAuvZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933D62147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHVA60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:58:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50192 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbeHVA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:58:25 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LLYGVi010571;
        Tue, 21 Aug 2018 14:36:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=zxLfJma5W6+QeF7kJqnEsF/bgjjJ2NJLkMmgfAY0Ecw=;
 b=Oi7kisRU44EBMcHZZOg9Q+dAI7wT9U+eT1qWmZJzYw6PaBShjtyb+3Sk6MjzCqAql0Xo
 IT4QiY6MDQv1s3yMFN7VAtT2sffIN/LQ4Z8rbW5/6gZ6yxjPB4Zd66TnpR1crpjCz2Wl
 iqvESvmmbkVGDjQ/Qdbzp8SwUUVoh29whmw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m0ssj05p6-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 14:36:26 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 14:36:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxLfJma5W6+QeF7kJqnEsF/bgjjJ2NJLkMmgfAY0Ecw=;
 b=PQBAuvZE11i21vm1cwg9E4vHPd93gMtSnq4ssVqc/rDUC2qNvHtgxd7oBAiGyTwJ3MtuizTkQhJ5+/K85Akon5W3WFA4Er4Y7jyFrlZwn17sm42jGKt+L02u5U4ti49U+xzltsPaK7kPqVWGaGNsdoTn2UJNyvS5qxG6Jl5bTHU=
Received: from tower.thefacebook.com (2620:10d:c090:200::7:b0bf) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 21 Aug
 2018 21:36:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 2/3] mm: drain memcg stocks on css offlining
Date:   Tue, 21 Aug 2018 14:35:58 -0700
Message-ID: <20180821213559.14694-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821213559.14694-1-guro@fb.com>
References: <20180821213559.14694-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:b0bf]
X-ClientProxiedBy: MWHPR1301CA0004.namprd13.prod.outlook.com
 (2603:10b6:301:29::17) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40419c43-56d2-49ee-f824-08d607ae207c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:TBL0qJTkjZiWFKU7w565iphd9wDD/jpRMM8XT/T5YoDaOLV2j0Jwm2uvpaXazPwhh0EAiM7TYJ8K5h+82/B49QzyZAf4dukl6hzNpiTk5Ic5n47GNG1b/fBY1nlmqlESSlOx5+A0jg9js0eoCklIJTLQEYF6Ty0gluDqHTzaJ8TKO5SzK+1qXdZvkvBjcVjW3WKIzOo5jTQIs7kxThQMrm5Kx4Ku6YztmCVkbd1gr1oU0jNBt5e1bi9oeUfZwFDK;25:2Oj7blzgBNaTQz3a472uDfIr4SuDLuGU7waAnlewMh0NniB+DEU1CVj6rR039ndi7KvHG81YL2yTOXaA+X9gBUYFQH3IuYzgWVjPrq+aE2MsKOQwz4/PVRpGJAm2zOoIpyCINiwgy59bJZNKkWFZ6s9Mqs42WAcWFxZWR2NZkOWV3wE4DvaKw9YwHnqFbNQyWlkaL+sFnBBH2O0GaZTqs/2VtqyvCxuDed6Y+p5ZS4cSfTYq/XtALWaV3DaLokXoGp1jVsphQUx9HykYXreG042z/SDdgtmLZk1nQNkCjXxX625DSV2lN0Ww9vMoPrI8r9J4Imair+XAyVtitIr9FA==;31:1ssX5LFspXHxLr1ukFUTti2dGkExnsm6F8E/6JT+7zDZ3FFBTgQj6r4Fsso8FjWjxQz/bUhg0ZQB1PMhxZnSPUetLSZ8Y0JQVzPWVm5pUXBbU7wZp/aC7DS7suA7xB/FCL7JlS4dHWa9eWE3ppKP9I106O3bdDmdqNZSH/4oGutSyzHYY9xAb14I6YRqsSSEDi0p1qZmvr40Vr+n4xHSrH0btKmaSh0GE/xudgPpYhY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:KYBrQAu+OxkB/UuxpqUeKoI+deFee/3XzZpCO+NGYupvn8mNnZBoMku3ECyUJtx7bUQ8+pi1pVziDdbg40PDP2JMkKVjzr11eLVK/OBXA5gWMtjJjjPUQUodjtLVdAChHvWwbh4gDDxcsldzSaQul/47JSnKjFur8ec9/E3c0wPOyxjX/wuCE/urvOgeoCnAKIJhQD93cvh/wiOYklO5yttxFOfEKF4iC2xDUFH1SxKZwKDHOeyDlxvoFO7TWHD4Rhg2yOJQoXT+n3aTKznMD3SUkMUhDkyVscBFzDg2HUDf4cph1LP1t0tW9BWz55imq3Q0EOZFFeYfUFHJitGiAxL2dInEPfBt0kAN3y5ALu5deTdrcx+CN0ufkUKuvhF7NxiSm1dK2QZOlAV5C5dV19JtZvb5NwflLNnF8XIZq14aNM2ANzPhFcYwbuhQB5HEOXlKg/fOm01IRID4axgow3cFM30p9o93+IJ94qqFnTGuF3Hyp+ubEMrov/lYmIIG;4:q3X4FjkMQHdHiSqeUb91Gi66R1VZaNAAhFobAZMMksmeqzJzv4qVIiIp9gJ2NnOqpxj5v4bCTRrNjHPOYwXxISSnoNFsKxOsD7zVbVtrN5BLYbsMIFH1hvD7rknUrfmieXOQASV7bpgp0vZSg3Atk8V9KtzgMedft8vCMYoh9wYn1oCVP25x3QAlNQmqeN8zckR6yiHxGpTflIGSyMKbw92J044nOYvkKA846buQOB94Eup6nSGZr9k9O564sflXEOSmeWI0I1hfKl4e+d3Z48nAnqXaMj1ZxlFYVjWlPuRPcXxz9Z81lSdjz3zjuklkSpnttGLLRIsBERAVsjOI1sv5nQvZmzl/UKvGdecvBGoy0gCjwZinbNPN06TPsBpWGKmWMW7i47CT597o2jhBYxFp1ZOAk8lWGS8BOwbeJ4g=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166C66770C6E766F0758A95BE310@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(53936002)(68736007)(39060400002)(50226002)(8936002)(25786009)(1076002)(2906002)(6116002)(4326008)(476003)(486006)(86362001)(16526019)(97736004)(6506007)(186003)(386003)(46003)(2361001)(478600001)(105586002)(48376002)(50466002)(54906003)(446003)(106356001)(6486002)(2351001)(2616005)(11346002)(6916009)(76176011)(52396003)(305945005)(6512007)(8676002)(53416004)(69596002)(36756003)(16586007)(81156014)(47776003)(81166006)(316002)(52116002)(5660300001)(6666003)(7736002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:rFusLMPsguwOOA2ZTbxEEV+B6UIijFRTnsNwcZnMR?=
 =?us-ascii?Q?/5dL9RFF/cax+ECy3ZmWEQmxmZqznJIlUdEVZ/0eCi8WqjNiLWR8aRZ6AvjP?=
 =?us-ascii?Q?1pMjwXg+qNiBK5e/PeULaNSnKqHTIGGdbaJqGlqDgimfF84qTKUqMjdaui2y?=
 =?us-ascii?Q?hqdxNBF0IZBa2S2KGmLh9x0FwfPgk/FctI0GuSoHfgP05bJofN5p/kSHW6K9?=
 =?us-ascii?Q?ezawnf9/fj6nW7Sj4FSp6b12RMF74bIGefoTYDbd1Thszc18h7HpETHB17KB?=
 =?us-ascii?Q?Jb4tZWhbGFuWkHmakNzTArpX01Xun2YGcjjwQ7mj/LNBLPgo7JA59Tafx5qo?=
 =?us-ascii?Q?wXENIzsoulAEASdrcO0aZUcRiAYIomZS4MZaDhIvlPYd6UZDytnJGEwa9Jbs?=
 =?us-ascii?Q?eX9zszuB1cyljHvCaEeBbXP9xivcKQPRK2orEcgJgM30BC97+/6Y0IaHqupO?=
 =?us-ascii?Q?XmBGlf2gWXFy92k7TsUwI8hje5CqGj7AkdDPkW8oT0vncRPaZkSpvfd+8dMj?=
 =?us-ascii?Q?OQZ++WkRKqGtlmPwLxVxJgttE2IqTh1TbGZOs2Uee5KymiyhmZjJ8GCe23ye?=
 =?us-ascii?Q?yiD9Pin60pTH/Kheck4MGh0UL/pW7+Wl4WQa+9/YN+lzgc8LaAq3UyrvI7UD?=
 =?us-ascii?Q?3/cv+H1o/qhEKDCyEbOJtVBahU/AuKfta2ncPMSuIhNGZy071kjIqUQERb1l?=
 =?us-ascii?Q?SeqEFz+pnfqccYIw5se/hlXeUB8z0V8AuCS9pEjYn0w1iXygW2lpxbwL7xGy?=
 =?us-ascii?Q?ZbZwszZSfWbe/WhiUdQMsSt9ovyYlLuEq04YNeXY5i3/UpuygWVWOZ1ANMwg?=
 =?us-ascii?Q?+Hc3OROnzVVFZaISoWPS89uhyidz29yw0i3QqD5DExOYRhFgxwKmxfbEgT0i?=
 =?us-ascii?Q?wFJeC2xj6LHBC5VSKOgIb4WBDLZPMosUMOtolewLBT7F7MbXOph8ZH+TKZHT?=
 =?us-ascii?Q?sqZFLagcUrBBA6XnCZke6VrB4+sryDiMRY5sy9zuTWOv3fn/WT8GSgIg12aw?=
 =?us-ascii?Q?0HJFKgQsOt/Qs5/Kr9RCpG7ZAJxek+XhYE10ttZjMBTCh6N0FXFhwYC3IKW9?=
 =?us-ascii?Q?UH03sjtHLWFwL2E6nR3mvgW0QabKdYF+eCzRrSha3x0XVm6pjcO324ap5dDZ?=
 =?us-ascii?Q?EBSG1DdYjC4p+RTNvuyCJjTYRUFl4BQuMPUzV28A5jtWC336WpxFpitPJ6uo?=
 =?us-ascii?Q?ntTRnwtgSJMd42EojiO2BW9O7GllA9C4irsnx+HfUjalD720czDGTd6KYtM+?=
 =?us-ascii?Q?a0e97/xF27mfNs99tq/FnJX1HG5k2DxC+QIM16++acpl3COeCfA3X8VUaC1Q?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: kr8NafbeI82blmvsxo/yRtCuWkiSdENdFZcJBrhKQ493F4+PZ2VF1t0WqFPdk6/TxXxTU8rerXcJ/0t171e70/4vo/qNGimLJxq0I3oSM5M5//ADC2LbSG7TgSHRGNeOdqIE6EQ/YkO52olhe7wzueAlxUECD3Kgu3lONQYiutQ1mexq0zeyKlg4boICIwflN19S2FD+9mwUBgsQ/Eis8sOvFI5CQkdeqa/iqQOi6Tnd6mDJTqw0O0gJnHiUDs6O7EPrUw1uNASET/a/WTdmOpLBkkL/TBIdVi+BrWFlgUsFT6GnkOI30UV+Jeo+Sew2qbzYojDaSKg66QvA474e7teO0B3O08YB7uSj+hT42J8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:15A4IiM76ksmxBdDnlyEcGhxpyqeMgtMcSiCyiOErhw1PsjIU2fJu8GaDUR4e7JDzp+aQXJdi2RFiKpk/nT3fdmvQeWhymzhWs5ojasZcWXJUKTXK/bHphAW8H4o/A6YwdnWdWcgQopdP0hyDUuyJDOZT/0yQ7qA8YCjfALqkoJsEx4wqJtDm/sk1QBkWgA3rD9FVoOj2N6/jEzOKCPkNa1KskaWAeiYvdXI5JD7g4z4d8UElt6HqPVXHtmNm5mYg6PeBMVcjjj7AHUw2eS7gf9Rmhtwn3dHppv/eJBqmndDl5VVvHZmSzTJz7avPnL1ngp5FAxxwaDoK+ACSdJEATsV+IvqsRO+jCp0LHRnJztAvqJKfowQnXJbSmROEw9NUpBy7f6upAo0GHyk2cu9XIfrdL0kjSz9LtB6EG+E0kQ+x00clCgzTYYJG2Rh4mPyVe/dMo/b7U831S3zQYhfQQ==;5:9P+acqHu8LuXWzM44mYKAVusAcsdSCtSMJ/1BEeSYAXiV1AwhNxMOMTfuJpJmv2xxiKIu8gEletzAITSisZdAZ+Q2iPUhiqwqaYWDW9lkq8WgcPCTERWxsQZPrU8FJ9M7hx61p3evs0eZXrxqKKKWag5sz+DAgHKVht00yAABXY=;7:LFz0z1301GGpmKoFKBP1b9P0Izx8PkV46mQtBlMGSo/HhzClJFGghtOxV2BUmT3jA1LPlzB/RqWC4NNmymIHPXRqEY6urad0PMIHvV2lN7i/WMoemYPSceYiTT6gOZ93jXDK8UtIobAo10Ph+cBRYm2gY70zUYHqlVMEvfJfKhVjvV/BPSfrCgl1JZrQC+2McpZrTGVSitjijOnbNG1Dv44cLiC0kVoGSxuXx/HtgKokGfMIm5+1WUmHKiF0QqY4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:AWf5XKKK8ByplrzGOml1j5BzxpEV44GJgySP+SLB+dslmMNrFl2/MesYuMcXT6d+DMoW1Go/Gqe3E3GOywHPNyLFoiqoKkI8NZMELMhPRcgWWqK3GQ+ssTCUX2wo2kMe1qDBGCxs+PHOCwXYnLH5g4FL+TRBWqiUAbVgFsvOyhE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 21:36:16.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40419c43-56d2-49ee-f824-08d607ae207c
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

Memcg charge is batched using per-cpu stocks, so an offline memcg
can be pinned by a cached charge up to a moment, when a process
belonging to some other cgroup will charge some memory on the same
cpu. In other words, cached charges can prevent a memory cgroup
from being reclaimed for some time, without any clear need.

Let's optimize it by explicit draining of all stocks on css offlining.
As draining is performed asynchronously, and is skipped if any
parallel draining is happening, it's cheap.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6a921890739f..c2a254f74f30 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4518,6 +4518,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
 
+	drain_all_stock(memcg);
+
 	mem_cgroup_id_put(memcg);
 }
 
-- 
2.17.1

