Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515CC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZOaEKqZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850D12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeKUAej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:34:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKUAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lcXJPPCGXDKW1H11/v9aEe9iz4zninRANp7o5D2qo5E=; b=ZOaEKqZjPnY5lSRmox26mS8Ud
        t3IODCi61oJtlE6uqLWtRtPkHJKcSA4OH0rP/BKUJvTWUyFeMS0lBWdNVBZHNlCPBzfhV8WbGsWb9
        ch/je87d11G4SaLS9aWAcZyvC5LVWxWXMXw6eeTAf22M6q3DYmUJGWRSXvYz5LgudVChvrShrg5Bj
        3ys3tjGgU8GMldDO3gjSze1pMbytbQcwp5wNj4y+GU44d80pLqkyUTHSdo3IYQsgRYHgGLKeDj3i3
        4xv6cn/saMrBjdmMfc9VolFRHss35kVBhZmu1Hg3bD5tZhe19660RQUmkRfI92/0YFVD/8Nqg74lK
        5BrPkJ8wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6eB-0008O6-KY; Tue, 20 Nov 2018 14:04:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56C762029F87F; Tue, 20 Nov 2018 15:04:58 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:04:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 15/25] sched/vtime: Introduce
 vtime_accounting_enabled_cpu()
Message-ID: <20181120140458.GU2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-16-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-16-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:59AM +0100, Frederic Weisbecker wrote:
> This allows us to check if a remote CPU runs vtime accounting
> (ie: is nohz_full). We'll need that to reliably support "nice"
> accounting on kcpustat.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/vtime.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 82fed7a..a53f6ea 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -31,6 +31,16 @@ static inline bool vtime_accounting_enabled(void)
>  	return context_tracking_enabled();
>  }
>  
> +static inline bool vtime_accounting_enabled_cpu(int cpu)
> +{
> +	if (vtime_accounting_enabled()) {
> +		if (context_tracking_enabled_cpu(cpu))
> +			return true;
> +	}
> +
> +	return false;
> +}

static inline bool vtime_account_enabled_cpu(int cpu)
{
	return vtime_account_enabled() && context_tracking_enabled_cpu(cpu);
}

Hmm?
