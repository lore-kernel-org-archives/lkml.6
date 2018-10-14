Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64045C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3475A20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3475A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJNX0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:26:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37127 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbeJNX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:26:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cY-Ek; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000Oe-DX; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Cong Wang" <xiyou.wangcong@gmail.com>,
        "" <syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.787900772@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 189/366] llc: hold llc_sap before release_sock()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit f7e43672683b097bb074a8fe7af9bc600a23f231 upstream.

syzbot reported we still access llc->sap in llc_backlog_rcv()
after it is freed in llc_sap_remove_socket():

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
 llc_conn_ac_send_sabme_cmd_p_set_x+0x3a8/0x460 net/llc/llc_c_ac.c:785
 llc_exec_conn_trans_actions net/llc/llc_conn.c:475 [inline]
 llc_conn_service net/llc/llc_conn.c:400 [inline]
 llc_conn_state_process+0x4e1/0x13a0 net/llc/llc_conn.c:75
 llc_backlog_rcv+0x195/0x1e0 net/llc/llc_conn.c:891
 sk_backlog_rcv include/net/sock.h:909 [inline]
 __release_sock+0x12f/0x3a0 net/core/sock.c:2335
 release_sock+0xa4/0x2b0 net/core/sock.c:2850
 llc_ui_release+0xc8/0x220 net/llc/af_llc.c:204

llc->sap is refcount'ed and llc_sap_remove_socket() is paired
with llc_sap_add_socket(). This can be amended by holding its refcount
before llc_sap_remove_socket() and releasing it after release_sock().

Reported-by: <syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/llc/af_llc.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,6 +187,7 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -197,9 +198,15 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
+	sap = llc->sap;
+	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
+	 * use it.
+	 */
+	llc_sap_hold(sap);
 	if (!sock_flag(sk, SOCK_ZAPPED))
 		llc_sap_remove_socket(llc->sap, sk);
 	release_sock(sk);
+	llc_sap_put(sap);
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);

