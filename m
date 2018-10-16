Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572F72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ziMC6eBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572F72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJPWMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:12:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zWdPFoVcPFsjVZduwFWVu2mlW7RkXTwtJQZowP+VTRI=; b=ziMC6eBq10CQIOsqULn/xsDMg
        7qA3+hhnIutrRlH5LWFUDjE5H+e7O2is8bdxr1cspZRGcJ2r1UN7zgA8TwlpUWD9ltCF6rkDftQnk
        Rla687C/ZPfd3ileBQZ67lKymm6GViJHkknkUYoolcCt6RYRgZC5NbQN5P1aytvIAGJKUFBq9zwrx
        VFz2BSOuqANtk/uZhygVEuXJXp+BGXquoccK1VOcSL3gE6XsfSpUqa78TLYtnmdBb10moLSzeyCJg
        HDCexYozRqyt/ZqaD5TwRP49ySBhLJCqnjfPz7v9fydNZGdYMcm1CfQuJoJ0pK5fsOvOP3PvnAHpU
        ZZ781c1+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCQET-00027l-My; Tue, 16 Oct 2018 14:22:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE82B2029856B; Tue, 16 Oct 2018 16:21:58 +0200 (CEST)
Date:   Tue, 16 Oct 2018 16:21:58 +0200
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
Message-ID: <20181016142158.GA2603@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:54:15PM +0200, Peter Zijlstra wrote:
> printk will determine the current context:
> 
>   task, softirq, hardirq or NMI
> 
> and pick the corresponding per-cpu line buffer and do the vsnprintf()

We need 4, but we don't need to do the exact context determination for
this. We can keep a simple counter:

#define MAX_IDX 4	/* task, sirq, hirq, nmi */
#define MAX_LEN 1020	/* sizeof(struct line_buffer) < 4k */

struct line_buffers {
	int idx;
	char line[MAX_IDX][MAX_LEN];
};

static DEFINE_PER_CPU(struct line_buffers, lbs);

static char *get_linebuf(void)
{
	struct line_buffers *lbp = this_cpu_ptr(&lbs);
	int idx;

	idx = lbp->idx++;
	return lbp->linx[idx];
}

static void put_linbuf(void)
{
	this_cpu_dec(lbs.idx);
}

> thing. Then we have the actual line length and content. With the length
> we reserve the bytes from the global buffer, we memcpy into the buffer
> and commit.

