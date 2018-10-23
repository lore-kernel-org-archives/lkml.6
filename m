Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8862FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3D520671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HPlhpbO2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VxA7IoVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3D520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeJXBIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:08:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbeJXBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:08:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9NGgkPt012080;
        Tue, 23 Oct 2018 09:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=PR5w1w1S9NvX8+Jm2ceUxWCy5jJcE4KIzFqrvHni6Dw=;
 b=HPlhpbO2g+Y+XwbWnsU4yHKlqV4j/t3ocnCEj6PJ9kTJbrsj2zJaH+ElNDhZRs8KRVC7
 uC8fle5tUSIZd1RPRoeovrCp3+VMgYeP7oUsGxmttTYRwRamlH3PCvGqHnrdLEIdcVbM
 6eA6hKQBgSZvEZmzf0V3UELDPNZQDHHeMFs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2na6emg77h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Oct 2018 09:43:37 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 23 Oct 2018 09:43:34 -0700
Received: from FRC-CHUB01.TheFacebook.com (2620:10d:c021:18::10) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 23 Oct 2018 09:43:34 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 23 Oct 2018 12:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5w1w1S9NvX8+Jm2ceUxWCy5jJcE4KIzFqrvHni6Dw=;
 b=VxA7IoVlsAii+VGgChgcX6JT9NK538+GNPqobeFaUAYN6yxW8S5v2gRhnF/t3ObC3+QGoLxXzzz9LrHSuegLUAXxQ4naigcqIWhf3SrQlpGWK/vt4kP2GPCfoyawS+s/NYAKM8C01/m4B/L/+bH5ES0Is8Ee39pnQPdO6bLjmKg=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0759.namprd15.prod.outlook.com (10.164.171.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 16:43:29 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 16:43:29 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Topic: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgUw==
Date:   Tue, 23 Oct 2018 16:43:29 +0000
Message-ID: <20181023164302.20436-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:300:4b::17) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:bf0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0759;20:fdOyDHHSjgJskpO7YLB5o14kkEAT9ZpEwbJn6Z6J4h5xMBpNDv0n+CVNYWkEZrzTfo6xT1QBGmDphuHQuTPW6Js8UzGlNmCgaHVmzOvQ4oY8qFjqfHsQfQlZZg2JrllkrrOr20+ozY6/AiyTnRvGe5r859AB2xKhGGpdiRMppxg=
x-ms-office365-filtering-correlation-id: 5f202612-01d7-4284-2bf8-08d63906a8c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0759;
x-ms-traffictypediagnostic: BY2PR15MB0759:
x-microsoft-antispam-prvs: <BY2PR15MB0759B6D1F9C15A3F0239F940BEF50@BY2PR15MB0759.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0759;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0759;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(476003)(36756003)(46003)(1076002)(81156014)(14454004)(25786009)(2616005)(8936002)(386003)(106356001)(6916009)(2900100001)(4326008)(54906003)(2351001)(316002)(2906002)(97736004)(6512007)(575784001)(478600001)(53936002)(86362001)(186003)(5640700003)(99286004)(7736002)(486006)(52116002)(102836004)(6436002)(6506007)(6486002)(71200400001)(5250100002)(68736007)(8676002)(71190400001)(2501003)(5024004)(14444005)(81166006)(256004)(5660300001)(6116002)(305945005)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0759;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EFht1TZby7aqqtXOxj0JTXiYqz2M6HPKsQ6dgJTMyLgQLD0jUDHf7sAs3kkzN50m71wPrIZRC2fYd3fgynNPavgVsq/nDszBkh5coFpIVCL14/CfujMeV4PZGNTjzvgn7VYJg3mdINPisq39MwxZGSNVkEMtK5+UYWJ9E66XWNiFKtCnAC4vTqYE8N2OXTLBojbuSfB9t9jYSnCbKf4gKVzryc4JB8RxAljTrT88gHr/8UzgAKP9glX8eEeH5UH6JN6hGTEiHoq/t0MdDp5aGjbQ2UMYtxHtff59LK6cMt1Ki7U7jJnfP9Sys4tB+b7LssAqiMq+lPJKw/AqoaamAjp+qh8S1T7mjW/iT/sSmZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f202612-01d7-4284-2bf8-08d63906a8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 16:43:29.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
with a relatively small number of objects") leads to a regression on
his setup: periodically the majority of the pagecache is evicted
without an obvious reason, while before the change the amount of free
memory was balancing around the watermark.

The reason behind is that the mentioned above change created some
minimal background pressure on the inode cache. The problem is that
if an inode is considered to be reclaimed, all belonging pagecache
page are stripped, no matter how many of them are there. So, if a huge
multi-gigabyte file is cached in the memory, and the goal is to
reclaim only few slab objects (unused inodes), we still can eventually
evict all gigabytes of the pagecache at once.

The workload described by Spock has few large non-mapped files in the
pagecache, so it's especially noticeable.

To solve the problem let's postpone the reclaim of inodes, which have
more than 1 attached page. Let's wait until the pagecache pages will
be evicted naturally by scanning the corresponding LRU lists, and only
then reclaim the inode structure.

Reported-by: Spock <dairinin@gmail.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 73432e64f874..0cd47fe0dbe5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -730,8 +730,11 @@ static enum lru_status inode_lru_isolate(struct list_h=
ead *item,
 		return LRU_REMOVED;
 	}
=20
-	/* recently referenced inodes get one more pass */
-	if (inode->i_state & I_REFERENCED) {
+	/*
+	 * Recently referenced inodes and inodes with many attached pages
+	 * get one more pass.
+	 */
+	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
 		inode->i_state &=3D ~I_REFERENCED;
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;
--=20
2.17.2

