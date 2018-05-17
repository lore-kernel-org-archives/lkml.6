Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEQBe4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:34:56 -0400
Received: from ozlabs.org ([203.11.71.1]:46069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEQBey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:34:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 11:34:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Novakovic <chris@chrisn.me.uk>
Subject: linux-next: manual merge of the net-next tree with the vfs tree
Message-ID: <20180517113450.182c8259@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9JDh.iCQyacovvxgBx6vtA/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9JDh.iCQyacovvxgBx6vtA/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/ipconfig.c

between commits:

  3f3942aca6da ("proc: introduce proc_create_single{,_data}")
  c04d2cb2009f ("ipconfig: Write NTP server IPs to /proc/net/ipconfig/ntp_s=
ervers")

from the vfs tree and commit:

  4d019b3f80dc ("ipconfig: Create /proc/net/ipconfig directory")

from the net-next tree.

I fixed it up (see below - there may be more to do) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/ipv4/ipconfig.c
index bbcbcc113d19,86c9f755de3d..000000000000
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@@ -1282,6 -1317,74 +1317,61 @@@ static int pnp_seq_show(struct seq_fil
  			   &ic_servaddr);
  	return 0;
  }
 -
 -static int pnp_seq_open(struct inode *indoe, struct file *file)
 -{
 -	return single_open(file, pnp_seq_show, NULL);
 -}
 -
 -static const struct file_operations pnp_seq_fops =3D {
 -	.open		=3D pnp_seq_open,
 -	.read		=3D seq_read,
 -	.llseek		=3D seq_lseek,
 -	.release	=3D single_release,
 -};
 -
+ /* Create the /proc/net/ipconfig directory */
+ static int __init ipconfig_proc_net_init(void)
+ {
+ 	ipconfig_dir =3D proc_net_mkdir(&init_net, "ipconfig", init_net.proc_net=
);
+ 	if (!ipconfig_dir)
+ 		return -ENOMEM;
+=20
+ 	return 0;
+ }
+=20
+ /* Create a new file under /proc/net/ipconfig */
+ static int ipconfig_proc_net_create(const char *name,
+ 				    const struct file_operations *fops)
+ {
+ 	char *pname;
+ 	struct proc_dir_entry *p;
+=20
+ 	if (!ipconfig_dir)
+ 		return -ENOMEM;
+=20
+ 	pname =3D kasprintf(GFP_KERNEL, "%s%s", "ipconfig/", name);
+ 	if (!pname)
+ 		return -ENOMEM;
+=20
+ 	p =3D proc_create(pname, 0444, init_net.proc_net, fops);
+ 	kfree(pname);
+ 	if (!p)
+ 		return -ENOMEM;
+=20
+ 	return 0;
+ }
+=20
+ /* Write NTP server IP addresses to /proc/net/ipconfig/ntp_servers */
+ static int ntp_servers_seq_show(struct seq_file *seq, void *v)
+ {
+ 	int i;
+=20
+ 	for (i =3D 0; i < CONF_NTP_SERVERS_MAX; i++) {
+ 		if (ic_ntp_servers[i] !=3D NONE)
+ 			seq_printf(seq, "%pI4\n", &ic_ntp_servers[i]);
+ 	}
+ 	return 0;
+ }
+=20
+ static int ntp_servers_seq_open(struct inode *inode, struct file *file)
+ {
+ 	return single_open(file, ntp_servers_seq_show, NULL);
+ }
+=20
+ static const struct file_operations ntp_servers_seq_fops =3D {
+ 	.open		=3D ntp_servers_seq_open,
+ 	.read		=3D seq_read,
+ 	.llseek		=3D seq_lseek,
+ 	.release	=3D single_release,
+ };
  #endif /* CONFIG_PROC_FS */
 =20
  /*
@@@ -1356,8 -1459,20 +1446,20 @@@ static int __init ip_auto_config(void
  	int err;
  	unsigned int i;
 =20
+ 	/* Initialise all name servers and NTP servers to NONE (but only if the
+ 	 * "ip=3D" or "nfsaddrs=3D" kernel command line parameters weren't decod=
ed,
+ 	 * otherwise we'll overwrite the IP addresses specified there)
+ 	 */
+ 	if (ic_set_manually =3D=3D 0) {
+ 		ic_nameservers_predef();
+ 		ic_ntp_servers_predef();
+ 	}
+=20
  #ifdef CONFIG_PROC_FS
 -	proc_create("pnp", 0444, init_net.proc_net, &pnp_seq_fops);
 +	proc_create_single("pnp", 0444, init_net.proc_net, pnp_seq_show);
+=20
+ 	if (ipconfig_proc_net_init() =3D=3D 0)
+ 		ipconfig_proc_net_create("ntp_servers", &ntp_servers_seq_fops);
  #endif /* CONFIG_PROC_FS */
 =20
  	if (!ic_enable)

--Sig_/9JDh.iCQyacovvxgBx6vtA/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr83DoACgkQAVBC80lX
0GwCOgf+OJOpmMXGZGwIm1XEQIc4vAlzHd9ML6Nu6IQn8nSFxoRvUq6AST+8nHXv
1OGmxs/nL+p6urtzJIGb0tjF9l/cuHIqeA5idi0/ayGQLOFXAsjk92mdgjb70Jxd
0wZ2wFnxcH8YBQIISjTtkkOn8GTopLcyMsZ4ceU6HTqEz9nbw+YJ6j1HjWAFEfNX
KbwrPbwxkCCJVfMcMV2YjDFJBBFVVtwP06NMzemQlB0WtsMRjca+aswtcM33ExsS
E1Ca4ZmoZe1lTkjhoLBzWf45yGrm2avp6HeqwK+aV7OTbZeMklB9P2ZTnqq0Ajm+
63IeyYTwDstpNzQJSv9VZVl9UpHNag==
=pcy+
-----END PGP SIGNATURE-----

--Sig_/9JDh.iCQyacovvxgBx6vtA/--
