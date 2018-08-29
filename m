Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E243BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9900C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqcJKz4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9900C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH2K4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:56:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2K4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QorzVjD/PvjAwP1BoQ+kN6WDYAySbLD54LwKXcdUbGE=; b=lqcJKz4ijjANvNO/p16badsp6
        g7DSvqm/IsCGr0tZ4R5P2FPiANcwL7r3RYKrKcK8SMpAy4dtXIrYPDPLiQtArJtue5mVa+yS6Ig61
        1IWtYOgLrP5qboUsmisWE4aP0FERW2YFVX2zMtLT8FkgKl7X4p0ZnVTcnvIlI5GmpYlNestCGXIW3
        3jLpsCSQr9pPpg8qh0ktRHnP40E9ytL/gszjVHewOKLmQXWu4bkec2sygTiIuVzRJR3DN8aupCzw2
        yeU1C4i2TrQYs63uB7g5GYbnOr7sU/KX8eg9/mgN3BZ0csK/YI1VWYOJNbCFMjYvsUUKe3ZGSKQwa
        j3FEf6r8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuuSy-0002Ed-Vx; Wed, 29 Aug 2018 07:00:37 +0000
Date:   Wed, 29 Aug 2018 00:00:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, christian.brauner@canonical.com,
        ben@decadent.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] binder: use standard functions to allocate fds
Message-ID: <20180829070036.GA13718@infradead.org>
References: <20180828160005.90796-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828160005.90796-1-tkjos@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  config ANDROID_BINDER_IPC
>  	bool "Android Binder IPC Driver"
> -	depends on MMU
> +	depends on MMU && !CPU_CACHE_VIVT

Thats is a purely arm specific symbol which should not be
used in common code.  Nevermind that there generally should
be no good reason for it.

> +	fixup->offset = (uintptr_t)fdp - (uintptr_t)t->buffer->data;

This looks completely broken.  Why would you care at what exact
place the fd is placed?  Oh, because you share an array with fds
with userspace, which is a hell of a bad idea, and then maninpulate
that buffer mapped to userspace from kernel threads.

I think we just need to rm -rf drivers/android/binder*.c and be done
with it, as this piece of crap should never have been merged to start
with.
