Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B990C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527882084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVPbXgNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527882084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeLEJmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbeLEJmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:42:04 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC5320879;
        Wed,  5 Dec 2018 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002924;
        bh=b0IHSgUSy50pbIqeRaEhsU5t430F0nvR2rNARyjafG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVPbXgNW/oaJ47OU8J5WjzY4xxRTIehzudlgAIwf0RwFsOD3nshvkfTAZRxM3xAan
         HIyjeg/1g119KENRZilq5ZnniXrkcapI4yCQjWPKKC+hRlgLeZrdMP6OhG2C3Wm7aS
         5+8pP/DL9y1lsDQ7DZh5i7TjuMv3jyXpxk5DCcns=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 114/123] unifdef: use memcpy instead of strncpy
Date:   Wed,  5 Dec 2018 04:35:46 -0500
Message-Id: <20181205093555.5386-114-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 38c7b224ce22c25fed04007839edf974bd13439d ]

New versions of gcc reasonably warn about the odd pattern of

	strncpy(p, q, strlen(q));

which really doesn't make sense: the strncpy() ends up being just a slow
and odd way to write memcpy() in this case.

There was a comment about _why_ the code used strncpy - to avoid the
terminating NUL byte, but memcpy does the same and avoids the warning.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/unifdef.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index 7493c0ee51cc..db00e3e30a59 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -395,7 +395,7 @@ usage(void)
  * When we have processed a group that starts off with a known-false
  * #if/#elif sequence (which has therefore been deleted) followed by a
  * #elif that we don't understand and therefore must keep, we edit the
- * latter into a #if to keep the nesting correct. We use strncpy() to
+ * latter into a #if to keep the nesting correct. We use memcpy() to
  * overwrite the 4 byte token "elif" with "if  " without a '\0' byte.
  *
  * When we find a true #elif in a group, the following block will
@@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ignoreon(); }
 static void Itrue (void) { Ftrue();  ignoreon(); }
 static void Ifalse(void) { Ffalse(); ignoreon(); }
 /* modify this line */
-static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
+static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }
 static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
 static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
 static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }
-- 
2.17.1

