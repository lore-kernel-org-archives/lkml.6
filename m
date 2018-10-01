Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5BC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BB820840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N/JsF+/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BB820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeJAHZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:25:41 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729247AbeJAHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwI1rq22STASm5H7FJCCjy4XD53L5x4x7mv3bQkrB9Y=;
 b=N/JsF+/IYCgJVVNrGbQ0PG6lI0lL/FxQh3rug4m55EjXyZ4qV09gCoV+4Sz+G0MoUfOlgebEzNLT5VDkewiz64CjIo4P4+VUL+9WtPKvlnpPKYxviWSw0x2KOiaF3EJcT/1slM4epJzcZ03CBvt+S4GVwv7/gAxMbHOWRIeQp/w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joe Thornber <ejt@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/65] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Topic: [PATCH AUTOSEL 4.18 48/65] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Index: AQHUWR8UrmmcYWZblUyH/papqFqAmg==
Date:   Mon, 1 Oct 2018 00:38:32 +0000
Message-ID: <20181001003754.146961-48-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:Rbhxnst9RIiZUnH2dDpSZKo3k/OFA+BR34z+XdserxiPtAx6s6APQtYmTMkYjnfNZ0L0FCuAqcc8NHSYeAlmKtSrEaEm2kuiPA8+oYNRj0nQr0lUomoRnagdkTWcxlmgk6Tl638b47VlU21L3s1xpUqMeSlHHbsJD7gyP1A3GNcl46gS2LT9ik+uBh+C6WBx//AsvhP3of9NToufvMgSL+pG9wz3J1K7IJN4xaVfvypr+jJD9bhzwcna4+xMyQCAg3We0I9ZK5gVv8qLZbcsz6S8lne/fx+O2k7pyUa/5kYVuDTxoVVpEEcIJGVNueHHv9AoQMC7b0ZzZEw10tVSnMPG04GWDS7fY5aXUubB0LfGHDGhgzRS6vxMltTVk3s3UkSNGD72iZ57u1jTAGsweTWI23DJm/XcegHReaF3FGlUY5aZF8OQZ3C3piHtXb1gZnMkaXIQoWcyKnN6zT1ZJg==;5:2OfE2R6eTy+1K4pP40EtM+gi13Qnv/d6XbLRIp1yglr/lg0wsgteAJAnS4HBUcf52Tw4fuztFyOvKYm7GRYVwdWQ9Lssuxc2+QOFx8jqGyY9xdSRQfmT2gN8yK/c9DNSvd5eM5dUbNybi8cNIQd50JMhccOx18+srNC82uhY5zE=;7:+pHdzDsRlI+ZgwFNnZTTZcgkRRPHqH/NGxNSS5h9evrLg5IwbR57jEQSlwEhZ+nnBvf5n/1+6KJmYeeN8bhhgGqCnWSlelnQ+0KVsffYViuQPCsZjTRurSQ5O9N9oqdlYg1Dq7yc6MgjC2MdkXSJN6KiYw4sxutKuFcB4/dLbYghhX/msxecQHWvLGjSQLa38BZnU6ZGePjw30RHu9HuiiP9KPrO+/9tV1lHdBWWSb/2bA4rD5WSYwaLI6i/f83m
x-ms-office365-filtering-correlation-id: 2f9527eb-b00e-49db-9e09-08d627364855
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082460F5BAAD1D62FD20B70FFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(551934003)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wZlNcu2CKfOk43eVtLU99ikBb+gbO3sVaBIP9hNfiXult+m/suEg9w4N16x2zcwjFjWioO84u4UN7v6s8ZYhUfmoRwbdSrNMgGVQ6hkA6f/T7Xnv1nNRCuq26Muz7Y1h6Fu3pbMr4fCaeuCRcEyTCjxKvhxOK7XwFJ0qfWdwROE0bGmu+syCORSSgSfQm7H83OMjmKLTH2Le6mtwYAzs1tpytwuH/TiJKBh8dfhU1byLyXrh0HQxfkQl6il/9Fge24Bx9vPg28lbdesdBJR+4bCLEHBTglqvmwR+R5uCjjM2kaAy11L+fQsMWIBgr4KIa5kwV7OCsZL6c13833k9tGflU1UVl7R9mTXmnlI5x18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9527eb-b00e-49db-9e09-08d627364855
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:32.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 72142021b5c9..74f6770c70b1 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -188,6 +188,12 @@ struct dm_pool_metadata {
 	unsigned long flags;
 	sector_t data_block_size;
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
@@ -816,6 +822,22 @@ static int __commit_transaction(struct dm_pool_metadat=
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
@@ -849,6 +871,8 @@ struct dm_pool_metadata *dm_pool_metadata_open(struct b=
lock_device *bdev,
 		return ERR_PTR(r);
 	}
=20
+	__set_metadata_reserve(pmd);
+
 	return pmd;
 }
=20
@@ -1820,6 +1844,13 @@ int dm_pool_get_free_metadata_block_count(struct dm_=
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
@@ -1932,8 +1963,11 @@ int dm_pool_resize_metadata_dev(struct dm_pool_metad=
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
index 1087f6a1ac79..b512efd4050c 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -200,7 +200,13 @@ struct dm_thin_new_mapping;
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
@@ -1388,7 +1394,35 @@ static void set_pool_mode(struct pool *pool, enum po=
ol_mode new_mode);
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
@@ -1414,14 +1448,16 @@ static int commit(struct pool *pool)
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
@@ -1487,6 +1523,19 @@ static int alloc_data_block(struct thin_c *tc, dm_bl=
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
@@ -1518,6 +1567,7 @@ static blk_status_t should_error_unserviceable_bio(st=
ruct pool *pool)
 	case PM_OUT_OF_DATA_SPACE:
 		return pool->pf.error_if_no_space ? BLK_STS_NOSPC : 0;
=20
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
 	case PM_FAIL:
 		return BLK_STS_IOERR;
@@ -2481,8 +2531,9 @@ static void set_pool_mode(struct pool *pool, enum poo=
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
@@ -3420,6 +3471,10 @@ static int maybe_resize_metadata_dev(struct dm_targe=
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
@@ -3724,7 +3779,7 @@ static int pool_message(struct dm_target *ti, unsigne=
d argc, char **argv,
 	struct pool_c *pt =3D ti->private;
 	struct pool *pool =3D pt->pool;
=20
-	if (get_pool_mode(pool) >=3D PM_READ_ONLY) {
+	if (get_pool_mode(pool) >=3D PM_OUT_OF_METADATA_SPACE) {
 		DMERR("%s: unable to service pool target messages in READ_ONLY or FAIL m=
ode",
 		      dm_device_name(pool->pool_md));
 		return -EOPNOTSUPP;
@@ -3798,6 +3853,7 @@ static void pool_status(struct dm_target *ti, status_=
type_t type,
 	dm_block_t nr_blocks_data;
 	dm_block_t nr_blocks_metadata;
 	dm_block_t held_root;
+	enum pool_mode mode;
 	char buf[BDEVNAME_SIZE];
 	char buf2[BDEVNAME_SIZE];
 	struct pool_c *pt =3D ti->private;
@@ -3868,9 +3924,10 @@ static void pool_status(struct dm_target *ti, status=
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
