Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97570C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBAB21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBAB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbeIXSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbeIXSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AC381018;
        Mon, 24 Sep 2018 12:32:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 082/235] s390/qeth: fix race in used-buffer accounting
Date:   Mon, 24 Sep 2018 13:51:08 +0200
Message-Id: <20180924113113.242696894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit a702349a4099cd5a7bab0904689d8e0bf8dcd622 ]

By updating q->used_buffers only _after_ do_QDIO() has completed, there
is a potential race against the buffer's TX completion. In the unlikely
case that the TX completion path wins, qeth_qdio_output_handler() would
decrement the counter before qeth_flush_buffers() even incremented it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3530,13 +3530,14 @@ static void qeth_flush_buffers(struct qe
 	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |= QDIO_FLAG_PCI_OUT;
+	atomic_add(count, &queue->used_buffers);
+
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
 	if (queue->card->options.performance_stats)
 		queue->card->perf_stats.outbound_do_qdio_time +=
 			qeth_get_micros() -
 			queue->card->perf_stats.outbound_do_qdio_start_time;
-	atomic_add(count, &queue->used_buffers);
 	if (rc) {
 		queue->card->stats.tx_errors += count;
 		/* ignore temporary SIGA errors without busy condition */


