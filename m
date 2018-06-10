Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ttukHBHCHFtQdwAAmS7hNA
	; Sun, 10 Jun 2018 06:30:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC5C8608BA; Sun, 10 Jun 2018 06:30:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9IefxBT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4E6CB602FC;
	Sun, 10 Jun 2018 06:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E6CB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeFJGad (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753674AbeFJGab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:30:31 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B492087E;
        Sun, 10 Jun 2018 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528612231;
        bh=lzD6Lnl4+KFShPlsUpojpF+5ky6XlNxu7HS4Ap9iDew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9IefxBTNjf0+FjlqGQEpXV3dMJucjbU5JQjslUZgpm9QJMfTTRCXHTysrLxUTHF4
         KpLtlo8M3TPmS3VwmN9EQKNvu9wNSPrRI00IQ/V/UNk0f66sVQ9oS57RYFK7gEXLvf
         OHwNUFQXBUx6eqa0sCHjO2Z+TYxoUzi4vcATertw=
Date: Sun, 10 Jun 2018 09:30:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180610063028.GH12407@mtr-leonro.mtl.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <20180608174218.32455-3-willy@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 10:42:18AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Allocate agent IDs from a global IDR instead of an atomic variable.
> This eliminates the possibility of reusing an ID which is already in
> use after 4 billion registrations, and we can also limit the assigned
> ID to be less than 2^24, which fixes a bug in the mlx4 device.
>
> We look up the agent under protection of the RCU lock, which means we
> have to free the agent using kfree_rcu, and only increment the reference
> counter if it is not 0.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/infiniband/core/mad.c      | 78 ++++++++++++++++++------------
>  drivers/infiniband/core/mad_priv.h |  7 +--
>  include/linux/idr.h                |  9 ++++
>  3 files changed, 59 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
> index 68f4dda916c8..62384a3dd3ec 100644
> --- a/drivers/infiniband/core/mad.c
> +++ b/drivers/infiniband/core/mad.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/dma-mapping.h>
> +#include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/security.h>
> @@ -58,8 +59,8 @@ MODULE_PARM_DESC(send_queue_size, "Size of send queue in number of work requests
>  module_param_named(recv_queue_size, mad_recvq_size, int, 0444);
>  MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of work requests");
>
> +static DEFINE_IDR(ib_mad_clients);
>  static struct list_head ib_mad_port_list;
> -static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
>
>  /* Port list lock */
>  static DEFINE_SPINLOCK(ib_mad_port_list_lock);
> @@ -377,13 +378,24 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
>  		goto error4;
>  	}
>
> -	spin_lock_irq(&port_priv->reg_lock);
> -	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
> +	idr_preload(GFP_KERNEL);
> +	idr_lock(&ib_mad_clients);
> +	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> +			(1 << 24), GFP_ATOMIC);

Hi Matthew,

Thank you for looking on that, I have a couple of comments to the proposed patch.

1. IBTA spec doesn't talk at all about the size of TransactionID, more
on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
says: "The contents of the TransactionID (TID) field are implementation-
dependent. So let's don't call it mlx4 bug.

2. The current implementation means that in mlx5-only network we will
still have upto (1 << 24) TIDs. I don't know if it is really important,
but worth to mention.

Thanks

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbHMWEAAoJEORje4g2clinUWoP/3apYwBEyq7kmWfLOrzmL/T3
2iaHTOY5KC3TsbVLQAUoE7UDqzvxJU3a1DBhPqHbTw8AuF7/kFEZZNmiDV3Onjeo
ru1lxCjFpClpI681OqZYEFv4eWM0JS5K2uXxb3Rr5xiE4X4iJuCJj1DonuWG0/EZ
JMrqkdsBieYaNmodabGkSoBa3mbSUhjb4JMQKwq0HcLcWmaKdxRY8j3i0wfQoVZj
p69dCCMYfCoXUuEjuWq4+JYMXCMqxiLtShsnEqonqKod6yJ9yGt6oen9c/ETd8Jo
ReQ16nZ+D2ZyJMjOWW17cwyQP2K5v0O8hGPiVHTkjtDtBcgjJf1pKl5pDU/g7g8T
9st7GEqPekkujWeed+59AIR5rSi7lsFS74yhmeScYraa0rtXLb+Gm/aBFEbJyxpG
BEwCaALp4N/UQ+PuHmix7PB4FqxFKcvb4UIBOOcDbK9bzy0ga55tJidbVuOi6b3T
GThL5mXM/gtbmj5qBT8JEE9xz4hRpD8x2uZGfRfIHIx7bqKk4U7ykqCl9hdm+EF3
hKrZSuDzfopljThxx4c4c4Ez7sE9VBvAJ9MdiEnUFp4m10MEsoP4xgkFzVK7JNuj
jUz5jyxFp1oPjHMgHqO9p1QCBTMclekggDloskdWzwZNFLm0DY2IGMUP7Ze14Ihs
5rO09A/00Oq6esO10qDk
=RXCl
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
