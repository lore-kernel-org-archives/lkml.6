Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBUUkw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:40:52 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:41612 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeBUUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:40:50 -0500
X-Google-Smtp-Source: AH8x225ALYgUIVWUQ18cRaaOHrYGPSasIvRCXKnE9oQ3Dr1C5LpTnCJHLAcVexpvmMiTerD/r3I5PHpEbJK+gnWiH/8=
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
References: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk> <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com> <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 12:40:48 -0800
X-Google-Sender-Auth: YRQyTjqRwBUWthmIdpRK0y3Hkbw
Message-ID: <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:58 AM, Luck, Tony <tony.luck@intel.com> wrote:
>
> How are you envisioning this rate-limiting to be implemented? Are
> you going to fail an EFI call if the rate is too high?  I'm thinking that
> we just add a delay to each call so that we can't exceed the limit.

Delaying sounds ok, I guess.

But the "obvious" implementation may be simple:

    static void efi_ratelimit(void)
    {
        static DEFINE_RATELIMIT_STATE(ratelimit, HZ, 100);

        if (!__ratelimit(&ratelimit))
                msleep(10);
        }
    }

but the above is actually completely broken.

Why? If you have multiple processes, they can each only do a hundred
per second, but globally they can do millions per second by just
having a few thousand threads. They all sleep, but..

So how do you restrict it *globally*?

If you put this all inside a lock like a mutex, you can generate
basically arbitrary delays, and you're back to the DoS schenario. A
fair lock will allow thousands of waiters to line up and make the
delay be

But maybe I'm missing some really obvious way. You *can* make the
msleep be a spinning wait instead, and rely on the scheduler, I guess.

Or maybe I'm just stupid and am overlooking the obvious case.

Again, making the ratelimiting be per-user makes all of these issues
go away. Then one user cannot delay another one.

             Linus
