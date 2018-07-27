Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD22C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA542089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA542089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbeG0LJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbeG0LJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:03 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 41591898;
        Fri, 27 Jul 2018 09:47:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 26/66] tls: check RCV_SHUTDOWN in tls_wait_data
Date:   Fri, 27 Jul 2018 11:45:19 +0200
Message-Id: <20180727093812.107280483@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doron Roberts-Kedes <doronrk@fb.com>

[ Upstream commit fcf4793e278edede8fcd748198d12128037e526c ]

The current code does not check sk->sk_shutdown & RCV_SHUTDOWN.
tls_sw_recvmsg may return a positive value in the case where bytes have
already been copied when the socket is shutdown. sk->sk_err has been
cleared, causing the tls_wait_data to hang forever on a subsequent
invocation. Checking sk->sk_shutdown & RCV_SHUTDOWN, as in tcp_recvmsg,
fixes this problem.

Fixes: c46234ebb4d1 ("tls: RX path for ktls")
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -646,6 +646,9 @@ static struct sk_buff *tls_wait_data(str
 			return NULL;
 		}
 
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			return NULL;
+
 		if (sock_flag(sk, SOCK_DONE))
 			return NULL;
 


