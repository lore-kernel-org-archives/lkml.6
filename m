Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEVIYl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:24:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:55995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVIYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:24:33 -0400
Message-ID: <1526977462.6491.1.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <gleep@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Tue, 22 May 2018 10:24:22 +0200
In-Reply-To: <20180522065051.xy42nwvcxz2nekti@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
         <1525604359.28142.3.camel@gmx.de>
         <20180507073928.shmtfpqyhgxya53b@linutronix.de>
         <1526738996.5365.1.camel@gmx.de>
         <20180522065051.xy42nwvcxz2nekti@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DShaY8UeB09FKhtPtwjvw5MIucLpgERS9R4nO8qnkgUVBojf9hk
 RzgzhPY6eseqZOjymy4AXX+GTn8daGDJzfTn6lUR/dUB/bbPtai9Qagqr0Ka2G2q/Numcnc
 adkbIXhpoy1nJZGwg5G1WWOhFPibRBCWw2TAPHp33xCaVZZ6kKzbwdhCzmw60NnC4bD2F3B
 6T0iRNiiEsxorBGEbnmKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U6AaIPoY6K8=:q6ZWHBkEAyFtPxPRztkNSd
 kaMv87ujXRsQHC5kCHJ5ZWpD4kYv27BF2xA7rxHk3U7zsPLGlEKZCYSFTdyNOXf7NBjfh6cN+
 E6cBEuE1s80Q5o08qTf+krIz5DO+coAgw2otA1Bffa2JNMjDE/tiCrWUMHKjxiLUX2wRY2HBE
 DPhitg7gtlTNaFT9NadLG/dbs0ebj8NeuUdhOHj/nvfRRgpIgfVUiOacArzuSu3PjZGsW0JIZ
 gmmhkO2Ik0cObgeSc79pLJtZ5roSCQ+pgs3oKGx+M6y0yXU02IQh6sAg0HidZ8FLgJOJsy5Rd
 DI/SLVXrVnhMSnYXpOjg6IVyK587jmDX/c/q9L02rAJb1QR7jFLMaR4xLKuXjHXeSWGsaClt/
 42p+aExr30/8KacNQ2HcWCYKDeIJkuConIHC6xYxJYVELCaq/MmlcDUJu3/TwdqDiyyZBnpXc
 nMiT5ckiVdM9UVD2rZCJcQL2kzYp7DOZ/YjbzPDXnbdJhaFPKs410b4uHed+pz3MnBLL/lpuj
 RzoffVahrg+IG+GcuqCIYzv7V+oYzskosi+urGbXM/K073WTJ7SpGqgPJyxkTWYkftO4ViHxe
 q6q68EJQ75ecAwb3yQxU3EYwiRgFd27EMJegZ6JrtudB9ZDAFOHHP2rXm28mMjTvRq8S6UKSI
 fbdPunrRbR6nouSnj9p+IuLtCPNOCsRwdpfyuFfL/XPVgbS5HsrGQVhQoFzOnat2tVp0v+qfv
 mnkp5y+zR4BM4SOZCSFn8iNOdBBApB4cODtBkrUd6rRapKliHGA85FOkQyAHkft20q2ESN48I
 +WZ/J44
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 08:50 +0200, Sebastian Andrzej Siewior wrote:
> 
> Regarding the preempt_disable() in the original patch in uv_read_rtc():
> This looks essential for PREEMPT configs. Is it possible to get this
> tested by someone or else get rid of the UV code? It looks broken for
> "uv_get_min_hub_revision_id() != 1".

I suspect SGI cares not one whit about PREEMPT.

> Why does PREEMPT_RT require migrate_disable() but PREEMPT only is fine
> as-is? This does not look right.

UV is not ok with a PREEMPT config, it's just that for RT it's dirt
simple to shut it up, whereas for PREEMPT, preempt_disable() across
uv_bau_init() doesn't cut it due to allocations, and whatever else I
would have met before ending the whack-a-mole game.

If I were in your shoes, I think I'd just stop caring about UV until a
real user appears.  AFAIK, I'm the only guy who ever ran RT on UV, and
I only did so because SUSE asked me to look into it.. years ago now.

	-Mike
