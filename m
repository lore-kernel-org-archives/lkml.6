Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10400C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E992083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AtSkMjV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfBDO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:28:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDO2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:28:42 -0500
Received: from zn.tnic (p200300EC2BC6E200586F742EFBEF042E.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:586f:742e:fbef:42e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 196921EC014B;
        Mon,  4 Feb 2019 15:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549290520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QWaSI9Kzgqtb8SEtCk6Q1g3OhoIUSGko6l3DVOvT7k=;
        b=AtSkMjV3V26u12tYepdjk6o9U9Pk4aRuwarM6f5IGq/OIK+z2V5XsIvRa2phDllI9Zpd8B
        uuiWlDwk5b69HGShQwpAEW34F3RmpjU/s2F8unqxcQyun4nUQo17fsPzOF7AfXDbkRf0qc
        sHuQzSqsCV3rWSo/aGkNjUr+0YORPEg=
Date:   Mon, 4 Feb 2019 15:28:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <namit@vmware.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 03/20] x86/mm: temporary mm struct
Message-ID: <20190204142829.GD29639@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-4-rick.p.edgecombe@intel.com>
 <20190131112948.GE6749@zn.tnic>
 <C481E605-E19A-4EA6-AB9A-6FF4229789E0@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C481E605-E19A-4EA6-AB9A-6FF4229789E0@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:19:54PM +0000, Nadav Amit wrote:
> Having a different struct can prevent the misuse of using mm_structs in
> unuse_temporary_mm() that were not “used” using use_temporary_mm. The
> typedef, I presume, can deter users from starting to play with the internal
> “private” fields.

Ok, makes sense.

> > That prev.prev below looks unnecessary, instead of just using prev.
> > 
> >> +	struct mm_struct *prev;
> > 
> > Why "prev”?
> 
> This is obviously the previous active mm. Feel free to suggest an
> alternative name.

Well, when I look at the typedef I'm wondering why is it called "prev"
but I guess this is to mean that it will be saving the previously used
mm, so ack.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
