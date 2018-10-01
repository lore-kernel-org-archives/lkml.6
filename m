Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516EDC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A0720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OGJ1HpMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A0720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeJAHPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:55 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbeJAHPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BwKA25tJbcg1akd3J0sq8E1/qjYYCMAS+URUgJ+x9M=;
 b=OGJ1HpMoEiKYyM8993O8SBG9XsNoM0sQkXRX4eq2nc16Z65IBPGKUeuT4XZS4fwfL4UKnfqEag6183HK+t6v0a5o5VCbb/grQJ1303UOs/sEXeX22qu76oasNW2vt5BPDQ9aNMPZY9FcSM93RA81qLbK5UPERCc3Zs97G94qpeo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joe Thornber <ejt@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/26] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Topic: [PATCH AUTOSEL 4.9 16/26] dm thin metadata: try to avoid ever
 aborting transactions
Thread-Index: AQHUWR9f73Hde/YjdUuZxiL6pxOPgA==
Date:   Mon, 1 Oct 2018 00:40:38 +0000
Message-ID: <20181001004026.147201-16-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:p1LFB6bfOEeao2VN2HnQWLzpCgTYHnD07HHne5ZwF2A1VlIfxB58Fb1G7rzjnc9FQ7AJi+kaifcrSl4U/czA8UnGbfA/A5UxGw08hGcTTQat9oszDTLiMYZEjR8IMhmk/O4npYZgQFncr86Gm6N5Bkem4GAvNS1HCZPIYUP8LhIWmqNWr0Rg7o07XGcouaHAVVvLOSfMVuEL6Dy8JQRUqO6E1FpwJvc4S/uYzhegJsUwLTkw8vCIMYUyx1X2/vrLxcQ2XhOGvhvdOT85xdnQNV+fk7pIizyFJOx6tZE8qT8S6AZWqFUljWMvEfVSQwQg/kzF3i7wdL3lxk98ggHbCu8829urXlmvN0y9mXf32ZV0532iArhd0DCYx2FER+Dw3cXsft8Hl4RyEOdY4wckR/IJ+JL00rTeVoSeXRQvlopdzYFFXxTbv+0oXFSFjZv93UKwUII21BDPxR7kciINRg==;5:Jv+1V9ZiwkjlcUOSJlK5p3POF6epww1L7UfAR68nPlKuFJ6zbwcFfzg2lBC64Hm3AGhPNObz97aTO32W3oroEvpZSoaohqyVJ0zzwNTShWkx3k2UyZuVQDwcLIXDTO1EeHU4Ic4on+gtZJIHZ/TFtX58vzhqOnJ6s/wdYlfxr1g=;7:ZWiZ+upD6Wzm8htsqaOjh21CjjBsX449QVcEW2nasrnHgw4q23UXXIXhqU00GvMyB2MEzlGPOothZo7z8zNBAOLyt1wrEiyU5zA28sZxpKtKeLHCRXxhDnAAoi2IhLFQNXaSYg8iY64cBluqdaJvG3ZzNaot6WwBY95qYyDe76jEmFqHHXx4D70r70pJfmdxNfvmpywV8jj4KSTVeebBySTbeLEzO1t9SkmnI9cIjJGIkWZdF/W/fwrWx+xQEQvH
x-ms-office365-filtering-correlation-id: 4526c231-abe5-41f2-3aef-08d627368259
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165F5E2B6114F1F21EE35EFFBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(551934003)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vlD23U52oc+oyAtZQuUBCE9e6Wvbj0T1X588rynjU40CtU6Jj19HyS1SU/7ASokjBu6Q1TlqTY5TWZ/W7siooLtwZIV6FCLP2nV5GNvAK3QreFvrpCcbInCInUkGkXhGT3zs6fqoV+dkl7sXYXn3E4bKSiZxoAuFH8y5pWqD8BVMm+QHGhBkH1bouAXMNWamhkk2ioaS8uF67m2zV0sM8Dr+VqzqF2tixAkclm72XHRSKAYpreRJibS45/5OjqQ0Z4OVKvuJ2pBMbtvM65XdK9sitylKyUAc7fAtS5OSNeZLyaed4WzqsrteTc//BAsUbvy9EdfnodXX3a9nUcVdvLglzdm6furVJ7wpUOjLKUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526c231-abe5-41f2-3aef-08d627368259
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:38.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index e976f4f39334..7e0ccb6fee9d 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -189,6 +189,12 @@ struct dm_pool_metadata {
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
@@ -827,6 +833,22 @@ static int __commit_transaction(struct dm_pool_metadat=
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
@@ -860,6 +882,8 @@ struct dm_pool_metadata *dm_pool_metadata_open(struct b=
lock_device *bdev,
 		return ERR_PTR(r);
 	}
=20
+	__set_metadata_reserve(pmd);
+
 	return pmd;
 }
=20
@@ -1831,6 +1855,13 @@ int dm_pool_get_free_metadata_block_count(struct dm_=
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
@@ -1943,8 +1974,11 @@ int dm_pool_resize_metadata_dev(struct dm_pool_metad=
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
index a952ad890f32..81309d7836c5 100644
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
@@ -1386,7 +1392,35 @@ static void set_pool_mode(struct pool *pool, enum po=
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
@@ -1412,14 +1446,16 @@ static int commit(struct pool *pool)
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
@@ -1485,6 +1521,19 @@ static int alloc_data_block(struct thin_c *tc, dm_bl=
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
@@ -1516,6 +1565,7 @@ static int should_error_unserviceable_bio(struct pool=
 *pool)
 	case PM_OUT_OF_DATA_SPACE:
 		return pool->pf.error_if_no_space ? -ENOSPC : 0;
=20
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
 	case PM_FAIL:
 		return -EIO;
@@ -2479,8 +2529,9 @@ static void set_pool_mode(struct pool *pool, enum poo=
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
@@ -3418,6 +3469,10 @@ static int maybe_resize_metadata_dev(struct dm_targe=
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
@@ -3721,7 +3776,7 @@ static int pool_message(struct dm_target *ti, unsigne=
d argc, char **argv)
 	struct pool_c *pt =3D ti->private;
 	struct pool *pool =3D pt->pool;
=20
-	if (get_pool_mode(pool) >=3D PM_READ_ONLY) {
+	if (get_pool_mode(pool) >=3D PM_OUT_OF_METADATA_SPACE) {
 		DMERR("%s: unable to service pool target messages in READ_ONLY or FAIL m=
ode",
 		      dm_device_name(pool->pool_md));
 		return -EOPNOTSUPP;
@@ -3795,6 +3850,7 @@ static void pool_status(struct dm_target *ti, status_=
type_t type,
 	dm_block_t nr_blocks_data;
 	dm_block_t nr_blocks_metadata;
 	dm_block_t held_root;
+	enum pool_mode mode;
 	char buf[BDEVNAME_SIZE];
 	char buf2[BDEVNAME_SIZE];
 	struct pool_c *pt =3D ti->private;
@@ -3865,9 +3921,10 @@ static void pool_status(struct dm_target *ti, status=
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
