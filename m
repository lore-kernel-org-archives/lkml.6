Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C4420869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eYQdyWLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C4420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJPU3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:29:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cTCr8Ojgre4CN5m9ZDgevQMr3KOcTBDrfo77rx8jx4s=; b=eYQdyWLJ5ARRZVz2wwBSvDgTR
        QE2Mf6VwNjf6EDj7XvVLGEon53aJYvrB7vnfW5Ehc15ArdQkswQPn1sxl0DVH2rqhGL0XYXBsOWKp
        AsaWxASVFD0mEGUd+p4exGh3IQiCOlrtN9/HtUqZq6dWkTZNVEvLurBKIvI+wCMc6ch4+GLzRl+u6
        zR5aiQJgUKzM8OQGHP1eIGG1uL5F1JPA39EKrJ/UHVVBlXHTJXE+yezvcBsify6XoEH4ghVIYjav0
        xuzjmrRXW4fZ2u0lEF7O3XkXrDswM9wOYCbR0NaGIkkDe3hERDCBJ5VhLD9f3dM6rnOrYtB6O1pVz
        6xrXWqncQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCOcR-0003DO-0Y; Tue, 16 Oct 2018 12:38:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47D0020297B77; Tue, 16 Oct 2018 14:38:37 +0200 (CEST)
Date:   Tue, 16 Oct 2018 14:38:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181016123837.GC2537@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016122734.GA1259@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> On (10/16/18 09:27), Peter Zijlstra wrote:
> > 
> > So I really _really_ hate all this. Utterly detest it.
> 
> I learned a new word today - detest. I can haz re-entrant consoles now please?

early_serial_write() not haz a lock anywhere.
