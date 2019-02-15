Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71172177E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfBOBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:20:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBOBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:20:01 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1guSAT-000617-Cv; Fri, 15 Feb 2019 02:19:53 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [RFC PATCH v1 04/25] printk-rb: add writer interface
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-5-john.ogness@linutronix.de>
        <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
        <87ef8aosby.fsf@linutronix.de>
Date:   Fri, 15 Feb 2019 02:19:50 +0100
In-Reply-To: <87ef8aosby.fsf@linutronix.de> (John Ogness's message of "Fri, 15
        Feb 2019 00:36:49 +0100")
Message-ID: <87a7ixq24p.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-15, John Ogness <john.ogness@linutronix.de> wrote:
> prb_commit() does not actually care what is in the handle. It is going
> to commit everything up to the reserve.

After thinking about what I wrote here, I realized that the struct
prb_handle has no purpose in this ringbuffer implementation. We really
could simplify the writer interface to:

    char *prb_reserve(struct printk_ringbuffer *rb, unsigned int size);

    void prb_commit(struct printk_ringbuffer *rb);

That probably feels really strange because the writer doesn't specify
_what_ to commit. But this ringbuffer implementation doesn't need to
know that.

The only reason I can think of for having a handle is if there should be
any statistics, debugging, or sanity checking added. (For example if a
writer tried to commit something it did not reserve.)

John Ogness
