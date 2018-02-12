Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226XBWZtMwn7fkxUNDGPQ9VZXpSyMaHAGGRiF3SW6olYheP7hTzwsgYLFYnxWiAwU6Ra9K6s
ARC-Seal: i=1; a=rsa-sha256; t=1518479903; cv=none;
        d=google.com; s=arc-20160816;
        b=aswKfnDSupx9chHv2M8vKT0hKbAkheLOMlkeScHzYwVVqdrUpXryfwnZXVRScSNnmb
         wT3eM3DgvDFzv8McA5cr93sdkVFa7BEVZ83jIAB8E7V1Jyo8P3tAUHwcDfgx10soytQI
         Dv7k+EEZS/5k2va8z4BI7hTsCRR8dTbxDPNWI9SSkz632wsxvJGaaP86d7nlIi4zt3MO
         GQHqt6eL1FQyUpMaXJcg6o/36kpBRmajGnQu/G6yA7gKwkFm6yGwuBPtAHh72UfbzLzo
         yB7Na7TiXmPtXyZJJ7A//81Tnp9cOI87NL0r9Qk+oxRQsJVrE/b7IoCT7FVn+EAjml7s
         OGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=TJjKDq73qzWeYO1pwjODWeof8v3P5XrumeSPUGYG9wQ=;
        b=pFS2o3wIU5xge/46PshVzTNGvtqAmoWfJp+v8dmw16eina31fPIXCrwWZMwmSPBJE3
         fJbaMbCQSXMs55EC/FadDNCGFqeGQ9wksJQzQe4Oe9VgOcP60XVano56skkz3DZTHBK3
         J3ReYo9QJN/ZSSiD1zJCvTPOCGgv084BZkTbR2Q1HLpS/QgFzJDMmEHftjWbuwI5I98c
         qb1WsdbFKPWwHdHKVAzd+izKWVpcL/99F4y68DQPikJcSVylf/03NWoeYRiKOgrwkLSu
         BLLvSJ7Rp6A6wP3SWiCRMa3z58bGWZ7FwPf7fYwW7QZTxq1hiVrm/TRKnZmwB6qD0dkY
         lrwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Patrick Farrell <paf@cray.com>, Oleg Drokin <oleg.drokin@intel.com>, "Andreas
 Dilger" <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 10:58:09 +1100
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 06/19] staging: lustre: introduce and use l_wait_event_abortable()
In-Reply-To: <81AFF1FD-E398-4B69-9B20-1D202747AB25@cray.com>
References: <151847037709.22826.16175867257667686132.stgit@noble> <151847055667.22826.8544979478231411275.stgit@noble> <81AFF1FD-E398-4B69-9B20-1D202747AB25@cray.com>
Message-ID: <87r2pprca6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231846783527803?=
X-GMAIL-MSGID: =?utf-8?q?1592241582686097026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12 2018, Patrick Farrell wrote:

> It's worth noting that the change from -EINTR to -ERESTARTSYS will
> modify the behavior of userspace slightly.  Specifically, when a
> signal handler is setup with retry set (SA_RESTART flag set), the
> syscall will be restarted rather than aborted.

Thanks for the review.
This state is true if the error status ever gets all the way up to user
space.  I don't think it does, though I haven't carefully audited every
l_wait_event_abortable() call site.  I did look at a few and the return
value is only used locally in the same function.
I suspect I would have checked for error codes escaping when I wrote
the patch, but I don't have a clear memory.

Some sort of audit wouldn't hurt of course.

Thanks,
NeilBrown


>
> This should be fine.  It may eventually shake out some stuble bugs in Lus=
tre when we abort an operation and then restart it from a point where we di=
dn't in the past - past instances where we changed from -EINTR to -ERESTART=
SYS certainly have - but it's for the best.  As I understand it from past c=
onversations with Andreas and others, Lustre is not really intending to cla=
im it's not restartable, it's just an artifact of people copying older code=
 that was written without awareness of the difference in EINTR vs ERESTARTS=
YS.
>
> Ideally someone should go through and audit the remaining uses of -EINTR =
and replace most of them with -ERESTARTSYS.
>
> James, maybe you want to add that to the TODO list?
>
> =EF=BB=BFOn 2/12/18, 3:24 PM, "lustre-devel on behalf of NeilBrown" <lust=
re-devel-bounces@lists.lustre.org on behalf of neilb@suse.com> wrote:
>
>     lustre sometimes wants to wait for an event, but abort if
>     one of a specific list of signals arrives.  This is a little
>     bit like wait_event_killable(), except that the signals are
>     identified a different way.
>=20=20=20=20=20
>     So introduce l_wait_event_abortable() which provides this
>     functionality.
>     Having separate functions for separate needs is more in line
>     with the pattern set by include/linux/wait.h, than having a
>     single function which tries to include all possible needs.
>=20=20=20=20=20
>     Also introduce l_wait_event_abortable_exclusive().
>=20=20=20=20=20
>     Note that l_wait_event() return -EINTR on a signal, while
>     Linux wait_event functions return -ERESTARTSYS.
>     l_wait_event_{abortable_,}exclusive follow the Linux pattern.
>=20=20=20=20=20
>     Reviewed-by: James Simmons <jsimmons@infradead.org>
>     Signed-off-by: NeilBrown <neilb@suse.com>
>     ---
>      drivers/staging/lustre/lustre/include/lustre_lib.h |   24 ++++++++++=
++++++++++
>      drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   12 +++++-----
>      drivers/staging/lustre/lustre/llite/llite_lib.c    |   12 +++-------
>      drivers/staging/lustre/lustre/obdclass/genops.c    |    9 +++-----
>      drivers/staging/lustre/lustre/obdclass/llog_obd.c  |    5 ++--
>      drivers/staging/lustre/lustre/osc/osc_page.c       |    6 ++---
>      drivers/staging/lustre/lustre/osc/osc_request.c    |    6 ++---
>      7 files changed, 43 insertions(+), 31 deletions(-)
>=20=20=20=20=20
>     diff --git a/drivers/staging/lustre/lustre/include/lustre_lib.h b/dri=
vers/staging/lustre/lustre/include/lustre_lib.h
>     index 7d950c53e962..b2a64d0e682c 100644
>     --- a/drivers/staging/lustre/lustre/include/lustre_lib.h
>     +++ b/drivers/staging/lustre/lustre/include/lustre_lib.h
>     @@ -336,4 +336,28 @@ do {									   \
>      /** @} lib */
>=20=20=20=20=20=20
>=20=20=20=20=20=20
>     +
>     +/* l_wait_event_abortable() is a bit like wait_event_killable()
>     + * except there is a fixed set of signals which will abort:
>     + * LUSTRE_FATAL_SIGS
>     + */
>     +#define l_wait_event_abortable(wq, condition)				\
>     +({									\
>     +	sigset_t __blocked;						\
>     +	int __ret =3D 0;							\
>     +	__blocked =3D cfs_block_sigsinv(LUSTRE_FATAL_SIGS);		\
>     +	__ret =3D wait_event_interruptible(wq, condition);		\
>     +	cfs_restore_sigs(__blocked);					\
>     +	__ret;								\
>     +})
>     +
>     +#define l_wait_event_abortable_exclusive(wq, condition)			\
>     +({									\
>     +	sigset_t __blocked;						\
>     +	int __ret =3D 0;							\
>     +	__blocked =3D cfs_block_sigsinv(LUSTRE_FATAL_SIGS);		\
>     +	__ret =3D wait_event_interruptible_exclusive(wq, condition);	\
>     +	cfs_restore_sigs(__blocked);					\
>     +	__ret;								\
>     +})
>      #endif /* _LUSTRE_LIB_H */
>     diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/dri=
vers/staging/lustre/lustre/ldlm/ldlm_resource.c
>     index 2e66825c8f4b..4c44603ab6f9 100644
>     --- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
>     +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
>     @@ -879,7 +879,6 @@ static int __ldlm_namespace_free(struct ldlm_name=
space *ns, int force)
>      	ldlm_namespace_cleanup(ns, force ? LDLM_FL_LOCAL_ONLY : 0);
>=20=20=20=20=20=20
>      	if (atomic_read(&ns->ns_bref) > 0) {
>     -		struct l_wait_info lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>      		int rc;
>=20=20=20=20=20=20
>      		CDEBUG(D_DLMTRACE,
>     @@ -887,11 +886,12 @@ static int __ldlm_namespace_free(struct ldlm_na=
mespace *ns, int force)
>      		       ldlm_ns_name(ns), atomic_read(&ns->ns_bref));
>      force_wait:
>      		if (force)
>     -			lwi =3D LWI_TIMEOUT(msecs_to_jiffies(obd_timeout *
>     -					  MSEC_PER_SEC) / 4, NULL, NULL);
>     -
>     -		rc =3D l_wait_event(ns->ns_waitq,
>     -				  atomic_read(&ns->ns_bref) =3D=3D 0, &lwi);
>     +			rc =3D wait_event_idle_timeout(ns->ns_waitq,
>     +						     atomic_read(&ns->ns_bref) =3D=3D 0,
>     +						     obd_timeout * HZ / 4) ? 0 : -ETIMEDOUT;
>     +		else
>     +			rc =3D l_wait_event_abortable(ns->ns_waitq,
>     +						    atomic_read(&ns->ns_bref) =3D=3D 0);
>=20=20=20=20=20=20
>      		/* Forced cleanups should be able to reclaim all references,
>      		 * so it's safe to wait forever... we can't leak locks...
>     diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/driver=
s/staging/lustre/lustre/llite/llite_lib.c
>     index c820b201af71..ccb614bd7f53 100644
>     --- a/drivers/staging/lustre/lustre/llite/llite_lib.c
>     +++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
>     @@ -986,16 +986,12 @@ void ll_put_super(struct super_block *sb)
>      	}
>=20=20=20=20=20=20
>      	/* Wait for unstable pages to be committed to stable storage */
>     -	if (!force) {
>     -		struct l_wait_info lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>     -
>     -		rc =3D l_wait_event(sbi->ll_cache->ccc_unstable_waitq,
>     -				  !atomic_long_read(&sbi->ll_cache->ccc_unstable_nr),
>     -				  &lwi);
>     -	}
>     +	if (!force)
>     +		rc =3D l_wait_event_abortable(sbi->ll_cache->ccc_unstable_waitq,
>     +					    !atomic_long_read(&sbi->ll_cache->ccc_unstable_nr));
>=20=20=20=20=20=20
>      	ccc_count =3D atomic_long_read(&sbi->ll_cache->ccc_unstable_nr);
>     -	if (!force && rc !=3D -EINTR)
>     +	if (!force && rc !=3D -ERESTARTSYS)
>      		LASSERTF(!ccc_count, "count: %li\n", ccc_count);
>=20=20=20=20=20=20
>      	/* We need to set force before the lov_disconnect in
>     diff --git a/drivers/staging/lustre/lustre/obdclass/genops.c b/driver=
s/staging/lustre/lustre/obdclass/genops.c
>     index 3ff25b8d3b48..8f776a4058a9 100644
>     --- a/drivers/staging/lustre/lustre/obdclass/genops.c
>     +++ b/drivers/staging/lustre/lustre/obdclass/genops.c
>     @@ -1332,7 +1332,6 @@ static bool obd_request_slot_avail(struct clien=
t_obd *cli,
>      int obd_get_request_slot(struct client_obd *cli)
>      {
>      	struct obd_request_slot_waiter orsw;
>     -	struct l_wait_info lwi;
>      	int rc;
>=20=20=20=20=20=20
>      	spin_lock(&cli->cl_loi_list_lock);
>     @@ -1347,11 +1346,9 @@ int obd_get_request_slot(struct client_obd *cl=
i)
>      	orsw.orsw_signaled =3D false;
>      	spin_unlock(&cli->cl_loi_list_lock);
>=20=20=20=20=20=20
>     -	lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>     -	rc =3D l_wait_event(orsw.orsw_waitq,
>     -			  obd_request_slot_avail(cli, &orsw) ||
>     -			  orsw.orsw_signaled,
>     -			  &lwi);
>     +	rc =3D l_wait_event_abortable(orsw.orsw_waitq,
>     +				    obd_request_slot_avail(cli, &orsw) ||
>     +				    orsw.orsw_signaled);
>=20=20=20=20=20=20
>      	/*
>      	 * Here, we must take the lock to avoid the on-stack 'orsw' to be
>     diff --git a/drivers/staging/lustre/lustre/obdclass/llog_obd.c b/driv=
ers/staging/lustre/lustre/obdclass/llog_obd.c
>     index 28bbaa2136ac..26aea114a29b 100644
>     --- a/drivers/staging/lustre/lustre/obdclass/llog_obd.c
>     +++ b/drivers/staging/lustre/lustre/obdclass/llog_obd.c
>     @@ -104,7 +104,6 @@ EXPORT_SYMBOL(__llog_ctxt_put);
>=20=20=20=20=20=20
>      int llog_cleanup(const struct lu_env *env, struct llog_ctxt *ctxt)
>      {
>     -	struct l_wait_info lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>      	struct obd_llog_group *olg;
>      	int rc, idx;
>=20=20=20=20=20=20
>     @@ -129,8 +128,8 @@ int llog_cleanup(const struct lu_env *env, struct=
 llog_ctxt *ctxt)
>      		CERROR("Error %d while cleaning up ctxt %p\n",
>      		       rc, ctxt);
>=20=20=20=20=20=20
>     -	l_wait_event(olg->olg_waitq,
>     -		     llog_group_ctxt_null(olg, idx), &lwi);
>     +	l_wait_event_abortable(olg->olg_waitq,
>     +			     llog_group_ctxt_null(olg, idx));
>=20=20=20=20=20=20
>      	return rc;
>      }
>     diff --git a/drivers/staging/lustre/lustre/osc/osc_page.c b/drivers/s=
taging/lustre/lustre/osc/osc_page.c
>     index 20094b6309f9..6fdd521feb21 100644
>     --- a/drivers/staging/lustre/lustre/osc/osc_page.c
>     +++ b/drivers/staging/lustre/lustre/osc/osc_page.c
>     @@ -759,7 +759,6 @@ static long osc_lru_reclaim(struct client_obd *cl=
i, unsigned long npages)
>      static int osc_lru_alloc(const struct lu_env *env, struct client_obd=
 *cli,
>      			 struct osc_page *opg)
>      {
>     -	struct l_wait_info lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>      	struct osc_io *oio =3D osc_env_io(env);
>      	int rc =3D 0;
>=20=20=20=20=20=20
>     @@ -782,9 +781,8 @@ static int osc_lru_alloc(const struct lu_env *env=
, struct client_obd *cli,
>=20=20=20=20=20=20
>      		cond_resched();
>=20=20=20=20=20=20
>     -		rc =3D l_wait_event(osc_lru_waitq,
>     -				  atomic_long_read(cli->cl_lru_left) > 0,
>     -				  &lwi);
>     +		rc =3D l_wait_event_abortable(osc_lru_waitq,
>     +					    atomic_long_read(cli->cl_lru_left) > 0);
>=20=20=20=20=20=20
>      		if (rc < 0)
>      			break;
>     diff --git a/drivers/staging/lustre/lustre/osc/osc_request.c b/driver=
s/staging/lustre/lustre/osc/osc_request.c
>     index 45b1ebf33363..074b5ce6284c 100644
>     --- a/drivers/staging/lustre/lustre/osc/osc_request.c
>     +++ b/drivers/staging/lustre/lustre/osc/osc_request.c
>     @@ -552,14 +552,12 @@ static int osc_destroy(const struct lu_env *env=
, struct obd_export *exp,
>=20=20=20=20=20=20
>      	req->rq_interpret_reply =3D osc_destroy_interpret;
>      	if (!osc_can_send_destroy(cli)) {
>     -		struct l_wait_info lwi =3D LWI_INTR(LWI_ON_SIGNAL_NOOP, NULL);
>     -
>      		/*
>      		 * Wait until the number of on-going destroy RPCs drops
>      		 * under max_rpc_in_flight
>      		 */
>     -		l_wait_event_exclusive(cli->cl_destroy_waitq,
>     -				       osc_can_send_destroy(cli), &lwi);
>     +		l_wait_event_abortable_exclusive(cli->cl_destroy_waitq,
>     +					       osc_can_send_destroy(cli));
>      	}
>=20=20=20=20=20=20
>      	/* Do not wait for response */
>=20=20=20=20=20
>=20=20=20=20=20
>     _______________________________________________
>     lustre-devel mailing list
>     lustre-devel@lists.lustre.org
>     http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
>=20=20=20=20=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqCKhIACgkQOeye3VZi
gblCHQ/+I60dZOiY1hOwZ6O9mlcKtDhGScjTcvtCYFyzO3wBvmFaF5QInluyhC1U
9+ES0MJBFSGtDSXrkziKv4CVbUgRSCg9tjd0MVYOqDYu5ID+CWHeQvRhYHoYN1Rg
Pb7QUxq7VT0hUAOImFqFZI24RJN5gG5abH0SxGZtM7TwZvjGpPhF/m4aOaQhBiBN
2pPg1IXpP6Lmk4kk7xKCI0mFj17XTIogQG9qVN5146C2K3lYth1acVb9ySyeWFVT
xQWAX/+f1U3mrKUuRDzY0tjfnnpZvdVQwIYAggK5uocH0Cai9b7Ob1Xo9tF3AY8U
czwJ6KBEJsqtryCas6nceaU15TUnUnw+5JYhjIPHaqaOS2Bm/VtYu/XjAqPdS2kD
DlSzGxeTtgtcOpjtyCv+tB3+uEtsVvFqiTmf66GA3lTs/PSwUpoqs1BqV5cFSovv
JUVn6WX4fNmNkqeVjsNXDNLsOpSCH49/klChhR5w4yXKwKjk4Lq2RDlT/d4czy4w
jMmu8GHVHuuWZyINVTTpnqNKa9zyBFf20xXiV+5ZidjHyDsjtitNFHopKtu2slne
Lka0xtAjoszO6EPugUsIgup3k/KVdjnE3MJAUuYoUwBmmIEXvF5t/p9pglaPFRCr
38gpYwoGJp6uKC/EVhHktzmHGaJVGAqezrk7pa0ThwSK3teGaKs=
=F46S
-----END PGP SIGNATURE-----
--=-=-=--
