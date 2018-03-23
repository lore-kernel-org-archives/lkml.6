Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCWGFG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 02:05:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeCWGFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 02:05:05 -0400
Date: Fri, 23 Mar 2018 17:04:57 +1100
From: Aleksa Sarai <asarai@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Subject: [REGRESSION v4.16-rc6] [PATCH] mqueue: forbid unprivileged user
 access to internal mount
Message-ID: <20180323060457.sxgsd3j2obi33fyw@gordon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mkwhpp2yu2pyrkbn"
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkwhpp2yu2pyrkbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Felix reported weird behaviour on 4.16.0-rc6 with regards to mqueue[1],
which was introduced by 36735a6a2b5e ("mqueue: switch to on-demand
creation of internal mount").

Basically, the reproducer boils down to being able to mount mqueue if
you create a new user namespace, even if you don't unshare the IPC
namespace.

Previously this was not possible, and you would get an -EPERM. The mount
is the *host* mqueue mount, which is being cached and just returned from
mqueue_mount(). To be honest, I'm not sure if this is safe or not (or if
it was intentional -- since I'm not familiar with mqueue).

To me it looks like there is a missing permission check. I've included a
patch below that I've compile-tested, and should block the above case.
Can someone please tell me if I'm missing something? Is this actually
safe?

[1]: https://github.com/docker/docker/issues/36674

--8<--------------------------------------------------------------------

Fix a regression caused by 36735a6a2b5e ("mqueue: switch to on-demand
creation of internal mount"), where an unprivileged user is permitted to
mount mqueue even if they don't have CAP_SYS_ADMIN in the ipcns's
associated userns. This can be reproduced as in the following.

  % unshare -Urm                       # ipc isn't unshare'd
  # mount -t mqueue mqueue /dev/mqueue # should have failed
  # echo $?
  0

Previously the above would error out with an -EPERM, as the mount was
protected by mount_ns(), but the patch in question switched to
kern_mount_data() which doesn't do this necessary permission check. So
add it explicitly to mq_internal_mount().

Fixes: 36735a6a2b5e ("mqueue: switch to on-demand creation of internal moun=
t")
Reported-by: Felix Abecassis <fabecassis@nvidia.com>
Signed-off-by: Aleksa Sarai <asarai@suse.de>
---
 ipc/mqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d7f309f74dec..ddb85091398d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -353,6 +353,12 @@ static struct vfsmount *mq_internal_mount(void)
 {
 	struct ipc_namespace *ns =3D current->nsproxy->ipc_ns;
 	struct vfsmount *m =3D ns->mq_mnt;
+	/*
+	 * Match the semantics of mount_ns, to avoid unprivileged users from being
+	 * able to mount mqueue from an IPC namespace they don't have ownership o=
f.
+	 */
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return ERR_PTR(-EPERM);
 	if (m)
 		return m;
 	m =3D kern_mount_data(&mqueue_fs_type, ns);
--=20
2.16.2

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mkwhpp2yu2pyrkbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlq0mQgACgkQnhiqJn3b
jbSX+g//csB1W7Uq8uwJeJsbdF4DwmoAW6wqS0ur2OZKuY5nDlgPXLMEpPc+4L/J
LEspc1mhN7U2SEypffN0fpAdf9SDANX5lKbKn93L1oJS59Ap0vjVtkRv2pBOuqDv
24mDkUsZGhtEqump4AkCkoJivQRzpHseXpgs5WfDGZJXEKCapkTS3ozfCbrmJRrL
1npE/vPcWT/tpxXBo8pFdvcFZ08EhqQ1tRINNdHXF5ii8rmAxT/RTEN33e461G4+
QUNZbJCHhrQKyJDOD9vychOMQUbFlI/WUVm7WvUo8RzS5r7TuDw3DDlHoiO0zbhR
Ns/9ZAO9MCA2o15rcXzI5kZUS7ZJL3FHr3lLTS8JOTCZCdIDkjJoIEtvbAg/7TAH
S6n7r+qJffKwCjC93VKiOZ9CxsmdMGaUX3J6vYvU07o6CIiD6oL6/Q07weE2RRUV
31P/YOdKf9EYxU9SqBtPQJxeeKKDvIbebwv/iLLu4quuIJIbybe9i4cDuu15Yrj3
eh735RAl8vtKc0Em1SushCT9NaTBe4qXQSw9I4jJWgaLL9b49lbqFdHlaMyl7uQe
BgK81ykG/V3qXRm+0L57Oj1AglqBTYJwgUrG8C0eGQstz+XN3ir9AqpSWXtZl6m9
ZNEm4UHc3BnroM5TaLWRt/OWjmfB7m5sDSrBCXsCfBFrswe9fxQ=
=5QhP
-----END PGP SIGNATURE-----

--mkwhpp2yu2pyrkbn--
