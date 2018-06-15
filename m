Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E003C208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E003C208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756572AbeFOVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:05:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754429AbeFOVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 263704070481;
        Fri, 15 Jun 2018 21:05:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B5BB5032D;
        Fri, 15 Jun 2018 21:05:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5FL513d026715;
        Fri, 15 Jun 2018 17:05:01 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5FL51P9026711;
        Fri, 15 Jun 2018 17:05:01 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 15 Jun 2018 17:05:01 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload isochronous
 urb completions to ksoftirq]
In-Reply-To: <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
Message-ID: <alpine.LRH.2.02.1806151658000.24974@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org> <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 15 Jun 2018 21:05:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 15 Jun 2018 21:05:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2018, Thomas Gleixner wrote:

> One solution to that is to avoid both tasklets and kworkers and change the
> USB code to make use of threaded interrupt handlers. I.e. handle the fast
> stuff in the primary (hardirq) handler and delegate the rest to the irq
> thread. That thread still can offload disk type stuff to a kworker if
> needed. But the irq thread allows to bring the stuff under scheduler
> control and experiments which I did a few years ago worked out pretty good.
> 
> Thanks,
> 
> 	tglx

I don't think that threaded interrupt handlers are a good idea.

There are existing tools such as rtkit in Linux distributions that 
increase the priority of audio applications to real time. And if rtkit 
increases the priority of audio player or audio server above the priority 
of the interrupt thread that handles the soundcard - sound playback is 
screwed.

You would have to set the priority of the interrupt thread to the highest 
real-time priority - and in such a case, the interrupt thread is no 
different than a hard-irq handler.

Mikulas
