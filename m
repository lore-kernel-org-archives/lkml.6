Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7888C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6479A2404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aVuBvYSA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EPEON40N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6479A2404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeGEUzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:55:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754058AbeGEUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:40 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIm0026792;
        Thu, 5 Jul 2018 13:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=atshKjSHdKM1PjoAnQ0StTnFBoDwLnUGCnIy6X6CqUM=;
 b=aVuBvYSAFP0JRCSc6yWaLuWyFD7+tA4q8hsj4xp6jvFZGw5XmH+1jMjUivMEfKQLQWLh
 vSMGmkm0/NsydnpTAxCFHcziGov4UmQ1olAhUEM3VFKFOF560SVq6vI9rVKcmwRoNlwB
 +bFTLCrvidFYYNWV3oeSiY9PqRovbXNpQXc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atshKjSHdKM1PjoAnQ0StTnFBoDwLnUGCnIy6X6CqUM=;
 b=EPEON40NB1cSGX8kO0jy7xN8xPMU0fgcZcGbarxvptvmkn0GoaeRIBWkV2vsDlfU1n5M83rhLm8NSLzQRGpb/vX9XNXdLjQmhBvmHn8Miu5nyUHhVHib3ATRO9Xs3l6PJVf3ta3Ji4l+lWLwN7/iwkGV/hGNStDI8YXdT/7ZRag=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Thu, 5 Jul 2018 13:51:29 -0700
Message-ID: <20180705205139.3462-5-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d035830-b03c-42d9-191b-08d5e2b92e57
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:g+VZf1KSGDKKNOq651I/RSiZ9mnfwy3YDOS2pi5ud6maF8RaXJk72cnZXmNUaXVr0+XaKxInIHEad2xh5Fg0RpfZp2rM1bN8VzYgoyqXdJlhs8fXNBsWgFTQe5l4zK5HADQU0FAwCd9MY/iOZdLdVAzcUwUNRvnpyGgt+G4KB1mTRPAus5NAmaCWKacbLrrEglys4kn3Df+5r4qM/iJ8sOaFIZDclnl1zQFoNEbc1dOmnkyahHuWeKWGhrklgTJr;25:HpWa9jlu27+rSK+09BbR++CTlogIBnryXfzMSb8AbRXY8dgDcVXKLpR4bSp8QxjcaEJieazjfbSbinh/NEHPaKlwLSdcUeqF5e4END7baFH8ZoRFgVwYYyr5ms+qlug5DAhVoK23Uojdjd924BT2tsCm+PgMQv4VdvNYfCGK88WIKa70+eTBdIpWd4g1W869I+wAZj5Z3U49DIU90M9YZzx9IXYQrVexsqGDawOJJHk1epWIzBkmRj84ubxuYfB01rbaJZiOLLyeCLeDl2E8Bh7tyg33cp3D/Nd0mT9dJi8kJI2x+J6oIBkDBM8nIfDoqnEXLLjq+eZFfx9U1CyQ4w==;31:ZQoVHnWPZSFBXOHK6cF7dVYVPaFBP3Z8WtDCWHf4OrNzHNURAk8K46se/D962D+CjzWRSKdPmhcngGSUaeoY1GlCaP5L7uc7cMtNNe/62kIXE9j6/T46lp0j+65K/q/MMbmPwzd07rATIrlAv2wXcF16DbRdO1eyOMbLmeoTlHlF23NQ9dPAEdaUa4jtvw56J2H1rKB300loPcxcTsOxZ2CSp+2RtG3yauhgDYdZ1S4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:70ZtFH2iWRnZMKIoPWn6lEX2I1Yxayj3zCFp5PV9z7uEEqL1vdvthqAj8qr2VyRuVULstFO6UUhBr9/qOKs1vhaLOXyhdjx/jb6y2Vw/RkPezPEfLOJJeuPGi82V4n7xweKqCwbRlPU2a/1+BGINXOXKvbWjSkOUVwzHdYHuws33v7URhnk12PvEpWBez7RDVrmRLMAeZtEBnEVDc6sNqv6Sc8l8R5D1y+ZXfTyQMkWi60toQDlI3YZB/0MK1Ti2/YbuYgNZYyj5MErc6V0ZfkXZ7oKuDgRVc/v6glxGALuX0JguAj8xZ800/NB2/Qm37c6roEBkaSxf/TKPlKxyQdttZGLt9dFaCwgid75ejJvDwWbjfdrdbegXmqmX8rELnTKmnqwfHOl/KbV0Z8iv7FZkGU6u00vBOg3xXxYMpQs9n25ya9gUKgaCeDe83PuuouuPu9L4R0EJVvrcz7D5ou2/+1rz+aobkTsSPIYMKXZR6Q/njiXzp3XhDHmG/L52;4:zQp4ECe1wnk4Gp+tMiknVfNQ30sj5koRIcx/CrWbIca6Vp8VXe/mXEe6RR1b9MOK00HWu+GS5BlathWVqrWO4MGwbRiyUENzGMmKq316YLSPguOlxKvHSaPAxiUqNLDRrVaH9yyACJy6i3P6QsUxlydtbDr7StANU5t8WKnBz6FWMf67uI+wY5FzP7YJTtYltBs/v+POj80RsXFI5xZsRN8i8T/se/xsdHjsJIbtcC2AZYgllRvo0pfmzOpfLiWYF01EPJJvanStN0YH26cNG1G6lQwumbq40amjSqK0FOYkngcMd3uQ0YCkCJBOyakA
X-Microsoft-Antispam-PRVS: <BY2PR15MB016694AFE6C3CABB4F72C301BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:mJKZxwmoUnpCipX7FzE4XLjRQmlbW19MnyXH47kii?=
 =?us-ascii?Q?cTlA4Y2ooEgbLchXHEaVYnYD0ZZXtif0CJnKfYYeUM+nsI3TniJ4ZRqt095F?=
 =?us-ascii?Q?EAvcTfKsufcqgRUGXD4wKhFNIdydMsGI0PHCY9WOmLPZpZ+RwXVkbmro3sAJ?=
 =?us-ascii?Q?0dzsVIqlAgWqY6U8QLDiBiVi8IUnIxiKZzelEddOrEExZLfKytIzwp/x+R+M?=
 =?us-ascii?Q?xt9iC8jLYthIWSGpC3Nw+p+2W5u8ZHse9e8SUQ222jm/mw8fLVGXnblStapw?=
 =?us-ascii?Q?qrUGsGrc6ff6XKt7XaWdgJnJvc20T/qbQuSYfQ8rmU3mpULvQ93QrfD4i9yh?=
 =?us-ascii?Q?jvivjxMjhjA0Qoaig5xPvXviPekl+uwSprPwipsUdRpE4ltIsfKClHCV5aPG?=
 =?us-ascii?Q?N6P/FXaR3DdJmvGgRO8ZdKEXfLc/0c/6qgyELknCDXS4ap05dEfuzo20g5Uu?=
 =?us-ascii?Q?bR1v4Nb7ewr4u1f7kz3TmxeR1oEiaGwWh7OcSAF1gB26qV5f+TBV8F1H/nIc?=
 =?us-ascii?Q?u7n6VsAI3RaTK/zaKC0C3OJcRS11g2o+kOrp4xK1IMjZvNMPCpWMM7A20EmQ?=
 =?us-ascii?Q?QMNB3UF72IEJIBT53HshP+P1BYd123ukgYkB9q1sZJCOX2397X9XWSX7fMQO?=
 =?us-ascii?Q?74kogzg/Q8mFzcW/VLH5YCveqQ31oYBUDUIuCSUDT84zo3yN5rLDMamxDTuh?=
 =?us-ascii?Q?AG3Woyo8CkfTjEdfeIqPVaCZp6CN3selZNqkn8AlH0S9bFXO3CQJp9AtIb9d?=
 =?us-ascii?Q?0kJ2SVRJ6gdMfHsSNFoWmqWAP6hm53BOPmBLNY28Z+VDaJjG5rOUW32vWUiI?=
 =?us-ascii?Q?VOOUCIkoDHP8gWZwetmyETbDA2ZS0pbBsce6ug9nKSoy/aiwMi0gdAgYNMqr?=
 =?us-ascii?Q?azUnmNLzBGdPwXCTxkUgvWbic44y71T3+UQRy48VTA2JbgwvsgMyctrdJPjv?=
 =?us-ascii?Q?knaSp6F5YPDoxd9tL7ayH8WxsYHjAiMkh9epZHS1NcoMiBWuOILYs8LyVfSj?=
 =?us-ascii?Q?Ggz8PB/NAjfl6arUWGsYCAfNgLesj6rcXr/Yeu3UzritqDCpK7xE8mgjcCCo?=
 =?us-ascii?Q?ZwasgpTSdjOE2K/idzft4nLH7MhICz3A0725SAex9eCAiTC2IGrNgQjp/p9/?=
 =?us-ascii?Q?hi3iII6Ho2Fca4YbdXYswRjFvHcS5SGnOOKOzKjxNRiXqw2y9XNGHIXhKfP7?=
 =?us-ascii?Q?tezWQIS4UTOE284OCEu/RBYaET3EW22KZoswIXgFAZxqRclzENFIVYTjJfb2?=
 =?us-ascii?Q?ozdMVXlK029JxPrTzwPpr3SZTZ6lRhurtBWepKZJWb5bXT9CiGwZlsnSGwqb?=
 =?us-ascii?Q?YdC5WPtw9vn1L0mi8vkwcU=3D?=
X-Microsoft-Antispam-Message-Info: GTQUAbPPaUf9v/cuRF5dnbZCRHbIK6+6ioZlfSOY7YUpSc3JNiaV9RW9+V83/s1Ct0VlROhCr8i4eUMJTYUOxBZFMGIuI/CCJLSwX2JVpmAoqXJtxsv4Mnk/gkMP54QBVSoP0vzv1AWb4QRGgGB6KytbIJtmQM4x7n3NFg0ImcBg83T9hDGFQI5/IFOxS+I7Pmgd9+ZxBAMYwgg9jUmkYVLgGskaYC414wU4VazfwmxWtC856XClCawkxNY/kz8vAEblZKmy+VhQdG4QYJJP5D/QNI5X1sglmVovP/2HaUgL3DMO656SgGgSC7doh3hw312Cl3LNyoCTovxh63fzaOrbJdRfyt6DIXZ0huIIdMQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:n53nhfHqro3+ldnpJrya9z1uOmr6fS7g2PSp4QAT5FotWoArb9gBZTHxAvBJCBIR9Z9po+aTVCPT+a4QnycHpjYBaGV+QLPxCm7W5OrMBsd0J6Yr4lfhrpj6kT+JAHxOYlxWB6tqdWPgevOfPCiH/uQn6IJw9yG8VgoGyqA6P3M2FH0Ukzy5tWBTqj5A3MTtBaxC/AgnXi6G8RZ58t4O3nMFa+sQX2tnY/42IpfgyifECNkIhjM6TN5xcfE0B228DNiRIM/VImtdx80WWbS4IPSCdH3JTlP7B5HVR8aOJsMzLfQvM2HDNfPZLCZqwhguIOFWXXq9UOnc0QEaDKw1cYLxvCKW+U7RFkDy8OlBNRutf6XVWF3cP4Dsx9qxn1qhes9pfsLJ0/ap4A5QlCPy9roz7A9l5RprCxDgeLHbjGdy3s+VSDNs/Pe/snz1Au8yKbW/cqvURiMTV/+Gft2wiA==;5:zJ9KNT3GD5t1WY30odEFPLT/dC8J9CQuCr3tT7T7m+aPu/z9qqDagSBh3kkxyCib/fElg7CS4Aa4+iZyH7MTW12yFbEQrAufp4WtzwTDBzh5ZKa/PZe+4DDczYqMYHx742Y+noXPpjqkCAt6lVrNnM5skNM8eRi7G6KV+LNoHGQ=;24:e8R2tEY9mLcsnGz910NzwbqaRNVEWWKZW7BPFpa1DaKY4HmM8p5OzaBZeAtrHQAUhfylXZRQb2JX83YSh7YfACSjwAUfUZGV5+DD+HGLZVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:6/82jUoCY5BASSx7gHbqem0vouLAABG0tHBB4+d0xdNE+9t7zPyC3zp5nP8KvLkLfd5WzL+qPOkD+7uojcEE/+S2Ni48FH4IlvJgZokJztIAyH+2fmjW/GPzpOVO0l+WS/q9QvkV4NYxj1H3foQJMGRurzjOMuB3WlaeqYiwIcupNnemAExew3HppErox38kbleOBCIIgWYn1AlVXqKNQjdZaxUqehtIg55I2bGJ+RZ5Nh1A+G4ciTybMi+WZy2R;20:Il5XS+ZadaRAoiyRiN/Vv5Wy4Pj0Fqm5JwU2xgsrnLlR2/sQFibUz7MvFPisfsLEPfTrbcCF1OYmL4zI0xAIEvQBc+oO1ARJh3edghAx2qydJSOV3l2s3jRJDgXlzxU2qjcoPJkvFVgPia1QcQk/ddBH4LTnlJwKaKfK2ngfVao=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:11.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d035830-b03c-42d9-191b-08d5e2b92e57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index ce77a6dffb6d..1d2167deeb6c 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -42,6 +42,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 3d83ee7df381..808497a7c911 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -189,6 +191,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -211,6 +214,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node)
 			if (pl->prog == prog)
@@ -218,24 +225,33 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 				return -EINVAL;
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -258,10 +274,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -277,6 +296,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -357,6 +379,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

