Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4367FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F03D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F03D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbeGTNdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:33:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbeGTNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:33:11 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2FB39D69;
        Fri, 20 Jul 2018 12:39:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d464d2c20c717ef5a6a8@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.17 080/101] bpf: sockmap, consume_skb in close path
Date:   Fri, 20 Jul 2018 14:14:26 +0200
Message-Id: <20180720121426.660871694@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

commit 7ebc14d507b4b55105da8d1a1eda323381529cc7 upstream.

Currently, when a sock is closed and the bpf_tcp_close() callback is
used we remove memory but do not free the skb. Call consume_skb() if
the skb is attached to the buffer.

Reported-by: syzbot+d464d2c20c717ef5a6a8@syzkaller.appspotmail.com
Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/sockmap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -471,7 +471,8 @@ static int free_sg(struct sock *sk, int
 	while (sg[i].length) {
 		free += sg[i].length;
 		sk_mem_uncharge(sk, sg[i].length);
-		put_page(sg_page(&sg[i]));
+		if (!md->skb)
+			put_page(sg_page(&sg[i]));
 		sg[i].length = 0;
 		sg[i].page_link = 0;
 		sg[i].offset = 0;
@@ -480,6 +481,8 @@ static int free_sg(struct sock *sk, int
 		if (i == MAX_SKB_FRAGS)
 			i = 0;
 	}
+	if (md->skb)
+		consume_skb(md->skb);
 
 	return free;
 }


