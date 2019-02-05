Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF04C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B664220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pkx4/UcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBEGSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:18:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEGSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:18:08 -0500
Received: from zn.tnic (p200300EC2BCB6B0090E35794C198FCB8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:90e3:5794:c198:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 099AC1EC0943;
        Tue,  5 Feb 2019 07:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549347487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bNDAh8x4IXIDKCqNZ2W68EMbAi5ZMv/mepSYH63Qw78=;
        b=pkx4/UcYSIloxjEDmvbRdKjs4RJgSGlxcLA+fIiH0oRVIqXjSGE+mY2Gu8apWQu4cse5uw
        ccWufTTa3esRNXXFuutd2/AmuFDcdeSf3/LHkeRX1DLuphI9ZUc/z40ALmm3hhxIXMmwCs
        CXAbxPEzYr3BDpkF+V3IWf8nBW09pxk=
Date:   Tue, 5 Feb 2019 07:18:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205061801.GC21801@zn.tnic>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190204214044.GN29639@zn.tnic>
 <722af610-da30-2318-9ddd-d991238ce334@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <722af610-da30-2318-9ddd-d991238ce334@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:24:23PM -0800, Dave Hansen wrote:
> Actually, there's one part of all this that I forgot.  Will split lock
> detection be enumerated _widely_?

You never know what users will do. The moment it gets out, it better be
designed properly, along with the chicken bits.

> IOW, will my laptop in 5 years enumerate support for it?

Don't tell me this is going to be another MPX fiasco :-\

Or is this something along the lines of "let's see whether it takes off
and if yes, we'll commit to it or otherwise remove it and not even waste
a CPUID leaf"?

> If so, we surely don't want to enable this everyhwhere: it will break
> old apps. Doesn't that mean that we need both feature detection and
> another separate bit for folks to opt-in?

Well, if it breaks old apps, it probably needs to be opt-in anyway.

And for that you don't need setcpuid either - you simply boot with
"split_lock_ac" or whatever and the kernel pokes that MSR_TEST_CTL or
whatever else it needs to detect in hw for split lock and sets the
X86_FEATURE bits if detection is successful.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
