Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C03C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82412146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82412146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeK3Tie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:38:34 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:35131 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK3Tie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:38:34 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 459705C09BF; Fri, 30 Nov 2018 08:29:26 +0000 (UTC)
Date:   Fri, 30 Nov 2018 09:29:26 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Message-ID: <20181130082926.GA6517@osadl.at>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
 <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
 <20181130075453.GB2456@osadl.at>
 <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:09:30AM -0800, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-11-29 23:54:53)
> > On Thu, Nov 29, 2018 at 03:45:23PM -0800, Stephen Boyd wrote:
> > > Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> > > > The kmalloc here is small (< 16 bytes) and occurs during initialization
> > > > during system startup here (can not be built as module) thus if this
> > > > kmalloc failed it is an indication of something more serious going on
> > > > and it is fine to hang the system here rather than cause some harder
> > > > to understand error by dereferencing NULL.
> > > > 
> > > > Explicitly checking would not make that much sense here as the only
> > > > possible reaction would be would BUG() here anyway.
> > > > 
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > ---
> > > 
> > > Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
> > > reason why we would want it here either. Just handle the failure, or
> > > don't care if this is so critical to system boot.
> > >
> > It was not motivated by the criticality but by the low probability
> > and cluttering the code for this case did not seem good to me.
> > Effectively handling it here means BUG() - so more or less
> > the same result that hanging it on __GFP_NOFAIL if allocation
> > was not possible would cause.
> > 
> > Not clear what the objection to __GFP_NOFAIL here is - my understanding
> > was that it is intended precisely for cases like this - but
> > I´ll send a V2 handling it with BUG_ON(!clk_name) if that is prefered.
> > 
> 
> Or just WARN() and return. Maybe something else can get far enough to be
> helpful.
> 
> I would also appreciate if this sort of problem could be caught earlier
> in code review and/or with some automated scripting. Debating BUG_ON()
> and allocation failures is not what I look forward to doing so please
> try to make this exact sort of patch never make it to the list in the
> first place.
>
well it was found by a experimental coccinelle script
I´m trying to write up semi-formal specifications for
APIs so that this can be tested automatically and cought early.

If you put in a WARN() here it would still allow for the
NULL pointer to be passt on potentially corupting memory in the following 
snprintf()->vsnprintf() which does not seem to check for !buf 


thx!
hofrat
