Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA24C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D0320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhxDDfRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D0320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeJEVON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:14:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+2Hg3x+DThcI5Dql16qLdvIGmJ3ZNOO2ZjgVB3KbByQ=; b=VhxDDfRakhA7KvlOrldiJzTiu
        WlsJ6C3CDGpqOjkNRtwN0eVpdrQ4FM2n3tDHa7+xV6XQ5m7ZfyMOrN6TaLYvLFRPsSbp2QT/U1bED
        /DgO3nz1C4X7i2ObbiGm45DXABKMSqBFV7EJx4Gj/KqHajM/7t4MNk/8MYg5wRqXipXZCfOvVeiUd
        no3a5nc17AbXivzjepRlm5TlR0cAw8kcP+LxMdW8W72PpazRpn7X2AxXeStpvpKN1s5TebIxgYd4e
        Tvi7l0JzRJbgQS+g/JIm8Txm1XTw/iDVAGxD6rfgjJhA/wNy+U9YlLPb+iQeZX5qqzGSPyUDR88f1
        h87AtGejg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8QsF-0004ER-AB; Fri, 05 Oct 2018 14:14:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1675202631DA; Fri,  5 Oct 2018 16:14:33 +0200 (CEST)
Date:   Fri, 5 Oct 2018 16:14:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
Message-ID: <20181005141433.GS19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005081333.15018-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
> new file mode 100644
> index 000000000000..8fc3b4c9b38f
> --- /dev/null
> +++ b/include/linux/ffp.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_FFP_H
> +#define __LINUX_FFP_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_FFP
> +#include <asm/ffp.h>
> +#else
> +
> +struct ffp {
> +	void	(**fn)(void);
> +	void	(*default_fn)(void);
> +};
> +
> +#define DECLARE_FFP(_fn, _def)						\
> +	extern typeof(_def) *_fn;					\
> +	extern struct ffp const __ffp_ ## _fn
> +
> +#define DEFINE_FFP(_fn, _def)						\
> +	typeof(_def) *_fn = &_def;					\
> +	struct ffp const __ffp_ ## _fn					\
> +		= { (void(**)(void))&_fn, (void(*)(void))&_def };	\
> +	EXPORT_SYMBOL(__ffp_ ## _fn)
> +
> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
> +{
> +	WRITE_ONCE(*m->fn, new_fn);
> +}
> +
> +static inline void ffp_reset_target(const struct ffp *m)
> +{
> +	WRITE_ONCE(*m->fn, m->default_fn);
> +}
> +
> +#endif
> +
> +#define SET_FFP(_fn, _new)	ffp_set_target(&__ffp_ ## _fn, _new)
> +#define RESET_FFP(_fn)		ffp_reset_target(&__ffp_ ## _fn)
> +
> +#endif

I don't understand this interface. There is no wrapper for the call
site, so how are we going to patch all call-sites when you update the
target?
