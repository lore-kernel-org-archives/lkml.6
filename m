Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZr4IKdmHF9Vn8Ar/wrNzAueKjdo2IrqHCsvuLZw9KEab7vSK9XSO/zQ/H35XmwCGzo8YEaw
ARC-Seal: i=1; a=rsa-sha256; t=1525012204; cv=none;
        d=google.com; s=arc-20160816;
        b=T/IW585muXxi//3VCnE4Fis6MBX1ICFj+qqruF2ZaOfvxXrUhiqcHeTM8dOO36ywVn
         VpuZ3LeTSJ9rQKFrfKnGvQ9Q2KRi0oaZSaU1xbabPxTMqzhPFKIFqNTcNElx5N/Ptdj4
         mdzZR7masyrxutCgyigehmqfBvcTba6YzfhcMiI4uaVpPeNaCXOklJDdPz7pRF+AI/s7
         A3Oapfm7Fg62LLGjo3K6f4JMpEnRrZ6P8G2yiWIyuODNoTc0+BAHH6YjLlypckZBloun
         dyH61BpnopnRq6jKVlmgHaFjsioh7jjvkxpomNTEoB65zQvmZDhEScGALcbrssY1t7Ez
         NVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=K56ULmRtuBdAWxi1/Qxk2kPM5KT+l6XXPTf1x2vvHV8=;
        b=kwqUNnjRIJoQFleNuhIDc0kAhRAPxJbEtYBT1SSEcKx/G349QQUheeIZ+OoHtq9HeJ
         nJuMHBjeqyN9xo8jWcrbF5tzZht1bFvuoMVkgjhlPZdhCEke58/pss+4C8HYh4MspWbw
         2XMk8YdRmnzfm4dXKZeallH33qLyCqkasIMuti2in1fArl8PQWO0jSoWnuN3QiQ4KQnh
         gN2fpHvxr8SrEVsfqY282mqFHuCX+1Irj2UlZ1vndABwEhNp79ZLOxIAxIyZ6oYLiwY4
         KASOEv2O6odFqfVgs7ZzZqr1GguXRsc/s0KsGkId0kOVauZIPc1itRFoEC139fm+Zoxi
         CW7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Sun, 29 Apr 2018 16:30:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, geert@linux-m68k.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
Message-ID: <20180429143002.GC13475@amd>
References: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598715584055641513?=
X-GMAIL-MSGID: =?utf-8?q?1599091197155368646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-25 18:59:31, Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>=20
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

Sounds like magic.

> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
> +					loff_t *pos)
>  {
=2E..
> -	srcuidx =3D srcu_read_lock(&wakeup_srcu);
> -	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
> -		print_wakeup_source_stats(m, ws);
> -	srcu_read_unlock(&wakeup_srcu, srcuidx);
> +	*srcuidx =3D srcu_read_lock(&wakeup_srcu);
> +	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> +		if (n-- <=3D 0)
> +			return ws;
> +	}
> +
> +	return NULL;
> +}
=2E..
> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
> +{
> +	int *srcuidx =3D m->private;
> +
> +	srcu_read_unlock(&wakeup_srcu, *srcuidx);
> +}

But you are holding srcu_lock over return to userspace, and somehow I
don't think that's permitted?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrl1uoACgkQMOfwapXb+vLWfQCfec1XrdlLE0AwT0gWMJILdKJP
fLgAoIqn6yp9O1011jbE2eSYNL1XyMHR
=uMnk
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
