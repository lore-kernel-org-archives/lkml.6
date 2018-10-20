Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5137D21557
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5137D21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJTWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:52:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:53939 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeJTWwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:52:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2018 07:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,404,1534834800"; 
   d="scan'208";a="84182240"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2018 07:41:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CD50F300FE1; Sat, 20 Oct 2018 07:41:59 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] x86/microcode: Handle negative microcode revisions
Date:   Sat, 20 Oct 2018 07:41:58 -0700
Message-Id: <20181020144158.6261-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Intel microcode revision space is unsigned. Inside Intel there are special
microcodes that have the highest bit set, and they are considered to have
a higher revision than any microcodes that don't have this bit set.

The function comparing the microcode revision in the Linux driver compares
u32 with int, which ends up being signed extended to long on 64bit
systems. This results in these highest bit set microcode revision not loading
because their revision appears negative and smaller than the
existing microcode.

Change the comparison to unsigned. With that the loading works
as expected.

Cc: stable@vger.kernel.org # Any supported stable
Signed-off-by: Andi Kleen <ak@linux.intel.com>
--
v2: White space changes.
---
 arch/x86/kernel/cpu/microcode/intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e54d402500d3 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -93,7 +93,8 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
+static int has_newer_microcode(void *mc, unsigned int csig, int cpf,
+			       unsigned new_rev)
 {
 	struct microcode_header_intel *mc_hdr = mc;
 
-- 
2.17.1

