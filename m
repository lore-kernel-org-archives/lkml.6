Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F04C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B8323C40
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B8323C40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032435AbeGAQoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:44:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032052AbeGAQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 92526ACD;
        Sun,  1 Jul 2018 16:43:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.17 161/220] um: Fix raw interface options
Date:   Sun,  1 Jul 2018 18:23:05 +0200
Message-Id: <20180701160915.001589949@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

commit 5ec9121195a4f1cecd0fa592636c5f81eb03dc8c upstream.

Raw interface initialization needs QDISC_BYPASS. Otherwise
it sees its own packets when transmitting.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/drivers/vector_kern.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -188,7 +188,7 @@ static int get_transport_options(struct
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
 		return (vec_rx | VECTOR_BPF);
 	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
-		return (vec_rx | vec_tx);
+		return (vec_rx | vec_tx | VECTOR_QDISC_BYPASS);
 	return (vec_rx | vec_tx);
 }
 
@@ -1241,9 +1241,8 @@ static int vector_net_open(struct net_de
 
 	if ((vp->options & VECTOR_QDISC_BYPASS) != 0) {
 		if (!uml_raw_enable_qdisc_bypass(vp->fds->rx_fd))
-			vp->options = vp->options | VECTOR_BPF;
+			vp->options |= VECTOR_BPF;
 	}
-
 	if ((vp->options & VECTOR_BPF) != 0)
 		vp->bpf = uml_vector_default_bpf(vp->fds->rx_fd, dev->dev_addr);
 


