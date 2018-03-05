Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeCEHD1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:03:27 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38253 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933001AbeCEHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:03:07 -0500
X-Google-Smtp-Source: AG47ELuOxu7QXPAXaK7qFyAqbUdlFc/1x3oewpob3EVTKzUTVLYzsBss19rbcpjXjyDAiPW5pFatTUqa3fTFmv2Pkww=
MIME-Version: 1.0
In-Reply-To: <20180305124054.09966cb0@canb.auug.org.au>
References: <20180305124054.09966cb0@canb.auug.org.au>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 5 Mar 2018 15:03:05 +0800
Message-ID: <CADvbK_cMVBWO7zgnyG=L8T5cTKfjyUXQAAv+a2ne5WVZ9TBJ4g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Moore <paul@paul-moore.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 9:40 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Paul,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   net/sctp/socket.c
>
> between several refactoring commits from the net-next tree and commit:
>
>   2277c7cd75e3 ("sctp: Add LSM hooks")
>
> from the selinux tree.
>
> I fixed it up (I think - see below) and can carry the fix as
The fixup is great!  the same as I mentioned in:
https://patchwork.ozlabs.org/patch/879898/
for net-next.git

> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
[net-next,0/9] sctp: clean up sctp_sendmsg, this patchset was just applied
in net-next. So I just guess it might not yet be there when selinux tree was
being submitted.

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc net/sctp/socket.c
> index 7fa76031bb08,73b34a6b5b09..000000000000
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@@ -1606,193 -1622,362 +1622,209 @@@ static int sctp_error(struct sock *sk,
>   static int sctp_msghdr_parse(const struct msghdr *msg,
>                              struct sctp_cmsgs *cmsgs);
>
>  -static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
>  +static int sctp_sendmsg_parse(struct sock *sk, struct sctp_cmsgs *cmsgs,
>  +                            struct sctp_sndrcvinfo *srinfo,
>  +                            const struct msghdr *msg, size_t msg_len)
>   {
>  -      struct net *net = sock_net(sk);
>  -      struct sctp_sock *sp;
>  -      struct sctp_endpoint *ep;
>  -      struct sctp_association *new_asoc = NULL, *asoc = NULL;
>  -      struct sctp_transport *transport, *chunk_tp;
>  -      struct sctp_chunk *chunk;
>  -      union sctp_addr to;
>  -      struct sctp_af *af;
>  -      struct sockaddr *msg_name = NULL;
>  -      struct sctp_sndrcvinfo default_sinfo;
>  -      struct sctp_sndrcvinfo *sinfo;
>  -      struct sctp_initmsg *sinit;
>  -      sctp_assoc_t associd = 0;
>  -      struct sctp_cmsgs cmsgs = { NULL };
>  -      enum sctp_scope scope;
>  -      bool fill_sinfo_ttl = false, wait_connect = false;
>  -      struct sctp_datamsg *datamsg;
>  -      int msg_flags = msg->msg_flags;
>  -      __u16 sinfo_flags = 0;
>  -      long timeo;
>  +      __u16 sflags;
>         int err;
>
>  -      err = 0;
>  -      sp = sctp_sk(sk);
>  -      ep = sp->ep;
>  -
>  -      pr_debug("%s: sk:%p, msg:%p, msg_len:%zu ep:%p\n", __func__, sk,
>  -               msg, msg_len, ep);
>  +      if (sctp_sstate(sk, LISTENING) && sctp_style(sk, TCP))
>  +              return -EPIPE;
>
>  -      /* We cannot send a message over a TCP-style listening socket. */
>  -      if (sctp_style(sk, TCP) && sctp_sstate(sk, LISTENING)) {
>  -              err = -EPIPE;
>  -              goto out_nounlock;
>  -      }
>  +      if (msg_len > sk->sk_sndbuf)
>  +              return -EMSGSIZE;
>
>  -      /* Parse out the SCTP CMSGs.  */
>  -      err = sctp_msghdr_parse(msg, &cmsgs);
>  +      memset(cmsgs, 0, sizeof(*cmsgs));
>  +      err = sctp_msghdr_parse(msg, cmsgs);
>         if (err) {
>                 pr_debug("%s: msghdr parse err:%x\n", __func__, err);
>  -              goto out_nounlock;
>  +              return err;
>         }
>
>  -      /* Fetch the destination address for this packet.  This
>  -       * address only selects the association--it is not necessarily
>  -       * the address we will send to.
>  -       * For a peeled-off socket, msg_name is ignored.
>  -       */
>  -      if (!sctp_style(sk, UDP_HIGH_BANDWIDTH) && msg->msg_name) {
>  -              int msg_namelen = msg->msg_namelen;
>  -
>  -              err = sctp_verify_addr(sk, (union sctp_addr *)msg->msg_name,
>  -                                     msg_namelen);
>  -              if (err)
>  -                      return err;
>  -
>  -              if (msg_namelen > sizeof(to))
>  -                      msg_namelen = sizeof(to);
>  -              memcpy(&to, msg->msg_name, msg_namelen);
>  -              msg_name = msg->msg_name;
>  +      memset(srinfo, 0, sizeof(*srinfo));
>  +      if (cmsgs->srinfo) {
>  +              srinfo->sinfo_stream = cmsgs->srinfo->sinfo_stream;
>  +              srinfo->sinfo_flags = cmsgs->srinfo->sinfo_flags;
>  +              srinfo->sinfo_ppid = cmsgs->srinfo->sinfo_ppid;
>  +              srinfo->sinfo_context = cmsgs->srinfo->sinfo_context;
>  +              srinfo->sinfo_assoc_id = cmsgs->srinfo->sinfo_assoc_id;
>  +              srinfo->sinfo_timetolive = cmsgs->srinfo->sinfo_timetolive;
>         }
>
>  -      sinit = cmsgs.init;
>  -      if (cmsgs.sinfo != NULL) {
>  -              memset(&default_sinfo, 0, sizeof(default_sinfo));
>  -              default_sinfo.sinfo_stream = cmsgs.sinfo->snd_sid;
>  -              default_sinfo.sinfo_flags = cmsgs.sinfo->snd_flags;
>  -              default_sinfo.sinfo_ppid = cmsgs.sinfo->snd_ppid;
>  -              default_sinfo.sinfo_context = cmsgs.sinfo->snd_context;
>  -              default_sinfo.sinfo_assoc_id = cmsgs.sinfo->snd_assoc_id;
>  -
>  -              sinfo = &default_sinfo;
>  -              fill_sinfo_ttl = true;
>  -      } else {
>  -              sinfo = cmsgs.srinfo;
>  -      }
>  -      /* Did the user specify SNDINFO/SNDRCVINFO? */
>  -      if (sinfo) {
>  -              sinfo_flags = sinfo->sinfo_flags;
>  -              associd = sinfo->sinfo_assoc_id;
>  +      if (cmsgs->sinfo) {
>  +              srinfo->sinfo_stream = cmsgs->sinfo->snd_sid;
>  +              srinfo->sinfo_flags = cmsgs->sinfo->snd_flags;
>  +              srinfo->sinfo_ppid = cmsgs->sinfo->snd_ppid;
>  +              srinfo->sinfo_context = cmsgs->sinfo->snd_context;
>  +              srinfo->sinfo_assoc_id = cmsgs->sinfo->snd_assoc_id;
>         }
>
>  -      pr_debug("%s: msg_len:%zu, sinfo_flags:0x%x\n", __func__,
>  -               msg_len, sinfo_flags);
>  +      sflags = srinfo->sinfo_flags;
>  +      if (!sflags && msg_len)
>  +              return 0;
>
>  -      /* SCTP_EOF or SCTP_ABORT cannot be set on a TCP-style socket. */
>  -      if (sctp_style(sk, TCP) && (sinfo_flags & (SCTP_EOF | SCTP_ABORT))) {
>  -              err = -EINVAL;
>  -              goto out_nounlock;
>  -      }
>  +      if (sctp_style(sk, TCP) && (sflags & (SCTP_EOF | SCTP_ABORT)))
>  +              return -EINVAL;
>
>  -      /* If SCTP_EOF is set, no data can be sent. Disallow sending zero
>  -       * length messages when SCTP_EOF|SCTP_ABORT is not set.
>  -       * If SCTP_ABORT is set, the message length could be non zero with
>  -       * the msg_iov set to the user abort reason.
>  -       */
>  -      if (((sinfo_flags & SCTP_EOF) && (msg_len > 0)) ||
>  -          (!(sinfo_flags & (SCTP_EOF|SCTP_ABORT)) && (msg_len == 0))) {
>  -              err = -EINVAL;
>  -              goto out_nounlock;
>  -      }
>  +      if (((sflags & SCTP_EOF) && msg_len > 0) ||
>  +          (!(sflags & (SCTP_EOF | SCTP_ABORT)) && msg_len == 0))
>  +              return -EINVAL;
>
>  -      /* If SCTP_ADDR_OVER is set, there must be an address
>  -       * specified in msg_name.
>  -       */
>  -      if ((sinfo_flags & SCTP_ADDR_OVER) && (!msg->msg_name)) {
>  -              err = -EINVAL;
>  -              goto out_nounlock;
>  -      }
>  +      if ((sflags & SCTP_ADDR_OVER) && !msg->msg_name)
>  +              return -EINVAL;
>
>  -      transport = NULL;
>  +      return 0;
>  +}
>
>  -      pr_debug("%s: about to look up association\n", __func__);
>  +static int sctp_sendmsg_new_asoc(struct sock *sk, __u16 sflags,
>  +                               struct sctp_cmsgs *cmsgs,
>  +                               union sctp_addr *daddr,
>  +                               struct sctp_transport **tp)
>  +{
>  +      struct sctp_endpoint *ep = sctp_sk(sk)->ep;
>  +      struct net *net = sock_net(sk);
>  +      struct sctp_association *asoc;
>  +      enum sctp_scope scope;
> ++      struct sctp_af *af;
>  +      int err = -EINVAL;
>
>  -      lock_sock(sk);
>  +      *tp = NULL;
>
>  -      /* If a msg_name has been specified, assume this is to be used.  */
>  -      if (msg_name) {
>  -              /* Look for a matching association on the endpoint. */
>  -              asoc = sctp_endpoint_lookup_assoc(ep, &to, &transport);
>  +      if (sflags & (SCTP_EOF | SCTP_ABORT))
>  +              return -EINVAL;
>
>  -              /* If we could not find a matching association on the
>  -               * endpoint, make sure that it is not a TCP-style
>  -               * socket that already has an association or there is
>  -               * no peeled-off association on another socket.
>  -               */
>  -              if (!asoc &&
>  -                  ((sctp_style(sk, TCP) &&
>  -                    (sctp_sstate(sk, ESTABLISHED) ||
>  -                     sctp_sstate(sk, CLOSING))) ||
>  -                   sctp_endpoint_is_peeled_off(ep, &to))) {
>  -                      err = -EADDRNOTAVAIL;
>  -                      goto out_unlock;
>  -              }
>  +      if (sctp_style(sk, TCP) && (sctp_sstate(sk, ESTABLISHED) ||
>  +                                  sctp_sstate(sk, CLOSING)))
>  +              return -EADDRNOTAVAIL;
>  +
>  +      if (sctp_endpoint_is_peeled_off(ep, daddr))
>  +              return -EADDRNOTAVAIL;
>  +
>  +      if (!ep->base.bind_addr.port) {
>  +              if (sctp_autobind(sk))
>  +                      return -EAGAIN;
>         } else {
>  -              asoc = sctp_id2assoc(sk, associd);
>  -              if (!asoc) {
>  -                      err = -EPIPE;
>  -                      goto out_unlock;
>  -              }
>  +              if (ep->base.bind_addr.port < inet_prot_sock(net) &&
>  +                  !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
>  +                      return -EACCES;
>         }
>
>  -      if (asoc) {
>  -              pr_debug("%s: just looked up association:%p\n", __func__, asoc);
>  +      scope = sctp_scope(daddr);
>
>  -              /* We cannot send a message on a TCP-style SCTP_SS_ESTABLISHED
>  -               * socket that has an association in CLOSED state. This can
>  -               * happen when an accepted socket has an association that is
>  -               * already CLOSED.
>  -               */
>  -              if (sctp_state(asoc, CLOSED) && sctp_style(sk, TCP)) {
>  -                      err = -EPIPE;
>  -                      goto out_unlock;
>  -              }
> ++      /* Label connection socket for first association 1-to-many
> ++       * style for client sequence socket()->sendmsg(). This
> ++       * needs to be done before sctp_assoc_add_peer() as that will
> ++       * set up the initial packet that needs to account for any
> ++       * security ip options (CIPSO/CALIPSO) added to the packet.
> ++       */
> ++      af = sctp_get_af_specific(daddr->sa.sa_family);
> ++      if (!af)
> ++              return -EINVAL;
> ++      err = security_sctp_bind_connect(sk, SCTP_SENDMSG_CONNECT,
> ++                                       (struct sockaddr *)daddr,
> ++                                       af->sockaddr_len);
> ++      if (err < 0)
> ++              return err;
> +
>  -              if (sinfo_flags & SCTP_EOF) {
>  -                      pr_debug("%s: shutting down association:%p\n",
>  -                               __func__, asoc);
>  +      asoc = sctp_association_new(ep, sk, scope, GFP_KERNEL);
>  +      if (!asoc)
>  +              return -ENOMEM;
>
>  -                      sctp_primitive_SHUTDOWN(net, asoc, NULL);
>  -                      err = 0;
>  -                      goto out_unlock;
>  -              }
>  -              if (sinfo_flags & SCTP_ABORT) {
>  +      if (sctp_assoc_set_bind_addr_from_ep(asoc, scope, GFP_KERNEL) < 0) {
>  +              err = -ENOMEM;
>  +              goto free;
>  +      }
>
>  -                      chunk = sctp_make_abort_user(asoc, msg, msg_len);
>  -                      if (!chunk) {
>  -                              err = -ENOMEM;
>  -                              goto out_unlock;
>  -                      }
>  +      if (cmsgs->init) {
>  +              struct sctp_initmsg *init = cmsgs->init;
>
>  -                      pr_debug("%s: aborting association:%p\n",
>  -                               __func__, asoc);
>  +              if (init->sinit_num_ostreams) {
>  +                      __u16 outcnt = init->sinit_num_ostreams;
>
>  -                      sctp_primitive_ABORT(net, asoc, chunk);
>  -                      err = 0;
>  -                      goto out_unlock;
>  +                      asoc->c.sinit_num_ostreams = outcnt;
>  +                      /* outcnt has been changed, need to re-init stream */
>  +                      err = sctp_stream_init(&asoc->stream, outcnt, 0,
>  +                                             GFP_KERNEL);
>  +                      if (err)
>  +                              goto free;
>                 }
>  -      }
>
>  -      /* Do we need to create the association?  */
>  -      if (!asoc) {
>  -              pr_debug("%s: there is no association yet\n", __func__);
>  +              if (init->sinit_max_instreams)
>  +                      asoc->c.sinit_max_instreams = init->sinit_max_instreams;
>
>  -              if (sinfo_flags & (SCTP_EOF | SCTP_ABORT)) {
>  -                      err = -EINVAL;
>  -                      goto out_unlock;
>  -              }
>  +              if (init->sinit_max_attempts)
>  +                      asoc->max_init_attempts = init->sinit_max_attempts;
>
>  -              /* Check for invalid stream against the stream counts,
>  -               * either the default or the user specified stream counts.
>  -               */
>  -              if (sinfo) {
>  -                      if (!sinit || !sinit->sinit_num_ostreams) {
>  -                              /* Check against the defaults. */
>  -                              if (sinfo->sinfo_stream >=
>  -                                  sp->initmsg.sinit_num_ostreams) {
>  -                                      err = -EINVAL;
>  -                                      goto out_unlock;
>  -                              }
>  -                      } else {
>  -                              /* Check against the requested.  */
>  -                              if (sinfo->sinfo_stream >=
>  -                                  sinit->sinit_num_ostreams) {
>  -                                      err = -EINVAL;
>  -                                      goto out_unlock;
>  -                              }
>  -                      }
>  -              }
>  +              if (init->sinit_max_init_timeo)
>  +                      asoc->max_init_timeo =
>  +                              msecs_to_jiffies(init->sinit_max_init_timeo);
>  +      }
>
>  -              /*
>  -               * API 3.1.2 bind() - UDP Style Syntax
>  -               * If a bind() or sctp_bindx() is not called prior to a
>  -               * sendmsg() call that initiates a new association, the
>  -               * system picks an ephemeral port and will choose an address
>  -               * set equivalent to binding with a wildcard address.
>  -               */
>  -              if (!ep->base.bind_addr.port) {
>  -                      if (sctp_autobind(sk)) {
>  -                              err = -EAGAIN;
>  -                              goto out_unlock;
>  -                      }
>  -              } else {
>  -                      /*
>  -                       * If an unprivileged user inherits a one-to-many
>  -                       * style socket with open associations on a privileged
>  -                       * port, it MAY be permitted to accept new associations,
>  -                       * but it SHOULD NOT be permitted to open new
>  -                       * associations.
>  -                       */
>  -                      if (ep->base.bind_addr.port < inet_prot_sock(net) &&
>  -                          !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE)) {
>  -                              err = -EACCES;
>  -                              goto out_unlock;
>  -                      }
>  -              }
>  +      *tp = sctp_assoc_add_peer(asoc, daddr, GFP_KERNEL, SCTP_UNKNOWN);
>  +      if (!*tp) {
>  +              err = -ENOMEM;
>  +              goto free;
>  +      }
>
>  -              scope = sctp_scope(&to);
>  +      return 0;
>
>  -              /* Label connection socket for first association 1-to-many
>  -               * style for client sequence socket()->sendmsg(). This
>  -               * needs to be done before sctp_assoc_add_peer() as that will
>  -               * set up the initial packet that needs to account for any
>  -               * security ip options (CIPSO/CALIPSO) added to the packet.
>  -               */
>  -              af = sctp_get_af_specific(to.sa.sa_family);
>  -              if (!af) {
>  -                      err = -EINVAL;
>  -                      goto out_unlock;
>  -              }
>  -              err = security_sctp_bind_connect(sk, SCTP_SENDMSG_CONNECT,
>  -                                               (struct sockaddr *)&to,
>  -                                               af->sockaddr_len);
>  -              if (err < 0)
>  -                      goto out_unlock;
>  +free:
>  +      sctp_association_free(asoc);
>  +      return err;
>  +}
>
>  -              new_asoc = sctp_association_new(ep, sk, scope, GFP_KERNEL);
>  -              if (!new_asoc) {
>  -                      err = -ENOMEM;
>  -                      goto out_unlock;
>  -              }
>  -              asoc = new_asoc;
>  -              err = sctp_assoc_set_bind_addr_from_ep(asoc, scope, GFP_KERNEL);
>  -              if (err < 0) {
>  -                      err = -ENOMEM;
>  -                      goto out_free;
>  -              }
>  +static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
>  +                                   __u16 sflags, struct msghdr *msg,
>  +                                   size_t msg_len)
>  +{
>  +      struct sock *sk = asoc->base.sk;
>  +      struct net *net = sock_net(sk);
>
>  -              /* If the SCTP_INIT ancillary data is specified, set all
>  -               * the association init values accordingly.
>  -               */
>  -              if (sinit) {
>  -                      if (sinit->sinit_num_ostreams) {
>  -                              __u16 outcnt = sinit->sinit_num_ostreams;
>  -
>  -                              asoc->c.sinit_num_ostreams = outcnt;
>  -                              /* outcnt has been changed, so re-init stream */
>  -                              err = sctp_stream_init(&asoc->stream, outcnt, 0,
>  -                                                     GFP_KERNEL);
>  -                              if (err)
>  -                                      goto out_free;
>  -                      }
>  -                      if (sinit->sinit_max_instreams) {
>  -                              asoc->c.sinit_max_instreams =
>  -                                      sinit->sinit_max_instreams;
>  -                      }
>  -                      if (sinit->sinit_max_attempts) {
>  -                              asoc->max_init_attempts
>  -                                      = sinit->sinit_max_attempts;
>  -                      }
>  -                      if (sinit->sinit_max_init_timeo) {
>  -                              asoc->max_init_timeo =
>  -                               msecs_to_jiffies(sinit->sinit_max_init_timeo);
>  -                      }
>  -              }
>  +      if (sctp_state(asoc, CLOSED) && sctp_style(sk, TCP))
>  +              return -EPIPE;
>
>  -              /* Prime the peer's transport structures.  */
>  -              transport = sctp_assoc_add_peer(asoc, &to, GFP_KERNEL, SCTP_UNKNOWN);
>  -              if (!transport) {
>  -                      err = -ENOMEM;
>  -                      goto out_free;
>  -              }
>  +      if (sflags & SCTP_EOF) {
>  +              pr_debug("%s: shutting down association:%p\n", __func__, asoc);
>  +              sctp_primitive_SHUTDOWN(net, asoc, NULL);
>  +
>  +              return 0;
>         }
>
>  -      /* ASSERT: we have a valid association at this point.  */
>  -      pr_debug("%s: we have a valid association\n", __func__);
>  +      if (sflags & SCTP_ABORT) {
>  +              struct sctp_chunk *chunk;
>
>  -      if (!sinfo) {
>  -              /* If the user didn't specify SNDINFO/SNDRCVINFO, make up
>  -               * one with some defaults.
>  -               */
>  -              memset(&default_sinfo, 0, sizeof(default_sinfo));
>  -              default_sinfo.sinfo_stream = asoc->default_stream;
>  -              default_sinfo.sinfo_flags = asoc->default_flags;
>  -              default_sinfo.sinfo_ppid = asoc->default_ppid;
>  -              default_sinfo.sinfo_context = asoc->default_context;
>  -              default_sinfo.sinfo_timetolive = asoc->default_timetolive;
>  -              default_sinfo.sinfo_assoc_id = sctp_assoc2id(asoc);
>  -
>  -              sinfo = &default_sinfo;
>  -      } else if (fill_sinfo_ttl) {
>  -              /* In case SNDINFO was specified, we still need to fill
>  -               * it with a default ttl from the assoc here.
>  -               */
>  -              sinfo->sinfo_timetolive = asoc->default_timetolive;
>  -      }
>  +              chunk = sctp_make_abort_user(asoc, msg, msg_len);
>  +              if (!chunk)
>  +                      return -ENOMEM;
>
>  -      /* API 7.1.7, the sndbuf size per association bounds the
>  -       * maximum size of data that can be sent in a single send call.
>  -       */
>  -      if (msg_len > sk->sk_sndbuf) {
>  -              err = -EMSGSIZE;
>  -              goto out_free;
>  +              pr_debug("%s: aborting association:%p\n", __func__, asoc);
>  +              sctp_primitive_ABORT(net, asoc, chunk);
>  +
>  +              return 0;
>         }
>
>  -      if (asoc->pmtu_pending)
>  -              sctp_assoc_pending_pmtu(asoc);
>  +      return 1;
>  +}
>
>  -      /* If fragmentation is disabled and the message length exceeds the
>  -       * association fragmentation point, return EMSGSIZE.  The I-D
>  -       * does not specify what this error is, but this looks like
>  -       * a great fit.
>  -       */
>  -      if (sctp_sk(sk)->disable_fragments && (msg_len > asoc->frag_point)) {
>  -              err = -EMSGSIZE;
>  -              goto out_free;
>  -      }
>  +static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
>  +                              struct msghdr *msg, size_t msg_len,
>  +                              struct sctp_transport *transport,
>  +                              struct sctp_sndrcvinfo *sinfo)
>  +{
>  +      struct sock *sk = asoc->base.sk;
>  +      struct net *net = sock_net(sk);
>  +      struct sctp_datamsg *datamsg;
>  +      bool wait_connect = false;
>  +      struct sctp_chunk *chunk;
>  +      long timeo;
>  +      int err;
>
>  -      /* Check for invalid stream. */
>         if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
>                 err = -EINVAL;
>  -              goto out_free;
>  +              goto err;
>         }
>
>  -      /* Allocate sctp_stream_out_ext if not already done */
>         if (unlikely(!asoc->stream.out[sinfo->sinfo_stream].ext)) {
>                 err = sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_stream);
>                 if (err)
