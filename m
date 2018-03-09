Return-Path: <kernel-hardening-return-12342-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv5YB7+i0JP0sVo/3WyssTIA3sDBP6kixwQooR7ZLEjwbS3xLILKSTFQR5XKtikewXmkbLR
ARC-Seal: i=1; a=rsa-sha256; t=1520634606; cv=none;
        d=google.com; s=arc-20160816;
        b=bY3XpBLAmwGlBTCulxSoh9ZwgF050N/rwGcT5Fmh2P6quMwuMNjqiapzpEmz+zXSN1
         eSq5lOj2dWsj4x1FUG27GcTiY2azsJVHHsLBEn6qevEJ+lVkum+TtFaVHnWyFt1IAQHx
         HSTeEaSfKydv9IQodlR7u4xIzIYa70dB0OrI6765qRYkpDvRkiaXLv9liSnUD8sH0cR0
         fh0+wp9cKjY1Fs6XNpfxqhaQ1ukctQDF/g/IYvzG185AVdYSjTH2QzxOiLBUI4lSq/oX
         Erf2QwMkwKMrB3zGjbkOUK2KSlXaQVETCq0X4g5d4gzhxHWe3kP1G6Plc/OHXSoMsNBQ
         QbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:subject:cc:to:from:date:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=x13OgXZXXu0fqwqfSM+nGKmYXVStmO6fEbDqXIuRDlA=;
        b=HphxPYXpxxUathqBAH9+5izA3pljjZLMeG2o5mhbDvlt/qprqG7fFi7xexPQYZQ9cC
         ZkfE5Lm41kE//T9TxzI6I/KsxCDWURgL8QSSRXNty7+GFh3v62zo2XakxqqR+kZMjcNh
         A8xDYB13m/APhbDn08Mlh5mSc/ZoEYGUnfTsPoThuHBkEAhq3jmQf8ZZhEGT7qe++AKO
         Fzqqudj1en7dzFATabd1/ZZw/TM4oVe93kTIhiwYcX4u96HOz7w9+u88+0iRktJCLpR/
         eeAQWTqF+8ZaJP3B2C8JdqZBN5zbwMzOSComiwPy2wnYM3787BNqTP6EVGfiMy3SmyYg
         Q74Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12342-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12342-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12342-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12342-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 23:29:33 +0100
From: Stephen Kitt <steve@sk2.org>
To: Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: VLA removal, device_handler and COMMAND_SIZE
Message-ID: <20180309232933.14e39858@heffalump.sk2.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ND1RoT20ph5rx/6uVsD0LuU"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 782500436982517069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeeigdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594500952779467026?=
X-GMAIL-MSGID: =?utf-8?q?1594500952779467026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/ND1RoT20ph5rx/6uVsD0LuU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99ve been looking into removing some VLAs from device_handler drive=
rs,
prompted by https://lkml.org/lkml/2018/3/7/621

The uses in question here are quite straightforward, e.g. in
drivers/scsi/device_handler/scsi_dh_alua.c:

	u8 cdb[COMMAND_SIZE(MAINTENANCE_IN)];

There=E2=80=99s no trivial way of keeping the compiler happy with -Wvla tho=
ugh here,
at least not while keeping the behaviour strictly identical. I=E2=80=99ve c=
ome up
with two approaches, and I=E2=80=99m curious whether they=E2=80=99re approp=
riate or if
there=E2=80=99s a better way...

The first approach is to use MAX_COMMAND_SIZE instead; this wastes a few
bytes on the stack here and there, and stays reasonably maintainable.

The second approach might be symptomatic of a twisted mind, and involves
replacing COMMAND_SIZE so that it can be calculated at compile time when the
opcode is known:

/*
 * SCSI command sizes are as follows, in bytes, for fixed size commands, per
 * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of an opcode
 * determine its group.
 * The size table is encoded into a 32-bit value by subtracting each value
 * from 16, resulting in a value of 1715488362
 * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6 << 4 + 10).
 * Command group 3 is reserved and should never be used.
 */
#define COMMAND_SIZE(opcode) \
       (16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) & 7)))))


This has the side-effect of making some of the call sites more complex, and
the macro itself isn=E2=80=99t the most maintainer-friendly. It does mean w=
e can drop
BLK_SCSI_REQUEST from drivers/target/Kconfig so it=E2=80=99s not all bad...

Both patches will follow in reply to this email, I=E2=80=99ll let more fami=
liar
developers judge which is appropriate (if any).

Regards,

Stephen

--Sig_/ND1RoT20ph5rx/6uVsD0LuU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqjCs0ACgkQgNMC9Yht
g5zk6A//RgjRyD4aFvyZl/eCAy/q6gNM2ocvJzRHBsHKaNPlTEx5vEkjAZYHntoV
tnRf/nmiNrq5OLzfH7IDig0/P6IAh9WZBQKyO5RSL/NDqSKny6+M5grxTN8+hLl6
D+ODmC8MOvQmtwIfu3zj/OGNCvZmEfqW//DAg/v6QgHKMQtwhxXRoh7BqOlMt/Qm
f+27uE5BdPoOrXwJ7AcMBy4xHm7RvSpuUMUkOTpIEe4DvnqCMQK3wDjpvSLqJcv5
m7toKh3D5neVqL6jLKykWb1+4L0EQUokd4i0LCcp69evzT21MqwAyvHpLyBSS+EN
AW9mX017A1OY/nraKEhbV84jlWh0LggMe9rzHoBqNLOEtJ7F3/7RBasnEIYQs3vj
s03GFz3qc82X0gX9MF1e6SgkvpRlSHEexvph2mMC2bGw9qRnoU2iwOhptM4LzB1t
D+YZ+XG8vOQ97TlT0BEIpuKsZCOJFcWW3rdl1kc4/s2F04daCdBWTVCYbPJZi767
uub1reBwy8U1LNr9ZhtS0LnghY+VGOzeeiZTMboIv0895ERgWbTR6M84xJcBoyOh
Kb7mxjH1dG2kqdp0RJLrFY32rXZuswvO1Fwl+GfDKXy0Dx5XUxfLU1BY8zcaBly9
BNtHLwOx/F9UkQqTp5CbQvBNQuvAjOi8k/IQkdckph9H/DKBsgE=
=b4fl
-----END PGP SIGNATURE-----

--Sig_/ND1RoT20ph5rx/6uVsD0LuU--
