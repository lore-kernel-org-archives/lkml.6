Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758808AbeD0TPI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:15:08 -0400
Received: from imap.thunk.org ([74.207.234.97]:40080 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758062AbeD0TPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:15:02 -0400
Date: Fri, 27 Apr 2018 15:14:58 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christian Brauner <christian.brauner@canonical.com>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180427191458.GJ5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426204748.GA7540@gmail.com>
 <20180427000013.GH5965@thunk.org>
 <CAHmME9oVRULStf1ff+OUJLyf7GMxUTPrJebF5pxxLO7Sn2tzow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oVRULStf1ff+OUJLyf7GMxUTPrJebF5pxxLO7Sn2tzow@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 05:38:52PM +0200, Jason A. Donenfeld wrote:
> 
> Please correct me if I'm wrong, but my present understanding of this
> is that crng readiness used to be broken, meaning people would have a
> seeded rng without it actually being seeded. You fixed this bug, and
> now people are discovering that they don't have crng readiness during
> a late stage of their init, which is breaking all sorts of entirely
> reasonable and widely deployed userspaces.

I'd say the problem is a combination of some classes of x86 hardware
devices (so far I've mainly seen repurposed chromebooks and VM's that
don't have virtio-rng enabled) combined with some distributions that
could make themselves more amenable to platforms with minimal amounts
of entropy available to them during system startup.

> Sultan mentioned that his machine actually does trigger large
> quantities of interrupts. Is it possible that the entropy gathering
> algorithm has some issues, and Sultan's report points to a real bug
> here? Considering the crng readiness state hasn't been working until
> your recent fix, I suspect the actual entropy gathering code probably
> hasn't prompted too many bug reports, until now that is.

It's not clear when his machine is triggering the "large quantity of
interrupts".  Is it during the system startup, or after he's logged
into the machine?  I suspect what is going on is the Chromebook has
been engineered so that when it's idle, it doesn't issue any
interrupts at all --- which is a good thing from a power management
perspective.  So if nothing is actually _querying_ the SD Card reader,
it's not generating any interrupts.

This is a feature, and not a bug.  That being said, a laptop which
sends some number of interrupts as it receives, say, WiFi packets, and
a system which automatically starts looking for suitable access points
as soon as the machine is started gives us timing events which is not
easily available to an analyst sitting in Fort Meade, Maryland.  In
practice, that seems to be much more of the rule and not the
exception.  However, as laptops try to become much more sparing
interrupts to save power, then we either have to (a) be willing to
trust hardware random number generators available to the laptop,
and/or (b) change userspace to *wait* until after the user has logged
in to try to obtain cryptographic-graded randomness.

If you think there is an alternative besides those two, I'm all ears...

       	     	      	 	      	      - Ted
