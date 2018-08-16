Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E95C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D362147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D362147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbeHPPov convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeHPPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:44:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868C22147D;
        Thu, 16 Aug 2018 12:46:28 +0000 (UTC)
Date:   Thu, 16 Aug 2018 08:46:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tobias Waldekranz <tobias@waldekranz.com>
Cc:     Tobias Waldekranz <tobias.waldekranz@westermo.se>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY)
Subject: Re: [PATCH] net: phy: add tracepoints
Message-ID: <20180816084626.19f516c9@gandalf.local.home>
In-Reply-To: <20180816093056.2485-1-tobias@waldekranz.com>
References: <20180816093056.2485-1-tobias@waldekranz.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 11:30:53 +0200
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Two tracepoints for now:
> 
>    * `phy_interrupt` Pretty self-explanatory.
> 
>    * `phy_state_change` Whenever the PHY's state machine is run, trace
>      the old and the new state.

From a tracing perspective, this patch looks fine,

  Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

But below I have a possible improvement.

> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/phy/phy.c      |  4 +++
>  include/trace/events/phy.h | 68 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 include/trace/events/phy.h
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9aabfa1a455a..8d22926f3962 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -38,6 +38,9 @@
>  
>  #include <asm/irq.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/phy.h>
> +
>  #define PHY_STATE_STR(_state)			\
>  	case PHY_##_state:			\
>  		return __stringify(_state);	\
> @@ -1039,6 +1042,7 @@ void phy_state_machine(struct work_struct *work)
>  	if (err < 0)
>  		phy_error(phydev);
>  
> +        trace_phy_state_change(phydev, old_state);

I see that you are passing in a enum phy_state.

>  	if (old_state != phydev->state)
>  		phydev_dbg(phydev, "PHY state change %s -> %s\n",
>  			   phy_state_to_str(old_state),
> diff --git a/include/trace/events/phy.h b/include/trace/events/phy.h
> new file mode 100644
> index 000000000000..7ba6c0dda47e
> --- /dev/null
> +++ b/include/trace/events/phy.h
> @@ -0,0 +1,68 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM phy

You can add this:

#define PHY_STATE_ENUMS	\
	EM( DOWN ) 	\
	EM( STARTING )	\
	EM( READY )	\
	EM( PENDING )	\
	EM( UP )	\
	EM( AN )	\
	EM( RUNNING )	\
	EM( NOLINK )	\
	EM( FORCING )	\
	EM( CHANGELINK )\
	EM( HALTED )	\
	EMe(RESUMING)

#undef EM
#undef EMe

#define EM(a) TRACE_DEFINE_ENUM( PHY_##a );
#define EMe(a) TRACE_DEFINE_ENUM( PHY_##a );

PHY_STATE_ENUMS

#undef EM
#undef EMe

#define EM(a) { PHY_##a, #a },
#define EMe(a) { PHY_##a, #a }

> +
> +#if !defined(_TRACE_PHY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PHY_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(phy_interrupt,
> +	    TP_PROTO(int irq, struct phy_device *phydev),
> +	    TP_ARGS(irq, phydev),
> +	    TP_STRUCT__entry(
> +		    __field(int, irq)
> +		    __field(int, addr)
> +		    __field(int, state)
> +		    __array(char, ifname, IFNAMSIZ)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->irq = irq;
> +		    __entry->addr = phydev->mdio.addr;
> +		    __entry->state = phydev->state;
> +		    if (phydev->attached_dev)
> +			    memcpy(__entry->ifname,
> +				   netdev_name(phydev->attached_dev),
> +				   IFNAMSIZ);
> +		    else
> +			    memset(__entry->ifname, 0, IFNAMSIZ);
> +		    ),
> +	    TP_printk("phy-%d-irq irq=%d ifname=%16s state=%d",

Here you can have "state=%s"

> +		      __entry->addr,
> +		      __entry->irq,
> +		      __entry->ifname,
> +		      __entry->state

And here you can have:

			__print_symbolic(__entry->state,
					PHY_STATE_ENUMS )

> +		    )
> +	);
> +
> +TRACE_EVENT(phy_state_change,
> +	    TP_PROTO(struct phy_device *phydev, enum phy_state old_state),
> +	    TP_ARGS(phydev, old_state),
> +	    TP_STRUCT__entry(
> +		    __field(int, addr)
> +		    __field(int, state)
> +		    __field(int, old_state)
> +		    __array(char, ifname, IFNAMSIZ)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->addr = phydev->mdio.addr;
> +		    __entry->state = phydev->state;
> +		    __entry->old_state = old_state;
> +		    if (phydev->attached_dev)
> +			    memcpy(__entry->ifname,
> +				   netdev_name(phydev->attached_dev),
> +				   IFNAMSIZ);
> +		    else
> +			    memset(__entry->ifname, 0, IFNAMSIZ);
> +		    ),
> +	    TP_printk("phy-%d-change ifname=%16s old_state=%d state=%d",
> +		      __entry->addr,
> +		      __entry->ifname,
> +		      __entry->old_state,
> +		      __entry->state

And do the same above for both old_state and state.

Then instead of just printing numbers and having to remember what state
goes with what number (and god forbid those enums were to change), you
would get actual names of the states, and be easier to read the trace
output.

Note, I didn't test what I wrote, there could be a bug, but it
shouldn't be too far off from what I'm trying to get at.

-- Steve


> +		    )
> +	);
> +
> +#endif /* _TRACE_PHY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

