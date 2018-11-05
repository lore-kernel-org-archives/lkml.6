Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E75C20868
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E75C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeKESe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:34:59 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:33464 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbeKESe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:34:59 -0500
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gJazL-0003gS-Ly; Mon, 05 Nov 2018 10:16:03 +0100
Date:   Mon, 5 Nov 2018 10:16:03 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     David Miller <davem@davemloft.net>
Cc:     kurt@linutronix.de, anirudh@xilinx.com, John.Linn@xilinx.com,
        michal.simek@xilinx.com, radhey.shyam.pandey@xilinx.com,
        andrew@lunn.ch, yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
Message-ID: <20181105091601.5dgwkcd4wcsw2cvp@breakpoint.cc>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-2-kurt@linutronix.de>
 <20181030.112511.957438343014682098.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030.112511.957438343014682098.davem@davemloft.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-30 11:25:11 [-0700], David Miller wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> Date: Tue, 30 Oct 2018 10:31:38 +0100
> 
> > The function could report a false positive if it gets preempted between reading
> > the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
> > the condition has to be rechecked to avoid false positives.
> > 
> > Therefore, check for expected condition even after the timeout occurred.
> > 
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>  ...
> >  		if (time_before_eq(end, jiffies)) {
> > -			WARN_ON(1);
> > -			return -ETIMEDOUT;
> > +			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
> > +			break;
> >  		}
> > +
> >  		udelay(1);
> >  	}
> > -	return 0;
> > +	if (val & XAE_MDIO_MCR_READY_MASK)
> > +		return 0;
> > +
> > +	WARN_ON(1);
> > +	return -ETIMEDOUT;
> 
> You are not fundamentally changing the situation at all.

> The condtion could change right after your last read of
> XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
> modifications to this code.
> 
> It sounds more like the timeout is slightly too short, and that's the
> real problem that causes whatever behavior you think you are fixing
> here.

There is a timeout of two jiffies. If the condition is not true within
those two jiffies it will attempt to check condition one last time after
the timeout occured.
If the task got preempted after the reading from the register but before
the timeout it is possible that the task gets back on the CPU after the
timeout occured. And since the timeout occured it won't check if the
condition changed:
Time
 0   +---+
     | c | Check for condition (false)
     | c |
     | c |
     | c |
     | c |
     | P | Task gets preempted
     |   |
     | O | Condition is true, task still preempted, no check
     |   |
 2   | T | The timeout is true
     |   |
     |   |
     |   |
     | p | Task gets back on the CPU, no re-check of condition

In the last step, there is no checking of the condition after the
timeout occured and it wrongly assumes that the condition is not true.
Increasing the timeout would help as long as the task gets not preempted
past the new timeout.
The same pattern (check condition after timeout) is also used in
wait_event_timeout() or readx_poll_timeout().  Would you prefer to
refactor this with readx_poll_timeout() instead?

> I'm not applying this.
Please reconsider.

Sebastian
