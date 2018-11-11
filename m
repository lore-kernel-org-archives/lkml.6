Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606482148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606482148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeKLGD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52860 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:56 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt5-0000l6-Mg; Sun, 11 Nov 2018 19:59:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001VS-07; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.347331301@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 108/366] powerpc/mm/hash: Add missing isync prior to
 kernel stack SLB switch
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

commit 91d06971881f71d945910de128658038513d1b24 upstream.

Currently we do not have an isync, or any other context synchronizing
instruction prior to the slbie/slbmte in _switch() that updates the
SLB entry for the kernel stack.

However that is not correct as outlined in the ISA.

=46romPower ISA Version 3.0B, Book III, Chapter 11, page 1133:

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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
[mpe: Flesh out change log with more ISA text & explanation]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -525,6 +525,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEG
 	 * actually hit this code path.
 	 */
 
+	isync
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0

