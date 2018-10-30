Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CDF2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jp4nBzgO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EI3D++4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CDF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeJaCoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:44:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727852AbeJaCoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:44:20 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UHeb0d028481;
        Tue, 30 Oct 2018 10:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=98Hm8EWnpSumYGr9eAANGqQtfjgjJdPSFRLNI0aCMmE=;
 b=Jp4nBzgOdklEowSR19dECg9T68rF6NKlVK+0D5bhQHDk9t4/x1SIuSTkmoG5+zZRUMHb
 cfpL/GnFEjI8xvmbfVOT8E3uHkobNj2NYNF8NGcGgOLvHJ3UQDaRXJwL6Pdps/ph20SE
 fEsIxEb9uCN2pSKVLrRrvR2K38TwPr/W4OU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nerr40qr5-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Oct 2018 10:49:47 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 30 Oct 2018 10:48:28 -0700
Received: from FRC-CHUB06.TheFacebook.com (2620:10d:c021:18::25) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 30 Oct 2018 10:48:28 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 30 Oct 2018 13:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Hm8EWnpSumYGr9eAANGqQtfjgjJdPSFRLNI0aCMmE=;
 b=EI3D++4YDlSts1VEIvsqOfG9+nOSRnX+4A92t4YjfPxLTDzZYmCokCGg1lp4r5BAxHkgBZarVk/nCpWQYvGpAmw/dt1cOURQ+ztj2150OroVAi1wiL9l4JpdnBsELfFJquPf8GPzqtr2CO4NJfGMKM3Xlz/EdkjTmC6Yvz/WKjA=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0424.namprd15.prod.outlook.com (10.163.109.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Tue, 30 Oct 2018 17:48:25 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 17:48:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Yongqin Liu <yongqin.liu@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Roman Gushchin" <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: hide incomplete nr_indirectly_reclaimable in
 /proc/zoneinfo
Thread-Topic: [PATCH] mm: hide incomplete nr_indirectly_reclaimable in
 /proc/zoneinfo
Thread-Index: AQHUcHjBGiUxS89Jr0ajcl/UiAVc0g==
Date:   Tue, 30 Oct 2018 17:48:25 +0000
Message-ID: <20181030174649.16778-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:301:5f::18) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:6ec5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0424;20:YEYJoxqWMtiAm7Jsuyta/K6Grv0CEDu0keckvOQN/2TwRsRjhJuNxnCA6lxlVXG71YDvRySDKaHOx9/2W6jciM8ClC6b02izh4N3j8zpXQz9q0yShEyimG1qo5wjQOTdJnd4eJ0/sLongrFS/rGtDwxTaQrNdeyt4JgyfzaACPc=
x-ms-office365-filtering-correlation-id: 18788bc5-62ac-44e7-22ca-08d63e8fe3f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0424;
x-ms-traffictypediagnostic: BY2PR15MB0424:
x-microsoft-antispam-prvs: <BY2PR15MB0424F6F3C8B1DB3A07D90B27BECC0@BY2PR15MB0424.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0424;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0424;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(71200400001)(2616005)(52116002)(478600001)(5660300001)(53936002)(71190400001)(68736007)(4326008)(105586002)(1857600001)(6436002)(316002)(386003)(106356001)(2900100001)(1076002)(2906002)(5640700003)(6116002)(305945005)(476003)(86362001)(102836004)(6916009)(1730700003)(54906003)(8936002)(81156014)(81166006)(97736004)(46003)(8676002)(6486002)(2501003)(486006)(36756003)(6512007)(186003)(2351001)(256004)(99286004)(7736002)(5250100002)(6506007)(14454004)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0424;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7KKk2V2euTmaTRHsyfZwOmTAE/WgmMuWUm3+9eLVGWHzFvD46ekV4ilvIK6Q+O3vBYya9d5/4fB/RnsAEgPMnge+ivXwA7ksGCABAFf+6SQNJEOdgQ1yzxF2KuCrSXtAX+qVm0tFvb0I5H4k6hn7rRpYKDZFGLdjlwZAx9pKJpFdp7Y6LAC/9nFiozv1RgsGtdFIP0yc7miYFJloaPf2CIlbzQ6sWa4ATyKgzTJaHDXAslPdQrESuv0YaII5nL+wfk1e7zC1BbGus3YHLMCJJRAYQ/n/AyuNDQi1SAX123cBFlYLAHMAj0hfVoBbvFqJyO2mEh/sBBzPggf9rMnXfg4zsnjK06r6slfRkyLPNN4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18788bc5-62ac-44e7-22ca-08d63e8fe3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 17:48:25.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqin reported that /proc/zoneinfo format is broken in 4.14
due to commit 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable
in /proc/vmstat")

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 403
      nr_active_anon 89123
      nr_inactive_file 128887
      nr_active_file 47377
      nr_unevictable 2053
      nr_slab_reclaimable 7510
      nr_slab_unreclaimable 10775
      nr_isolated_anon 0
      nr_isolated_file 0
      <...>
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   6022
      nr_written   5985
                   74240
      ^^^^^^^^^^
  pages free     131656

The problem is caused by the nr_indirectly_reclaimable counter,
which is hidden from the /proc/vmstat, but not from the
/proc/zoneinfo. Let's fix this inconsistency and hide the
counter from /proc/zoneinfo exactly as from /proc/vmstat.

BTW, in 4.19+ the counter has been renamed and exported by
the commit b29940c1abd7 ("mm: rename and change semantics of
nr_indirectly_reclaimable_bytes"), so there is no such a problem
anymore.

Cc: <stable@vger.kernel.org> # 4.14.x-4.18.x
Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vms=
tat")
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 527ae727d547..6389e876c7a7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1500,6 +1500,10 @@ static void zoneinfo_show_print(struct seq_file *m, =
pg_data_t *pgdat,
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			/* Skip hidden vmstat items. */
+			if (*vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
+					 NR_VM_NUMA_STAT_ITEMS] =3D=3D '\0')
+				continue;
 			seq_printf(m, "\n      %-12s %lu",
 				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
 				NR_VM_NUMA_STAT_ITEMS],
--=20
2.17.2

