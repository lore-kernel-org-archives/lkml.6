Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827982064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BMfaIcBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANTcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:32:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANTcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:32:17 -0500
Received: from zn.tnic (p200300EC2BC4CA000555087DEC7D7788.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:555:87d:ec7d:7788])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43CF41EC02FF;
        Mon, 14 Jan 2019 20:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547494336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Avr/p5DlTxKluwzmh6NWMv1oKZil+gypj7eGxSrjGgk=;
        b=BMfaIcBsmP/bnYvlaWDDltsT4enNV2EfrPSQ/F21gnRk5MWbQHZ8cxSHbA7abuOWv4x7I7
        JJ1asFTEHEZikfNNLZkaKsuNwEWayyp38Q8enTcaltRQCw6a9Z1uXNrI4mTJKcrkPBIBz6
        NTTJUuQNHUmkIcdJGNbFF1pDDBqARFU=
Date:   Mon, 14 Jan 2019 20:32:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 04/22] x86/fpu: Always init the `state' in fpu__clear()
Message-ID: <20190114193214.GR2773@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-5-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:26PM +0100, Sebastian Andrzej Siewior wrote:
> fpu__clear() only initializes the `state' if the FPU is present. This
> initialisation is also required for the FPU-less system and takes place

"in math_emulate()."

> math_emulate(). Since fpu__initialize() only performs the initialization
> if ->initialized is zero it does not matter that it is invoked each time
> an opcode is emulated. It makes the removal of ->initialized easier if
> the struct is also initialized in FPU-less case at the same time.

				in the

> 
> Move fpu__initialize() before the FPU check so it is also performed in
> FPU-less case.

in the...

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 1 -
>  arch/x86/kernel/fpu/core.c          | 5 ++---
>  arch/x86/math-emu/fpu_entry.c       | 3 ---
>  3 files changed, 2 insertions(+), 7 deletions(-)

With that fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
