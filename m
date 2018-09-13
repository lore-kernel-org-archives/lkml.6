Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B54DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A54C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A54C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeIMStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:49:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:49:40 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ABCFCF3;
        Thu, 13 Sep 2018 13:40:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 74/78] s390/lib: use expoline for all bcr instructions
Date:   Thu, 13 Sep 2018 15:32:01 +0200
Message-Id: <20180913131813.078250125@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 5eda25b10297684c1f46a14199ec00210f3c346e upstream.

The memove, memset, memcpy, __memset16, __memset32 and __memset64
function have an additional indirect return branch in form of a
"bzr" instruction. These need to use expolines as well.

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: 97489e0663 ("s390/lib: use expoline for indirect branches")
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/s390/lib/mem.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -27,7 +27,7 @@
  */
 ENTRY(memset)
 	ltgr	%r4,%r4
-	bzr	%r14
+	jz	.Lmemset_exit
 	ltgr	%r3,%r3
 	jnz	.Lmemset_fill
 	aghi	%r4,-1
@@ -42,12 +42,13 @@ ENTRY(memset)
 .Lmemset_clear_rest:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
+.Lmemset_exit:
 	BR_EX	%r14
 .Lmemset_fill:
 	stc	%r3,0(%r2)
 	cghi	%r4,1
 	lgr	%r1,%r2
-	ber	%r14
+	je	.Lmemset_fill_exit
 	aghi	%r4,-2
 	srlg	%r3,%r4,8
 	ltgr	%r3,%r3
@@ -59,6 +60,7 @@ ENTRY(memset)
 .Lmemset_fill_rest:
 	larl	%r3,.Lmemset_mvc
 	ex	%r4,0(%r3)
+.Lmemset_fill_exit:
 	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
@@ -73,7 +75,7 @@ EXPORT_SYMBOL(memset)
  */
 ENTRY(memcpy)
 	ltgr	%r4,%r4
-	bzr	%r14
+	jz	.Lmemcpy_exit
 	aghi	%r4,-1
 	srlg	%r5,%r4,8
 	ltgr	%r5,%r5
@@ -82,6 +84,7 @@ ENTRY(memcpy)
 .Lmemcpy_rest:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
+.Lmemcpy_exit:
 	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)


