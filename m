Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D91C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF27208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SAiBokt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF27208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeKKLPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:15:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeKKLPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D3caOmTcGmtLW2FE5aQpNNxgbVwXNlmD/zZMeSKaduE=; b=SAiBokt3LZkWop7iU/yksiBKBv
        im5YrbutiP23mKMNbt3Q21wHZClF2o/pt6TxtyEajhBAgMUuRHoiUoR0f21x1hXSvOukkiazlc/c/
        7iIpD/jp3pQ26ICnynzt4KIataSMkc807Z1CKQzryyltp5XtFOvNEVqOcoDb8ZQnbBbn/0uhzoFBZ
        B+DxHEc5+JKm/yg9jKGJS44WJiqVN97CIp6rQygcuZQnQyDdHkVKJy1eixumBJX8c3V9RVNDVnDag
        ZKZKNl2gZKppEllf3ohHbevMb7jHDSuHSBYrxv1wE6eCc/ASu7ljRbhxtVlwQ/qG/3TNGLgs8oJtE
        tPAeIHDA==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLeY5-0007jn-RA; Sun, 11 Nov 2018 01:28:26 +0000
Received: by worktop (Postfix, from userid 1000)
        id 09A826E07D5; Sun, 11 Nov 2018 02:28:24 +0100 (CET)
Date:   Sun, 11 Nov 2018 02:28:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 01/12] locking/lockdep: Rework
 lockdep_set_novalidate_class()
Message-ID: <20181111012823.GB12766@worktop.psav.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <1541709268-3766-2-git-send-email-longman@redhat.com>
 <20181110141458.GE3339@worktop.programming.kicks-ass.net>
 <bc8ef8ae-c673-f4ae-fab1-3fe1bc884087@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc8ef8ae-c673-f4ae-fab1-3fe1bc884087@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 07:26:51PM -0500, Waiman Long wrote:
> On 11/10/2018 09:14 AM, Peter Zijlstra wrote:
> > On Thu, Nov 08, 2018 at 03:34:17PM -0500, Waiman Long wrote:
> >> The current lockdep_set_novalidate_class() implementation is like
> >> a hack. It assigns a special class key for that lock and calls
> >> lockdep_init_map() twice.
> > Ideally it would go away.. it is not thing that should be used.
> 
> Yes, I agree. Right now, lockdep_set_novalidate_class() is used in
> 
> drivers/base/core.c:    lockdep_set_novalidate_class(&dev->mutex);
> drivers/md/bcache/btree.c:      lockdep_set_novalidate_class(&b->lock);
> drivers/md/bcache/btree.c:     
> lockdep_set_novalidate_class(&b->write_lock);
> 
> Do you know the history behind making them novalidate?

Only of the driver/base/core.c one; there the locking order depends on
the hardware and we never quite found a way to annotate that sanely. I
forgot most details though.

The other stuff I only 'recently' found out about :-( And ideally would
have never made it into the tree, but alas.
