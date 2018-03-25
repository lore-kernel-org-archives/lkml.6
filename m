Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AG47ELvCGET5yyJy16CBrK9kAyYd864fRxMVWIcy9Ht8rO3mRmpv3LmdVY044gj6AB3GXZrKXH58
ARC-Seal: i=1; a=rsa-sha256; t=1521985705; cv=none;
        d=google.com; s=arc-20160816;
        b=YOTEIPLIZEi5ETuGbOxsWgBGtFouAsMknzl1A7byIVpgnYEYB4m+uzj5dwkuHE9Giw
         DYe58GnsKxGYTxMeM1hkLNdBlOhZ+snZRyFCQF+SmbqF8t/gPrzWpGKxkVHt3T6dVMtS
         20O3USuV3Ctzf/iLch9y13fZ7moek6gkDKDanySuPMg2IOCYwU/DCfoe3EQ2dh88gdJ4
         yTI1Vh8+wMNYG0Mt0kIolxeBhFSb3BVrD9Lk4e3ctSpCCXLHu/oqcJy1pw9EmoiGgxcR
         6Oh8r5ChtXYqD0DhoMxxwUGCYgVurXj1Qe78tsHvdY/W8zvfA0iuUlw1dPs+0F+eWFIa
         QDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Re7WM/PjBlBwBzpH88zCY89S1XAMZOVlp2AWierHPgg=;
        b=xNlFB4mq/nT6hlKoyI3Xy02RKURltLnSQYU56TtbrtGzfAm/rmOXXfiohM0dglxq+R
         0YWn/HOAK7RbKKPCCdj3CQzkZCzyBS1W12DP89vzXRCVFsVc8u3abtxVHdsMetvCxCTE
         18L/LSrmQP4JnEhfFp8uyKPXmzy9Q1IfUZ8BlB4cTGmZL1b1b5PrlXK1fl+78c/HAuf5
         KI/MbA3KFdtcbD7vSvHkk4ItyAz9zoWS7w+Ocq4xb0BqID5LlKyeb5QYqzVWCuiE5UAE
         BNcqQyYK1/H5JzLaocZ4QeWAU8KbqVZ/04scci3eQsmbvu4pvjF67+sR7XeboqSNfmw5
         EHIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Sun, 25 Mar 2018 14:48:10 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180325134548.GA1344@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180320095215.GB23359@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320095215.GB23359@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1595917683211431231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 20 Mar 2018 at 10:52:15 (+0100), Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>

[...]

> > +#ifdef CONFIG_PM_OPP
> 
> #ifdefs go in .h files, not .c files, right?
> 

So, after looking into this, my suggestion would be to: 1) remove the
#ifdef CONFIG_PM_OPP from energy.c entirely; 2) make sure
init_sched_energy() is stubbed properly for !CONFIG_SMP and
!CONFIG_PM_OPP in include/linux/sched/energy.h; 3) relocate the global
variables (energy_model, freq_domains, ...) to fair.c; and 4) modify
kernel/sched/Makefile with something like:

ifeq ($(CONFIG_PM_OPP),y)
obj-$(CONFIG_SMP) += energy.o
endif

That way, energy.c is not compiled if not needed by the arch, and the
ifdef are kept within header files and Makefiles.

Would that work ?

Thanks,
Quentin
