Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F50CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0AE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhVJDzbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfBLNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:38:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbfBLNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e+HDU8Tn9mRjXpui4+zibNX2Wg/bAhW747qwF6G2erE=; b=LhVJDzbCFIbY/EYOXl0v6KhES
        2Eyah2HIKUEyGJ/PCRGBHg0taYjH7Yesc/mq7X6xWHwyqcntpms/TT7TEfHaH7v7t+ChrjMhHHwYv
        NUlIgKVMkTWfveXRakeHvBU4pEMyLcsTJsT2hXEDCqslW1uPHd5zP+CyX997gILXb7YEhjvsvG7i6
        NHh6jjxo9AMcDvuAjqOYGbEIzuCKuUgYGyQsvd3p8Zgyk4Vh8SkdcUAxT7ZquuPgkDyCb8zX6dzki
        eh6JBMQFlrf2LjBEntmoSTh3aH0/1vREjLCnARQQ2/qm4bMC/sLJZkZsTnfsDWK8EWCDccvej8Hwo
        2Vxk4IWOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtYG0-0004wT-A1; Tue, 12 Feb 2019 13:37:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9339120D0C1D8; Tue, 12 Feb 2019 14:37:50 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:37:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190212133750.GJ32494@hirez.programming.kicks-ass.net>
References: <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
 <20190205170415.GG17550@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
 <20190211191643.GB103371@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211191643.GB103371@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:16:43AM -0800, Fenghua Yu wrote:
> 4. The feature can be disabled by kernel option
> "clearcpuid=split_lock_detection" during early boot time.

IFF clearcpuid lives, it should also employ CPUID faulting and clear it
for userspace too.
