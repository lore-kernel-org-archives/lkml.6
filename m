Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C86C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AF2208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="egTXtHwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AF2208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934261AbeGJPxY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933976AbeGJPxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:53:23 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3105A208F7;
        Tue, 10 Jul 2018 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531238002;
        bh=YLmV+Fy7wGILUFUkdG2vReVLfdnqZvvqKabU8QIR2Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egTXtHwGhrX7PVghah+YFyMa2oHlDDLnGx2CEOtiXaEGhtbN4sWA2erigi9BY50xB
         Mx+IMogyn1ZQxk3QkM/tchcaMfzDOUoy2ztjzd4X8hXrV1DDToa6CozaUpsfuhC36u
         XWZZCENmZMKPN2XD9LriI+Vu0ehorycvb16z9e/g=
Date:   Tue, 10 Jul 2018 18:53:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "jan.dakinevich@virtuozzo.com" <jan.dakinevich@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "den@virtuozzo.com" <den@virtuozzo.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "khorenko@virtuozzo.com" <khorenko@virtuozzo.com>
Subject: Re: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Message-ID: <20180710155318.GI3014@mtr-leonro.mtl.com>
References: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <20180710053944.GN3014@mtr-leonro.mtl.com>
 <5196ea6e33825dd5fde58d23b38630afafcb77f1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yuedfix5hmtMJRO4"
Content-Disposition: inline
In-Reply-To: <5196ea6e33825dd5fde58d23b38630afafcb77f1.camel@wdc.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yuedfix5hmtMJRO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2018 at 03:08:38PM +0000, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 08:39 +0300, Leon Romanovsky wrote:
> > On Mon, Jul 09, 2018 at 04:51:08PM +0300, Jan Dakinevich wrote:
> > > An array of pointers to SRPT contexts in ib_device is over 30KiB even
> > > in default case, in which an amount of contexts is 4095. The patch
> > > is intended to weed out large contigous allocation for non-DMA memory.
> >
> > kvmalloc* doesn't "weed out" large contiguous allocations, but tries to
> > allocate them and gracefully fallback to vmalloc if kmalloc fails.
> >
> > More on that, for allocations less than page (64KB for PowerPC), it will
> > not call to vmalloc at all, which is fine too, because pages granularity.
> >
> > If you want to get rid of "contiguous allocations", use vmalloc instead.
>
> vmalloc() has a very significant disadvantage compared to kvmalloc(): with
> vmalloc() it is guaranteed that memory allocations will be slow. That's not
> the case for kvmalloc() if the number of bytes that is allocated is small
> enough.

Bart,

I'm not arguing, just pointing that the commit message doesn't reflect
actual change.

Thanks

>
> Bart.
>
>
>
>

--yuedfix5hmtMJRO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRNZuAAoJEORje4g2clinw5cP/0FbpRGJuK+4GFge8yXm1YAj
gkEFjH+lntodg9luLb8ChrZXEOFJxHhfEHUS1yVk3xTjYrlrVi0er0G9o6mwEPel
l+ndKGmaP7Uy2tfa0PKy54cSUpYTvBSlPrgJk+EoPqvSGLPpvjduZUOGJEaBChcr
iWcYIxFgrf/TMOfDT+weJ/J5xtolIXfOhJ1GZAhJsj1kAJ0wu+14CNddiKCgy6pT
dQoqX1AGdq0mt5YMExVIBiFk8wqeIs9F8fplHOatnCrF1SdsG/e3eSYJm7B4vihl
we/BmTYe4xnsR5rhovghmwE00pT/mxUc4WYu+re+zh3Z90YIWjp/q1BV2heagBin
9rL2Z84cZAGVDlfE01Z2hRhQ9aKhOioZD22Dv/TzZNSDDWkkFuIugTf5cudb9lK3
/p/B6FNMKnhzIvqZdFh2jmM8CMfafLumEsv+Xk9INcB1EpoWioQNldELqxrGG3nM
ttToQAuJQheOoxJnzBp5RGUoILvVYKXBPN8BRy80+oNLDSscCz2JORUeTynggeMb
yjYkUAyfcLgshgJlOfrB6DqVOdlZvjVVkLh/3TibOqmFipb0kulNARKrVmCzsNmf
jkKXqKJdX1itNNr7RIZocBjbOwpYYLg4iz4CDQIo2EoItHYMnyAvpUxTJTR0w6k9
5noxFnCbhWbtdsKPT6ny
=5ixS
-----END PGP SIGNATURE-----

--yuedfix5hmtMJRO4--
