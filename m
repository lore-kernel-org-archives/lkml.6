Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx495aaS1WWooq7HpqGOmCsCdZ8vwYzVQN6kbV5EUs81aZ0dbJo5gzAtojCeZh5HWt+CwusbI
ARC-Seal: i=1; a=rsa-sha256; t=1522708449; cv=none;
        d=google.com; s=arc-20160816;
        b=QwLPwsGlDlosp+c0F+O1w1K6JkSp/0NSOg0ws2jqm+HkcqgyYMozuYJfw2xu/AO3xg
         FqfEv5gAFittSAkwuxMxW+RaqNTDUFy9UEI0HOFnzHBjMwxqL21Ou1rypp+kEx89W1Zl
         CWv8tYRB1BLGuAayKNrs3FE5cDy0vsVF38iIOd0XYCHPbO4PK0lAyC8Z4W93eQktTcF5
         hbiA86DygVWmUkmu5XiZfS0XOLTJmL+rSUJxFv8aLQsGuflclfQ9Ggo19FLv2+IdNPO7
         D91CMK68PLU3N4LlSDmPs2s+9U5nRY8SoBnod0yRP5Kf08JJLuNwtJzIcNjlbMq1EfvC
         9zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=8OazoarOMi80RrZtr/rXjuOzkNnc4u9aOUTJifNk3sc=;
        b=dttfQteKqrMG850Lp+FDJr9IfzMcVoU2FrLRVXocRUtYpDNLzSSWQWZLSbZ4kmqomD
         t2yVND+su3DxHHHH+RfGOnh7jNzCdBw25o/eBNHDS0zaoBuomUb4Lx+JEa3dSmbOun/A
         BbLQfLRf1BKoomUyZrtGMKIaYLow2SKOUMUy3gn0vqzEGrjBaoLZt5VafnhVarlznEJ6
         i73sKpNU0UoNkKqz1R8nU7dNJQWnH0y4Q4WsM/5lDlkPrmswBtZXhT/TkXCnnA6I0p6y
         JsMIbUI3TBGy1MW8EdyFa80IbSh9H25tL89JwZfEAzp6uzYyvjYsXAW+2Qhv6/G0Q0Ui
         1H5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Tue, 03 Apr 2018 08:34:00 +1000
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 13/17] staging: lustre: libcfs: remove cfs_timeout_cap()
In-Reply-To: <346B8E2C-5842-4771-86D8-CBB5CEF2DC35@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760874.27689.12453214678546053828.stgit@noble> <346B8E2C-5842-4771-86D8-CBB5CEF2DC35@intel.com>
Message-ID: <87k1tp1bmv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244858213208850?=
X-GMAIL-MSGID: =?utf-8?q?1596675535336391330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02 2018, Dilger, Andreas wrote:

> On Mar 28, 2018, at 22:26, NeilBrown <neilb@suse.com> wrote:

>> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-tim=
e.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> index ff3aae2f1231..ecb2126a9e6f 100644
>> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> @@ -78,7 +78,7 @@ static inline int cfs_time_beforeq_64(u64 t1, u64 t2)
>> /*
>>  * One jiffy
>>  */
>> -#define CFS_TICK		(1)
>> +#define CFS_TICK		(1UL)
>
> It seems like CFS_TICK is mostly useless as well and could just be droppe=
d?

Possibly, but I don't know what its purpose is so I didn't want to just
drop it in the middle of a patch that is performing an idempotent
transformation.

Do you know why the one place that uses CFS_TICK wants to protect about
a timeout of zero?  Maybe because the old l_wait_event() treated a
timeout of zero as meaning no timeout?
In that case this really is irrelevant now and that
wait_event_idle_timeout() should just use "timeout" directly.

Thanks,
NeilBrown


>
>> #define CFS_DURATION_T	  "%ld"
>>=20
>> diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/sta=
ging/lustre/lustre/ptlrpc/import.c
>> index 4a9d1f189d01..dd4fd54128dd 100644
>> --- a/drivers/staging/lustre/lustre/ptlrpc/import.c
>> +++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
>> @@ -1486,7 +1486,7 @@ int ptlrpc_disconnect_import(struct obd_import *im=
p, int noclose)
>> 	}
>>=20
>> 	if (ptlrpc_import_in_recovery(imp)) {
>> -		long timeout;
>> +		unsigned long timeout;
>>=20
>> 		if (AT_OFF) {
>> 			if (imp->imp_server_timeout)
>> @@ -1501,7 +1501,7 @@ int ptlrpc_disconnect_import(struct obd_import *im=
p, int noclose)
>>=20
>> 		if (wait_event_idle_timeout(imp->imp_recovery_waitq,
>> 					    !ptlrpc_import_in_recovery(imp),
>> -					    cfs_timeout_cap(timeout)) =3D=3D 0)
>> +					    max(timeout, CFS_TICK)) =3D=3D 0)
>> 			l_wait_event_abortable(
>> 				imp->imp_recovery_waitq,
>> 				!ptlrpc_import_in_recovery(imp));
>>=20
>>=20
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrCr9kACgkQOeye3VZi
gbnnfhAAv1ip0QJR0qLJ8SXIOFocVwJfPS+J9pw51MC+2bkZkQ1x8ZO6gq0ZlVoR
Hmc/65qENJAyJtXee6RxC1fO5fF2pLkHbUkzPg5cohu8sjBznaZA2OFShLwnRXyd
/hFp+az2v1UG7rcoY63yXVgtkPzoQRTSdnE+A9sOqYdUdOAQ6Ap+BBlvvwjob6YB
UY4o1Qd0pT9Fnk28YvS53dERbKTuUdvI8Gdqlh3+8kLkwp4ZofooIyv2IUlhiE1v
TCpTARl5ETY0YSZ4poXYjMLPPESd20PRzC0c425Zg786h2Lwv36cE0daypQaeZx/
xl/aF+aSKJ2L+1M2/ZYLN33j8bfelzV0ox53bUqC055Xnwh1mVv8g3dZX4pncRPH
D2TWwqT33eB1ybvXsff48N745XZMaMKYTEZGOsq8DlV01x4sCmKOuKFmlwMro6PS
FKlvJE66O8W3nf/CTgTuRgu3zo/x1RfTdkOe3UI/y/kiuqJrUkFf83Uucf4WrERm
GZWF8uzEAKqI6+slMEp3+a1WMv2YDvuzloQSSAjJzrmA1p1d1XtqsPd6Aw4Z4Yfw
wSHARh5CrwhghVmVz2ADwtWONUWrp6VZsau/ZNhRyBYiRkpL8wfA8euBePTdX6Bw
TDZNC2FbSozAg98Vhm/eFiSVYNj0RN6r5TwcJ9BUiBaS7whGggo=
=Bb07
-----END PGP SIGNATURE-----
--=-=-=--
