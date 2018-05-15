Return-Path: <daniel.lezcano@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526392577; cv=none;
        d=google.com; s=arc-20160816;
        b=nSFYb5c1m0gyKF6OZ0H4dbkuzGrxrO/BPfkAJyj5nqHLk2G8tlQ9iCQdM/2sR9lyOi
         FLcxrB+2CdqogZjQjylO6VVfQYdUgDiZacCFoHMoqoHuY6DpTbf3rPHSeLkhzlSY0tJC
         SDsprWsgm+sdm9hl7wE9aoQjE0mPyUdIfPaKJZ/kdKLx0TPyoolXNxNSpeE6uHqOBzLs
         DPME1VnL5uByKuXADHFqx7UANGcebcnwFsbVQE4d2HdghqeoEyE2Fs2uGh3tazbt1lgC
         /hiBmVtLTF7a7Ox5k/WufOPdeEXasptsY3YNOY8BjIn4/KbDLCL3/Yb2608gvJU33P6C
         6eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=ueg7auepDmlUY3OPmWquc+zeC96SSuDdbuoWriLwMYU=;
        b=AuKOJn0pEZCTIh/gpKvOrZDeSyeXCK8QzYBqLmxqxh7eydhsVYOaok4NLCNJKt4dza
         FgHSC7oZ+AowVxlsyZ7A+qOZl/K3pkh297A6G5fQAQ6n/GR1x5vddiSU0kPQr72IweHp
         LTIVag/UQkmbpNwT579dXNd/m9HpUilChwurRZ+NhWydw5Us8nRmM+4W+oSMMFSPGel6
         BSQpEUWiBK+LjXAq4HD/AuHBwdHfsswLkGhw6n78ERqZM+NCFFM/wfstZtkXN2Bi3NN0
         8DhLBe/KgbARLP8YcWPzXpwlAXL8Fb3T8cL/KwNeZvXa8JGcVD8V5sNxnCsp4tkhlcxo
         GJjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UcP0/aQC;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UcP0/aQC;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq4jOk7Ipys2Z4quvff5ibS+WHXAdKL6EuPZFslBXr9Y8jGTSr7wp1Clwsaqytzx+TXBa6drA==
Date: Tue, 15 May 2018 15:56:12 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: tglx@linutronix.de, john.stultz@linaro.org, arnd@arndb.de,
	tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk,
	mark.rutland@arm.com, marc.zyngier@arm.com, broonie@kernel.org,
	paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
	rdunlap@infradead.org, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
	linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org,
	hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com,
	len.brown@intel.com, rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] Add persistent clock support
Message-ID: <20180515135612.GQ29062@mai>
References: <cover.1526285602.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429141477472075?=
X-GMAIL-MSGID: =?utf-8?q?1600538623003427540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
> Hi,
> 
> We will meet below issues when compensating the suspend time for the timekeeping.
> 
> 1. We have too many different ways of dealing with persistent timekeeping
> across architectures, so it is hard for one driver to compatable with different
> architectures.
> 
> 2. On some platforms (such as Spreadtrum platform), we registered the high
> resolution timer as one clocksource to update the OS time, but the high
> resolution timer will be stopped in suspend state. So we use another one
> always-on timer (but low resolution) to calculate the suspend time to
> compensate the OS time. Though we can register the always-on timer as one
> clocksource, we need re-calculate the mult/shift with one larger conversion
> range to calculate the suspend time and need update the clock in case of
> running over the always-on timer.
> 
> More duplicate code will be added if other platforms meet this case.
> 
> 3. Now we have 3 sources that could be used to compensate the OS time:
> Nonstop clocksource during suspend, persistent clock and rtc device,
> which is complicated. Another hand is that the nonstop clocksource can
> risk wrapping if the suspend time is too long, so we need one mechanism
> to wake up the system before the nonstop clocksource wrapping.
> 
> According to above issues, we can introduce one common persistent clock
> framework to compatable with different architectures, in future we will
> remove the persistent clock implementation for each architecture. Also
> this framework will implement common code to help drivers to register easily.
> Moreover if we converted all SUSPEND_NONSTOP clocksource to register to
> be one persistent clock, we can remove the SUSPEND_NONSTOP clocksource
> accounting in timekeeping, which means we can only compensate the OS time
> from persistent clock and RTC.
> 
> Will be appreciated for any comments. Thank you all.

Why do we need another API ?

Why not remove the present persistent API and rely on the SUSPEND_NONSTOP flag
to do the right action at suspend and resume?

We register different clocksources, the rating does the selection.

When entering 'suspend', we check against the SUSPEND_NONSTOP flag and switch
to the first clocksource with the best rating and the flag set. When resuming,
we switch back to the highest rating.

Having a clocksource out of the always-on domain must be notified with a trace
in the log because this is not a normal situation.


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
