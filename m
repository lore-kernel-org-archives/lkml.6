Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF9FC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F0B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jFmAvGrj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="X2Pg7/yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F0B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeG3Thw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:37:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730671AbeG3Thv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:37:51 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UHoagT020874;
        Mon, 30 Jul 2018 11:01:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=i/YBD9nfD/U1z2eE1+nNM+iv0evZ0/9HS1+xSWnCDxE=;
 b=jFmAvGrjiHFKEP5KNBE9SoDL1KPNkNz+5AdvYsh8K2Mf6JjSI1uuxr/NMrzNEpEj6jIF
 sfcJZ4rg6vQ2Emg0myr8KsLk5ADpfYYtwv8csvKwqC2tcfXzAPJ6e9sipdjzhevIfHDt
 wR45zk+lZkQi1ATk47IcN/HWij0WGPY4Ses= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kj4sgrhwm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Jul 2018 11:01:30 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 30 Jul 2018 11:01:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/YBD9nfD/U1z2eE1+nNM+iv0evZ0/9HS1+xSWnCDxE=;
 b=X2Pg7/yWxGXmttMHNj9/C8BZfgXRRQIRLBQdIReXriKVMeodKR60oQDhgl1z3gZwmW+oBWwSpWPkClkAMrfL3fLfVeLYXs6weKWRFFEkk7BL4s7Lg1AdNxQGgvk3erxQK6kWaHwVPdnzBKldHIApWcPb4Y3U7yhfQK9jCqjuhds=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:484b) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Mon, 30 Jul
 2018 18:01:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 0/3] introduce memory.oom.group
Date:   Mon, 30 Jul 2018 11:00:57 -0700
Message-ID: <20180730180100.25079-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:484b]
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea4e6ebd-abd8-45b2-09e5-08d5f64676ae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:6YEC7Dy6e1I9M46dYXB9JnNLx0vg3dGBf+F6byQCP+qRpGto0cskkxTY81lrpOHSPrJU/H90M4rypQVhflc2gFGx9nabLt882FC10zGVqf0SfJOMURJ4RkL18jWA1TtCKJl/HB/KDq0iGnTXFthPJsHDbLNF3anUULarKkq1jlbMsp5s4+YxJB7axouqGcrlpkGiqZE8R26bsT64DYnze0t3tNChMBC8GXOTgytFm1S0UxcBb3RircqnN11SyPiY;25:ch0ZypEX0NQR25VhJiME8mNElz6ah1wmrNOBmgT5yNAak8gboRPlNPdg9qyYlAq4NQvdGlvdiV/mPtD4GT6rPuhof9t8nwoHX3+5/bzWXfjmchCA04pzZboY/Fa+G5RsLhIQLxP7SdvRSzAnT4mYAI8X65kdl8cVNw5hlH/EC0n1LnJm2zrzKjDpP7u9WfrvRPzTWLECAGcUpkZ6y2w+WV2YPPX2HU5ib+4bnci5DbT/2Wu1wDUOg8zPWuem31Qo+8L081FG6/5SVnjwZ2Yt9jlmddo1QDkMu/pHDlUs+OPtDHGrQsJkspswLiHPHzqxUTPJ9Ob8PQO2zhbGf3TPAQ==;31:4QA/8VMfqbsCli3fNNpnnk57MPqcI2gIBgtjZt8E0OtbOeB3RsYUgH3qlNNNeANRkW71iWKMxqlbJw7Xutg/1wlPr0vjA7gdYq5+1CYC0zdFOrnyg84hDOTVmQ/XZ0W7NwClxAYc/7csj5vhk+4ZZiQ1S8ixbnNYKAuP5j1OcY27iViJkzd2Pir4DsG8oG6BzZC/2ToMEPHMEhfQjETcEXclLTQjCHz+Szi8CM2dJ0Y=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:+yMjg5rOgmwdfWiUqizgggI6y3QfGMsI236u/3CV1F4vGIV+m5Cozfo/bnYsEzSFmFlI/XD+eSNs3zcPhhexDFqFjCbV8u+BjNPCu3fcm+qXAvzyFKYRRPNkZjM8+zOPTTjXgU0HQ102Kllw0S0jZnbBJinhXFZb5vPRaDTXLluBNA9t0AgKmNQ6WvjmuCpGuzylDgXqB0DEZ4UoVjYugrnFwm7hjQN07aTnZV3mOmYwaM2Idi0VSOBTV6opyQGKAgpGBBKbXMSqu18HKRnq51+VDCVtt79xpklWcbOQeb5jQqDzjQZHp/g0QvYFoVlCz6+HuNiPd0ERkImFdDKuJsXLr7J6YghIfU+aY4DBm1HEsMTWWg0naoKmW4f7dqSWLoyU3UicFC+ObfnUcknv009dC7xlb6A4fbpBiYGp8tV4OiTbkA80PJNw7eEnx0LBJdjwBLgnJXvpK73dTHgK78EYnWkBoNfG924VwsA/llOKO2OJcRNCneNAl39AZ9Cb;4:mlCFI+F760RcZocgYXDr+RLqHAEX0oK3EIjRKeWMPA/NjB7wWD059djIXg5zd0v/C5eIHWVM4I8odddiJTZoyXF0FQrC9LFGxI5muBLW6Ao2SWZvD1vUXWZT+zlzMls7XEAgkP9nfswCexMloWdzWOnFcXeWSeHTPRqy7vYOfRuGoeWF5ZbHnPU6MEaBDm2hKzimtLrZTpWfgF2uUCnVTqW0kJEhil7U1lF1U8kS9C2H2Zy9efQKUV4mLiF1w83YUXRe6z8Alm79+MAHcHidUg==
X-Microsoft-Antispam-PRVS: <SN1PR15MB01758AC93B69726B43B03013BE2F0@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(36756003)(6116002)(8676002)(6486002)(16526019)(6506007)(386003)(186003)(1076002)(86362001)(69596002)(52116002)(51416003)(52396003)(81156014)(106356001)(2351001)(105586002)(97736004)(8936002)(81166006)(305945005)(7736002)(53936002)(6666003)(50226002)(25786009)(53416004)(478600001)(6512007)(5660300001)(2906002)(6916009)(54906003)(2361001)(16586007)(316002)(48376002)(50466002)(47776003)(476003)(4326008)(46003)(68736007)(2616005)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:LYZA9cUN4nEmdSSKnfPhwsywtUT98xIWnwRpBqIWl?=
 =?us-ascii?Q?5HQ8sItubP0gTwpRiq5QcG1z89ju/+UhXjoPsMt7kxTWZmEOlwpN69GWqnCd?=
 =?us-ascii?Q?qTw2jIgIcu8lLPAAzIG3NXQx+WdRMCuD0foEmszvqdOVa7p7GyCnt5JFdCi8?=
 =?us-ascii?Q?P3gcq8MgSIxq3hTMnle59TOLXuIiRC7nFiqnMGu3+IusKKHOzigc0sSSrAiu?=
 =?us-ascii?Q?MF4h96RgMXDeduPXxobUb4Jd6qPf5NxGlTHflN6nDgNTSyucFKjYAB9LYm2c?=
 =?us-ascii?Q?RhsTE1JWgu47bDfNtrG7MsfJMCbPr5i8HWcVoSKpuWWEyR+Ve/aiADbSbvwN?=
 =?us-ascii?Q?t4vzMW6bJjfsRxQkXDk3O8OahQAjaxYEflHZcL16EgImwr4sHdY0SoncJbVe?=
 =?us-ascii?Q?9/nv8VARmBvS6hMvFknnKYYlvh7djGjiDrNWRXyzJ8DhG01FSA9TzI3ZOzlg?=
 =?us-ascii?Q?XTOmv+0vhB/fqfFOYP5R1yM3EW5+iA3z1s/74RIP1OqJ3CCGjjps6GF4Ji2V?=
 =?us-ascii?Q?L4V4MoalTDR1j8PbHcEDQSjn/xKARK5HPtZQ9nAwKMP2oQpUJnEZ/sy2kLvW?=
 =?us-ascii?Q?TdMSVSXRS7uQV6wk3dQCPtFFywTAwu0CcVI3/MnUpYSl2MqwA1SUnjJ6NNpA?=
 =?us-ascii?Q?qBBimEIuHPxxYpxzcU4heoL2c6wuW2ThYWAnUHTQSePUh6wyIsslTZ8YfcJz?=
 =?us-ascii?Q?54jcFCrFBmnyApG6h2Vn7eYT69hXYAh9EVPaDZVpAIDgMLYR1/68zONWUJ1L?=
 =?us-ascii?Q?8zsBrt8ISk8pyJQYf26ZLDgMiexKJpwdmRY3N9Et3qW6MYhgdeoXzXJm5YsH?=
 =?us-ascii?Q?cnxavyWg3OVZUTTcmfOJzWdvKtKEE10DeLo+1rkHez4/wjlA2LfeFAyLYJ8v?=
 =?us-ascii?Q?9J3IOg2lwYO3M7m4EwFt15IHNH89+Tgdpav7L0oQIn+Rx7jKxmvAzORqZn8x?=
 =?us-ascii?Q?O0m3QTZn0S9klJIKNia6/nrLBW634yjpjFbdjyz3kjAk3+SWABuTCYkJQnL8?=
 =?us-ascii?Q?MfXA5S/hhYnAiNeYDhY0V6Z9ZEyhNcy+sB0iVjredt2FwyrwoBGGyDEF0mbt?=
 =?us-ascii?Q?2Tc2KHCix0TgYwmtzw+uED198qQuC67ng4NGKHpivGhzr55C5FA1L2dx8tDR?=
 =?us-ascii?Q?lce9N4urojkTOhsFBGCBosjVUKreY/13vKAqD0jj1e8V9oTN63CcfnwoqmHn?=
 =?us-ascii?Q?Zoqbt4mHBqawGocgw/90xd2YmRe5mqz5ZRvrhZjIx+hjUvOniUnCgJtig=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 3YN2FwBT9MxcmCtDltIRySMvJfDpxMfvTp++023aVmAusBZDrZujZaRb/Md83pmVm4o1/oCmDkmLusJHX62T36LdLPEYcWjhRGuwyI7kin7gusacC9k/4glibF81/x9lPsYZudtod4zbeeHeBN4jzRZLjCkBzScgteCz4lto2m/xnvwy8vSubw5u6xH/IHsHv+BFQ7Nouslu1UIJQNlEIj1e7aoIPF1+GjfPHVb6DIqUt5z+W8iPkHw0+c1IJaO6nPDqx0lzAbrz+gYSw2sYsPGd2alQrYtDyig2aLtZpvjPjT2BZzJiEQVV40kOLN54bRxeWv+9CVxaKmFBHHsfTpg+qSUvmLoZ2UlI4pFuORU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:azZaDc2EHoxEgPIftw7OVQsPaw7QU2J2kwFUtQgehXLqCdd1Nkj4iC8et+RecLVCGPrPJIyPxjFuVrfGFqQKxjUue7J3NdqCEMIYK4REeUYOPtrvUfqNxWQHD8IKS6EyD7s8YtQtO2fpIFeirVrSP1FmnK6GdwLMbShE5ZV8WsUvG3O41qYq/xzVKEXTY4bX6jMqQtkfaIS+bbco2VYGqRdBuvi4Mp1SEVZhn0ydyZBt1DrrL9rVJgwYPNKersX85YuLoQQ8IAYXTSVRWO3o24Ypnl5lrSEY+C+5UQiffwqNcGzdmN0vicq1qs3EYLGFlMpHhwbuvMP8AeJOJF0IvxSKQEixu8g9LlD5AI9ulkX0Gq0uW2Iov1V2Xlsypfgsrnppae7SuDZxQu4yr5PPthfjrDSfvEPRPWHvV/PhH0Inh6McgU49UMt4PikU2wEPPsTp1EeIqS550t5GudYQlQ==;5:BO9Hn1/Jd/52iQ8Z5v6jLLJN+TSQlKG0OJOHe3lQjV4LRSsJhwz26Qktq4WLYCUGiJ7xDPdg6nD6b5O5RG/cKhuC7vsQ40AJdMHcWqyNd+8AOmaorgV9qfIv4+DwAB7JbhhlN4f6aTh8K9noE6OGozBc/+xzn7pqNhxFZ3clLhw=;7:5yrL3RsRB1eOvfFH+JHGfrBg7lqFcydZOlSerlnPgAoZzmXmDUSj77FaersNz0UO64tcUMYp38glUjI3cBdA6APOa9WSQeFbx9rXRfx7VvKN1vCQHVdYztbz4tPY8rP9/jHpDaJsYsZwjOu8jhDUAMwtuAYuDPgFniFZy9i04DN3/vYtpglr+QPjdoTKj9lD6B9yS+y3Ws16hQujQBuwSxderEjNRuuEeyPu6gBpRqQifAP7dRQdR3UOyJMrUXxx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:xtQ4wRnG2TDkb6QsI6UK5Qv867e2ozJPJJAURFQHAFpR4KRp0HBKqILC2+nBGyjXA+qC3LiK7eo5x+gKy23qePWHAZv2TUHC78BBVkWZql2mCxm9XdemvhVBODaaIAl26QogGFNXmCnfZ9Grt6Xy8jJLDndwNoh+UODxnQ7eMoc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 18:01:22.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4e6ebd-abd8-45b2-09e5-08d5f64676ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny implementation of cgroup-aware OOM killer,
which adds an ability to kill a cgroup as a single unit
and so guarantee the integrity of the workload.

Although it has only a limited functionality in comparison
to what now resides in the mm tree (it doesn't change
the victim task selection algorithm, doesn't look
at memory stas on cgroup level, etc), it's also much
simpler and more straightforward. So, hopefully, we can
avoid having long debates here, as we had with the full
implementation.

As it doesn't prevent any futher development,
and implements an useful and complete feature,
it looks as a sane way forward.

This patchset is against Linus's tree to avoid conflicts
with the cgroup-aware OOM killer patchset in the mm tree.

Two first patches are already in the mm tree.
The first one ("mm: introduce mem_cgroup_put() helper")
is totally fine, and the second's commit message has to be
changed to reflect that it's not a part of old patchset
anymore.

Roman Gushchin (3):
  mm: introduce mem_cgroup_put() helper
  mm, oom: refactor oom_kill_process()
  mm, oom: introduce memory.oom.group

 Documentation/admin-guide/cgroup-v2.rst |  16 ++++
 include/linux/memcontrol.h              |  22 +++++
 mm/memcontrol.c                         |  84 ++++++++++++++++++
 mm/oom_kill.c                           | 152 ++++++++++++++++++++------------
 4 files changed, 216 insertions(+), 58 deletions(-)

-- 
2.14.4

