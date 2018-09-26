Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95742C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49484214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49484214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIZRtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbeIZRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:49:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60A01AE10;
        Wed, 26 Sep 2018 11:37:16 +0000 (UTC)
Date:   Wed, 26 Sep 2018 13:37:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20180926113715.6llme2vmvynzuoa3@pathway.suse.cz>
References: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
 <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
 <20180914111953.GA20572@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914111953.GA20572@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-14 20:19:53, Sergey Senozhatsky wrote:
> On (09/14/18 10:59), Petr Mladek wrote:
> > 
> > Well, I am not sure if it is worth the code complexity.
> >
> 
> Well, I don't think we need to bother that much here. Besides,
> exclusive_console is cleared under logbuf_lock with preemption
> disabled now. So we set it under logbuf_lock and !irq and we
> clear it under logbuf_lock and !irq. Looks quite OK to me.

I wanted to say that you moved exclusive_console handling under
a locked section from a reason. This reason is far from clear
from the code.

If you really want this change, please add a comment, for example:

/*
 * Set exclusive_console still with disabled interrupts to
 * reduce race window with eventual console_flush_on_panic()
 * that ignores console_lock.
 */

I am not against the change. It makes some sense and it does
not break anything. It is just not obvious and might either
get easily lost again or it might cause confusion. I mean that
it might cause false feeling that exclusive_console is
synchronized by logbuf_lock.

printk code already is complex enough without this subtle
tricks.

Best Regards,
Petr
