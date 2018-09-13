Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32720ECDFD3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E7217AE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173E7217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIMW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:28:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeIMW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:28:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D84B3D09;
        Thu, 13 Sep 2018 17:17:38 +0000 (UTC)
Date:   Thu, 13 Sep 2018 19:17:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jbeulich@suse.com,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4.14] x86/pae: use 64 bit atomic xchg function in
 native_ptep_get_and_clear
Message-ID: <20180913171714.GA26169@kroah.com>
References: <CAKf6xpvseyNJtbr3fp=qH4kMeJReBd=fm5Kn-DpqoZL25moVqg@mail.gmail.com>
 <20180913155611.10854-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913155611.10854-1-jandryuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:56:11AM -0400, Jason Andryuk wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> commit b2d7a075a1ccef2fb321d595802190c8e9b39004 upstream
> 
> Using only 32-bit writes for the pte will result in an intermediate
> L1TF vulnerable PTE. When running as a Xen PV guest this will at once
> switch the guest to shadow mode resulting in a loss of performance.
> 
> Use arch_atomic64_xchg() instead which will perform the requested
> operation atomically with all 64 bits.
> 
> Some performance considerations according to:
> 
> https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf
> 
> The main number should be the latency, as there is no tight loop around
> native_ptep_get_and_clear().
> 
> "lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
> memory operand) isn't mentioned in that document. "lock xadd" (with xadd
> having 3 cycles less latency than xchg) has a latency of 11, so we can
> assume a latency of 14 for "lock xchg".
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Atomic operations gained an arch_ prefix in commit
> 8bf705d130396e69c04cd8e6e010244ad2ce71f4
> s/arch_atomic64_xchg/atomic64_xchg/ for backport.
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Thanks for the fix, I've now queued it up everywhere and will push out
-rc2 versions of this.

greg k-h
