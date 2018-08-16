Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B87208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B87208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeHPG1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:27:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHPG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:27:51 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB609BDB;
        Thu, 16 Aug 2018 03:32:27 +0000 (UTC)
Date:   Wed, 15 Aug 2018 20:32:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Peter Kalauskas <peskal@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-Id: <20180815203226.2c7e48b2f9395d2772ecfcb2@linux-foundation.org>
In-Reply-To: <20180816014835.GA2793@jagdpanzerIV>
References: <20180808223100.225086-1-peskal@google.com>
        <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
        <20180813073825.GA1062@jagdpanzerIV>
        <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
        <20180816014835.GA2793@jagdpanzerIV>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 10:48:35 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > The implementation might be able to use strim() somehow.
> 
> strim() trims white-spaces.

Which includes \n.

> What we have here is a trailing new line symbol,
> which echo appends to the string it writes to the kernel [echo -n switch
> disables it]. So we receive a "/dev/name\n" device name from sysfs, which we
> unsuccessfully try to open(). To make it all work we need to remove that
> trailing new line.
> 
> A side note,
> There is sysfs_strcmp(), which takes care of that "user space may append
> a new line to the string" case, I wonder if we should finally have
> sysfs_strcpy(), which would not copy the trailing new line. I think this
> "if string[sz - 1] == '\n' then string[sz - 1] == 0x00" is quite common.

Sure, some additional well-chosen helpers here would be good.  There's
a LOT of code which does basically-the-same-thing with sysfs input. 
And a lot of it misses things, such as leading whitespace.  Passing all
this through helpers would provide consistency as well as code-size
reductions, improved reviewability, etc.


