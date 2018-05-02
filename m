Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeEBQ07 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:26:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:54408 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeEBQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:26:58 -0400
Date: Wed, 2 May 2018 12:26:53 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Justin Forbes <jmforbes@linuxtx.org>
Cc: Jeremy Cline <jeremy@jcline.org>, Sultan Alsawaf <sultanxda@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180502162653.GB3461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org>
 <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 07:09:11AM -0500, Justin Forbes wrote:
> Yes, Fedora libgcrypt is carrying a patch which makes it particularly
> painful for us, we have reached out to the libgcrypt maintainer to
> follow up on that end. But as I said before, even without that code
> path (no dracut-fips) we are seeing some instances of 4 minute boots.
> This is not really a workable user experience.  And are you sure that
> every cloud platform and VM platform offers, makes it possible to
> config virtio-rng?

Unfortunately, the answer is no.  Google Compute Engine, alas, does
not currently support virtio-rng.  With my Google hat on, I can't
comment on future product features.  With my upstream developer hat
on, I'll give you three guesses what I have been advocating and
pushing for internally, and the first two don't count.  :-)

That being said, I just booted a Debian 9 (Stable, aka Stretch)
standard kernel, and then installed 4.17-rc3 (which has the
CVE-2018-1108 patches).  The crng_init=2 message doesn't appear
immediately, and it does appear quite a bit later comapred to
the standard 4.9.0-6-amd64 Debian 9 kernel.  However, the lack of a
fully initialized random pool doesn't prevent the standard Debian 9
image from booting:

May  2 15:33:42 localhost kernel: [    0.000000] Linux version 4.17.0-rc3-xfstests (tytso@cwcc) (gcc version 7.3.0 (Debian 7.3.0-16)) #169 SMP Wed May 2 11:28:17 EDT 2018
May  2 15:33:42 localhost kernel: [    1.456883] random: fast init done
May  2 15:33:46 rng-testing systemd[1]: Startup finished in 3.202s (kernel) + 5.963s (userspace) = 9.166s.
May  2 15:33:46 rng-testing google-accounts: INFO Starting Google Accounts daemon.
May  2 15:44:39 rng-testing kernel: [  661.436664] random: crng init done

So it really does appear to be something going on with Fedora's
userspace; can you help try to track down what it is?

Thanks,

						- Ted
