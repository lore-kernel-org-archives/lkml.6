Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeCSA0L (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:26:11 -0400
Received: from ozlabs.org ([103.22.144.67]:38313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754258AbeCSA0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:26:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 11:25:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: linux-next: manual merge of the net-next tree with the syscalls
 tree
Message-ID: <20180319112510.5492f274@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iTvzUgPCCujS9G0ZQSTcM/L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iTvzUgPCCujS9G0ZQSTcM/L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/linux/socket.h

between commits:

  06947f40e3e9 ("net: socket: add __sys_recvfrom() helper; remove in-kernel=
 call to syscall")
  bd4053a762c6 ("net: socket: move check for forbid_cmsg_compat to __sys_..=
.msg()")

from the syscalls tree and commit:

  d8d211a2a0c3 ("net: Make extern and export get_net_ns()")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/socket.h
index e2b6bd4fe977,1ce1f768a58c..000000000000
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@@ -356,30 -352,7 +356,31 @@@ extern long __sys_sendmsg(int fd, struc
  extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned i=
nt vlen,
  			  unsigned int flags, struct timespec *timeout);
  extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 -			  unsigned int vlen, unsigned int flags);
 +			  unsigned int vlen, unsigned int flags,
 +			  bool forbid_cmsg_compat);
 +
 +/* helpers which do the actual work for syscalls */
 +extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 +			  unsigned int flags, struct sockaddr __user *addr,
 +			  int __user *addr_len);
 +extern int __sys_sendto(int fd, void __user *buff, size_t len,
 +			unsigned int flags, struct sockaddr __user *addr,
 +			int addr_len);
 +extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 +			 int __user *upeer_addrlen, int flags);
 +extern int __sys_socket(int family, int type, int protocol);
 +extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrle=
n);
 +extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 +			 int addrlen);
 +extern int __sys_listen(int fd, int backlog);
 +extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 +			     int __user *usockaddr_len);
 +extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 +			     int __user *usockaddr_len);
 +extern int __sys_socketpair(int family, int type, int protocol,
 +			    int __user *usockvec);
 +extern int __sys_shutdown(int fd, int how);
 +
 =20
+ extern struct ns_common *get_net_ns(struct ns_common *ns);
  #endif /* _LINUX_SOCKET_H */

--Sig_/iTvzUgPCCujS9G0ZQSTcM/L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvA2YACgkQAVBC80lX
0Gz3Rwf9EcG3WGavtC+wbJ06s7CNuhrUgSY+M6CdWNGH6mWowcRfY1RbWrQAnsNj
DQKX5ZDInOPH3MdzCGbNtW+KzVYYQwguHHBv2nhLOUcvIiIp+2YHQ3rEcYAJ0MXj
8SxBzQY11dcfi+e8/U2YA6IMOvGsy5z1wqfSV5yHUZbPPePIoohriq5CxYPHqU1W
t+YJD3TMXMc5iuhxG5mv+Pej1lCq42vLQastxH5PNMs6pKI/UmOmUO1dALJ622BB
wuvR09Vfr3z6FmvGzG5paWaOTVtPoZko1UCbgQZCIZpNAOn+YaLDBpC5Ifs85472
KeFYaHnc3qRz05CdnyZXNx+Bvw3ORw==
=kAgj
-----END PGP SIGNATURE-----

--Sig_/iTvzUgPCCujS9G0ZQSTcM/L--
