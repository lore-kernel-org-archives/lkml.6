Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C07C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 23:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1953A20862
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 23:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1953A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeG3BGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 21:06:09 -0400
Received: from nautica.notk.org ([91.121.71.147]:46979 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbeG3BGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 21:06:09 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 73184C009; Mon, 30 Jul 2018 01:33:51 +0200 (CEST)
Date:   Mon, 30 Jul 2018 01:33:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: fix Use-After-Free in p9_write_work()
Message-ID: <20180729233336.GB28684@nautica>
References: <20180729130248.29612-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180729130248.29612-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Sun, Jul 29, 2018:
> There is a race condition between p9_free_req() and p9_write_work().
> A request might still need to be processed while p9_free_req() is called.
> 
> To fix it, flush the read/write work before freeing any request.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com

It looks like I have not received this report, I found it through google
in the lkml archives but Dmitry do you have a convenient-ish way of
finding the report on the syzkaller website with that reported-by tag?

> ---
> 
> To be able to flush the r/w work from client.c we need the p9_conn and
> p9_trans_fd definitions. Therefore this commit moves most of the declarations in
> trans_fd.c to trans_fd.h and import such file in client.c

This cannot work as it is, because you're not just intorudcing the
trans_fd types but you're really depending on the transport used being
fd.
'conn.wq' won't even be valid memory in other transports so I don't want
to know what trying to flush_work on this will do... :)


Other transports also have the same issue see discussion in
https://lkml.org/lkml/2018/7/19/727
(that is another syzbot report, slightly different but I believe it
points to the same issue)

Basically, a more global view of the problem is a race between
p9_tag_lookup returning a p9_req_t and another thread freeing it.

Matthew wrote the problem himself in a comment in p9_tag_lookup in his new
version that used to be in linux-next at the time (I took the commit out
temporarily until I've had time to benchmark it, but it will come back in,
just you're working on thin air right now because the bug was only found
thanks to this commit):
+       /* There's no refcount on the req; a malicious server could
cause
+        * us to dereference a NULL pointer
+        */

So a more proper solution would be to had a refcount to req, have
p9_tag_lookup increment the refcount within rcu_read_lock, and have a
deref function free the req when the count hits 0.


Now we're here though I'm not sure what to suggest, I had promised to
get some performance benchmark out by this past weekend and I obviously
failed, so this patch might be delayed to 4.20 and the refcount approach
would not work with the current req cache/reuse system we have right
now.
If you want to finish this anyway you can work on my 9p-test branch
(I've kept the commit there), and I'll take that patch in at the same
time as the other.


> Moreover, a couple of identifiers were altered to avoid name conflicts with the
> new import.

If we were to stick to this approach, two suggestions:
 - headers aren't all-or-nothing, I think it's better to only expose
what you need (and e.g. keep the Opt_* enum in the .c)
 - instead of exposing trans_fd specific stuff, it's cleaner to add a
new op vector '.flush' to the p9_trans_module struct and call that if it
exists.


Thanks,
-- 
Dominique
