Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A1AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79C4208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79C4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbeFUO4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:56:41 -0400
Received: from foss.arm.com ([217.140.101.70]:51044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932752AbeFUO4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:56:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87AC580D;
        Thu, 21 Jun 2018 07:56:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56A803F246;
        Thu, 21 Jun 2018 07:56:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 84BD61AE2E48; Thu, 21 Jun 2018 15:57:16 +0100 (BST)
Date:   Thu, 21 Jun 2018 15:57:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] rseq: Avoid infinite recursion when delivering SIGSEGV
Message-ID: <20180621145715.GF22505@arm.com>
References: <1529582080-31430-1-git-send-email-will.deacon@arm.com>
 <92378910.863.1529592277773.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92378910.863.1529592277773.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:44:37AM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 21, 2018, at 7:54 AM, Will Deacon will.deacon@arm.com wrote:
> 
> > When delivering a signal to a task that is using rseq, we call into
> > __rseq_handle_notify_resume() so that the registers pushed in the
> > sigframe are updated to reflect the state of the restartable sequence
> > (for example, ensuring that the signal returns to the abort handler if
> > necessary).
> > 
> > However, if the rseq management fails due to an unrecoverable fault when
> > accessing userspace or certain combinations of RSEQ_CS_* flags, then we
> > will attempt to deliver a SIGSEGV. This has the potential for infinite
> > recursion if the rseq code continuously fails on signal delivery.
> > 
> > Avoid this problem by using force_sigsegv() instead of force_sig(), which
> > is explicitly designed to reset the SEGV handler to SIG_DFL in the case
> > of a recursive fault. In doing so, remove rseq_signal_deliver() from the
> > internal rseq API and have an optional struct ksignal * parameter to
> > rseq_handle_notify_resume() instead.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > RFC v1 -> v2: Kill rseq_signal_deliver()
> 
> I actually meant to kill _rseq_handle_notify_resume introduced by
> your patch, not rseq_signal_deliver().
> 
> Please keep rseq_signal_deliver() as a static inline, and just remove
> the _rseq_handle_notify_resume() by changing the signature of
> rseq_handle_notify_resume to take an extra sig argument (which can
> be NULL).

Sorry, I misunderstood what you were asking for. I'll spin a v3 in a bit
with rseq_signal_deliver() reintroduced.

Will
