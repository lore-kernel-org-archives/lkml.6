Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FF720645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FF720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeLEXqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:46:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53470 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbeLEXqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:46:49 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2CDED211B3;
        Wed,  5 Dec 2018 23:46:49 +0000 (UTC)
Date:   Wed, 5 Dec 2018 23:46:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
Message-ID: <20181205234649.ssvmv4ulwevgdla4@dcvr>
References: <20181203110237.14787-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203110237.14787-1-rpenyaev@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Penyaev <rpenyaev@suse.de> wrote:
> Hi all,
> 
> The goal of this patch is to reduce contention of ep_poll_callback() which
> can be called concurrently from different CPUs in case of high events
> rates and many fds per epoll.  Problem can be very well reproduced by
> generating events (write to pipe or eventfd) from many threads, while
> consumer thread does polling.  In other words this patch increases the
> bandwidth of events which can be delivered from sources to the poller by
> adding poll items in a lockless way to the list.

Hi Roman,

I also tried to solve this problem many years ago with help of
the well-tested-in-userspace wfcqueue from Mathieu's URCU.

I was also looking to solve contention with parallel epoll_wait
callers with this.  AFAIK, it worked well; but needed the
userspace tests from wfcqueue ported over to the kernel and more
review.

I didn't have enough computing power to show the real-world
benefits or funding to continue:

	https://lore.kernel.org/lkml/?q=wfcqueue+d:..20130501

It might not be too much trouble for you to brush up the wait-free
patches and test them against the rwlock implementation.

(I only noticed this thread since I was catching up on some
 public-inbox work :>)
