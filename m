Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC1F25263
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC1F25263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030515AbeGAQbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:31:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030482AbeGAQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E69CAA6;
        Sun,  1 Jul 2018 16:31:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 034/157] powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch
Date:   Sun,  1 Jul 2018 18:21:46 +0200
Message-Id: <20180701160854.071876565@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 91d06971881f71d945910de128658038513d1b24 upstream.

Currently we do not have an isync, or any other context synchronizing
instruction prior to the slbie/slbmte in _switch() that updates the
SLB entry for the kernel stack.

However that is not correct as outlined in the ISA.

>From Power ISA Version 3.0B, Book III, Chapter 11, page 1133:

  "Changing the contents of ... the contents of SLB entries ... can
   have the side effect of altering the context in which data
   addresses and instruction addresses are interpreted, and in which
   instructions are executed and data accesses are performed.
   ...
   These side effects need not occur in program order, and therefore
   may require explicit synchronization by software.
   ...
   The synchronizing instruction before the context-altering
   instruction ensures that all instructions up to and including that
   synchronizing instruction are fetched and executed in the context
   that existed before the alteration."

And page 1136:

  "For data accesses, the context synchronizing instruction before the
   slbie, slbieg, slbia, slbmte, tlbie, or tlbiel instruction ensures
   that all preceding instructions that access data storage have
   completed to a point at which they have reported all exceptions
   they will cause."

We're not aware of any bugs caused by this, but it should be fixed
regardless.

Add the missing isync when updating kernel stack SLB entry.

Cc: stable@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
[mpe: Flesh out change log with more ISA text & explanation]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_64.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -597,6 +597,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEG
 	 * actually hit this code path.
 	 */
 
+	isync
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0


