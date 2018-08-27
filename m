Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF3B208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF3B208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH1C64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:58:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:47193 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeH1C64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:58:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D2A41C009; Tue, 28 Aug 2018 01:10:09 +0200 (CEST)
Date:   Tue, 28 Aug 2018 01:09:54 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: Re: [PATCH v2 2/2] 9p: Add refcount to p9_req_t
Message-ID: <20180827230954.GA21513@nautica>
References: <20180814174342.11068-1-tomasbortoli@gmail.com>
 <20180814174342.11068-2-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814174342.11068-2-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Tue, Aug 14, 2018:
> To avoid use-after-free(s), use a refcount to keep track of the
> usable references to any instantiated struct p9_req_t.
> 
> This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
> wrappers to kref_put(), kref_get() and kref_get_unless_zero().
> These are used by the client and the transports to keep track of
> valid requests' references.
> 
> p9_free_req() is added back and used as callback by kref_put().
> 
> Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
> kmem_cache_free() will not be reused for another type until the rcu
> synchronisation period is over, so an address gotten under rcu read
> lock is safe to inc_ref() without corrupting random memory while
> the lock is held.


FWIW, since 4.19-rc1 has been tagged I was going to push this and all
the perrequesites to linux-next, but I've managed to leak some requests
by interrupting them in trans_virtio.
I think I've found why (see below), so I'll push a fixed version after
some more testing and another thorough read -- at some point today, but
this hasn't been 'approved' explicitely so please review! :)

(Jun, I think you'll need to ask again to rename 'req' to 'rreq' if you
think it's important -- I think such a rename should go in a separate
patch anyway, there's plenty of time until the 4.20 merge window)


By "all the prerequesites" I mean this patch "serie":
* 9p: Use a slab for allocating requests
* 9p: Remove p9_idpool
* net/9p: embed fcall in req to round down buffer allocs
* net/9p: add a per-client fcall kmem_cache
* 9p: rename p9_free_req() function
* 9p: Add refcount to p9_req_t

All the other patchs have had some review though, I was just waiting for
the start of this cycle, but if someone has any issue with the above
patches now is a good time to say.


> diff --git a/net/9p/client.c b/net/9p/client.c
> index 7942c0bfcc5b..c9bb5d41afa4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  
>  	err = c->trans_mod->request(c, req);
>  	if (err < 0) {
> +		/* write won't happen */
> +		p9_req_put(req);
>  		if (err != -ERESTARTSYS && err != -EFAULT)
>  			c->status = Disconnected;
>  		goto recalc_sigpending;

p9_client_zc_rpc needs the same put if zc_request failed, I'm not sure
why it wasn't here in my draft

-- 
Dominique
