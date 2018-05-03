Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZrGsaX3PGvPwuEn99iyz2y1+wNbKgDvbibB2+9y09AUrE/9Zw/GrjCYUGI4h/qbID9PXSdM
ARC-Seal: i=1; a=rsa-sha256; t=1525390014; cv=none;
        d=google.com; s=arc-20160816;
        b=c5VSjhsif6KWAsKW6+7B4yPBU6fKZpYOmfNBkF7o2eRobFCU6yG0uqO9iBn0xfK2lr
         sLaKuA5vhI/CNzQUuzrB+9Z/Us9VBB6mj/ZTt+WXel7Bf1eNYX2eR4f0iPVlCE0q7Nfe
         Bi9B3dTWQ1UDsTpFaBnMNBerFGhS5U6+gOVCKKwbBmhnl59ohYY7p57hDrZoJkYuhAET
         nm/trgtz81mR1ql7VYsvz4CbV6jL81V5cH77FdJpqrCRRLageJxg+pwyY3WchFPl+ofA
         hsU6IG+6kx52SdaHFICGX4Ruq9MF1kdbbN2CtBfNMeWhCwyNJlDRPPRrpQD2zRgLGvBD
         HILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=8dTrA0nYBiFyOWYZH1l/nkcZK36dSAHhQuUEHKz1ucw=;
        b=hDffK8XrQoWxhlwisyBFoDx9jY2ZxZE+oJ5c9Kvx8EbfyXIP6/dfrXPvnCPfIy4rLz
         4ZLdyslrtEHYu7v7uw6UoXYfn9BVxe96y7LQOASy6sk/LG3BfV8DzkpJJs4bDHKOuw0I
         IxVaSb3oYpdgXQD42LRA0KKyTd4HPAL8z2RNB9t9gFTUMvc6HJHTlkr9rVB3JVfdz0wE
         2lsjVSG7jELkfSzRPpr4bNHuyxKFKudxKW91K/V15b9EHUQCGaWwH/LMarQAkte6rd7m
         yXo+j6rIfwHdUEzhw/xKSMwA6GLWBCLO8XCY7wjArv97cgOJlTjt3C27qKHzl6enz/JZ
         9rvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: David Laight <David.Laight@ACULAB.COM>, 'James Simmons' <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>
Date: Fri, 04 May 2018 09:26:36 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Lustre
 Development List" <lustre-devel@lists.lustre.org>, Li Xi <lixi@ddn.com>, "Gu
 Zheng" <gzheng@ddn.com>
Subject: RE: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key to rwlock
In-Reply-To: <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org> <1525285308-15347-2-git-send-email-jsimmons@infradead.org> <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com>
Message-ID: <87po2cfhhv.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599377573675786314?=
X-GMAIL-MSGID: =?utf-8?q?1599487359677424866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 03 2018, David Laight wrote:

> From: James Simmons
>> Sent: 02 May 2018 19:22
>> From: Li Xi <lixi@ddn.com>
>>=20
>> Most of the time, keys are never changed. So rwlock might be
>> better for the concurrency of key read.
>
> OTOH unless there is contention on the spin lock during reads the
> additional cost of a rwlock (probably double that of a spinlock)
> will hurt performance.

That's roughly what I was going to say - rwlocks are rarely a win.
I think the second patch which caused the lock to be taken less often
would have a bigger impact that the switch to rwlocks.

However I suspect a better approach would be to investigate some sort of
lockless solution.
I think the use of the spinlock in lu_context_key_register() could be
replaced with a careful cmp_xchg().  I'm less sure about
lu_context_key_degister(), but it might be possible.

>
> ...
>> -	spin_lock(&lu_keys_guard);
>> +	read_lock(&lu_keys_guard);
>>  	atomic_inc(&lu_key_initing_cnt);
>> -	spin_unlock(&lu_keys_guard);
>> +	read_unlock(&lu_keys_guard);
>
> WTF, seems unlikely that you need to hold any kind of lock
> over an atomic_inc().
>
> If this is just ensuring that no code holds the lock then
> it would need to request the write_lock().
> (and would need a comment)

There is a comment - that patch showed the last 2 lines of it.
This is for synchronization with lu_context_key_quiesce().
That spins(!! calling schedule, but still... not good) until
the lu_key_initing_cnt is zero while it holds the write lock.
Then it is sure that the code protected by this counter isn't
running.
I'm sure this can be improved!  I would need to study it carefully to
see how.

Note that I don't object to these patches going in - if they provide a
measurable improvement which seems likely, then in they go.  But I
hope the code won't stay like this long term.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrmqwACgkQOeye3VZi
gbmdGxAAgBcMxEEM49WNOVfIDnNije4MPuD0Qo2e32hwQFXE2EvBDFWro1zoDKCE
QdsUFeOurwjS9frS7wjy9QiJEVP22S5ePskSiOEf0bjJ3pq0mLn+J0PT+vi/vtlP
Z+LmwS80/uQqnxf9bfHd4dExoQiSQMbU52U93Pm3ByKt86XVaktM9ACFtTbfqeVb
LpxMexL7X/moYXHjB3aeohVKsfLLxPQ5eVh0O8LTogugN8zbOPbYDxUKJ21Dsk/O
8ja1vwuvfntMePMZX0tW2LOcUVu/GX5lZmSKn7FmHnVtNKlL2BeUx/XHGsWXZe24
+jPUZZxFlYEiZJjwW9ucIQVQzWCHlB/9iHE85y6fLyrB12QjY9qboJCnUv+MSGik
r5l9HLQ+3WUaR9F1YMK2sY7I/YwHop5ayXQuqba5Hbw8NSB1nr7vW0ccBNQTB3pY
RBfqHovEeCRqIKs5uFJadLq5E/8hEo43EqD0TGmY6N4WwBXvO50T1eEw2bKqAq62
zdW7Rlr+Cad533tASCWvsc5DDGC7ZzISnZtxUUXdyM6fOMpcOGtX9McaqgUP8mZG
HIYrt0Ms6qOmCq/O4wzX6Zjf1G4GzcjrGWvYYeTB3lCMdoeEHChSsi7giAcrVD3G
c7xoUOq8RwSViCc4SBW18T9yjQ+TjlpRRyiWWPOBrFhS8ZC3rDo=
=9e77
-----END PGP SIGNATURE-----
--=-=-=--
