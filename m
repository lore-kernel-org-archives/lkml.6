Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D883C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089BE25AD3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZE4HAxWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089BE25AD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934044AbeFYNtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:49:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933983AbeFYNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rJrcEJWv2SyO0fTBpNPxZM6DdoMUkg2ZxTOUkjJVMJE=; b=ZE4HAxWupcHxqyybM5uNyvb0B
        JQ9xniAbkNFd4TTcfZ6zuS1cNZyeTOH9cTNxMVaeEMqkNHuhbooaHK0t19Q1S588+T45/Vj6YMFN6
        FHrA37oN3poenroLdIVZDWzHFNNa2IEVD8wb/JRrnM3eCv0/vQjfbge8KAwvQeRniD0piF7b9XYpl
        VsrpCmnPWVq4vvY/Z8AkZ3/6bJnOD+gzSL/803I+feKIiwrVN5OG2swwpjOEeQEcfXkB8bmtsZ68N
        MiYeNhh9zzHvimr2l1WomESWTUZGA6rpc9q+o5sqqmBsOt4hGExLr2DhskQiA8628/bEaWtbd6uAp
        em+z6f5bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXRrQ-0006TM-V2; Mon, 25 Jun 2018 13:48:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EC722029F1DB; Mon, 25 Jun 2018 15:48:51 +0200 (CEST)
Date:   Mon, 25 Jun 2018 15:48:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Message-ID: <20180625134851.GB2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com>
 <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net>
 <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:32:41AM -0400, Pavel Tatashin wrote:
> > It _should_ all work.. but scary, who knows where this early stuff ends
> > up being used.
> 
> I have tested this patch

Sure,.. but call me paranoid.

> However, the other way to fix this bug is to change:
> arch/x86/kernel/jump_label.c
> 
> -void arch_jump_label_transform(struct jump_entry *entry,
> +void __ref arch_jump_label_transform(struct jump_entry *entry,
>                                enum jump_label_type type)
>  {
> +       void *(*poker)(void *, const void *, size_t) = NULL;
> +
> +       if (unlikely(!after_bootmem))
> +               poker = text_poke_early;
> +
>         mutex_lock(&text_mutex);
> -       __jump_label_transform(entry, type, NULL, 0);
> +       __jump_label_transform(entry, type, poker, 0);
>         mutex_unlock(&text_mutex);
>  }

No need to elide that mutex I think, by going through the normal
static_key_enable() stuff you already take a whole bunch of them, and
they should work early just fine (no contention etc.).

Also, I think the better condition is @early_boot_irqs_disabled, until
we enable IRQs for the first time, text_poke_early() should be fine. And
once we enable interrupts, all that other crud should really be working.

This gives:

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..425ba6102828 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -46,6 +46,9 @@ static void __jump_label_transform(struct jump_entry *entry,
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
+	if (early_boot_irqs_disabled)
+		poker = text_poke_early;
+
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			/*

> Also, modify text_poke_early to call sync_core().

and that.
