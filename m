Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC216C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571DB20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VzJpwUop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571DB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeJKHDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:03:16 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42434 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:03:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E05F211D0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BVGOWsmjF4Nq for <linux-kernel@vger.kernel.org>;
        Wed, 10 Oct 2018 18:38:48 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 9CAC111EB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 18:38:41 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id f18so7376545itk.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/AvVb+RxbRgLzIPudSCQtCVRU6mEOU+6uQofFgWjkSU=;
        b=VzJpwUopMAHuywSkKEliHnTn6MS0aSRbtDPJZTixADF2TBAHm65VjSETQmLiB2aC7c
         eWa3lZt/iIs3zO6hAm6YpObU4bQ9MyrCnmOP+qcg0SZGEMRK6lq5lv5WEIPu2DprqwDi
         EVeeGAiNLkYe0Armz0JBXQzi018Dy5JqKl42mu5WfUm25Z1VH1EEVnHlfBbFJSAzcEEq
         pwBkfloVwaL03QImRe+xwsmW/8RYYG1d6cBiROES8/XJOf0CNEwaDltdducIAnXBIuh5
         gszErwRhECRIjydpoR9ZrgCd1pUp7zLPqeQNsmmIQSmcEQDP6FdQJLCPE8aj+10aA2gQ
         XumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/AvVb+RxbRgLzIPudSCQtCVRU6mEOU+6uQofFgWjkSU=;
        b=c2s6tg7sYrlCIvI1fWH+cSnLE8Qp4jwt4T91/2uRlI7IzLJYzmUghvbqSo32IQ+cpB
         ZnfW5drpW/ceKmEFHESbl69YNvNZ/tbUQ+3v1cYzqJJAG3TtzbZiJo0sEVfX1ykqoQFu
         uGaw0P2zTCbswa5Jg1pMcywXIdQs9l6ZK8n9NPeYjcWvY4EM7bci4+ZJNPaXE5EoL58v
         +IMzHNbNgU1fzV8tzVrAOI4CqvnfED+jVMw5/jBZHg9+pPyFu0OIHYWutddhvdsta+NB
         JLiZId8TLxlQiT4eSryb6EwlioDH1OJ08X7EodXTqb7BWewzFLD9UkF5Axe09z4lfFqe
         4l0Q==
X-Gm-Message-State: ABuFfoinaatD+1gmoTcefHWmhlUMQu1cYBvdolTQ9y1ZLG79StU7V1Gc
        EdV91Yu57Fr5TBkxaXfIX+NLYp9vsNsYk7NAuyR7bbUTQuRQDmsMFx+4j1sU3T9jIOeVCTeWFHQ
        QcswbAPGNkexX3TheJ2Zg9T49ftEY
X-Received: by 2002:a24:da42:: with SMTP id z63-v6mr2480365itg.111.1539214721282;
        Wed, 10 Oct 2018 16:38:41 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62KT5utGm50JCYzQPVwSwMkXJFRy11Mp+ygKeZry2Cohq9JJQbvEiWolYSiFpbxICNZwozyfw==
X-Received: by 2002:a24:da42:: with SMTP id z63-v6mr2480355itg.111.1539214721106;
        Wed, 10 Oct 2018 16:38:41 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id z195-v6sm17272310iof.71.2018.10.10.16.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 16:38:40 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] misc: mic: fix a DMA pool free failure
Date:   Wed, 10 Oct 2018 18:38:28 -0500
Message-Id: <1539214709-12391-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _scif_prog_signal(), the boolean variable 'x100' is used to indicate
whether the MIC Coprocessor is X100. If 'x100' is true, the status
descriptor will be used to write the value to the destination. Otherwise, a
DMA pool will be allocated for this purpose. Specifically, if the DMA pool
is allocated successfully, two memory addresses will be returned. One is
for the CPU and the other is for the device to access the DMA pool. The
former is stored to the variable 'status' and the latter is stored to the
variable 'src'. After the allocation, the address in 'src' is saved to
'status->src_dma_addr', which is actually in the DMA pool, and 'src' is
then modified.

Later on, if an error occurs, the execution flow will transfer to the label
'dma_fail', which will check 'x100' and free up the allocated DMA pool if
'x100' is false. The point here is that 'status->src_dma_addr' is used for
freeing up the DMA pool. As mentioned before, 'status->src_dma_addr' is in
the DMA pool. And thus, the device is able to modify this data. This can
potentially cause failures when freeing up the DMA pool because of the
modified device address.

This patch avoids the above issue by using the variable 'src' (with
necessary calculation) to free up the DMA pool.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/misc/mic/scif/scif_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
index cac3bcc..7bb929f 100644
--- a/drivers/misc/mic/scif/scif_fence.c
+++ b/drivers/misc/mic/scif/scif_fence.c
@@ -272,7 +272,7 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 dma_fail:
 	if (!x100)
 		dma_pool_free(ep->remote_dev->signal_pool, status,
-			      status->src_dma_addr);
+			      src - offsetof(struct scif_status, val));
 alloc_fail:
 	return err;
 }
-- 
2.7.4

