Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30ACC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD6F22438
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wOsbE/Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD6F22438
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeGESFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:05:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeGESFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LrTvPfC6gZ84+BiplJcgusDzGTOkKRssYS7e2v5kEmM=; b=wOsbE/WomtJXRYwBfLuSFN3It
        3RMUUQn3IxY/yRdZcccvSHQpdXGSKSCDx3kEh0nm5Kx4jWn9zzDZw2OpXjwkd3K0LFyyoKf3iW596
        edJcxdst8dH0OHB5VKJE/0lSnHm53LiP148iugJ+oAGdCnd8cn5fa2w5jBU0UFRA9uGc41UMVK5a+
        K2YQzZo2a5Azns/u+6Ij3RckPV1DWRCfXwa9GyqeeHpc2Exi4foyVbyvzHXIWXE0QYBPNbXwnBGLD
        xUNOtfVoLnzEgXnQvOstaAzwpYArlwRpQcZOyAEDzVAf190+FaeUcvE7SP8bIAqRU4XxUoq/PTZAi
        2Du4KRpsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8cr-0002qM-4X; Thu, 05 Jul 2018 18:05:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 733CA20289CF4; Thu,  5 Jul 2018 20:05:03 +0200 (CEST)
Date:   Thu, 5 Jul 2018 20:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180705180503.GH2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:19AM +0800, Guo Ren wrote:
> +static irqreturn_t handle_ipi(int irq, void *dev)
> +{
> +	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> +
> +	while (true) {
> +		unsigned long ops;
> +
> +		/* Order bit clearing and data access. */
> +		mb();
> +
> +		ops = xchg(pending_ipis, 0);
> +		if (ops == 0)
> +			return IRQ_HANDLED;
> +
> +		if (ops & (1 << IPI_RESCHEDULE))
> +			scheduler_ipi();
> +
> +		if (ops & (1 << IPI_CALL_FUNC))
> +			generic_smp_call_function_interrupt();
> +
> +		BUG_ON((ops >> IPI_MAX) != 0);
> +
> +		/* Order data access and bit testing. */
> +		mb();
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
> +
> +void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
> +{
> +	if (send_arch_ipi)
> +		return;
> +
> +	send_arch_ipi = func;
> +}
> +
> +static void
> +send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
> +{
> +	int i;
> +
> +	mb();
> +	for_each_cpu(i, to_whom)
> +		set_bit(operation, &ipi_data[i].bits);
> +
> +	mb();
> +	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
> +}


Please explain those mb()'s... I'm thinking you meant to use smp_mb().

But then for handle_ipi(), the xchg() should already imply all those.
And the send_ipi_message() only needs the second.

