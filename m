Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11626C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB598208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB598208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeHGLNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:13:02 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47157 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbeHGLNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:13:02 -0400
X-IronPort-AV: E=Sophos;i="5.51,454,1526335200"; 
   d="scan'208";a="341629592"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 10:59:40 +0200
Date:   Tue, 7 Aug 2018 10:59:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Mao Wenan <maowenan@huawei.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtmutex: Drop pointless static qualifier in
 rt_mutex_adjust_prio_chain()
In-Reply-To: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
Message-ID: <alpine.DEB.2.20.1808071058100.3351@hadrien>
References: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2018, Mao Wenan wrote:

> There is no need to have the 'T *v' variable static
> since new value always be assigned before use it.

The code is:

		static int prev_max;

		/*
		 * Print this only once. If the admin changes the limit,
		 * print a new message when reaching the limit again.
		 */
		if (prev_max != max_lock_depth) {

So it is referenced before it is initialized.

julia


>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 2823d41..ba70db8 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -472,7 +472,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
>  	 * We limit the lock chain length for each invocation.
>  	 */
>  	if (++depth > max_lock_depth) {
> -		static int prev_max;
> +		int prev_max;
>
>  		/*
>  		 * Print this only once. If the admin changes the limit,
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
