Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831EC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391842146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1hxGE8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391842146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeKTTX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:23:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKTTX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nsf58Ztg4xl8ckOTivhDXMMia513PkPI+cm4nopF9hA=; b=W1hxGE8Ai6nGJ5Wtq1b0CdIFw
        edbYTc5RGmVq/Ml9jnXVqQ3RcOhgH7tEAiBrhsMB4uSP1zmvunEIE9oDIe3P3TsDjQ759D8420RkV
        TNU965x/dBZjMKJ6XZvl7SfZEfRLojPf+8bPy8IWp3KNvdI6JLEoUdIXrU9RMdt2XnYc98RExkR2y
        iPrZmNBbUYqTn0+8BGc8bhSrJBkLWd/0a8QSBcBlZqqh541tCJI9+o0jHVks9TRKIa8YH0cQKnyiz
        s6WBY863x+af+wgfoZdPBBCuiCN3s9uA7lk/VO3W5cLAH2HjZtzFH3Sh1dkRQ+/Z2mtwLAeM63Raz
        hJJdgWYOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP1m4-0004Gm-To; Tue, 20 Nov 2018 08:52:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AABC2029FD58; Tue, 20 Nov 2018 09:52:38 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:52:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181120085238.GE2131@hirez.programming.kicks-ass.net>
References: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 03:19:04PM -0800, Dan Williams wrote:

> [1]: https://lore.kernel.org/patchwork/patch/1009434/#1193941
> [2]: https://lore.kernel.org/patchwork/patch/1009434/#1194540

FWIW, that is not the canonical form to refer to emails. Please use:

  https://lkml.kernel.org/r/$msgid

(also, patchwork is even worse crap than lore is for reading emails :/)
