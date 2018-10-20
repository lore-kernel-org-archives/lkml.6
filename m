Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698FAECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6BE2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6BE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJTIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:20:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:16231 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbeJTIUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:20:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 17:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="82652041"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2018 17:11:41 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DF913300FC1; Fri, 19 Oct 2018 17:11:41 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1] x86/microcode: Handle negative microcode revisions
Date:   Fri, 19 Oct 2018 17:11:37 -0700
Message-Id: <20181020001137.31461-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Intel ucode revision space is unsigned. Inside Intel there are special
microcodes that have the highest bit set, and they are considered to have
a higher revision than any microcodes that don't have this bit set.

The function comparing the microcodes in the Linux driver compares
u32 with int, which ends up being signed extended to long on 64bit
systems. This results in these highest bit set microcodes not loading
because their revision appears negative and smaller than the
existing microcode.

Change the comparison to unsigned. With that the loading works
as expected.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e95cebdd5993 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -93,7 +93,7 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
+static int has_newer_microcode(void *mc, unsigned int csig, int cpf, unsigned new_rev)
 {
 	struct microcode_header_intel *mc_hdr = mc;
 
-- 
2.17.1

