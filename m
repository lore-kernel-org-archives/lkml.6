Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0AD20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0AD20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeH3RjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:39:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeH3RjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:39:08 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvN7v-0004CU-An; Thu, 30 Aug 2018 15:36:47 +0200
Date:   Thu, 30 Aug 2018 15:36:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <nadav.amit@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
In-Reply-To: <7202F39D-B4C2-4FA0-868E-2D03BD313BD7@gmail.com>
Message-ID: <alpine.DEB.2.21.1808301535110.1210@nanos.tec.linutronix.de>
References: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org> <7202F39D-B4C2-4FA0-868E-2D03BD313BD7@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Nadav Amit wrote:
> at 8:47 AM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> > In NMI context, we might be in the middle of context switching or in
> > the middle of switch_mm_irqs_off().  In either case, CR3 might not
> > match current->mm, which could cause copy_from_user_nmi() and
> > friends to read the wrong memory.
> > 
> > Fix it by adding a new nmi_uaccess_okay() helper and checking it in
> > copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Nadav Amit <nadav.amit@gmail.com>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> > 
> > Nadav, this is intended for your series.  Want to add it right
> > before the use_temporary_mm() stuff?
> 
> Sure. Thanks! I will apply the following small fix:
> 
> > +
> > +#ifdef CONFIG_DEBUG_VM
> > +	WARN_ON_ONCE(!loaded_mm);
> > +#endif
> 
> Will be changed to VM_WARN_ON_ONCE() in the two instances.

Unless I'm completely lost, this can just be applied to tip right
away. It's not depending on anything else.

Thanks,

	tglx
