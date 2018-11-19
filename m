Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E672080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E672080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKSLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:17:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:37204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbeKSLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:17:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FC84AC43;
        Mon, 19 Nov 2018 00:55:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 19 Nov 2018 11:55:46 +1100
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: update path-lookup.md for parallel lookups
Message-ID: <87k1l9dgx9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Since this document was written, i_mutex has been replace with
i_rwsem, and shared locks are utilized to allow lookups in the one
directory to happen in parallel.

So replace i_mutex with i_rwsem, and explain how this is used for
parallel lookups.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Just FYI

$ git grep -w i_mutex | wc -l
262

it was 276 before this patch... so a small improvement.

NeilBrown


 Documentation/filesystems/path-lookup.md | 85 ++++++++++++++++++------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.md b/Documentation/files=
ystems/path-lookup.md
index e2edd45c4bc0..06151b178f80 100644
=2D-- a/Documentation/filesystems/path-lookup.md
+++ b/Documentation/filesystems/path-lookup.md
@@ -12,6 +12,10 @@ This write-up is based on three articles published at lw=
n.net:
 - <https://lwn.net/Articles/650786/> A walk among the symlinks
=20
 Written by Neil Brown with help from Al Viro and Jon Corbet.
+It has subsequently been updated to reflect changes in the kernel
+including:
+
+- per-directory parallel name lookup.
=20
 Introduction
 ------------
@@ -231,37 +235,80 @@ renamed.  If `d_lookup` finds that a rename happened =
while it
 unsuccessfully scanned a chain in the hash table, it simply tries
 again.
=20
=2D### inode->i_mutex ###
+### inode->i_rwsem ###
=20
=2D`i_mutex` is a mutex that serializes all changes to a particular
+`i_rwsem` is a read/write semaphore that serializes all changes to a parti=
cular
 directory.  This ensures that, for example, an `unlink()` and a `rename()`
 cannot both happen at the same time.  It also keeps the directory
 stable while the filesystem is asked to look up a name that is not
=2Dcurrently in the dcache.
+currently in the dcache or, optionally, when the list of entries in a
+directory is being retrieved with `readdir()`.
=20
=2DThis has a complementary role to that of `d_lock`: `i_mutex` on a
+This has a complementary role to that of `d_lock`: `i_rwsem` on a
 directory protects all of the names in that directory, while `d_lock`
 on a name protects just one name in a directory.  Most changes to the
=2Ddcache hold `i_mutex` on the relevant directory inode and briefly take
+dcache hold `i_rwsem` on the relevant directory inode and briefly take
 `d_lock` on one or more the dentries while the change happens.  One
 exception is when idle dentries are removed from the dcache due to
=2Dmemory pressure.  This uses `d_lock`, but `i_mutex` plays no role.
+memory pressure.  This uses `d_lock`, but `i_rwsem` plays no role.
=20
=2DThe mutex affects pathname lookup in two distinct ways.  Firstly it
=2Dserializes lookup of a name in a directory.  `walk_component()` uses
+The semaphore affects pathname lookup in two distinct ways.  Firstly it
+prevents changes during lookup of a name in a directory.  `walk_component(=
)` uses
 `lookup_fast()` first which, in turn, checks to see if the name is in the =
cache,
 using only `d_lock` locking.  If the name isn't found, then `walk_componen=
t()`
=2Dfalls back to `lookup_slow()` which takes `i_mutex`, checks again that
+falls back to `lookup_slow()` which takes a shared lock on `i_rwsem`, chec=
ks again that
 the name isn't in the cache, and then calls in to the filesystem to get a
 definitive answer.  A new dentry will be added to the cache regardless of
 the result.
=20
 Secondly, when pathname lookup reaches the final component, it will
=2Dsometimes need to take `i_mutex` before performing the last lookup so
+sometimes need to take an exclusive lock on `i_rwsem` before performing th=
e last lookup so
 that the required exclusion can be achieved.  How path lookup chooses
=2Dto take, or not take, `i_mutex` is one of the
+to take, or not take, `i_rwsem` is one of the
 issues addressed in a subsequent section.
=20
+If two threads attempt to look up the same name at the same time - a
+name that is not yet in the dcache - the shared lock on `i_rwsem` will
+not prevent them both adding new dentries with the same name.  As this
+would result in confusion an extra level of interlocking is used,
+based around a secondary hash table (`in_lookup_hashtable`) and a
+per-dentry flag bit (`DCACHE_PAR_LOOKUP`).
+
+To add a new dentry to the cache while only holding a shared lock on
+`i_rwsem`, a thread must call `d_alloc_parallel()`.  This allocates a
+dentry, stores the required name and parent in it, checks if there
+is already a matching dentry in the primary or secondary hash
+tables, and if not, stores the newly allocated dentry in the secondary
+hash table, with `DCACHE_PAR_LOOKUP` set.
+
+If a matching dentry was found in the primary hash table then that is
+returned and the caller can know that it lost a race with some other
+thread adding the entry.  If no matching dentry is found in either
+cache, the newly allocated dentry is returned and the caller can
+detect this from the presence of `DCACHE_PAR_LOOKUP`.  In this case it
+knows that it has won any race and now is responsible for asking the
+filesystem to perform the lookup and find the matching inode.  When
+the lookup is complete, it must call `d_lookup_done()` which clears
+the flag and does some other house keeping, including removing the
+dentry from the secondary hash table - it will normally have been
+added to the primary hash table already.  Note that a `struct
+waitqueue_head` is passed to `d_alloc_parallel()`, and
+`d_lookup_done()` must be called while this `waitqueue_head` is still
+in scope.
+
+If a matching dentry is found in the secondary hash table,
+`d_alloc_parallel()` has a little more work to do. It first waits for
+`DCACHE_PAR_LOOKUP` to be cleared, using a wait_queue that was passed
+to the instance of `d_alloc_parallel()` that won the race and that
+will be woken by the call to `d_lookup_done()`.  It then checks to see
+if the dentry has now been added to the primary hash table.  If it
+has, the dentry is returned and the caller just sees that it lost any
+race.  If it hasn't been added to the primary hash table, the most
+likely explanation is that some other dentry was added instead using
+`d_splice_alias()`.  In any case, `d_alloc_parallel()` repeats all the
+look ups from the start and will normally return something from the
+primary hash table.
+
 ### mnt->mnt_count ###
=20
 `mnt_count` is a per-CPU reference counter on "`mount`" structures.
@@ -376,7 +423,7 @@ described.  If it finds a `LAST_NORM` component it firs=
t calls
 "`lookup_fast()`" which only looks in the dcache, but will ask the
 filesystem to revalidate the result if it is that sort of filesystem.
 If that doesn't get a good result, it calls "`lookup_slow()`" which
=2Dtakes the `i_mutex`, rechecks the cache, and then asks the filesystem
+takes `i_rwsem`, rechecks the cache, and then asks the filesystem
 to find a definitive answer.  Each of these will call
 `follow_managed()` (as described below) to handle any mount points.
=20
@@ -408,7 +455,7 @@ of housekeeping around `link_path_walk()` and returns t=
he parent
 directory and final component to the caller.  The caller will be either
 aiming to create a name (via `filename_create()`) or remove or rename
 a name (in which case `user_path_parent()` is used).  They will use
=2D`i_mutex` to exclude other changes while they validate and then
+`i_rwsem` to exclude other changes while they validate and then
 perform their operation.
=20
 `path_lookupat()` is nearly as simple - it is used when an existing
@@ -429,7 +476,7 @@ complexity needed to handle the different subtleties of=
 O_CREAT (with
 or without O_EXCL), final "`/`" characters, and trailing symbolic
 links.  We will revisit this in the final part of this series, which
 focuses on those symbolic links.  "`do_last()`" will sometimes, but
=2Dnot always, take `i_mutex`, depending on what it finds.
+not always, take `i_rwsem`, depending on what it finds.
=20
 Each of these, or the functions which call them, need to be alert to
 the possibility that the final component is not `LAST_NORM`.  If the
@@ -728,12 +775,12 @@ checking the `seq` number of the old exactly mirrors =
the process of
 getting a counted reference to the new dentry before dropping that for
 the old dentry which we saw in REF-walk.
=20
=2D### No `inode->i_mutex` or even `rename_lock` ###
+### No `inode->i_rwsem` or even `rename_lock` ###
=20
=2DA mutex is a fairly heavyweight lock that can only be taken when it is
+A semaphore is a fairly heavyweight lock that can only be taken when it is
 permissible to sleep.  As `rcu_read_lock()` forbids sleeping,
=2D`inode->i_mutex` plays no role in RCU-walk.  If some other thread does
=2Dtake `i_mutex` and modifies the directory in a way that RCU-walk needs
+`inode->i_rwsem` plays no role in RCU-walk.  If some other thread does
+take `i_rwsem` and modifies the directory in a way that RCU-walk needs
 to notice, the result will be either that RCU-walk fails to find the
 dentry that it is looking for, or it will find a dentry which
 `read_seqretry()` won't validate.  In either case it will drop down to
@@ -1134,7 +1181,7 @@ and `do_last()`, each of which use the same conventio=
n as
 to be followed.
=20
 Of these, `do_last()` is the most interesting as it is used for
=2Dopening a file.  Part of `do_last()` runs with `i_mutex` held and this
+opening a file.  Part of `do_last()` runs with `i_rwsem` held and this
 part is in a separate function: `lookup_open()`.
=20
 Explaining `do_last()` completely is beyond the scope of this article,
=2D-=20
2.19.0.216.g2d3b1c576c85


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvyChIACgkQOeye3VZi
gbmGfg//aYBm2AF+su3UhJ0yYZhxEtp0aNYRrBikuuTeMxmQQEgaGFfv5/DoTJn7
2iP1LVpikP77T+nzYq5eEdNnACtgIs3A3a28PUfQeOLMUgw3fTeOh+pkwBfL9Qpd
kH82iiCot2TKCxS1m9L3pTwT/SS4KvGWgujCIzRFfKwCaY9aUT1xsmUqKACXwWUn
5goYGlFHDJPE1p4eB+21XOwxLLMKzG9f2ad13YDo1IiKdhqg7cd3Yaqd2bD6OXk4
jTXR7hgLTB7eP2N1Vj5W99hKdVweqvUueF2ZHHO8ThJRU2H36qZTiBVO0hShAC8o
L2OwZN1dEKGb63R/Vs+xjpVknMQHbFb0rJDMFbtM/4amkX/EtMAiPnQWi05NvoYS
O0UR6w+2V9ttSqxj8fDSQbuWzTcTk7LCpdQtoxSM7lzc01Bal/2rPcd1PKiDd0jP
su3uAZGMdMUmnfGCJm0ullPKkKdagZa748dAvdCvG6JSvskdzj3aJSbOOhFXaNfd
v0msqM+r8vAIWeFkG/1EQIe2+QdN4oRmIjpWN6PwvgdcBjsnmJoEtGFMqvBdvmXu
6AnRqXofi5kltobLYHUX2mpbAf66tMikC+ijRoaUAzP0xCiyE2fR6y0VwCo1K361
DLt9D0mtCgynDHpGiYwgrnIh5dLMC7jjbO7HTbPUr98WM7NBZm4=
=KBLx
-----END PGP SIGNATURE-----
--=-=-=--
