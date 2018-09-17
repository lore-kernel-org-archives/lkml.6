Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5678ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ECB2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G9QRzZC2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kwbKzi0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ECB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeIREkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731765AbeIREki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8HN5FK1019892;
        Mon, 17 Sep 2018 16:11:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Jbe1IVl/3TdJPUjUnlnKAZ1MdZdGtdidUSU3ALvqOxk=;
 b=G9QRzZC2VoCZGpWzZCjS1Cy2Ujgljwu6KQcAdmkogn7Ez781NGIfyQ9nWX42s9L19Qxc
 832qX6k3ZkKR4LfXjMaNWZ8BeYIl3WprJpWxh+/AUFrCTN5vAfqfcTQMwPAfSk9k4q3W
 NL9aqW0WuttvqtxEftQ5zikHmg6Ggv/FWnU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mjnd281u8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Sep 2018 16:11:04 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 17 Sep 2018 16:11:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbe1IVl/3TdJPUjUnlnKAZ1MdZdGtdidUSU3ALvqOxk=;
 b=kwbKzi0uPmY9EayeI/OQ2KQgjhMA1EkZgRmNNcCFXpektgDCQ8ujh8IVVryGxa0ZMCjrFeTvQjpHs7aB8RqO8fha9YupDOcDBYzv5/K4Scxbj68BIbYUUbCmCkQwbB1dHAzXutxiTwJ5kKk1joTPks4eSBRQ2bXzYR6gqm7BYXU=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0230.namprd15.prod.outlook.com (10.163.64.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 23:10:59 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 23:10:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH RESEND] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Thread-Topic: [PATCH RESEND] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Thread-Index: AQHUTtuyJMv55ImTDUG/zRfoLMvR+A==
Date:   Mon, 17 Sep 2018 23:10:59 +0000
Message-ID: <20180917230846.31027-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:301:3b::47) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:4cc1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0230;20:BoRbK9JklVj4OfUfktW7bKwfaF4ovkf4ZZOk590bOcmPP/Fo3yhLs1eA2VIn930Flqf+w49h7iz4nuRqt25wN89u/NUlCDhEXUJ9i31rDeQw9vucyk0LWHmikmFqhjVdwoWvs2ZFRlFaPeGtJ2US/2bE/BJ7XllNOqyHu9ZJvuw=
x-ms-office365-filtering-correlation-id: 49498ec1-c812-4a4a-6415-08d61cf2d463
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0230;
x-ms-traffictypediagnostic: BY2PR15MB0230:
x-microsoft-antispam-prvs: <BY2PR15MB02303EF72AEBA5D041CB013FBE1E0@BY2PR15MB0230.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BY2PR15MB0230;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0230;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39860400002)(346002)(366004)(52314003)(189003)(199004)(8936002)(46003)(86362001)(305945005)(486006)(97736004)(81166006)(81156014)(478600001)(39060400002)(6916009)(7736002)(6512007)(53936002)(25786009)(6116002)(14454004)(4326008)(2351001)(186003)(52116002)(5250100002)(8676002)(105586002)(106356001)(2616005)(2900100001)(5640700003)(316002)(6486002)(36756003)(14444005)(2501003)(99286004)(256004)(68736007)(2906002)(6506007)(386003)(5660300001)(6436002)(476003)(1076002)(54906003)(102836004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0230;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jM2hvUF+2afGcaAeEXuk42+6/vR4ud5hlWKogzWao2J5KRMWL1BkmfzTuz0U+IVlmmy3HNbJud0W8dfMiuKfxE9558Vobr8yXg+jvLhC0CRZKQg5s2Vy079wjcUFZ8dsULVjAS3i+kAbrOhO2Du2WPeSm0ra0WoBIEOYVRd1pPZ73MMumfQeVCfYqJgAuOcBeG2n1gAW/jijPrp1AmY3WvwtJktaPiMLe3R+mwEUYrgGbtvo6Muq/sGEGKuWot2CUAMbL+sYkmoqVf9VNU6PK8LKzMh7z+cJ0SHl23Ie8aiA1GBROI/hj4irg8ULIGiO/mciNtq+0Lm59U9xm2KKR4xQIBClY0IzL4J8n3CzieU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49498ec1-c812-4a4a-6415-08d61cf2d463
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 23:10:59.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0230
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg OOM killer is never invoked due to a failed high-order
allocation, however the MEMCG_OOM event can be raised.

As shown below, it can happen under conditions, which are very
far from a real OOM: e.g. there is plenty of clean pagecache
and low memory pressure.

There is no sense in raising an OOM event in such a case,
as it might confuse a user and lead to wrong and excessive actions.

Let's look at the charging path in try_caharge(). If the memory usage
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
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fcec9b39e2a3..103ca3c31c04 100644
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

