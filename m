Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeB0DMD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:12:03 -0500
Received: from ozlabs.org ([103.22.144.67]:48891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751721AbeB0DMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:12:02 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 27 Feb 2018 14:11:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: linux-next: manual merge of the akpm-current tree with the ext3
 tree
Message-ID: <20180227141153.417a520e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oaWdntv1Yojh6vBGVy9gmDj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oaWdntv1Yojh6vBGVy9gmDj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got conflicts in:

  fs/notify/fanotify/fanotify.c
  fs/notify/fanotify/fanotify.h
  fs/notify/fanotify/fanotify_user.c
  fs/notify/inotify/inotify_fsnotify.c

between commits:

  1e301852d657 ("fanotify: Avoid lost events due to ENOMEM for unlimited qu=
eues")
  b900420e4109 ("fsnotify: Let userspace know about lost events due to ENOM=
EM")

from the ext3 tree and commit:

  d519ceef2ad6 ("fs: fsnotify: account fsnotify metadata to kmemcg")

from the akpm-current tree.

I fixed it up (see below - I simplified the obvious resolution a bit) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/notify/fanotify/fanotify.c
index d51e1bb781cf,0d9493ebc7cd..000000000000
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@@ -157,14 -148,16 +157,16 @@@ struct fanotify_event_info *fanotify_al
  	if (fanotify_is_perm_event(mask)) {
  		struct fanotify_perm_event_info *pevent;
 =20
- 		pevent =3D kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
+ 		pevent =3D kmem_cache_alloc_memcg(fanotify_perm_event_cachep,
 -						GFP_KERNEL, memcg);
++						gfp, group->memcg);
  		if (!pevent)
  			return NULL;
  		event =3D &pevent->fae;
  		pevent->response =3D 0;
  		goto init;
  	}
- 	event =3D kmem_cache_alloc(fanotify_event_cachep, gfp);
 -	event =3D kmem_cache_alloc_memcg(fanotify_event_cachep, GFP_KERNEL,
 -				       memcg);
++	event =3D kmem_cache_alloc_memcg(fanotify_event_cachep, gfp,
++				       group->memcg);
  	if (!event)
  		return NULL;
  init: __maybe_unused
diff --cc fs/notify/fanotify/fanotify.h
index 8609ba06f474,51b797896c87..000000000000
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
diff --cc fs/notify/fanotify/fanotify_user.c
index 72e367822efb,e5e5983051c0..000000000000
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@@ -756,8 -757,9 +757,9 @@@ SYSCALL_DEFINE2(fanotify_init, unsigne
 =20
  	group->fanotify_data.user =3D user;
  	atomic_inc(&user->fanotify_listeners);
+ 	group->memcg =3D get_mem_cgroup_from_mm(current->mm);
 =20
 -	oevent =3D fanotify_alloc_event(NULL, FS_Q_OVERFLOW, NULL, group->memcg);
 +	oevent =3D fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL);
  	if (unlikely(!oevent)) {
  		fd =3D -ENOMEM;
  		goto out_destroy_group;
diff --cc fs/notify/inotify/inotify_fsnotify.c
index 40dedb37a1f3,ed8e7b5f3981..000000000000
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@@ -98,15 -98,9 +98,15 @@@ int inotify_handle_event(struct fsnotif
  	i_mark =3D container_of(inode_mark, struct inotify_inode_mark,
  			      fsn_mark);
 =20
- 	event =3D kmalloc(alloc_len, GFP_KERNEL);
+ 	event =3D kmalloc_memcg(alloc_len, GFP_KERNEL, group->memcg);
 -	if (unlikely(!event))
 +	if (unlikely(!event)) {
 +		/*
 +		 * Treat lost event due to ENOMEM the same way as queue
 +		 * overflow to let userspace know event was lost.
 +		 */
 +		fsnotify_queue_overflow(group);
  		return -ENOMEM;
 +	}
 =20
  	fsn_event =3D &event->fse;
  	fsnotify_init_event(fsn_event, inode, mask);

--Sig_/oaWdntv1Yojh6vBGVy9gmDj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqUzHkACgkQAVBC80lX
0Gw7Uwf+O8t9NFzmoqcyeVOVt2RP6nUrGtc8fuSdV7M3S3nJzCo3+yaWbfMafg4b
0dcAQHhQc4Ysam6ACYbi92x0Z0H7QIO0hK8Sc0uGDf/HNzqT3YpwUVWhGAz5VcXp
QMezKMECYF2V3GwvwKQ8PBZv7r1JU3qB7ozLT7pK8lOG7xOLksGR4/wLUVNPAVFv
jWzds4lJ4p5QKCWrzvrXe95LImPbt0KXLAwMYAsroDBf2ak7hQYi6A+ladieJRkS
Hsdl+OcRPhiMDRu+JXFOloPvC51/mphs3CHEREfA6fD6Lo4xBm/2U9wLWiiZbs8x
c2Q+njZeRYUfDXwNOstKl34P2MBF4A==
=H97w
-----END PGP SIGNATURE-----

--Sig_/oaWdntv1Yojh6vBGVy9gmDj--
