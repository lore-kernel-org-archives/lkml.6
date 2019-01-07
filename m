Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBFD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfAGRye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:54:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfAGRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:54:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A929C80D;
        Mon,  7 Jan 2019 09:54:32 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2533F5A0;
        Mon,  7 Jan 2019 09:54:29 -0800 (PST)
Date:   Mon, 7 Jan 2019 17:54:27 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] include/linux/compiler.h: allow memory operands
Message-ID: <20190107175427.GB22911@fuggles.cambridge.arm.com>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-3-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-3-mst@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 03:57:54PM -0500, Michael S. Tsirkin wrote:
> We don't really care whether the variable is in-register
> or in-memory. Relax the constraint accordingly.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 1ad367b4cd8d..6601d39e8c48 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -154,7 +154,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #ifndef OPTIMIZER_HIDE_VAR
>  /* Make the optimizer believe the variable can be manipulated arbitrarily. */
>  #define OPTIMIZER_HIDE_VAR(var)						\
> -	__asm__ ("" : "=r" (var) : "0" (var))
> +	__asm__ ("" : "=rm" (var) : "0" (var))
>  #endif

I think this can break for architectures with write-back addressing modes
such as arm, where the "m" constraint is assumed to be evaluated precisely
once in the asm block.

Will
