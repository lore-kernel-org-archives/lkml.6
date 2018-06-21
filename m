Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B46C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDD21D5B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjuTpZns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFDD21D5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbeFUTrJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:47:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbeFUTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dKdoQVcn+6m/IbgEsL3ircDvr5obJhV5m/yv5lJzpKE=; b=qjuTpZnsEPMnynJGGerZA6BVu
        U3yFJRHig4RI7hc29BzY9Xat7y48FGC5sXFKpFM2MIUjnn0w/naY6n9E0oHu0EbsNPN0UGg1JY2V+
        cZDr7O8shNRk38GLzIGT2MqTRg49D0P649BuKJ46HEiBhw7DKH5pDmzX6RpcmKgmjaD8NfCwFhYoI
        OnyD0Rsm6Qtxq9jO4LU3MRXckDe1mOGilo7rvbFSOYDu2jfsFeCpOZigGeW8ekbcqsfuznzS+ikVv
        VDxQ13yk/TbaB+6GSTs8eQgbHC2kUfcrey1joTCS5tS5HdLq6jccZvzpvukkRPI4glKLXZdNZ8Win
        R2LSOGPlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW5Xn-0001FK-Ej; Thu, 21 Jun 2018 19:46:59 +0000
Received: by worktop (Postfix, from userid 1000)
        id 5E1D06E093E; Thu, 21 Jun 2018 21:46:56 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:46:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180621194656.GB13636@worktop.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 08:45:51AM -0700, Fenghua Yu wrote:
> When #AC exception for split lock is triggered from a kernel instruction,
> by default we don't want the exception to panic the whole system. Instead,
> the exception handler should log the fault information for debug and
> continue the instruction execution.

This should not happen today, did you find any unaligned LOCK insns?

This is a lot of code to 'handle' something that really should not ever
happen. Maybe just WARN and clear the MSR bit, nothing complicated.

Also, fix your "disgusting drug-induced crap" comments.
