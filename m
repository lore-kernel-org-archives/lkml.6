Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B9C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B34E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeKTTqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:46:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48821 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeKTTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:46:37 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3735D8094E; Tue, 20 Nov 2018 10:18:27 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:18:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        timmurray@google.com, joelaf@google.com, surenb@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120091829.GD16916@amd>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
 <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 10:05:21, Vlastimil Babka wrote:
> On 11/19/18 11:54 AM, Pavel Machek wrote:
> > On Mon 2018-11-05 13:22:05, Daniel Colascione wrote:
> >> State explicitly that holding a /proc/pid file descriptor open does
> >> not reserve the PID. Also note that in the event of PID reuse, these
> >> open file descriptors refer to the old, now-dead process, and not the
> >> new one that happens to be named the same numeric PID.
> >>
> >> Signed-off-by: Daniel Colascione <dancol@google.com>
> >> ---
> >>  Documentation/filesystems/proc.txt | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> Moved paragraphed to start of /proc/pid section; added signed-off-by.
> >>
> >> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesy=
stems/proc.txt
> >> index 12a5e6e693b6..0b14460f721d 100644
> >> --- a/Documentation/filesystems/proc.txt
> >> +++ b/Documentation/filesystems/proc.txt
> >> @@ -125,6 +125,13 @@ process running on the system, which is named aft=
er the process ID (PID).
> >>  The link  self  points  to  the  process reading the file system. Eac=
h process
> >>  subdirectory has the entries listed in Table 1-1.
> >> =20
> >> +Note that an open a file descriptor to /proc/<pid> or to any of its
> >> +contained files or subdirectories does not prevent <pid> being reused
> >> +for some other process in the event that <pid> exits. Operations on
> >=20
> > "does not" -> "may not"?
> >=20
> > We want to leave this unspecified, so that we can change it in future.
>=20
> Why can't the documentation describe the current implementation, and
> change in the future if the implementation changes? I doubt somebody

Documentation should describe "contract" between kernel and userspace.

> would ever rely on the pid being reused while having the descriptor
> open. How would that make sense?

I agree this is corner space, but users might be surprised that
keeping FDs of /proc/pid/X would lead to PID space exhaustion, for
example.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvz0WUACgkQMOfwapXb+vJ1PACgmy/iCA1dXVCGclBaPHG6U4Kw
1zMAnjmMZqfNMLsTsMqdWy4mmy/bpC5r
=fvhL
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
