Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5132DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF532064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF532064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbeJBUog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:44:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbeJBUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:50 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3EFBCC3F;
        Tue,  2 Oct 2018 13:30:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 185/228] bpf: sockmap: write_space events need to be passed to TCP handler
Date:   Tue,  2 Oct 2018 06:24:42 -0700
Message-Id: <20181002132510.823294744@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 9b2e0388bec8ec5427403e23faff3b58dd1c3200 ]

When sockmap code is using the stream parser it also handles the write
space events in order to handle the case where (a) verdict redirects
skb to another socket and (b) the sockmap then sends the skb but due
to memory constraints (or other EAGAIN errors) needs to do a retry.

But the initial code missed a third case where the
skb_send_sock_locked() triggers an sk_wait_event(). A typically case
would be when sndbuf size is exceeded. If this happens because we
do not pass the write_space event to the lower layers we never wake
up the event and it will wait for sndtimeo. Which as noted in ktls
fix may be rather large and look like a hang to the user.

To reproduce the best test is to reduce the sndbuf size and send
1B data chunks to stress the memory handling. To fix this pass the
event from the upper layer to the lower layer.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1430,12 +1430,15 @@ out:
 static void smap_write_space(struct sock *sk)
 {
 	struct smap_psock *psock;
+	void (*write_space)(struct sock *sk);
 
 	rcu_read_lock();
 	psock = smap_psock_sk(sk);
 	if (likely(psock && test_bit(SMAP_TX_RUNNING, &psock->state)))
 		schedule_work(&psock->tx_work);
+	write_space = psock->save_write_space;
 	rcu_read_unlock();
+	write_space(sk);
 }
 
 static void smap_stop_sock(struct smap_psock *psock, struct sock *sk)


