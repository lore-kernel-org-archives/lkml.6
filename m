Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeD0NkB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:40:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51791 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758357AbeD0Nj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:39:59 -0400
X-Google-Smtp-Source: AB8JxZoqidc4QMSg+wV7b27gjeIr0oebos3i9GNiq7wM2iNX+EjL1MZTAnWPuxOlKH0gkIKwwFl4nQ==
X-ME-Sender: <xms:KSjjWmwIju3v5zIJgzcd3mubHOaH2jmn1FtRPUYlId-Rh7ArBFRkBA>
Date: Fri, 27 Apr 2018 21:44:14 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, jlayton@kernel.org,
        bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
Message-ID: <20180427134414.wxq3h24vhzeoeyul@tardis>
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
 <20180417140110.GB21954@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3zpf46irlveq7scd"
Content-Disposition: inline
In-Reply-To: <20180417140110.GB21954@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3zpf46irlveq7scd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 07:01:10AM -0700, Matthew Wilcox wrote:
> On Thu, Apr 05, 2018 at 02:58:06PM +0300, Kirill Tkhai wrote:
> > I observed the following deadlock between them:
> >=20
> > [task 1]                          [task 2]                         [tas=
k 3]
> > kill_fasync()                     mm_update_next_owner()           copy=
_process()
> >  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        wri=
te_lock_irq(&tasklist_lock)
> >   send_sigio()                    <IRQ>                             ...
> >    read_lock(&fown->lock)         kill_fasync()                     ...
> >     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> >=20
> > Task 1 can't acquire read locked tasklist_lock, since there is
> > already task 3 expressed its wish to take the lock exclusive.
> > Task 2 holds the read locked lock, but it can't take the spin lock.
>=20
> I think the important question is to Peter ... why didn't lockdep catch t=
his?
>=20

I think the following will help lockdep to catch this:


@@ -570,7 +588,14 @@ static inline void print_irqtrace_events(struct task_s=
truct *curr)
 #define spin_release(l, n, i)			lock_release(l, n, i)
=20
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, =
i)
-#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, =
s, t, NULL, i)
+#define rwlock_acquire_read(l, s, t, i)				\
+do {									\
+	if (!IS_ENABLED(CONFIG_QUEUED_RWLOCKS) || in_interrupt())	\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+	else								\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+} while (0)
+

However, this will break several self tests in lib/locking-selftest.c,
because we used to treat read_lock() as recursive read locks for all
callsites from lockdep's viewpoint.

Besides, the above change will bring an interesting challenge for the
recursive read lock deadlock detection work that I'm doing:

	https://marc.info/?l=3Dlinux-kernel&m=3D152345444100825

I will explain that in the thread of that patchset and add you and
others Cced in case that you're interested.

Regards,
Boqun

> > -		spin_lock_irq(&fa->fa_lock);
> > +		write_lock_irq(&fa->fa_lock);
> >  		fa->fa_file =3D NULL;
> > -		spin_unlock_irq(&fa->fa_lock);
> > +		write_unlock_irq(&fa->fa_lock);
> ...
> > -		spin_lock_irq(&fa->fa_lock);
> > +		write_lock_irq(&fa->fa_lock);
> >  		fa->fa_fd =3D fd;
> > -		spin_unlock_irq(&fa->fa_lock);
> > +		write_unlock_irq(&fa->fa_lock);
>=20
> Do we really need a lock here?  If we convert each of these into WRITE_ON=
CE,
> then=20
>=20
> ...
> > -		spin_lock_irqsave(&fa->fa_lock, flags);
> > +		read_lock(&fa->fa_lock);
> >  		if (fa->fa_file) {
>=20
> file =3D READ_ONCE(fa->fa_file)
>=20
> then we're not opening any new races, are we?
>=20
> >  			fown =3D &fa->fa_file->f_owner;
> >  			/* Don't send SIGURG to processes which have not set a
> > @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *f=
a, int sig, int band)
> >  			if (!(sig =3D=3D SIGURG && fown->signum =3D=3D 0))
> >  				send_sigio(fown, fa->fa_fd, band);
> >  		}
> > -		spin_unlock_irqrestore(&fa->fa_lock, flags);
> > +		read_unlock(&fa->fa_lock);
> >  		fa =3D rcu_dereference(fa->fa_next);
> >  	}
> >  }
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c6baf767619e..297e2dcd9dd2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct fil=
e *filp, struct file_lock *fl)
> >  }
> > =20
> >  struct fasync_struct {
> > -	spinlock_t		fa_lock;
> > +	rwlock_t		fa_lock;
> >  	int			magic;
> >  	int			fa_fd;
> >  	struct fasync_struct	*fa_next; /* singly linked list */
> >=20

--3zpf46irlveq7scd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrjKSoACgkQSXnow7UH
+ri+1QgAiZYOJzkWmlfFOYqSA/QP8sOKdfW52Naa3ZePpoTjh18Sm7pAIs6+VP1H
UuSJQDKVhIRRpFWw0Cha8A/+kmcvDgXiRm2xHL2v8GN9Seys/weaf05SNof3tUeu
DES20A3IrEaN8t+7ax2XFr1viIJ43CPzqYTfMGeIMgf9bfqNc/cP2iY30nONot3y
MzjM7N/BQ/u0nuNjljJERpiJc0q4KbWjQfvGkwnuA4eh6eTbebu25hUwspmrpNbe
ivNR+Wwf3qWH/dnR/dFvW0rbvXlmri8h4uPVDnCFvpnDHk31crtQzfOjNmxWhjvD
CMfsAQnSDaHYRDg32JJZhmNYpFIZoQ==
=CSbS
-----END PGP SIGNATURE-----

--3zpf46irlveq7scd--
