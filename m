Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693A1214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dq+rseJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693A1214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeKVEGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:06:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeKVEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zBB4WO6mxheSnm6GfPRs+mXpIzV6EYBADWqUDBzGFUw=; b=dq+rseJyhiDjHHLZ7h3exsJA5
        1xjEqMYKTldGWnUIb9sdBESBd6ruMfH64q78AWw692QfYqWYdBSAmdrJt6BW0ae6ACS4YzTZql/BL
        EEoIp3vttngkal4kkYxCFg+fugLLXeHLVOSTe+LVQOVWYPPtfzMP0wlx55Ns+OXHYWs9Q09bo9jg3
        ZS66u49UhOjxlwHj0KDQl4enREZmyyio1ZE7Dl+QfU1CrCG2k9rhwn8/kzuJm03NFppCYZpnI6pHc
        1poIk638sxL9ZdGRUwjpTTiY9hT5OQw3WZOaoZRwuFLVpRjYMERluaLJdNV8sE7wuLnsCfBE5wgVp
        EJzosYmZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPWLK-0006WQ-Ia; Wed, 21 Nov 2018 17:31:14 +0000
Date:   Wed, 21 Nov 2018 09:31:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
Message-ID: <20181121173114.GA14352@infradead.org>
References: <20181121115922.22864-2-dave.rodgman@arm.com>
 <20181121115922.22864-3-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121115922.22864-3-dave.rodgman@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define LZO_USE_CTZ32	1
>  #elif defined(__i386__) || defined(__powerpc__)
>  #define LZO_USE_CTZ32	1
> -#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >= 5)
> +#elif defined(__arm__)
> +#if (__LINUX_ARM_ARCH__ >= 5)
>  #define LZO_USE_CTZ32	1
>  #endif
> +#if (__LINUX_ARM_ARCH__ >= 6) && (CONFIG_THUMB2_KERNEL)
> +#define LZO_USE_CTZ64	1

All of this really needs to be driven by Kconfig symbols that
the architecture selects instead of magic arch ifdefs here.
