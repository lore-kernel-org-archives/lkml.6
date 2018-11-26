Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6D120862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpk9Gg04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6D120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeK0DDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:03:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rVK3OSg+fplJdhi3jagWzpvWC8ZlL1m038W+Id1YYL8=; b=gpk9Gg04pRfCb0cZzDketA/I2
        g93caYkhr2MkPCcFQyZsWmpSi0YbIpCzqShWlWrOfFYRKW71hITqh3ylqe65j/TkI8FSheWX3sWU9
        PeiIm+FxW7Z/SUUHC1GNZOlb/ZgmXPFyEjCSzidUa7gmh6qFwQbFwcCdbF7GOI7r9AequcicV7GpL
        hJYjdEixXeF1amdmT/7VFSJMDlPuwVZBgX65nmSDWIfBVkEzBAwfi9RKFLDDC0EXp2iDCPRRsRnys
        YoBnvKyDUK9Nv/h1iYNK+49CsCnu9/A4IrMrPMhbRBGxH+mgMMwGtl1Oj92cqArfk0Z5wEbnz9sCf
        JK/JGCKaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRJR9-0008FN-6W; Mon, 26 Nov 2018 16:08:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEDD42029F87F; Mon, 26 Nov 2018 17:08:37 +0100 (CET)
Date:   Mon, 26 Nov 2018 17:08:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126160837.GS2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +void arch_static_call_defuse_tramp(void *site, void *tramp)
> +{
> +	unsigned short opcode = INSN_UD2;
> +
> +	mutex_lock(&text_mutex);
> +	text_poke((void *)tramp, &opcode, 2);
> +	mutex_unlock(&text_mutex);
> +}
> +#endif

I would rather think that makes the trampoline _more_ dangerous, rather
than less so.

My dictionary sayeth:

  defuse: verb

    - remove the fuse from (an explosive device) in order to prevent it
      from exploding.

    - make (a situation) less tense or dangerous

patching in an UD2 seems to do the exact opposite.
