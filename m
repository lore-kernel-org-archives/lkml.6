Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D272C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5597020870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bt1Ufs1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5597020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeLKSxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:53:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeLKSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nw6gn98kOeoOvbqz55rm/FYxZbQcsNmtwlPp0QYTMl8=; b=Bt1Ufs1rGUuKuPX9FPPhRGAjk
        ATyCVLwMga5rmHuaH3ToIWqHw2EpfccHAi6YE1i6GKsGHi67nP1i7Z6xc5C7Jrow1gJc6lJz7AmnG
        +b3OFSsw6pqOGo80O+pa0NAlfn60UDsLHzkUatuNRh/Aggv7S5uSTzQUEk+Ya5ia2B/I1H0iH6C2Y
        LaQWwDgUdK1ToURhs21I8ahduzDwZlirQzJ69JCkrfeuJrtrfNhPgZtTjzENsDMiTU6a4YREvijcl
        gygc4YnAN6s1/BfdP2KcED2q2EeLelAoxqzdYvQg5gcx5mwnHZtkMg7Zp7hx2oyT/x58NU2u3Lw/t
        NjNJOUZhg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWn9b-0000ti-MW; Tue, 11 Dec 2018 18:53:11 +0000
Date:   Tue, 11 Dec 2018 10:53:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
Message-ID: <20181211185311.GJ6830@bombadil.infradead.org>
References: <20181128183531.5139-1-willy@infradead.org>
 <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
 <20181211184553.GH6830@bombadil.infradead.org>
 <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75267003-9407-101f-33ee-685e345a2c8a@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:46:53AM -0700, Jens Axboe wrote:
> On 12/11/18 11:45 AM, Matthew Wilcox wrote:
> > I think we need the rcu read lock here to prevent ctx from being freed
> > under us by free_ioctx().
> 
> Then that begs the question, how about __xa_load() that is already called
> under RCU read lock?

I've been considering adding it to the API, yes.  I was under the
impression that nested rcu_read_lock() calls were not expensive, even
with CONFIG_PREEMPT.
