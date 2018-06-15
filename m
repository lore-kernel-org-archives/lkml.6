Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F58FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D459A208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D459A208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756590AbeFOVNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756434AbeFOVNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:13:33 -0400
Received: from vmware.local.home (user-0cemj78.cable.mindspring.com [24.235.76.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 467EF20896;
        Fri, 15 Jun 2018 21:13:32 +0000 (UTC)
Date:   Fri, 15 Jun 2018 17:13:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload
 isochronous urb completions to ksoftirq]
Message-ID: <20180615171329.05f7e4de@vmware.local.home>
In-Reply-To: <alpine.LRH.2.02.1806151658000.24974@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
        <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
        <alpine.LRH.2.02.1806151658000.24974@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 17:05:01 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:


> I don't think that threaded interrupt handlers are a good idea.
> 
> There are existing tools such as rtkit in Linux distributions that 
> increase the priority of audio applications to real time. And if rtkit 
> increases the priority of audio player or audio server above the priority 
> of the interrupt thread that handles the soundcard - sound playback is 
> screwed.
> 
> You would have to set the priority of the interrupt thread to the highest 
> real-time priority - and in such a case, the interrupt thread is no 
> different than a hard-irq handler.

Perhaps rtkit et.al. should be updated to know about interrupt threads.
It's pretty trivial to know about them and that can easily be
automated. The only problem is to keep the irq thread higher than the
audio server. And we always tell people to never put a thread to the
maximum priority unless they had a damn good reason to do so.

-- Steve
