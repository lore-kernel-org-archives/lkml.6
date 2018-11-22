Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE875C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9102720866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TD6rNKnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9102720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393887AbeKVUtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:49:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393869AbeKVUtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:49:00 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A73771EC0AD8;
        Thu, 22 Nov 2018 11:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542881413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i2GhZdFswSy8O5JtZOi+k0vsm1MtJprLiBowyrddS0Y=;
        b=TD6rNKnKHoXrmHTysyAThI4smgm1mhGSd76iXiHlqd6QgJ2DJlSeD4OiA2nyqjIL90hzgx
        RkKHzz5DY1jRoGs+Zk8zrQNahuVu0I7cCM7nR1Szu2bdtuR+Eu1nyzunZeMJTasNWvcd7n
        7cOpRVEqJNI6IBr2zroJqsWszowksQk=
Date:   Thu, 22 Nov 2018 11:10:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 15/24] x86/speculation: Add command line control for
 indirect branch speculation
Message-ID: <20181122101007.GB10365@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.764150349@linutronix.de>
 <20181121234312.GI27559@zn.tnic>
 <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
 <20181122091858.GJ2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122091858.GJ2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:18:58AM +0100, Peter Zijlstra wrote:
> Right; that retpoline + IBPB case is one that came up earlier when we
> talked about this stuff. The IBPB also helps against app2app BTB ASLR
> attacks. So even if you have userspace retpoline, you might still want
> IBPB.
> 
> But yes, this should be relatively straight forward to allow/fix with
> the proposed code.

So I got some feedback from AMD that IBPB on context switch has a
small perf impact and they wouldn't mind it being enabled by default
considering that it provides protection against a lot of attack
scenarios. Basically, what the recommendation says.

But if we go and do opt-in, then they're fine with it being off by
default if we decide to do it so in the kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
