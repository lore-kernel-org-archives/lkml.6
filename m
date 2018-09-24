Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BDECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383222098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Or0alF8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383222098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeIXUvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:16 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com ([40.107.72.120]:39245
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730010AbeIXUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkpVByoN7HmxmU/RvThrxgKkoNEK1rEQxppD84qYavg=;
 b=Or0alF8o/zVAPpOvtGDjrtarIRtJ2TVynm/CoD8JDXXqcqXAouzUgOD2EK2RysFa8K9iLUwK22t0ow0Zf7KXyLNGEUtio653BWBS98r/GHVFfF9LfX06dBPZ50uwSYu5iCm5LhRIR8TJCRyASIW9s4iNjRtViRrT++kIOcPpk6o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robbie Ko <robbieko@synology.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/76] Btrfs: fix unexpected failure of nocow
 buffered writes after snapshotting when low on space
Thread-Topic: [PATCH AUTOSEL 4.18 03/76] Btrfs: fix unexpected failure of
 nocow buffered writes after snapshotting when low on space
Thread-Index: AQHUVBWXx0iT/H9gQEmnsooI5DlGkw==
Date:   Mon, 24 Sep 2018 14:48:01 +0000
Message-ID: <20180924144751.164410-3-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:eAuHC9zR9r5it1ZHqVL67V+ergaASePp7wgiy/Ak+SfDrm0X3+X333Tzy2iETkm3D9mpxMAKJlNhGCEATWGcXZO0L8/2E6Rv2ymntoKUFUqT+IQt6QgUjLzk9mknYY1pJvaDC3pUZM/imCZhxWSEapLV24XoS5L0NtOvbczBgM+yFeK+Ey8Tj5Z743s5vd2OBBY9CUSILvzcadMxFQAnm4CeRbT34fwoQwMtBwfFpgt52qvNDemn3Ylb8Xx7wzEJ5JpA2G+lBSP2cHHSAFbWpHgQspqdI7P04NoismU6p+Xe7i5/94WoFBc09SwnG903XYg23VpiPtEI/m2+6tFTHyQKLxNMRKopZEdgLSpapXiEpDvUeTzYKo4OfAnsbbIbB7PiS0BNQHZcSMdrlthVnVx8tC2j1MRfj9U6YWEbRB/1Jh/tM+NulPpnMBPumrht9aA4Fl8ktVTkwMtf8KhUzA==;5:uzbgLbsmYsN6v68Y8+ffewozrobv09uYAmJGZE0DfcZs6dBi1dz66kKNQSRPsCaGklYEeNp8gJHV+X34BjTBlru1zNDrGxd6ZeNWqJ0CSzQ7pOxObDsrtRgdhcBYIss5GCSPCUKAKlwFpx8bseVgjzL31jk5DLldt4kI2w8dSEk=;7:zvD0jsHRk3VhWvv6JWQ5RjVC9z9T9utwzJ+tfOTK5cSSr9bbNH2lGAX+Ys9eH9A+BLJnI/wJedWLwNYOI+NZN22zFkOBWovCaG2I6GY8v4cXa2rXWpdhGoiKmudbMK+zO4BBQmXe7bS507yI1Ymow9SmMtWKqWJ1KndiJupL/zm5VpcoriVbjEk/2mJOVrCokw/z4sCC9ktEHODmlCqpLXeqCw22ANq5BHVy0xC5dZfBUYNOklTqJIipjLzsFrVv
x-ms-office365-filtering-correlation-id: 2364e144-52db-48f0-732c-08d6222cba4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134CFD576A7F32B49DDC3FEFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EJw7ceQM3na206ukCv5ahhXxIHr7ILUEivupTCp3HRhBZ+K5Z2JxmaIeLs7zUtb7zPDlvH+Uv9ncGgJEsg1psShL0WqKmDXeBpsqCGZr7J0hr4IJh9CfJPiOQNgK2vN/WocBC3L3uT2pVKPawZSJUsTXap1vKRZBclseqydGM0SoAmuchoI7L17YrTuGicR2pNdOHWfc+ZqH4fnVsrDkCnPojBUVqy5eN9fjvqEnsz2/zw/jRYICTGnGsXqzfD0OzWqGAGmVTJBceNzre0Q8v3XM7gJ+X072fUeQ5gKbSI5u2ObvYrf8JLPhPsgKOwZuDsiaHOqZQlK1vnvG/jUaLzcysCASM40pNZM3vhTOVCM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2364e144-52db-48f0-732c-08d6222cba4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:01.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

[ Upstream commit 8ecebf4d767e2307a946c8905278d6358eda35c3 ]

Commit e9894fd3e3b3 ("Btrfs: fix snapshot vs nocow writting") forced
nocow writes to fallback to COW, during writeback, when a snapshot is
created. This resulted in writes made before creating the snapshot to
unexpectedly fail with ENOSPC during writeback when success (0) was
returned to user space through the write system call.

The steps leading to this problem are:

1. When it's not possible to allocate data space for a write, the
   buffered write path checks if a NOCOW write is possible.  If it is,
   it will not reserve space and success (0) is returned to user space.

2. Then when a snapshot is created, the root's will_be_snapshotted
   atomic is incremented and writeback is triggered for all inode's that
   belong to the root being snapshotted. Incrementing that atomic forces
   all previous writes to fallback to COW during writeback (running
   delalloc).

3. This results in the writeback for the inodes to fail and therefore
   setting the ENOSPC error in their mappings, so that a subsequent
   fsync on them will report the error to user space. So it's not a
   completely silent data loss (since fsync will report ENOSPC) but it's
   a very unexpected and undesirable behaviour, because if a clean
   shutdown/unmount of the filesystem happens without previous calls to
   fsync, it is expected to have the data present in the files after
   mounting the filesystem again.

So fix this by adding a new atomic named snapshot_force_cow to the
root structure which prevents this behaviour and works the following way:

1. It is incremented when we start to create a snapshot after triggering
   writeback and before waiting for writeback to finish.

2. This new atomic is now what is used by writeback (running delalloc)
   to decide whether we need to fallback to COW or not. Because we
   incremented this new atomic after triggering writeback in the
   snapshot creation ioctl, we ensure that all buffered writes that
   happened before snapshot creation will succeed and not fallback to
   COW (which would make them fail with ENOSPC).

3. The existing atomic, will_be_snapshotted, is kept because it is used
   to force new buffered writes, that start after we started
   snapshotting, to reserve data space even when NOCOW is possible.
   This makes these writes fail early with ENOSPC when there's no
   available space to allocate, preventing the unexpected behaviour of
   writeback later failing with ENOSPC due to a fallback to COW mode.

Fixes: e9894fd3e3b3 ("Btrfs: fix snapshot vs nocow writting")
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/inode.c   | 25 ++++---------------------
 fs/btrfs/ioctl.c   | 16 ++++++++++++++++
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 118346aceea9..663ce0518d27 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1277,6 +1277,7 @@ struct btrfs_root {
 	int send_in_progress;
 	struct btrfs_subvolume_writers *subv_writers;
 	atomic_t will_be_snapshotted;
+	atomic_t snapshot_force_cow;
=20
 	/* For qgroup metadata reserved space */
 	spinlock_t qgroup_meta_rsv_lock;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dfed08e70ec1..891b1aab3480 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1217,6 +1217,7 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
 	atomic_set(&root->log_batch, 0);
 	refcount_set(&root->refs, 1);
 	atomic_set(&root->will_be_snapshotted, 0);
+	atomic_set(&root->snapshot_force_cow, 0);
 	root->log_transid =3D 0;
 	root->log_transid_committed =3D -1;
 	root->last_log_commit =3D 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 071d949f69ec..d3736fbf6774 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1275,7 +1275,7 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 	u64 disk_num_bytes;
 	u64 ram_bytes;
 	int extent_type;
-	int ret, err;
+	int ret;
 	int type;
 	int nocow;
 	int check_prev =3D 1;
@@ -1407,11 +1407,8 @@ static noinline int run_delalloc_nocow(struct inode =
*inode,
 			 * if there are pending snapshots for this root,
 			 * we fall into common COW way.
 			 */
-			if (!nolock) {
-				err =3D btrfs_start_write_no_snapshotting(root);
-				if (!err)
-					goto out_check;
-			}
+			if (!nolock && atomic_read(&root->snapshot_force_cow))
+				goto out_check;
 			/*
 			 * force cow if csum exists in the range.
 			 * this ensure that csum for a given extent are
@@ -1420,9 +1417,6 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 			ret =3D csum_exist_in_range(fs_info, disk_bytenr,
 						  num_bytes);
 			if (ret) {
-				if (!nolock)
-					btrfs_end_write_no_snapshotting(root);
-
 				/*
 				 * ret could be -EIO if the above fails to read
 				 * metadata.
@@ -1435,11 +1429,8 @@ static noinline int run_delalloc_nocow(struct inode =
*inode,
 				WARN_ON_ONCE(nolock);
 				goto out_check;
 			}
-			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr)) {
-				if (!nolock)
-					btrfs_end_write_no_snapshotting(root);
+			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
 				goto out_check;
-			}
 			nocow =3D 1;
 		} else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
 			extent_end =3D found_key.offset +
@@ -1453,8 +1444,6 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 out_check:
 		if (extent_end <=3D start) {
 			path->slots[0]++;
-			if (!nolock && nocow)
-				btrfs_end_write_no_snapshotting(root);
 			if (nocow)
 				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
 			goto next_slot;
@@ -1476,8 +1465,6 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 					     end, page_started, nr_written, 1,
 					     NULL);
 			if (ret) {
-				if (!nolock && nocow)
-					btrfs_end_write_no_snapshotting(root);
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
 								disk_bytenr);
@@ -1497,8 +1484,6 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
-				if (!nolock && nocow)
-					btrfs_end_write_no_snapshotting(root);
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
 								disk_bytenr);
@@ -1537,8 +1522,6 @@ static noinline int run_delalloc_nocow(struct inode *=
inode,
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_PRIVATE2);
=20
-		if (!nolock && nocow)
-			btrfs_end_write_no_snapshotting(root);
 		cur_offset =3D extent_end;
=20
 		/*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3d6be0c657b..ef7159646615 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -761,6 +761,7 @@ static int create_snapshot(struct btrfs_root *root, str=
uct inode *dir,
 	struct btrfs_pending_snapshot *pending_snapshot;
 	struct btrfs_trans_handle *trans;
 	int ret;
+	bool snapshot_force_cow =3D false;
=20
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return -EINVAL;
@@ -777,6 +778,11 @@ static int create_snapshot(struct btrfs_root *root, st=
ruct inode *dir,
 		goto free_pending;
 	}
=20
+	/*
+	 * Force new buffered writes to reserve space even when NOCOW is
+	 * possible. This is to avoid later writeback (running dealloc) to
+	 * fallback to COW mode and unexpectedly fail with ENOSPC.
+	 */
 	atomic_inc(&root->will_be_snapshotted);
 	smp_mb__after_atomic();
 	/* wait for no snapshot writes */
@@ -787,6 +793,14 @@ static int create_snapshot(struct btrfs_root *root, st=
ruct inode *dir,
 	if (ret)
 		goto dec_and_free;
=20
+	/*
+	 * All previous writes have started writeback in NOCOW mode, so now
+	 * we force future writes to fallback to COW mode during snapshot
+	 * creation.
+	 */
+	atomic_inc(&root->snapshot_force_cow);
+	snapshot_force_cow =3D true;
+
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
=20
 	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
@@ -851,6 +865,8 @@ static int create_snapshot(struct btrfs_root *root, str=
uct inode *dir,
 fail:
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
+	if (snapshot_force_cow)
+		atomic_dec(&root->snapshot_force_cow);
 	if (atomic_dec_and_test(&root->will_be_snapshotted))
 		wake_up_var(&root->will_be_snapshotted);
 free_pending:
--=20
2.17.1
