Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9025C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A109720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A109720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbeHARau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:30:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389602AbeHARau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:30:50 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rd5djjtglqVP; Wed,  1 Aug 2018 17:44:30 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DB391EC0591;
        Wed,  1 Aug 2018 17:44:29 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:44:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com
Subject: [PATCH 1/2] x86/microcode: Make sure boot_cpu_data.microcode is
 up-to-date
Message-ID: <20180801154434.GD13988@nazgul.tnic>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
 <20180801154255.GC13988@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801154255.GC13988@nazgul.tnic>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

The MCE code uses boot_cpu_data.microcode to prepare the MCE record.
However, on systems where late microcode update has occurred, the
microcode revision output in a MCE log record is wrong because
boot_cpu_data.microcode is not updated when the microcode gets updated.

However, the microcode revision saved in boot_cpu_data's microcode
member should be kept up-to-date, regardless, for consistency.

Make it so.

Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: sironi@amazon.de
Cc: stable@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20180731112739.32338-1-prarit@redhat.com
[ Make commit message more precise. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..63b072377ba4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
 	c->microcode = mc_amd->hdr.patch_id;
 
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode =  mc_amd->hdr.patch_id;
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
2.18.0.321.gffc6fa0e3962


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
