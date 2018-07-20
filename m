Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF128ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A606D20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A606D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbeGTNQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:16:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbeGTNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:16:11 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6900BCF;
        Fri, 20 Jul 2018 12:28:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 31/31] net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.
Date:   Fri, 20 Jul 2018 14:14:01 +0200
Message-Id: <20180720121341.278466905@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 3bc53be9db21040b5d2de4d455f023c8c494aa68 upstream.

syzbot is reporting stalls at nfc_llcp_send_ui_frame() [1]. This is
because nfc_llcp_send_ui_frame() is retrying the loop without any delay
when nonblocking nfc_alloc_send_skb() returned NULL.

Since there is no need to use MSG_DONTWAIT if we retry until
sock_alloc_send_pskb() succeeds, let's use blocking call.
Also, in case an unexpected error occurred, let's break the loop
if blocking nfc_alloc_send_skb() failed.

[1] https://syzkaller.appspot.com/bug?id=4a131cc571c3733e0eff6bc673f4e36ae48f19c6

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/nfc/llcp_commands.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -754,11 +754,14 @@ int nfc_llcp_send_ui_frame(struct nfc_ll
 		pr_debug("Fragment %zd bytes remaining %zd",
 			 frag_len, remaining_len);
 
-		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
+		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, 0,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
-			pr_err("Could not allocate PDU\n");
-			continue;
+			pr_err("Could not allocate PDU (error=%d)\n", err);
+			len -= remaining_len;
+			if (len == 0)
+				len = err;
+			break;
 		}
 
 		pdu = llcp_add_header(pdu, dsap, ssap, LLCP_PDU_UI);


