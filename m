Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E3C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEE320879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080512;
	bh=sjFAX/dMMQE36hbbXOfX8hj4bStcmbRIn/O2h1iaMBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OMoKAF+OPb/VWHRZdZOIAuaCy47+XWUkrDNLlm8zkD7+KrdbdpDUVgLNU3+gMg+G0
	 rIK1qn4JklxvYwph/J3qB6XZKR6PhqfyGThl2OYTlmudEYSwcdEcseKMPzeh+TwaQf
	 hISbhOdF4wl/wcC07GUyj6mzpdEj0BO2aTeA7a5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAUNqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbfAUNqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1600720870;
        Mon, 21 Jan 2019 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078403;
        bh=sjFAX/dMMQE36hbbXOfX8hj4bStcmbRIn/O2h1iaMBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eALMCZ2BvwbvW87jdtviLY14wnQs/y79WjZoxc2+qswXX6GHqF4uNbHpRk1a4XmU/
         bab3mLKScFHVLMFD8f1xhIF+e10biV3yyEPd9O+wCibXo3Rs5WfwkUVkAD5sPMuGh1
         baKExF3qjoM8LMexJs+SiJ/b+XAZZ/bEqYqZhNOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 020/111] tcp: change txhash on SYN-data timeout
Date:   Mon, 21 Jan 2019 14:42:14 +0100
Message-Id: <20190121122458.018023071@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit c5715b8fabfca0ef85903f8bad2189940ed41cc8 ]

Previously upon SYN timeouts the sender recomputes the txhash to
try a different path. However this does not apply on the initial
timeout of SYN-data (active Fast Open). Therefore an active IPv6
Fast Open connection may incur one second RTO penalty to take on
a new path after the second SYN retransmission uses a new flow label.

This patch removes this undesirable behavior so Fast Open changes
the flow label just like the regular connections. This also helps
avoid falsely disabling Fast Open on the sender which triggers
after two consecutive SYN timeouts on Fast Open.

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -226,7 +226,7 @@ static int tcp_write_timeout(struct sock
 	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
 		if (icsk->icsk_retransmits) {
 			dst_negative_advice(sk);
-		} else if (!tp->syn_data && !tp->syn_fastopen) {
+		} else {
 			sk_rethink_txhash(sk);
 		}
 		retry_until = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_syn_retries;


