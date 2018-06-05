Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFERag (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:30:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40853 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeFERad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:30:33 -0400
X-Google-Smtp-Source: ADUXVKLqDkYlQU7eLc5BuNuXSXgtx8vt0U4xS6iOXkLyOTA8dISgMrzhLu6JqMbAzr6X4JCFU5KSe+2pKhKXd8iU0SI=
MIME-Version: 1.0
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 10:30:21 -0700
Message-ID: <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  device property: Get rid of union aliasing

Honestly, this looks questionable to me.

I'm not talking about the changes themselves - I can live with them.
But the _rationale_ is pure and utter garbage, and dangerously so.

The fact is, using a union to do type punning is the traditional AND
STANDARD way to do type punning in gcc. In fact, it is the
*documented* way to do it for gcc, when you are a f*cking moron and
use "-fstrict-aliasing" and need to undo the braindamage that that
piece of garbage C standard imposes.

So the commit message that talks about how horrible union aliasing is
is pushing a story that is simply wrong. Using the standard to push it
- the same standard that came up with the completely mis-guided
aliasing rules - is not a valid argument.

Andy, what is the background for trying to push this idiocy? Don't
tell me "the C standard is unclear". The C standard is _clearly_ bogus
shit (see above on strict aliasing rules), and when it is bogus
garbage, it needs to be explicitly ignored, and it needs per-compiler
workarounds for braindamage. The exact same situation is true when
there is some lack of clarity.

This is why we use -fwrapv, -fno-strict-aliasing etc. The standard
simply is not *important*, when it is in direct conflict with reality
and reliable code generation.

The *fact* is that gcc documents type punning through unions as the
"right way". You may disagree with that, but putting some theoretical
standards language over the *explicit* and long-time documentation of
the main compiler we use is pure and utter bullshit.

I've said this before, and I'll say it again: a standards paper is
just so much toilet paper when it conflicts with reality. It has
absolutely _zero_ relevance. In fact, I'll take real toilet paper over
standards any day, because at least that way I won't have splinters
and ink up my arse.

So I want to see actual real arguments, not "the standard is unclear".
When documented gcc behavior says one thing, and the standard might be
unclear, we really don't care one whit about the lack of clarity in
some standard.

So what's the _real_ reason for avoiding union aliasing?

There are competent people on standards bodies. But they aren't
_always_ competent, and the translation of intent to English isn't
always perfect either. So standards are not some kind of holy book
that has to be revered. Standards too need to be questioned.

                 Linus
