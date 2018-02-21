Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939044AbeBUSC1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:02:27 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34328 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938969AbeBUSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:02:24 -0500
X-Google-Smtp-Source: AG47ELsSTSvxSyrlLPHEY5zrG/kNzPfyOE82VhO4jG9xoHf2PJVoh6po+euc7a/q44dgexpDuJQ0oc1i+AjRUxwxC0k=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk> <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com> <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 10:02:23 -0800
X-Google-Sender-Auth: LRT0A9g4caPug-rm9yKIuCWfXfA
Message-ID: <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, Peter Jones <pjones@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 1:03 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> The thing I like about rate limiting (for everyone including root) is
> that it does not break anybody's workflow (unless EFI variable access
> occurs on a hot path, in which case you're either a) asking for it, or
> b) the guy trying to DoS us), and that it can make exploitation of any
> potential Spectre v1 vulnerabilities impractical at the same time.

I do agree that ratelimiting would seem to be the simple solution.

We _would_ presumably need to make it per-user, so that one user
cannot just DoS another user.

But it should be fairly easy to just add a 'struct ratelimit_state' to
'struct user_struct', and then you can easily just use

   '&file->f_cred->user->ratelimit'

and you're done. Make sure the initial root user has it unlimited, and
limit it to something reasonable for all other user allocations.

So I think a rate-limiting thing wouldn't be overly complicated. We
could make the rate-limiting be some completely generic thing, not
tying it to efivars itself, but just saying "this is for random
"occasional" things where we are ok with a user doing a hundred
operations per second, but if somebody tries to do millions, they get
shut down".

Realistically, even root is fine with those, but letting root in the
initial namespace be entirely unlimited is obviously a pretty
reasonable thing to do.

So it might be a few tens of lines of code or something, including the
initialization of that new user struct entry.

I think the real issue is testing and just doing it.

Anybody?

               Linus
