Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221788-2-11269070392575829017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221787; b=QFoIhfxbxPqi3r0XlYuMuZifVh+wHSy3hCtQxDlzRgJIrnI
    411FrmIu5OOQpBABOcAymrtdQRBgPtVhtjGFEBWHWa9EYs8XrFQCuLL7CSqUyNbI
    hhUWHdIgLBBYeDN4tIKPgZL5JUluPpdKshqLu7yYjlZ+yrGOqRLpnWOfaTmAWzu5
    jfM30KM0c92tYk59aFDt2QKGVN9Pu0lYhU4YIgLjWEzMPwqwhSvD4uj3sROWHoJI
    VJlk238SC9UOW4ZubL+O5c8ndaVp4S12/1w3hzRZGqZ8UHqqZ/5ksgjAuyl5PckX
    BAbuWgJEWFwA/VGdfRc747dZuGhkOgDZmODngaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221787; bh=MjEhepK5us4B9WZT06LGiTLfHT
    vLO26mVLtuXutFkKk=; b=plZGfijo7+WhLhxDExWb9Eah6fYwDapFAHnj4FdPV9
    I6xk8p8u/Wd1Cwfd5+W5VmaxQE/pr3aZvvoPGiFDpbBtvhJr8QMJHc5MDiuu4S/p
    nPiTZPadN8jsUOSUMXD9QywmqQkBW9N3/b8vnB4CP+SsKFT/jfjV56bNsx/fTsbb
    L0kUaoh/4f/yBOAbntzhgeGw1GxvA0lIB5lH5X6d3q9ULDG+qoecf42egmDibTk8
    EBP0ZM2wQdjLpd2DIoGzu37rhURsq8IbPR/+oHYuM+A7fVdSHX8sCEZXmvaZL/IT
    54dhDoReHfwpVcsKmo3BSAy+xDeQqvllCK5jvaE1Q5ZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCPP0s (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932573AbeCPP0p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8012e198bd037f4871e5@syzkaller.appspotmail.com,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 08/25] netfilter: nat: cope with negative port range
Date: Fri, 16 Mar 2018 16:22:55 +0100
Message-Id: <20180316152233.096672405@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit db57ccf0f2f4624b4c4758379f8165277504fbd7 upstream.

syzbot reported a division by 0 bug in the netfilter nat code:

divide error: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4168 Comm: syzkaller034710 Not tainted 4.16.0-rc1+ #309
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:nf_nat_l4proto_unique_tuple+0x291/0x530
net/netfilter/nf_nat_proto_common.c:88
RSP: 0018:ffff8801b2466778 EFLAGS: 00010246
RAX: 000000000000f153 RBX: ffff8801b2466dd8 RCX: ffff8801b2466c7c
RDX: 0000000000000000 RSI: ffff8801b2466c58 RDI: ffff8801db5293ac
RBP: ffff8801b24667d8 R08: ffff8801b8ba6dc0 R09: ffffffff88af5900
R10: ffff8801b24666f0 R11: 0000000000000000 R12: 000000002990f153
R13: 0000000000000001 R14: 0000000000000000 R15: ffff8801b2466c7c
FS:  00000000017e3880(0000) GS:ffff8801db500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000208fdfe4 CR3: 00000001b5340002 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  dccp_unique_tuple+0x40/0x50 net/netfilter/nf_nat_proto_dccp.c:30
  get_unique_tuple+0xc28/0x1c10 net/netfilter/nf_nat_core.c:362
  nf_nat_setup_info+0x1c2/0xe00 net/netfilter/nf_nat_core.c:406
  nf_nat_redirect_ipv6+0x306/0x730 net/netfilter/nf_nat_redirect.c:124
  redirect_tg6+0x7f/0xb0 net/netfilter/xt_REDIRECT.c:34
  ip6t_do_table+0xc2a/0x1a30 net/ipv6/netfilter/ip6_tables.c:365
  ip6table_nat_do_chain+0x65/0x80 net/ipv6/netfilter/ip6table_nat.c:41
  nf_nat_ipv6_fn+0x594/0xa80 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c:302
  nf_nat_ipv6_local_fn+0x33/0x5d0
net/ipv6/netfilter/nf_nat_l3proto_ipv6.c:407
  ip6table_nat_local_fn+0x2c/0x40 net/ipv6/netfilter/ip6table_nat.c:69
  nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
  nf_hook_slow+0xba/0x1a0 net/netfilter/core.c:483
  nf_hook include/linux/netfilter.h:243 [inline]
  NF_HOOK include/linux/netfilter.h:286 [inline]
  ip6_xmit+0x10ec/0x2260 net/ipv6/ip6_output.c:277
  inet6_csk_xmit+0x2fc/0x580 net/ipv6/inet6_connection_sock.c:139
  dccp_transmit_skb+0x9ac/0x10f0 net/dccp/output.c:142
  dccp_connect+0x369/0x670 net/dccp/output.c:564
  dccp_v6_connect+0xe17/0x1bf0 net/dccp/ipv6.c:946
  __inet_stream_connect+0x2d4/0xf00 net/ipv4/af_inet.c:620
  inet_stream_connect+0x58/0xa0 net/ipv4/af_inet.c:684
  SYSC_connect+0x213/0x4a0 net/socket.c:1639
  SyS_connect+0x24/0x30 net/socket.c:1620
  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x26/0x9b
RIP: 0033:0x441c69
RSP: 002b:00007ffe50cc0be8 EFLAGS: 00000217 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 0000000000441c69
RDX: 000000000000001c RSI: 00000000208fdfe4 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000538 R11: 0000000000000217 R12: 0000000000403590
R13: 0000000000403620 R14: 0000000000000000 R15: 0000000000000000
Code: 48 89 f0 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 46 02 00 00 48 8b
45 c8 44 0f b7 20 e8 88 97 04 fd 31 d2 41 0f b7 c4 4c 89 f9 <41> f7 f6 48
c1 e9 03 48 b8 00 00 00 00 00 fc ff df 0f b6 0c 01
RIP: nf_nat_l4proto_unique_tuple+0x291/0x530
net/netfilter/nf_nat_proto_common.c:88 RSP: ffff8801b2466778

The problem is that currently we don't have any check on the
configured port range. A port range == -1 triggers the bug, while
other negative values may require a very long time to complete the
following loop.

This commit addresses the issue swapping the two ends on negative
ranges. The check is performed in nf_nat_l4proto_unique_tuple() since
the nft nat loads the port values from nft registers at runtime.

v1 -> v2: use the correct 'Fixes' tag
v2 -> v3: update commit message, drop unneeded READ_ONCE()

Fixes: 5b1158e909ec ("[NETFILTER]: Add NAT support for nf_conntrack")
Reported-by: syzbot+8012e198bd037f4871e5@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_nat_proto_common.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/netfilter/nf_nat_proto_common.c
+++ b/net/netfilter/nf_nat_proto_common.c
@@ -41,7 +41,7 @@ void nf_nat_l4proto_unique_tuple(const s
 				 const struct nf_conn *ct,
 				 u16 *rover)
 {
-	unsigned int range_size, min, i;
+	unsigned int range_size, min, max, i;
 	__be16 *portptr;
 	u_int16_t off;
 
@@ -71,7 +71,10 @@ void nf_nat_l4proto_unique_tuple(const s
 		}
 	} else {
 		min = ntohs(range->min_proto.all);
-		range_size = ntohs(range->max_proto.all) - min + 1;
+		max = ntohs(range->max_proto.all);
+		if (unlikely(max < min))
+			swap(max, min);
+		range_size = max - min + 1;
 	}
 
 	if (range->flags & NF_NAT_RANGE_PROTO_RANDOM) {
