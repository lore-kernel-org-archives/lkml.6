Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BDDA7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E91208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t1nTpx0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E91208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934813AbeFMIep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:34:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934388AbeFMIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F8dNqoUPtF14WJSDZbvOo9ao6LJ4tabuyRNfPNTpqkk=; b=t1nTpx0phqcLjYUnqs0vZEzp9
        nt7vYSh4eXFH9FPqxCVi0g7SZQ2GpCJ2I6WPmTjfsSqve9CnrXp17j+1/Xx3/02CcdA0joYzKV1bF
        lOh7vqUsVgucQHI+LmpQnWbFw6njnQ41b9AEjaNMPUJMvgALQSd6GkZP8u8exY8SXQN7YVoAZwjHI
        9RxYaKqv86gKKeSytnwkq+EeuCbA5XAPTXhKlTJ+TuXmIKDg8UIcGCEx9sDs/UtTYZZZwR7dnJF3h
        kHCIcXA9Ei4+XybBN3ofD7rHZQlbYoywGFayImNO2TGZy6+s70Wx1VrCA6sTdumSVpuJzCt7d62Mh
        0DFHrHcWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT1ES-0006uT-PD; Wed, 13 Jun 2018 08:34:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C9FA201EA7CB; Wed, 13 Jun 2018 10:34:19 +0200 (CEST)
Date:   Wed, 13 Jun 2018 10:34:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Doug Berger <opendmb@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-ID: <20180613083419.GS12258@hirez.programming.kicks-ass.net>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 5426627..dbc5e02 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -61,6 +61,8 @@
>   *                interrupt handler after suspending interrupts. For system
>   *                wakeup devices users need to implement wakeup detection in
>   *                their interrupt handlers.
> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
> + *                supported by the chip.
>   */

NAK on the first 6 patches. You really _REALLY_ don't want to expose
NMIs to this level.
