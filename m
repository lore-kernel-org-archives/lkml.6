Return-Path: <adilger@dilger.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1523640936; cv=none;
        d=google.com; s=arc-20160816;
        b=IksiiUEVEgsoia526CbqDw74iAEaRKnzaTq2njA9tIAVAP2HpecinqgQvGKm4LsMf2
         PMziuogSHYRoJ7agha5xLVbVV3J6XCsUZfG//GNvZBKJnwWp8o0BeG1kiTCOdEBoTGvo
         kRV8tCwqmogR1LSS0LOkcAtzhTh64wCSoAzSvC2bXjBqWJ8G8xsCBm7xK9iDsdSiMSrt
         IYg8tcdjdI3B/2RMea0tLII8970YnUMGVA2SS5fIfIMctAcb+reEP2eMCw8sOfsrRYX9
         TrOnYwdLLGa2hgI7kjAoA9a3Tbn2cLQKOBQnO9X3fLox1yu5n/B62krGmuOqFKsdyd34
         VTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=A22juUA9iDP3ZDLxQH5cux0EJsl08n7FRblQ2YnCb7Y=;
        b=FnFE/x7sQ02HoNiIssuZqKaFM4zbpRrXXcnse3zuleh3xp2UJuhK7wJRqJbLkMjSmj
         0mBhAMoBaWZcv1Q1FV4VW9JQZp7gZJowyfDDEB1UGveXjDLQ/gV6jO3oOyADYZYBa4hY
         33lwuDiwrL+tEVrF/NoYvWIGGvlrLd/W+GaYWJCbbbxlt0wDQptiD/u0br86B377As2v
         8qSjvuLJ/NgXfqm5m3gC22n4LyaRasafCUPqyZXxYcRZCU9EX6WTSC7JPsGYLMTHJN2d
         WEwPfcDICCeVde2b+JBe7GZUY0RDNcS6sRizKKR7GeB9PChhcKDeOc0pEIkB2tJYVVa2
         PQtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@dilger-ca.20150623.gappssmtp.com header.s=20150623 header.b=T02tRN2s;
       spf=pass (google.com: domain of adilger@dilger.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=adilger@dilger.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@dilger-ca.20150623.gappssmtp.com header.s=20150623 header.b=T02tRN2s;
       spf=pass (google.com: domain of adilger@dilger.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=adilger@dilger.ca
X-Google-Smtp-Source: AIpwx49MtpSa3GaY4vSMKhEL03NGHY3kVRzcImslzVgJscRKfiW7/c7qidkvFkagdNZdvhLv/yROQA==
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <833FF27F-CFAD-4011-A21C-86B3947BB7D5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D7F47ADB-50BF-47CD-AAC9-EA4086E41970";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] statfs: use << to align with fs header
Date: Fri, 13 Apr 2018 11:35:11 -0600
In-Reply-To: <20180413161126.31313-3-christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 serge@hallyn.com
To: Christian Brauner <christian.brauner@ubuntu.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-3-christian.brauner@ubuntu.com>
X-Mailer: Apple Mail (2.3273)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648046265390168?=
X-GMAIL-MSGID: =?utf-8?q?1597653318132242392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_D7F47ADB-50BF-47CD-AAC9-EA4086E41970
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 13, 2018, at 10:11 AM, Christian Brauner =
<christian.brauner@ubuntu.com> wrote:
>=20
> Consistenly use << to define ST_* constants. This also aligns them =
with
> their MS_* counterparts in fs.h

IMHO, using (1 << 10) makes the code harder to debug.  If you see a =
field
in a structure like 0x8354, it is non-trivial to map this to the ST_*
flags if they are declared in the form (1 << 10) or BIT(10).  If they =
are
declared in the form 0x100 (as they are now) then it is trivial that the
ST_APPEND flag is set in 0x8354, and easy to understand the other flags.

So, my preference would be to NOT land this or the previous patch.

Cheers, Andreas

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> include/linux/statfs.h | 26 +++++++++++++-------------
> 1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index 3142e98546ac..b336c04e793c 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -27,18 +27,18 @@ struct kstatfs {
>  * ABI.  The exception is ST_VALID which has the same value as =
MS_REMOUNT
>  * which doesn't make any sense for statfs.
>  */
> -#define ST_RDONLY	0x0001	/* mount read-only */
> -#define ST_NOSUID	0x0002	/* ignore suid and sgid bits */
> -#define ST_NODEV	0x0004	/* disallow access to device special =
files */
> -#define ST_NOEXEC	0x0008	/* disallow program execution */
> -#define ST_SYNCHRONOUS	0x0010	/* writes are synced at once */
> -#define ST_VALID	0x0020	/* f_flags support is implemented */
> -#define ST_MANDLOCK	0x0040	/* allow mandatory locks on an FS */
> -/* 0x0080 used for ST_WRITE in glibc */
> -/* 0x0100 used for ST_APPEND in glibc */
> -/* 0x0200 used for ST_IMMUTABLE in glibc */
> -#define ST_NOATIME	0x0400	/* do not update access times */
> -#define ST_NODIRATIME	0x0800	/* do not update directory =
access times */
> -#define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime =
*/
> +#define ST_RDONLY	(1<<0) /* mount read-only */
> +#define ST_NOSUID	(1<<1) /* ignore suid and sgid bits */
> +#define ST_NODEV	(1<<2) /* disallow access to device special =
files */
> +#define ST_NOEXEC	(1<<3) /* disallow program execution */
> +#define ST_SYNCHRONOUS	(1<<4) /* writes are synced at once */
> +#define ST_VALID	(1<<5) /* f_flags support is implemented */
> +#define ST_MANDLOCK	(1<<6) /* allow mandatory locks on an FS */
> +/* (1<<7) used for ST_WRITE in glibc */
> +/* (1<<8) used for ST_APPEND in glibc */
> +/* (1<<9) used for ST_IMMUTABLE in glibc */
> +#define ST_NOATIME	(1<<10) /* do not update access times */
> +#define ST_NODIRATIME	(1<<11) /* do not update directory =
access times */
> +#define ST_RELATIME	(1<<12) /* update atime relative to mtime/ctime =
*/
>=20
> #endif
> --
> 2.17.0
>=20


Cheers, Andreas






--Apple-Mail=_D7F47ADB-50BF-47CD-AAC9-EA4086E41970
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlrQ6k8ACgkQcqXauRfM
H+BY5A//dcXNbzUvpY084Y1ap19FYY9GUGnuN3CIrR/zKSUVO1ihVJfLSwTG40Wn
usG1NBwhpuhKiPJ6rL+Z+m8+ag8n13yAR54nxRCtsAqsDMdeC3WWVad78EoBOdcU
bEb0Kw3GtTRPY7eSW7M/hnHGuDIWVhYfpv8F/H/q9YqwjHnH92eQABrvCZq/KvKS
hRjzKY0mUb0SehSDTcu5/BGn/z0uEA55w9WZm5i1zR5fk09dli5u2cnMrE/W10FQ
8W4G9w+jOtJHWmDutvK6xiHSDL4ZyZ2M4mym3rIBybO+TFzqcAV84cbXx7aRP+jV
Y1dNY59elAQyZ5vuuxF0pch3qC9NWN78GrFBOkC6ExEBZaQVYQw8KWHuzG+j3wB0
f7Dxns1FFnm14nprxbRkbw+CtS1Fz9nihFp7xMhcX/ISyMSr4D7crw7NXny0rF6X
LfMN0jF+HU2Xodvtc5E42ZSnwbpa0MnJqFQZilBu2bEFh7cu8DmAAyHdhi7ucm5/
Qutzgz+vVkXQn353auIVBoCjUQc7mjpX2zqP8xVmO9TIhdT78Q2o+Uoaa8tJ4Czd
hQXdWwL05AEW1urKAAQywVQE2TFUPRoBMAHOV1ahdeP32BVDicaguyqkduEmMp9b
ntRukS/Cvs6wmtzm5k724cvXuSYRHn6PtYoayQdFJ8Ncd6IIpHw=
=JHIA
-----END PGP SIGNATURE-----

--Apple-Mail=_D7F47ADB-50BF-47CD-AAC9-EA4086E41970--
