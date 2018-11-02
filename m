Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A373FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523572081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/MbPQuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523572081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeKBXr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:47:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeKBXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFS2yIYcp1WZoHF9vc1jvGkeQNloqX4R+3yx8Emmfpo=; b=X/MbPQuwL77C1JhIgM6A4ijyM
        WX7QyfgT2fp/K3l50vNP14s92OSZvDGcFnino6GB/F4bO5l/Bm4fdOzt5FqZrB3+caJrKElisreLv
        IDj9zx4vLqrXpR4XBqqVlJL/J9330sxKGJ3JTAkFLWQcWUt/Yy1oWBoak/MnZdJLFogXdGOv/i+ar
        JM4LV70OVyS0AyNg7B8BP0mSE9NdOCMlpiBieZBiRH+TSZAId31D8UmrAHhANvqwYXP7W0LS50N0D
        TBnXptVG3CiyHTak+TvfEsMOuY0Q+JCuvGHjz5T0EYyb1DJf6Qk44AErGnhkDmPFtArC0m3qrX8vE
        lkZNzcjUg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIacf-0005BT-4J; Fri, 02 Nov 2018 14:40:29 +0000
Date:   Fri, 2 Nov 2018 07:40:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181102144028.GQ10491@bombadil.infradead.org>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:31:55PM +0900, Tetsuo Handa wrote:
>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>   statically preallocated array. get_printk_buffer() returns NULL if
>   all "struct printk_buffer" are in use, but the caller does not need to
>   check for NULL.

This seems like a great way of wasting 16kB of memory.  Since you've
already made printk_buffered() work with a NULL initial argument, what's
the advantage over just doing kmalloc(1024, GFP_ATOMIC)?

