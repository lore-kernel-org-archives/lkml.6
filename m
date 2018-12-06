Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91325C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591EB20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108428;
	bh=PQ6GjO7wAKla4anQLBpStt7ns6jj/wLVMh1EyxFrsz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jlOvPYtdgyLOxSZfYbh4Eqiwn6HvOOpUJaR4Js6MTC0XU6FspKOLRKEW0egG1BsCI
	 9TnCwo9RZ27hPTpaXJsLplAx0O3RhbCmjDyz7KQlKy6Db/xQQ5yrIwBSL7zrmvXgNB
	 cb7ylWPe/FkZuR2LVl3YDf9/gmW+Ht4U8/zhuw9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591EB20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLFPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbeLFOkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525B120661;
        Thu,  6 Dec 2018 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107246;
        bh=PQ6GjO7wAKla4anQLBpStt7ns6jj/wLVMh1EyxFrsz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7E/sbCtci1WrGKy0II4OV0y0WVxlweyYXz5oBA+XaYda5cXay3ygQsPQ6R3WCoyZ
         bbiVu+1qoJpLtRZZxFTE8bc8tR8yxi0v2Ky1nTzx7smA7L6G6KvfAxeIWYFoAFLLMD
         Pv9XgLeLTHKFYWmMN7e4rUmaDauiVRl1Uvcdb2Cw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 03/41] unifdef: use memcpy instead of strncpy
Date:   Thu,  6 Dec 2018 15:38:43 +0100
Message-Id: <20181206142950.018078943@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 38c7b224ce22c25fed04007839edf974bd13439d upstream.

New versions of gcc reasonably warn about the odd pattern of

	strncpy(p, q, strlen(q));

which really doesn't make sense: the strncpy() ends up being just a slow
and odd way to write memcpy() in this case.

There was a comment about _why_ the code used strncpy - to avoid the
terminating NUL byte, but memcpy does the same and avoids the warning.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/unifdef.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
@@ -450,7 +450,7 @@ static void Idrop (void) { Fdrop();  ign
 static void Itrue (void) { Ftrue();  ignoreon(); }
 static void Ifalse(void) { Ffalse(); ignoreon(); }
 /* modify this line */
-static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
+static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }
 static void Mtrue (void) { keywordedit("else");  state(IS_TRUE_MIDDLE); }
 static void Melif (void) { keywordedit("endif"); state(IS_FALSE_TRAILER); }
 static void Melse (void) { keywordedit("endif"); state(IS_FALSE_ELSE); }


