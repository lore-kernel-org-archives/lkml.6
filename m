Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313ACC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB75521019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098146;
	bh=9fPvEs/PgoQJvwCEzm5MVBesbZMOcsYpOdVVRUXs97s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGBg+EPPyOD2dSuttuX4ZJdLSG6mdsKzYSPQuYtKlzhSIs+3epT/W125dVc49xgvk
	 wg9yxDnY5+gkVt68hinhkxiqUKw1tMCWrLa9qkndCk5os8MjhU+4eTa2LnboCjqp9/
	 oCLR1lS8mnS31Yx0TSq/PJOZBzZD8jhZwSwkP2JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfAUTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfAUTPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:15:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC52D2089F;
        Mon, 21 Jan 2019 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548098143;
        bh=9fPvEs/PgoQJvwCEzm5MVBesbZMOcsYpOdVVRUXs97s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdkw6Sx7rdfdAlIyZsB2CHz/w77+d136iOeZGU2dm5z9uPefs+b4w1FnxqeVSdm6S
         z4h7/tstUMLhJ4G+ym9p36ToBYrSKRg+C5eqAZ8fdI1CzAGCVpqhDkAztuMf7dlJoO
         kGCWFIE6wF1Z2og9FnaqKMjonCSHQmyxQuWRyTYg=
Date:   Mon, 21 Jan 2019 20:15:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC] x86/speculation: add L1 Terminal Fault / Foreshadow demo
Message-ID: <20190121191541.GB4026@kroah.com>
References: <1548076208-6442-1-git-send-email-jsteckli@amazon.de>
 <20190121183618.GP6118@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121183618.GP6118@tassilo.jf.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:36:18AM -0800, Andi Kleen wrote:
> > + 	/* Check the start address: needs to be page-aligned.. */
> > +-	if (start & ~PAGE_MASK)
> > ++	if (start & ~PAGE_MASK) {
> > ++
> > ++		/*
> > ++		 * XXX Hack
> > ++		 *
> > ++		 * We re-use this error case to show case a cache load gadget:
> > ++		 * There is a mispredicted branch, which leads to prefetching
> > ++		 * the cache with attacker controlled data.
> > ++		 */
> > ++		asm volatile (
> 
> Obviously that can never be added to a standard kernel.

No, that's why it is a patch, right?  People want to test things, it's
nice to have a way to easily do this.

> And I don't see much point in shipping test cases that require non
> standard kernel patching. The idea of shipping test cases is that
> you can easily test them, but in this form it can't.

It's better than having nothing at all, which is what we have today.  So
I see no harm in it, only benefits.

thanks,

greg k-h
