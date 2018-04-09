Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/0eT7f66ziDy2aqXgQNHq2c9me7ZlyscVy2JOjaFWIXkyD3cKnX545h6tGRVlyK8qq+/N7
ARC-Seal: i=1; a=rsa-sha256; t=1523275274; cv=none;
        d=google.com; s=arc-20160816;
        b=iVwpF9Y3jPY68aYyjrTFDh6437VOnqtVlYN0FTUuV0kqki0fV5GsvYK2KJQGk80Wtg
         qXEH9NiAs263xIBBfcnNjX0TPhxWOEl5+0CiRa1Ktp++u2UnN5J5ORqzEIQckDPAVHGn
         8sQBGYJZnzS9kOyQRFqIqmodcwhXhlvxUNE0nI7UTxOqDJGvfe2hzrsdlEBbQNhQ9+rS
         4tVxbrJnKDsG+7qRneEy7US3+wFgxMTbtd2arHm+m0RPrGdyTvi/Ikh1BkN12ct58OG7
         f8avZ9cJqsv5/8frnNye8Zec9nn3jKu03qemVIbMZK8U5iUAVImWQN3ehx/991OJ/3Z/
         PKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=bQpYjl+LvjcfXn5dwVONZL7s4H/ozMeawvYNZ3zXFr8=;
        b=yvegElj3bP69R8B4chrXsOmeHFTSpINLt4qtwwlLoglfgiPFviRYoUr+3lpn7/N+IE
         yPX2vqNK91xNx3oZPoFrvAUp1TeLRYfGuRwYnEbeyBjZn5PqeU7WHgWcEDodxd5PIlCk
         OoB/FZxrtzDxPXBTF4J8W2y2PfzoCm6sK4bl4LQ1kYGKWZc17SIeM9acYPkOcANMDY14
         Ti+YgLA3/TfkRYYXZtT24SkhB0BdVBoFIL0uzR/LW1mMlPxaHzNBCjDnehqViPNfSUSw
         gtH1tEXK+OGc1D3EMVxip6oDdQqYdQk70GCNIg7ZPWdP8L6wfd7jOnAXX/vt06I71Kfd
         OYgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=HQ2y+/nJ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=HQ2y+/nJ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 14:01:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180409120111.GA4043@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-3-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1597269894549731882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> The energy consumption of each CPU in the system is modeled with a list
> of values representing its dissipated power and compute capacity at each
> available Operating Performance Point (OPP). These values are derived
> from existing information in the kernel (currently used by the thermal
> subsystem) and don't require the introduction of new platform-specific
> tunables. The energy model is also provided with a simple representation
> of all frequency domains as cpumasks, hence enabling the scheduler to be
> aware of dependencies between CPUs. The data required to build the energy
> model is provided by the OPP library which enables an abstract view of
> the platform from the scheduler. The new data structures holding these
> models and the routines to populate them are stored in
> kernel/sched/energy.c.
> 
> For the sake of simplicity, it is assumed in the energy model that all
> CPUs in a frequency domain share the same micro-architecture. As long as
> this assumption is correct, the energy models of different CPUs belonging
> to the same frequency domain are equal. Hence, this commit builds only one
> energy model per frequency domain, and links all relevant CPUs to it in
> order to save time and memory. If needed for future hardware platforms,
> relaxing this assumption should imply relatively simple modifications in
> the code but a significantly higher algorithmic complexity.

What this doesn't mention is why this isn't part of the regular topology
bits. IIRC this is because the frequency domains don't necessarily need
to align with the existing topology, but this completely fails to state
any of that.

Also, since I'm not at all familiar with DT and the OPP library stuff,
this code is completely unreadable to me and there isn't a nice comment
to help me along.
