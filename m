Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeDTU0V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:26:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34287 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeDTU0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:26:19 -0400
X-Google-Smtp-Source: AIpwx4/4feNLAvhNgpB8SgEOkHH2ZIZjOWkhl/2CfgC0TdLDAKk94x41Ws2RVNvsjycxHix/tSrfKg==
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <6C3CB775-988A-4543-9A92-3DB67BA3D92A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FF36D015-D8B0-4A0C-AA5F-2BB54F47DC8B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY
 conversion
Date: Fri, 20 Apr 2018 14:26:13 -0600
In-Reply-To: <CA+55aFyez2t_JUBhb3R0VFN7s_Gn+LwOS16gTSmSFb_M90v98A@mail.gmail.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <152422770230.23067.14348897715991489250.stgit@warthog.procyon.org.uk>
 <CA+55aFyez2t_JUBhb3R0VFN7s_Gn+LwOS16gTSmSFb_M90v98A@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_FF36D015-D8B0-4A0C-AA5F-2BB54F47DC8B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 20, 2018, at 11:03 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Fri, Apr 20, 2018 at 5:35 AM, David Howells <dhowells@redhat.com> =
wrote:
>> In do_mount() when the MS_* flags are being converted to MNT_* flags,
>> MS_RDONLY got accidentally convered to SB_RDONLY.
>=20
> Applied.
>=20
> I guess they have the same value (1). How did you notice? Do you have
> some patches that turn the kernel flags into a bitwise type? Or did
> you just happen on it manually?

Making s_flags and mnt_flags differently-named enums would help make
this problem more obvious (and some compilers might complain if used
incorrectly).  That also makes it more clear what kind of flags are
being passed to do_mount(), rather than "unsigned long flags".

Even while looking at the code for this, I see that s_flags is being
used incorrectly with MS_* flags all over the place:

static inline bool sb_rdonly(const struct super_block *sb) {
	return sb->s_flags & MS_RDONLY;
}

void inode_add_lru(struct inode *inode)
{
        if (!(inode->i_state & (I_DIRTY_ALL | I_SYNC |
                                I_FREEING | I_WILL_FREE)) &&
            !atomic_read(&inode->i_count) && inode->i_sb->s_flags & =
MS_ACTIVE)
                inode_lru_list_add(inode);
}

A quick grep showed 243 lines matching "->s_flags.*MS_".

Cheers, Andreas






--Apple-Mail=_FF36D015-D8B0-4A0C-AA5F-2BB54F47DC8B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlraTOUACgkQcqXauRfM
H+D/tw/+PoAZ7hVBSuX6j2tcDSYkSr/4uvW4/VJGmm4QfJ0Kgby/jfTaDLr6mSgl
aZIZ5L4VUIM4b5YyZeuvxd7F+rCayxniHX4R4212reTlxtnKcwH5ryK1RggfYKDF
2uhAnjPLV7VzQiplu8TfBgHTsk5yjldxaNqic9zkV/8HedgPUJk7+gMAENGg/z/q
y9VBqAoQMlIj5r08e8oK7royW/C+10MXzUskdn8ZVVIv+UVWWVNYivDm4tmLTJRE
GELk2qCetTIQPrYQRIyr6zJ9GMyPZCk80Rc81TjdZLEjyDOfyWEVs0WmOe5iSgcj
SP/rnSItOH0jdAJyd/vVRooP2TrA7LdxOCo2gQMvhRmWKfCfi56YrN471x6yFowa
hT+d7NXNHK6KbT1o/pR3m4tJKh2OuBHhB2pCxjsGKN4vNBHQZDkCStw3flYdOrgV
GIzw35G8MjnGJzwDUSJs86AWlowCKf4MH79/pDhIMFhQkmSDV16HNtNUnIBJBWHu
d/Eg9/ghtrVXGdL3lourOqWLi1AmBJOuQD5dIBRK+2UqOkJlhEmvhfg8tYyiGF0/
uBErv1kz7kYhHMblWfLNQjX1wfFgbrow/BUMOcFdz6AnPpTjlMSWgwciVXhYrJNI
ww4SGcpfEo/Q1aa+bVywCKNYWbIbH3ORe8RjORloTiYVb7S/wvU=
=rNX3
-----END PGP SIGNATURE-----

--Apple-Mail=_FF36D015-D8B0-4A0C-AA5F-2BB54F47DC8B--
