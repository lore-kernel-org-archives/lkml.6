Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx49T12e0/MmqaMNflGIUS64Z7IiNTrnBHRBIfUjF2wND74+u8aDXS97ow3CiH4DiL6TqpROi
ARC-Seal: i=1; a=rsa-sha256; t=1521695143; cv=none;
        d=google.com; s=arc-20160816;
        b=Pg271PDncwGRXzoComANyhEgEb2+OBn7FuhpPbmlA9FVZjnIPb+BXVctorf3L/JcoM
         EvnIdKBNuaOFLwcUmZS/6/gw3ApHhbCG1jxuGIOlrC4o2BoSJRMLv+MFN/RgqpMYDD1V
         2QunZyIZc75800f+GmsM+8DFBfIrP1EDUIGpH9chPIiPXplYb9VKOH/MQ48KvAol954e
         7WqbojyBYi9QWLBIcLTc9lhCGg4wTa9BS4j5jPY+zTL0cnZZhML4BEtk6rVQN10BEhGT
         zcy8LUMtNCX5TB/0tiQGscK5lr6oqGXWl5doPdxoMxIWXiSb6wuK4yN1QH7NxBqrhaZF
         /ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DXAsD4OCWJcBgOAmc4lVqagxaSAOe3AXYMzx/9lVBv0=;
        b=mY98Zge8WPbjeGlAc+nmy9I3W4+YxXn3eO596M0L/eHXHYAX7zgkyC0jjm1s8n6D3I
         ejHpb7YF+LMKjefHlpoE567mD2BZCPYET8pwwJ2cApQldJ8XPAyjOqF/EE/E6eMjIuOl
         B7hK4UXGt/3Sa+1jRS3u6qKuEdz3+Y42tdPdEb6+Ti9QK2jKqUJCejgvh9JHsxYiXG/T
         Eu//abkA1XHWXTIouVUXYgnCRXa8WN61B8aKcs7k4QtHmrQ0rZYE7i8ozoTydJ50bmpS
         LqhDPgquTIBl+2gz01iObz+D2yfxV1/zYmyYcbwdOwopr9x5JJ/iYbw2+g0ehMathF9d
         B2pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Thu, 22 Mar 2018 05:05:29 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180322050527.GA1559@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
 <20180321142630.GB2168@queper01-VirtualBox>
 <20180321155458.GD13951@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321155458.GD13951@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595613007176182743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday 21 Mar 2018 at 15:54:58 (+0000), Patrick Bellasi wrote:
> On 21-Mar 14:26, Quentin Perret wrote:
> > On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> > > On 20-Mar 09:43, Dietmar Eggemann wrote:
> > > > From: Quentin Perret <quentin.perret@arm.com>

[...]

> > So actually, what I can do is add something like
> > 
> >     fdom_tot_util += util;
> > 
> > to this loop and compute
> > 
> >     energy = cs->power * fdom_tot_util / cs->cap;
> > 
> > only once, instead of having the second loop to compute the energy. We don't
> > have to scale the util for each and every CPU since they share the same
> > cap state. That would save some divisions and ensure the consistency
> > between the selection of the cap state and the associated energy
> > computation. What do you think ?
> 
> Right, would say that under the hypothesis the we are in the same
> frequency domain (and we are because of fdom->span), that's basically
> doing:
> 
>    sum_i(P_x * U_i / C_x) => P_x / C_x * sum_i(U_i)
> 
> Where (C_x, P_x) are the EM reported capacity and power for the
> expected frequency domain OPP.
> 

Yes that's exactly that. I'll do the change in v2.

> > Or maybe you were talking about consistency between several consecutive
> > calls to compute_energy() ?
> 
> Nope, the above +1
> 

[...]

> > I agree that it would be nice to document somewhere that
> > compute_energy() is unsafe to call without sched_energy_present.
> > I can simply add a proper doc comment to this function actually.
> > Would that work ?
> 
> Right, it's just that _maybe_ an explicit BUG_ON is improving the
> documentation by making more explicit the error on testing ?
> 
> Thus, I would probably add both... but Peter will tell you for sure ;)
> 

Right, but I'm still not sure if the BUG_ON is the right thing to do. I
mean, if we really want to make this check, then we could also try
to recover into a working state ... If we enter compute_energy() without
having an energy model, and if we detect it on time, we could bail out
and disable sched_energy_present ASAP with an error message for example.
That would let us know if EAS is broken without making the system
unusable.

Anyways, if there is a general agreement, or if the maintainers think
that the BUG_ON is the right thing to do here, I'm happy to change that
in future versions :)
