Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCULwY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:52:24 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43732 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCULwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:52:22 -0400
X-Google-Smtp-Source: AG47ELvrvhJ0qQnqVOhUrABfRxZcaDrhTKNnr8cctBY0EXkeSgaOfdR4JX+1k5CP5STuDpT2XndYFu1UjmYne7/0WIo=
MIME-Version: 1.0
In-Reply-To: <2111949.c172CzMuf8@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <2111949.c172CzMuf8@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Mar 2018 12:52:21 +0100
X-Google-Sender-Auth: iQJrAQGWE_pnigLti7Sq6-II7Mw
Message-ID: <CAJZ5v0i7AE=HEp1guNdpSV7=a-GS=e00+K1kG7Q6SYnK2g6cZA@mail.gmail.com>
Subject: Re: [RFT][PATCH v7.1 5/8] cpuidle: Return nohz hint from cpuidle_select()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 7:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add a new pointer argument to cpuidle_select() and to the ->select
> cpuidle governor callback to allow a boolean value indicating
> whether or not the tick should be stopped before entering the
> selected state to be returned from there.
>
> Make the ladder governor ignore that pointer (to preserve its
> current behavior) and make the menu governor return 'false" through
> it if:
>  (1) the idle exit latency is constrained at 0, or
>  (2) the selected state is a polling one, or
>  (3) the expected idle period duration is within the tick period
>      range.
>
> In addition to that, the correction factor computations in the menu
> governor need to take the possibility that the tick may not be
> stopped into account to avoid artificially small correction factor
> values.  To that end, add a mechanism to record tick wakeups, as
> suggested by Peter Zijlstra, and use it to modify the menu_reflect()
> behavior when tick wakeup occurs.  Namely, if the CPU is woken up by
> the tick, the predicted idle duration is likely too short, so make
> menu_reflect() try to compensate by bumping up the correction factor
> with a (sufficiently large) constant value.
>
> Since the value returned through the new argument pointer of
> cpuidle_select() is not used by its caller yet, this change by
> itself is not expected to alter the functionality of the code.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Another variant of patch [5/8] to test.
>
> This one doesn't run menu_update() at all on tick wakeups, but simply
> bumps up the correction factor alone then.

I have overlooked one thing in this patch and in the original v7 of it.

Namely, tick wakeups occurring when the return value of
tick_nohz_get_sleep_length() is within the tick boundary should be
treated as normal wakeups, because the nohz code itself doesn't stop
the tick then even without this patch series.

I'll rework this patch for that and will send an update shortly.

Thanks!
