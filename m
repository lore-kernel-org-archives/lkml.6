Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF3C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhfWmHA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F1D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLFPJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:09:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0dhPucSif+bNWSWjAadItddk0PjLPHKsFcP+f39FBQw=; b=qhfWmHA9rpxQDgIFKLdoLDUIU
        rxzompB77F2oUFfPZPbNXKwzYsaFwqa9yVucUYOD3C4ysCpCECp5PnfHBycpFDYL8r+AhbURvlV2w
        ofONtJ1HHcon7WM7ZbO0CTYLpET+PX8LlD4f41ara9Bv4uHFAwclqcWlGfcWMgICopfgRehsIGt7S
        kQDWzlmiWC9z4rCs/051SLwYPo8vsjJx52DOGxR7dHD9UaVtcMragmgmO//M1M5Xrbt2IkXMojdj1
        KNs3eO+nwdiWV3i9aKkD9uDc26Rbhp5oaW2pUDYsxdqeTxj3nIZ5381IyXBAbC0lqFKed+2q2GKFh
        WF4yJw+tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvGm-0002zL-Mm; Thu, 06 Dec 2018 15:08:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD0A6200F9F91; Thu,  6 Dec 2018 16:08:50 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:08:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
        tglx@linutronix.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181206150850.GI13538@hirez.programming.kicks-ass.net>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:34:29PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I originally posted here:
> 
>   http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com
> 
> The only change since v1 is that  __preempt_count_dec_and_test() now
> reloads the need_resched flag if it initially saw that it was set. This
> resolves the issue spotted by Peter, where an IRQ coming in during the
> decrement can cause a reschedule to be missed.

Yes, I think this one will work, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

However, this leaves me wondering if the sequence is actually much
better than what you had?

I suppose there's a win due to cache locality -- you only have to load a
single line -- but I'm thinking that on pure instruction count, you're
not actually winning much.
