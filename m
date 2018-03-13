Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeCMAaK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:30:10 -0400
Received: from ozlabs.org ([103.22.144.67]:50839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932102AbeCMAaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:30:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 11:29:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180313112941.7971ba0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/frLOy=jyCYIrEK1ptviZ+79"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/frLOy=jyCYIrEK1ptviZ+79
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  drivers/net/ethernet/mellanox/mlxsw/spectrum.h
  drivers/net/ethernet/mellanox/mlxsw/spectrum.c

between commit:

  663f1b26f9c1 ("mlxsw: spectrum: Prevent duplicate mirrors")

from the net tree and commit:

  a629ef210d89 ("mlxsw: spectrum: Move SPAN code to separate module")

from the net-next tree.

I fixed it up (the code changed in the former was moved in the latter -
I applied the below merge fix patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Mar 2018 11:25:13 +1100
Subject: [PATCH] mlxsw: merge fix for move of SPAN code

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 28 ++++++++++++++++++=
----
 .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/=
net/ethernet/mellanox/mlxsw/spectrum_span.c
index ae22a3daffbf..4d6ed207b4af 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -600,13 +600,17 @@ int mlxsw_sp_span_port_mtu_update(struct mlxsw_sp_por=
t *port, u16 mtu)
 }
=20
 static struct mlxsw_sp_span_inspected_port *
-mlxsw_sp_span_entry_bound_port_find(struct mlxsw_sp_port *port,
-				    struct mlxsw_sp_span_entry *span_entry)
+mlxsw_sp_span_entry_bound_port_find(struct mlxsw_sp_span_entry *span_entry,
+				    enum mlxsw_sp_span_type type,
+				    struct mlxsw_sp_port *port,
+				    bool bind)
 {
 	struct mlxsw_sp_span_inspected_port *p;
=20
 	list_for_each_entry(p, &span_entry->bound_ports_list, list)
-		if (port->local_port =3D=3D p->local_port)
+		if (type =3D=3D p->type &&
+		    port->local_port =3D=3D p->local_port &&
+		    bind =3D=3D p->bound)
 			return p;
 	return NULL;
 }
@@ -636,8 +640,22 @@ mlxsw_sp_span_inspected_port_add(struct mlxsw_sp_port =
*port,
 	struct mlxsw_sp_span_inspected_port *inspected_port;
 	struct mlxsw_sp *mlxsw_sp =3D port->mlxsw_sp;
 	char sbib_pl[MLXSW_REG_SBIB_LEN];
+	int i;
 	int err;
=20
+	/* A given (source port, direction) can only be bound to one analyzer,
+	 * so if a binding is requested, check for conflicts.
+	 */
+	if (bind)
+		for (i =3D 0; i < mlxsw_sp->span.entries_count; i++) {
+			struct mlxsw_sp_span_entry *curr =3D
+				&mlxsw_sp->span.entries[i];
+
+			if (mlxsw_sp_span_entry_bound_port_find(curr, type,
+								port, bind))
+				return -EEXIST;
+		}
+
 	/* if it is an egress SPAN, bind a shared buffer to it */
 	if (type =3D=3D MLXSW_SP_SPAN_EGRESS) {
 		u32 buffsize =3D mlxsw_sp_span_mtu_to_buffsize(mlxsw_sp,
@@ -665,6 +683,7 @@ mlxsw_sp_span_inspected_port_add(struct mlxsw_sp_port *=
port,
 	}
 	inspected_port->local_port =3D port->local_port;
 	inspected_port->type =3D type;
+	inspected_port->bound =3D bind;
 	list_add_tail(&inspected_port->list, &span_entry->bound_ports_list);
=20
 	return 0;
@@ -691,7 +710,8 @@ mlxsw_sp_span_inspected_port_del(struct mlxsw_sp_port *=
port,
 	struct mlxsw_sp *mlxsw_sp =3D port->mlxsw_sp;
 	char sbib_pl[MLXSW_REG_SBIB_LEN];
=20
-	inspected_port =3D mlxsw_sp_span_entry_bound_port_find(port, span_entry);
+	inspected_port =3D mlxsw_sp_span_entry_bound_port_find(span_entry, type,
+							     port, bind);
 	if (!inspected_port)
 		return;
=20
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h b/drivers/=
net/ethernet/mellanox/mlxsw/spectrum_span.h
index 948aceb512c5..4b87ec20e658 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
@@ -51,6 +51,9 @@ struct mlxsw_sp_span_inspected_port {
 	struct list_head list;
 	enum mlxsw_sp_span_type type;
 	u8 local_port;
+
+	/* Whether this is a directly bound mirror (port-to-port) or an ACL. */
+	bool bound;
 };
=20
 struct mlxsw_sp_span_parms {
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/frLOy=jyCYIrEK1ptviZ+79
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnG3UACgkQAVBC80lX
0GykGggAiiuHOkzeoNqW1nqtpCRLsMTYjDvCIjnsLpgPjBXTHvqzOPqk0u0pvNVR
QMWo76yIgW9wUc9vkdE2I4ZYi4ax6yju3NVSFbJvfGLNkBwQnQIsuhDL3mHoKBiv
+dWcHfJy8a84D0mY4AMgq9ZGfBocZR4p9oKbwhTnrpSXmSaY98d/FArsEqNdR73F
s+tk5+9OEDKdOmKerk9gwJ+LupARC2v036GjsjojcWbu6721AT6VkvMXiCTLsEme
5/hys4jOPWIX6pkZ3TuZ5P1Zu9q4/uPw0XrquCJ0wlDlIe6dKythCP5VYB4XvG4/
U8S8yIGjrlPytfqpXhRnlqnDWvLPog==
=ltqn
-----END PGP SIGNATURE-----

--Sig_/frLOy=jyCYIrEK1ptviZ+79--
