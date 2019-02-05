Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3570DC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C09217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f9WHTPuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfBEPnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbfBEPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:20 -0500
Received: from zn.tnic (p200300EC2BCB6B00244CCF9C8D56D337.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:244c:cf9c:8d56:d337])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A05A21EC0229;
        Tue,  5 Feb 2019 16:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549381398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=X1vMKrLb28yWHq2CP/gd/lEJL/Tqn4anOE3PJOAduGM=;
        b=f9WHTPuGyR8bphc3CXEBOB4VYCooozCl+dg5wvNDCjVT1X/RFaSOnQfxKzi0rfKHKRGe8q
        qRaYHcmC9Rq9Pc+UBsNXAVDUmXhTIuKn2xCWrjmdGufGEgxZYkJSmhrhh4GDt1sEd8UEtI
        qTgETlX1ok//bmDq8I/t5M+N7eXs/3k=
Date:   Tue, 5 Feb 2019 16:43:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205154309.GU21801@zn.tnic>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:19:16AM -0800, Dave Hansen wrote:
> This is one of the few times that we're pretty confident that folks will
> use this.  The reason we're going to this trouble is that the split lock
> detection is wanted by actual customers, and they want it before it's
> implemented on a processor with real enumeration.
>
> This isn't something we want everybody and their grandma to turn on;
> it's a rather specialized feature.  It's really only for folks that care
> about the latency incurred across the entire system on split lock
> operations.

...

> It's not for developers.  This really is for (somewhat niche) end users
> that want split lock detection in production.  This is all really an
> effort to get them running mainline or real distro kernels.

This all sounds to me like it shouldn't even be mainline but in a
special, evaluation kernel. If anything, it should be default off and be
opted-in by a cmdline switch. None of that *cpuid=* toggling dance.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
