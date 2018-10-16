Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC6C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AAA208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AAA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJPHzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:55:52 -0400
Received: from ozlabs.org ([203.11.71.1]:33945 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeJPHzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:55:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Ywcv2GW3z9s8F;
        Tue, 16 Oct 2018 11:08:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ebiederm@xmission.com
Subject: Re: [PATCH] signal: Mark expected switch fall-throughs
In-Reply-To: <20181013114847.GA3160@embeddedor.com>
References: <20181013114847.GA3160@embeddedor.com>
Date:   Tue, 16 Oct 2018 11:08:14 +1100
Message-ID: <87y3aylpn5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc += ebiederm@xmission.com ]

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  include/linux/signal.h | 6 ++++++
>  1 file changed, 6 insertions(+)

These all look correct to me.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 200ed96..f428e86 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -129,9 +129,11 @@ static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
>  		b3 = b->sig[3]; b2 = b->sig[2];				\
>  		r->sig[3] = op(a3, b3);					\
>  		r->sig[2] = op(a2, b2);					\
> +		/* fall through */					\
>  	case 2:								\
>  		a1 = a->sig[1]; b1 = b->sig[1];				\
>  		r->sig[1] = op(a1, b1);					\
> +		/* fall through */					\
>  	case 1:								\
>  		a0 = a->sig[0]; b0 = b->sig[0];				\
>  		r->sig[0] = op(a0, b0);					\
> @@ -161,7 +163,9 @@ static inline void name(sigset_t *set)					\
>  	switch (_NSIG_WORDS) {						\
>  	case 4:	set->sig[3] = op(set->sig[3]);				\
>  		set->sig[2] = op(set->sig[2]);				\
> +		/* fall through */					\
>  	case 2:	set->sig[1] = op(set->sig[1]);				\
> +		/* fall through */					\
>  	case 1:	set->sig[0] = op(set->sig[0]);				\
>  		    break;						\
>  	default:							\
> @@ -182,6 +186,7 @@ static inline void sigemptyset(sigset_t *set)
>  		memset(set, 0, sizeof(sigset_t));
>  		break;
>  	case 2: set->sig[1] = 0;
> +		/* fall through */
>  	case 1:	set->sig[0] = 0;
>  		break;
>  	}
> @@ -194,6 +199,7 @@ static inline void sigfillset(sigset_t *set)
>  		memset(set, -1, sizeof(sigset_t));
>  		break;
>  	case 2: set->sig[1] = -1;
> +		/* fall through */
>  	case 1:	set->sig[0] = -1;
>  		break;
>  	}

I think _NSIG_WORDS is always constant. So these last two seem like they
could just be replaced with memset() and a modern compiler would do the
right thing.

cheers
