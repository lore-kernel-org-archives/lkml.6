Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F502170F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F502170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeFUQu3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeFUQu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:50:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4412E21708;
        Thu, 21 Jun 2018 16:50:27 +0000 (UTC)
Date:   Thu, 21 Jun 2018 12:50:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Stefan Agner <stefan@agner.ch>, abelvesa@linux.com,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ARM: ftrace: Only set kernel memory back to read-only
 after boot
Message-ID: <20180621125025.25b70bb9@gandalf.local.home>
In-Reply-To: <20180621124710.453ee0ae@gandalf.local.home>
References: <20180621124710.453ee0ae@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 12:47:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Dynamic ftrace requires modifying the code segments that are usually
> set to read-only. To do this, a per arch function is called both before
> and after the ftrace modifications are performed. The "before" function
> will set kernel code text to read-write to allow for ftrace to make the
> modifications, and the "after" function will set the kernel code text
> back to "read-only" to keep the kernel code text protected.
> 
> The issue happens when dynamic ftrace is tested at boot up. The test is
> done before the kernel code text has been set to read-only. But the
> "before" and "after" calls are still performed. The "after" call will
> change the kernel code text to read-only prematurely, and other boot
> code that expects this code to be read-write will fail.
> 
> The solution is to add a variable that is set when the kernel code text
> is expected to be converted to read-only, and make the ftrace "before"
> and "after" calls do nothing if that variable is not yet set. This is
> similar to the x86 solution from commit 162396309745 ("ftrace, x86:
> make kernel text writable only for conversions").
> 
> Reported-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Stefan Agner <stefan@agner.ch>
> Link: http://lkml.kernel.org/r/20180620212906.24b7b66e@vmware.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Perhaps I should have Cc'd stable too?

-- Steve
