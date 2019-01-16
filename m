Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82643C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1D22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfAPFgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:36:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34336 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbfAPFgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:36:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F7A114AC3A7F;
        Tue, 15 Jan 2019 21:36:15 -0800 (PST)
Date:   Tue, 15 Jan 2019 21:36:12 -0800 (PST)
Message-Id: <20190115.213612.497427192026892080.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Revert "rxrpc: Allow failed client calls to be
 retried"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154713955397.15386.3132662854461157170.stgit@warthog.procyon.org.uk>
References: <154713955397.15386.3132662854461157170.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Jan 2019 21:36:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 10 Jan 2019 16:59:13 +0000

> The changes introduced to allow rxrpc calls to be retried creates an issue
> when it comes to refcounting afs_call structs.  The problem is that when
> rxrpc_send_data() queues the last packet for an asynchronous call, the
> following sequence can occur:
 ...
> Synchronising the clean up after rxrpc_kernel_send_data() returns an error
> with the asynchronous cleanup is then tricky to get right.
> 
> Mostly revert commit c038a58ccfd6704d4d7d60ed3d6a0fca13cf13a4.  The two API
> functions the original commit added aren't currently used.  This makes
> rxrpc_kernel_send_data() always return successfully if it queued the data
> it was given.
> 
> Note that this doesn't affect synchronous calls since their Rx notification
> function merely pokes a wait queue and does not refcounting.  The
> asynchronous call notification function *has* to do refcounting and pass a
> ref over the work item to avoid the need to sync the workqueue in call
> cleanup.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied.
