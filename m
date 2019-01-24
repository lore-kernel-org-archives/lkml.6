Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19217C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA68F218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359076;
	bh=BRYcvoOSSWRrOgkaZsxZSCVp+ELA43wAiBehBFZybQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zf1SSmLXWCkH+nPq78+gWO/c6kZxwNKTd5c6vXCfVE6/JW5YQGHu1FPKtDlGOjeZI
	 d+kQBC6x5PFpTi9UX3v+UurPZj8QArA9UkOGcNnfUYGgWEnOcwvOcSb9j6JvF8gDPx
	 ZrHSUa1LIDNVLSysbc+4OqbhiVHQ88YjmfRO8fdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfAXTof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387739AbfAXTob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB03620663;
        Thu, 24 Jan 2019 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359071;
        bh=BRYcvoOSSWRrOgkaZsxZSCVp+ELA43wAiBehBFZybQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lS+EOLxQ0lwikxXJpUnfBP1xlbA9oetCJ4vDR4yBvOozd+y2BzLwnutho6HkuSkiR
         loGEQI5Nz2aUUtWL9RLFgTwzG9CUv6Dx8hYmpTO3dvG1IkhkcgnkGt0jx9XGEKviv2
         vEFKQThB9yGmqqNxmd8IgND+c7FXNwHUWKPb3HvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fred Klassen <fklassen@appneta.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.20 126/127] ipmi: Prevent use-after-free in deliver_response
Date:   Thu, 24 Jan 2019 20:21:12 +0100
Message-Id: <20190124190217.277761137@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fred Klassen <fklassen@appneta.com>

commit 479d6b39b9e0d2de648ebf146f23a1e40962068f upstream.

Some IPMI modules (e.g. ibmpex_msg_handler()) will have ipmi_usr_hdlr
handlers that call ipmi_free_recv_msg() directly. This will essentially
kfree(msg), leading to use-after-free.

This does not happen in the ipmi_devintf module, which will queue the
message and run ipmi_free_recv_msg() later.

BUG: KASAN: use-after-free in deliver_response+0x12f/0x1b0
Read of size 8 at addr ffff888a7bf20018 by task ksoftirqd/3/27
CPU: 3 PID: 27 Comm: ksoftirqd/3 Tainted: G           O      4.19.11-amd64-ani99-debug #12.0.1.601133+pv
Hardware name: AppNeta r1000/X11SPW-TF, BIOS 2.1a-AP 09/17/2018
Call Trace:
dump_stack+0x92/0xeb
print_address_description+0x73/0x290
kasan_report+0x258/0x380
deliver_response+0x12f/0x1b0
? ipmi_free_recv_msg+0x50/0x50
deliver_local_response+0xe/0x50
handle_one_recv_msg+0x37a/0x21d0
handle_new_recv_msgs+0x1ce/0x440
...

Allocated by task 9885:
kasan_kmalloc+0xa0/0xd0
kmem_cache_alloc_trace+0x116/0x290
ipmi_alloc_recv_msg+0x28/0x70
i_ipmi_request+0xb4a/0x1640
ipmi_request_settime+0x1b8/0x1e0
...

Freed by task 27:
__kasan_slab_free+0x12e/0x180
kfree+0xe9/0x280
deliver_response+0x122/0x1b0
deliver_local_response+0xe/0x50
handle_one_recv_msg+0x37a/0x21d0
handle_new_recv_msgs+0x1ce/0x440
tasklet_action_common.isra.19+0xc4/0x250
__do_softirq+0x11f/0x51f

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Fred Klassen <fklassen@appneta.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -894,7 +894,7 @@ static int deliver_response(struct ipmi_
 
 		if (user) {
 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
-			release_ipmi_user(msg->user, index);
+			release_ipmi_user(user, index);
 		} else {
 			/* User went away, give up. */
 			ipmi_free_recv_msg(msg);


