Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZrE4b8Gm5PL7A3sIFmOP6PuVsnQy/JlLySkQ9Jd2X72PrzgrnHzDujZ4bAfXZqMsLCXKOFq
ARC-Seal: i=1; a=rsa-sha256; t=1525393846; cv=none;
        d=google.com; s=arc-20160816;
        b=z0yLYVwuAVXzwHd3vcnFAWXxW6FjeA0M+KeCSAo3m+affrkTYetJCueIwnDXleOL6p
         yvK/rP0Sr0iRM+ej+/npMEiGbR+pNEEQzloaUVtazEkf1Da/Fcrh7fHY2EI+J2fpvzbX
         ByDY0ieP18jGEgqU0T2jU2tPF2jvit57X+FlIU3xqXtF72L8nGRHHQ/q67DtRxMnvcf7
         3/Mk5UcTh7RwatzBWa3jUybDeB9aSaRCTK7oQK58FAdYuqkjRyJmOCmJAhTCa7xVqK9o
         swnNsdiLQt9OkOwnPDTKavkM9QcKrrxrmwJ4c9qTRbihN8OPe2epIRkr962rEKBhYdBU
         3vTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=Y7yQScbF6WHB72Y5jzhHhw+i4fYXtZAEx04GpB97yic=;
        b=UvNZ9y1v6ouY1AZbjXVKO5VD7MqPp5p6AS49nuuk6CAAUo+T5Fu4ER/fnoIBE0lgrd
         uPRNPbClZhz+OMUajfDEFC6H73G9axI9ZpDW7KcsSPVCUPum7zjBw6z0e3NuR3x2PPHI
         tHYIgETHCYbfzU8uNKKzlkxdFbnaOckd/F+TFtbO33UKGPiBlTzYAVmn6z4S/i7PP1r2
         MFJHGWYze8IsxqWlu15SrA+eS27vEsnRbA3c3Zn+YI1OL9pwG1CKh9vk0dkuYCQhPfeN
         IqBf1qaF4LzZDAS8gB/dCMrdnYNLEzKWFxHtEg4NNUxzS1nN0HJOs80O2PH6mrYIkVre
         H72Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>, "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Fri, 04 May 2018 10:30:33 +1000
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 04/10] staging: lustre: lu_object: move retry logic inside htable_lookup
In-Reply-To: <alpine.LFD.2.21.1805021914550.24633@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675897.17843.15112214060540196720.stgit@noble> <EFC6D018-5FB5-4902-AE7A-B91A5E0148FE@intel.com> <alpine.LFD.2.21.1805021914550.24633@casper.infradead.org>
Message-ID: <87fu38feja.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232342096971957?=
X-GMAIL-MSGID: =?utf-8?q?1599491377033817029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 02 2018, James Simmons wrote:

>> On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>> >=20
>> > The current retry logic, to wait when a 'dying' object is found,
>> > spans multiple functions.  The process is attached to a waitqueue
>> > and set TASK_UNINTERRUPTIBLE in htable_lookup, and this status
>> > is passed back through lu_object_find_try() to lu_object_find_at()
>> > where schedule() is called and the process is removed from the queue.
>> >=20
>> > This can be simplified by moving all the logic (including
>> > hashtable locking) inside htable_lookup(), which now never returns
>> > EAGAIN.
>> >=20
>> > Note that htable_lookup() is called with the hash bucket lock
>> > held, and will drop and retake it if it needs to schedule.
>> >=20
>> > I made this a 'goto' loop rather than a 'while(1)' loop as the
>> > diff is easier to read.
>> >=20
>> > Signed-off-by: NeilBrown <neilb@suse.com>
>> > ---
>> > drivers/staging/lustre/lustre/obdclass/lu_object.c |   73 +++++++-----=
--------
>> > 1 file changed, 27 insertions(+), 46 deletions(-)
>> >=20
>> > diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/driv=
ers/staging/lustre/lustre/obdclass/lu_object.c
>> > index 2bf089817157..93daa52e2535 100644
>> > --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> > +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> > @@ -586,16 +586,21 @@ EXPORT_SYMBOL(lu_object_print);
>> > static struct lu_object *htable_lookup(struct lu_site *s,
>>=20
>> It's probably a good idea to add a comment for this function that it may
>> drop and re-acquire the hash bucket lock internally.
>>=20
>> > 				       struct cfs_hash_bd *bd,
>> > 				       const struct lu_fid *f,
>> > -				       wait_queue_entry_t *waiter,
>> > 				       __u64 *version)
>> > {
>> > +	struct cfs_hash		*hs =3D s->ls_obj_hash;
>> > 	struct lu_site_bkt_data *bkt;
>> > 	struct lu_object_header *h;
>> > 	struct hlist_node	*hnode;
>> > -	__u64  ver =3D cfs_hash_bd_version_get(bd);
>> > +	__u64 ver;
>> > +	wait_queue_entry_t waiter;
>> >=20
>> > -	if (*version =3D=3D ver)
>> > +retry:
>> > +	ver =3D cfs_hash_bd_version_get(bd);
>> > +
>> > +	if (*version =3D=3D ver) {
>> > 		return ERR_PTR(-ENOENT);
>> > +	}
>>=20
>> (style) we don't need the {} around a single-line if statement
>
> I hate to be that guy but could you run checkpatch on your patches.
>=20=20

Someone's got to be "that guy" - thanks.
I have (at last) modified my patch-preparation script to run checkpatch
and show me all the errors that I'm about to post.


>> > 	*version =3D ver;
>> > 	bkt =3D cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
>> > @@ -625,11 +630,15 @@ static struct lu_object *htable_lookup(struct lu=
_site *s,
>> > 	 * drained), and moreover, lookup has to wait until object is freed.
>> > 	 */
>> >=20
>> > -	init_waitqueue_entry(waiter, current);
>> > -	add_wait_queue(&bkt->lsb_marche_funebre, waiter);
>> > +	init_waitqueue_entry(&waiter, current);
>> > +	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
>> > 	set_current_state(TASK_UNINTERRUPTIBLE);
>> > 	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
>> > -	return ERR_PTR(-EAGAIN);
>> > +	cfs_hash_bd_unlock(hs, bd, 1);
>>=20
>> This looks like it isn't unlocking and locking the hash bucket in the sa=
me
>> manner that it was done in the caller.  Here excl =3D 1, but in the call=
er
>> you changed it to excl =3D 0?
>
> This is very much like the work done by Lai. The difference is Lai remove=
=20
> the work queue handling complete in htable_lookup(). You can see the=20
> details at https://jira.hpdd.intel.com/browse/LU-9049. I will push the=20
> missing lu_object fixes including LU-9049 on top of your patch set so you
> can see the approach Lai did. Form their we can figure out merge the=20
> lu_object work and fixing the issues Andreas and I pointed out.

I think I did see that before but didn't feel I understood it enough to
do anything with, so I deferred it.  Having the patches that you
provided, I think it is starting the make more sense.  Once I resubmit
this current series I'll have a closer look.  Probably we can just
apply the series you sent on top of mine - I might even combine the two
=2D and the think about whatever else needs doing.

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrqakACgkQOeye3VZi
gblbrBAAhZRCDfMp/zZyYxW2xDyaYCBjAniHk3GZqyMXTRWVjpGAQEes/XGliDAo
Q+ASwkPY5ip3d2u9IeriYR+u0CVYSl1p17qQ9ho9cp88pnRktOnSXzpnC4+gyVcp
vr5mPcs1X522owIz47lT1nxbNK78hdfnxnRb1wnSrTuZ5I+NHrOJOjmNDuU549z/
3CLC7UGppLB+slPLqzNXpa6JNItA7yb+/1ek5ZSyOOgDZKu/l8mJdlRfGwRuOz3R
q7a5dNgMlh1nJ00U6VZ7bD1v3zmyQJIRd5hsKhnVv0YW1bMsMSQa+BHr48YZSmiq
RUAGr2I8iR6E0S6DByWlKSUgu7F2RVKiLIPNUdFckrHGnDbC3YfnTOLOs3UxJksJ
LwWUZeUbnB576+FdmaB7haEW35EF0ea0JgfyjplUbeUnwm9CuOgH737/kiGU2OQR
tBXeJEoKuFM4KWrTQrEea5hjqpTV5T0ldzyAV5JavMeiilnqHsRnoczvM8whwLWH
lmhZlqD5TG0B5MaY5dIyPx9K/F2OlxfHvuNEiDXed1TdZYt947czJGG93xu+cLS/
nrpLgdVLNmn5yyTbHsZ49OJnY6bo+uK2tu4cyoJyrVreOAZhcWY3LS40QvHufCmh
CLEYPxb9VCdy6rNzVosN5kHJqGTPFe3WJF5WMOMdeLZjgpIQqkE=
=2+7q
-----END PGP SIGNATURE-----
--=-=-=--
