Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55511C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064DB21722
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLyijwEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064DB21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeFVITf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:19:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeFVITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A4U8hP6rw2wgMEe57XXxeN238PMayIt6TYvvhA3Tv24=; b=YLyijwEKN65RCFrriLFB+CcSC
        vdCDY2tSD+6LtLkV/NYzAfC779vECcG+NfHErFLY9ChVVYAwpGC2PwaROOE7+33CignF1UkZ+qzIA
        dToo6r1NloaGHp6e2PNmm+wTnc4HlFRzCnmuszVE2+CA+UA0BccyWeC6pXRSLZ/If/AfebVOp8luR
        V9tgPp61O26NWu47h8quAMcVn90UeP0tfiPp3uf2AtMh6fCwXshFoE26aJvbWYow8WVbilXJeCRB9
        cHDgqEIz/tgc2aNIwng+wfL1ds3z7LrwzNmP8G5qRcMbu+Lkhezk9A04E+A4eqj1v1iqw6tmNN7yK
        TU2I4Dx6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWHHy-0002Yg-Lq; Fri, 22 Jun 2018 08:19:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F28BB2029F1D5; Fri, 22 Jun 2018 10:19:24 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:19:24 +0200
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
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180622081924.GH2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
 <20180621221006.GC2494@hirez.programming.kicks-ass.net>
 <20180621230501.GC18979@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621230501.GC18979@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:05:02PM -0700, Fenghua Yu wrote:

> But in a real case, when I enable #AC for split lock in kernel, reboot
> hits #AC because of split lock in firmware code and firmware handles #AC
> as fatal error and stops continuing to run.
> 
> It will take long time/forever for firmware to fix the split lock issue.
> Before the firmware issue is fixed, reboot or S4 cannot run if the feature
> is enabled by kernel.

Then it will take a long time / forever for people to use their machines
as they need. Don't you see that is a problem?

Either you take this real-time stuff serious and force BIOS monkeys to
get with the act, this includes no #AC but also very much force them
into abandoning SMM as a fail^Wfeature-platform.

Or it's all a joke and we'll continue to complain and shame..

> And if unlucky, I'm afraid the patch set even has no chance to be merged to
> upstream if maintainer's test machine has firmware split lock issue and the
> machine simply cannot reboot or go to S4 if the feature is enabled.

Well, then you'd better get those BIOS monkeys on board and fixing their
crap.
