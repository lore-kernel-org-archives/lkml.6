Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F219120861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956094;
	bh=VO30JhGpAuK8xTJXbluNZ+V6awx8Y1G6zH8WRTQDtmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHhjbaYNlwyW5qGc+u0iGfx27vaMVifGHy46G5lcEBw9k5xYSoa8ZaTi37pQjYuvF
	 vdG6JncIyyRx9bbuXPwcOfyQbOWPIy9FfZL7MksAnPEjKlniBcRsgQqOQ9AQNaCyzU
	 AHzGTC7OGOja2gGX52D3AtcrI1r6ZiA68W8c975Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfBWVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbfBWVIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:08:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9441420855;
        Sat, 23 Feb 2019 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956088;
        bh=VO30JhGpAuK8xTJXbluNZ+V6awx8Y1G6zH8WRTQDtmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KDWmTFfX4AtcnSjLeIayaWVMP6/wfeeWzcPNokgM+7XQiukkt7EwJ4YL04AredDO
         MOifvAZw8apdNpX9k22wkgpZalWjd6JvyLfuxesZI22kpmUmq9KylQXWz/uAXigKrE
         ZipMHDTmwLY6HQGU9XpVBSVWHoUnsWDsGunA679I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 55/65] arm64: kprobe: Always blacklist the KVM world-switch code
Date:   Sat, 23 Feb 2019 16:06:30 -0500
Message-Id: <20190223210640.200911-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit f2b3d8566d81deaca31f4e3163def0bea7746e11 ]

On systems with VHE the kernel and KVM's world-switch code run at the
same exception level. Code that is only used on a VHE system does not
need to be annotated as __hyp_text as it can reside anywhere in the
 kernel text.

__hyp_text was also used to prevent kprobes from patching breakpoint
instructions into this region, as this code runs at a different
exception level. While this is no longer true with VHE, KVM still
switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
world-switch code will cause a hyp-panic.

Move the __hyp_text check in the kprobes blacklist so it applies on
VHE systems too, to cover the common code and guest enter/exit
assembly.

Fixes: 888b3c8720e0 ("arm64: Treat all entry code as non-kprobe-able")
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index b5a367d4bba6a..30bb137970347 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -478,13 +478,13 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
 	    addr < (unsigned long)__idmap_text_end) ||
+	    (addr >= (unsigned long)__hyp_text_start &&
+	    addr < (unsigned long)__hyp_text_end) ||
 	    !!search_exception_tables(addr))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_text_start &&
-		    addr < (unsigned long)__hyp_text_end) ||
-		    (addr >= (unsigned long)__hyp_idmap_text_start &&
+		if ((addr >= (unsigned long)__hyp_idmap_text_start &&
 		    addr < (unsigned long)__hyp_idmap_text_end))
 			return true;
 	}
-- 
2.19.1

