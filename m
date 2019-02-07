Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ACC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AEB21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBGN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:28:06 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50265 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:28:06 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BF0F81BF212;
        Thu,  7 Feb 2019 13:28:01 +0000 (UTC)
Date:   Thu, 7 Feb 2019 14:28:01 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <20190207132801.GA2284@behemoth.owl.eu.com.local>
References: <cover.1548998323.git.hle@owl.eu.com>
 <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
 <20190202183743.GA229953@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20190202183743.GA229953@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > The result is a potential performance gain during freeze, since less
> > tasks have to be awaken.
>=20
> I'm curious did you try the freezing process and see if pointless wakeups=
 are
> reduced?  That would be an added bonus if you did.

Test env: fresh Debian QEMU vm with 4.19 stable kernel.

Test process:

- Added two debug logs to freeze_task:

    bool freeze_task(struct task_struct *p)
    {
        unsigned long flags;
    [snip]
        pr_info("freezing a task");
    [snip]
        if (freezer_should_skip(p)) {
            pr_info("skeeping a task");
            return false;
        }
    [snip]
    }

- Triggered manual freeze:

# echo freezer > /sys/power/pm_test
# echo test_resume > /sys/power/disk
# echo disk > /sys/power/state

- grep -c to get the number of "freezing a task" and "skeeping a task"
lines in kern.log.

Results:

Without my patch: 448 calls freeze_task, 12 skipped.
With my patch: 448 calls, 32 skipped.

2.6x more tasks skipped.

Not sure this is the best way to test this patch, though. Any advice?

regards,
 Hugo

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxcMlkACgkQZYVUZx9w
0DTCzAf+LqBnqXSONA0VtCYHAEfgiS/gjTtAhZBNzyl0S+42tbMMH1IG7ZYheBqh
DSIBoyNQICOhXtRPgt1SVZQyojoT/wIEMT7HZjeIuo1o7gFWk0XXj+Hg3LfLQ77j
ycE2bq+tO7CUyoKFTWOtlDTb8fTE3S2Q7nDXUOGZ1NfQ3AaFXox6J7J+BnxrAZ8g
kwpLblEc8294UNtG6YKVuqx0lxh3KFujuxmvW7ma6ykmNgiQDNYf8S6ZFpTpCVBf
4zGkcrMKqd5lwQqeRa95WkQm0mFRvXG5U6JUAghyBxNE63JhNPlwe6I5nrE0Pz+A
fRlVbvMt47uRIdWDF0KAkZPqwOPuUQ==
=2HBS
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
