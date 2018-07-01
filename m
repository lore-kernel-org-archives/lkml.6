Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFFC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0B255C6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D0B255C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965947AbeGARUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:20:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031593AbeGAQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B7A9AA6;
        Sun,  1 Jul 2018 16:38:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 045/220] powerpc/pkeys: Detach execute_only key on !PROT_EXEC
Date:   Sun,  1 Jul 2018 18:21:09 +0200
Message-Id: <20180701160910.206851258@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ram Pai <linuxram@us.ibm.com>

commit eabdb8ca8690eedd461e61ea7780595fbbae8132 upstream.

Disassociate the exec_key from a VMA if the VMA permission is not
PROT_EXEC anymore. Otherwise the exec_only key continues to be
associated with the vma, causing unexpected behavior.

The problem was reported on x86 by Shakeel Butt, which is also
applicable on powerpc.

Fixes: 5586cf61e108 ("powerpc: introduce execute-only pkey")
Cc: stable@vger.kernel.org # v4.16+
Reported-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pkeys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -383,9 +383,9 @@ int __arch_override_mprotect_pkey(struct
 {
 	/*
 	 * If the currently associated pkey is execute-only, but the requested
-	 * protection requires read or write, move it back to the default pkey.
+	 * protection is not execute-only, move it back to the default pkey.
 	 */
-	if (vma_is_pkey_exec_only(vma) && (prot & (PROT_READ | PROT_WRITE)))
+	if (vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC))
 		return 0;
 
 	/*


