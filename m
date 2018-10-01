Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32351C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E362145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E362145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeJBACs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:02:48 -0400
Received: from muru.com ([72.249.23.125]:57984 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeJBACs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:02:48 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 26A0C80F0;
        Mon,  1 Oct 2018 17:28:26 +0000 (UTC)
Date:   Mon, 1 Oct 2018 10:23:57 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix runtime PM handling
Message-ID: <20181001172356.GX5662@atomide.com>
References: <20180928224056.GA10486@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928224056.GA10486@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [180928 22:45]:
> On Thu, May 10, 2018 at 03:13:56PM +0100, Phil Edworthy wrote:
> > When using kgdb, you get an abort when accessing the UART registers.
> > This is because the driver has already entered runtime PM and so turned
> > off the bus clock needed to access the registers.
> > 
> > To fix this, set the capability indicating Runtime PM is active while idle.
> > 
> 
> With this patch applied, I get the already reported traceback [1].
> Obviously neither the promised revert [2] nor the presumed fix [3] made it
> into the mainline Kernel.
> 
> Greg, can you please revert this patch ? If people don't care enough
> to fix the problem, we should at least not have to suffer the consequences.

Yes please revert until things are fixed.

FYI, what Andy and I discussed earlier is that we can disable
runtime PM for serial layer by taking a PM runtime use count
on the serial driver if there is an active console but we need
a way to attach/detach kernel serial consoel via /sys to prevent
regressions with PM.

So how do we attach/detach kernel serial console? We don't seem
to have a way to attach/detach a kernel console to a UART via
/sys do we? Or am I again 10 years behind or something?

We have /sys/class/vtconsole to bind and unbind a frame
buffer console though.

Andy, do you have your updated patches available somewhere?

Regards,

Tony


> [1] https://www.spinics.net/lists/linux-serial/msg30379.html
> [2] https://www.spinics.net/lists/linux-serial/msg30380.html
> [3] https://www.spinics.net/lists/linux-serial/msg30757.html
