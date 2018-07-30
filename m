Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627C1625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AD020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeG3T0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:26:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728672AbeG3T0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7696D40201A3;
        Mon, 30 Jul 2018 17:50:03 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 086C62156701;
        Mon, 30 Jul 2018 17:50:03 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     bp@alien8.de
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com,
        Prarit Bhargava <prarit@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] arch/x86: Fix boot_cpu_data.microcode version output
Date:   Mon, 30 Jul 2018 13:49:11 -0400
Message-Id: <20180730174911.26238-1-prarit@redhat.com>
In-Reply-To: <20180601121939.GA23298@nazgul.tnic>
References: <20180601121939.GA23298@nazgul.tnic>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 17:50:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 17:50:03 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems where a runtime microcode update has occurred the microcode
version output in a MCE log record is wrong because
boot_cpu_data.microcode is not updated during runtime.

Update boot_cpu_data.microcode when the BSP's microcode is updated.

Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
Suggested-by: Borislav Petkov <bp@alien8.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: stable@vger.kernel.org
Cc: sironi@amazon.de
Cc: tony.luck@intel.com
---
 arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..7f5b32535ac7 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
+
 	return UCODE_UPDATED;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 97ccf4c3b45b..256d336cbc04 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
+
 	return UCODE_UPDATED;
 }
 
-- 
2.17.0

