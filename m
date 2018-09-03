Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAF720658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAF720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeICV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:58:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:58:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6CEB2A95;
        Mon,  3 Sep 2018 17:37:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.18 088/123] s390/lib: use expoline for all bcr instructions
Date:   Mon,  3 Sep 2018 18:57:12 +0200
Message-Id: <20180903165723.247067123@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
 arch/s390/lib/mem.S |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -17,7 +17,7 @@
 ENTRY(memmove)
 	ltgr	%r4,%r4
 	lgr	%r1,%r2
-	bzr	%r14
+	jz	.Lmemmove_exit
 	aghi	%r4,-1
 	clgr	%r2,%r3
 	jnh	.Lmemmove_forward
@@ -36,6 +36,7 @@ ENTRY(memmove)
 .Lmemmove_forward_remainder:
 	larl	%r5,.Lmemmove_mvc
 	ex	%r4,0(%r5)
+.Lmemmove_exit:
 	BR_EX	%r14
 .Lmemmove_reverse:
 	ic	%r0,0(%r4,%r3)
@@ -65,7 +66,7 @@ EXPORT_SYMBOL(memmove)
  */
 ENTRY(memset)
 	ltgr	%r4,%r4
-	bzr	%r14
+	jz	.Lmemset_exit
 	ltgr	%r3,%r3
 	jnz	.Lmemset_fill
 	aghi	%r4,-1
@@ -80,6 +81,7 @@ ENTRY(memset)
 .Lmemset_clear_remainder:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
+.Lmemset_exit:
 	BR_EX	%r14
 .Lmemset_fill:
 	cghi	%r4,1
@@ -115,7 +117,7 @@ EXPORT_SYMBOL(memset)
  */
 ENTRY(memcpy)
 	ltgr	%r4,%r4
-	bzr	%r14
+	jz	.Lmemcpy_exit
 	aghi	%r4,-1
 	srlg	%r5,%r4,8
 	ltgr	%r5,%r5
@@ -124,6 +126,7 @@ ENTRY(memcpy)
 .Lmemcpy_remainder:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
+.Lmemcpy_exit:
 	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
@@ -145,9 +148,9 @@ EXPORT_SYMBOL(memcpy)
 .macro __MEMSET bits,bytes,insn
 ENTRY(__memset\bits)
 	ltgr	%r4,%r4
-	bzr	%r14
+	jz	.L__memset_exit\bits
 	cghi	%r4,\bytes
-	je	.L__memset_exit\bits
+	je	.L__memset_store\bits
 	aghi	%r4,-(\bytes+1)
 	srlg	%r5,%r4,8
 	ltgr	%r5,%r5
@@ -163,8 +166,9 @@ ENTRY(__memset\bits)
 	larl	%r5,.L__memset_mvc\bits
 	ex	%r4,0(%r5)
 	BR_EX	%r14
-.L__memset_exit\bits:
+.L__memset_store\bits:
 	\insn	%r3,0(%r2)
+.L__memset_exit\bits:
 	BR_EX	%r14
 .L__memset_mvc\bits:
 	mvc	\bytes(1,%r1),0(%r1)


