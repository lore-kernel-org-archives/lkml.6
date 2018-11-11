Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD115C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB33214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB33214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeKLDVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:21:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLDVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:21:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D4D80D;
        Sun, 11 Nov 2018 09:32:16 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140C53F5BD;
        Sun, 11 Nov 2018 09:32:14 -0800 (PST)
Date:   Sun, 11 Nov 2018 17:32:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, zhizhouzh@gmail.com
Subject: Re: [PATCH] ftrace: remove KASAN poison in ftrace_ops_test()
Message-ID: <20181111173211.q2gzf7h4htxbezch@salmiak>
References: <1541949017-3001-1-git-send-email-zhizhouzhang@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541949017-3001-1-git-send-email-zhizhouzhang@asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:10:17PM +0800, Zhizhou Zhang wrote:
> ftrace_ops_test() passed local varible parameter to hash_contains_ip(),
> which could result KASAN stack-out-of-bounds warning.
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f536f60..6e11f90 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1522,6 +1522,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
>  	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
>  	rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
>  
> +	kasan_unpoison_task_stack(current);

This is extremely heavy-handed, and will mask legitimate stack-out-of-bounds
errors. 

Passing a stack-local variable by reference *should not* result in KASAN
warnings unless KASAN itself is broken. Can you please give an example report
when this occurs?

Which compiler are you using?

Thanks,
Mark.

> +
>  	if (hash_contains_ip(ip, &hash))
>  		ret = 1;
>  	else
> -- 
> 2.7.4
> 
