Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4FC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741F120850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uNs1GFht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741F120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLDBJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:09:40 -0500
Received: from ozlabs.org ([203.11.71.1]:59299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeLDBJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:09:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4383g45hWPz9sBQ;
        Tue,  4 Dec 2018 12:09:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543885776;
        bh=I/fKLKxZfPgyMTaIYEmCyu1l7MJV+Q1RzqisnC3lsA4=;
        h=Date:From:To:Cc:Subject:From;
        b=uNs1GFhtgOD5qzXqpBY5OHTMIi5LVx7RzXzQrqY8ZfKAsi5X3woIfh5ReAPk7WJOk
         VScxxtRNpwQ+xCse1S46WGHeocNMLvgtEEvsxKzKJMDidxTqZz8SKr4bmZ0pyn5ZP3
         uFKK/icZprGxdXsktkmOuVZB3Ds9WM5l/xJkPBBVUt3WtWqPLsDUUtUNwlKowpT3Z9
         M0kJa4gB+gQQPGgwVjujM8Bw0JXDSYRR6dtbrxHivd0iPThpqX0MeWolP+UQoVE4fD
         osH9b7n5ukyVMyZB4ZU0lYc3SIdPGkqv5Vh6vW8iNbQGLkl37u1oa5IHhhebuofjpm
         KVSJwqREuVOTQ==
Date:   Tue, 4 Dec 2018 12:09:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Vlad Dumitrescu <vladum@google.com>,
        Willem de Bruijn <willemb@google.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20181204120936.77cd82a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YsoqOWuYK7+7TM6wmY5NxYd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YsoqOWuYK7+7TM6wmY5NxYd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  net/core/filter.c

between commit:

  b7df9ada9a77 ("bpf: fix pointer offsets in context for 32 bit")

from the bpf tree and commit:

  e3da08d05700 ("bpf: allow BPF read access to qdisc pkt_len")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/core/filter.c
index 8659b40172d1,3d54af4c363d..000000000000
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@@ -5771,9 -5770,10 +5771,10 @@@ static bool sk_filter_is_valid_access(i
  	case bpf_ctx_range(struct __sk_buff, data):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
  	case bpf_ctx_range(struct __sk_buff, data_end):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
  	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
  	case bpf_ctx_range(struct __sk_buff, tstamp):
+ 	case bpf_ctx_range(struct __sk_buff, wire_len):
  		return false;
  	}
 =20
@@@ -5797,7 -5797,8 +5798,8 @@@ static bool cg_skb_is_valid_access(int=20
  	switch (off) {
  	case bpf_ctx_range(struct __sk_buff, tc_classid):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
+ 	case bpf_ctx_range(struct __sk_buff, wire_len):
  		return false;
  	case bpf_ctx_range(struct __sk_buff, data):
  	case bpf_ctx_range(struct __sk_buff, data_end):
@@@ -5842,8 -5843,9 +5844,9 @@@ static bool lwt_is_valid_access(int off
  	case bpf_ctx_range(struct __sk_buff, tc_classid):
  	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
  	case bpf_ctx_range(struct __sk_buff, tstamp):
+ 	case bpf_ctx_range(struct __sk_buff, wire_len):
  		return false;
  	}
 =20
@@@ -6272,8 -6274,9 +6275,9 @@@ static bool sk_skb_is_valid_access(int=20
  	switch (off) {
  	case bpf_ctx_range(struct __sk_buff, tc_classid):
  	case bpf_ctx_range(struct __sk_buff, data_meta):
 -	case bpf_ctx_range(struct __sk_buff, flow_keys):
 +	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
  	case bpf_ctx_range(struct __sk_buff, tstamp):
+ 	case bpf_ctx_range(struct __sk_buff, wire_len):
  		return false;
  	}
 =20

--Sig_/YsoqOWuYK7+7TM6wmY5NxYd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwF09AACgkQAVBC80lX
0Gw7VAf/TZBXWKB28iHf01HrmCgOku/46/yDzrzXHdYPIYdpkmYWVZ+DZcCXJ/Pv
qsZ2/vF0AZf6KTLDHR2ok/f8XP8x2VYXnNdo1dYrBA+rXFi9D8p9QffpgixHOG5j
S2p7c8elUVs0R5auolNLfemJfe6tNM0oX3ReUtFE8hDoGHESCaAjmgEGEiKjzGnb
scqRcyRew0e07PPIR/JvitvDn5AkgpOoUYGEG82tbRTq6yOG9N7YvQnvUIU/vuBi
2EuVZeBDB0UyaaCoqNx6VWQy1E1XFLEWcuobt+8hzb6mrqbO1k1fj+AFkeMf8Hmv
uZ97OPvVO2JS/oyd9KTjZAfGWMPnbw==
=QIj7
-----END PGP SIGNATURE-----

--Sig_/YsoqOWuYK7+7TM6wmY5NxYd--
