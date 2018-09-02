Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE43620837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tQu73SFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE43620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbeICEEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 00:04:54 -0400
Received: from ozlabs.org ([203.11.71.1]:36053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeICEEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 00:04:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423VBc019rz9s2P;
        Mon,  3 Sep 2018 09:47:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535932040;
        bh=C1godOuQMF8DAsSBvbEMrA0GlCBdLzY0Zwo7BEXXB8k=;
        h=Date:From:To:Cc:Subject:From;
        b=tQu73SFzSvcUFYVlsnFTg/NSoz0eqnD+yL3HQdB/d+VQjj5yh/JW1YVECzfBoALTv
         ++tJ4wI5pbqklS2ccmduhOgOfcmQaCfxqjKiphajFWOb6IaVcxSWyHf7JU+4jcnX6M
         bBvs4T9N804YoN3m3rYk1KzkpGZXwJd0lVpzxsRNXOMI1C6OeXe/2RdEZTD4a/lCnC
         FhWO4PowXHi40NVKa70OS534SJX07kFRHSfhIJUcwLFIZ0bSR8Xor7GDACDJeU43yb
         PHtmcGV4qvatUnQWkw/u2PGFUIJkWDtUKm71jLB5l9bdqpX9PTY/I/UzNRi2iXPtE2
         BS+jguHFuJWPQ==
Date:   Mon, 3 Sep 2018 09:47:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20180903094702.3e32d8f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZNNK2TVTwXRyyUCbaVN90rD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZNNK2TVTwXRyyUCbaVN90rD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:
drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_sta=
t_strings':
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: functio=
n '__i40e_add_stat_strings' can never be inlined because it uses variable a=
rgument lists
 static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats=
 stats[],
                    ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool=
_stats.h")

It is not clear this patch has any value anyway as the moved functions
are only used in the file they were moved from.

I reverted that commit for today.

The same problem would exist in drivers/net/ethernet/intel/i40evf (where
a lot of code is duplicated from drivers/net/ethernet/intel/i40e) except
that this function is not declared inline there.
Luckily, i40e_ethtool_stats.h is only included my one file
drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c, otherwise there
would be multiple copies of __i40e_add_stat_strings().

Surely there is some scope for factoring out some common code between
these two drivers?
--=20
Cheers,
Stephen Rothwell

--Sig_/ZNNK2TVTwXRyyUCbaVN90rD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMdnYACgkQAVBC80lX
0Gwb4Qf+MOMSL1ycz0LwsoSipwGk2jGgeSx71ZWrO2jhOxYqHLUR/naoHD+NSvDN
Gxyyf2RTHXp2liEFCBPjw4s5QTrrwvtbxjvy9Q/70/39XoCsnQ1/c/4VmRU+PcRN
iMXEcr2FqZbdi+m1aD562Z5UPfnnYrxzWD1QHidugrG7NnRqh5o4mKcbT8A858od
0yPRUMp1Y+/bhTd+LZOqqb1HjLaf6AXdXqw1F/C2zdiInHdaGjqEjY9GV/vFjbUb
nSWAuPqyA7HaZ/vgkQgW0HxDAdU2TRnJvXHsAyyij1STYJ6eK/Md5Rcu8HI1NI4C
wR1ps8IxXcKLGpbUGB8Nv/UR2r/TYw==
=sU4X
-----END PGP SIGNATURE-----

--Sig_/ZNNK2TVTwXRyyUCbaVN90rD--
