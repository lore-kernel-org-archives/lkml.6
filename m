Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125E82146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125E82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeK3TD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:03:56 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:35099 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:03:56 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 3F7E25C099D; Fri, 30 Nov 2018 07:54:53 +0000 (UTC)
Date:   Fri, 30 Nov 2018 08:54:53 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Message-ID: <20181130075453.GB2456@osadl.at>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
 <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:45:23PM -0800, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> > The kmalloc here is small (< 16 bytes) and occurs during initialization
> > during system startup here (can not be built as module) thus if this
> > kmalloc failed it is an indication of something more serious going on
> > and it is fine to hang the system here rather than cause some harder
> > to understand error by dereferencing NULL.
> > 
> > Explicitly checking would not make that much sense here as the only
> > possible reaction would be would BUG() here anyway.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> 
> Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
> reason why we would want it here either. Just handle the failure, or
> don't care if this is so critical to system boot.
>
It was not motivated by the criticality but by the low probability
and cluttering the code for this case did not seem good to me.
Effectively handling it here means BUG() - so more or less
the same result that hanging it on __GFP_NOFAIL if allocation
was not possible would cause.

Not clear what the objection to __GFP_NOFAIL here is - my understanding
was that it is intended precisely for cases like this - but
I´ll send a V2 handling it with BUG_ON(!clk_name) if that is prefered.


thx!
hofrat
