Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC207C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F4F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dZuKBLN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAWUgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:36:47 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:44886 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfAWUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:36:46 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 4E1E324E09A5;
        Wed, 23 Jan 2019 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548275806; bh=kJQpOk9ZK86cD+f4lSJLjtMX3cfMvrQBXd+6efrgIP4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dZuKBLN4fosMTZqfsal0ZyRo/wn5iUM2k2qZFxow0NmEKflFzF5TFyfm2LdqocROm
         bDMSfhbtHpZFSJCWhxE2dRYwiF6rKyN9FMzlCcQ1LGeMHIHi5NBINqc8G3EOvnxKRi
         6JS+sR1bo9lYJySXOLo02kzhlEifaj/depZm9QfYIF71DF1DYwws5fFV0V9n5wRxki
         vLPwh5q0FlcQiLAe1ZWQkokaNmnYAapoesdycqhKWu877Z6m9TejcXYHB/kY7bnwBV
         iC1o7/eWs7mEKO0RIFUpdXiMbPB2cYWlcnpegJRjYuqMe6XyYvqpr9E8TNHpwZnbGv
         oTMiXHfhObT3A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EBC3AA0091;
        Wed, 23 Jan 2019 20:36:45 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 12:33:20 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:21 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:19 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 1/3] coredump: Replace opencoded set_mask_bits()
Date:   Wed, 23 Jan 2019 12:33:02 -0800
Message-ID: <1548275584-18096-2-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
References: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/g/20150807115710.GA16897@redhat.com
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 fs/exec.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fb72d36f7823..df7f05362283 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1944,15 +1944,10 @@ EXPORT_SYMBOL(set_binfmt);
  */
 void set_dumpable(struct mm_struct *mm, int value)
 {
-	unsigned long old, new;
-
 	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
 		return;
 
-	do {
-		old = READ_ONCE(mm->flags);
-		new = (old & ~MMF_DUMPABLE_MASK) | value;
-	} while (cmpxchg(&mm->flags, old, new) != old);
+	set_mask_bits(&mm->flags, MMF_DUMPABLE_MASK, value);
 }
 
 SYSCALL_DEFINE3(execve,
-- 
2.7.4

