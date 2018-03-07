Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeCGXjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754966AbeCGXjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:39:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0162C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 8 Mar 2018 00:39:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 2/6] sched: idle: Do not stop the tick
 upfront in the idle loop
Message-ID: <20180307233911.GB9367@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
 <3346281.BDGJiv2ZOp@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3346281.BDGJiv2ZOp@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:02:15AM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -220,13 +220,17 @@ static void do_idle(void)
>  	 */
>  
>  	__current_set_polling();
> -	tick_nohz_idle_enter();
> +	tick_nohz_idle_prepare();

Since we leave tick_nohz_idle_exit() unchanged, can we keep tick_nohz_idle_prepare()
under the name tick_nohz_idle_enter() so that we stay symetric? And then make xen call
the two functions:

    tick_nohz_idle_enter();
    tick_nohz_idle_go_idle();

Also can we rename tick_nohz_idle_go_idle() to tick_nohz_idle_stop_tick() ?
This will be more self-explanatory.

Thanks.
