Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B208C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA12A208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA12A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeLEUL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:11:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeLEUL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:11:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22BDCADC8;
        Wed,  5 Dec 2018 20:11:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Dec 2018 21:11:54 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <b8c6ef78-f0ea-2bc5-566a-9482061fffb2@akamai.com>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
 <38cc83144a2ec332dead4e21214ea068@suse.de>
 <b8c6ef78-f0ea-2bc5-566a-9482061fffb2@akamai.com>
Message-ID: <1c214a8b9e6c06589c912b55d2ef5f37@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-05 17:38, Jason Baron wrote:
> 
> I think it might be interesting for, at least testing, to see if not 
> grabbing
> wq.lock improves your benchmarks any further? fwiw, epoll only recently 
> started
> grabbing wq.lock bc lockdep required it.

That's easy!  I've just tested with the following hunk applied to my 
patch on top:

+++ b/fs/eventpoll.c
@@ -1228,7 +1228,7 @@ static int ep_poll_callback(wait_queue_entry_t 
*wait, unsigned mode, int sync, v
                                 break;
                         }
                 }
-               wake_up(&ep->wq);
+               wake_up_locked(&ep->wq);
         }

Run time:

threads   w/ wq.lock   w/o wq.lock
-------   ----------   -----------
      8        8581ms        8602ms
     16       13800ms       13715ms
     32       24167ms       23817ms

No big difference.  According to perf the contention is on read lock and
on try_to_wake_up(), the p->pi_lock, which serializes access exactly 
like
vanished wq.lock.


-   24.41%     5.39%  a.out    [kernel.kallsyms]   [k] ep_poll_callback
    - 19.02% ep_poll_callback
       + 11.88% _raw_read_lock_irqsave
       + 5.74% _raw_read_unlock_irqrestore
       - 1.39% __wake_up_common
          - 1.22% try_to_wake_up
             + 0.98% _raw_spin_lock_irqsave


--
Roman
