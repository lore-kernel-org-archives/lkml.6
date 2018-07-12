Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KS9Jc+45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C0720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeGLIel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:34:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeGLIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BijgM1KwdwyxHUXNy/VTtpX2QuY/05kxshrUBUpVu/0=; b=KS9Jc+453vO3MLKupsjBI6MpY
        XaeuRy748z36tsbRXR/oh5UyVCRRm4YKNB4PBdG0nD8g62nen6xmYzJgMC1Qk5ZYO5y6bKiEaFV87
        +8WzHtBww/AfoxYv+BTakvjBd6ZgSA+3s9Qp8Gvju7zMBNwxuiwuHsU9Z2gZvx2oViJO08WBaLlii
        fwjo8w1zbTdYYqvXMlPX03Qv+cKs7ffwsumQS2qKCW8ZgmiTouvhPvfaLX9XcYlvy0MqNMObWUx5g
        TlTWXK8dVZ3KnSD0P7ekYLCG47gY1pyL/DRGSDCxp0gHJ6fKLUHnCX7yB4ve19gnq+OwppoLyfHrm
        sqW0TqzSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWvR-0006M3-Ml; Thu, 12 Jul 2018 08:26:09 +0000
Date:   Thu, 12 Jul 2018 01:26:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH v3 5/7] time: Add struct __kernel_timex
Message-ID: <20180712082609.GB8802@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-6-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707054247.19802-6-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think this patches makes sense without the next one,
which actually uses the structure.

> +/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
> + * and 32-bit emulation.
> + */

Wrong comment style, also the 'compat path is the 32 (or 31 in case of
s390) bit emulation, so the comment seems rather confusing.

> +#ifndef CONFIG_64BIT_TIME
> +#define __kernel_timex timex
> +#endif

using #defines for structs has all kinds of ill effects.  Why can't
we aways use __kernel_timex for the in-kernel usage?

> +#ifndef __kernel_timex
> +struct __kernel_timex {
> +	unsigned int modes;	/* mode selector */
> +	int :32;            /* pad */

Why do we need padding for a purely in-kernel structure?

Also the anonymous member syntax is rather odd and I don't remeber
us using it anywhere else.  Why here?
