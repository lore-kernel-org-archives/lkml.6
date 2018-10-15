Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049212098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049212098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJPGuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:50:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39108 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:50:11 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8F70113AEA2F2;
        Mon, 15 Oct 2018 16:02:49 -0700 (PDT)
Date:   Mon, 15 Oct 2018 16:02:46 -0700 (PDT)
Message-Id: <20181015.160246.58484704665215987.davem@davemloft.net>
To:     acme@redhat.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: perf's handling of unfindable user symbols...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181015222546.GA2159@redhat.com>
References: <20181014.004238.292485794143606801.davem@davemloft.net>
        <20181015222546.GA2159@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 16:02:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 15 Oct 2018 19:25:46 -0300

> But I think we should have it as a property of 'struct machine', because we may
> be processing on, say, x86, a perf.data file recorded on a Sparc machine, so we
> need to save this property on the perf.data file, humm, or we can derive that
> from data already there, like the quick patch below. I'll cache that property
> on machine->user_kernel_shared_address_space, to avoid having to do the
> strcmp() lots of times.
> 
> Does that document the hack further? Defining the
> machine__user_kernel_shared_address_space() function right besides the
> machine__kernel_ip() inline should help as well?

Your patch looks fine.

But, more deeply, the VDSO thing itself makes no sense to me.

Why would we use the kernel map for something that is mapped into
userspace and uses the user space virtual addresse range?

As it is used by user applications, the VDSO isn't mapped into the
kernel virtual address range, therefore no PC from userspace executing
the VDSO will have a kernel range address.

We will see normal userspace virtual addresses instead.  Test this
assertion, if you like :-)

So I am suggesting that we remove the hack, and don't try to use the
kernel map for resolving the IP of user mode events.  If that is a
valid change, we can toss all of this weird stuff that tries to
interpret an address based upon what "range" it falls into.

