Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594BF2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qaTV1rFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfBDVkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:40:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfBDVkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:40:53 -0500
Received: from zn.tnic (p200300EC2BC6E20090E35794C198FCB8.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:90e3:5794:c198:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DF321EC0858;
        Mon,  4 Feb 2019 22:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549316451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Wr4WovlCXPB9Wu/0USl6ADaF6B+zwQgM2M4kqNr+30=;
        b=qaTV1rFkye/MQgvBMyg7R/k7PMK52AJjTtH3QWEjYPz/zFrZn5X2qBlIyxUd7zRfopgkDy
        ZgffQwUVgX+l++Qq+jysRvFlKeSaoevvfmDHij5V9Ys0HzBNdT6t50bMB8ZqHD/N3itrvc
        17Ei3EXEflg5b+ksBBR0w75oRvmquE8=
Date:   Mon, 4 Feb 2019 22:40:45 +0100
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
Message-ID: <20190204214044.GN29639@zn.tnic>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:46:30PM -0800, Dave Hansen wrote:
> Intel can obviously add or remove enumeration for a feature after
> silicon ships.  But, that eats up microcode "patch" space which is an
> even more valuable resource than the microcode "ROM" space.  That patch
> space is a very constrained resource when creating things like the
> side-channel mitigations.  The way I read this situation is that this
> feature fills a bit small of a niche to justify consuming patch space.

Yap, makes sense. I've heard that argumentation before, btw.

> So, the compromise we reached in this case is that Intel will fully
> document the future silicon architecture, and then write the kernel
> implementation to _that_.

Yap.

> Then, for the weirdo deployments where this feature is not enumerated,
> we have the setcpuid= to fake the enumeration in software.
>
> The reason I'm pushing for setcpuid= instead of a one-off is that I
> don't expect this to be the last time Intel does this. I'd rather have
> one setcpuid= than a hundred things like "ac_split_lock_disable".

So my only issue with this is the user having to type this in in order
to get the feature.

VS

automatically enabling it during boot in early_init_intel() or so. No
need for any user intervention. It'll be just like a forgotten CPUID bit
and we've done those before.

The disable chicken bits you have for all those features which are
enumerated in CPUID anyway so there'll be no difference.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
