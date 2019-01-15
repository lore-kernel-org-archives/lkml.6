Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D628C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC0420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547576077;
	bh=jFpQJY/SxyQB2i7VzKNntewDBzXweKzUilUFV7t+oBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TStAEIpOLB1UdzGAMoovkTcO04n1gkQRX0X4cjs2YuIAEabrfuSOyY3W6b6dS20Zc
	 SZsJdvkWnZO6uJFnOcouJkpyNWLsjS2m2cxkEVGJvjNrLguM+xQfHABDnV18nk3m1G
	 OIIFbd7gPE+P3cG6zgG3Vr0l/WXCTeZVM21Kpi8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfAOSOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfAOSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:14:35 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A61D20656;
        Tue, 15 Jan 2019 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547576074;
        bh=jFpQJY/SxyQB2i7VzKNntewDBzXweKzUilUFV7t+oBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0ZHkhxYtKH/HNrCkfxQdoZYuGCxr+LFC0Avpsah1+AWGwZhzWZ/nZPtgM1kQ4tx1
         Q3cvMhrs3sVsNHILoQkKiIljXv7OyvjmE8USDhDZD3Z45Fejk1HTEwEaywos045z+5
         stV4sDq8A3AWNFQ7j9CmcXV841AP5LQSc048oOvw=
Date:   Tue, 15 Jan 2019 20:14:29 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] infiniband: fix a missing check of nla_put
Message-ID: <20190115181429.GP15600@mtr-leonro.mtl.com>
References: <20190105161808.3496-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20190105161808.3496-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 05, 2019 at 10:18:07AM -0600, Aditya Pakki wrote:
> nla_put() may fail. The fix adds a check for its return value, and
> returns -EMSGSIZE if it fails, post canceling netlink msg.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/infiniband/core/addr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 0dce94e3c495..e847b34bacd1 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -178,7 +178,10 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
>  	/* Construct the family header first */
>  	header = skb_put(skb, NLMSG_ALIGN(sizeof(*header)));
>  	header->ifindex = dev_addr->bound_dev_if;
> -	nla_put(skb, attrtype, size, daddr);
> +	if (nla_put(skb, attrtype, size, daddr)) {
> +		nlmsg_cancel(skb, nlh);

It should be nlmsg_free() and not nlmsg_cancel()

> +		return -EMSGSIZE;
> +	}
>
>  	/* Repair the nlmsg header length */
>  	nlmsg_end(skb, nlh);
> --
> 2.17.1
>

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcPiMFAAoJEORje4g2clinqWYP/Ra8NEt0GVIJEra8OE+ynSCx
P2fXTH947KwgDcFbc+eu2aEiLm3v3yFjWjkE5Ut1uBqaeqiUCphSRVdpQ1OPQWC3
cUdqOB21Qr77T47bgoRDvgZGz/+ch5z4nWMQ1I+yZwLj4wmSLP63ZvNaSD2STFxE
SONQ/5N9Dr4sJo7+9WS4SJlud9cgE17ovEfTfeniYUbwDWrkgNnNjXvqtv4a+5Nl
WSrJkxbJxwPQBw8E+Y1oOcWxw42EaSSGVm9DNqcSp60X/gOvuedPx4WvIVp+u8yY
jHbQNUsa6sK8vnmhNW4N0KCO5ROQsXBEvpGtUX9xATyONi8c887xbKYNE+Bm3D6v
jlcaa3XIgDB2l8EEqnaYb+35TEU66YjfUthYR93PQDK+F+T/qfIbQ4+sAHWbdIy3
GUuh7dEGsVJPkqazVcVWF+zZks3P8lhKOa/SUdDPqzLKFpiysutNB/foAyoFTt9/
PBNGgyNnWRah52EjLMRSGoYujs2xoJvaRF9BC1rPlmqL+dP9mhKbavRsyBim9d2h
3AU8DI6ZHRiw4ozm3ykXBPCvkmEvwo9kntuMdcm+jtrdncQsgplZ8b78GSG69/WD
n980swMGW9BpT5pUSy7nU9VfFNU+1jGRdiyQe5kcaUy08A7KpBUpIkzOISNr6nnM
ArXmvtveScB5pHR8/H/w
=L/zf
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
