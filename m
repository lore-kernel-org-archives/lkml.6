Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23FEECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733820856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="feVPXSXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJYXkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:19 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:51191 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJYXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=fm7+i4hVDplYlFm3ZwCsreipigqiKCzyh2Tadn1JudQ=; b=feVPXSXLqqoU
        1smFvqyHV4kENESG5kTGs/8QVuosI0p3jUJWyBHfQI3dt9CeReC25HPYbSPL4P1Xnyn9LLxnWPwkL
        nDVwq3RYtJmPJrvVnn7i7DWM96wd/S5mKOthbhXH4dMjnWFNUM9HF2R2hjsoBvJ1QsAFl66zRcaWO
        kHw/KytEYnmZLJEN/126PkBixa7pKET2vLQR0US6xLc1oTD6msN/hwUqkRLQc+9h0RAMZEl3wjI22
        tC2r5xGieiMM8lxVr9zwkFQYyuc6/E4vp4OqbM4uivthiGWN74sknZ1EnQpn+smWo0b+qNvFgDQl/
        eY51N4OgIsJslqqr2bnJVw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gFhDn-000GQ4-3k; Thu, 25 Oct 2018 17:06:56 +0200
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 74ECAC0750;
        Thu, 25 Oct 2018 17:06:34 +0200 (CEST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, tytso@mit.edu,
        bvanassche@acm.org
Subject: [PATCH 2/3] kernel/workqueue: Surround work execution with shared lock annotations
Date:   Thu, 25 Oct 2018 08:05:39 -0700
Message-Id: <20181025150540.259281-3-bvanassche@acm.org>
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
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vexjD+qHE4eiwKuIM+Widd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ8+YO8vChGFh3RuBr6W5W4OxXLKJYlhMSlvFrRpI1afX1e
 LdXSQEA2A8Mi+qZBNAJeQM+giwlWxLd3u9oewtfxHkDLQXsP0l4gM901I8VRelOcvqL7erI7cmyP
 F7rNKoQ6nIk9pDZAy5+Bh7H1WlayS5/54zeXko+dun95C2GNU5Zgdw/TrNerJc6iNElLjOR9Z0PH
 iUJqLuzqGOBBT/JUBMmyNbDn7R5kilAhwr3KtFkEjgy2lIalT1bgV0G1B6wR6UEXs2CpqzV8tKL4
 SxeIZFs3hxL2bckpClidT6MQ5u75lAaleymDhM6q/bf6ylvMne8kEFi9whdly91uPt+NjZ/2BflP
 GJGaubsXCX08RTS5uosuJIDwx+20ECcNkg/IQ6hdCufMS9/BCap8vQGHPoGLQmyHoPQ6TB1wLqq5
 Qkv8gSmPI3hcWIP6I/UqgklFXXqpVcVFhDpgnnGd9TvwpduFUH54xozIXYC/AO4ruQQZSCdFgRT7
 uB3pznGUiPdhD/iWD0V++qD0gbQQTy2MSHRP7JsY9SIFlGCnk976CRbAiblZVZAoQGrzL+lZC3bY
 5Qx4fJOk03R5fJtf/Dv/gSdxjDi1ltP+wptveb2Ijci0u19DQjpIcLYmJ1eNF7Ecs8qMuhzWs9XG
 7Iiuz5DKzyOnSUXAPUaedexohugdGgGGPcOEvDrzcvu1bC7a0IB3MEaSi/a2UpaZXx577r2VX5L+
 J71s/JQPh4CpIirAWU4JGuUMSPEM4jSvu0DxlABITZexxilFc9uhI53Z4n/X50oTLts/mAi3bdTt
 +kCc014dWJl0kwfXlmvU2bsvJrtx8fXHyj1p+RqJJRyLN6C+DGPF2F6m9SGDf0iNMQCyiZ6QZDvV
 AcJRgqDug2GSJBdRZgzstIAg6rIwnyMY+7rV9R/2gMGq0KWAzmMf+ibVDvxqiYOBPyjSuNX12Foj
 Ct6b+3PptLpbDCN56+pk/nrDlJMRPkiuApKqkLmPwA7QezIzJvw9qxD5zQLggp7fQfdZbzftsOiK
 1rBamiUlczHh9dLX6qBpW3U5Ey2lggFy2qdXG55oeqRZoYKir3ci7UmvMyduSR5H9stXx9/Mf6KV
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surround execution of work with a shared lockdep annotation because multiple
work items associated with a work queue may execute concurrently.

Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6755ef21a679..fc9129d5909e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2125,8 +2125,8 @@ __acquires(&pool->lock)
 
 	spin_unlock_irq(&pool->lock);
 
-	lock_map_acquire(&pwq->wq->lockdep_map);
-	lock_map_acquire(&lockdep_map);
+	lock_acquire_shared(&pwq->wq->lockdep_map, 0, 0, NULL, _THIS_IP_);
+	lock_acquire_shared(&lockdep_map, 0, 0, NULL, _THIS_IP_);
 	/*
 	 * Strictly speaking we should mark the invariant state without holding
 	 * any locks, that is, before these two lock_map_acquire()'s.
@@ -2156,8 +2156,8 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work);
-	lock_map_release(&lockdep_map);
-	lock_map_release(&pwq->wq->lockdep_map);
+	lock_release(&lockdep_map, 0, _THIS_IP_);
+	lock_release(&pwq->wq->lockdep_map, 0, _THIS_IP_);
 
 	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
 		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
@@ -2652,8 +2652,8 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
+	lock_acquire_exclusive(&wq->lockdep_map, 0, 0, NULL, _THIS_IP_);
+	lock_release(&wq->lockdep_map, 0, _THIS_IP_);
 
 	mutex_lock(&wq->mutex);
 
@@ -2891,8 +2891,9 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	 */
 	if (!from_cancel &&
 	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
-		lock_map_acquire(&pwq->wq->lockdep_map);
-		lock_map_release(&pwq->wq->lockdep_map);
+		lock_acquire_exclusive(&pwq->wq->lockdep_map, 0, 0, NULL,
+				       _THIS_IP_);
+		lock_release(&pwq->wq->lockdep_map, 0, _THIS_IP_);
 	}
 
 	return true;
-- 
2.19.1.568.g152ad8e336-goog

