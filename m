Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D055ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506C72084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ml0R8dkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506C72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJYXkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:14 -0400
Received: from com-out001.mailprotect.be ([83.217.72.83]:40925 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJYXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=3yzremdG7KlPI+he8Y9AG7unAFm4oqDX1d1Y7PNdTII=; b=ml0R8dkDPaEl
        tXupkcd6gEZSuueX7MPx+sQYWV1i+rqehvSns00L2TZqVNgMqQ5KXyvz0Eww+S3azBVfYLfTHMkre
        o5R8LFHK3i8XWd12R83TqdT1vPZ7AvEBZfvYqr9tdF3RAGDrlee+xWWQ7F/Ns/IxiIggLAPgw2IgT
        SThgzcPTnJXr+ZwIZBvBpUiT27gnGq5XdxhD5ye/UFXTvW8PxLCkXwaZby8iZvvr2RhzevuHqIXIm
        YY/I+Z61UPU41toa2FuleBQl9J1bVAkZkWefegc2FW+qjYtVjQdKkCtE3h697/RnEZg67qzfXL8dj
        4SX5ZprTQy67g7TKKJPJjA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gFhDk-0005p8-II; Thu, 25 Oct 2018 17:06:49 +0200
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id BDDA5C0515;
        Thu, 25 Oct 2018 17:06:32 +0200 (CEST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, tytso@mit.edu,
        bvanassche@acm.org
Subject: [PATCH 1/3] kernel/workqueue: Remove lockdep annotation from __flush_work()
Date:   Thu, 25 Oct 2018 08:05:38 -0700
Message-Id: <20181025150540.259281-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025150540.259281-1-bvanassche@acm.org>
References: <20181025150540.259281-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5pPEBrJLWXleZ86P3/N6enZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ8+YO8vChGFh3RuBr6W5W4OxXLKJYlhMSlvFrRpI1afX1e
 LdXSQEA2A8Mi+qZBNAJeQM+giwlWxLd3u9oewtfxHkDLQXsP0l4gM901I8VRelOcvqL7erI7cmyP
 F7rNKoQ6nIk9pDZAy5+Bh7H1WlayS5/54zeXko+dun95C2GNU5Zgdw/TrNerJc6iNElLjOR1Atod
 vd2FGqSV/lWQkgIDBMmyNbDn7R5kilAhwr3KtFkEjgy2lIalT1bgV0G1B6wR6UEXs2CpqzV8tKL4
 SxeI7sn//RcLEIwmfxtejjVQPe75lAaleymDhM6q/bf6ylvMne8kEFi9whdly91uPt+NjZ/2BflP
 GJGaubsXCX08RTS5uosuJIDwx+20ECcNkg/IQ6hdCufMS9/BCap8vQGHPoGLQmyHoPQ6TB1wLqq5
 Qkv8gSmPI3hcWIP6I/UqgklFXXqpVcVFhDpgnnGd9TvwpduFUH54xozIXYC/AO4ruQQZSCdFgRT7
 uB3pznGUiPdhD/iWD0V++qD0gbQQTy2MSHRP7JsY9SIFlGCnk976CRbAiblZVZAoQGrzL+lZC3bY
 5Qx4fJOk03R5fJtf/Dv/gSdxjDi1ltP+wptveb2Ijci0u19DQjpIcLYmJ1eNF7Hj7YQfAz1XFm6U
 HzM/nSXDLT9tKhKScZUlyc1itWoqbggB99dd+Irj5q+evX1sYw13MEaSi/a2UpaZXx577r2VX5L+
 J71s/JQPh4CpIirAWU4JGuUMSPEM4jSvu0DxlABITZexxilFc9uhI53Z4n/X50oTLts/mAi3bdTt
 +kCc014dWJl0kwfXlmvU2bsvJrsFPR3Gzs71Wpk9+y1Dmbcg/JLrNZOfRyh3keK+TZYqwZ6QZDvV
 AcJRgqDug2GSJBdRZgzstIAg6rIwnyMY+7rV9R/2gMGq0KWAzmMf+ibVDvxqiYOBPyjSuNX12Foj
 Ct6b+3PptLpbDCN56+pk/nrDlJMRPkiuApKqkLmPwA7QezIzJvw9qxD5zQLggp7fQfdZbzftsOiK
 1rBamiUlczHh9dLX6qBpW3U5Ey2lggFy2qdXG55oeqRZoYKir3ci7UmvMyduSR5H9stXx9/Mf6KV
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented in a comment in start_flush_work(), calling flush_work()
from a multi-threaded workqueue is safe if that workqueue is not
equipped with a rescuer. Avoid that flush_work() calls from inside a
work item executing on such a queue trigger a lockdep complaint. Remove
the lockdep annotation from __flush_work() because start_flush_work()
already has such an annotation.

Fixes: 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0280deac392e..6755ef21a679 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2908,11 +2908,6 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
-	if (!from_cancel) {
-		lock_map_acquire(&work->lockdep_map);
-		lock_map_release(&work->lockdep_map);
-	}
-
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
-- 
2.19.1.568.g152ad8e336-goog

