Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B67ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1411C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbeGWQjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbeGWQjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:39:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293ED20854;
        Mon, 23 Jul 2018 15:37:43 +0000 (UTC)
Date:   Mon, 23 Jul 2018 11:37:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Snild Dolkow <snild@sony.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH RESEND] kthread, tracing: Don't expose half-written comm
 when creating kthreads
Message-ID: <20180723113741.66df3b50@gandalf.local.home>
In-Reply-To: <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
References: <20180723134210.54013-1-snild@sony.com>
        <20180723095550.08203a24@gandalf.local.home>
        <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 16:23:09 +0200
Snild Dolkow <snild@sony.com> wrote:

> On 07/23/2018 03:55 PM, Steven Rostedt wrote:
> 
> > Can you add a comment here stating something to the affect of:
> > 		/* task is now visible to other tasks */
> >
> > -- Steve  
> Sure, but isn't that a bit misleading? It will have been visible since
> some unknown point in time between waking up kthreadd and the return of
> wait_for_completion(); we're not the ones making it visible.
> 

I guess that should be reworded, as that is not what I meant, and I
thought not what I stated. It's stating that the task is now visible,
not that we are now making it invisible. But I guess I was being too
short with what I meant. Here's the full statement:

		/*
		 * task is now visible by other tasks, so updating COMM
		 * must be protected.
		 */

-- Steve
