Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5142C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C87721477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C87721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHXWys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:54:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeHXWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:54:48 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BC3FF4F;
        Fri, 24 Aug 2018 19:18:51 +0000 (UTC)
Date:   Fri, 24 Aug 2018 21:18:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Matthias B." <matthias@winterdrache.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824191848.GB15489@kroah.com>
References: <20180824142408.6340d052@ninja>
 <20180824125950.GA29673@kroah.com>
 <20180824154344.1c53a68c@ninja>
 <20180824141254.GB31555@kroah.com>
 <20180824163338.4bd9db8f@ninja>
 <20180824155545.GA6066@kroah.com>
 <20180824181919.36e6b3c7@ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824181919.36e6b3c7@ninja>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 06:19:19PM +0200, Matthias B. wrote:
> Bisect identified the problem. It's the attached patch. I applied it to
> 4.4.152 with patch -Rp1 and I'm running the resulting kernel now.
> 
> MSB
> 
> -- 
> For every idiot-proof system there exists at least one system-proof
> idiot.
> 

> >From 02ff2769edbce2261e981effbc3c4b98fae4faf0 Mon Sep 17 00:00:00 2001
> From: Andi Kleen <ak@linux.intel.com>
> Date: Tue, 7 Aug 2018 15:09:39 -0700
> Subject: [PATCH] x86/mm/pat: Make set_memory_np() L1TF safe
> 
> commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> 
> set_memory_np() is used to mark kernel mappings not present, but it has
> it's own open coded mechanism which does not have the L1TF protection of
> inverting the address bits.
> 
> Replace the open coded PTE manipulation with the L1TF protecting low level
> PTE routines.
> 
> Passes the CPA self test.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [ dwmw2: Pull in pud_mkhuge() from commit a00cc7d9dd, and pfn_pud() ]
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> [groeck: port to 4.4]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/include/asm/pgtable.h | 27 +++++++++++++++++++++++++++
>  arch/x86/mm/pageattr.c         |  8 ++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)

<snip>

Guenter, another report of this patch causing an issue.  Any ideas?  I
am away from test systems this weekend, but can push out patches if
needed.

thanks,

greg k-h
