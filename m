Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA196208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA196208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966099AbeFORec (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965916AbeFOReb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:34:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EC820896;
        Fri, 15 Jun 2018 17:34:30 +0000 (UTC)
Date:   Fri, 15 Jun 2018 13:34:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload
 isochronous urb completions to ksoftirq]
Message-ID: <20180615133428.20205bae@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
References: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
        <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 19:28:34 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> One solution to that is to avoid both tasklets and kworkers and change the
> USB code to make use of threaded interrupt handlers. I.e. handle the fast
> stuff in the primary (hardirq) handler and delegate the rest to the irq
> thread. That thread still can offload disk type stuff to a kworker if
> needed. But the irq thread allows to bring the stuff under scheduler
> control and experiments which I did a few years ago worked out pretty good.

If there's any question about this, drivers can request to have their
interrupt handlers run as threads. This has been added to mainline
years ago. And it really should be the default solution before pushing
off to tasklets or kworkers.

-- Steve
