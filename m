Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D84C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FD0208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD0208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeFULwH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:52:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933134AbeFULwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:52:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9321529;
        Thu, 21 Jun 2018 04:52:04 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C5883F578;
        Thu, 21 Jun 2018 04:52:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 90A561AE2E48; Thu, 21 Jun 2018 12:52:40 +0100 (BST)
Date:   Thu, 21 Jun 2018 12:52:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH] rseq: Avoid infinite recursion when delivering
 SIGSEGV
Message-ID: <20180621115240.GE22505@arm.com>
References: <1529512560-28007-1-git-send-email-will.deacon@arm.com>
 <10453618.15.1529513735208.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10453618.15.1529513735208.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:55:35PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 20, 2018, at 12:36 PM, Will Deacon will.deacon@arm.com wrote:
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
> > of a recursive fault.
> 
> Your approach looks good. One nit below implementation-wise:

Nit accepted :) v2 on its way.

Will
