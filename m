Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F6920818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBVCwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:52:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50412 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVCwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:52:04 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gx0wP-00033q-BV; Fri, 22 Feb 2019 02:51:57 +0000
Date:   Fri, 22 Feb 2019 02:51:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
Message-ID: <20190222025157.GC2217@ZenIV.linux.org.uk>
References: <20190221221356.173485-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221221356.173485-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:13:56PM -0800, Eric Biggers wrote:

> Rather than fixing all these and relying on every socket type to get
> this right forever, just make __sock_release() set sock->sk to NULL
> itself after calling proto_ops::release().

	Is there any case when we would want sock->sk non-NULL when
sock->sk->sk_socket is NULL?

	IOW, why not make sock_orphan() take care of that, at the same
time we dissociate sock from socket?  After all, on the other end
of things we have both sock_graft() and sock_init_data() set both
sock->sk and sk->sk_socket...

	Looking at the assignments to sock->sk, I see
* atalk_release(), bcm_release(), raw_release(), pfkey_release(),
pppol2tp_release(), packet_release(), smc_release(), xsk_release() -
directly after sock_orphan()
* rxrpc_release() - directly *before* sock_orphan()

* ax25_release() - somewhat after sock_orphan(); no idea if anything
done in between needs it still set.  Doesn't looks like there could
be - readers of sock->sk in there are all in methods that can't
overlap with ->release().
* kcm_release() - similar.
* rds_release() - similar.
* tipc_release() - similar.
* unix_accept() - similar, and there I'm fairly sure it could be
done right after sock_orphan()
* netrom_release() - similar.  BTW, why the hell does nr_accept()
check for NULL sock->sk, while other methods (callable for exact
same sockets) assume that it's non-NULL?  AFAICS, the check in
nr_accept() is pointless - nr_create() can leave sock->sk NULL
only if it fails, in which case it's going to be immediately
hit by ->release() and freed by iput() in sock_release().
* rose_release() - similar, complete with ->accept() oddity.

* caif_release() - done *before* sock_orphan(), with other bit of
the latter duplicated just prior.  NFI why; it messes with
debugfs, so there's a whole kettle of copulating slugs involved ;-/

* ieee802154_sock_release(), inet_release(), pn_socket_release() -
done before calliing into protocol's ->close(), which ends up
calling sock_orphan(), either directly or via sk_common_release().
I suspect that we would be find with zeroing sock->sk delayed
until sock_orphan() in all of those, but that needs more RTFS
than I want to go into at the moment.

* netlink_release() - somewhat after sock_orphan(); not sure,
calls of ->netlink_unbind() done inbetween might want it still
set.

* qrtr_release() - lacks sock_orphan(), might be broken

* vsock_releae() - NFI.

* vcc_create() - clears sock->sk in the very beginning; AFAICS
that's pointless.
