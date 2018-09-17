Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D14ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534662147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gEfaqL1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534662147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeIQIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:41 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730853AbeIQIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ytxasIXUWVDmBEd5pH7XR4oA+CDagyKJU+HFMY/wxk=;
 b=gEfaqL1iks9aITGYQ4NW7YVQuZtfe3mvskG8QKoBN00RJDe5Fg0XLbM4MR7waWiaHWsvmU31t5RSnpRILgktXPjPb6QJXQThUlzEhN+vCobJqGBR0uVE+5I67PniKx6aKAKrVZjM/OQPh9b6RnuYXdMBErmP6zkQ8o4/GkDXEbk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/43] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Topic: [PATCH AUTOSEL 4.4 11/43] md-cluster: clear another node's
 suspend_area after the copy is finished
Thread-Index: AQHUTjM1/Z7VgIAjzECMKmOhxa+X/A==
Date:   Mon, 17 Sep 2018 03:04:55 +0000
Message-ID: <20180917030445.484-11-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:1AHgXZe+SXK1SMT6VWz2M7/EbUi+IslGgks0yTLIGIJlRfGgQPcRnU2OP7LSsBYVbUuaISXGEo8hih2m2aI1w9mE+0SfwXh7aWpgFb0fXmkUzrOdSzJSzI8pY/+UjqrdsnJ56Fq1J/OcEZAcvs18LmLPpaeAGLQ4kTsbjxuhB6EO3sTWQbOEDhZh/ebYDpkGS2NrvTxTeH9HWVoPbu6MEtz1+Yde/8W/m+uJNNIjv7zVRv9ltmjfKamZPfMsnat2yX5mV8FMsGlG3icFHtG0dHT0S+7dIEArbR7fqqBtwLTA/QEqbdOGNdP7UfvJugZygxxYI5kbFKfTvf0l0KmfKydWryG1ajliWxJrfbv1qtzQ1nq9fLoD1Ys+7+H4V580MJJWMW0+ycYA/gs2rhXTTbQOYqnUOwX2oJ+G3TkX+tK56Zpi+S0L3UuzTHXTwNfChW2KdjVKE625ebxWmijRsQ==;5:nN9dvODIRAAjDWjAoDrQh2/TJAdG3TTWy7WeG94aVKQn47RiPas7PuUNDmUT1F4962keumTRNGQDiMhGZSEaQKpo/K+ILuYeAOI+9HPNLOErj3DrVUeuwpkU05mHp2ePJfIPDoADdqbvwp+huK/l1R58s3hwaMl63t6e/OZMZKU=;7:mQNM7e0fUXsboqafqwTEs8s27CZiIpM6hQ2jF/YVt2114uwwlgfvaZQyEpMHi7RL/Ftk3LAh/U1Y01z5ZdJFS4YfVxFAS7XqDvxdUzqKK3Sz23hSwXKOv0NHF6cYJbr5u0vSVc9yGv/MT0HyXrdMagwa0vFt5iZaO+Qe/92bXMQZBHOge4BdHJ9FYrlNDiftcgvIWPWmDg7AkKMtKCisxvnkYuRXkWKZbn6gBazTsiODPZBRY0h0auRYxB+IKY//
x-ms-office365-filtering-correlation-id: ff1a01db-afe7-4bbe-fea1-08d61c4aa574
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01667BCDC74066F799EDE368FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(15650500001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wS+uSKoFic8DDEKaw9dYB2Aaxw1oP1RD8ED8RTPraQUOp0v4g/MS4NopqHVp0UT2kBZsByd5Y/Ayy14I8mJzZcoMb0gsWKVJtAjo8d2KCyEI+nc7pODgu2pCgVd13VRvj+DK6ZjCbdp82B2kTLUwu6ZYpAcpO4Dh68yQuWunrccdd/vEdc3mMCdPgrkkNb/mLLISwjJeGnsigGxAC87g+UGvsUUr1Xz5BxehLcEjOHQNiVmANlnRTHQXPnwHD5CkEae4PF4ZgPcig4j4cz7n1chNGMSJNtaLjQsvS97+/GOS4OKgOjBbnHTAej6CCvfuhonKgILn8bClDX1ibq3B81Sg5p2STACYSsFPkKtRbnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1a01db-afe7-4bbe-fea1-08d61c4aa574
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:55.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit 010228e4a932ca1e8365e3b58c8e1e44c16ff793 ]

When one node leaves cluster or stops the resyncing
(resync or recovery) array, then other nodes need to
call recover_bitmaps to continue the unfinished task.

But we need to clear suspend_area later after other
nodes copy the resync information to their bitmap
(by call bitmap_copy_from_slot). Otherwise, all nodes
could write to the suspend_area even the suspend_area
is not handled by any node, because area_resyncing
returns 0 at the beginning of raid1_write_request.
Which means one node could write suspend_area while
another node is resyncing the same area, then data
could be inconsistent.

So let's clear suspend_area later to avoid above issue
with the protection of bm lock. Also it is straightforward
to clear suspend_area after nodes have copied the resync
info to bitmap.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/md-cluster.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index a7a561af05c9..617a0aefc1c4 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -239,15 +239,6 @@ static void recover_bitmaps(struct md_thread *thread)
 	while (cinfo->recovery_map) {
 		slot =3D fls64((u64)cinfo->recovery_map) - 1;
=20
-		/* Clear suspend_area associated with the bitmap */
-		spin_lock_irq(&cinfo->suspend_lock);
-		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
-			if (slot =3D=3D s->slot) {
-				list_del(&s->list);
-				kfree(s);
-			}
-		spin_unlock_irq(&cinfo->suspend_lock);
-
 		snprintf(str, 64, "bitmap%04d", slot);
 		bm_lockres =3D lockres_init(mddev, str, NULL, 1);
 		if (!bm_lockres) {
@@ -266,6 +257,16 @@ static void recover_bitmaps(struct md_thread *thread)
 			pr_err("md-cluster: Could not copy data from bitmap %d\n", slot);
 			goto dlm_unlock;
 		}
+
+		/* Clear suspend_area associated with the bitmap */
+		spin_lock_irq(&cinfo->suspend_lock);
+		list_for_each_entry_safe(s, tmp, &cinfo->suspend_list, list)
+			if (slot =3D=3D s->slot) {
+				list_del(&s->list);
+				kfree(s);
+			}
+		spin_unlock_irq(&cinfo->suspend_lock);
+
 		if (hi > 0) {
 			/* TODO:Wait for current resync to get over */
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
--=20
2.17.1
