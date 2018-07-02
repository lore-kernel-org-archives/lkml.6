Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A96BC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD502546F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O6dnKFML";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O6dnKFML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD502546F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeGBBMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:12:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGBBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:12:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3D4260452; Mon,  2 Jul 2018 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530493921;
        bh=a5Ujte802Ceibov3ZIHbR41qUs3kOEw9yi450DcLXBc=;
        h=From:To:Cc:Subject:Date:From;
        b=O6dnKFMLlq1OWxwFMp2OyUTRE548o67hw7gm8z/Juhx0sDWrZ1FSOf3Dr4Moq6lPv
         xjUE+VqjVcKjpiznLzBnBK82iJneHU+skInLYxOq4lVZw7APxT2ohoz5PddN4zg5r3
         3Tjxrlb+Q9EkUenvaodXSGU3SUhQeaKrAC93m5ZY=
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CF6A6034E;
        Mon,  2 Jul 2018 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530493921;
        bh=a5Ujte802Ceibov3ZIHbR41qUs3kOEw9yi450DcLXBc=;
        h=From:To:Cc:Subject:Date:From;
        b=O6dnKFMLlq1OWxwFMp2OyUTRE548o67hw7gm8z/Juhx0sDWrZ1FSOf3Dr4Moq6lPv
         xjUE+VqjVcKjpiznLzBnBK82iJneHU+skInLYxOq4lVZw7APxT2ohoz5PddN4zg5r3
         3Tjxrlb+Q9EkUenvaodXSGU3SUhQeaKrAC93m5ZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CF6A6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     neilb@suse.com, tgraf@suug.ch, linux-arm-msm@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] lib: rhashtable: Correct self-assignment in rhashtable.c
Date:   Sun,  1 Jul 2018 18:11:46 -0700
Message-Id: <1530493906-19711-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file lib/rhashtable.c line 777, skip variable is assigned to
itself. The following error was observed:

lib/rhashtable.c:777:41: warning: explicitly assigning value of
variable of type 'int' to itself [-Wself-assign] error, forbidden
warning: rhashtable.c:777
This error was found when compiling with Clang 6.0. Change it to iter->skip.

Change-Id: I5abd1ce5ba76737a73bd6eca94b07b1bd5267523
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 lib/rhashtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b57..3109b2e 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -774,7 +774,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 				skip++;
 				if (list == iter->list) {
 					iter->p = p;
-					skip = skip;
+					iter->skip = skip;
 					goto found;
 				}
 			}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

