Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZofk1Ad1pWPQoKOpMpiSAAC4scSpS7wMC9lQ1mjuSCOQmE+N5im4sJM7JD3f0Vy/nsyZrYS
ARC-Seal: i=1; a=rsa-sha256; t=1525395226; cv=none;
        d=google.com; s=arc-20160816;
        b=kuyaHxFJfXQq/Ddse63VetjjJeaiHsf37eDPCTcOIKYLZtqe2I+mMJVqtwHl0gEaCo
         36/3EZfQKgfgzVgCGoKMfM3Z861Q7qvrNbPeSQ/AnzUV7khTuvgX+EU/AC4QkxZ1YNW1
         2xA+rP/gmHn7IJ4hHyOc7A9Vs4krk2skOioW636onT70qu6HXt0c4oHVpp0ogZQklqwF
         +a1t05XTD+RVFXZ+DcOCATMlOG9+LeaLFWf2kODVi7xWDwpDxPrLDuSwj0OF8MdgXRmA
         68lM+f0Y+IXPZ2ObG24vIJAx07EtWZ+63cf9dShDYi0E9K6p16bw9YHQdYqWUK9awknF
         PIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=rpXgPUjm9QuBePUuYPsOh0va7n6tfbCWoZ0l913XCzg=;
        b=gk4bH465tgNv0YCMvnzK5VjFMRNknewgiNE60aikGrKwkrLRgZB5y8e5n5ItMNMfm8
         ni6lo6WzuwkIAgUWDO/61ATHb4X5GJw/Ygt+7UMvbSPjZJ7wNsew/VjDOMkcVEMmnUgf
         WUIhkGbq1hvYdc6HxNPly+yc+eMIoIRQ7DuD6HrdLeLMq09ix64QsPfMg447Xt5uoQIh
         GS9VLaAwtTBPIBuqWcx6ht1qvckGt9ELWw5JlZRCndBCILML34uzqnD68h3TCOMQEzcC
         OInIs0r4+oy2cOriVibld5JfzRd3wARDwoAuNK49JSiTBpkebvl80EejKFFi91atf686
         VFog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>, David Laight <David.Laight@ACULAB.COM>
Date: Fri, 04 May 2018 10:53:36 +1000
Cc: James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Drokin\, Oleg" <oleg.drokin@intel.com>, "Siyao\, Lai" <lai.siyao@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>, Li Xi <lixi@ddn.com>, Gu Zheng <gzheng@ddn.com>
Subject: Re: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key to rwlock
In-Reply-To: <55458B75-4105-4F4F-BB50-3D506611AB24@intel.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org> <1525285308-15347-2-git-send-email-jsimmons@infradead.org> <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com> <55458B75-4105-4F4F-BB50-3D506611AB24@intel.com>
Message-ID: <87a7tgfdgv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599377573675786314?=
X-GMAIL-MSGID: =?utf-8?q?1599492825243589305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, May 04 2018, Dilger, Andreas wrote:

> On May 3, 2018, at 07:50, David Laight <David.Laight@ACULAB.COM> wrote:
>>=20
>> From: James Simmons
>>> Sent: 02 May 2018 19:22
>>> From: Li Xi <lixi@ddn.com>
>>>=20
>>> Most of the time, keys are never changed. So rwlock might be
>>> better for the concurrency of key read.
>>=20
>> OTOH unless there is contention on the spin lock during reads the
>> additional cost of a rwlock (probably double that of a spinlock)
>> will hurt performance.
>>=20
>> ...
>>> -	spin_lock(&lu_keys_guard);
>>> +	read_lock(&lu_keys_guard);
>>> 	atomic_inc(&lu_key_initing_cnt);
>>> -	spin_unlock(&lu_keys_guard);
>>> +	read_unlock(&lu_keys_guard);
>>=20
>> WTF, seems unlikely that you need to hold any kind of lock
>> over an atomic_inc().
>>=20
>> If this is just ensuring that no code holds the lock then
>> it would need to request the write_lock().
>> (and would need a comment)
>
> There was a fair amount of benchmarking done for this that shows the
> performance is significantly improved with the patch, which can be
> seen in the ticket that was referenced in the original commit comment:
>
> https://jira.hpdd.intel.com/browse/LU-6800?focusedCommentId=3D121776#comm=
ent-121776

That does surprise me.  The only places where the lock is held for read
are very short - clearing a few fields or incrementing a value.
But numbers don't lie.
I wonder if the next patch would have had just as big an effect. Taking
and dropping the lock 40 times is not likely to be good for performance.

Thanks,
NeilBrown


>
> That said, it might be good to include this information into the
> commit comment itself.
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrrxAACgkQOeye3VZi
gbm6HQ//dCdH9MwD3kUjEKaLymrwQR/nuNHP4IEppOJAlmi0vbOHR1GNcMWsLDeU
AaYtGyi7e+7sxpo7OihX7+VGKVK3XrVnVoFzrJ3X9Hd5EFfx6ikGKqlQ08FpIskX
8juWuCAvqx92SRbqN7+jX0KtYqeH5A+E8UP//t/eks771+Q3Z+kZEmKW4s98WjOS
ABruCPT2Rf7y7dc4rReECjX07ODSYktYEY0TPkQQUGjn8GiTpX2h7ZX3bd+Bisec
gXUNtk+jMaQThIUmuE1KP6eXjIv/w2d9fADLadh/qk10nV5gkkHGXjodvvIx69es
5YrEwn4azzYEEWNkDPX9otRJIvLrnvrPg46g/15RjIT9n3si8Hn8D6ld154/AaxH
5w9aQwVS2Q5tR5eAUfTxfJI5KMEI42tBEEQd9RZxRqlrfpbgwNKk2B5cZ6sQpHjg
pVqhaMgXmJ9+5ApbHOQigtF3GCe0AmzSngklGNwBr6ZEhlY8Z4hCtPLlFFdnI+LE
TTE+i9ixFj0G1dF0TZ/rt0laQNCflobgUA9SCc1I6C+nazaX8kpdS2VjxvpWrVM+
JkJihlmu/Eltce0xToTcXgqoAnrobYQ17/Hs5A1c0/xVO+q14/MlUMWc9YnI2Kp2
86fO/glP3vMiN/PZVPzfTYKGlUbInGOBieXKC2KBScMyKfm8/vc=
=zv+U
-----END PGP SIGNATURE-----
--=-=-=--
