Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083B7206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Fnkfcu5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083B7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeK2Krb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:31 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:45815 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeK2Krb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=NbDJS5KCUmlgmti0x7bPYn3Se3WmXYSYsFjXhyzWgQA=; b=Fnkfcu5EJzii
        0cjcpP+3Oo7c2OiduT/hWOs0f2HeyvB2D7/+FqKgs047CTmaGc4QUlyNOwhnlMz54ajWU4nWGDkDz
        vp73PjRa9pDuMqw9fTetLBPfVXE3VSfarcHH7qXSeYcLynv3j7QtXuJtjnL0uHgatpEn4x61y8W/u
        G3u+hysO+5rHZ6YdRt7fD4J0+UMLOxGLWYKJl3WqOPIuFesnDLQZ860Ku9uALY7YZlaB/OvG5co8A
        HOVUFOG/HZjo/RAf6epalIX1eBdFTsql6z5tSioqxZGv1gXmVTkbsSpM6+2Wv8qbMMjqcCYFMnRDf
        C7Jkv+8UBwBxNuo3Qry9VA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Ut-0001zB-Qk; Thu, 29 Nov 2018 00:44:00 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 4398FC11FB;
        Thu, 29 Nov 2018 00:43:57 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/27] timekeeping: Assign a name to tk_core.seq.dep_map
Date:   Wed, 28 Nov 2018 15:43:09 -0800
Message-Id: <20181128234325.110011-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.0077418294842)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ljhHrlBN2WZ2DP47jcb4B9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGcKt9+MHCUigiU7g
 43wm9HK3frzyd/ntZ+wCG7T3cbT4sXVhPBs4K8hVtp6La00Uv8ZB14E0iQtvqvjtp9rD8If9bcHJ
 zTYM7Gz36QU/LMAv7W/iATtz0rFEH2PjecTx1iTg127TqHZDxA/kZB41Rh8wUGmdr3B4qT9RiswA
 A6TjCkmYneWmOLktMt7B24Jcus2wWVbjHO/cpJpsYlvFhM+N0nsLdCG7LGfReC1C1uWeBldNoc4/
 ugpbufbubK+x4pGqVAT1vWFeEhEnVslbRXVRh+7MnWbw7fXOUdDwPDg2bN87qJveuvI4FkaTzox5
 7en0TkQuIdVjxFJSAPHvCxKJKuWBdR7YVGu3dD+xoi67r0TCUZsaG+mLAH7VoDC8TEHvm3Pq/TMV
 hLiLVSlbDnLxMg+tusI0bd26SWMjAgXw31/E3ahF5MMcDI7KdpjQKXV03l7WBaRxJ7yoJ3IKvCYv
 P92yJqFDUMWgYkYfhC80a8lAKYNtqEsHRfxQgIiuywCa/QYlJHXn0HHVtjhKEP24sffQX1o0gBXz
 k0Y91KPW6J1fhOzjF0b4LXcjJZ5lovU05zj51HaxHXGC/wjT3xNrSlHVtLHaZkFpoXAuc0NSfJC+
 wmFIviS1isD/Gy4dUilADpsrRqn5Jpuf+kRv1g8Te5rdilVCCfSu51hI99R4i3H9f7we29ciaD/8
 EjIFKfVMC/0z9VT6J51+EkUQd7rKATDDBZ7fFc0FDw0l2bg+RuQm3HCO5MWXKMmMA1ef4kNHk9CZ
 3+zCf2m2s0zlPaSj2HJLvdxF+Un5MPk5QOxnl9UvxdUuxhgy1UgE7lWmo7wKcfIpPo3vv82R1c8N
 Xqt6jvJsmaZpbKRZNsABnVcYdlUSxVR0EOyhVYwy6sZ0p9EyvDkN3AfUBddcu9g0UhyJvXzobDJy
 UVEv3v3xOoI2V0bkGRWsfttAG/pnMLcZFc2wWVbjHO/cpJpsYlvFhM9du1Tr+KAnEl6h2QN7FJBw
 oApFJJJ3+3GhjK7Gku3lzsf6aC/gK6YvCJx47zPlUt4=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes lockdep reports that refer to tk_core.seq more
informative.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2d110c948805..6c9493495538 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,7 +50,9 @@ enum timekeeping_adv_mode {
 static struct {
 	seqcount_t		seq;
 	struct timekeeper	timekeeper;
-} tk_core ____cacheline_aligned;
+} tk_core ____cacheline_aligned = {
+	.seq = SEQCNT_ZERO(tk_core.seq),
+};
 
 static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

