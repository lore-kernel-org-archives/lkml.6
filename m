Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60461C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcg9+EhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9A92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeJ2Szs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbeJ2Szs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:55:48 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2112020827;
        Mon, 29 Oct 2018 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540807669;
        bh=7DX5UQuycbwywgywfDcjg/mkhVjlX+ErmeD9+JPzs/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jcg9+EhUP0LhkHBTd8wDCjpD0KdjrH/kK7BCy5DJCNXiYerJulMwRtXhed14XvLD+
         67i6tI4+CVwTUYUe6FYQpDBNn1v6KWqHxVpE5QzP4xf3C3q11DY4O8Cc/SBMhUv0Ap
         TiOXtTJ0rHeUe6dOqj5E/4Jsx3+j1Rc5wrFwMYCA=
Date:   Mon, 29 Oct 2018 12:07:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20181029100744.GP3974@mtr-leonro.mtl.com>
References: <20181018080258.GA1720@embeddedor.com>
 <20181018110155.GH5007@mtr-leonro.mtl.com>
 <4bf459e9feb559270983530d2e3720e78a167b05.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <4bf459e9feb559270983530d2e3720e78a167b05.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2018 at 08:17:10PM -0400, Doug Ledford wrote:
> On Thu, 2018-10-18 at 14:01 +0300, Leon Romanovsky wrote:
> > On Thu, Oct 18, 2018 at 10:02:58AM +0200, Gustavo A. R. Silva wrote:
> > > Cast *max_num_sg* to u64 in order to give the compiler complete
> > > information about the proper arithmetic to use.
> > >
> > > Notice that such variable is used in a context that expects an
> > > expression of type u64 (64 bits, unsigned) and the following
> > > expression is currently being evaluated using 32-bit
> > > arithmetic:
> >
> > And what is wrong with that?
> > Please fix static analyzer tool instead of fixing proper C code.
>
> Judging on the static analyzer tool's message, I don't see anything
> wrong with it.  The code contains a potential unintentional overflow
> error.  The author might have been well aware of the overflow and not
> cared and in that case this is valid C, but the analyzer has no way of
> knowing that, so it flags it for review.  To silence the checker you
> could either cast the arithmetic to u64, or cast length to u32.  Either
> would clear up the ambiguity.  I guess I'm not seeing why you would
> blame the static checker in this case, it did the best it is possible
> for it to do.

You are right, static analyzer tools have no way to understand that this
overflow isn't possible. I was over excited to go to my vacation hence my
response. Sorry about that.

Thanks

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb1tvwAAoJEORje4g2clinayQP/R70uw4wTtRmMPCkAZCm75H0
nyENuFu+rQxYOy+08ebBtp1b+jBfstb/fUR3/Qwy/bbORPNnomeD/aZM/fR4pRmc
ZEeRpMh666+9d4ZJ+VW2x71n0X+rQvE+tG55au75Bxl4fh/vKKWX0GjMlyo0lwBv
FpJ+5rn372QBiXo71wfVq3HtAU1Hu+wkqNY32pMQkko/YbsI+zyaX7YNo+214qD9
tNUEgk4uzZH0vTvnQZt0C+8KxSJBy1Qsatj+G1XfPIXfgXfSq/jqsV0klaSo4zpl
QaXo3l3738IvUrJbEOGEBRDGlnmsG6TmiNHMQlcupgwKGbi1pY2beVW1vTJ12s36
/88y8r9TjOFHikEM8Gv6in5Cw6v61iVSbqiTsMPRRgTy7C2iIxrIwSx6cqYzcQk8
aJguQqDlzEJW72JYSxo0/rDzD3aP+OMyXPvp5YiHbBK9UbNSZrx2bK9g1222y2Bd
UTtCkBuIIrQfJGT8Fk9ZyCdVk8bu8p9Gsvvm/U6mKdbtUR/jIJinyGdTUoyhNSUi
zeuQD+FzLdkgbL+NZWmN7JmzQuygjAQp3wXfn6l+D/DxQL+T7AcnzSI3Uly0S1sl
iodzUYEfYVHi22gIyGKo6fZ5wyByXD2VBrwF+aoWD4Fjpn6oLAqb7OQd4Up42ED5
jDbEgNcsCaVK66PfgwKg
=4bu2
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
