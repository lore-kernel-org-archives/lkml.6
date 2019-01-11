Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E22C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECAF2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNNmoPgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfAKJY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:24:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfAKJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3bbqLmoBi4UZeRgd7URqMZLeNNe0MRIllp1E7eJVj0A=; b=aNNmoPgsvxPQq61hvQHcor5bA
        0LPvTkpfJ/6vOrRplQ7yTmX6+sHt2N1cWHPnoOkQSHh3hLqzc42ktWwk0XLRarfTDjZu5OTX3AAHw
        8YCHrml7NksXzKYP3YveERj9LXQ7LXne8iSuMkUO+2vpSDvjva6FGxIVM6THVUB0dVUNsnWkYhwf0
        Ks4R4+UanUuhAxT44qHB5eDVc/s4RSPENGw1HZ55p/2fv8EULhstdSmm4GcAE7SjgVxe9YqbP56PC
        htjUC7aAGNucsLsqRxRbT8D1j8vJ4Bd22ffdBVeRCu9PezulCN7pMKumK2iS1mKHE+Iz772bm3UNq
        iZef46nvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ght2v-00080C-Nu; Fri, 11 Jan 2019 09:24:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80185208096AB; Fri, 11 Jan 2019 10:24:08 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:24:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] bitops.h: set_mask_bits() to return old value
Message-ID: <20190111092408.GM30894@hirez.programming.kicks-ass.net>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
 <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:26:27PM -0800, Vineet Gupta wrote:

> @@ -246,7 +246,7 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>  		new__ = (old__ & ~mask__) | bits__;		\
>  	} while (cmpxchg(ptr, old__, new__) != old__);		\

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..2060d26a35f5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -241,10 +241,10 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 	const typeof(*(ptr)) mask__ = (mask), bits__ = (bits);	\
 	typeof(*(ptr)) old__, new__;				\
 								\
+	old__ = READ_ONCE(*(ptr));				\
 	do {							\
-		old__ = READ_ONCE(*(ptr));			\
 		new__ = (old__ & ~mask__) | bits__;		\
-	} while (cmpxchg(ptr, old__, new__) != old__);		\
+	} while (!try_cmpxchg(ptr, &old__, new__));		\
 								\
 	new__;							\
 })


While there you probably want something like the above... although,
looking at it now, we seem to have 'forgotten' to add try_cmpxchg to the
generic code :/
