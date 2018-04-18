Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48S0oCxwSZU3kGZDTPgldvPGeT2Wi7dqSOjZJy4eZEc8a3EnQuA497jNnwk4tPqAl+RNH5o
ARC-Seal: i=1; a=rsa-sha256; t=1524017879; cv=none;
        d=google.com; s=arc-20160816;
        b=bzWdUER8SN8tYkdCTghDRQubuvjQftImXhTu8O68xZvwAQwdBA+vE+e1dp08A+uOXR
         Sqmg40RJ/USBQsbBayDghQMhR2APya/Ji4/w2dtrm1jd2J/cs9d+4YAIkRWM64voS04/
         SkHlPFBmVULtEoeRdf//daKz6ZFPDkQ7DVwSq/X6pejgAdMFK0Dn4FB6+SXtePsn3k5p
         C2K0+SH8XGsTWr4lZk0cpsimw5lg1nuYlDOE8Wo2zjKFGFdKq8y+oB8aiD7nI99nYDOB
         wFqvkM6Tr/2cb+AhnttWk7V5ugtf7b8BqFPVu1319EDxdHgiDERwPQ4RDCa+06uhqhXs
         D+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=a5IEPK+oBIJKNAL2gYbw3X+KpC9vu0G0Wcf4GL3FFHM=;
        b=NKkUOq2q6swmoxCjxjrItxhVjZDy9n0yzxb1Kxro1vdhfzFtBt8GVzgvz528WE/iY5
         AAtJRnTgxiyNcE7KJzRTJfgE/bly/jL2LDNLQ8g1u68XPrRpHnoyEAWDM+Y9jiYpUX6H
         Knccld2WJ+s5zOyCgod9gxoGnCYfovmpNbWyDaYtF6R6JegfB2i+a8s9KmhevNTpNU7x
         fA28KEOv432UXvNQ96sQiHHaVb03RsCultM9sSNILk4WnlP6P1AEHuHnX2FEn9M5V4F7
         FwhI66cPzp1eVDYh/fT7KX6+Z47HCjvswLbgezrNvver2Ou8irnARIyaWZ605iARhKSs
         SHsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 18 Apr 2018 12:17:37 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 1/6] staging: lustre: move stack-check macros to libcfs_debug.h
In-Reply-To: <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935730.23409.6748888065027051683.stgit@noble> <alpine.LFD.2.21.1804160438220.16188@casper.infradead.org>
Message-ID: <87a7u1s1fi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861409409058351?=
X-GMAIL-MSGID: =?utf-8?q?1598048571811399971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16 2018, James Simmons wrote:

>> CDEBUG_STACK() and CHECK_STACK() are macros to help with
>> debugging, so move them from
>>    drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>> to
>>    drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>>=20
>> This seems a more fitting location, and is a step towards
>> removing linux/libcfs.h and simplifying the include file structure.
>
> Nak. Currently the lustre client always enables debugging but that
> shouldn't be the case. What we do need is the able to turn off the=20
> crazy debugging stuff. In the development branch of lustre it is
> done with CDEBUG_ENABLED. We need something like that in Kconfig
> much like we have CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK. Since we like
> to be able to turn that off this should be moved to just after
> LIBCFS_DEBUG_MSG_DATA_DECL. Then from CHECK_STACK down to CWARN()
> it can be build out. When CDEBUG_ENABLED is disabled CDEBUG_LIMIT
> would be empty.

So why, exactly, is this an argument to justify a NAK?
Are you just saying  that the code I moved into libcfs_debug.h should be
moved to somewhere a bit later in the file?
That can easily be done when it is needed.  It isn't needed now so why
insist on it?

Each patch should do one thing and make clear forward progress.  This
patch gets rid of an unnecessary file and brings related code together.
I think that qualifies.

Thanks,
NeilBrown


>=20=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  .../lustre/include/linux/libcfs/libcfs_debug.h     |   32 +++++++++++++=
+++++++
>>  .../lustre/include/linux/libcfs/linux/libcfs.h     |   31 -------------=
------
>>  2 files changed, 32 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h =
b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>> index 9290a19429e7..0dc7b91efe7c 100644
>> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h
>> @@ -62,6 +62,38 @@ int libcfs_debug_str2mask(int *mask, const char *str,=
 int is_subsys);
>>  extern unsigned int libcfs_catastrophe;
>>  extern unsigned int libcfs_panic_on_lbug;
>>=20=20
>> +/* Enable debug-checks on stack size - except on x86_64 */
>> +#if !defined(__x86_64__)
>> +# ifdef __ia64__
>> +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>> +			  ((unsigned long)__builtin_dwarf_cfa() &       \
>> +			   (THREAD_SIZE - 1)))
>> +# else
>> +#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>> +			  ((unsigned long)__builtin_frame_address(0) &  \
>> +			   (THREAD_SIZE - 1)))
>> +# endif /* __ia64__ */
>> +
>> +#define __CHECK_STACK(msgdata, mask, cdls)			      \
>> +do {								    \
>> +	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
>> +		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
>> +		libcfs_stack =3D CDEBUG_STACK();			  \
>> +		libcfs_debug_msg(msgdata,			       \
>> +				 "maximum lustre stack %lu\n",	  \
>> +				 CDEBUG_STACK());		       \
>> +		(msgdata)->msg_mask =3D mask;			     \
>> +		(msgdata)->msg_cdls =3D cdls;			     \
>> +		dump_stack();					   \
>> +	      /*panic("LBUG");*/					\
>> +	}							       \
>> +} while (0)
>> +#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, ma=
sk, cdls)
>> +#else /* __x86_64__ */
>> +#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
>> +#define CDEBUG_STACK() (0L)
>> +#endif /* __x86_64__ */
>> +
>>  #ifndef DEBUG_SUBSYSTEM
>>  # define DEBUG_SUBSYSTEM S_UNDEFINED
>>  #endif
>> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h =
b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>> index 07d3cb2217d1..83aec9c7698f 100644
>> --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
>> @@ -80,35 +80,4 @@
>>  #include <stdarg.h>
>>  #include "linux-cpu.h"
>>=20=20
>> -#if !defined(__x86_64__)
>> -# ifdef __ia64__
>> -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>> -			  ((unsigned long)__builtin_dwarf_cfa() &       \
>> -			   (THREAD_SIZE - 1)))
>> -# else
>> -#  define CDEBUG_STACK() (THREAD_SIZE -				 \
>> -			  ((unsigned long)__builtin_frame_address(0) &  \
>> -			   (THREAD_SIZE - 1)))
>> -# endif /* __ia64__ */
>> -
>> -#define __CHECK_STACK(msgdata, mask, cdls)			      \
>> -do {								    \
>> -	if (unlikely(CDEBUG_STACK() > libcfs_stack)) {		  \
>> -		LIBCFS_DEBUG_MSG_DATA_INIT(msgdata, D_WARNING, NULL);   \
>> -		libcfs_stack =3D CDEBUG_STACK();			  \
>> -		libcfs_debug_msg(msgdata,			       \
>> -				 "maximum lustre stack %lu\n",	  \
>> -				 CDEBUG_STACK());		       \
>> -		(msgdata)->msg_mask =3D mask;			     \
>> -		(msgdata)->msg_cdls =3D cdls;			     \
>> -		dump_stack();					   \
>> -	      /*panic("LBUG");*/					\
>> -	}							       \
>> -} while (0)
>> -#define CFS_CHECK_STACK(msgdata, mask, cdls)  __CHECK_STACK(msgdata, ma=
sk, cdls)
>> -#else /* __x86_64__ */
>> -#define CFS_CHECK_STACK(msgdata, mask, cdls) do {} while (0)
>> -#define CDEBUG_STACK() (0L)
>> -#endif /* __x86_64__ */
>> -
>>  #endif /* _LINUX_LIBCFS_H */
>>=20
>>=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWqsEACgkQOeye3VZi
gbnurxAAhJnypoYlpUyCCgAUsNzkfvI0WAOVjRGAL0U9aA9HFEY0soWuh+LumC0K
T1Dj1/3XHkjSGzyTSt87jleJRl2FlMRMKND5aDUBE8Q3IbkHi2pI4rusPq09A1kV
xXtIM48rFjAm+hx6ns5BJs/2f4c53ouQZVCKFsw/tUK8RaKVYikRfLfvucoDEeZD
FbKE+m8f/4tbhngR775Js0Bu1pKjx4Hl/eCBj5nVpemXq/NVBo1jBwuWzaGjHs1a
V5ebyv6tKQ7HdsUW+slKyVGKgyHFeDXSjQsdqba7AlWOD6ehS4Ki/YMYmfjpaCMx
aB8KQsRWZA5SZOEBHvLL8HHUeNaeM/qztX800tlj3/+KPplrKomz/8o+xkx0yq1O
CbbMMiBsgVxAYJgokdVoxGsooydGv8miYb/vjhhSTfIBrq4rj30HSuyXCOZ5i2aS
kCjdhL2HCNwtWxT9r+mJSL1I9ts+lkOTahvamv/3gEKYwqpeflDmaHENFfagEbIs
5LIZTw2h35iYhjOh19D81rq4+AsiLQ53xEmPibVEiRu/pwuaX51iSzRaVQdpL0Ge
ILbeaRH+2LkFtkNG17t+1mm00e0ExV0eiXaGNUSY5NYUCvR/bhGrsggPChNOnlaJ
KHRri91V4nyYDyCHxB24hLtR3+v6641Os3yDjhs9H43I6s6Hxr4=
=X/xr
-----END PGP SIGNATURE-----
--=-=-=--
