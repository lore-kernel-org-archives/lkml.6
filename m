Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10813208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10813208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966348AbeFOQqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966083AbeFOQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:46:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBCA208B2;
        Fri, 15 Jun 2018 16:46:11 +0000 (UTC)
Date:   Fri, 15 Jun 2018 12:46:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
Message-ID: <20180615124609.7726924b@gandalf.local.home>
In-Reply-To: <alpine.LRH.2.02.1806151222200.5648@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org>
        <alpine.LRH.2.02.1806131521540.26196@file01.intranet.prod.int.rdu2.redhat.com>
        <20180613183145.17564d82@gandalf.local.home>
        <alpine.LRH.2.02.1806141809500.6435@file01.intranet.prod.int.rdu2.redhat.com>
        <20180614183546.7e04024c@gandalf.local.home>
        <alpine.LRH.2.02.1806151222200.5648@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 12:41:10 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> BTW. when I subject the machine to a ping flood (ping -f), the 
> non-realtime kernel (with the patch to avoid offloading ehci urb 
> callbacks) performs better than the real-time kernel.
> 
> With the real-time kernel, all the networking work is done in the thread 
> "irq/12-eth0", that has (by default) priority -51, it consumes 30% CPU 
> time and causes sound skipping. I can avoid the skipping by lowering the 
> priority of "irq/12-eth0".

That's actually the correct thing to do. When dealing with RT
applications, one needs to modify the priority of the interrupts that
are required (or lower the ones that are not).

> 
> With non-realtime kernel, no such problem during ping flood exists.

But that was with a patched kernel?

-- Steve
