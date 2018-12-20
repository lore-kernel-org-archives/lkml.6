Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A77218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HD0cJR8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeLTStZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:49:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeLTStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KKdRf1lwJWtkW/36xyZrlsowCIaciesNrJNkfZ3tciE=; b=HD0cJR8k0HJ+fvRGqpxIpCuBV
        Fv36z4Vt8ShO8NFzBBtayIPjB9/TjWatGfFJaRKb9lICX04efXa4BN21EloFDDLCNGdIgqNudc6SX
        RjMVsTOFDBzhTyN7V89mX0EkODnl8JolibRJCLyLbzhQXq6sDbWX1dPZFFPV5qavQkcjzzpKeWB1V
        0chzDgEU37j22rDA4kwbbtHMlAO/vj0AY241MDyJMYdsyzhQVzma95xzZwc01OM2NKj0AKWT7iTIR
        aSMPEYBCDGp1T1EV7jydjusAQi9aN/2Zb7nR5JlEuzl7mGPVop7fspeE5SFbOqFAtUtlzcH+5Mwk6
        fJerPEiVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga3Nm-0003yK-6A; Thu, 20 Dec 2018 18:49:18 +0000
Date:   Thu, 20 Dec 2018 10:49:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
Message-ID: <20181220184917.GY10600@bombadil.infradead.org>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219213338.26619-5-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:33:30PM +0200, Igor Stoppa wrote:
> +void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
> +	      enum wr_op_type op)
> +{
> +	temporary_mm_state_t prev;
> +	unsigned long offset;
> +	unsigned long wr_poking_addr;
> +
> +	/* Confirm that the writable mapping exists. */
> +	if (WARN_ONCE(!wr_ready, "No writable mapping available"))
> +		return (void *)dst;
> +
> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
> +		return (void *)dst;
> +
> +	offset = dst - (unsigned long)&__start_wr_after_init;
> +	wr_poking_addr = wr_poking_base + offset;
> +	local_irq_disable();
> +	prev = use_temporary_mm(wr_poking_mm);
> +
> +	if (op == WR_MEMCPY)
> +		copy_to_user((void __user *)wr_poking_addr, (void *)src, len);
> +	else if (op == WR_MEMSET)
> +		memset_user((void __user *)wr_poking_addr, (u8)src, len);
> +
> +	unuse_temporary_mm(prev);
> +	local_irq_enable();
> +	return (void *)dst;
> +}

I think you're causing yourself more headaches by implementing this "op"
function.  Here's some generic code:

void *wr_memcpy(void *dst, void *src, unsigned int len)
{
	wr_state_t wr_state;
	void *wr_poking_addr = __wr_addr(dst);

	local_irq_disable();
	wr_enable(&wr_state);
	__wr_memcpy(wr_poking_addr, src, len);
	wr_disable(&wr_state);
	local_irq_enable();

	return dst;
}

Now, x86 can define appropriate macros and functions to use the temporary_mm
functionality, and other architectures can do what makes sense to them.

