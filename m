Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A106C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBFB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JNS0B13O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBFB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:18:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLGKSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:18:23 -0500
Received: from zn.tnic (p200300EC2BCEC90030FF5A381F5D9977.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:30ff:5a38:1f5d:9977])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B5FF1EC0B1A;
        Fri,  7 Dec 2018 11:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544177902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QafImu+or5tPA0Me+BXmiWDEE7v3OvjesYfrEGPW9pc=;
        b=JNS0B13OvagkV7qve1yZ19cO5edMomvctD15a2Ry/r1d9negOXQQ47DWEkUISmd0c2Z92w
        Gvaw3BlL+XM+xobWHiO4JYmGJZIfh2DyMJBwBR9GYWFuhLi9lFTqhe6CA6OtaHRg4sXGiH
        JtDW6nUTn6+YGrEhrVEVAWxIzvntZKY=
Date:   Fri, 7 Dec 2018 11:18:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     ndesaulniers@google.com
Cc:     luto@kernel.org, Fangrui Song <maskray@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/vdso: drop implicit common-page-size linker flag
Message-ID: <20181207101814.GA9385@zn.tnic>
References: <20181206191231.192355-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206191231.192355-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:12:31AM -0800, ndesaulniers@google.com wrote:
> These are implied by the target architecture and for x86_64 match the
> max-page-size. The default for non-NaCl x86_64 is 0x1000 (4096).
> 
> In bfd the common page size is defined as 0x1000 (4096) for non-NaCl

Sodium Chloride?

> x86_64 targets:
> 
> bfd/elf64-x86-64.c:
> 4998:#define ELF_COMMONPAGESIZE             0x1000
> 
> For gold, the common page size is defined as 0x1000 (4096) for non-NaCl
> x86_64 targets:
> 
> gold/x86_64.cc:
> 1413:  0x1000, // common_pagesize (overridable by -z common-page-size)
> 1442:  0x1000, // common_pagesize (overridable by -z common-page-size)
> 
> (ELF_COMMONPAGESIZE also defaults to ELF_MAXPAGESIZE when not set
> explicitly for a target architecture in bfd/elfxx-target.h, but that's
> not relevant for x86_64).
> 
> Because it's implied by the target architecture, it's of questionable
> use to implement in LLD.  This patch resolves one of the issues towards
> using LLD to link an x86_64 kernel.

LLD?

I can only guess what this commit message is about and have to look at
the patch itself and then look at the LD(1) man page and rhyme up what
it is aiming to do.

How about rewriting it for mere mortals?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
