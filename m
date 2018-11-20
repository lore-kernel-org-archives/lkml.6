Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2597BC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6690206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E4uOmZO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6690206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeKUAch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:32:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R5LxcDBX+qQn3dR4Q4gGpRnVPPQOFgB3dLXXY9Ysj6k=; b=E4uOmZO1AHUJ+q6wi2FAmbNXw
        kY91lWPGaZSfMdtSWo+p3wLAtl+Nl/BWfnaQ/TsXOSaTXy/XAnKvkRJmQOJisrjX7i+fZWFQ21NXq
        X+jqf6BzYQrI8RMB5EDBhG5lQ58AlkWNkz+Z0xnR3ujHwyGnydTnPpPAjoXm+eoqpWyPiP0GkLi7O
        PZsOWUr+rYjW1NtDTpUkLtgT3bblCGfWElALnrtvqYkAZDE/gi/jRK3TLj9MGkFASTkF+Z6uaJr1g
        nc785SCwwKbVF0wWuppGYkBW7HzvE3bK/WKbhIXwaBlEsdFi7CLjFkcWT27FKGSrYQ6gKo0jWdbkX
        7ou7gU4yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6c8-0000qB-FJ; Tue, 20 Nov 2018 14:02:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF8952029F87F; Tue, 20 Nov 2018 15:02:50 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:02:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 13/25] context_tracking: Introduce
 context_tracking_enabled_cpu()
Message-ID: <20181120140250.GT2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-14-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-14-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:57AM +0100, Frederic Weisbecker wrote:
> This allows us to check if a remote CPU runs context tracking
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
>  include/linux/context_tracking_state.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 08f125f..5877177 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -31,6 +31,11 @@ static inline bool context_tracking_enabled(void)
>  	return static_branch_unlikely(&context_tracking_key);
>  }
>  
> +static inline bool context_tracking_enabled_cpu(int cpu)
> +{
> +	return per_cpu(context_tracking.active, cpu);
> +}
> +
>  static inline bool context_tracking_enabled_this_cpu(void)
>  {
>  	return __this_cpu_read(context_tracking.active);

Should not the last two be something like:

static inline bool context_tracking_enabled_cpu(int cpu)
{
	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
}

static inline bool context_tracking_enabled_this_cpu(void)
{
	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
}

Because, afaict, not all callsites first check the static key.
