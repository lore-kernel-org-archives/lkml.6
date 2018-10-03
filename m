Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13665C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B840A2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PJBLAxrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B840A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJCG6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:58:09 -0400
Received: from ozlabs.org ([203.11.71.1]:52547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeJCG6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:58:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PxKQ3Hssz9s55;
        Wed,  3 Oct 2018 10:12:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538525530;
        bh=toMn6nnsKlAl9zMvZvO0fHcIeKee8Y9yZUVM4jBIMHQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PJBLAxrQhOhCshhTQoxjpcTps5iUtmaQKvtC0cFa2Q5Y3CV82HNNPXDsL4XGDS8Mq
         cTWfyI9m1+zVY6jBr/wDLGRg/rp/rghyNzW7E6iClyd5tmfYMkELsIKq4wPqBPtaew
         r7rA3lJ6MBeolT0JsTN8r9UJP1HXBysaoauT74EPVMT5YYR40emuFjLiineDorVSm7
         dqlN7TB9Ait4XrhOwMgMTYV6psi8aZYVeAsw2Pz37mmV2G/tlcaV1MmE/FPGA/eHiU
         eyvdUBxEXCEhYmwrZ6UWBhUpev9NOaCFmKfZdhgzdEYBWR3pb/yl/+TnrGXUM9xl/k
         9Iq8MDDz7m7dA==
Date:   Wed, 3 Oct 2018 10:12:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20181003101207.2553ca7c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ST5DDRH7T+QUIB5ojyL6Ihm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ST5DDRH7T+QUIB5ojyL6Ihm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/f2fs/super.c

between commit:

  f80f781514ef ("f2fs: checkpoint disabling")

from the f2fs tree and commit:

  307c6e5241b4 ("vfs: Require specification of size of mount data for inter=
nal mounts")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/super.c
index 952a67b3184a,89970dd81b0e..000000000000
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@@ -1449,53 -1419,8 +1449,54 @@@ static void default_options(struct f2fs
  #ifdef CONFIG_QUOTA
  static int f2fs_enable_quotas(struct super_block *sb);
  #endif
 +
 +static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 +{
 +	struct cp_control cpc;
 +	int err;
 +
 +	sbi->sb->s_flags |=3D SB_ACTIVE;
 +
 +	mutex_lock(&sbi->gc_mutex);
 +	for (; dirty_segments(sbi) > 2 * NR_CURSEG_TYPE;) {
 +		err =3D f2fs_gc(sbi, true, false, NULL_SEGNO);
 +		if (err =3D=3D -ENODATA)
 +			break;
 +		if (err && err !=3D -EAGAIN) {
 +			mutex_unlock(&sbi->gc_mutex);
 +			return err;
 +		}
 +	}
 +	mutex_unlock(&sbi->gc_mutex);
 +
 +	err =3D sync_filesystem(sbi->sb);
 +	if (err)
 +		return err;
 +
 +	mutex_lock(&sbi->gc_mutex);
 +	cpc.reason =3D CP_PAUSE;
 +	set_sbi_flag(sbi, SBI_CP_DISABLED);
 +	f2fs_write_checkpoint(sbi, &cpc);
 +
 +	sbi->unusable_block_count =3D 0;
 +	mutex_unlock(&sbi->gc_mutex);
 +	return 0;
 +}
 +
 +static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 +{
 +	mutex_lock(&sbi->gc_mutex);
 +	f2fs_dirty_to_prefree(sbi);
 +
 +	clear_sbi_flag(sbi, SBI_CP_DISABLED);
 +	set_sbi_flag(sbi, SBI_IS_DIRTY);
 +	mutex_unlock(&sbi->gc_mutex);
 +
 +	f2fs_sync_fs(sbi->sb, 1);
 +}
 +
- static int f2fs_remount(struct super_block *sb, int *flags, char *data)
+ static int f2fs_remount(struct super_block *sb, int *flags,
+ 			char *data, size_t data_size)
  {
  	struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
  	struct f2fs_mount_info org_mount_opt;

--Sig_/ST5DDRH7T+QUIB5ojyL6Ihm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu0CVcACgkQAVBC80lX
0GxmdAgAkYuaezPMu/Nttte9vH5MqBuJLbJQIEq+jHka9gUQoaLbyvvHK6ALklB5
jOxvoHELYKgrZt6EBzdemYedSYpOPXmIphi0dn+FXm8U/3TmTEGPgqX3X3kEnWR7
F15cqtBTVH8zTNdWI/w563/+aepJsMbrQTiqGURQK3rH8OMm9ZRIdhHfBGq+BiaM
UGj6n2Zkj4JFiJJj/H6fXGYXwv/OgRfWg05F5gtOtRW2wPOxnDK83to0FEg9MCCD
PlN529/5OAjBMAF/PM01fRntvlo1OS9keyVjkJ5sl2Y88n3vbFTvVEPwaqOvmzNz
qeIRK+HdJZx7UKGgtNiH3xYU2/626Q==
=G058
-----END PGP SIGNATURE-----

--Sig_/ST5DDRH7T+QUIB5ojyL6Ihm--
