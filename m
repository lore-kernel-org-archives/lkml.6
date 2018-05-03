Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeECTWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:22:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51660 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeECTWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:22:15 -0400
Date: Thu, 03 May 2018 15:22:13 -0400 (EDT)
Message-Id: <20180503.152213.740988890883315228.davem@davemloft.net>
To: syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com
Cc: jon.maloy@ericsson.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Subject: Re: KMSAN: uninit-value in strcmp
From: David Miller <davem@davemloft.net>
In-Reply-To: <00000000000059f907056b519603@google.com>
References: <00000000000059f907056b519603@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syzbot <syzbot+df0257c92ffd4fcc58cd@syzkaller.appspotmail.com>
Date: Thu, 03 May 2018 11:44:02 -0700

> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>  strcmp+0xf7/0x160 lib/string.c:329
>  tipc_nl_node_get_link+0x220/0x6f0 net/tipc/node.c:1881
>  genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]

Hmmm, TIPC_NL_LINK_GET uses tipc_nl_policy, which has a proper nesting
entry for TIPC_NLA_LINK.  I wonder how the code goes about validating
TIPC_NLA_LINK_NAME in such a case?  Does it?

This may be the problem.
