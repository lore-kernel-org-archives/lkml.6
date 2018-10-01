Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBAFC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F10208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jLNMrHCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F10208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJAHNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:36 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:39861
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeJAHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJcguG1kCdgWJY7bfz3AGYDa1Hu0Vsp/lxvVlwnuo+Y=;
 b=jLNMrHCA/NcvMTeszGOMxOSgKQBA8DVsMwAlNuoHjzP0i3Lag1DuxyZENr0N9DarWYagnDZSXcA9fm1upZgAaQ9AOVDSr581R0XyYXh2IuHd8dMWCfbpXgCM0vpJxYa3K+pr++0Xnig3OHWtgYWpE1S64zm25lzPBEfQcn6tVaY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/65] dm raid: fix reshape race on small devices
Thread-Topic: [PATCH AUTOSEL 4.18 29/65] dm raid: fix reshape race on small
 devices
Thread-Index: AQHUWR8NdPfXfjjJPU+UI4Vv7mDW/w==
Date:   Mon, 1 Oct 2018 00:38:20 +0000
Message-ID: <20181001003754.146961-29-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:fF4PN9WwdukkKR6ew4yTpC5Kw39Afkno91gHj/gHOYVfMyCVXDFbGbs1g64dSm8Gm1Bs39MpnFkGlGUoDJVgrPS/bWIb2Do+ZvlEJO69rkrv37PBUiF14F0xJTyrMHVpqApEr6N5bOnCYKdfMRwRcXWK3/74vt1+c3SZTXhrhIHUdssRAze0+LsvpC9MCEULOZQKPyy5ipM+SPUGQdyN6RLxTP9f3+yxoEM2B+DQSMP3BLjA30l+j0MNonMbKRLi1wET2Y4muuvpWgN9MHqg7/6rVcbXrP3L+QEDTpAzo+VVHVTT+OnY0NOHmRJ5xWlOJX0yFp7KwpuIGeqQjO4wIMlCXKxgOiAGxN4AxDo2jZnSPdTWODM9osLIB+SQt9EUxdvsGbx7m+k3RF8aOGWnQLH3/45JBMo4M8F9PaC9WTLy1Q0N13UacxANLVoekGoAxKf/6M9wnMUHUHPnz08d+w==;5:+dzGjsodfCFsoToiqHf5FhUm26DmK3o6P7Y6DEctzvim3Xipyi8SG05A+ffA2xahdbdrCAprnEbI9B0JR1sJi9ygtM0xmjavDqn12tDEXRb8kOq29tArkQOBdIrxTpssUBclPzeA1J8bNjG0M8KJ9++PWI4Jhk5NeMDFcSEzboo=;7:uPFFNuG2PO1ougmagpgdM+a9cJf9J4boDAUvam9ujnx2DeyfZ1qxkTEtkQiWyxBn6QUAp0JMKIJYsKyHBy0TlssYPMCrd27PwYtAW2YglN20oMvpTdpyTgcEvFiLjBO8TZetqgg19HdcwdSOdUmyUzqkIcdy03UoeH3H0xp6PPvuyLg7teNsBdnyVNm2zGh4C6SpNpGJttu6Wg/SQZ5jOk62ujQId78gVPIR7pUfZ/oKF493HDrKbAf2I60oogIZ
x-ms-office365-filtering-correlation-id: 5babd119-917f-4cd5-f10f-08d62736303d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01813A77EFA827351F5BA959FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ANQZgv68SUK8UOGeeH1YQdanTOqSlK13btzdoaQi+fO6s2ddb5/PAdM4+pKCi0B71yhcJCQnAcOxh/jII5px1+xo841DKnub6htZ7zSytc7pAiNaH5k6kOQI2LHBvkNN9rBUvxb0tnE7RzDHj9H3yMfLPKpd1Cg64haCN3XXBXE5qDCvKPQhZhskI50xDlZ6pAGz58bx6VHE2awcVTwmmDZx5CR2TLjnYZh2JHB1TO3rpTPag5p72aXcZDvb6Ak+VLm3PwwBhU6ERIukt3CyzMIsEwgv0FWELuA8CxhfJRD/Fnn2zOS3md+0Ni45Io8yBOwXxN+vGuqSG/WMSz3/eBrW3m5cNMbHPqfeUmyMvJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5babd119-917f-4cd5-f10f-08d62736303d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:20.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 38b0bd0cda07d34ad6f145fce675ead74739c44e ]

Loading a new mapping table, the dm-raid target's constructor
retrieves the volatile reshaping state from the raid superblocks.

When the new table is activated in a following resume, the actual
reshape position is retrieved.  The reshape driven by the previous
mapping can already have finished on small and/or fast devices thus
updating raid superblocks about the new raid layout.

This causes the actual array state (e.g. stripe size reshape finished)
to be inconsistent with the one in the new mapping, causing hangs with
left behind devices.

This race does not occur with usual raid device sizes but with small
ones (e.g. those created by the lvm2 test suite).

Fix by no longer transferring stale/inconsistent raid_set state during
preresume.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 48 +-------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 75df4c9d8b54..0d30958dc78f 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -29,9 +29,6 @@
  */
 #define	MIN_RAID456_JOURNAL_SPACE (4*2048)
=20
-/* Global list of all raid sets */
-static LIST_HEAD(raid_sets);
-
 static bool devices_handle_discard_safely =3D false;
=20
 /*
@@ -227,7 +224,6 @@ struct rs_layout {
=20
 struct raid_set {
 	struct dm_target *ti;
-	struct list_head list;
=20
 	uint32_t stripe_cache_entries;
 	unsigned long ctr_flags;
@@ -273,19 +269,6 @@ static void rs_config_restore(struct raid_set *rs, str=
uct rs_layout *l)
 	mddev->new_chunk_sectors =3D l->new_chunk_sectors;
 }
=20
-/* Find any raid_set in active slot for @rs on global list */
-static struct raid_set *rs_find_active(struct raid_set *rs)
-{
-	struct raid_set *r;
-	struct mapped_device *md =3D dm_table_get_md(rs->ti->table);
-
-	list_for_each_entry(r, &raid_sets, list)
-		if (r !=3D rs && dm_table_get_md(r->ti->table) =3D=3D md)
-			return r;
-
-	return NULL;
-}
-
 /* raid10 algorithms (i.e. formats) */
 #define	ALGORITHM_RAID10_DEFAULT	0
 #define	ALGORITHM_RAID10_NEAR		1
@@ -764,7 +747,6 @@ static struct raid_set *raid_set_alloc(struct dm_target=
 *ti, struct raid_type *r
=20
 	mddev_init(&rs->md);
=20
-	INIT_LIST_HEAD(&rs->list);
 	rs->raid_disks =3D raid_devs;
 	rs->delta_disks =3D 0;
=20
@@ -782,9 +764,6 @@ static struct raid_set *raid_set_alloc(struct dm_target=
 *ti, struct raid_type *r
 	for (i =3D 0; i < raid_devs; i++)
 		md_rdev_init(&rs->dev[i].rdev);
=20
-	/* Add @rs to global list. */
-	list_add(&rs->list, &raid_sets);
-
 	/*
 	 * Remaining items to be initialized by further RAID params:
 	 *  rs->md.persistent
@@ -797,7 +776,7 @@ static struct raid_set *raid_set_alloc(struct dm_target=
 *ti, struct raid_type *r
 	return rs;
 }
=20
-/* Free all @rs allocations and remove it from global list. */
+/* Free all @rs allocations */
 static void raid_set_free(struct raid_set *rs)
 {
 	int i;
@@ -815,8 +794,6 @@ static void raid_set_free(struct raid_set *rs)
 			dm_put_device(rs->ti, rs->dev[i].data_dev);
 	}
=20
-	list_del(&rs->list);
-
 	kfree(rs);
 }
=20
@@ -3947,29 +3924,6 @@ static int raid_preresume(struct dm_target *ti)
 	if (test_and_set_bit(RT_FLAG_RS_PRERESUMED, &rs->runtime_flags))
 		return 0;
=20
-	if (!test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags)) {
-		struct raid_set *rs_active =3D rs_find_active(rs);
-
-		if (rs_active) {
-			/*
-			 * In case no rebuilds have been requested
-			 * and an active table slot exists, copy
-			 * current resynchonization completed and
-			 * reshape position pointers across from
-			 * suspended raid set in the active slot.
-			 *
-			 * This resumes the new mapping at current
-			 * offsets to continue recover/reshape without
-			 * necessarily redoing a raid set partially or
-			 * causing data corruption in case of a reshape.
-			 */
-			if (rs_active->md.curr_resync_completed !=3D MaxSector)
-				mddev->curr_resync_completed =3D rs_active->md.curr_resync_completed;
-			if (rs_active->md.reshape_position !=3D MaxSector)
-				mddev->reshape_position =3D rs_active->md.reshape_position;
-		}
-	}
-
 	/*
 	 * The superblocks need to be updated on disk if the
 	 * array is new or new devices got added (thus zeroed
--=20
2.17.1
