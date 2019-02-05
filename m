Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A444206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rmb0ZCyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfBENQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:16:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBENQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IR5wMkCYQLNTYSViTbLd1ajEmMmnVY7B2XzIeUjuFvM=; b=Rmb0ZCyVfbsXM/yF19zSnNAPS
        YNDrKuI4zZGZabHIB0VExbYjUj0R7AjOPnqskkjxzNQz+7PPoQKAKXTcBXO1ci8cZBt7wBtxpGLn7
        zE5Uuakj8YfstGiWdup12HMEWIND86WDbhbJ8dJBb9fIFecClm3N4GxT86GWF0iLv8PHUb5jcTVL/
        K8CVeEmy7TTkOa8Ujy3w3mNjLNRuyojX6AhlRRY9ngiS4nbDB9f+w0j7zKy+PPrA1h7wLxuH6Aa1S
        Wvv3Fs6gvBTU6KmLs15SJ3x3TMoRfRz4fzb+638+FYD3KuV5Uft4HTSkXBX0FyIdl/cOKSZI9vcj4
        Vs31NAhKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr0Zy-0002r7-Tf; Tue, 05 Feb 2019 13:15:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D2BA2029FA02; Tue,  5 Feb 2019 14:15:57 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:15:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205131557.GD17582@hirez.programming.kicks-ass.net>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190204214044.GN29639@zn.tnic>
 <722af610-da30-2318-9ddd-d991238ce334@intel.com>
 <20190205085750.GM17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205085750.GM17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 09:57:50AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 03:24:23PM -0800, Dave Hansen wrote:
> 
> > Actually, there's one part of all this that I forgot.  Will split lock
> > detection be enumerated _widely_?  IOW, will my laptop in 5 years
> > enumerate support for it?
> 
> I would bloody hope so. Just for giggles, create an little program that
> does LOCK prefix across a line or page boundary in a while(1) loop and
> 'enjoy' your laptop experience.
> 
> > If so, we surely don't want to enable this
> > everyhwhere: it will break old apps.  Doesn't that mean that we need
> > both feature detection and another separate bit for folks to opt-in?
> 
> No, we very much do want to default enable this everywhere.
> 
> We might want to provide some chicken bits, like a (inheritable) PRCTL
> or ELF flag to disable it for those broken apps.

Combined with a sysctl that disables the chickens; such that
administrators can configure their system to be #AC pure.

> But realistically, any app that triggers this is non-portable already,
> most (if not all) the RISC architecture would already kill it with
> SIGBUS for this.
> 
> We very much want the kernel _AND_ firmware to be #AC clean, always,
> everywhere.
> 
> Heck, I'd love for #AC to be even stronger and not only trigger on
> cross-line.
