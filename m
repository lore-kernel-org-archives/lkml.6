Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeCVRXP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:23:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46905 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeCVRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:23:13 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 22 Mar 2018 18:23:38 +0100
Message-ID: <2685716.WAg79ZNVrZ@aspire.rjw.lan>
In-Reply-To: <642c6901-ad0d-b6b3-9ee9-3e0bd10aa610@tu-dresden.de>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <CAJZ5v0iThFDEjnwTbpAhwHY_vF_KDdAUyhDL1CdB4GJsG5eNRQ@mail.gmail.com> <642c6901-ad0d-b6b3-9ee9-3e0bd10aa610@tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 22, 2018 2:18:59 PM CET Thomas Ilsche wrote:
> On 2018-03-21 23:15, Rafael J. Wysocki wrote:
> > On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche
> > <thomas.ilsche@tu-dresden.de> wrote:
> >> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
> >>>
> >>>
> >>> So please disregard this one entirely and take the v7.2 replacement
> >>> instead of it:https://patchwork.kernel.org/patch/10299429/
> >>>
> >>> The current versions (including the above) is in the git branch at
> >>>
> >>>    git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >>>    idle-loop-v7.2
> >>
> >>
> >> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
> >> as with v5: several cores which just keep the sched tick enabled.
> >> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
> >> full sched tick.
> >> The resulting power consumption is ~105 W instead of ~ 70 W.
> >>
> >> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
> >>
> >> I have briefly ran v7 and I believe it was also affected.
> > 
> > Then it looks like menu_select() stubbornly thinks that the idle
> > duration will be within the tick boundary on those cores.
> > 
> > That may be because the bumping up of the correction factor in
> > menu_reflect() is too conservative or it may be necessary to do
> > something radical to measured_us in menu_update() in case of a tick
> > wakeup combined with a large next_timer_us value.
> > 
> > For starters, please see if the attached patch (on top of the
> > idle-loop-v7.2 git branch) changes this behavior in any way.
> > 
> 
> The patch on top of idle-loop-v7.2 doesn't improve idle behavior on
> SKL-SP. Overall it is pretty erratic, I have not seen any regular
> patterns. Sometimes only few cpus are affected, here's a screenshot of
> almost all cpus being affected after a short burst workload.
> 
> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_reflect_skl_sp_idle.png

Thanks for the information!

I will post a v7.3 of patch [5/8] shortly that appears to give good results
for me.  It may be selectig deep states quite aggressively, but let's see.
