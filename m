Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51273C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2A6217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498110;
	bh=Pfqgf6qkYUj6MjWIH5UWOVX1JqVa+YcUE6i14hnlE80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nsM6Ij2NWAaXj6BbnAqPFDh+Wa44wLaAAGrMeq7jLbylidzLEKFZpASKd/hQ98YzS
	 ijUxb0DNwmRXrAJnH6QQX9BApHIKogYy3Okf8yrPg8quTJixyeVcdoBIR5x7mqcb1F
	 SK92eVeNVbmxGV7GMOXhwA5AuuxU+Tv4PMZNtL4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbfBRNzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbfBRNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C301217D9;
        Mon, 18 Feb 2019 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498104;
        bh=Pfqgf6qkYUj6MjWIH5UWOVX1JqVa+YcUE6i14hnlE80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTMcg73xp7sD4g9jYp1fzf4twqTaukSAY30gWpJD20CWQbFuzZlo9aAqR0CaKc6yy
         /rrG6qi0I4osKkQKYjs1e+MinBIhClep4QI15zQoR3IBYpXj8BkB6aAmqS7xWylFG5
         ZN0OFzQ+ufJQkgXJZf4LTsGj11sOKttG40au75pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/62] ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
Date:   Mon, 18 Feb 2019 14:43:12 +0100
Message-Id: <20190218133506.328269515@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 73839798af7ebc6c8d0c9271ebbbc148700e521f upstream.

When setting a dummy iwmmxt context, create a local instance and
use __copy_to_user both cases whether iwmmxt is being used or not.
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/signal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 1dc1f39825b6..b12499cc3582 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -76,8 +76,6 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		kframe->magic = IWMMXT_MAGIC;
 		kframe->size = IWMMXT_STORAGE_SIZE;
 		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
-
-		err = __copy_to_user(frame, kframe, sizeof(*frame));
 	} else {
 		/*
 		 * For bug-compatibility with older kernels, some space
@@ -85,10 +83,14 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		 * Set the magic and size appropriately so that properly
 		 * written userspace can skip it reliably:
 		 */
-		__put_user_error(DUMMY_MAGIC, &frame->magic, err);
-		__put_user_error(IWMMXT_STORAGE_SIZE, &frame->size, err);
+		*kframe = (struct iwmmxt_sigframe) {
+			.magic = DUMMY_MAGIC,
+			.size  = IWMMXT_STORAGE_SIZE,
+		};
 	}
 
+	err = __copy_to_user(frame, kframe, sizeof(*kframe));
+
 	return err;
 }
 
-- 
2.19.1



