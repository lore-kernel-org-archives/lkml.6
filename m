Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BFC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A0720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A0720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeIMSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:48:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeIMSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:48:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B340CF3;
        Thu, 13 Sep 2018 13:38:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ricardo Nabinger Sanchez <rnsanchez@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 4.9 59/78] tcp: Revert "tcp: tcp_probe: use spin_lock_bh()"
Date:   Thu, 13 Sep 2018 15:31:46 +0200
Message-Id: <20180913131811.656361967@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 29869d66870a715177bfb505f66a7e0e8bcc89c3 upstream.

This reverts commit e70ac171658679ecf6bea4bbd9e9325cd6079d2b.

jtcp_rcv_established() is in fact called with hard irq being disabled.

Initial bug report from Ricardo Nabinger Sanchez [1] still needs
to be investigated, but does not look like a TCP bug.

[1] https://www.spinics.net/lists/netdev/msg420960.html

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Cc: Ricardo Nabinger Sanchez <rnsanchez@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_probe.c
+++ b/net/ipv4/tcp_probe.c
@@ -117,7 +117,7 @@ static void jtcp_rcv_established(struct
 	     (fwmark > 0 && skb->mark == fwmark)) &&
 	    (full || tp->snd_cwnd != tcp_probe.lastcwnd)) {
 
-		spin_lock_bh(&tcp_probe.lock);
+		spin_lock(&tcp_probe.lock);
 		/* If log fills, just silently drop */
 		if (tcp_probe_avail() > 1) {
 			struct tcp_log *p = tcp_probe.log + tcp_probe.head;
@@ -157,7 +157,7 @@ static void jtcp_rcv_established(struct
 			tcp_probe.head = (tcp_probe.head + 1) & (bufsize - 1);
 		}
 		tcp_probe.lastcwnd = tp->snd_cwnd;
-		spin_unlock_bh(&tcp_probe.lock);
+		spin_unlock(&tcp_probe.lock);
 
 		wake_up(&tcp_probe.wait);
 	}


