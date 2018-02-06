Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AH8x227ajxJHtOOlPphhNhjE/i2kl5FISc5NNp9T35jnvSpXBORp8yRE1gtIXYLF4JDrZWaX8C5B
ARC-Seal: i=1; a=rsa-sha256; t=1517943646; cv=none;
        d=google.com; s=arc-20160816;
        b=TQS2wNBpcVGdBM1XIjzQoYyVSx+BdcNHZXOG33ti6j2YwJs+hHm7y0SFjcRu4FYEYs
         gggVnDbix4qWO+mMuIs90A7EyV6wTSAjE59B66UJ8QZNNT1cZAsBlR9/GuI7HLbcgTCQ
         PiSGP287iaPn9qzA0BCF3OSxyaOPb0Om6J5O/sLS13+i6kGBU+gGQq7GnU8Nv4FS3rQH
         h+7uw+TPjkAMcpavVBuOu3NDoQ21LgD5620Ph126WXFK0+KUvPfC3kJmh5d/J/h8P/zm
         0vGdgY/zQTaWVQ4PFuwA1HrfBYkrmvnuhXvFN5ceunpX58a+dhqti0RrLzOaolmVfnrz
         xejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=3grscKlb0FGCMg2sAl+UM4hSFdqbQL0ryxJA+tOk2Z0=;
        b=kca4zGgreIXFc1mgliGL+00Eqbynuwa1K3hcT8kpTdvOI4rEwCTNAnxCqSFY65wGMI
         mUuh2DmJ3gUhy1vJBncBKg7HvXEmRVO9ocBFVli3LlWgErPxOP+UWn2Mn1RyKWLBykd0
         J1iRkWYMTwbnqRDMyq0fAVdbJ01d3LNEJUXVGH2M+9rA9dK3M5ADxYKZnWnXtzlOETF0
         tU2nEm9JFiwG/nuNWGKDVJTQDbhkJDJOFUK0CwiJodEVd5+u6H4UhU7d2eCvUuFr5s33
         Su/+BW9cKfnWL7LOH3gj2CpKmCoGx0XZ6r02ByEWb/2kYMd4PGaZGiCx9csiQ3cuCg6Q
         luhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Tue, 6 Feb 2018 20:00:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Bin Liu <b-liu@ti.com>
Cc: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180206200024.18d40735@aktux>
In-Reply-To: <20180206184605.GA3992@uda0271908>
References: <20180127083403.928-1-andreas@kemnade.info>
	<20180206184605.GA3992@uda0271908>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uiQa17RxlFNEvXCvVHH0J_w"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590733890514552620?=
X-GMAIL-MSGID: =?utf-8?q?1591679277021779215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/uiQa17RxlFNEvXCvVHH0J_w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 6 Feb 2018 12:46:05 -0600
Bin Liu <b-liu@ti.com> wrote:

> Hi,
>=20
> On Sat, Jan 27, 2018 at 09:34:03AM +0100, Andreas Kemnade wrote:
> > On dm3730 there are enumeration problems after resume.
> > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > bit is not set. If it was set before suspend (because it
> > was enabled via musb_pullup()), it is set in
> > musb_restore_context() so the pullup is enabled. But then
> > musb_start() is called which overwrites MUSB_POWER and
> > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > enabled and the device is not enumerated. =20
> =20
> Do you see the issue with the v4.15?
>=20
Yes. Tested without other patches.=20
It was also there in earlier kernels but I had not had motivation enough
to debug.

So maybe it deserves a CC: Stable


> > So let's do a subset of what musb_start() does
> > in the same way as musb_suspend() does it. Platform-specific
> > stuff it still called as there might be some phy-related stuff
> > which needs to be enabled.
> > Also interrupts are enabled, as it was the original idea
> > of calling musb_start() in musb_resume() according to
> > Commit 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend,
> > enable them on resume") =20
>=20
> The logic in the fix makes sense, and I do see the same problem with
> AM335x on v4.9 kernel, but it doesn't happen on v4.15. I haven't checked
> if there is anything after musb_start() which sets MUSB_POWER_SOFTCON
> bit.
>=20
Well reconfiguring gadget from userspace helps.

Regards,
Andreas

--Sig_/uiQa17RxlFNEvXCvVHH0J_w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp5+0gACgkQfb1qx03i
kyT3jhAApShmP7qSeGKNXBmdj/K33GgwzbTez4TZNBRkKfLI6AWeqOsEvGIHayX6
0pEmoWiQGYeYP2vXtFoOX7J83hXGamH2L0KCaSLRlHQO/6CNjTRxy7wj/0/NlB9m
3gvHw9FmaoIFUuIRENZtEOv78AtqRVU+kvPWee15sr4jk+NiVitheTxE2KfgWx3a
Qg40TEj/y/bRKEZDLTTJ9XeOYY5yn9QcBtVKDQ2QaiS/co0TtaxQLV+UOrDWc9Xv
owkO6f44Ve8t12AxyGO2QZBi8WuioL7zhwh5+0yTA6CgCWCeepiAdXIUtX5NguD4
GlzHNujMq3ereYoI1pvUI6gOJ7xMJQKQVYwYSZw2hFADQCaRi/4IKPlRzqmEHqsh
qiE9AI0ttO/Lt52TeJoJZ/9if00/lsplHMWaLDeQnfMY+qyEJlbRNUB+ZC6G/HM3
gwnIqum9W/Cn4Lc57A3Ko7BW45liGHGD08TOA9warUd6St9VvJpv3v0FEFRy9vEv
N9XtRD6J5GhupnJubis5YTuSVTL/O2B+H9EgzC5r/dvy+0REiqnGga8/0L2x00/s
8YmyIccsQJ8ZM+ypq+M97ZjCQx7133Tn/JDfbstspfZEDQnMLbaxGjI63Yi75VLY
KGyAjWDrPr98JNrBc6/ZX/L2WV12rEk+OWBeGSA83u2s7FRB5O0=
=UDKf
-----END PGP SIGNATURE-----

--Sig_/uiQa17RxlFNEvXCvVHH0J_w--
