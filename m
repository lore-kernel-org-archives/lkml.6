Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1C2C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5F320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJNXTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cS-95; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Jt-1L; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Nicholas Piggin" <npiggin@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.175080568@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 132/366] powerpc/powernv: define a standard delay for
 OPAL_BUSY type retry loops
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 34dd25de9fe3f60bfdb31b473bf04b28262d0896 upstream.

This is the start of an effort to tidy up and standardise all the
delays. Existing loops have a range of delay/sleep periods from 1ms
to 20ms, and some have no delay. They all loop forever except rtc,
which times out after 10 retries, and that uses 10ms delays. So use
10ms as our standard delay. The OPAL maintainer agrees 10ms is a
reasonable starting point.

The idea is to use the same recipe everywhere, once this is proven to
work then it will be documented as an OPAL API standard. Then both
firmware and OS can agree, and if a particular call needs something
else, then that can be documented with reasoning.

This is not the end-all of this effort, it's just a relatively easy
change that fixes some existing high latency delays. There should be
provision for standardising timeouts and/or interruptible loops where
possible, so non-fatal firmware errors don't cause hangs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/opal.h | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -707,6 +707,9 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
 
+/* Default time to sleep or delay between OPAL_BUSY/OPAL_BUSY_EVENT loops */
+#define OPAL_BUSY_DELAY_MS	10
+
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
 

