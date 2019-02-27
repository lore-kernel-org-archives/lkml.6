Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E161C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBE3213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfB0JrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:47:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfB0JrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:47:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9A85AF63;
        Wed, 27 Feb 2019 09:46:58 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:46:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
Message-ID: <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-21-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-21-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:58, John Ogness wrote:
> Implement a non-sleeping NMI-safe write_atomic console function in
> order to support emergency printk messages.

It uses console_atomic_lock() added in 18th patch. That one uses
prb_lock() added by 2nd patch.

Now, prb_lock() allows recursion on the same CPU. But it still needs
to wait until it is released on another CPU.

It means that it is not completely save when NMIs happen on more CPUs in
parallel, for example, when calling nmi_trigger_cpumask_backtrace().

OK, it would be safe when prb_lock() is the only lock taken
in the NMI handler. But printk() should not make such limitation
to the rest of the system. Not to say, that we would most
likely need to add a lock back into nmi_cpu_backtrace()
to keep the output sane.


Peter Zijlstra several times talked about fully lockless
consoles. He is using the early console for debugging, see
the patchset
https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

I am not sure if it is always possible. I personally see
the following way:

   1. Make the printk ring buffer fully lockless. Then we reduce
      the problem only to console locking. And we could
      have a per-console-driver lock (no the big lock like
      prb_lock()).

   2. I am afraid that we need to add some locking between CPUs
      to avoid mixing characters from directly printed messages.
      This would be safe everywhere expect in NMI. Then we could
      either risk ignoring the lock in NMI (there should be few
      messages anyway, the backtraces would get synchronized
      another way). Or we might need a compromise between
      handling console using the current owner and offload.


Best Regards,
Petr
