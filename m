Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B90EC5ACD3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9492086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfARRIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:08:06 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37143 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfARRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:08:05 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D9D6524000A;
        Fri, 18 Jan 2019 17:08:01 +0000 (UTC)
Date:   Fri, 18 Jan 2019 18:08:01 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190118170801.GA4537@hle-laptop.local>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20190118151941.GB187589@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

Thanks for your review.

> I believe these should be 2 patches. In the first patch you introduce the
> new API, in the second one you would simplify the VSOC driver.
>=20
> In fact, in one part of the patch you are using wait_event_freezable which
> already exists so that's unrelated to the new API you are adding.

Agree, I will split the patch for the v2.

> > +/*
> > + * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to=
 avoid
> > + * increasing load and is freezable.
> > + */
> > +#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
>=20
> You should document the variable names in the header comments.

Agree. This comment was copy/pasted from wait_event_freezable_timeout,
should I fix it there as well?

> Also, this new API appears to conflict with definition of 'freezable' in
> wait_event_freezable I think,
>=20
> wait_event_freezable - sleep or freeze until condition is true.
>=20
> wait_event_freezable_hrtimeout - sleep but make sure freezer is not block=
ed.
> (your API)
>=20
> It seems to me these are 2 different definitions of 'freezing' (or I coul=
d be
> completely confused). But in the first case it calls try_to_freeze after
> schedule(). In the second case (your new API), it calls freezable_schedul=
e().
>=20
> So I am wondering why is there this difference in the 'meaning of freezab=
le'.
> In the very least, any such subtle differences should be documented in the
> header comments IMO.

It appears that freezable_schedule() and schedule(); try_to_freeze() are
almost identical:

    static inline void freezable_schedule(void)
    {
        freezer_do_not_count();
        schedule();
        freezer_count();
    }

and

    static inline void freezer_do_not_count(void)
    {
        current->flags |=3D PF_FREEZER_SKIP;
    }

    static inline void freezer_count(void)
    {
        current->flags &=3D ~PF_FREEZER_SKIP;
        /*
         * If freezing is in progress, the following paired with smp_mb()
         * in freezer_should_skip() ensures that either we see %true
         * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
         */
        smp_mb();
        try_to_freeze();
    }

as far as I understand this code, freezable_schedule() avoids blocking the
freezer during the schedule() call, but in the end try_to_freeze() is still
called so the result is the same, right?

I wonder why wait_event_freezable is not calling freezable_schedule().

That being said, I am not sure that the try_to_freeze() call does anything
in the vsoc case because there is no call to set_freezable() so the thread
still has PF_NOFREEZE...

regards,
 Hugo

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxCB+oACgkQZYVUZx9w
0DQUSAf8CZqbI4QMqVaVcLJct4ZWr0WwA9yzwPjUd6sX2C4e8m2HxUqEb0wNA3ll
zDwb8drU31yGYSw5CuVufTmdZ9r5etWtI2ZmVX3DHyJJhnxwaHg8xUKhJI05NvXP
sAXoisn6NrJwqLeAGAJHG6pXsOC964mafKKxGhXzCRaQ7LERZsLe3gIE5eY8N1vI
RXPrIpirhjXsLgvQ5mveDeZ1mXDZ+ThygLR6OLhi8zdbiqpRHZGzF+tUwpT0+Gyy
L/0mrNNny1HPAOugANwHL73bHKhCmCI9zt9SJY3f7dbW5p6vPMRt/GKq1a77F2Zl
5M6YRrnVUukcy2cW67KuLiB2smE9sA==
=UZWB
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
