Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2EE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2EE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLAA3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:29:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40110 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLAA3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:29:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so4958978lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MYK1Fe1SMo3XkBqdmK20b/a6CPuB50O2uKZhV3bkitM=;
        b=bPthkvVvNKJDLy4b3TDEvD37DOTtVgkNEuq6DFPzVN955HLemoX26pVgghMI+h0+yz
         MSxSQ/kd+4ndjRcajIAgsbAl1M9MFhMgvDvGXe/Bl2gP7K1ZAYM3h2IuhXKPA550AR6K
         fhbjhAPIhXPf18IwA4fkmJndX8GWVKZvFLsml9V/Nk3QHYqni7kbohCyoLRhYAfPJCV+
         HuyGIudwD3gYXNrZz6/8CMPYREkH3H2lezS2Vzj0AmA6Tgly1qHIn1Onlj/p8cbTiLtx
         AmZ5z21cIIOgOLXjTiyP5lKBTYDLZ+dasAz3M8+UrJwcOx70Sl/h4UV65lsaUhCyb6rk
         CS5g==
X-Gm-Message-State: AA+aEWaahns+H19VrV+S5wsplvH3i6V7OLYM1j83y3sqzuoCHEPWF9sj
        zCZ+QLq2Bw4OpTbbkP4viZQ=
X-Google-Smtp-Source: AFSGD/Ug4nwyFB+Fak6D+Ks51fspieVWWH94yQHG7jlNyW+kdC2/h8GHEEwPZjRnekNlGWcNwd21YQ==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr3846732ljg.160.1543583999439;
        Fri, 30 Nov 2018 05:19:59 -0800 (PST)
Received: from localhost.localdomain ([213.87.138.170])
        by smtp.gmail.com with ESMTPSA id c22sm802455lfd.88.2018.11.30.05.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:19:58 -0800 (PST)
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
Subject: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass before the 'mach' pass
Date:   Fri, 30 Nov 2018 16:19:47 +0300
Message-Id: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
after the 'reload' pass. That allows gcc to do some weird optimization in
function prologues and epilogues, which are generated later [1].

Let's avoid that by registering the 'stackleak_cleanup' pass before
the 'mach' pass, which performs the machine dependent code transformations.
It's the moment when the stack frame size is final and function prologues
and epilogues are already generated.

[1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 2f48da9..6f41b32 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 						PASS_POS_INSERT_BEFORE);
 
 	/*
-	 * The stackleak_cleanup pass should be executed after the
-	 * "reload" pass, when the stack frame size is final.
+	 * The stackleak_cleanup pass should be executed before the "mach"
+	 * pass, which performs the machine dependent code transformations.
+	 * It's the moment when the stack frame size is already final and
+	 * function prologues and epilogues are generated.
 	 */
-	PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
+	PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE);
 
 	if (!plugin_default_version_check(version, &gcc_version)) {
 		error(G_("incompatible gcc/plugin versions"));
-- 
2.7.4

