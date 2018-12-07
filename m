Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75053C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1232083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="O8wF+iWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1232083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLGQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:10:23 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:63540 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:10:23 -0500
Received: from [192.168.111.102] (p4FD9776D.dip0.t-ipconnect.de [79.217.119.109])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id wB7GAFZO018092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Dec 2018 17:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1544199016;
        bh=7+hHY0x6+fkrYS75OrTZKvvu1QR3SDPE0jE7ku97I4E=;
        h=To:Cc:From:Subject:Date;
        b=O8wF+iWx0u1QnQXvFlP79SIiDWDnE0lH76w49NtGE6yhKV/Xog9wtlMY/5cRRQWk/
         nVeQr7KQAImG1uGXRul24YM/UjRUYLDsSdrviVqSjg/XlpDM++KRNw1I9laSQYFZiA
         yu/xwzQq1HgIKDNAyR3fP0hf9GcTRPzctiXa8fCU=
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 spNrcZJf1pbo3EKkCwUPAltq51ramtYzOu4K
Message-ID: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
Date:   Fri, 7 Dec 2018 17:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="deY1qw98uTk0HPj0q493xUIRGf6rhRGPb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--deY1qw98uTk0HPj0q493xUIRGf6rhRGPb
Content-Type: multipart/mixed; boundary="1PGYM7kVnzcPL8PJynbOvpHmdP5m1oFWw";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Message-ID: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
Subject: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags

--1PGYM7kVnzcPL8PJynbOvpHmdP5m1oFWw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable


inode.i_flags might be altered without proper
synchronisation when the inode belongs to devtmpfs.
blkdev_write_iter() starts writing via __generic_file_write_iter()
which sets S_NOSEC bit without any synchronisation.
The following stacktrace shows how to get there:
13: entry_SYSENTER_32:460
12: do_fast_syscall_32:410
11: _static_cpu_has:146
10: do_syscall_32_irqs_on:322
09: SyS_pwrite64:636
08: SYSC_pwrite64:650
07: fdput:38
06: vfs_write:560
05: __vfs_write:512
04: new_sync_write:500
03: blkdev_write_iter:1977
02: __generic_file_write_iter:2897
01: file_remove_privs:1818
00: inode_has_no_xattr:3163
If S_NOSEC is *not* set, i_rwsem is acquired around
__generic_file_write_iter().

Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
Spinczyk)

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 fs/block_dev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a80b4f0ee7c4..b4ece62e3c05 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1894,8 +1894,10 @@ ssize_t blkdev_write_iter(struct kiocb *iocb,
struct iov_iter *from)
 {
 	struct file *file =3D iocb->ki_filp;
 	struct inode *bd_inode =3D bdev_file_inode(file);
+	struct inode *inode =3D file_inode(file);
 	loff_t size =3D i_size_read(bd_inode);
 	struct blk_plug plug;
+	int locked =3D 0;
 	ssize_t ret;

 	if (bdev_read_only(I_BDEV(bd_inode)))
@@ -1913,9 +1915,19 @@ ssize_t blkdev_write_iter(struct kiocb *iocb,
struct iov_iter *from)
 	iov_iter_truncate(from, size - iocb->ki_pos);

 	blk_start_plug(&plug);
+	/*
+	 * Ensure excl. access to i_flags in __generic_file_write_iter().
+	 * Otherwise, it would race with chmod adding SUID bit.
+	 */
+	if (!IS_NOSEC(inode)) {
+		inode_lock(inode);
+		locked =3D 1;
+	}
 	ret =3D __generic_file_write_iter(iocb, from);
 	if (ret > 0)
 		ret =3D generic_write_sync(iocb, ret);
+	if (locked)
+		inode_unlock(inode);
 	blk_finish_plug(&plug);
 	return ret;
 }
--=20
2.19.2


--1PGYM7kVnzcPL8PJynbOvpHmdP5m1oFWw--

--deY1qw98uTk0HPj0q493xUIRGf6rhRGPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAlwKm2cACgkQWT7tBbw+
9v0SiA/9FxB3DC3GIU6DHouZyn2cMdX0Z/IzUR6Ns9fD3T0lPECLLVbOdghboxzs
2Sdm7OQJQPNguJKc3rFwn3377m0fVui0KXxzdVxj1FyJF5KPWbwZCpAIFpepsWqu
tl0+0bdLYYkxDB5yUNczxrY2BeMRawhvWc7A9dAQWyV+zdd96VDYRBWWwj4kCJ46
gjIsvEdsGkTtuWlYlEVyz787wXIk7iV1x/Ws8d3ZAxtQsowTW8ZOe0Yw+IQTQ8eX
NegMpiNHJrpQ7a4zOqRo6R+1ZohtHLb4nCPhqzudw+OvLezi5lIKcKVtewWFVeHE
5HZ7kGwbqbDbFk0wUaC3tNA/DSX1EaZYLqoIOTQphUJZue6Akbn2qxtJtAOaE/td
+9tQWMGoMCs6dYiuod3lcauKU/57bZHHnb8ftHBoSkyvR7KesOGQC5SJgvid3Oyn
r6BElNU5Hf/LVqE4DzhWx7YuM2SC+r4nhxiLFQT4KAZ5b7FCKGcaEN5p/gCl7GNR
bA/SBWA6z/kD4VY9rXy4z2Xa8QZsezctg7EUq5Calx2T13cee3ahh+UrkrtPcndV
jijOhWZfoC8OdGjz82HkgC7inNmgtZpJpqNRUt+nP/L13qvdXEIDwpVpHD3ESM9w
+ndZwUj4D3K8zbNvmyJ0NUWB5VAO4hJTSkL5t98mSqG9S9FcS04=
=VnTL
-----END PGP SIGNATURE-----

--deY1qw98uTk0HPj0q493xUIRGf6rhRGPb--
