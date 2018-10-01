Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A7C64EB2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC292083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VS/iL2QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC292083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeJAHRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:10 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbeJAHRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHtmaB/oQzGXkhB0Bqoc1ibnV+OS14kMuQhv8TslEkM=;
 b=VS/iL2QIq847RIbSw9H32sHfXGVYQeIAk/BLBL1Pc894u4/GaqerwVSnOAD0gK6U2qXl8LhPvyQmOQ0G5tiB8DcGFCdrVvmB2zL0g7DQoQjYJibDakTiyWJSghOxmQ8ipwcqdOs1GrZaVeEctMRDn9MBMyUrZ3xug7lZaF1f934=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joe Thornber <ejt@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 06/13] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Topic: [PATCH AUTOSEL 3.18 06/13] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Index: AQHUWR+ImJu1mtIlV0akAdLTdFoPJw==
Date:   Mon, 1 Oct 2018 00:41:47 +0000
Message-ID: <20181001004139.147341-6-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:BABAFAf5GhuSdyolhQpORmw8rayqObokQnRaCZimfsYHdc9bAxBpPRSIepCmooEhQ4+H8Gyf9LWo8fHuhmLviz7aAbZv5XwPq5Gel4YZLpNThu4kEKgqO0lqHO2UfOJG50QSeZ4UZ1mLKJfqG5lwdHaVn2BLqP9XLiK/W7mfJgEZ4ioCGovuFAuUD21uQG2PbcB99of6Xvj1ehFnw3BWP2WLJ9crnbxBue8N3bpzlbOF59cVFY9f4ktRoHmtLR7uFYtrifWF1iYJzY22ATYGnA/0zKEUTYuzJs7VK8hbtZJZ12FHd33SxhCyGmXwyAJigXjdGG/5/uqKR1EWUUOM1vNC99ed3yQRTLzoT01yKpwLOzvCUecwvu6oQCiEsdC+7uJZbhC5ri0dy8JoQKSknXzvjbaTim0C/bsAGPwNSGq83d77qw90IcnvwL/lH/8pa6i99KCcufevpWBldu8How==;5:kHrqcnPZls0NEOsAHss2XfC6Jc5I+DKciXfrURr2AXtVuWv1DLdEllgWfCDRceidN/i8jnUrs9JTcO8eO+rEGYTI5CAFhtRQETJKg18ytDDD748+OZV6HqBmTbMXvpAl7n+aKAetQpSojndeFioK/Z5X45f1mKLVc7ElQ9eeJT8=;7:l6/LMvrebdOOkE69BzKmwQJl09HHp7XMcyJP8FFU/5iXuS2hgHRGFhD83nUkf7C9Hp5+IpfI6m+urxl9Dc1Fl7Cv6iLeFhlnZNVMo0hdeCmsIFKmi2QXylGmuqYYqXleBPXIHa4wzMwFLSm93fS7ly5hC5tkljuF2HKflyW3ViwZORUuUgqk12/mzESdSMpajhOs/XZq+GGXWAHaMW6OpVtz2wQfTQL0ahVfTT5y9RHSBqrCE3DRT7oiLKGtf3FL
x-ms-office365-filtering-correlation-id: a86dbe2b-d0da-449c-94a5-08d62736ab49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07919D55C8F100F1184DB860FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(551934003)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bf+YKMB2ECMAFvzWsMzriAUIHTV4P74pO83ptCHxSw02nif9jHDQZdKL2nIfShMfNbF1rJB4bItk1/5qg+hQnzCkxI3KgiKsRVlukI2V7RcwHfOCvEiyCAg3tqb4suwQNcXyLfVJUpB4JKC+PwQX4p1S2YMxK4w+5p+rV+ABPORZ6eSpVe67JkKn+FMlfdq08ahyJHjnqOUeGeb15EZ51BoH+GELUKzGb1Q9sJEyupX+Ktjw68m6xcE8neo90XedWLQfstU45VplGbUchQ9x8doSQdrVdJrj9z2zmY6VhKU6o122Rq1dp2hBlQz3g3QMzhrIg5QBAgZNpzRxWCBdabCCf3ly37GhU4g2rPDcbL4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86dbe2b-d0da-449c-94a5-08d62736ab49
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:47.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

[ Upstream commit 3ab91828166895600efd9cdc3a0eb32001f7204a ]

Committing a transaction can consume some metadata of it's own, we now
reserve a small amount of metadata to cover this.  Free metadata
reported by the kernel will not include this reserve.

If any of the reserve has been used after a commit we enter a new
internal state PM_OUT_OF_METADATA_SPACE.  This is reported as
PM_READ_ONLY, so no userland changes are needed.  If the metadata
device is resized the pool will move back to PM_WRITE.

These changes mean we never need to abort and rollback a transaction due
to running out of metadata space.  This is particularly important
because there have been a handful of reports of data corruption against
DM thin-provisioning that can all be attributed to the thin-pool having
ran out of metadata space.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-thin-metadata.c | 36 ++++++++++++++++-
 drivers/md/dm-thin.c          | 73 +++++++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 3f3ab7586dc0..096de9433da2 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -190,6 +190,12 @@ struct dm_pool_metadata {
 	sector_t data_block_size;
 	bool read_only:1;
=20
+	/*
+	 * We reserve a section of the metadata for commit overhead.
+	 * All reported space does *not* include this.
+	 */
+	dm_block_t metadata_reserve;
+
 	/*
 	 * Set if a transaction has to be aborted but the attempt to roll back
 	 * to the previous (good) transaction failed.  The only pool metadata
@@ -824,6 +830,22 @@ static int __commit_transaction(struct dm_pool_metadat=
a *pmd)
 	return dm_tm_commit(pmd->tm, sblock);
 }
=20
+static void __set_metadata_reserve(struct dm_pool_metadata *pmd)
+{
+	int r;
+	dm_block_t total;
+	dm_block_t max_blocks =3D 4096; /* 16M */
+
+	r =3D dm_sm_get_nr_blocks(pmd->metadata_sm, &total);
+	if (r) {
+		DMERR("could not get size of metadata device");
+		pmd->metadata_reserve =3D max_blocks;
+	} else {
+		sector_div(total, 10);
+		pmd->metadata_reserve =3D min(max_blocks, total);
+	}
+}
+
 struct dm_pool_metadata *dm_pool_metadata_open(struct block_device *bdev,
 					       sector_t data_block_size,
 					       bool format_device)
@@ -858,6 +880,8 @@ struct dm_pool_metadata *dm_pool_metadata_open(struct b=
lock_device *bdev,
 		return ERR_PTR(r);
 	}
=20
+	__set_metadata_reserve(pmd);
+
 	return pmd;
 }
=20
@@ -1625,6 +1649,13 @@ int dm_pool_get_free_metadata_block_count(struct dm_=
pool_metadata *pmd,
 	down_read(&pmd->root_lock);
 	if (!pmd->fail_io)
 		r =3D dm_sm_get_nr_free(pmd->metadata_sm, result);
+
+	if (!r) {
+		if (*result < pmd->metadata_reserve)
+			*result =3D 0;
+		else
+			*result -=3D pmd->metadata_reserve;
+	}
 	up_read(&pmd->root_lock);
=20
 	return r;
@@ -1746,8 +1777,11 @@ int dm_pool_resize_metadata_dev(struct dm_pool_metad=
ata *pmd, dm_block_t new_cou
 	int r =3D -EINVAL;
=20
 	down_write(&pmd->root_lock);
-	if (!pmd->fail_io)
+	if (!pmd->fail_io) {
 		r =3D __resize_space_map(pmd->metadata_sm, new_count);
+		if (!r)
+			__set_metadata_reserve(pmd);
+	}
 	up_write(&pmd->root_lock);
=20
 	return r;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 0e8d19b65678..68c7102a64c8 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -140,7 +140,13 @@ struct dm_thin_new_mapping;
 enum pool_mode {
 	PM_WRITE,		/* metadata may be changed */
 	PM_OUT_OF_DATA_SPACE,	/* metadata may be changed, though data may not be =
allocated */
+
+	/*
+	 * Like READ_ONLY, except may switch back to WRITE on metadata resize. Re=
ported as READ_ONLY.
+	 */
+	PM_OUT_OF_METADATA_SPACE,
 	PM_READ_ONLY,		/* metadata may not be changed */
+
 	PM_FAIL,		/* all I/O fails */
 };
=20
@@ -994,7 +1000,35 @@ static void set_pool_mode(struct pool *pool, enum poo=
l_mode new_mode);
=20
 static void requeue_bios(struct pool *pool);
=20
-static void check_for_space(struct pool *pool)
+static bool is_read_only_pool_mode(enum pool_mode mode)
+{
+	return (mode =3D=3D PM_OUT_OF_METADATA_SPACE || mode =3D=3D PM_READ_ONLY)=
;
+}
+
+static bool is_read_only(struct pool *pool)
+{
+	return is_read_only_pool_mode(get_pool_mode(pool));
+}
+
+static void check_for_metadata_space(struct pool *pool)
+{
+	int r;
+	const char *ooms_reason =3D NULL;
+	dm_block_t nr_free;
+
+	r =3D dm_pool_get_free_metadata_block_count(pool->pmd, &nr_free);
+	if (r)
+		ooms_reason =3D "Could not get free metadata blocks";
+	else if (!nr_free)
+		ooms_reason =3D "No free metadata blocks";
+
+	if (ooms_reason && !is_read_only(pool)) {
+		DMERR("%s", ooms_reason);
+		set_pool_mode(pool, PM_OUT_OF_METADATA_SPACE);
+	}
+}
+
+static void check_for_data_space(struct pool *pool)
 {
 	int r;
 	dm_block_t nr_free;
@@ -1020,14 +1054,16 @@ static int commit(struct pool *pool)
 {
 	int r;
=20
-	if (get_pool_mode(pool) >=3D PM_READ_ONLY)
+	if (get_pool_mode(pool) >=3D PM_OUT_OF_METADATA_SPACE)
 		return -EINVAL;
=20
 	r =3D dm_pool_commit_metadata(pool->pmd);
 	if (r)
 		metadata_operation_failed(pool, "dm_pool_commit_metadata", r);
-	else
-		check_for_space(pool);
+	else {
+		check_for_metadata_space(pool);
+		check_for_data_space(pool);
+	}
=20
 	return r;
 }
@@ -1093,6 +1129,19 @@ static int alloc_data_block(struct thin_c *tc, dm_bl=
ock_t *result)
 		return r;
 	}
=20
+	r =3D dm_pool_get_free_metadata_block_count(pool->pmd, &free_blocks);
+	if (r) {
+		metadata_operation_failed(pool, "dm_pool_get_free_metadata_block_count",=
 r);
+		return r;
+	}
+
+	if (!free_blocks) {
+		/* Let's commit before we use up the metadata reserve. */
+		r =3D commit(pool);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
=20
@@ -1124,6 +1173,7 @@ static int should_error_unserviceable_bio(struct pool=
 *pool)
 	case PM_OUT_OF_DATA_SPACE:
 		return pool->pf.error_if_no_space ? -ENOSPC : 0;
=20
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
 	case PM_FAIL:
 		return -EIO;
@@ -1823,8 +1873,9 @@ static void set_pool_mode(struct pool *pool, enum poo=
l_mode new_mode)
 		error_retry_list(pool);
 		break;
=20
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
-		if (old_mode !=3D new_mode)
+		if (!is_read_only_pool_mode(old_mode))
 			notify_of_pool_mode_change(pool, "read-only");
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio =3D process_bio_read_only;
@@ -2727,6 +2778,10 @@ static int maybe_resize_metadata_dev(struct dm_targe=
t *ti, bool *need_commit)
 		DMINFO("%s: growing the metadata device from %llu to %llu blocks",
 		       dm_device_name(pool->pool_md),
 		       sb_metadata_dev_size, metadata_dev_size);
+
+		if (get_pool_mode(pool) =3D=3D PM_OUT_OF_METADATA_SPACE)
+			set_pool_mode(pool, PM_WRITE);
+
 		r =3D dm_pool_resize_metadata_dev(pool->pmd, metadata_dev_size);
 		if (r) {
 			metadata_operation_failed(pool, "dm_pool_resize_metadata_dev", r);
@@ -2974,7 +3029,7 @@ static int pool_message(struct dm_target *ti, unsigne=
d argc, char **argv)
 	struct pool_c *pt =3D ti->private;
 	struct pool *pool =3D pt->pool;
=20
-	if (get_pool_mode(pool) >=3D PM_READ_ONLY) {
+	if (get_pool_mode(pool) >=3D PM_OUT_OF_METADATA_SPACE) {
 		DMERR("%s: unable to service pool target messages in READ_ONLY or FAIL m=
ode",
 		      dm_device_name(pool->pool_md));
 		return -EINVAL;
@@ -3047,6 +3102,7 @@ static void pool_status(struct dm_target *ti, status_=
type_t type,
 	dm_block_t nr_blocks_data;
 	dm_block_t nr_blocks_metadata;
 	dm_block_t held_root;
+	enum pool_mode mode;
 	char buf[BDEVNAME_SIZE];
 	char buf2[BDEVNAME_SIZE];
 	struct pool_c *pt =3D ti->private;
@@ -3117,9 +3173,10 @@ static void pool_status(struct dm_target *ti, status=
_type_t type,
 		else
 			DMEMIT("- ");
=20
-		if (pool->pf.mode =3D=3D PM_OUT_OF_DATA_SPACE)
+		mode =3D get_pool_mode(pool);
+		if (mode =3D=3D PM_OUT_OF_DATA_SPACE)
 			DMEMIT("out_of_data_space ");
-		else if (pool->pf.mode =3D=3D PM_READ_ONLY)
+		else if (is_read_only_pool_mode(mode))
 			DMEMIT("ro ");
 		else
 			DMEMIT("rw ");
--=20
2.17.1
