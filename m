Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6ACC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA6521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ve8r8761"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBHLjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:39:06 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:60883 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHLjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:39:06 -0500
Date:   Fri, 08 Feb 2019 11:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1549625942;
        bh=JjoXvKj0SDgBypwHxqOVFPJiqMeHegnxkMtOE1FBKII=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=ve8r8761e1/ElaSEiq2B/SIrjy411j+Ab0OpQH9vm2yjV4k96hMlIr/KtcfdkFxuW
         DOBFk+2jhssFLF3SYau+J/iv0hId6aH2tx2SWWFwLLrxmchi8tSqUaMdpOmVWqj3Ob
         uelHPYwMOrhT4+4ORaY+6Dp1ayXHwsdD5bWxHYZw=
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   23pieces <23pieces@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: 23pieces <23pieces@protonmail.com>
Subject: dm-crypt patch in Linux 4.20.6 Commit e4efd3184d9a63a7923e5c62fa236254f03c6bf8
Message-ID: <1uWvFLIArHW8L5PlgMMbXz1fok_GsLiCTltivAZWDl9rHLjihpxmIzakchb_s1Ad_S267Ia3FqRj-fgsrm-ROZZuGVBOlHB1lplVZswHzNE=@protonmail.com>
Feedback-ID: V_fp5sXP6zmcmzAjyTaeDeoi8EMEqfsK4Gl9_nNGgrOywuXKQvaYAF3PdizcueHLZvXErUxIl9GSHz76UXEwcA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------0dec83aa20b249964812242116be7f78"; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------0dec83aa20b249964812242116be7f78
Content-Type: multipart/mixed;boundary=---------------------9a9dc2ae214b5e7c81a6e0559ac878ca

-----------------------9a9dc2ae214b5e7c81a6e0559ac878ca
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello everyone!

It seems since kernelversion 4.20.6 many people have problems mounting the=
ir encrypted rootfs while booting.

Trying to investigate i found this commit in 4.20.6:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dr=
ivers/md/dm-crypt.c?id=3De4efd3184d9a63a7923e5c62fa236254f03c6bf8

To clarify this issue also persists in 4.20.7 and isn't occuring in 4.20.5=
.

People having the problem often have something like the following config o=
n their rootfs (including myself):
cryptsetup -v --type luks --cipher aes-xts-plain64 --key-size 512 --hash s=
ha512 --iter-time 5000 --use-random --verify-passphrase luksFormat device

I was trying to investigate the code in the commit and playing around with=
 the dmsetup commands mentioned.

Now on a running system with kernel 4.20.6 i get:

dmsetup create test --table "0 8 crypt aes-cbc-essiv:sha3-256 9c1185a5c5e9=
fc54612808977ee8f5b9e 0 /dev/sdc 0"      Works

dmsetup create test --table "0 8 crypt aes-cbc-essiv:sha512 9c1185a5c5e9fc=
54612808977ee8f5b9e 0 /dev/sdc 0"
device-mapper: reload ioctl on test  failed: Invalid argument
Command failed.

dmsetup create test --table "0 8 crypt aes-xts-plain-64:sha3-256 9c1185a5c=
5e9fc54612808977ee8f5b9e 0 /dev/sdc 0"
device-mapper: reload ioctl on test  failed: Invalid argument
Command failed.

dmsetup create test --table "0 8 crypt aes-xts-plain-64:sha512 9c1185a5c5e=
9fc54612808977ee8f5b9e 0 /dev/sdc 0"
device-mapper: reload ioctl on test  failed: Invalid argument
Command failed.


At boot people have the following error:
device-mapper: reload ioctl on  failed: Invalid argument
Failed to setup dm-crypt key mapping for device /dev/disk/by-uuid/UUID
Check that kernel supports aes-xts-plain-64 cipher (check syslog for more =
info)

I don't have a patch for this yet, just wanted to inform you.

Best regards
23pieces




-----------------------9a9dc2ae214b5e7c81a6e0559ac878ca
Content-Type: application/pgp-keys; filename="publickey - 23pieces@protonmail.com - 0xC6F1867B.asc"; name="publickey - 23pieces@protonmail.com - 0xC6F1867B.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - 23pieces@protonmail.com - 0xC6F1867B.asc"; name="publickey - 23pieces@protonmail.com - 0xC6F1867B.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjQuNg0KQ29tbWVudDogaHR0cHM6Ly9vcGVucGdwanMub3JnDQoNCnhzQk5CRnJUUTMwQkNB
Q2hJN2M0OVB0UmhONUMzRkJSZnRCc1JnVGd3TFJWWFgwd3JGSDlEbFVtbE1KSA0KV282bjdaV01F
WElSTVE3dzRrc0ptS2JGZUJWQU5FNmYxNWZXWDRha1VLRG1QeTZOV3lRcTdUUmxXbGxSDQpsR2tK
SU1ualh0QUl4WEJXbUZQbU9KNE5ncTc5Nkp1anJaRU96VUJSREkyUjhLZU5HT2xyVmVQazZIWVgN
CjU3WHNtdEJ5UUZQeU5QZjBNbkdSeVhXTzYzaVd0N2lJY1RkS2hNRzdjSiswZlVCUmMwWjBiVTF4
K1JvYg0KTm5Id2xvQmpDNGZxSk03Ryt3RmpxUGVLR1hBUFQxT25CMVNwbGQ2WDJ6ZkNJdUgxQXBM
cHRHR2lwY0E2DQpNUnI3dkFmVU9oN2RtdkdsUjJlVGV0bjFPT01Mak4zZXg2Z0NCRVZic3EyMzdq
SW9rU3Z3ZGFyWkFCRUINCkFBSE5NVEl6Y0dsbFkyVnpRSEJ5YjNSdmJtMWhhV3d1WTI5dElEd3lN
M0JwWldObGMwQndjbTkwYjI1dA0KWVdsc0xtTnZiVDdDd0g4RUVBRUlBQ2tGQWxyVFEzNEdDd2tI
Q0FNQ0NSQ3JRWEh2VmwvdzZRUVZDQW9DDQpBeFlDQVFJWkFRSWJBd0llQVFBS0NSQ3JRWEh2Vmwv
dzZYelVCLzRuOXMxQ1RqbFpkWWplWVFEQU9yankNCkFOZnlKNzNOdHFuK05RRXBINXFDNTNGQkta
R2RFRVNVSjM2NWlUdDNsaUJpc0VxdjVXMVNITnBLZkZpTw0KbFV1QkxCOFpDeG1NaG9rb01ZWmww
WEF3UXNWd3JHc3AzTXE1OTZ6QnFmZnZHbE5TV0lkRVBpc2liKzlwDQpFTFJCb0wxVXF1TWtVYk1v
YnIzTHg5TVluTzY0Ukd4eVpTaUplOGJ4bUFLYXVxcVYwYjdtdXRKSFB3eC8NClVteVJISjlrZDRG
b3VJY2ZUa3ppOWxhWnNFVVB4ek1lMXhaYTlnZXRMT3N1djVHMVhDWDlOa1J6dHpTUQ0KTGlQSGds
QmcrSUI2U0xTWWVNMFhyTW0wTWtGV1d5OTRlUE1uV0hXUG9Yc1E3K1pGWlNyUmp1eW5VUnBuDQpV
TjlXUVp6RG9ycHZOQXFvMWtmOHpzQk5CRnJUUTMwQkNBQ1hmZE5OVHZ1TDZ2dHQ5dXlsRnljK0N2
cEYNCmFxNmVpYTFwbW1wSFFRVWlNN28vRitYajh2YVArUGZCUzBQNVBxWmY5eFgrNXQ3L3ovNUoy
NmlIU0ZHVQ0KQkkyOTVUSmpoRm9zSTlzVzFUS1Q5V2NNZkhSMkt2aGdjRld2VHhUNXlhWjg0M3JC
ZnJnay85WlQraFFEDQozNHhLK0NWMTAwbHZCdVhNZEIzYmNCV1NEd1FuaHZDR2UrZms4RjI3RVF3
dlJCMHNTUVZMZEdhVG44b1ENCm13RGZQT3d4WUJFUGYycG4vOTE2b01HdkZJOTVCTHVFNU5Sd2VX
d0RNMVFmS1R6NVBOcS9lTzBEMzlOUw0KdmFMenAyTVIzZGFmMitWeERvd01RRXBRb1FFSUVKN2lS
T25iOFVEL1ZiejBiUGEvTXZRRDlxZFZZeDFhDQpnNmpwNThWanNVZ1NvS3VIQUJFQkFBSEN3R2tF
R0FFSUFCTUZBbHJUUTM0SkVLdEJjZTlXWC9EcEFoc00NCkFBb0pFS3RCY2U5V1gvRHBOOVFILzJD
aWpsT3pqaElsSWRqRVd3bjVSSWJ5NWVwbEhXUjFZdmwrSG9GcA0KZ2VSR3luZ1BPQ2ZIYVprcWQy
OHNKcUZQcmdTLzFndVdpY3Z3UDVEUE4wUEl4aStmZ25MTWJJNUw2Ynl2DQpqN0cycFlVbWEyaFZJ
TzRtWlB0OG9pK3FDbEUwZE5mRDl0UzdWTSsyWjh2UkEyTGVpVkdud2NnRUkxWUoNClZMZTh4dDZZ
cndoV2krdC9IWGhFZCtEZEJSUDRkS2srS2g5ZTF2Zk13Tmt0QkRKYTBpd3R2R3d6QnZGLw0KMVVO
d1k1cEpBaWovUkFJK01OTXBYbGwyTHNQVStMSjFIRDh6MXJXVVgyamNqQUg3MFZERzBkMTRYaEVn
DQppblhxdHZMakh2alFNQitySzJnSVIzSHB1bjE2c1FaTzNVMFRpNjRYRFRqMEpjRHBENTE1OERM
clBESDINCmQ5Zz0NCj13YlNFDQotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQo=
-----------------------9a9dc2ae214b5e7c81a6e0559ac878ca--

-----------------------0dec83aa20b249964812242116be7f78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail
Comment: https://protonmail.com

wsBcBAEBCAAGBQJcXWpTAAoJEKtBce9WX/Dp4dkH/A4pCaERCjthLmtnEnx3
1zOUnRK0CAZofMwAJlcWEdPPSheXh7G/weyg+s7yqjx32jjVyNOVYnaREnX+
7070k0DcDB+NeFBiKyVONJxkIRWA4GZOWPBRWFGhlofT2DaebrZdC1orhKOP
FAvLFWpp+IvBalenDe0XT2128yhLPIQpzXdy6x8CdevEsfUs+/rVNXZ1/BZL
E9Y9c8EK0NhASOjUH3GMDCR9MKIkRt5B0wEv8bQ/+Ia+ULgebztqnyTxTkaK
OT26dk0cEGcFI3WZ/w4VaCvJukoWKWgthKIPPStSxTZp4/WrONUiyHXN+2QS
8R7DFxtLM/MRbnWsZfBNYok=
=gWc9
-----END PGP SIGNATURE-----


-----------------------0dec83aa20b249964812242116be7f78--

