Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB651C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FA920873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STmHNsRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FA920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeGJFju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeGJFjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:39:48 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A0320873;
        Tue, 10 Jul 2018 05:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531201188;
        bh=+L9biaam00i/5fDTM7YvKSjAvJakID01EfO8ZcCpgSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STmHNsRkZSA5OshD4crYYz/+tD4/fQZGeYN1Zwa47KehDag34saJPkHK+3+POzPeA
         YXSJJKwwW2rPQPrzKrPsbPRE5UFeFgwBAm3KdB27UmCJ0LzGvW1vNnPYUcvfyKjNdp
         /OIu02pzCNVL9Ldz1wD1JAcoQyIrQlQKTmSaBRyc=
Date:   Tue, 10 Jul 2018 08:39:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Message-ID: <20180710053944.GN3014@mtr-leonro.mtl.com>
References: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OOz7ZB592LYQf07"
Content-Disposition: inline
In-Reply-To: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OOz7ZB592LYQf07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 04:51:08PM +0300, Jan Dakinevich wrote:
> An array of pointers to SRPT contexts in ib_device is over 30KiB even
> in default case, in which an amount of contexts is 4095. The patch
> is intended to weed out large contigous allocation for non-DMA memory.

kvmalloc* doesn't "weed out" large contiguous allocations, but tries to
allocate them and gracefully fallback to vmalloc if kmalloc fails.

More on that, for allocations less than page (64KB for PowerPC), it will
not call to vmalloc at all, which is fine too, because pages granularity.

If you want to get rid of "contiguous allocations", use vmalloc instead.

Thanks

>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 3081c62..de167af 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -720,7 +720,7 @@ static struct srpt_ioctx **srpt_alloc_ioctx_ring(struct srpt_device *sdev,
>  	WARN_ON(ioctx_size != sizeof(struct srpt_recv_ioctx)
>  		&& ioctx_size != sizeof(struct srpt_send_ioctx));
>
> -	ring = kmalloc_array(ring_size, sizeof(ring[0]), GFP_KERNEL);
> +	ring = kvmalloc_array(ring_size, sizeof(ring[0]), GFP_KERNEL);
>  	if (!ring)
>  		goto out;
>  	for (i = 0; i < ring_size; ++i) {
> @@ -734,7 +734,7 @@ static struct srpt_ioctx **srpt_alloc_ioctx_ring(struct srpt_device *sdev,
>  err:
>  	while (--i >= 0)
>  		srpt_free_ioctx(sdev, ring[i], dma_size, dir);
> -	kfree(ring);
> +	kvfree(ring);
>  	ring = NULL;
>  out:
>  	return ring;
> @@ -759,7 +759,7 @@ static void srpt_free_ioctx_ring(struct srpt_ioctx **ioctx_ring,
>
>  	for (i = 0; i < ring_size; ++i)
>  		srpt_free_ioctx(sdev, ioctx_ring[i], dma_size, dir);
> -	kfree(ioctx_ring);
> +	kvfree(ioctx_ring);
>  }
>
>  /**
> --
> 2.1.4
>

--0OOz7ZB592LYQf07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbREagAAoJEORje4g2clinc8MP/jEJQeruV+X+Af8kW/TU/Jps
GF1fuPUL+XTh47Zr6BHbCAspjcHn853TS43o4IQOJFMaCWHfkxBAxx0Qf9dm/FfR
xrwFmtBdOu5nvMfNG6LAQ9j1RmpsAi+wSii3xZJRgwM3uc7kYHYlkmm+y6fGALKL
ceQS9bhhI1m9CHTR+u61p5hTesxr3s8fY2mUoYh6vmCEh2RWgPMvUF9U/Gq5u3br
D9GAhYXd63K2OxIS1C1K9I6+5h6rpFuar/jQgrC1yrWqfOvalnjZCytiIEX1Mz2E
T2urRf6v/h5RZFCHGkm/ke0XIug9Vig/T58d1Byj6h7tBtwq+kXiue2EHCIKh1UT
D4T1EbwP24i+64SzYcABz5eLMIATLp6vgEtbP9HeS5HykgE01ct+4d6RT0r0V1Fe
MyDTpg7Kl3sU4nTF4EV8ZAnG9EvRcu2ZIjb0YqDQ1BbGmPTUjUrZvfU9o8f75Pyf
qlitI0cig2N2QzfCY12wkDP/SxEBRGaOXaAVhNvnthIQ2uHjBWvRf4lL3dK99qz2
bq8/mF+SQBqnTHVAI+3Xxh8GQahEDk6T1+nkpa6U7PMaQNEZTqC28IKN5TefI0nD
GpguPEmBraFCxdeHfVRKPf7pGKrmlAVXp4txyBTEf28vFlt0XhvUD3ZMgCsd9pu2
YMviGhO3eGg28Gnw53Mb
=Z3p4
-----END PGP SIGNATURE-----

--0OOz7ZB592LYQf07--
