Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEVKXO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:23:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40525 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:23:09 -0400
X-Google-Smtp-Source: AB8JxZpFQJUufPeQjxZmwU+8Cx6Jwi2uUDsSbKNr6FBmcq1E4u0cvUthJwfeyy/HouaMG2gxhniSzw==
Date: Tue, 22 May 2018 15:53:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522102305.uxph4u4o2zrvu4tx@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521105055.GQ30654@e110439-lin>
 <20180521154957.GA14065@joelaf.mtv.corp.google.com>
 <20180521170050.GT30654@e110439-lin>
 <20180521172001.GA21678@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172001.GA21678@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18, 10:20, Joel Fernandes wrote:
> On Mon, May 21, 2018 at 06:00:50PM +0100, Patrick Bellasi wrote:
> > If that's the case, this means that if, for example, during a
> > frequency switch you get a request to reduce the frequency (e.g.
> > deadline task passing the 0-lag time) and right after a request to
> > increase the frequency (e.g. the current FAIR task tick)... you will
> > enqueue a freq drop followed by a freq increase and actually do two
> > frequency hops?

I don't think so.

Consider the kthread as running currently and has just cleared the
work_in_progress flag. Sched update comes at that time and we decide
to reduce the frequency, we queue another work and update next_freq.
Now if another sched update comes before the kthread finishes its
previous loop, we will simply update next_freq and return. So when the
next time kthread runs, it will pick the most recent update.

Where is the problem both of you see ?

-- 
viresh
