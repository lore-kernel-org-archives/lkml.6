Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904EDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D04820869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D04820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeICVNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeICVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18857CF5;
        Mon,  3 Sep 2018 16:52:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3.18 50/56] s390/qdio: reset old sbal_state flags
Date:   Mon,  3 Sep 2018 18:49:40 +0200
Message-Id: <20180903164926.564147789@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit 64e03ff72623b8c2ea89ca3cb660094e019ed4ae upstream.

When allocating a new AOB fails, handle_outbound() is still capable of
transmitting the selected buffer (just without async completion).

But if a previous transfer on this queue slot used async completion, its
sbal_state flags field is still set to QDIO_OUTBUF_STATE_FLAG_PENDING.
So when the upper layer driver sees this stale flag, it expects an async
completion that never happens.

Fix this by unconditionally clearing the flags field.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/qdio.h |    1 -
 drivers/s390/cio/qdio_main.c |    5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -271,7 +271,6 @@ struct qdio_outbuf_state {
 	void *user;
 };
 
-#define QDIO_OUTBUF_STATE_FLAG_NONE	0x00
 #define QDIO_OUTBUF_STATE_FLAG_PENDING	0x01
 
 #define CHSC_AC1_INITIATE_INPUTQ	0x80
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -640,21 +640,20 @@ static inline unsigned long qdio_aob_for
 	unsigned long phys_aob = 0;
 
 	if (!q->use_cq)
-		goto out;
+		return 0;
 
 	if (!q->aobs[bufnr]) {
 		struct qaob *aob = qdio_allocate_aob();
 		q->aobs[bufnr] = aob;
 	}
 	if (q->aobs[bufnr]) {
-		q->sbal_state[bufnr].flags = QDIO_OUTBUF_STATE_FLAG_NONE;
 		q->sbal_state[bufnr].aob = q->aobs[bufnr];
 		q->aobs[bufnr]->user1 = (u64) q->sbal_state[bufnr].user;
 		phys_aob = virt_to_phys(q->aobs[bufnr]);
 		WARN_ON_ONCE(phys_aob & 0xFF);
 	}
 
-out:
+	q->sbal_state[bufnr].flags = 0;
 	return phys_aob;
 }
 


