Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51EECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5727D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeIRS7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:59:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:59:29 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1EB99CDE;
        Tue, 18 Sep 2018 13:26:52 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:26:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
Message-ID: <20180918132650.GA13255@kroah.com>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
 <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
 <20180918130243.GA25253@kroah.com>
 <07ee2375-382c-154a-4c47-abb1a81b3351@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ee2375-382c-154a-4c47-abb1a81b3351@raspberrypi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 02:13:15PM +0100, Phil Elwell wrote:
> Hi Greg,
> 
> On 18/09/2018 14:02, Greg Kroah-Hartman wrote:
> > On Wed, Sep 12, 2018 at 03:31:55PM +0100, Phil Elwell wrote:
> >> The SC16IS752 is a dual-channel device. The two channels are largely
> >> independent, but the IRQ signals are wired together as an open-drain,
> >> active low signal which will be driven low while either of the
> >> channels requires attention, which can be for significant periods of
> >> time until operations complete and the interrupt can be acknowledged.
> >> In that respect it is should be treated as a true level-sensitive IRQ.
> >>
> >> The kernel, however, needs to be able to exit interrupt context in
> >> order to use I2C or SPI to access the device registers (which may
> >> involve sleeping).  Therefore the interrupt needs to be masked out or
> >> paused in some way.
> >>
> >> The usual way to manage sleeping from within an interrupt handler
> >> is to use a threaded interrupt handler - a regular interrupt routine
> >> does the minimum amount of work needed to triage the interrupt before
> >> waking the interrupt service thread. If the threaded IRQ is marked as
> >> IRQF_ONESHOT the kernel will automatically mask out the interrupt
> >> until the thread runs to completion. The sc16is7xx driver used to
> >> use a threaded IRQ, but a patch switched to using a kthread_worker
> >> in order to set realtime priorities on the handler thread and for
> >> other optimisations. The end result is non-threaded IRQ that
> >> schedules some work then returns IRQ_HANDLED, making the kernel
> >> think that all IRQ processing has completed.
> >>
> >> The work-around to prevent a constant stream of interrupts is to
> >> mark the interrupt as edge-sensitive rather than level-sensitive,
> >> but interpreting an active-low source as a falling-edge source
> >> requires care to prevent a total cessation of interrupts. Whereas
> >> an edge-triggering source will generate a new edge for every interrupt
> >> condition a level-triggering source will keep the signal at the
> >> interrupting level until it no longer requires attention; in other
> >> words, the host won't see another edge until all interrupt conditions
> >> are cleared. It is therefore vital that the interrupt handler does not
> >> exit with an outstanding interrupt condition, otherwise the kernel
> >> will not receive another interrupt unless some other operation causes
> >> the interrupt state on the device to be cleared.
> >>
> >> The existing sc16is7xx driver has a very simple interrupt "thread"
> >> (kthread_work job) that processes interrupts on each channel in turn
> >> until there are no more. If both channels are active and the first
> >> channel starts interrupting while the handler for the second channel
> >> is running then it will not be detected and an IRQ stall ensues. This
> >> could be handled easily if there was a shared IRQ status register, or
> >> a convenient way to determine if the IRQ had been deasserted for any
> >> length of time, but both appear to be lacking.
> >>
> >> Avoid this problem (or at least make it much less likely to happen)
> >> by reducing the granularity of per-channel interrupt processing
> >> to one condition per iteration, only exiting the overall loop when
> >> both channels are no longer interrupting.
> >>
> >> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> >> ---
> >>  drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> >> index 243c960..47b4115 100644
> >> --- a/drivers/tty/serial/sc16is7xx.c
> >> +++ b/drivers/tty/serial/sc16is7xx.c
> >> @@ -657,7 +657,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
> >>  		uart_write_wakeup(port);
> >>  }
> >>  
> >> -static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >> +static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >>  {
> >>  	struct uart_port *port = &s->p[portno].port;
> >>  
> >> @@ -666,7 +666,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >>  
> >>  		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
> >>  		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
> >> -			break;
> >> +			return false;
> >>  
> >>  		iir &= SC16IS7XX_IIR_ID_MASK;
> >>  
> >> @@ -688,16 +688,23 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
> >>  					    port->line, iir);
> >>  			break;
> >>  		}
> >> -	} while (1);
> >> +	} while (0);
> >> +	return true;
> >>  }
> >>  
> >>  static void sc16is7xx_ist(struct kthread_work *ws)
> >>  {
> >>  	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
> >> -	int i;
> >>  
> >> -	for (i = 0; i < s->devtype->nr_uart; ++i)
> >> -		sc16is7xx_port_irq(s, i);
> >> +	while (1) {
> >> +		bool keep_polling = false;
> >> +		int i;
> >> +
> >> +		for (i = 0; i < s->devtype->nr_uart; ++i)
> >> +			keep_polling |= sc16is7xx_port_irq(s, i);
> >> +		if (!keep_polling)
> >> +			break;
> > 
> > This makes me worried, there is no "timeout" now?  What happens if this
> > never happens, will you just sit and spin forever?  What prevents that?
> 
> The patch is keeping to the spirit of the original, which also has a
> potentially infinite loop (in sc16is7xx_port_irq) - this just moves it
> up one level.
> 
> I could add a limit on the number of iterations, but if the limit is ever hit,
> leading to an early exit, the port is basically dead because it will never
> receive another interrupt.

Ok, it's your hardware, good luck with it!  :)

greg k-h
