Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDRFs1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:48:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:44119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeDRFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:48:24 -0400
Message-ID: <1524030475.5645.2.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <gleep@gmx.de>
To: Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Date: Wed, 18 Apr 2018 07:47:55 +0200
In-Reply-To: <20180417142119.GA4511@codeblueprint.co.uk>
References: <20180417142119.GA4511@codeblueprint.co.uk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xbn6KhsCiaNRUeE1TAjtk7jqMQr2bsRsXj3NtGT4o79R+IRl9+9
 TUXDlyPdERcHKwW4CK1fI5ZRFFpxnwpaEaTSK7UdmoN2ujiRMYKonE5SmvnqR+YnFnzse/e
 WRJZUEpR1V4mGRPBe84zpPQsQze5dZbKqY0xxnhNxWmT5uD9dIgaFcOtnX6MF+xt8fk+703
 ngIaWVJWtyBf9XuI+PcYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NGLFDCHFbZo=:IY6JAJ4s5x7SlP0dVH8SPq
 wEdThlnlV82UAGy883zxaHvq4fN5q5E8eJACZz8M6Z+Pra0X9973s4FUBgGs3wndRQDc6w/Hy
 xiRrnpZlpRB9+ZmfPNaJ4pZJ471RSY81azV1x2NCighycws8PY5iikcopCBDXtzg5ybGvppnn
 Eyl4l1zh+KfvYdueuwhYg41HyUFhTJ1UHG5zpIo9SPxxdri93n5iGI/7pALTiRNfbojGMTELc
 lpugWPcDFMJqH7RW/VHO3h7lHdn4EwUnR8wnVeYyn1H1WzkwmIghs60bqLMXmiBFsexw7VU+n
 uZ1r8f4xdW7sVXpd5efqwvKSNdjz7LoKsYqrz+qTnK0ZTbfq5yrIDly6vV2VPwUIH3nCTzoS4
 Q2s+73KnSCkIezpDv9k8BoEUMlKktI4lZEnDaO7zg5pZzznMCHmINTSBf6kFqHhdFDm393A9S
 ljtZiJTVxIwIa82UPExr1VpSPEgOHrZkyK95tGwHt9fcwtLM8n+rAO5gCalFnG00hKsNNX9G+
 T/6R762kljuBCuDIYIV0Iraix1o97cX4zHXfjxP008o67FqMKCSbnAObWdyD7BMHJkjCSgBq2
 5lVZHzTV6RmSEUrhlS6n2zIjHtdk0JiVgXPFWy8VadBthA6JOT4F5peiFNgZpmzNDq/jCbMKt
 5RQhAjYqHvKAq95R5nZzQO9KSavNBJXyXprZipQU3qeQFKbxxDcgft/EuUonKG56LMMC8vDvi
 9W8dfgIcTTd43nBaZFoyR2PrtxUuZYUSmYs6h7JyipX4cTqwmDX6ucBvsPpT7fevJscHEYR72
 eMreQ3KFxViTaf1yFhPyylXIeekjLzKJ3IonACcTqrvzXeO3bI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 15:21 +0100, Matt Fleming wrote:
> Hi guys,
> 
> We've seen a bug in one of our SLE kernels where the cpu stopper
> thread ("migration/15") is entering idle balance. This then triggers
> active load balance.
> 
> At the same time, a task on another CPU triggers a page fault and NUMA
> balancing kicks in to try and migrate the task closer to the NUMA node
> for that page (we're inside stop_two_cpus()). This faulting task is
> spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
> !VAL)), waiting for "migration/15" to context switch.
> 
> Unfortunately, because "migration/15" is doing active load balance
> it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
> which is already held (since it's inside stop_two_cpus()).
> 
> Deadlock ensues.
> 
> This seems like a situation that should be prohibited, but I cannot
> find any code to prevent it. Is it OK for stopper threads to load
> balance? Is there something that should prevent this situation from
> happening?

I don't see anything to stop the deadlock either, would exclude stop
class from playing idle balancer entirely, though I suppose you could
check for caller being stop class in need_active_balance().  I don't
think any RT class playing idle balancer is particularly wonderful.

	-Mike
