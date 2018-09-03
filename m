Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32478C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB90C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeICVVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:21:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeICVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:21:25 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D691ACFB;
        Mon,  3 Sep 2018 17:00:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 46/80] s390/kvm: fix deadlock when killed by oom
Date:   Mon,  3 Sep 2018 18:49:24 +0200
Message-Id: <20180903164935.996392471@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

commit 306d6c49ac9ded11114cb53b0925da52f2c2ada1 upstream.

When the oom killer kills a userspace process in the page fault handler
while in guest context, the fault handler fails to release the mm_sem
if the FAULT_FLAG_RETRY_NOWAIT option is set. This leads to a deadlock
when tearing down the mm when the process terminates. This bug can only
happen when pfault is enabled, so only KVM clients are affected.

The problem arises in the rare cases in which handle_mm_fault does not
release the mm_sem. This patch fixes the issue by manually releasing
the mm_sem when needed.

Fixes: 24eb3a824c4f3 ("KVM: s390: Add FAULT_FLAG_RETRY_NOWAIT for guest fault")
Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/mm/fault.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -459,6 +459,8 @@ retry:
 	/* No reason to continue if interrupted by SIGKILL. */
 	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
 		fault = VM_FAULT_SIGNAL;
+		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+			goto out_up;
 		goto out;
 	}
 	if (unlikely(fault & VM_FAULT_ERROR))


