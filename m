Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F035CC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A3E20BF3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X8jwfvor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A3E20BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeGGPHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:07:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60514 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeGGPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7C1h9c1wzyisR628nMZn3UvSb1tgbSF0hGluha+cv5M=; b=X8jwfvoraJZIXQ5BShhNAeLok
        EYSsRrOnOH4OrG99ahIcwbxjfqm97xlagV/Amj3fv4ilqFg/5OjyXb1Za9NmERjez+S6h965HxcOm
        IKvWKv9vnqIMlHq+JlPUtWD2YDLEygXcV46/dKXivL85MyIlNoBgQnpWWNhRZTEU5w1Rs=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42639)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbonS-0003aw-0m; Sat, 07 Jul 2018 16:06:50 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbonP-0000Bq-9N; Sat, 07 Jul 2018 16:06:47 +0100
Date:   Sat, 7 Jul 2018 16:06:45 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
Message-ID: <20180707150645.GD17271@n2100.armlinux.org.uk>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
 <20180705180601.18423-4-mathieu.desnoyers@efficios.com>
 <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
 <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com>
 <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
 <1913049637.1366.1530905741745.JavaMail.zimbra@efficios.com>
 <131696830.1369.1530905931822.JavaMail.zimbra@efficios.com>
 <CA+55aFzuxGtPE2NnL9+K4=OQ=-9oAXSqX-mP_QiHpzBz7zrq6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzuxGtPE2NnL9+K4=OQ=-9oAXSqX-mP_QiHpzBz7zrq6A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:56:58PM -0700, Linus Torvalds wrote:
> On Fri, Jul 6, 2018 at 12:38 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > Should I change all 4 bytes __get_user()/__put_user() in kernel/rseq.c
> > for get_user()/put_user() to ensure consistency ?
> 
> Probably.
> 
> *If* this actually turns out to be somethinig that shows up on
> profiles, it's almost certainly going to be the STAC/CLAC instructions
> ("perf report" tends to report them as three one-byte nop's because
> that's how they look before instruction replacement).
> 
> And then it's not __get/put_user() that will improve things, but doing a
> 
>         user_access_begin();
> 
>         .. do unsafe_get/put_user() ..
> 
>         user_access_end();
> 
> that will improve performance.
> 
> But it is *very* seldom useful. We have it in a handful of places in
> the kernel, and the most noticeable one is
> lib/{strnlen,strncpy_from}_user.c

Also, __get_user() is probably going to become the same as get_user()
when I finish the Spectre v1 ARM mitigations, because there'll be no
point in __get_user() being any different.  For those mitigations,
we're going to have to check the pointer against the address limit
inside __get_user() and NULL it out, just like get_user() does, which
makes the whole distinction between the two completely pointless.

Is this not also the case on other architectures affected by Spectre
variant 1, hmm?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
