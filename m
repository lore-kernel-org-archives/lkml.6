Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759FDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D81D2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p985S903"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D81D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJBTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:17:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbeJBTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Di9uCSjiF6Qk5dAEgQHHHJdT0GY25KcK7saRgYTxwc8=; b=p985S9031mrV3r0oh+EqWLkqi
        gWjydpxoZww/7NQS9AGCPndOQATIQtHjbswleO7RGiKG4dNvX97RNwzsKo3fmfJlhQyPfDEEqHkJP
        i0s21rj1VIrCWa09ZsMpG6AsFFrWL7vlToXHChSmfQezhmcOiZYxDEijP7dGLb9Ya3KDQH9fW0CtT
        wJWOeK27G2kcnC1FtXRsb0KeQiVXaepJEbSMgSGeXVyDy6Ot+2S4rJAwxo2s/qmqR3jWBdJE0BeGP
        1xA8T/LikdWzvgUL8hcbQnUeaBEFjIWgTVTugjGqNEY8ngf4iNtJL3QULjlv3OGGGpbOBzipJpGwh
        Or/7Wyy1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7JsY-0006MO-3J; Tue, 02 Oct 2018 12:34:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C94F2025A349; Tue,  2 Oct 2018 14:34:16 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:34:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware
 Scheduling
Message-ID: <20181002123416.GA3439@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-6-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:00AM +0100, Quentin Perret wrote:
> In order to make sure Energy Aware Scheduling (EAS) doesn't hurt
> systems not using it, add a new sched_feat, called ENERGY_AWARE,
> guarding the access to EAS code paths.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  kernel/sched/features.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 85ae8488039c..26ff6752e492 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -90,3 +90,10 @@ SCHED_FEAT(WA_BIAS, true)
>   * UtilEstimation. Use estimated CPU utilization.
>   */
>  SCHED_FEAT(UTIL_EST, true)
> +
> +/*
> + * Energy-Aware Scheduling. Whether or not tasks will be placed into an
> + * energy-aware fashion depends on this feature being enabled and on the
> + * root domain having an Energy Model attached.
> + */
> +SCHED_FEAT(ENERGY_AWARE, false)

So these are debug knobs.. I would expect there to be a regular
static_key that is controlled by the presence of EM data.

Remember, if you compile with SCHED_DEBUG=n, this becomes a compile time
constant: false, and the compiler gets to do lots of DCE.
