Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JcN8x+fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4137E20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeGLIib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:38:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeGLIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lf8KUMJ47bK48uLqrOR4uTtmdkwmjBYI8fRDrQ4I1sI=; b=JcN8x+fpHs8/v0+UBmyiBAe/w
        Z2fx5myd6bNKGsihbi9SyfARKWicYMrwvNvU18hrutTCobnrjVoqsgHNizqB/qbCdpZOaksFfI6Z3
        DS93j/lfkyz9135NJsag3GGpYylryKNJuOunxzpT/8pKb4S30GGdx2LKY/kAgDA7lFIqZaKBD8lHS
        hpZJDtxGeAyrsR77VJ+rBKdMCFH+Y+NlnNFkfTo/8ueG28pRv77KLXQdJVuyHcid3sFJhpPTcxGCg
        q+w/2LDLSRmbhD2QFLUvtS9+XDBlaXWVoM2aYsLCBNPCm0HXGVGfbRvHxzDIkzNx9tV6U+/LMDU1o
        uWB7Cngqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWz6-0007Cm-JW; Thu, 12 Jul 2018 08:29:56 +0000
Date:   Thu, 12 Jul 2018 01:29:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 7/7] timex: change syscalls to use struct
 __kernel_timex
Message-ID: <20180712082956.GD8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-8-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707054247.19802-8-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:42:47PM -0700, Deepa Dinamani wrote:
> struct timex is not y2038 safe.
> Switch all the syscall apis to use y2038 safe __kernel_timex.

So you switch existing syscalls to use a different structure.
If this actually happens to be safe it needs a big explanation
in the commit log.

> -#ifdef CONFIG_COMPAT
> -
>  COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
>  		       struct compat_timex __user *, utp)
>  {
> @@ -1187,10 +1183,6 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
>  	return err;
>  }
>  
> -#endif

And this unconditionally defines clock_adjtime, but doesn't actually
seem to add callers, which looks rather odd.  Same for other bits
in the patch.
