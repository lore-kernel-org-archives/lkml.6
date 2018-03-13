Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELurkOxj47c78b6q7eUAgi3pi/0NI43I6lVosCW5QSbW8XdkpU09Z6bKIAZAi2mLbDoAOntN
ARC-Seal: i=1; a=rsa-sha256; t=1520978092; cv=none;
        d=google.com; s=arc-20160816;
        b=jZbjfbaL6/2ruALT8+4YhTryMFTwb5DSeqNi3XsA7fL6tr48oWqswbRnC61qPl83Wg
         WQ/fDwgzk70NXoyv7unP7VdOuHx5SOTljKvgnigWI8oYIpt3uOHjt8DVu8QM6ylZNM6q
         Z4s6NKEXZ4EP2pahPQNhMuQp4NEZejWvetZTdR7KGhRTD23X8vfdb4KAk4PgpYKiia/f
         JSUIaGc7R84nhcQuEykRWYcYLdeqrpmSQozKAIYbnNyONAm1aB1uJ2rpRA3YOzOCdWKu
         V5Z3QU3w62piUjK3KU2iNyXn0WhYoNiaZhhHqc3Qf9rnfiAn2s+uc5Yb1aQe6J5jfJD/
         v2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=w0KFIRPFN/Hocki/++R84C1oj5GtOZ1B2bI2dOrU3Mw=;
        b=sPep3Z/GOZ8FbniGcDNL6XFyzuxbkZbBkdL2kL7GDaOiO0Fm5u1h16kDdI83zYlsuj
         zigHodrjbDM2hCdlcDYLMM8eERoIWZnLnn79rwVzMjtMLdWGGs/fQOCa9qSL4z0Ej22c
         QZnE9gbnXnZEi3RKg7vFtIeXi+7Rak3GRKJiKgfli3IL8pIsR7oBO5zKLew5OaKrLU+t
         nsou7Q+BfKRv07AGwIsXHRQGTajJ4aBPUz/JAx6Ll2I0Z4mQshwkghSuIJz17unsHSrD
         wzlHb7LxpXx9ELIkwL3bf475sjTkqCbO0w89h23+mKGcKty63b45iOIo7LfxUyUTl95A
         x9OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Arnd Bergmann <arnd@arndb.de>, Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 14 Mar 2018 08:54:39 +1100
Cc: Arnd Bergmann <arnd@arndb.de>, lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: lustre: fid: avoid false-positive uninitialized variable warning
In-Reply-To: <20180313130532.4015402-1-arnd@arndb.de>
References: <20180313130532.4015402-1-arnd@arndb.de>
Message-ID: <87lgevd4kg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827833770334289?=
X-GMAIL-MSGID: =?utf-8?q?1594861124622653307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13 2018, Arnd Bergmann wrote:

> One of Neil's recent cleanups apparently has led the code to get
> to a state where gcc tracks the 'seqnr' variable just enough to
> see that it is sometimes initialized in seq_client_alloc_seq(),
> but not enough that it can prove this initialization to be reliable
> before the use of that variable:
>
> drivers/staging/lustre/lustre/fid/fid_request.c: In function 'seq_client_=
alloc_fid':
> drivers/staging/lustre/lustre/fid/fid_request.c:245:22: error: 'seqnr' ma=
y be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>
> The code seems to be otherwise correct, and I could not come
> up with a good way to simplify it further, so this adds a fake
> initialization to shut up that warning.

We could possibly have seq_client_alloc_seq return the seqnr,
or U64_MAX+rc.

Then if (seqnr >=3D U64MAX-MAX_ERRNO) there is an error.

I'm not sure that is actually an improvement though, and I'm happy with
your approach

 Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/lustre/lustre/fid/fid_request.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/st=
aging/lustre/lustre/fid/fid_request.c
> index fa23423eb8b3..030680f37c79 100644
> --- a/drivers/staging/lustre/lustre/fid/fid_request.c
> +++ b/drivers/staging/lustre/lustre/fid/fid_request.c
> @@ -174,6 +174,7 @@ static int seq_client_alloc_seq(const struct lu_env *=
env,
>  		if (rc) {
>  			CERROR("%s: Can't allocate new meta-sequence, rc %d\n",
>  			       seq->lcs_name, rc);
> +			*seqnr =3D U64_MAX;
>  			return rc;
>  		}
>  		CDEBUG(D_INFO, "%s: New range - " DRANGE "\n",
> --=20
> 2.9.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqoSKAACgkQOeye3VZi
gbklgw//R1BGQx7VjkoQdjtusyGVgyzIAyB8hRUbLCkCMy79Wvz9hvrmA/RWRnTa
U+4u7MkTjZrFhm4d10BrG6XxmqUou7SWQpsl0nkMcr95fpPTSXpT9o1I4DsneJ7U
J8eIQIrjeTSzJ5sOpPUDnoVVdyU2p3iveEzeCtrOH7ATKvbOyyRMPWuf9JrB0HUV
sTKaJx5tLwF6XgB1GKBduYmVNHoFJT7K9f4wxy7Tl991fd87jvKvY9mBmF1iUPhi
ApB3cTXdUC7D6BluQon59MmRIF4xIuUnuzMV+Kyk/C6ylzUS8v+mNGwkfygl8asy
avtdK1U2rYNFavWcOe9YKocGQtFl/TuTMTChdeE5s5uAKmbsJntBP7WECo307qsZ
BBsyDv7VLTwKwqQXSsK5Bog0BeEjeWx308lTXvISnKHcuXRu/TOA0lQ6u+VwEJaO
KNCjHWjtGWqKIl0h0tXjltg/TpgOouaEZSATBa/HRn3PszPCiFyjZEz2BTWaKLCG
S/1Uvf4mEAW0k1BBeev1wRQyp04T5s2iYKn8HDg2cnei23LucOSpf4G8+f0f0Hjg
Pjpjl0E3iuqNz0U6jk4t8SLMqTY1cPLrCDy6kVhqiBUSVPQeXlKJcr2GPUjcq0Li
mJCWEpxRW0024zqqxJRWeOk9IcX2bCPeE9tlQn5ErpV8fqRxCrE=
=0aSz
-----END PGP SIGNATURE-----
--=-=-=--
