Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934738AbeCHCH3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:07:29 -0500
Received: from ozlabs.org ([103.22.144.67]:52277 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933351AbeCHCH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:07:27 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 13:07:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the net-next
 tree
Message-ID: <20180308130703.7365f733@canb.auug.org.au>
In-Reply-To: <20180305124054.09966cb0@canb.auug.org.au>
References: <20180305124054.09966cb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9dXNQ3LF=I2qh8sZJzDPoiY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9dXNQ3LF=I2qh8sZJzDPoiY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Mar 2018 12:40:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the selinux tree got a conflict in:
>=20
>   net/sctp/socket.c
>=20
> between several refactoring commits from the net-next tree and commit:
>=20
>   2277c7cd75e3 ("sctp: Add LSM hooks")
>=20
> from the selinux tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell

The resolution now looks like below (there were more changes to this
file in the net-next tree).  It will keep changing every time this file
is touched :-(

--=20
Cheers,
Stephen Rothwell

diff --cc net/sctp/socket.c
index 7d3476a4860d,73b34a6b5b09..000000000000
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@@ -1606,200 -1622,308 +1622,216 @@@ static int sctp_error(struct sock *sk=
,=20
  static int sctp_msghdr_parse(const struct msghdr *msg,
  			     struct sctp_cmsgs *cmsgs);
 =20
 -static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_l=
en)
 +static int sctp_sendmsg_parse(struct sock *sk, struct sctp_cmsgs *cmsgs,
 +			      struct sctp_sndrcvinfo *srinfo,
 +			      const struct msghdr *msg, size_t msg_len)
  {
 -	struct net *net =3D sock_net(sk);
 -	struct sctp_sock *sp;
 -	struct sctp_endpoint *ep;
 -	struct sctp_association *new_asoc =3D NULL, *asoc =3D NULL;
 -	struct sctp_transport *transport, *chunk_tp;
 -	struct sctp_chunk *chunk;
 -	union sctp_addr to;
 -	struct sctp_af *af;
 -	struct sockaddr *msg_name =3D NULL;
 -	struct sctp_sndrcvinfo default_sinfo;
 -	struct sctp_sndrcvinfo *sinfo;
 -	struct sctp_initmsg *sinit;
 -	sctp_assoc_t associd =3D 0;
 -	struct sctp_cmsgs cmsgs =3D { NULL };
 -	enum sctp_scope scope;
 -	bool fill_sinfo_ttl =3D false, wait_connect =3D false;
 -	struct sctp_datamsg *datamsg;
 -	int msg_flags =3D msg->msg_flags;
 -	__u16 sinfo_flags =3D 0;
 -	long timeo;
 +	__u16 sflags;
  	int err;
 =20
 -	err =3D 0;
 -	sp =3D sctp_sk(sk);
 -	ep =3D sp->ep;
 +	if (sctp_sstate(sk, LISTENING) && sctp_style(sk, TCP))
 +		return -EPIPE;
 =20
 -	pr_debug("%s: sk:%p, msg:%p, msg_len:%zu ep:%p\n", __func__, sk,
 -		 msg, msg_len, ep);
 -
 -	/* We cannot send a message over a TCP-style listening socket. */
 -	if (sctp_style(sk, TCP) && sctp_sstate(sk, LISTENING)) {
 -		err =3D -EPIPE;
 -		goto out_nounlock;
 -	}
 +	if (msg_len > sk->sk_sndbuf)
 +		return -EMSGSIZE;
 =20
 -	/* Parse out the SCTP CMSGs.  */
 -	err =3D sctp_msghdr_parse(msg, &cmsgs);
 +	memset(cmsgs, 0, sizeof(*cmsgs));
 +	err =3D sctp_msghdr_parse(msg, cmsgs);
  	if (err) {
  		pr_debug("%s: msghdr parse err:%x\n", __func__, err);
 -		goto out_nounlock;
 +		return err;
  	}
 =20
 -	/* Fetch the destination address for this packet.  This
 -	 * address only selects the association--it is not necessarily
 -	 * the address we will send to.
 -	 * For a peeled-off socket, msg_name is ignored.
 -	 */
 -	if (!sctp_style(sk, UDP_HIGH_BANDWIDTH) && msg->msg_name) {
 -		int msg_namelen =3D msg->msg_namelen;
 +	memset(srinfo, 0, sizeof(*srinfo));
 +	if (cmsgs->srinfo) {
 +		srinfo->sinfo_stream =3D cmsgs->srinfo->sinfo_stream;
 +		srinfo->sinfo_flags =3D cmsgs->srinfo->sinfo_flags;
 +		srinfo->sinfo_ppid =3D cmsgs->srinfo->sinfo_ppid;
 +		srinfo->sinfo_context =3D cmsgs->srinfo->sinfo_context;
 +		srinfo->sinfo_assoc_id =3D cmsgs->srinfo->sinfo_assoc_id;
 +		srinfo->sinfo_timetolive =3D cmsgs->srinfo->sinfo_timetolive;
 +	}
 =20
 -		err =3D sctp_verify_addr(sk, (union sctp_addr *)msg->msg_name,
 -				       msg_namelen);
 -		if (err)
 -			return err;
 +	if (cmsgs->sinfo) {
 +		srinfo->sinfo_stream =3D cmsgs->sinfo->snd_sid;
 +		srinfo->sinfo_flags =3D cmsgs->sinfo->snd_flags;
 +		srinfo->sinfo_ppid =3D cmsgs->sinfo->snd_ppid;
 +		srinfo->sinfo_context =3D cmsgs->sinfo->snd_context;
 +		srinfo->sinfo_assoc_id =3D cmsgs->sinfo->snd_assoc_id;
 +	}
 =20
 -		if (msg_namelen > sizeof(to))
 -			msg_namelen =3D sizeof(to);
 -		memcpy(&to, msg->msg_name, msg_namelen);
 -		msg_name =3D msg->msg_name;
 +	if (cmsgs->prinfo) {
 +		srinfo->sinfo_timetolive =3D cmsgs->prinfo->pr_value;
 +		SCTP_PR_SET_POLICY(srinfo->sinfo_flags,
 +				   cmsgs->prinfo->pr_policy);
  	}
 =20
 -	sinit =3D cmsgs.init;
 -	if (cmsgs.sinfo !=3D NULL) {
 -		memset(&default_sinfo, 0, sizeof(default_sinfo));
 -		default_sinfo.sinfo_stream =3D cmsgs.sinfo->snd_sid;
 -		default_sinfo.sinfo_flags =3D cmsgs.sinfo->snd_flags;
 -		default_sinfo.sinfo_ppid =3D cmsgs.sinfo->snd_ppid;
 -		default_sinfo.sinfo_context =3D cmsgs.sinfo->snd_context;
 -		default_sinfo.sinfo_assoc_id =3D cmsgs.sinfo->snd_assoc_id;
 +	sflags =3D srinfo->sinfo_flags;
 +	if (!sflags && msg_len)
 +		return 0;
 =20
 -		sinfo =3D &default_sinfo;
 -		fill_sinfo_ttl =3D true;
 -	} else {
 -		sinfo =3D cmsgs.srinfo;
 -	}
 -	/* Did the user specify SNDINFO/SNDRCVINFO? */
 -	if (sinfo) {
 -		sinfo_flags =3D sinfo->sinfo_flags;
 -		associd =3D sinfo->sinfo_assoc_id;
 -	}
 +	if (sctp_style(sk, TCP) && (sflags & (SCTP_EOF | SCTP_ABORT)))
 +		return -EINVAL;
 =20
 -	pr_debug("%s: msg_len:%zu, sinfo_flags:0x%x\n", __func__,
 -		 msg_len, sinfo_flags);
 +	if (((sflags & SCTP_EOF) && msg_len > 0) ||
 +	    (!(sflags & (SCTP_EOF | SCTP_ABORT)) && msg_len =3D=3D 0))
 +		return -EINVAL;
 =20
 -	/* SCTP_EOF or SCTP_ABORT cannot be set on a TCP-style socket. */
 -	if (sctp_style(sk, TCP) && (sinfo_flags & (SCTP_EOF | SCTP_ABORT))) {
 -		err =3D -EINVAL;
 -		goto out_nounlock;
 -	}
 +	if ((sflags & SCTP_ADDR_OVER) && !msg->msg_name)
 +		return -EINVAL;
 =20
 -	/* If SCTP_EOF is set, no data can be sent. Disallow sending zero
 -	 * length messages when SCTP_EOF|SCTP_ABORT is not set.
 -	 * If SCTP_ABORT is set, the message length could be non zero with
 -	 * the msg_iov set to the user abort reason.
 -	 */
 -	if (((sinfo_flags & SCTP_EOF) && (msg_len > 0)) ||
 -	    (!(sinfo_flags & (SCTP_EOF|SCTP_ABORT)) && (msg_len =3D=3D 0))) {
 -		err =3D -EINVAL;
 -		goto out_nounlock;
 -	}
 +	return 0;
 +}
 =20
 -	/* If SCTP_ADDR_OVER is set, there must be an address
 -	 * specified in msg_name.
 -	 */
 -	if ((sinfo_flags & SCTP_ADDR_OVER) && (!msg->msg_name)) {
 -		err =3D -EINVAL;
 -		goto out_nounlock;
 -	}
 +static int sctp_sendmsg_new_asoc(struct sock *sk, __u16 sflags,
 +				 struct sctp_cmsgs *cmsgs,
 +				 union sctp_addr *daddr,
 +				 struct sctp_transport **tp)
 +{
 +	struct sctp_endpoint *ep =3D sctp_sk(sk)->ep;
 +	struct net *net =3D sock_net(sk);
 +	struct sctp_association *asoc;
 +	enum sctp_scope scope;
 +	struct cmsghdr *cmsg;
++	struct sctp_af *af;
 +	int err =3D -EINVAL;
 =20
 -	transport =3D NULL;
 +	*tp =3D NULL;
 =20
 -	pr_debug("%s: about to look up association\n", __func__);
 +	if (sflags & (SCTP_EOF | SCTP_ABORT))
 +		return -EINVAL;
 =20
 -	lock_sock(sk);
 +	if (sctp_style(sk, TCP) && (sctp_sstate(sk, ESTABLISHED) ||
 +				    sctp_sstate(sk, CLOSING)))
 +		return -EADDRNOTAVAIL;
 =20
 -	/* If a msg_name has been specified, assume this is to be used.  */
 -	if (msg_name) {
 -		/* Look for a matching association on the endpoint. */
 -		asoc =3D sctp_endpoint_lookup_assoc(ep, &to, &transport);
 +	if (sctp_endpoint_is_peeled_off(ep, daddr))
 +		return -EADDRNOTAVAIL;
 =20
 -		/* If we could not find a matching association on the
 -		 * endpoint, make sure that it is not a TCP-style
 -		 * socket that already has an association or there is
 -		 * no peeled-off association on another socket.
 -		 */
 -		if (!asoc &&
 -		    ((sctp_style(sk, TCP) &&
 -		      (sctp_sstate(sk, ESTABLISHED) ||
 -		       sctp_sstate(sk, CLOSING))) ||
 -		     sctp_endpoint_is_peeled_off(ep, &to))) {
 -			err =3D -EADDRNOTAVAIL;
 -			goto out_unlock;
 -		}
 +	if (!ep->base.bind_addr.port) {
 +		if (sctp_autobind(sk))
 +			return -EAGAIN;
  	} else {
 -		asoc =3D sctp_id2assoc(sk, associd);
 -		if (!asoc) {
 -			err =3D -EPIPE;
 -			goto out_unlock;
 -		}
 +		if (ep->base.bind_addr.port < inet_prot_sock(net) &&
 +		    !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
 +			return -EACCES;
  	}
 =20
 -	if (asoc) {
 -		pr_debug("%s: just looked up association:%p\n", __func__, asoc);
 +	scope =3D sctp_scope(daddr);
 =20
 -		/* We cannot send a message on a TCP-style SCTP_SS_ESTABLISHED
 -		 * socket that has an association in CLOSED state. This can
 -		 * happen when an accepted socket has an association that is
 -		 * already CLOSED.
 -		 */
 -		if (sctp_state(asoc, CLOSED) && sctp_style(sk, TCP)) {
 -			err =3D -EPIPE;
 -			goto out_unlock;
 -		}
++	/* Label connection socket for first association 1-to-many
++	 * style for client sequence socket()->sendmsg(). This
++	 * needs to be done before sctp_assoc_add_peer() as that will
++	 * set up the initial packet that needs to account for any
++	 * security ip options (CIPSO/CALIPSO) added to the packet.
++	 */
++	af =3D sctp_get_af_specific(daddr->sa.sa_family);
++	if (!af)
++		return -EINVAL;
++	err =3D security_sctp_bind_connect(sk, SCTP_SENDMSG_CONNECT,
++					 (struct sockaddr *)daddr,
++					 af->sockaddr_len);
++	if (err < 0)
++		return err;
+=20
 -		if (sinfo_flags & SCTP_EOF) {
 -			pr_debug("%s: shutting down association:%p\n",
 -				 __func__, asoc);
 +	asoc =3D sctp_association_new(ep, sk, scope, GFP_KERNEL);
 +	if (!asoc)
 +		return -ENOMEM;
 =20
 -			sctp_primitive_SHUTDOWN(net, asoc, NULL);
 -			err =3D 0;
 -			goto out_unlock;
 -		}
 -		if (sinfo_flags & SCTP_ABORT) {
 +	if (sctp_assoc_set_bind_addr_from_ep(asoc, scope, GFP_KERNEL) < 0) {
 +		err =3D -ENOMEM;
 +		goto free;
 +	}
 =20
 -			chunk =3D sctp_make_abort_user(asoc, msg, msg_len);
 -			if (!chunk) {
 -				err =3D -ENOMEM;
 -				goto out_unlock;
 -			}
 +	if (cmsgs->init) {
 +		struct sctp_initmsg *init =3D cmsgs->init;
 =20
 -			pr_debug("%s: aborting association:%p\n",
 -				 __func__, asoc);
 +		if (init->sinit_num_ostreams) {
 +			__u16 outcnt =3D init->sinit_num_ostreams;
 =20
 -			sctp_primitive_ABORT(net, asoc, chunk);
 -			err =3D 0;
 -			goto out_unlock;
 +			asoc->c.sinit_num_ostreams =3D outcnt;
 +			/* outcnt has been changed, need to re-init stream */
 +			err =3D sctp_stream_init(&asoc->stream, outcnt, 0,
 +					       GFP_KERNEL);
 +			if (err)
 +				goto free;
  		}
 +
 +		if (init->sinit_max_instreams)
 +			asoc->c.sinit_max_instreams =3D init->sinit_max_instreams;
 +
 +		if (init->sinit_max_attempts)
 +			asoc->max_init_attempts =3D init->sinit_max_attempts;
 +
 +		if (init->sinit_max_init_timeo)
 +			asoc->max_init_timeo =3D
 +				msecs_to_jiffies(init->sinit_max_init_timeo);
  	}
 =20
 -	/* Do we need to create the association?  */
 -	if (!asoc) {
 -		pr_debug("%s: there is no association yet\n", __func__);
 +	*tp =3D sctp_assoc_add_peer(asoc, daddr, GFP_KERNEL, SCTP_UNKNOWN);
 +	if (!*tp) {
 +		err =3D -ENOMEM;
 +		goto free;
 +	}
 =20
 -		if (sinfo_flags & (SCTP_EOF | SCTP_ABORT)) {
 -			err =3D -EINVAL;
 -			goto out_unlock;
 -		}
 +	if (!cmsgs->addrs_msg)
 +		return 0;
 =20
 -		/* Check for invalid stream against the stream counts,
 -		 * either the default or the user specified stream counts.
 -		 */
 -		if (sinfo) {
 -			if (!sinit || !sinit->sinit_num_ostreams) {
 -				/* Check against the defaults. */
 -				if (sinfo->sinfo_stream >=3D
 -				    sp->initmsg.sinit_num_ostreams) {
 -					err =3D -EINVAL;
 -					goto out_unlock;
 -				}
 -			} else {
 -				/* Check against the requested.  */
 -				if (sinfo->sinfo_stream >=3D
 -				    sinit->sinit_num_ostreams) {
 -					err =3D -EINVAL;
 -					goto out_unlock;
 -				}
 -			}
 -		}
 +	/* sendv addr list parse */
 +	for_each_cmsghdr(cmsg, cmsgs->addrs_msg) {
 +		struct sctp_transport *transport;
 +		struct sctp_association *old;
 +		union sctp_addr _daddr;
 +		int dlen;
 =20
 -		/*
 -		 * API 3.1.2 bind() - UDP Style Syntax
 -		 * If a bind() or sctp_bindx() is not called prior to a
 -		 * sendmsg() call that initiates a new association, the
 -		 * system picks an ephemeral port and will choose an address
 -		 * set equivalent to binding with a wildcard address.
 -		 */
 -		if (!ep->base.bind_addr.port) {
 -			if (sctp_autobind(sk)) {
 -				err =3D -EAGAIN;
 -				goto out_unlock;
 -			}
 -		} else {
 -			/*
 -			 * If an unprivileged user inherits a one-to-many
 -			 * style socket with open associations on a privileged
 -			 * port, it MAY be permitted to accept new associations,
 -			 * but it SHOULD NOT be permitted to open new
 -			 * associations.
 -			 */
 -			if (ep->base.bind_addr.port < inet_prot_sock(net) &&
 -			    !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE)) {
 -				err =3D -EACCES;
 -				goto out_unlock;
 -			}
 -		}
 +		if (cmsg->cmsg_level !=3D IPPROTO_SCTP ||
 +		    (cmsg->cmsg_type !=3D SCTP_DSTADDRV4 &&
 +		     cmsg->cmsg_type !=3D SCTP_DSTADDRV6))
 +			continue;
 =20
 -		scope =3D sctp_scope(&to);
 +		daddr =3D &_daddr;
 +		memset(daddr, 0, sizeof(*daddr));
 +		dlen =3D cmsg->cmsg_len - sizeof(struct cmsghdr);
 +		if (cmsg->cmsg_type =3D=3D SCTP_DSTADDRV4) {
 +			if (dlen < sizeof(struct in_addr))
 +				goto free;
 +
 +			dlen =3D sizeof(struct in_addr);
 +			daddr->v4.sin_family =3D AF_INET;
 +			daddr->v4.sin_port =3D htons(asoc->peer.port);
 +			memcpy(&daddr->v4.sin_addr, CMSG_DATA(cmsg), dlen);
 +		} else {
 +			if (dlen < sizeof(struct in6_addr))
 +				goto free;
 =20
 -		/* Label connection socket for first association 1-to-many
 -		 * style for client sequence socket()->sendmsg(). This
 -		 * needs to be done before sctp_assoc_add_peer() as that will
 -		 * set up the initial packet that needs to account for any
 -		 * security ip options (CIPSO/CALIPSO) added to the packet.
 -		 */
 -		af =3D sctp_get_af_specific(to.sa.sa_family);
 -		if (!af) {
 -			err =3D -EINVAL;
 -			goto out_unlock;
 +			dlen =3D sizeof(struct in6_addr);
 +			daddr->v6.sin6_family =3D AF_INET6;
 +			daddr->v6.sin6_port =3D htons(asoc->peer.port);
 +			memcpy(&daddr->v6.sin6_addr, CMSG_DATA(cmsg), dlen);
  		}
 -		err =3D security_sctp_bind_connect(sk, SCTP_SENDMSG_CONNECT,
 -						 (struct sockaddr *)&to,
 -						 af->sockaddr_len);
 -		if (err < 0)
 -			goto out_unlock;
 +		err =3D sctp_verify_addr(sk, daddr, sizeof(*daddr));
 +		if (err)
 +			goto free;
 =20
 -		new_asoc =3D sctp_association_new(ep, sk, scope, GFP_KERNEL);
 -		if (!new_asoc) {
 -			err =3D -ENOMEM;
 -			goto out_unlock;
 -		}
 -		asoc =3D new_asoc;
 -		err =3D sctp_assoc_set_bind_addr_from_ep(asoc, scope, GFP_KERNEL);
 -		if (err < 0) {
 -			err =3D -ENOMEM;
 -			goto out_free;
 +		old =3D sctp_endpoint_lookup_assoc(ep, daddr, &transport);
 +		if (old && old !=3D asoc) {
 +			if (old->state >=3D SCTP_STATE_ESTABLISHED)
 +				err =3D -EISCONN;
 +			else
 +				err =3D -EALREADY;
 +			goto free;
  		}
 =20
 -		/* If the SCTP_INIT ancillary data is specified, set all
 -		 * the association init values accordingly.
 -		 */
 -		if (sinit) {
 -			if (sinit->sinit_num_ostreams) {
 -				__u16 outcnt =3D sinit->sinit_num_ostreams;
 -
 -				asoc->c.sinit_num_ostreams =3D outcnt;
 -				/* outcnt has been changed, so re-init stream */
 -				err =3D sctp_stream_init(&asoc->stream, outcnt, 0,
 -						       GFP_KERNEL);
 -				if (err)
 -					goto out_free;
 -			}
 -			if (sinit->sinit_max_instreams) {
 -				asoc->c.sinit_max_instreams =3D
 -					sinit->sinit_max_instreams;
 -			}
 -			if (sinit->sinit_max_attempts) {
 -				asoc->max_init_attempts
 -					=3D sinit->sinit_max_attempts;
 -			}
 -			if (sinit->sinit_max_init_timeo) {
 -				asoc->max_init_timeo =3D
 -				 msecs_to_jiffies(sinit->sinit_max_init_timeo);
 -			}
 +		if (sctp_endpoint_is_peeled_off(ep, daddr)) {
 +			err =3D -EADDRNOTAVAIL;
 +			goto free;
  		}
 =20
 -		/* Prime the peer's transport structures.  */
 -		transport =3D sctp_assoc_add_peer(asoc, &to, GFP_KERNEL, SCTP_UNKNOWN);
 +		transport =3D sctp_assoc_add_peer(asoc, daddr, GFP_KERNEL,
 +						SCTP_UNKNOWN);
  		if (!transport) {
  			err =3D -ENOMEM;
 -			goto out_free;
 +			goto free;
  		}
  	}
 =20

--Sig_/9dXNQ3LF=I2qh8sZJzDPoiY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgmscACgkQAVBC80lX
0Gxx0wf/byf0Q81AAYRuWPfl+sgTADxCu5NWardNBYvaeweaEx9m+ka9GrtE2Kce
oAehDt8agyXnz/fAK34JMxfWbUFdGNDnw/Mj2Svw/N0gR/6YxfksXoyJlXfF8y+4
3c6FQ3W97qOpEnHQUDoE0YSYkXSj30/vfl7lPAgWq7s1c48BQuzJiqGqzwUxKuxr
ZBYiYZOFAR6+1kqJipGsE/uTqt2MRvGIN4gomtqjD4dAWUJox2rTfbEElAXoyQXq
U/2qKNsXGy6gBMLRKWbpEivA5Z77o/hcBj/vDg4v8kaLCpM7UrjfMe4pZRNgPpVe
seijeb2bkYSWHNqc/U+5xk/AhWBnBw==
=Ow7W
-----END PGP SIGNATURE-----

--Sig_/9dXNQ3LF=I2qh8sZJzDPoiY--
