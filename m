Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeEFHnX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:43:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeEFHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:43:20 -0400
Date: Sun, 6 May 2018 09:43:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
cc: Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>, Matan Barak <matanb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Fix mlx5_get_vector_affinity function
In-Reply-To: <alpine.DEB.2.21.1805060929540.1685@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1805060940220.1685@nanos.tec.linutronix.de>
References: <20180505143838.GA12621@roeck-us.net> <alpine.DEB.2.21.1805060929540.1685@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2018, Thomas Gleixner wrote:
> On Sat, 5 May 2018, Guenter Roeck wrote:
> > > -#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > > -	mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
> > > -#else
> > > -	mask = desc->irq_common_data.affinity;
> > > -#endif
> > > -	return mask;
> > > +	return desc->affinity_hint;
> 
> NAK.
> 
> Nothing in regular device drivers is supposed to ever fiddle with struct
> irq_desc. The existing code is already a violation of that rule and needs
> to be fixed, but not in that way.
> 
> The logic here is completely screwed. affinity_hint is set by the driver,
> so the driver already knows what it is. If the driver does not set it, then
> the thing is NULL.

And this completely insane fiddling with irq_desc is in MLX4 as
well. Dammit, why can't people respect subsytem boundaries and just fiddle
in everything just because they can? If there is something missing at the
core level then please talk to the maintainers instead of hacking utter
crap into your driver.

Yours grumpy

      tglx
