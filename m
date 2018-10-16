Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115C020881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y63UnSNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115C020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJPPMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:12:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJPPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DYXwqZglBkOAyqaCfAC6jbxJ/QNM9FovU4Xwb/DO0j8=; b=Y63UnSNm4mEIo7FQLEA1bIS2H
        g5yeEGUwBBASn9c91k9TTnfgaLFRbiRx9PYvaDQmnTeTQBENEvq+1zA9OybO2B85ApJenr98pcXVq
        kVPtt9w4TBF8QbWGCP6KEhOQvOxNcLmv364Ywgw2LwOM9axOphK0LxAm8N79vrb0I1RaBpf175PGQ
        OVDI+R/gdpykm3vFHyvMJFmx99PJ1uA+jKCUYSewYOh/1cC16fqPKVCYZ0ePpPYkhNU0roWbmK4ef
        MIWYGEJDra0JCNqAW7b4IUK7MHS1xTOafudeDrBEfCO4jKhMIpM+bxnmndQRJzOkYwnxk5JqkDgfl
        p/hR27Ekw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCJhT-0000HU-KN; Tue, 16 Oct 2018 07:23:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5EE620297B77; Tue, 16 Oct 2018 09:23:28 +0200 (CEST)
Date:   Tue, 16 Oct 2018 09:23:28 +0200
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
Subject: Re: [RFC][PATCHv2 0/4] less deadlock prone serial consoles
Message-ID: <20181016072328.GA4030@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:04:24PM +0900, Sergey Senozhatsky wrote:
> 	Hello,
> 
> 
> 	RFC
> 
> 
> 	The patch set reduces the number of ways serial consoles
> can deadlock the system, including the recently reported deadlock
> in panic().

That's what I use early_printk for... :-)
