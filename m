Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD9C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1F218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358011;
	bh=xQLrDoFaqFNBcNCcDiBFOFL/BhoLW8qAG/obQP7cFpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gA0F0ZlB5BREFzS7C8x4W2vgAXwtHp09MKuS+kZOnaVLQh9gvrmCvc+WqCBjTi7s+
	 8P7jR+uECY6G/oc8wda585zhwOsjJXWRGaV9s3KEbD8WI0BdU8ZzOCTt8nsqafs9Za
	 zCyIE5E5EW5CpNVvfZh7ZCOHCHP+JreJmKRAJQJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfAXT0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfAXT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:26:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB81218FC;
        Thu, 24 Jan 2019 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358004;
        bh=xQLrDoFaqFNBcNCcDiBFOFL/BhoLW8qAG/obQP7cFpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgxY/93Ykq2nZJiR2Dp7NgSHTfBL7XJhHHHTdLYjtH1QDHT2UdQXFTDzrn8mIJRiN
         ROg1ZMR90m9M+w9qB0sdwP6d+1hCpC7tBSbKvCG0/qjRSco83ratYUabvUszK8mz/Q
         kGf+1IyyyAl7DHRiDZGz4ZuPJQ4lwiAWnAflKwaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 064/104] tipc: fix uninit-value in tipc_nl_compat_link_set
Date:   Thu, 24 Jan 2019 20:19:53 +0100
Message-Id: <20190124190202.687403178@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

From: Ying Xue <ying.xue@windriver.com>

commit edf5ff04a45750ac8ce2435974f001dc9cfbf055 upstream.

syzbot reports following splat:

BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:486
CPU: 1 PID: 9306 Comm: syz-executor172 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  strlen+0x3b/0xa0 lib/string.c:486
  nla_put_string include/net/netlink.h:1154 [inline]
  __tipc_nl_compat_link_set net/tipc/netlink_compat.c:708 [inline]
  tipc_nl_compat_link_set+0x929/0x1220 net/tipc/netlink_compat.c:744
  __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
  tipc_nl_compat_doit+0x3aa/0xaf0 net/tipc/netlink_compat.c:344
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1107 [inline]
  tipc_nl_compat_recv+0x14d7/0x2760 net/tipc/netlink_compat.c:1210
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xf40/0x1020 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

The uninitialised access happened in
    nla_put_string(skb, TIPC_NLA_LINK_NAME, lc->name)

This is because lc->name string is not validated before it's used.

Reported-by: syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com
Signed-off-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -723,9 +723,14 @@ static int tipc_nl_compat_link_set(struc
 	struct tipc_link_config *lc;
 	struct tipc_bearer *bearer;
 	struct tipc_media *media;
+	int len;
 
 	lc = (struct tipc_link_config *)TLV_DATA(msg->req);
 
+	len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_LINK_NAME);
+	if (!string_is_valid(lc->name, len))
+		return -EINVAL;
+
 	media = tipc_media_find(lc->name);
 	if (media) {
 		cmd->doit = &tipc_nl_media_set;


