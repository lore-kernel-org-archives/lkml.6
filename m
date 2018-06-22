Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF20C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E135245BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2jfAp6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E135245BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeFVQVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:21:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbeFVQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DxGmMZZRMPH6CM8VicfGWQPSlifXQVyBx3Yhs8sqx18=; b=e2jfAp6UGkmfShbSZ9n4s+5bB
        r7mYBKvWBcZwk8WV/vyb4XuUsooaZ/wP0X+Wx6ZMEV/xJ74gLs71+vPc0xlkDDCdwutWTgQ7U0xTG
        CsKUvonM8gkSqN04A5i9QBeq53wC3tZKKMoI20kWyb9MuBj1l3qOR1MvZkmPQCrJ/2W6AnQWCHsSz
        NoQKmhLDvJfhYPHJvgRkiEJAFUmDR9DZqrFGKHc7/ZMfm5K8pU/pqo+WYMdC/jypdmmFjs06IqEDg
        cd64A2E4ulcuXa0iIxhf0R/daY2nD0jeI1W+++O6iBXYL8fDaVcZCgzV12a0UOu0rdnSajiiJ21JI
        vwQPwc6Eg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWOoY-0005cB-9V; Fri, 22 Jun 2018 16:21:34 +0000
Subject: Re: [PATCH v9 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
To:     "Tobin C. Harding" <me@tobin.cc>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180621231534.32278-1-me@tobin.cc>
 <20180621231534.32278-5-me@tobin.cc>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ce4d6ec-ef1b-1372-56bf-30ac1feabc9f@infradead.org>
Date:   Fri, 22 Jun 2018 09:21:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621231534.32278-5-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 04:15 PM, Tobin C. Harding wrote:
> Currently printing [hashed] pointers requires enough entropy to be
> available.  Early in the boot sequence this may not be the case
> resulting in a dummy string '(____ptrval____)' being printed.  This
> makes debugging the early boot sequence difficult.  We can relax the
> requirement to use cryptographically secure hashing during debugging.
> This enables debugging while keeping development/production kernel
> behaviour the same.
> 
> If new command line option debug_boot_weak_hash is enabled use
> cryptographically insecure hashing and hash pointer value immediately.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  lib/vsprintf.c                                  | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)


-- 
~Randy
