Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AEFC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA846206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XGRLCVo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfAKA0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:26:46 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59100 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAKA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:26:42 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1C92F24E0607;
        Thu, 10 Jan 2019 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547166402; bh=DVgWT4VOpi5ItAo8wxhZ9DfXiDw+m8gVPchbHy0ojuI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=XGRLCVo2XP8tQkWnaZQIZmEQVgpVkqn/Duw+Pi8ivbRQpZ0r0oZFFS8mKFKtld5U/
         j42v9RNlWg2TsIkvLteU7Hncr1BOYWa1KQdvttpfsOtWI2uVg1o4pe2BF1w19sp+OT
         aT4MQ7BHFq6F1sY8SOz2ZMlw/cIBsURPohz92YgHzUcEnbdGGt5VLNnz96Britwkr/
         s9ap5nwiAZY1pyftzTdIJ1kyXBpm9BcUaKt09EDMrilUQgL0GHep4l/rrnPRWm73mg
         7vBKSTwfVbnZ/vaqOvZcx5f6V8JaNr3JrUvM5yfuq/7EVXaYJe2fTdSHV9GnNgGyIz
         8FRViI6ZPLrJg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 931343436;
        Thu, 10 Jan 2019 16:26:41 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 16:26:41 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:42 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:43 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 1/3] coredump: Replace opencoded set_mask_bits()
Date:   Thu, 10 Jan 2019 16:26:25 -0800
Message-ID: <1547166387-19785-2-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
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

