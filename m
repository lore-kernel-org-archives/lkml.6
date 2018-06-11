Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nqd6LLlAHluaNQAAmS7hNA
	; Mon, 11 Jun 2018 09:28:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D097607A4; Mon, 11 Jun 2018 09:28:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HclKR0yM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C0BC60791;
	Mon, 11 Jun 2018 09:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C0BC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeFKJ2W (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:28:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeFKJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uTXcxqdBOYr7BOY9BJPtQqawOD3qpKqtrJQTyroSX0k=; b=HclKR0yMrGExNWsZta2G2LrE3
        Xu8OFrBjCJkEoRbL1g7C9Mq/aiDCEQb9oW4kL8ENhTiULFtUzvNAQMSn5affe3JZTLFG6tdv0gP3U
        JRfgZiIBKLZ3qLhx/72CcJgTpcHhtiki8XYcKVH7mXsAs/SlunLI0L4jE5qOmGSBKoQL0ai4762Lt
        DEGqFj3aPZcq5Rv99ZpLsNtnn9TaZqjyz6HOQrBfeTnkFvADRGc7Qv90PdSsMX+96rEIASiPN3R4f
        ELCtEZfP67PRjNHzM0KIjtjc6T91D6YMjiWJf3uDQunR/D+frhhdhGm3yL7tz3m/KgxjqaKzzpTfV
        OMT+H5UGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSJ7V-0006BM-DM; Mon, 11 Jun 2018 09:28:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F25D4201EA7A6; Mon, 11 Jun 2018 11:28:10 +0200 (CEST)
Date: Mon, 11 Jun 2018 11:28:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180611092810.GM12217@hirez.programming.kicks-ass.net>
References: <20180419051510.GA21898@mwanda>
 <20180608161219.q3lwvlydvs4l2gxa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608161219.q3lwvlydvs4l2gxa@treble>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:12:19AM -0500, Josh Poimboeuf wrote:
> 1) I've noticed a common pattern for many of the false positives.
>    Smatch doesn't seem to detect when the code masks off the array index
>    to ensure that it's safe.
> 
>    For example:
> 
>    > ./include/linux/mmzone.h:1161 __nr_to_section() warn: potential spectre issue 'mem_section[(nr / (((1) << 12) / 32))]'
> 
>    1153 static inline struct mem_section *__nr_to_section(unsigned long nr)
>    1154 {
>    1155 #ifdef CONFIG_SPARSEMEM_EXTREME
>    1156         if (!mem_section)
>    1157                 return NULL;
>    1158 #endif
>    1159         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>    1160                 return NULL;
>    1161         return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>    1162 }
> 
>    In the 2-D array access, it seems to be complaining about the '[nr &
>    SECTION_ROOT_MASK]' reference.  But that appears to be safe because
>    all the unsafe bits are masked off.
>  
>    It would be great if Smatch could detect that situation if possible.

Also see:

  https://lkml.kernel.org/r/20180425131958.hhapvc3b2i3b4pgy@lakrids.cambridge.arm.com

That exact pattern isn't (immediately) applicable here, but it makes the
general pattern of masking very hard to do.
