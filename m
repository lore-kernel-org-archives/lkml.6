Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B51C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB721736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501006;
	bh=+om2ETSsJST+cHybbdGHxDMHsVk1aemtohHTNv2TOPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fw2MY24dk2vWSEaVyqBUY5Jw/pN7BDgF/6nksD6ZhbOC9WzfZ+6YbB9S9jPZp6EVT
	 lXvDdBLrr8mC9hQQNy4sJGtASAhrf0yWO3T1X2uPgMIaAzETvGnFyYu98NBBDr+/t5
	 JMwUyEQ7KDEVNLzt7GG6tVYKPXjN9+nXWRlKedrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfBRNtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732005AbfBRNtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDF121901;
        Mon, 18 Feb 2019 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497757;
        bh=+om2ETSsJST+cHybbdGHxDMHsVk1aemtohHTNv2TOPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAhzbHBstSku6FKUPSUIJ4b6qkhOFJ4OPOpEAXH60Qmg0IeArErW37gg2s5kgYhr7
         8gs1BSNLd3gjjWJLb2BTCt+o0vqohC22nyuCDb9Ee685/YSkeNtHCq3mAIPndmLilS
         EuWPrUqfglMDSjV+3dESAqQ/29fer29UBkg7mCKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.20 75/92] s390/suspend: fix stack setup in swsusp_arch_suspend
Date:   Mon, 18 Feb 2019 14:43:18 +0100
Message-Id: <20190218133501.887436700@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 634692ab7007e8e3fec758ab0b26e65abf7c79e0 upstream.

The patch that added support for the virtually mapped kernel stacks changed
swsusp_arch_suspend to switch to the nodat-stack as the vmap stack is not
available while going in and out of suspend.

Unfortunately the switch to the nodat-stack is incorrect which breaks
suspend to disk.

Cc: stable@vger.kernel.org # v4.20
Fixes: ce3dc447493f ("s390: add support for virtually mapped kernel stacks")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/swsusp.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -30,10 +30,10 @@
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	lg	%r1,__LC_NODAT_STACK
-	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stmg	%r6,%r15,__SF_GPRS(%r1)
+	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stg	%r15,__SF_BACKCHAIN(%r1)
-	lgr	%r1,%r15
+	lgr	%r15,%r1
 
 	/* Store FPU registers */
 	brasl	%r14,save_fpu_regs


