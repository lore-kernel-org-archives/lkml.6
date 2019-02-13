Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8816A21901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sbN07MRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfBMJad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:30:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38136 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfBMJac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:30:32 -0500
Received: from zn.tnic (p200300EC2BCDE800B80E9BCAB03A01F8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:b80e:9bca:b03a:1f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D25771EC023E;
        Wed, 13 Feb 2019 10:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550050231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nWhGRHRr+Zy/pEzCUxLY0b2h4C5bMxeBEoMYI11Ts54=;
        b=sbN07MRC5yR8KuAl/7rk1VNOkW0PET2FJTcPP5cc4I6gOY9TH39BW8OMJAgRaErhahGwRQ
        OCdtwN/zhp8IUwkcS0ynV87Rs+qOS8IomD2oi/8NGwvPEEkMRWbZ9/G9bEi4WmrTPJtvHy
        bvUHTrReFkH51vHPuDRCQRGBS8MH0No=
Date:   Wed, 13 Feb 2019 10:30:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 09/22] x86/fpu: Add (__)make_fpregs_active helpers
Message-ID: <20190213093025.GA9683@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-10-bigeasy@linutronix.de>
 <20190128182349.GG20487@zn.tnic>
 <20190207104325.ai5fzaxa7xy7yydv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207104325.ai5fzaxa7xy7yydv@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:43:25AM +0100, Sebastian Andrzej Siewior wrote:
> They are accessible inside the region. But they should not be touched by
> context switch code (and later BH).
> Is that what you meant?

I just don't like that "changes" name. So when called, those functions
practically lock the FPU regs from being accessed by others. So with

fpregs_lock
fpregs_unlock

for example, is kinda clear what's going on and you don't have to wonder
what it does.

> No. I picked up the patches, that function was named like that. I kept
> it. That __ probably denotes that it is an internal function but then it
> has to be used outside (KVM) if they plan to "reload" registers (which
> happens if they switch between host/guest registers).

Ok, so you can drop the "__".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
