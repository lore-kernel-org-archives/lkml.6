Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8782C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F42081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1F42081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKCQKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:10:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:10:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2CA28141A8EF8;
        Sat,  3 Nov 2018 00:00:19 -0700 (PDT)
Date:   Sat, 03 Nov 2018 00:00:18 -0700 (PDT)
Message-Id: <20181103.000018.2014183024812085135.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix lockup due to no error backoff after
 ack transmit error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154107959336.26689.262397874166625147.stgit@warthog.procyon.org.uk>
References: <154107959336.26689.262397874166625147.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 03 Nov 2018 00:00:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 01 Nov 2018 13:39:53 +0000

> If the network becomes (partially) unavailable, say by disabling IPv6, the
> background ACK transmission routine can get itself into a tizzy by
> proposing immediate ACK retransmission.  Since we're in the call event
> processor, that happens immediately without returning to the workqueue
> manager.
> 
> The condition should clear after a while when either the network comes back
> or the call times out.
> 
> Fix this by:
> 
>  (1) When re-proposing an ACK on failed Tx, don't schedule it immediately.
>      This will allow a certain amount of time to elapse before we try
>      again.
> 
>  (2) Enforce a return to the workqueue manager after a certain number of
>      iterations of the call processing loop.
> 
>  (3) Add a backoff delay that increases the delay on deferred ACKs by a
>      jiffy per failed transmission to a limit of HZ.  The backoff delay is
>      cleared on a successful return from kernel_sendmsg().
> 
>  (4) Cancel calls immediately if the opening sendmsg fails.  The layer
>      above can arrange retransmission or rotate to another server.
> 
> Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied and queued up for -stable.
