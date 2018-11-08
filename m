Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C668ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD12081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD12081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKIAdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:33:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34926 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKIAdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:33:25 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FCJ-YN9CqQDK; Thu,  8 Nov 2018 15:57:32 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C83401EC0779;
        Thu,  8 Nov 2018 15:57:31 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:57:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 02/23] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181108145721.GC7543@zn.tnic>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107194858.9380-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 08:48:37PM +0100, Sebastian Andrzej Siewior wrote:
> This is a preparation for the removal of the ->initialized member in the
> fpu struct.
> __fpu__restore_sig() is deactivating the FPU via fpu__drop() and then
> setting manually ->initialized followed by fpu__restore(). The result is
> that it is possible to manipulate fpu->state and the state of registers
> won't be saved/restore on a context switch which would overwrite state.

		restored

> 
> Don't access the fpu->state while the content is read from user space
> and examined / sanitized. Use a temporary buffer kmalloc() buffer for

one "buffer" too many.

More importantly, what I'm missing here is more detailed explanation
about how that manipulation can happen. Especially since the comment
over fpu__drop() you're removing below is claiming the exact opposite.
AFAICT.

Yeah, FPU code has always been nasty and tricky to follow so I think
we'd need to have this stuff explained in much more detail.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
