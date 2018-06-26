Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00226753
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kzyv/B1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A00226753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFZJFa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:05:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5HnFJlEBXCJWXk4heeE+tksCcwl5EsAYSjWyU5u/SjE=; b=Kzyv/B1smohZj3/+J6BT4Jcu+
        tMzc/tlsKYmvg1P7upfp1T8DwNFP2HlFN4xvC0sVbahyt8vZujTqABXDt0IHGCCwcCmOWyOrIvUfO
        ZTeIKdsA/4h3LqzXDM76mMDghJkNoenqZNfbMAiarbQjQ8lBgwsWjlOrNQlAH7lXqrP84gaYT0YOr
        u36xcVMmXoAglY29/8mFBMJCccnrOZwNZZp0yTJgJKW6MO45LAOCQS/NQhI/PpD2qyUqa6tJjF95r
        qCsIvCv3Io21iTo8D56BSQzO13EgGIRfmKC2T4K8uol0Irs1EaLCEmIwlVOWdj+EZ4PIMBnlMbBU5
        6k6yQPMWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXjud-0000ee-Nd; Tue, 26 Jun 2018 09:05:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDD622029F1D5; Tue, 26 Jun 2018 11:05:21 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:05:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Cox <alan@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split
 lock in firmware in boot time and restore the setting in reboot
Message-ID: <20180626090521.GF2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
 <20180621195823.GD13636@worktop.programming.kicks-ass.net>
 <1529680267.4364.50.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529680267.4364.50.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:11:07PM +0100, Alan Cox wrote:
> On Thu, 2018-06-21 at 21:58 +0200, Peter Zijlstra wrote:
> > On Sun, May 27, 2018 at 08:45:55AM -0700, Fenghua Yu wrote:
> > > Firmware may contain split locked instructions.
> > 
> > I think that's the wrong attitude. You should mandate in your BIOS
> > development guide that Firmware _MUST_NOT_ contain unaligned LOCK
> > prefixed instructions.
> > 
> 
> In the longer term I would agree entirely with that sentiment.

But then how do we deal with SMIs ? The firmware people will at least
need to know about this, and the quick fix is to make the SMI handler
save/restore the MSR, but since they're aware and already changing their
code, they might as well fix the actual problem -- which is likely
trivial.

So no, I don't buy it. Just fix the firmware instead of allowing them to
fester and grow layers of ducttape.

Because even for SMM WRMSR is 100s of cycles, and why would they want to
make every single SMI more expensive.

Also, as mentioned earlier, what are we going to do about SMIs in
general? They're a _far_ _FAR_ bigger problem for RT workloads than a
sporadic split atomic. Esp. with some vendors thinking they can run
bitcoin miners in SMI (or whatever else it is that is taking miliseconds
of compute time).

Split atomics are an insignificant problem compared to the nightmare
trainwreck that is SMM.
