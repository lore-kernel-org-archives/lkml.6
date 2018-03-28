Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeC1Hm1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:42:27 -0400
Received: from ozlabs.org ([103.22.144.67]:46403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeC1HmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:42:23 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 18:41:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the userns tree
Message-ID: <20180328184125.3dbcfbf5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v4.foYZPa8UEMEN4NoXkpfH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v4.foYZPa8UEMEN4NoXkpfH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

After merging the userns tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from include/linux/sched.h:16:0,
                 from arch/powerpc/lib/xor_vmx_glue.c:14:
include/linux/shm.h:17:35: error: 'struct file' declared inside parameter l=
ist will not be visible outside of this definition or declaration [-Werror]
 bool is_file_shm_hugepages(struct file *file);
                                   ^~~~

and many, many more (most warnings, but some errors - arch/powerpc is
mostly built with -Werror)

Maybe caused by commit

  1a5c1349d105 ("sem: Move struct sem and struct sem_array into ipc/sem.c")

I have appplied the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Mar 2018 18:36:27 +1100
Subject: [PATCH] fix up for struct file no longer being available in shm.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/shm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/shm.h b/include/linux/shm.h
index 3a8eae3ca33c..d8e69aed3d32 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -7,6 +7,8 @@
 #include <uapi/linux/shm.h>
 #include <asm/shmparam.h>
=20
+struct file;
+
 #ifdef CONFIG_SYSVIPC
 struct sysv_shm {
 	struct list_head shm_clist;
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/v4.foYZPa8UEMEN4NoXkpfH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq7RyUACgkQAVBC80lX
0GzdFwgAmqFjHLk1tRKi8FtbIYW/3ZpBRnp4V+QZnP2hYg3gpdzTEmxt2XZjKvi7
sqWfzsZBlKkxSYIg9zsM3zbl/9cmm2+ZGgoUqZu/YB70jHYGOE/D+z0XK8nJ+WNZ
XB/wlawGMi4fndOQhq0gg5BiuNN0GZZs6na77Ec4KbAvOv9nC5ttDbWU3L+jsTSs
WmJuqy4DznkPXZB0jhbRtweMKH8W2sqyoKy6M0ilMQFUbWOpvdXEhCVWg0dKZpz3
Kf4VJbLDhaPViJRH72RjLk2U0YNhLzERh+u9OHynxbOw0DeMIuHoJoT7C2Lxrea8
DXWMkwVk7z61D1ZPwKsa/c1WFB0IHA==
=HScI
-----END PGP SIGNATURE-----

--Sig_/v4.foYZPa8UEMEN4NoXkpfH--
