Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EB520854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oPR/GZCH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Zf6dfcgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EB520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJEEgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:36:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33912 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbeJEEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:36:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94LXpkR028278;
        Thu, 4 Oct 2018 14:41:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=NRPERSulB+CgiyoKzWIV43HlBDw3Wje3bt9jlCGX1Bo=;
 b=oPR/GZCHU6uxgMl+VQCh2/f4uMTwwrw0JyKRj82uWzk0HzeRqEmOMB9DLkQMhIsMtqNF
 agEldVI6qK+uapQg7kKPTDPcq244gVqiPyo45S1liMxRqZJIWAq+EXWUcVs5Iy+t6yol
 90FaZuksACcqbJdjrSYcPofWxzpIpvevcR8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mwqw7rn6m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Oct 2018 14:41:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 4 Oct 2018 14:41:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRPERSulB+CgiyoKzWIV43HlBDw3Wje3bt9jlCGX1Bo=;
 b=Zf6dfcgihiioNPpUOUm3li9aRylQXR38oaM8U7NnkDJDsTJPMvNLTE78DsR0f6KtAo8zsusMqbH/QCEMzPb3QGhRM2njLWeoxFx+uZS/3el3WzI1Z3yRlxknDEBexGBDaEBwlI0zb/ruMjquEeGsEr23NWP3IkBrmp0f1qZ0ueA=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0886.namprd15.prod.outlook.com (10.164.171.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 21:41:09 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%4]) with mapi id 15.20.1185.024; Thu, 4 Oct 2018
 21:41:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v2] mm: don't raise MEMCG_OOM event due to failed high-order
 allocation
Thread-Topic: [PATCH v2] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Thread-Index: AQHUXCr2abwffTuYv0uLv4BJ3OKA6w==
Date:   Thu, 4 Oct 2018 21:41:09 +0000
Message-ID: <20181004214050.7417-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0057.namprd21.prod.outlook.com
 (2603:10b6:300:db::19) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:7869]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0886;20:L0sfQIXGxZCFxBTV1W9wkugzFAFp0EaZoWRwkLRh7r3tZKLHvvfmg0ucHX5wfQsU2FI3xuHcoDwzQGpiSBIhyq8dH1OUq5i4COW65h3kJaAlkft12551cXIWT2y0eRp4nI6jTvaFgyhYQGzePfKEHyqL+qpQJGwOQx0NxuaqTKE=
x-ms-office365-filtering-correlation-id: da7f1787-c249-4b7b-8f6f-08d62a421871
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0886;
x-ms-traffictypediagnostic: BY2PR15MB0886:
x-microsoft-antispam-prvs: <BY2PR15MB0886F87CE4AAB85E8BAE3E87BEEA0@BY2PR15MB0886.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(67672495146484)(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302091)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0886;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0886;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(366004)(376002)(52314003)(189003)(199004)(316002)(256004)(486006)(39060400002)(36756003)(54906003)(2900100001)(102836004)(106356001)(6512007)(5250100002)(386003)(476003)(2616005)(2501003)(4326008)(305945005)(7736002)(14444005)(71190400001)(71200400001)(6506007)(53936002)(25786009)(46003)(86362001)(575784001)(186003)(6436002)(8936002)(5660300001)(8676002)(6116002)(81166006)(97736004)(1076002)(2906002)(6486002)(81156014)(110136005)(105586002)(14454004)(478600001)(52116002)(68736007)(99286004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0886;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TxkyFpSOLCGXSfWfC8YEhlDN8jyTV0tFHaw+g/OidLxfsbAgagClGMDGxXTE29Hx5wP2m/S1ywpJ2Ds/Qg2e9o20jrqnu2avyj1CZjzTqn+k+kHe1mN6HZ0cLYvrFKzKihv7Etp6uVZsb6o/xaknp2xUe8KsCxbUfGeMqnUf5MM+50i8+52RNAaCfcAyYywAjLyn0GF5MJz9XqzHVN5DsRMNrkY/JJUzK6ijQOxLNETNfffhc9SxJDrWTlKk2PfA8yLQJMLCjJObiIqXxbBpXZkWNIxf45db8aXOOJhzMoaoCy/yFoP/4O6R0Ukkq6W/Tam32PVI/JL8eQpbsoFZ/iNSdQfSJkcp/wMwptwWrm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da7f1787-c249-4b7b-8f6f-08d62a421871
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 21:41:09.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0886
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reported that on some of our machines containers were restarted
with OOM symptoms without an obvious reason. Despite there were almost
no memory pressure and plenty of page cache, MEMCG_OOM event was
raised occasionally, causing the container management software to
think, that OOM has happened. However, no tasks have been killed.

The following investigation showed that the problem is caused by
a failing attempt to charge a high-order page. In such case, the
OOM killer is never invoked. As shown below, it can happen under
conditions, which are very far from a real OOM: e.g. there is plenty
of clean page cache and no memory pressure.

There is no sense in raising an OOM event in this case, as it might
confuse a user and lead to wrong and excessive actions (e.g. restart
the workload, as in my case).

Let's look at the charging path in try_charge(). If the memory usage
is about memory.max, which is absolutely natural for most memory cgroups,
we try to reclaim some pages. Even if we were able to reclaim
enough memory for the allocation, the following check can fail due to
a race with another concurrent allocation:

    if (mem_cgroup_margin(mem_over_limit) >=3D nr_pages)
        goto retry;

For regular pages the following condition will save us from triggering
the OOM:

   if (nr_reclaimed && nr_pages <=3D (1 << PAGE_ALLOC_COSTLY_ORDER))
       goto retry;

But for high-order allocation this condition will intentionally fail.
The reason behind is that we'll likely fall to regular pages anyway,
so it's ok and even preferred to return ENOMEM.

In this case the idea of raising MEMCG_OOM looks dubious.

Fix this by moving MEMCG_OOM raising to mem_cgroup_oom() after
allocation order check, so that the event won't be raised for high
order allocations. This change doesn't affect regular pages allocation
and charging.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 mm/memcontrol.c                         | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 8389d6f72a77..8384c681a4b2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1133,6 +1133,10 @@ PAGE_SIZE multiple when read back.
 		disk readahead.  For now OOM in memory cgroup kills
 		tasks iff shortage has happened inside page fault.
=20
+		This event is not raised if the OOM killer is not
+		considered as an option, e.g. for failed high-order
+		allocations.
+
 	  oom_kill
 		The number of processes belonging to this cgroup
 		killed by any kind of OOM killer.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7bebe2ddec05..81b47d0b14d7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1669,6 +1669,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgro=
up *memcg, gfp_t mask, int
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		return OOM_SKIPPED;
=20
+	memcg_memory_event(memcg, MEMCG_OOM);
+
 	/*
 	 * We are in the middle of the charge context here, so we
 	 * don't want to block when potentially sitting on a callstack
@@ -2250,8 +2252,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t=
 gfp_mask,
 	if (fatal_signal_pending(current))
 		goto force;
=20
-	memcg_memory_event(mem_over_limit, MEMCG_OOM);
-
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
 	 * a forward progress or bypass the charge if the oom killer
--=20
2.17.1

