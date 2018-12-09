Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF5220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeLIW3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:29:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34536 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbeLIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0002id-1U; Sun, 09 Dec 2018 21:55:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72X-0003CZ-Tc; Sun, 09 Dec 2018 21:55:05 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.775411301@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 006/328] s390/qdio: reset old sbal_state flags
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/qdio.h | 1 -
 drivers/s390/cio/qdio_main.c | 5 ++---
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
 

