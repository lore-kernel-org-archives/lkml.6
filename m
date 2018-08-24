Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE48C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E22147D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkirNp9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5E22147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHXWQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeHXWQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:16:55 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729FB2147A;
        Fri, 24 Aug 2018 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535136067;
        bh=SdIomO4MEFSUrqg/ntH9iYImSYSAyiElDBzJnU1VqA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkirNp9f+/6ywNgcR0jEND+/iJT1GTesQDREly9YrwqBVl0e5T+EY3i4M0x52BQDT
         xGcakgN6aPEWG02GwLwUeGbQ7+6eIPt7880eBc8370l1Oci+NlRlymB6G/lXDAfycX
         TKttY9ARutfIKKOFNU+Ww1LAxk/IxS5MPwja6q18=
Date:   Fri, 24 Aug 2018 20:41:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
Message-ID: <20180824184103.GD2730@lerouge>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
 <20180824061750.GA20523@kroah.com>
 <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
 <0d63c2bb-f75d-3f79-c19d-bb4ac9a00cd5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d63c2bb-f75d-3f79-c19d-bb4ac9a00cd5@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:10:44AM -0500, Grygorii Strashko wrote:
> Yes. i do not see local_softirq_pending messages any more
> 
> But one question, just to clarify, after patch "nohz: Fix missing tick reprog while interrupting inline timer softirq"
> the tick_nohz_irq_exit() will be called few times in case of nested interrupts (min 2):
> gic_handle_irq
>  |- irq_exit
>     |- preempt_count_sub(HARDIRQ_OFFSET); 
>     |-__do_softirq 
> 	<irqs enabled>
> 	|- gic_handle_irq()
> 	   |- irq_exit()
> 		|- tick_irq_exit()
> 		   if (!in_irq())
> 			tick_nohz_irq_exit(); <-- [1]
>     |- tick_irq_exit()
> 	if (!in_irq())
> 		tick_nohz_irq_exit(); <-- [2]
> 
> Is it correct? in 4.14 tick_nohz_irq_exit() is much more complex then in LKML now,
> and this is hot path.

That's correct and it's indeed more costly in 4.14 as then the tick is going to be programmed
twice.
