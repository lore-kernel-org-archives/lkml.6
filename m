Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E7EC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E81206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E81206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeI3Ea0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:30:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51599 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727800AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N62-0000Gv-Sl; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0006zS-17; Sat, 29 Sep 2018 22:48:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.321833084@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 131/131] exec: Limit arg stack to at most 75% of _STK_LIM
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit da029c11e6b12f321f36dac8771e833b65cec962 upstream.

To avoid pathological stack usage or the need to special-case setuid
execs, just limit all arg stack usage to at most 75% of _STK_LIM (6MB).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: replaced code is slightly different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/exec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -206,8 +206,7 @@ static struct page *get_arg_page(struct
 
 	if (write) {
 		unsigned long size = bprm->vma->vm_end - bprm->vma->vm_start;
-		unsigned long ptr_size;
-		struct rlimit *rlim;
+		unsigned long ptr_size, limit;
 
 		/*
 		 * Since the stack will hold pointers to the strings, we
@@ -236,14 +235,16 @@ static struct page *get_arg_page(struct
 			return page;
 
 		/*
-		 * Limit to 1/4-th the stack size for the argv+env strings.
+		 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
+		 * (whichever is smaller) for the argv+env strings.
 		 * This ensures that:
 		 *  - the remaining binfmt code will not run out of stack space,
 		 *  - the program will have a reasonable amount of stack left
 		 *    to work from.
 		 */
-		rlim = current->signal->rlim;
-		if (size > ACCESS_ONCE(rlim[RLIMIT_STACK].rlim_cur) / 4)
+		limit = _STK_LIM / 4 * 3;
+		limit = min(limit, rlimit(RLIMIT_STACK) / 4);
+		if (size > limit)
 			goto fail;
 	}
 

