Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A44C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4756420855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JZLvs1o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfA3LzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:55:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33804 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfA3LzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:55:16 -0500
Received: from zn.tnic (p200300EC2BCAED00D014CE199A91CB87.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:d014:ce19:9a91:cb87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 093481EC04F3;
        Wed, 30 Jan 2019 12:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548849315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y8YW9rjGmwaLyqrBqccCGo+HHNzQcqZ3OGmjrKup0io=;
        b=JZLvs1o6fykEjPkeZDaykfcQsgAo3WdKAuQ3jPbxSUPI0KVUPQlgQMXkfMxgKt0zHtodY0
        GI8b9gE+fM364UhlqkArfnW9xc5tFeEyqLBDzQwn0r9JssCV5Er7cLd9iPlEHA9EZoLHiL
        2R+msXlvol2xro2LSwOo/0nUz9FGgJ4=
Date:   Wed, 30 Jan 2019 12:55:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 15/22] x86/entry: Add TIF_NEED_FPU_LOAD
Message-ID: <20190130115507.GE18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-16-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-16-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:37PM +0100, Sebastian Andrzej Siewior wrote:
> Add TIF_NEED_FPU_LOAD. This is reserved for loading the FPU registers
> before returning to userland. This flag must not be set for systems
> without a FPU.
> If this flag is cleared, the CPU's FPU register hold the current content
> of current()'s FPU register. The in-memory copy (union fpregs_state) is
> not valid.
> If this flag is set, then all of CPU's FPU register may hold a random
> value (except for PKRU) and it is required to load the content of the
> FPU register on return to userland.

This definitely needs to be written somewhere in

arch/x86/include/asm/fpu/internal.h

or where we decide to put the FPU handling rules.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
