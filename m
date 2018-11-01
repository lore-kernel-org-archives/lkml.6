Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B127205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B127205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeKATu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:50:27 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:52154 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeKATu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:50:27 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 2618B4BAF5;
        Thu,  1 Nov 2018 11:48:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id cdNTyhMREMlW; Thu,  1 Nov 2018 11:47:58 +0100 (CET)
Date:   Thu, 1 Nov 2018 21:47:51 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH v2] Minimal non-child process exit notification
 support
Message-ID: <20181101104750.q23rb3hczx2tzakq@yavin>
References: <20181029175322.189042-1-dancol@google.com>
 <20181029192250.130551-1-dancol@google.com>
 <20181101070036.l24c2p432ohuwmqf@yavin>
 <CAKOZueszfoSM0pxhmuFLOuPmJqSfYXxgutstyCgqxAyoUi4h3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="snyupnd52lalsuup"
Content-Disposition: inline
In-Reply-To: <CAKOZueszfoSM0pxhmuFLOuPmJqSfYXxgutstyCgqxAyoUi4h3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--snyupnd52lalsuup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-01, Daniel Colascione <dancol@google.com> wrote:
> On Thu, Nov 1, 2018 at 7:00 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
> >> This patch adds a new file under /proc/pid, /proc/pid/exithand.
> >> Attempting to read from an exithand file will block until the
> >> corresponding process exits, at which point the read will successfully
> >> complete with EOF.  The file descriptor supports both blocking
> >> operations and poll(2). It's intended to be a minimal interface for
> >> allowing a program to wait for the exit of a process that is not one
> >> of its children.
> >>
> >> Why might we want this interface? Android's lmkd kills processes in
> >> order to free memory in response to various memory pressure
> >> signals. It's desirable to wait until a killed process actually exits
> >> before moving on (if needed) to killing the next process. Since the
> >> processes that lmkd kills are not lmkd's children, lmkd currently
> >> lacks a way to wait for a process to actually die after being sent
> >> SIGKILL; today, lmkd resorts to polling the proc filesystem pid
> >> entry. This interface allow lmkd to give up polling and instead block
> >> and wait for process death.
> >
> > I agree with the need for this interface (with a few caveats), but there
> > are a few points I'd like to make:
> >
> >  * I don't think that making a new procfile is necessary. When you open
> >    /proc/$pid you already have a handle for the underlying process, and
> >    you can already poll to check whether the process has died (fstatat
> >    fails for instance). What if we just used an inotify event to tell
> >    userspace that the process has died -- to avoid userspace doing a
> >    poll loop?
>=20
> I'm trying to make a simple interface. The basic unix data access
> model is that a userspace application wants information (e.g., next
> bunch of bytes in a file, next packet from a socket, next signal from
> a signal FD, etc.), and tells the kernel so by making a system call on
> a file descriptor. Ordinarily, the kernel returns to userspace with
> the requested information when it's available, potentially after
> blocking until the information is available. Sometimes userspace
> doesn't want to block, so it adds O_NONBLOCK to the open file mode,
> and in this mode, the kernel can tell the userspace requestor "try
> again later", but the source of truth is still that
> ordinarily-blocking system call. How does userspace know when to try
> again in the "try again later" case? By using
> select/poll/epoll/whatever, which suggests a good time for that "try
> again later" retry, but is not dispositive about it, since that
> ordinarily-blocking system call is still the sole source of truth, and
> that poll is allowed to report spurious readabilty.

inotify gives you an event if a file or directory is deleted. A pid
dying semantically is similar to the idea of a /proc/$pid being deleted.
I don't see how a blocking read on a new procfile is simpler than using
the existing notification-on-file-events infrastructure -- not to
mention that the idea of "this file blocks until the thing we are
indirectly referencing by this file is gone" seems to me to be a really
strange interface.

Sure, it uses read(2) -- but is that the only constraint on designing
simple interfaces?

> The event file I'm proposing is so ordinary, in fact, that it works
> from the shell. Without some specific technical reason to do something
> different, we shouldn't do something unusual.

inotify-tools are available on effectively every distribution.

> Given that we *can*, cheaply, provide a clean and consistent API to
> userspace, why would we instead want to inflict some exotic and
> hard-to-use interface on userspace instead? Asking that userspace poll
> on a directory file descriptor and, when poll returns, check by
> looking for certain errors (we'd have to spec which ones) from fstatat
> is awkward. /proc/pid is a directory. In what other context does the
> kernel ask userspace to use a directory this way?

I'm not sure you understood my proposal. I said that we need an
interface to do this, and I was trying to explain (by noting what the
current way of doing it would be) what I think the interface should be.

To reiterate, I believe that having an inotify event (IN_DELETE_SELF on
/proc/$pid) would be in keeping with the current way of doing things but
allowing userspace to avoid all of the annoyances you just mentioned and
I was alluding to.

I *don't* think that the current scheme of looping on fstatat is the way
it should be left. And there is an argument the inotify is not
sufficient to=20

> > I'm really not a huge fan of the "blocking read" semantic (though if we
> > have to have it, can we at least provide as much information as you get
> > from proc_connector -- such as the exit status?).
> [...]
> The exit status in /proc/pid/stat is zeroed out for readers that fail
> do_task_stat's ptrace_may_access call. (Falsifying the exit status in
> stat seems a privilege check fails seems like a bad idea from a
> correctness POV.)

It's not clear to me what the purpose of that field is within procfs for
*dead* proceses -- which is what we're discussing here. As far as I can
tell, you will get an ESRCH when you try to read it. When testing this
it also looked like you didn't even get the exit_status as a zombie but
I might be mistaken.

So while it is masked for !ptrace_may_access, it's also zero (or
unreadable) for almost every case outside of stopped processes (AFAICS).
Am I missing something?

> Should open() on exithand perform the same ptrace_may_access privilege
> check? What if the process *becomes* untraceable during its lifetime
> (e.g., with setuid). Should that read() on the exithand FD still yield
> a siginfo_t? Just having exithand yield EOF all the time punts the
> privilege problem to a later discussion because this approach doesn't
> leak information. We can always add an "exithand_full" or something
> that actually yields a siginfo_t.

I agree that read(2) makes this hard. I don't think we should use it.
But if we have to use it, I would like us to have feature parity with
features that FreeBSD had 18 years ago.

> Another option would be to make exithand's read() always yield a
> siginfo_t, but have the open() just fail if the caller couldn't
> ptrace_may_access it. But why shouldn't you be able to wait on other
> processes? If you can see it in /proc, you should be able to wait on
> it exiting.

I would suggest looking at FreeBSD's kevent semantics for inspiration
(or at least to see an alternative way of doing things). In particular,
EVFILT_PROC+NOTE_EXIT -- which is attached to a particular process. I
wonder what their view is on these sorts of questions.

> > Also maybe we should
> > integrate this into the exit machinery instead of this loop...
>=20
> I don't know what you mean. It's already integrated into the exit
> machinery: it's what runs the waitqueue.

My mistake, I missed the last hunk of the patch.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--snyupnd52lalsuup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlva2dQACgkQSnvnv3De
m5+qAxAA1x2Kbzbwil79xUBlcjKcEehEww8PpIKyZ9hdUHImdjTJlP4Yzo7sJfwz
xCfiUPUG1I8etcBDSgmAowAzPqFfyRQGhj0QcRI/BfK1RDMEit1ndGtm7UJEZgse
LpCYh7jv0l5pvZK85AyaXJx/JcRE2t8Ec8fVNQeEIfwxpKp6C+vYQLaNV7+X95+f
lW5fC4ek6z9+KpZPOxJw31XZgBUyZZHq4zhxLwHCdNOHAyN/EMXHhXxd1OdWFi0A
Z9DAnW17aeqSbVY69mgWOYBnK0cSXf0LMYeD85hNlJpLVrfG96QRw/sU+TyZ0+Sb
0cOwI8Kgp2WW3LoSiXULnk/U0aP1uPg7WCpmOsZ1fb/SLpOOqEfm8SaJqDlpF0kq
rv3r0VYbo0y2KADzC0A+HokPzorJ3fhWScGFfoBeKgpyhDr9wUxLA8tRVW6jM5LG
QIxjcn0ww2HolUR1shRNt9bl2Ffuvkj4LVPd4wD6WY8mk+yEvxS15WZZzBatulYb
zWzqQXfPB8RbIYX+bO1/m/ZaeClraQz3BnzrrFmvbAiJeSLvkDugBfvTGFYCoP0t
sPRvmKmQF5zTYgsYXfvjLOW2SD8pYyWrUvpyD3gJr0JF1MXrdGMLMp9MAz7cHKH4
o/DWJNNerVNjcajMncfB+1lkfMzl7590z67VoFswcKNCj8PMA3o=
=kCkq
-----END PGP SIGNATURE-----

--snyupnd52lalsuup--
