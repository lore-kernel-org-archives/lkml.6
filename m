Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D864B255BF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D864B255BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeGARUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:20:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031345AbeGAQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9A97892B;
        Sun,  1 Jul 2018 16:38:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haren Myneni <haren@us.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 050/220] powerpc/powernv: copy/paste - Mask SO bit in CR
Date:   Sun,  1 Jul 2018 18:21:14 +0200
Message-Id: <20180701160910.418692598@linuxfoundation.org>
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

From: Haren Myneni <haren@us.ibm.com>

commit 75743649064ec0cf5ddd69f240ef23af66dde16e upstream.

NX can set the 3rd bit in CR register for XER[SO] (Summary overflow)
which is not related to paste request. The current paste function
returns failure for a successful request when this bit is set. So mask
this bit and check the proper return status.

Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Haren Myneni <haren@us.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/copy-paste.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/copy-paste.h
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -42,5 +42,6 @@ static inline int vas_paste(void *paste_
 		: "b" (offset), "b" (paste_address)
 		: "memory", "cr0");
 
-	return (cr >> CR0_SHIFT) & CR0_MASK;
+	/* We mask with 0xE to ignore SO */
+	return (cr >> CR0_SHIFT) & 0xE;
 }


