Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD8C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FB720879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FB720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeLEQii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:38:38 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:39474 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeLEQih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:38:37 -0500
X-Greylist: delayed 666 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 11:38:36 EST
Received: from toshiba (85-76-49-126-nat.elisa-mobile.fi [85.76.49.126])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 91951B00BE;
        Wed,  5 Dec 2018 18:27:28 +0200 (EET)
Message-ID: <5C07FC30.43601034@users.sourceforge.net>
Date:   Wed, 05 Dec 2018 18:26:24 +0200
From:   Jari Ruusu <jariruusu@users.sourceforge.net>
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        " Radim =?iso-8859-1?Q?Kr=3Fm=E1=3F?=" <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 4.14 121/146] x86/fpu: Disable bottom halves while loading 
 FPU registers
References: <20181204103726.750894136@linuxfoundation.org> <20181204103731.697870447@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> commit 68239654acafe6aad5a3c1dc7237e60accfebc03 upstream.
> 
> The sequence
> 
>   fpu->initialized = 1;         /* step A */
>   preempt_disable();            /* step B */
>   fpu__restore(fpu);
>   preempt_enable();
> 
> in __fpu__restore_sig() is racy in regard to a context switch.

That same race appears to be present in older kernel branches also.
The context is sligthly different, so the patch for 4.14 does not
apply cleanly to older kernels. For 4.9 branch, this edit works:

    s/fpu->initialized/fpu->fpstate_active/

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -342,10 +342,10 @@ static int __fpu__restore_sig(void __use
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		local_bh_disable();
 		fpu->fpstate_active = 1;
-		preempt_disable();
 		fpu__restore(fpu);
-		preempt_enable();
+		local_bh_enable();
 
 		return err;
 	} else {
