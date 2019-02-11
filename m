Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E290C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531720844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895557;
	bh=xuuzD71YPxiHxw7eQoS1mHaU3ehuv8O/LOwqZGM97+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYaHxYozc3iFmyWGz/AQQJ+pquwmOSOgHDRmCvk7bOqxxs6/yVfGZaWlpX9TCCnFS
	 X7/gyXzjRDlQ1OTx8GS8vMxFlNDQIUh5TQd+Fe2cAkCU0m9A47hib7QlLQaZTo7V5B
	 tSg13+9j9zGNrV2SmHOmyrE0JAY3CkczvfqixEjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfBKOcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfBKOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8842F20675;
        Mon, 11 Feb 2019 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895549;
        bh=xuuzD71YPxiHxw7eQoS1mHaU3ehuv8O/LOwqZGM97+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwr1N55qG8J9u91QwSIDeJ/cCnMciVJyv5w7qhns/sSh4QvcmY3/NSzDBKbldfrbf
         jAgLevZQMSK0JeOLfPJFi6Azd27Z6UKH+lG/H0ut/uVuHm/QlSyW8xGeM93Su7jTT0
         MaiSAvEVkT6XXrrxnxW+3SJtLf4rO84mHsK14e1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 240/352] bpf: sk_msg, zap ingress queue on psock down
Date:   Mon, 11 Feb 2019 15:17:47 +0100
Message-Id: <20190211141902.437732082@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit a136678c0bdbb650daff5df5eec1dab960e074a7 ]

In addition to releasing any cork'ed data on a psock when the psock
is removed we should also release any skb's in the ingress work queue.
Otherwise the skb's eventually get free'd but late in the tear
down process so we see the WARNING due to non-zero sk_forward_alloc.

  void sk_stream_kill_queues(struct sock *sk)
  {
	...
	WARN_ON(sk->sk_forward_alloc);
	...
  }

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b7dbb3c976cd..fc7d59f1c57c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -575,6 +575,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 {
 	rcu_assign_sk_user_data(sk, NULL);
 	sk_psock_cork_free(psock);
+	sk_psock_zap_ingress(psock);
 	sk_psock_restore_proto(sk, psock);
 
 	write_lock_bh(&sk->sk_callback_lock);
-- 
2.19.1



