Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeDZIAh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:00:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42790 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbeDZIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:00:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
Date: Thu, 26 Apr 2018 10:00:22 +0200
Message-ID: <1937172.K7anUBJQAz@aspire.rjw.lan>
In-Reply-To: <2814513.Yf7f2L7MUC@aspire.rjw.lan>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de> <2814513.Yf7f2L7MUC@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 11:28:27 PM CEST Rafael J. Wysocki wrote:
> On Wednesday, April 25, 2018 9:09:29 PM CEST Thomas Gleixner wrote:
> > On Wed, 25 Apr 2018, Linus Torvalds wrote:
> > > On Wed, Apr 25, 2018 at 6:45 AM, tip-bot for Thomas Gleixner
> > > <tipbot@zytor.com> wrote:
> > > >
> > > > As stated in the pull request for the unification of CLOCK_MONOTONIC and
> > > > CLOCK_BOOTTIME, it was clear that we might have to revert the change.
> > > 
> > > I'm ok with the revert., but I do want the revert message to talk
> > > about *exactly* what broke.
> > > 
> > > I don't see the reported watchdog things, and I run systemd and I ran
> > > these patches.
> > 
> > With suspend/resume?
> > 
> > > So it's not just "systemd uses this for a watchdog". It must be
> > > something specific that made it trigger for some people and not
> > > others, and it's that specific thing that we should document so that
> > > we know why this simplification failed.
> > 
> > Fair enough. Do the reporters have more information or do I have to chase
> > it down myself?
> 
> Well, if CLOCK_MONOTONIC did not count when the system was suspended and now
> it does that due to the change in question, then this is a significant
> difference in behavior likely to confuse things even in principle.

FWIW, here's a list of issues reported and narrowed down to the commit
in question so far I could find:

* systemd kills daemons on resume, after >WatchdogSec seconds
  of suspending (Genki Sky).  [Verified that that's because systemd uses
  CLOCK_MONOTONIC and expects it to not include the suspend time.]

* systemd-journald misbehaves after resume:
  systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
  (	Mike Galbraith).

* NetworkManager reports "networking disabled" and networking is broken
  after resume 50% of the time (Pavel).  [May be because of systemd.]

* MATE desktop dims the display and starts the screensaver right after
  system resume (Pavel).

* Full system hang during resume (me).  [May be due to systemd or NM or both.]

I'm not sure if all of the above can be connected to one specific thing (other
than the fact that things get confused if they expect CLOCK_MONOTONIC to not
include system suspend time).
