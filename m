Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966270AbeCHNkY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:40:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:50525 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934137AbeCHNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:40:23 -0500
Message-ID: <1520516417.7807.88.camel@suse.de>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
From: Mike Galbraith <mgalbraith@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 08 Mar 2018 14:40:17 +0100
In-Reply-To: <CAJZ5v0gCi7bLL_r45qmoOKwh_dWF_RVs0U5UPe3qY45GbvtK9w@mail.gmail.com>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
         <1520505099.7807.60.camel@suse.de>
         <CAJZ5v0gCi7bLL_r45qmoOKwh_dWF_RVs0U5UPe3qY45GbvtK9w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 12:10 +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 8, 2018 at 11:31 AM, Mike Galbraith <mgalbraith@suse.de> wrote:
>                               1     2     3
> > 4.16.0.g1b88acc-master     6.95  7.03  6.91 (virgin)
> > 4.16.0.g1b88acc-master     7.20  7.25  7.26 (+v2)
> > 4.16.0.g1b88acc-master     6.90  7.06  6.95 (+local)
> >
> > Why would v2 charge the light firefox load a small but consistent fee?
> 
> Two effects may come into play here I think.
> 
> One is that allowing the tick to run biases the menu governor's
> predictions towards the lower end, so we may use shallow states more
> as a result then (Peter was talking about that).

Hm, I'd expect that to show up in +local as well then, as it keeps the
tick running when avg_idle < sched_migration_cost (convenient magic
number), but the firefox load runs at the same wattage as virgin.  I'm
also doing this...

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -335,7 +335,7 @@ static int menu_select(struct cpuidle_dr
                 * C1's exit latency exceeds the user configured limit.
                 */
                polling_threshold = max_t(unsigned int, 20, s->target_residency);
-               if (data->next_timer_us > polling_threshold &&
+               if (expected_interval > polling_threshold &&
                    latency_req > s->exit_latency && !s->disabled &&
                    !dev->states_usage[1].disable)
                        first_idx = 1;

...to help out high frequency cross core throughput, but the firefox
load apparently doesn't tickle that, as significant polling would
surely show in the wattage.

	-Mike
