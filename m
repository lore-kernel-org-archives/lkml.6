Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34042089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sx1NqRUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34042089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeGINcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:32:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGINcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2QNZh7mXJTvLK2z16iqxMV33862oaBvkAogy3Ea4mM8=; b=Sx1NqRUaQlIDYlLYSASnHIE4D
        Cj8Uxs8GK4Hk65ruhZHOjsxvi417PlN1cZbPLaABwk6FDNt1/hkz/w2IRmPG75a7FWwIjfe3CCTcf
        cI+yoyp/ZbG9woHl4dUoiEmUQrPPyhgWSBuB9nluQTKvF0He4UJca3r83SF8+D7I5Z64FbLHqHEoE
        +YPUyIXyCDiC/ETRxGSAnXRKKVGym+O4Rj3y6ZPL3+UbGkbbiaLo6pIjFQj0LnIcspsPdnNmI52Cd
        sPgX1SjbnmnKP71xUj1lD3FEo4zV4mjjyTKgc8tPbIBKfWaCsecNUmS5bo95h7hKPOAQH7Qr+uoLY
        8vRPzSgSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcWGy-0001xU-Hf; Mon, 09 Jul 2018 13:32:12 +0000
Date:   Mon, 9 Jul 2018 06:32:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     syzbot <syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm <linux-mm@kvack.org>
Subject: Re: BUG: corrupted list in cpu_stop_queue_work
Message-ID: <20180709133212.GA2662@bombadil.infradead.org>
References: <00000000000032412205706753b5@google.com>
 <000000000000693c7d057087caf3@google.com>
 <1271c58e-876b-0df3-3224-319d82634663@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271c58e-876b-0df3-3224-319d82634663@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:55:17PM +0900, Tetsuo Handa wrote:
> Hello Matthew,
> 
> It seems to me that there are other locations which do not check xas_store()
> failure. Is that really OK? If they are OK, I think we want a comment like
> /* This never fails. */ or /* Failure is OK because ... */
> for each call without failure check.

Good grief, no, I'm not adding a comment to all 50 calls to
xas_store().  Here are some rules:

 - xas_store(NULL) cannot fail.
 - xas_store(p) cannot fail if we know something was already in
   that slot beforehand (ie a replace operation).
 - xas_store(p) cannot fail if xas_create_range() was previously
   successful.
 - xas_store(p) can fail, but it's OK if the only things after that are
   other xas_*() calls.  Because every xas_*() call checks xas_error().
   So this is fine:

	do {
		xas_store(&xas, p);
		xas_set_tag(&xas, XA_TAG_0);
	} while (xas_nomem(&xas, GFP_KERNEL));

> >From d6f24d6eecd79836502527624f8086f4e3e4c331 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 9 Jul 2018 15:58:44 +0900
> Subject: [PATCH] shmem: Fix crash upon xas_store() failure.
> 
> syzbot is reporting list corruption [1]. This is because xas_store() from
> shmem_add_to_page_cache() is not handling memory allocation failure. Fix
> this by checking xas_error() after xas_store().

I have no idea why you wrote this patch on Monday when I already said
I knew what the problem was on Friday, fixed the problem and pushed it
out to my git tree on Saturday.
