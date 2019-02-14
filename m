Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65309C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F220842
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502947AbfBNT66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:58:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:58:57 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1CFFB3E;
        Thu, 14 Feb 2019 19:58:56 +0000 (UTC)
Date:   Thu, 14 Feb 2019 11:58:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?=C5=81ukasz?= Siudut <lsiudut@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] psi: avoid divide-by-zero crash inside virtual machines
Message-Id: <20190214115855.76869aecd777fbd37d48f45c@linux-foundation.org>
In-Reply-To: <20190214193157.15788-1-hannes@cmpxchg.org>
References: <20190214193157.15788-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 14:31:57 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -322,7 +322,7 @@ static bool update_stats(struct psi_group *group)
>  	expires = group->next_update;
>  	if (now < expires)
>  		goto out;
> -	if (now - expires > psi_period)
> +	if (now - expires >= psi_period)
>  		missed_periods = div_u64(now - expires, psi_period);
>  
>  	/*

It seems appropriate to use time_after64() and friends in this code.

