Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95890C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59859218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D2DYzels"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfABEBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 23:01:44 -0500
Received: from ozlabs.org ([203.11.71.1]:58915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfABEBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 23:01:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Ty6F2GHcz9s7T;
        Wed,  2 Jan 2019 15:01:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546401701;
        bh=G9BrBrOnoGZ9fE8cQuRTQvXmSugLXiHS+9vGwyLOhNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=D2DYzelsAev2mzwMszoVVpVkafh1xJ5jx800eGjhq0bNuDqfSI3BeVykCeKrBLnap
         ZsVN2TWBk6BzAKA11d6GPluimWbY0y7HMjLwIMMTXhuygduntygOSz7RE74J/7JxjB
         HVzSrosvDDnYZYlll2dbY9Tq7Nuanvt1SiC03vBkMk0n3m8TatvD7FSu8FUqXQqszb
         Y/J0tNoGJr7pFoCX2tvNvHBnB+DPRCeZ1SC9u+FA/p/NZlXXtaT1gsMTwa5psGpm0f
         fvTLAIIaLMOHBYcDKTGYz4HGx/Rb8/5/Jdm9sb9ffossMUV7M2C4bDG2ueiLUvm9kz
         l4dlX+fmoUNWw==
Date:   Wed, 2 Jan 2019 15:01:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20190102150140.704c4533@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8j9bjcOUK=mLTmizsGGHgnM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8j9bjcOUK=mLTmizsGGHgnM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

fs/fs_context.c: In function 'logfc':
fs/fs_context.c:400:3: error: implicit declaration of function 'vprintk_emi=
t'; did you mean 'dev_printk_emit'? [-Werror=3Dimplicit-function-declaratio=
n]
   vprintk_emit(0, LOGLEVEL_WARNING, NULL, 0, fmt, va);
   ^~~~~~~~~~~~
   dev_printk_emit

Caused by commit

  e6d72ffc503f ("vfs: Implement logging through fs_context")

# CONFIG_PRINTK is not set

I added the following hack for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 2 Jan 2019 14:57:36 +1100
Subject: [PATCH] vfs: work around CONFIG_PRINTK=3Dn in fs_context logging c=
ode

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/fs_context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 8728d49c7871..b0324598f573 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -391,6 +391,7 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
  */
 void logfc(struct fs_context *fc, const char *fmt, ...)
 {
+#ifdef CONFIG_PRINTK
 	va_list va;
=20
 	va_start(va, fmt);
@@ -409,6 +410,7 @@ void logfc(struct fs_context *fc, const char *fmt, ...)
=20
 	pr_cont("\n");
 	va_end(va);
+#endif
 }
 EXPORT_SYMBOL(logfc);
=20
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/8j9bjcOUK=mLTmizsGGHgnM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsN6QACgkQAVBC80lX
0GxCOAf+NcYWsZYMSnzubZq+Zgtrm5R1QlmhKgC2krRKzMqaBNbjgI71MQk4p80Q
6911oaW0wnjnRV7a3h76GGYc2l3IJdJxNK4nC3WW0zD6zcUCbyg/K4MxvphdNc58
QF0PQ1MJLi3SWFjXnqt6SLPunW6GwDMzrs/LMJU0BUUW14TLPSyz4qwTRqdT0Vq9
Vbi9qRiQF3VRaRCf6Bjoc1bDb5qyg+mdCU8Ibbr4+mu3pmQrHfyHDDTp0q4yqa7D
Pxd606xuX8EfOjbesfcfx7iR15XYlQ4e/rhsnw36F+kviVW1nIYP6CWhmCYodApm
FmaxQ+5mPDqlIjT/+sE8olxiH8tNnA==
=mJu7
-----END PGP SIGNATURE-----

--Sig_/8j9bjcOUK=mLTmizsGGHgnM--
