Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA310C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959502177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216236;
	bh=3sPrLwBGuMfJEILS8CJIdkHTWXkxhVl3qnvomHgTJ68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YtYlNwAr/JbmMr1ktP8R608kyqmVqnMPk7QEcQxlikRUlDSQfaZqTr85gsGfTvPEO
	 LU/ffcuLjfjiO/kSWYsgoZWX5C/WzfRSZHDD5nwTiMAbKorpBPqpDbIhb3bO9bAWPo
	 5p1ozwA988NCrMMDOgiTZ/Ici1+exvoMiCFtFrV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfAKORP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbfAKORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C2B214D8;
        Fri, 11 Jan 2019 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216232;
        bh=3sPrLwBGuMfJEILS8CJIdkHTWXkxhVl3qnvomHgTJ68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6YxezKj3Fy/FlkZ2ll8FnS4ppWY0LmngQ8/7WUEQ2Xhmb6IA/d7Qp1PPztMG6c9e
         NOLyu8P5Q7ATY95lHqpfnZUe49HgkEs9STX8RN16z07vIzxsumWnHuiujvvNkb7uLY
         PER24Z8382vNquP6rj/lUVtHeIrImuo8buGYSYus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 24/88] sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event
Date:   Fri, 11 Jan 2019 15:07:53 +0100
Message-Id: <20190111131049.722786865@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 4a2eb0c37b4759416996fbb4c45b932500cf06d3 ]

syzbot reported a kernel-infoleak, which is caused by an uninitialized
field(sin6_flowinfo) of addr->a.v6 in sctp_inet6addr_event().
The call trace is as below:

  BUG: KMSAN: kernel-infoleak in _copy_to_user+0x19a/0x230 lib/usercopy.c:33
  CPU: 1 PID: 8164 Comm: syz-executor2 Not tainted 4.20.0-rc3+ #95
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
  Google 01/01/2011
  Call Trace:
    __dump_stack lib/dump_stack.c:77 [inline]
    dump_stack+0x32d/0x480 lib/dump_stack.c:113
    kmsan_report+0x12c/0x290 mm/kmsan/kmsan.c:683
    kmsan_internal_check_memory+0x32a/0xa50 mm/kmsan/kmsan.c:743
    kmsan_copy_to_user+0x78/0xd0 mm/kmsan/kmsan_hooks.c:634
    _copy_to_user+0x19a/0x230 lib/usercopy.c:33
    copy_to_user include/linux/uaccess.h:183 [inline]
    sctp_getsockopt_local_addrs net/sctp/socket.c:5998 [inline]
    sctp_getsockopt+0x15248/0x186f0 net/sctp/socket.c:7477
    sock_common_getsockopt+0x13f/0x180 net/core/sock.c:2937
    __sys_getsockopt+0x489/0x550 net/socket.c:1939
    __do_sys_getsockopt net/socket.c:1950 [inline]
    __se_sys_getsockopt+0xe1/0x100 net/socket.c:1947
    __x64_sys_getsockopt+0x62/0x80 net/socket.c:1947
    do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
    entry_SYSCALL_64_after_hwframe+0x63/0xe7

sin6_flowinfo is not really used by SCTP, so it will be fixed by simply
setting it to 0.

The issue exists since very beginning.
Thanks Alexander for the reproducer provided.

Reported-by: syzbot+ad5d327e6936a2e284be@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -101,6 +101,7 @@ static int sctp_inet6addr_event(struct n
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
 			addr->a.v6.sin6_port = 0;
+			addr->a.v6.sin6_flowinfo = 0;
 			addr->a.v6.sin6_addr = ifa->addr;
 			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
 			addr->valid = 1;


