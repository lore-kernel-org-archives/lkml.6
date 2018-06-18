Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A6020836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d+YXy4Io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A6020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeFRDut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:50:49 -0400
Received: from ozlabs.org ([203.11.71.1]:59389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754588AbeFRDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:50:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418HDy2dtJz9s2t;
        Mon, 18 Jun 2018 13:50:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293845;
        bh=dI9CCdzrZvueGkVnXP6cvw7EBBS+0XpPo1pMQ3jmqwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d+YXy4IovQIxij0QEhUNR4d8hDDjBSpqVT55TVeY5j3yByOYf4V/0PMgL3WYz6oJg
         yLKJ+0mpfkbb92KyF6IQQjd/9Owsy/c7jnF7PmRtBHx3zu9AXoNEBsY1ChwpEp8FQ7
         o39ku0Aknm7zjmlj6PpnKa/9PYvA4YHqVaVipQghbo27u2I7B6WrPwBhlj5QVSXaCg
         IFVIOEaAu15YG2Rv0aDCzP+fu/aWMBdW3q4JiDT7negZQQLNHrkddnEwrQ++JRFntn
         DYL6cqEzb6qlDpdYgvIWIV8QAHK5eYBsjXiMSfGd1TYX293BR3Gh/c5rFb8m9FAjfd
         0Uh/i27kpLUoQ==
Date:   Mon, 18 Jun 2018 13:50:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure in Linus' tree
Message-ID: <20180618135041.5b661a2c@canb.auug.org.au>
In-Reply-To: <20180612122640.534118ed@canb.auug.org.au>
References: <20180612122640.534118ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lwvCwP46zO1EbN+lvHavvXu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lwvCwP46zO1EbN+lvHavvXu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Jun 2018 12:26:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Building Linus' tree, today's linux-next build (powerpc allyesconfig)
> failed like this:
>=20
> ld: net/bpfilter/bpfilter_umh.o: compiled for a little endian system and =
target is big endian
> ld: failed to merge target specific data of file net/bpfilter/bpfilter_um=
h.o
>=20
> This has come to light since I started using a native compiler (i.e. one
> that can build executables, not just the kernel) for my PowerPC builds
> on a powerpcle host.
>=20
> I have switched back to my limited compiler.

Any progress on this?
--=20
Cheers,
Stephen Rothwell

--Sig_/lwvCwP46zO1EbN+lvHavvXu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnLBEACgkQAVBC80lX
0Gxiigf/TavmN8fnRIYbvk8WFY9glYBpJkMjz/X3ZUJBrKAW7V46laetFyUZtkib
7W3oVrAWPwg0SUXY/q7kPhp/D3wXu2RVUlJh9LIsHBaf5kpNqlSb2rreDqIwoOWB
qn4lJkhE10AfmbBxbppaNOyNIwpbzWW9gZIxAGUe0pYZqtUBZnAIF5QSFNET6sml
fLdgNk/dXDCxuEUjdrnQxhoti0NTKuerjnfjRg//TdSHriRLmKHJBK9MezdnNuth
7qpT/IoTv/JD/EtYFYH8VZ1uxaYHRxAzCHGkKkOMhe18j2E+/u9XeNA09u0iRNfw
EuNiDaipfXBk+zKeDbiFZBPYf4lcVw==
=dP4B
-----END PGP SIGNATURE-----

--Sig_/lwvCwP46zO1EbN+lvHavvXu--
