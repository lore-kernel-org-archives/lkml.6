Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D482084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545191;
	bh=m0Yq7vsFwLm5rcnspiysqmb6t2Jgm3tezryuCyNRuQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D5ZWI9XJhpdD0iKbeRxQcqoyqdP6L/1DwHuLaYTSZvfo2gw/63hx/G4P2AhXX9TFK
	 IqPuDTk+1gej/mw3wIHIobF02fts3Wx/ysNx1jJnFkzcmhgzTIBh4QWrvhsy0tQ9O5
	 slX9EQNEY4YkrwBnWSSW0M9Va4hj9KTO7ucISGlo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D482084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeLKQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbeLKPpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AF421479;
        Tue, 11 Dec 2018 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543132;
        bh=m0Yq7vsFwLm5rcnspiysqmb6t2Jgm3tezryuCyNRuQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfJmp9wPXguCa7M8rC7KUB5ywKGZm7ityhG3SsJ9M+JRJf1p97J/HfHdKoTHlqoRp
         rAIwLvPFbUBCz3stlAyks/6f+Hc7Ma26UCRvj5P/P/50VWZwJz1Akxtis2m4jMIK8r
         MsU6un/VxrbqAfNVbfibRTdvwlCPTaju7Fx0tqCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 25/91] unifdef: use memcpy instead of strncpy
Date:   Tue, 11 Dec 2018 16:40:44 +0100
Message-Id: <20181211151607.816589545@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


