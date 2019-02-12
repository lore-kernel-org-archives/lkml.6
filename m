Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F16C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986228;
	bh=0W/75YHGlmESdSfdJlB9JnspyeIkW8XqMvb/1p+GSmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7tNwn/rTOMaY/jUTQnLvEwpAiHjT5D1fDvkEC4cb55nLWoS70RqkaU3Vkd+hNAzt
	 3eM3WPB+p+NdSGM9qYul5b3TeJw5Fy29+1tpcvAP/U4SL4Z1hV/jJO37F0C8qERqHl
	 0lwvKmfs+YDgyvgonpYSb35gnjDfMHTCYzPka2UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfBLPnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:43:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA0C21773;
        Tue, 12 Feb 2019 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986225;
        bh=0W/75YHGlmESdSfdJlB9JnspyeIkW8XqMvb/1p+GSmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGOU+vqFPOKSbJWqILXjb50J6gHsBXFUaB73jmnJfUhp4jq3igTdXIR3oFnC0etsJ
         lsFAFUcA/cdHEaCRnsl7i6s/99+6kpvsxr36mkxk7O0hm/PSG+ENQDeI7W8FXuIBwq
         VOKx0jiDt2wUvr8dlAs/WJNpOt2xZwbmHq+UdaOU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 1/4] arm64: kprobes: Move extable address check into arch_prepare_kprobe()
Date:   Wed, 13 Feb 2019 00:43:22 +0900
Message-Id: <154998620258.21869.8971320076728831126.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move extable address check into arch_prepare_kprobe() from
arch_within_kprobe_blacklist().
The blacklist is exposed via debugfs as a list of symbols.
The extable entries are smaller, so must be filtered out
by arch_prepare_kprobe().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 Update in v2:
  - Update commit message.
  - Add Reviewed-by from James.
---
 arch/arm64/kernel/probes/kprobes.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index f17afb99890c..9989ec9baa11 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 	if (in_exception_text(probe_addr))
 		return -EINVAL;
+
+	if (search_exception_tables(probe_addr))
+		return -EINVAL;
+
 	if (probe_addr >= (unsigned long) __start_rodata &&
 	    probe_addr <= (unsigned long) __end_rodata)
 		return -EINVAL;
@@ -479,8 +483,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__idmap_text_start &&
 	    addr < (unsigned long)__idmap_text_end) ||
 	    (addr >= (unsigned long)__hyp_text_start &&
-	    addr < (unsigned long)__hyp_text_end) ||
-	    !!search_exception_tables(addr))
+	    addr < (unsigned long)__hyp_text_end))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {

