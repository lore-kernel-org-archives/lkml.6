Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE573C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953B20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMrIWzf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8953B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393691AbeKVUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:42:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731866AbeKVUmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y+21ZkLfbrWzf9aEyQJB9VO+jjn3O4nwsFzDvOeUV4Y=; b=qMrIWzf87MfzuzV6wOaXsB9vE
        jjTD1Id1lLVAkEvw4MlJdZzMRWYZNsjRsz2JNbCeEWfVNCaTxnusVS5IXSLsYs7KUTet9YaPrt3r4
        kONs6PCc7wD3e4Fx2HLc548IPj6ZHSTLlqs8Cq2P29SLb1KMzzhkMbhc/qt3Vu6uSXGY1lBGCD4tH
        e5YYp3zSVfa4ouF/yjQPbOBkvV7lnqAt62MVtGiNKVV3khdpMt1Oz/JnXT/JuqdRdUdcxPhVqVekr
        oj9lWZvyMenWR7PC53IlVf3IyUHfDhGtIbfK5eS4yRB/fjJENhzZECUKGigdyX1LZXMgvP++e/LZf
        UD7Visv3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPlpb-0003Cf-Tb; Thu, 22 Nov 2018 10:03:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EDD32029FD58; Thu, 22 Nov 2018 11:03:22 +0100 (CET)
Date:   Thu, 22 Nov 2018 11:03:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
Subject: Re: [for-next][PATCH 15/18] function_graph: Use new curr_ret_depth
 to manage depth instead of curr_ret_stack
Message-ID: <20181122100322.GN2131@hirez.programming.kicks-ass.net>
References: <20181122002801.501220343@goodmis.org>
 <20181122003333.592319701@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122003333.592319701@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 07:28:16PM -0500, Steven Rostedt wrote:
> @@ -188,14 +186,20 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	struct ftrace_graph_ent trace;
>  
>  	trace.func = func;
> -	trace.depth = current->curr_ret_stack + 1;
> +	trace.depth = ++current->curr_ret_depth;
>  
>  	/* Only trace if the calling function expects to */
>  	if (!ftrace_graph_entry(&trace))
> -		return -EBUSY;
> +		goto out;
>  
> -	return ftrace_push_return_trace(ret, func, &trace.depth,
> -					frame_pointer, retp);
> +	if (ftrace_push_return_trace(ret, func,
> +				     frame_pointer, retp))

You can unwrap that line, by my counting that's at 69 chars, so unless
you're editing on a C64 it should fit your screen.

> +		goto out;
> +
> +	return 0;
> + out:
> +	current->curr_ret_depth--;
> +	return -EBUSY;
>  }

[diff "default"]
	xfuncname = "^[[:alpha:]$_].*[^:]$"

avoids the need for that ludicrous label indenting.

Also, "error" might be a better label name.
