Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6315C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869FC20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSPIFE8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869FC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJaAZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:25:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeJaAY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0hegZxhfmbRjPRN/c6ofJzXZUVbI7/brjSCLj5N1B3U=; b=JSPIFE8K4wKDJvXW5iodychsb
        xlV83Z6DoGBBHMWG/fpQ8z2mQg7gpSYvqLlQJ74mku8tP01j3g5Z+9PAEfjgfkXixX1dvzygIUd/T
        0FC17TEx91PMmHc7V00H7agnkZDPR400oxxQKaj4Bnv5nnXF6DwFUZ6vVlCKzyJIeAxKI7hO773ha
        AEeNZjOlmuEs9utDDQAaNuaRDYS55yM4LkRfLwA0E1pZv0fs0ukTBBraDmX+HaUsAlTw6w5veiF8B
        PMPTfcgI7Jj47vG6u4gpo+m8VSXA7oIIhdVR7qxURkXIy4X8H38MxIIIicjn/ceL3lrerpXf4wZ7q
        xMiVSCKnA==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHPXA-0007G0-D5; Tue, 30 Oct 2018 08:38:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 816AB202A40A3; Tue, 30 Oct 2018 09:36:50 +0100 (CET)
Date:   Tue, 30 Oct 2018 09:36:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, bp@suse.de,
        hpa@zytor.com
Subject: Re: [PATCH 3/3] kprobes/x86: Simplify indirect-jump check in
 retpoline
Message-ID: <20181030083650.GB1459@hirez.programming.kicks-ass.net>
References: <cc8f9981-f327-4238-8378-262579584db4@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8f9981-f327-4238-8378-262579584db4@default>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:55:06PM -0700, Zhenzhong Duan wrote:
> Since CONFIG_RETPOLINE hard depends on compiler support now, so
> replacing indirect-jump check with the range check is safe in that case.

Can we put kprobes on module init text before we run alternatives on it?

> @@ -240,20 +242,16 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
>  
>  static int insn_is_indirect_jump(struct insn *insn)
>  {
> -	int ret = __insn_is_indirect_jump(insn);
> +	int ret;
>  
>  #ifdef CONFIG_RETPOLINE
> -	/*
> -	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
> -	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
> -	 * older gcc may use indirect jump. So we add this check instead of
> -	 * replace indirect-jump check.
> -	 */
> -	if (!ret)
> +	/* Jump to x86_indirect_thunk_* is treated as an indirect jump. */
>  		ret = insn_jump_into_range(insn,
>  				(unsigned long)__indirect_thunk_start,
>  				(unsigned long)__indirect_thunk_end -
>  				(unsigned long)__indirect_thunk_start);
> +#else
> +		ret = __insn_is_indirect_jump(insn);
>  #endif
>  	return ret;
>  }

The resulting code is indented wrong.
