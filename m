Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeC0T4p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 15:56:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55999 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0T4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 15:56:43 -0400
X-Google-Smtp-Source: AIpwx4/7pAxPxk7w8uxPq1D6+ChV7Pp1PDc7vrjtI9PnGmkaZlxL/JWsxq8fTO5jMlI01PddhQGlug==
Date: Tue, 27 Mar 2018 21:56:39 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
Message-ID: <20180327195639.7pkqb47wcgr6jgoy@gmail.com>
References: <1522091848-18426-1-git-send-email-longman@redhat.com>
 <20180327060655.25zjgqlgbfsp6b3p@gmail.com>
 <72b8a73c-bfc0-5884-199d-349ee3311802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b8a73c-bfc0-5884-199d-349ee3311802@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 03/27/2018 02:06 AM, Ingo Molnar wrote:
> > * Waiman Long <longman@redhat.com> wrote:
> >
> >> For a rwsem, locking can either be exclusive or shared. The corresponding
> >> exclusive or shared unlock must be used. Otherwise, the protected data
> >> structures may get corrupted or the lock may be in an inconsistent state.
> >>
> >> In order to detect such anomaly, a new configuration option DEBUG_RWSEMS
> >> is added which can be enabled to look for such mismatches and print
> >> warnings that that happens.
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 64155e3..0958192 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -1075,6 +1075,13 @@ config DEBUG_WW_MUTEX_SLOWPATH
> >>  	 even a debug kernel.  If you are a driver writer, enable it.  If
> >>  	 you are a distro, do not.
> >>  
> >> +config DEBUG_RWSEMS
> >> +	bool "RW Semaphore debugging: basic checks"
> >> +	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
> >> +	help
> >> +	  This feature allows mismatched rw semaphore locks and unlocks
> >> +	  to be detected and reported.
> >> +
> > Makes sense - but this should also be integrated into the rest of lock debugging 
> > Kconfig hierarchy similar to DEBUG_MUTEXES: i.e. DEBUG_LOCK_ALLOC, PROVE_LOCKING, 
> > etc. should select this new lock debugging option as well.
> >
> > People generally are not supposed to know and configure the finer details, 
> > CONFIG_LOCK_DEBUGGING=y is a one-stop-shop in this regard.
> 
> I can add a patch to rework lock debugging configuration code. Do you
> want to hide the individual config options but still allow them to be
> enabled manually? Alternatively we can also just add a master lock
> debugging option to select them all.

They should work like mutex debugging: it's auto-selected by PROVE_LOCKING, but 
can be enabled individually as well if PROVE_LOCKING is disabled.

Thanks,

	Ingo
