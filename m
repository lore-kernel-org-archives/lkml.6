Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226XpcBOphlWMLzJEvnr/w4Y/Kv7XfeIzwm+X1b2MxQsBt5BaGUx+0529hGAawmSUHwu0hOA
ARC-Seal: i=1; a=rsa-sha256; t=1518481054; cv=none;
        d=google.com; s=arc-20160816;
        b=dU96WHuce3Km6hpSu12PguP5SEatwWEIlupxmC8smB91EhjNtIBChjfWNugbmiDH4j
         o8m86Zf9gO0IJAbpJHuJtccJCHKW9Pg65P28x3yDM7DECztShLlj9c7ymUJl011ef1Ej
         LfDz0u8pKgxIT4MWcR3gLRwHiugxWt8/IsxvwZAvsjhfc5lQyBVOFqfsZD5BOu1AkMd3
         azxJ5KWCxlIIgwS7bUL5eeUjVYnVjHm8IglDYwrdYOCJk0LdNNMHBUtPm5ljacPpLtGb
         ESBLvP3JBnOePG0fcxIFfVyl2Pq72DPw5UGiReE8MEJc8misJG+utmzJz3uO9p8FEELw
         aENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=qUQwbbtZyFQjrzWOW74GEKpVh3RK4k1NLMsNO+XWYoQ=;
        b=K4kwhra0BwKCBoIyklXrLUpGNTHiLrgveX+q8G60l+U59tG155FrIznzEv18TqaJO9
         ZHKU2aTMvQp30DVHo9Jz0JqAe98AV7Ryxa06nz2En4LNuclqIvsaNRtRZfArnKF2A3MK
         My8dwm93r/tK/C3jru3GDKRHEPSI6lSyRW7bZAO8JPCZ7wsUdzTgny9N0PlLjcm3PHRs
         is7Q3Cbc+kY3P0Ok9SmKaaLHPsQXRj73q/gGXE9nFm1c9jNLUkTiIUsbslE0ewiU0QKu
         wtoHfH10FTCYisI89jgqP/Go1pTCgwlB4PSaOxiPwpn0LdFrBxvfcSJioG2ZG9Le8i0U
         z7Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Patrick Farrell <paf@cray.com>, Oleg Drokin <oleg.drokin@intel.com>, "Andreas
 Dilger" <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 11:17:22 +1100
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 08/19] staging: lustre: simplify waiting in ldlm_completion_ast()
In-Reply-To: <4AC4BB93-85C5-4CA1-B062-1274833C51C6@cray.com>
References: <151847037709.22826.16175867257667686132.stgit@noble> <151847055674.22826.12912356108048917428.stgit@noble> <4AC4BB93-85C5-4CA1-B062-1274833C51C6@cray.com>
Message-ID: <87o9ktrbe5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231861062476291?=
X-GMAIL-MSGID: =?utf-8?q?1592242789313640711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12 2018, Patrick Farrell wrote:

> Neil,
>
> I didn't get anything after 8/19 in this series.  Is this just me?  (I'd =
keep waiting, except I also found a few things in this patch.)

Not just you.  My fault.  They are appearing now.

>
> Minor:
> The line XXX ALLOCATE is out of date and could go.  (It refers to a
> mix of things you eliminated and things that were already gone.)

What does the line even mean?  Some comment about stack usage?
I think we have a look that looks for large stack frames.  I wonder how
to run it...

>
> Less minor:
> You remove use of the imp_lock when reading the connection count.  While =
that'll work on x86, it's probably wrong on some architecture to read that =
without taking the lock...?

It was my understanding that on all architectures which Linux support, a
32bit aligned read is atomic wrt any 32bit write.  I have trouble imagining=
 how
it could be otherwise.

I probably should have highlighted the removal of the spinlock in the
patch description though - it was intentional.

>
> Bug:
> The existing code uses the imp_conn_cnt from *before* the wait, rather
> than after.  I think that's quite important.  So you'll want to read
> it out before the wait.  I think the main reason we'd hit the timeout
> is a disconnect, which should cause a reconnect, so it's very
> important to use the value from *before* the wait.  (See comment on
> ptlrpc_set_import_discon for more of an explanation.  Basically it's
> tracking a connection 'epoch', if it's changed, someone else already
> went through the reconnect code for this 'connection epoch' and we
> shouldn't start that process.)=20
>

That wasn't intentional though - thanks for catching!
Looking at  ptlrpc_set_import_discon(), which is where the number
eventually gets used, it is only used to compare with the new value of
imp->imp_conn_cnt.=20

This would fix both (assuming the locking issue needs fixing).

Thanks,
NeilBrown

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/st=
aging/lustre/lustre/ldlm/ldlm_request.c
index f1233d844bbd..c3c9186b74ce 100644
=2D-- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -103,7 +103,7 @@ static int ldlm_request_bufsize(int count, int type)
 	return sizeof(struct ldlm_request) + avail;
 }
=20
=2Dstatic void ldlm_expired_completion_wait(struct ldlm_lock *lock, struct =
obd_import *imp2)
+static void ldlm_expired_completion_wait(struct ldlm_lock *lock, __u32 con=
n_cnt)
 {
 	struct obd_import *imp;
 	struct obd_device *obd;
@@ -129,7 +129,7 @@ static void ldlm_expired_completion_wait(struct ldlm_lo=
ck *lock, struct obd_impo
=20
 	obd =3D lock->l_conn_export->exp_obd;
 	imp =3D obd->u.cli.cl_import;
=2D	ptlrpc_fail_import(imp, imp2 ? imp2->imp_conn_cnt : 0);
+	ptlrpc_fail_import(imp, conn_cnt);
 	LDLM_ERROR(lock,
 		   "lock timed out (enqueued at %lld, %llds ago), entering recovery for =
%s@%s",
 		   (s64)lock->l_last_activity,
@@ -241,6 +241,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 f=
lags, void *data)
 	struct obd_device *obd;
 	struct obd_import *imp =3D NULL;
 	__u32 timeout;
+	__u32 conn_cnt =3D 0;
 	int rc =3D 0;
=20
 	if (flags =3D=3D LDLM_FL_WAIT_NOREPROC) {
@@ -268,6 +269,11 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 =
flags, void *data)
=20
 	lock->l_last_activity =3D ktime_get_real_seconds();
=20
+	if (imp) {
+		spin_lock(&imp->imp_lock);
+		conn_cnt =3D imp->imp_conn_cnt;
+		spin_unlock(&imp->imp_lock);
+	}
 	if (OBD_FAIL_CHECK_RESET(OBD_FAIL_LDLM_INTR_CP_AST,
 				 OBD_FAIL_LDLM_CP_BL_RACE | OBD_FAIL_ONCE)) {
 		ldlm_set_fail_loc(lock);
@@ -280,7 +286,7 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 f=
lags, void *data)
 						     is_granted_or_cancelled(lock),
 						     timeout * HZ);
 			if (rc =3D=3D 0)
=2D				ldlm_expired_completion_wait(lock, imp);
+				ldlm_expired_completion_wait(lock, conn_cnt);
 		}
 		/* Now wait abortable */
 		if (rc =3D=3D 0)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqCLpIACgkQOeye3VZi
gbnpTBAAnUPWoPE/y92EWWB/jjQSnrjr5/eJGRf82iSWKoRKE/b4+4/FT917RYUf
CHhPiip23xMTmttzZD65QFZhLSsqcWlclIwdJ2fg9cfAYNGKw68sGPrI4a5I9o/X
JuFrdW9DMrFNwWjLUDEIBY7Lj/6kmKJOroOxeUoSFsx5MRsn6bvtmgSdLhzC4POG
qwLFtH1QvcaDYwA4eMKJlR4FGFV07WzePfBLPJH0cljTBGEMMfSY48dJeeI0T/DV
kIvxDYJ6TLnNtDyR2RTkpzUScn3keOSf0xvlEIxlXBGy10U14cAi8D/7brwiQScG
hZzq6B6ONKUF2KUB+OpH6ZCuPAeegIC8AkKnLaiMEKPon8OoYJrZZSTxtRJr+tZ3
pEBw/OcD4qHOS2E/u+P15E66BrWzNhafT/XxeIT2ksuMfZrFEcJl2wCC/GWt9kK5
liMOAWLx7yMkNzbpdn3NNS2Re1ruW9RAfZnpdaAOZl5qxXrMe2Ox78x4YPw3efYr
TnR6+tjwEM41+OPfWPt4TdOFqjG6jkomaqysY0rs8i4p0dpjLyfRs15yLi7Ec8wY
Bte5YY0j0uYAgF+pqoMVSEdgzenNQq9ogPh2pJX457Qx5Au/1kFcUC9PHrP6SW5m
V4tedjpKVSUnrt5O9BEuPhu0xrvVtu/6iMMlsoR6MYEF+POrJM0=
=ien4
-----END PGP SIGNATURE-----
--=-=-=--
