Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeDJOMM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:12:12 -0400
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:60988 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753145AbeDJOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:12:11 -0400
Date: Tue, 10 Apr 2018 09:12:08 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
In-Reply-To: <20180410081531.18053-1-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
References: <20180410081531.18053-1-vbabka@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfBecCrriSZ6UjdErba0pdGr4zaSMsSrwcfsjIjt6VAB4PFHDZDW1s9yittUW/6VuUbjSx5zGXz8j1+HS+Ycrmx3r7HNAsupsHD1sKO9y8SCpkzH5nLS0
 X+9haX+NHX/Ao+70uX9kRnVj2ErulcQzkHIm+7Xksty3d4jd4p62+MzCXh2PSy7IagWLjq+b6qrR74jwMxFMCv5qZ36LCWQ9Y20JaDtNKWZL5kfjRiLaHbN8
 3Hs/OdlWyYriXcgRsJM1KYKsS66HSPskvJ8KmwowEcdtA+Bg9hXtnEBRMHucpIud81GF2qxsa/VJqU3ysRwJPHaWw5Up9eyqqi2BRLR+NQirdnUNIeY9xo6b
 tOQVaGSVFooy93iY5Ycwr4vkBbdl7yyR3WbIpdyDMe55vCDvqJCybNiOsF2aKm9S0A4NGQKtQXH8q8dqPru6589TtlpFdHYrh8DdDUmBHgVnLAO9HkM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, Vlastimil Babka wrote:

> cache_reap() is initially scheduled in start_cpu_timer() via
> schedule_delayed_work_on(). But then the next iterations are scheduled via
> schedule_delayed_work(), thus using WORK_CPU_UNBOUND.

That is a bug.. cache_reap must run on the same cpu since it deals with
the per cpu queues of the current cpu. Scheduled_delayed_work() used to
guarantee running on teh same cpu.

> This patch makes sure schedule_delayed_work_on() is used with the proper cpu
> when scheduling the next iteration. The cpu is stored with delayed_work on a
> new slab_reap_work_struct super-structure.

The current cpu is readily available via smp_processor_id(). Why a
super structure?

> @@ -4074,7 +4086,8 @@ static void cache_reap(struct work_struct *w)
>  	next_reap_node();
>  out:
>  	/* Set up the next iteration */
> -	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
> +	schedule_delayed_work_on(reap_work->cpu, work,
> +					round_jiffies_relative(REAPTIMEOUT_AC));

schedule_delayed_work_on(smp_processor_id(), work, round_jiffies_relative(REAPTIMEOUT_AC));

instead all of the other changes?
