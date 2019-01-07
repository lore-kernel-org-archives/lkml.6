Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A21C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52F22089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864624;
	bh=L5RodkvpLjH/zO8+iHr8lS2OHyECnoxBxqNwpiPPODA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=saHblErm1eD4L9xU3nl7txUlmb6ICemL50Jf8TTXS8aN++DaMxwzFEvL/OL6OzjT2
	 EP1CSt8Kbkd7qkTPakROlA1eXScNL+k/J5cj+DbEyP8tsc/GaqDjm9ykjAkhvcVKuS
	 zDe6/PAtoAWH2tPwwDuaoZf7s29wrlYUTgff/t2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAGMhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDFC21736;
        Mon,  7 Jan 2019 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864621;
        bh=L5RodkvpLjH/zO8+iHr8lS2OHyECnoxBxqNwpiPPODA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a86kehcKzHiwRjv5IKj+lyMiFxTAkXsUyc8dd3zVaSMjyWtO9rPwEJMhFyOCsbirA
         85pS7dZjHTrMqr1ulldnGMPiA0HFzieJqdANOsdomtLRgWdy99fXJ8pTQU01UwIYUE
         JIDK/DnZ4JvGlzlbKhaQXXOjyyI/FVS/scmDvgbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 017/145] ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()
Date:   Mon,  7 Jan 2019 13:30:54 +0100
Message-Id: <20190107104439.576609858@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit aff6db454599d62191aabc208930e891748e4322 ]

__ptr_ring_swap_queue() tries to move pointers from the old
ring to the new one, but it forgets to check if ->producer
is beyond the new size at the end of the operation. This leads
to an out-of-bound access in __ptr_ring_produce() as reported
by syzbot.

Reported-by: syzbot+8993c0fa96d57c399735@syzkaller.appspotmail.com
Fixes: 5d49de532002 ("ptr_ring: resize support")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ptr_ring.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -573,6 +573,8 @@ static inline void **__ptr_ring_swap_que
 		else if (destroy)
 			destroy(ptr);
 
+	if (producer >= size)
+		producer = 0;
 	__ptr_ring_set_size(r, size);
 	r->producer = producer;
 	r->consumer_head = 0;


