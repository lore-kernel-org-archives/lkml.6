Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A64B2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A64B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeJBUNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbeJBUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:49 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D39DC2B;
        Tue,  2 Oct 2018 13:30:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 184/228] tls: possible hang when do_tcp_sendpages hits sndbuf is full case
Date:   Tue,  2 Oct 2018 06:24:41 -0700
Message-Id: <20181002132510.784554266@linuxfoundation.org>
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

[ Upstream commit 67db7cd249e71f64346f481b629724376d063e08 ]

Currently, the lower protocols sk_write_space handler is not called if
TLS is sending a scatterlist via  tls_push_sg. However, normally
tls_push_sg calls do_tcp_sendpage, which may be under memory pressure,
that in turn may trigger a wait via sk_wait_event. Typically, this
happens when the in-flight bytes exceed the sdnbuf size. In the normal
case when enough ACKs are received sk_write_space() will be called and
the sk_wait_event will be woken up allowing it to send more data
and/or return to the user.

But, in the TLS case because the sk_write_space() handler does not
wake up the events the above send will wait until the sndtimeo is
exceeded. By default this is MAX_SCHEDULE_TIMEOUT so it look like a
hang to the user (especially this impatient user). To fix this pass
the sk_write_space event to the lower layers sk_write_space event
which in the TCP case will wake any pending events.

I observed the above while integrating sockmap and ktls. It
initially appeared as test_sockmap (modified to use ktls) occasionally
hanging. To reliably reproduce this reduce the sndbuf size and stress
the tls layer by sending many 1B sends. This results in every byte
needing a header and each byte individually being sent to the crypto
layer.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -222,9 +222,14 @@ static void tls_write_space(struct sock
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
-	/* We are already sending pages, ignore notification */
-	if (ctx->in_tcp_sendpages)
+	/* If in_tcp_sendpages call lower protocol write space handler
+	 * to ensure we wake up any waiting operations there. For example
+	 * if do_tcp_sendpages where to call sk_wait_event.
+	 */
+	if (ctx->in_tcp_sendpages) {
+		ctx->sk_write_space(sk);
 		return;
+	}
 
 	if (!sk->sk_write_pending && tls_is_pending_closed_record(ctx)) {
 		gfp_t sk_allocation = sk->sk_allocation;


