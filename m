Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90148C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51820700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B51820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLFPNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:13:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33171 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:13:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so644867lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Fe3/yqBpf9nSMtaMboYSUItlGt6aYnnhkmOZpRL34kY=;
        b=jW8ZimDElUEiWG8gRN+Yl+XJYAshAiN1lGsSAI7yx5ibPzezdfGQwwawQGx4P5lbjt
         fC62mweCPuIRijal6W+iHjBEtgncyfLkTmgREUlx51lOZQ6LC+/u6LC9JjQU+t5czqlf
         Ve26ubsKtSRCkKE3/arlweRhQMvbEQ/bJxDuTMQaHrV7o727qIDdhwwZs+h8EX/UwXXo
         RQNRM3nrTEftwskbdBZokJzWNF524fLel2YUyLv0/WQzo2Ei2uAz+dZdlNFNjTpfjgKu
         q5pOmYfTxPCN4ZFL8GlQSvEdCaiLjUbhZJYsynuM4DQgXCj20UhLvqksNt9fFjPfZEny
         xA4Q==
X-Gm-Message-State: AA+aEWarxuSd3LTitJeb5guqaiW472WqModbfgphJuxNdE/mpR7CaPig
        ohwBHU8dsQwuZpnt4gbdshA=
X-Google-Smtp-Source: AFSGD/UKqwvqngJ4zSOCF6af7JvT8zoH8dIIShluX5oZq/1xPpdDhagFHSIvHngV7rawyO9gEl2mTQ==
X-Received: by 2002:a19:945b:: with SMTP id w88mr16333003lfd.15.1544109200176;
        Thu, 06 Dec 2018 07:13:20 -0800 (PST)
Received: from localhost.localdomain ([213.87.131.37])
        by smtp.gmail.com with ESMTPSA id h3sm115222lfb.49.2018.12.06.07.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 07:13:19 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Tycho Andersen <tycho@tycho.ws>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        H Peter Anvin <hpa@zytor.com>,
        David S Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, gcc@gcc.gnu.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] stackleak: Register the 'stackleak_cleanup' pass before the '*free_cfg' pass
Date:   Thu,  6 Dec 2018 18:13:07 +0300
Message-Id: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
after the 'reload' pass. That allows gcc to do some weird optimization in
function prologues and epilogues, which are generated later [1].

Let's avoid that by registering the 'stackleak_cleanup' pass before
the '*free_cfg' pass. It's the moment when the stack frame size is
already final, function prologues and epilogues are generated, and the
machine-dependent code transformations are not done.

[1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 2f48da9..dbd3746 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 						PASS_POS_INSERT_BEFORE);
 
 	/*
-	 * The stackleak_cleanup pass should be executed after the
-	 * "reload" pass, when the stack frame size is final.
+	 * The stackleak_cleanup pass should be executed before the "*free_cfg"
+	 * pass. It's the moment when the stack frame size is already final,
+	 * function prologues and epilogues are generated, and the
+	 * machine-dependent code transformations are not done.
 	 */
-	PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
+	PASS_INFO(stackleak_cleanup, "*free_cfg", 1, PASS_POS_INSERT_BEFORE);
 
 	if (!plugin_default_version_check(version, &gcc_version)) {
 		error(G_("incompatible gcc/plugin versions"));
-- 
2.7.4

