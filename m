Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC15C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDE62146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDE62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeIRReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:34:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:34:00 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1BD6CD7;
        Tue, 18 Sep 2018 12:01:42 +0000 (UTC)
Date:   Tue, 18 Sep 2018 14:01:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk,
        Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com,
        robh@kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/10] serial: uartps: Add run time support for more
 IPs than hardcoded 2
Message-ID: <20180918120140.GA31835@kroah.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
 <ac23383e-3d54-1cd2-c1f4-219c8ee306d2@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac23383e-3d54-1cd2-c1f4-219c8ee306d2@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:54:31PM +0200, Michal Simek wrote:
> Hi Greg,
> 
> On 3.9.2018 15:10, Michal Simek wrote:
> > Hi,
> > 
> > this series is trying to address discussion I had with Alan in past
> > https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
> > https://lkml.org/lkml/2018/4/26/551.
> > 
> > These patches are doing preparation to enable dynamic ID port allocation
> > which is capable to create devices with higher IDs.
> > 
> > For example this is how it works.
> > uart0 on higher alias
> > serial0 = &uart1;
> > serial30 = &uart0;
> > 
> > ~# ls -la /dev/ttyPS*
> > crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
> > crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS30
> > 
> > Thanks,
> > Michal
> > 
> > Changes in v3:
> > - New patch found by testing
> > - New patch - can be sent separately but there is dependency that's why
> >   sent in this series
> > - Fix uart_unregister_driver() in error path or when driver is removed.
> > - Change commit message
> > - s/,/;/ in filling structure
> > - get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs
> > - New patch in series
> > - Rebase on the top of previous broken patch
> > - Change patch subject ("was serial: uartps: Remove CDNS_UART_NR_PORTS
> >   macro")
> > - Keep CDNS_UART_NR_PORTS in this patch and remove it in next one and
> >   align commit message to reflect this
> > - Allocate struct console dynamically too to be unique for every
> >   instance
> > - Cleanup error path
> > - New patch in series
> > 
> > Changes in v2:
> > - new patch - it can be sent separately too
> > - new patch - it can be sent separately too
> > - new patch - it can be sent separately too
> > - Remove nr field logic
> > - new patch - it can be sent separately too
> > - Register one uart_driver with unique minor at probe time
> > 
> > Michal Simek (9):
> >   serial: uartps: console_setup() can't be placed to init section
> >   serial: uartps: Do not initialize field to zero again
> >   serial: uartps: Do not use static struct uart_driver out of probe()
> >   serial: uartps: Move alias reading higher in probe()
> >   serial: uartps: Move register to probe based on run time detection
> >   serial: uartps: Fill struct uart_driver in probe()
> >   serial: uartps: Change logic how console_port is setup
> >   serial: uartps: Register own uart console and driver structures
> >   serial: uartps: Move Port ID to device data structure
> > 
> > Nava kishore Manne (1):
> >   serial: uartps: Fix suspend functionality
> > 
> >  drivers/tty/serial/xilinx_uartps.c | 203 +++++++++++++++++++------------------
> >  1 file changed, 107 insertions(+), 96 deletions(-)
> > 
> 
> Can you please look at this series?
> I have sent 2 more patches on the top of this series where OF patch was
> reviewed by Rob already.

My tty queue is a bit lagging right now, sorry, will get to that soon...

greg k-h
