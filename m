Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4386C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D12020657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D12020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeJaWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:05:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbeJaWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:05:01 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1gHqCx-0000m5-L7; Wed, 31 Oct 2018 14:06:51 +0100
Date:   Wed, 31 Oct 2018 14:06:51 +0100
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     David Miller <davem@davemloft.net>
Cc:     anirudh@xilinx.com, John.Linn@xilinx.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, andrew@lunn.ch,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
Message-ID: <20181031130651.l4toezvyg4etevnh@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-2-kurt@linutronix.de>
 <20181030.112511.957438343014682098.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030.112511.957438343014682098.davem@davemloft.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:25:11AM -0700, David Miller wrote:
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
>
> The condtion could change right after your last read of
> XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
> modifications to this code.

That's true. The problem is different: If the current task gets
preempted by a higher priority task between checking the condition and
the timeout code, then a timeout might be falsely detected. Consider the
following events:

loop:
 check mdio condition
 ------------------------
 task with real time priority may run for a long time
 ------------------------
 check for timeout
 wait

That's why I've added the recheck of the condition in the timeout case.

>
> It sounds more like the timeout is slightly too short, and that's the
> real problem that causes whatever behavior you think you are fixing
> here.

The timeout value is not the problem here.

Thanks,
Kurt
