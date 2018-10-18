Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E50C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C5B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0aPYDYxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C5B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeJRPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:54:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=31iYr2gt3LupenHLKywHfE0u3cQ+7guioVNuXuMXjxk=; b=0aPYDYxdc20PdPK5nMKjeslQtg
        zh3odWDoZG5075IPp4G2WZG2cs7StGKteLKeKHbdilNDzFsfc2hEDB/8CWkf/Njh6th7Ti2SnVQKh
        KCszkgGV+LvfaEbqprXLXES/XvcW+EtRIDS3Grdc7Ih7YY9ZcDtkiFnrBy73qmY6ggzwWzC99MXuc
        u/EIGu+WOKvyqkHwOcJKVZWVPKcBt2m6h0mQg+GaexAKoqQSufQq7LNDZrTv1jK8+nCkEDabI5yGG
        tlZ++b7cIALPIBXx1AVWWiJu17rBu2/6HhgLqClmC1Wi7p/5wN2Zw7Qo6hmaev6AgIYstI53eG9/8
        jRvCYZBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gD38D-0002Fs-07; Thu, 18 Oct 2018 07:54:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81FFC2029856A; Thu, 18 Oct 2018 09:54:05 +0200 (CEST)
Date:   Thu, 18 Oct 2018 09:54:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181018075405.GS3121@hirez.programming.kicks-ass.net>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 06:22:48PM -0700, Andy Lutomirski wrote:
> 
> > On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
> > 
> > It is sometimes beneficial to prevent preemption for very few
> > instructions, or prevent preemption for some instructions that precede
> > a branch (this latter case will be introduced in the next patches).
> > 
> > To provide such functionality on x86-64, we use an empty REX-prefix
> > (opcode 0x40) as an indication that preemption is disabled for the
> > following instruction.
> 
> Nifty!
> 
> That being said, I think you have a few bugs.

> First, you can’t just ignore a rescheduling interrupt, as you
> introduce unbounded latency when this happens — you’re effectively
> emulating preempt_enable_no_resched(), which is not a drop-in
> replacement for preempt_enable().

> To fix this, you may need to jump to a slow-path trampoline that calls
> schedule() at the end or consider rewinding one instruction instead.
> Or use TF, which is only a little bit terrifying...

At which point we're very close to in-kernel rseq.
