Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941CFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B0206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeLOKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:46:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeLOKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:46:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBFAjqE11717522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Dec 2018 02:45:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBFAjqqj1717519;
        Sat, 15 Dec 2018 02:45:52 -0800
Date:   Sat, 15 Dec 2018 02:45:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alistair Strachan <tipbot@zytor.com>
Message-ID: <tip-cd01544a268ad8ee5b1dfe42c4393f1095f86879@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, labbott@redhat.com, luto@kernel.org,
        carlos@redhat.com, x86@kernel.org, mingo@kernel.org,
        mingo@redhat.com, stable@vger.kernel.org, joel@joelfernandes.org,
        astrachan@google.com, linux-kernel@vger.kernel.org,
        fweimer@redhat.com, hjl.tools@gmail.com, tglx@linutronix.de
Reply-To: bp@suse.de, labbott@redhat.com, hpa@zytor.com,
          stable@vger.kernel.org, mingo@redhat.com, joel@joelfernandes.org,
          luto@kernel.org, carlos@redhat.com, x86@kernel.org,
          mingo@kernel.org, hjl.tools@gmail.com, tglx@linutronix.de,
          astrachan@google.com, fweimer@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181214223637.35954-1-astrachan@google.com>
References: <20181214223637.35954-1-astrachan@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Pass --eh-frame-hdr to the linker
Git-Commit-ID: cd01544a268ad8ee5b1dfe42c4393f1095f86879
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cd01544a268ad8ee5b1dfe42c4393f1095f86879
Gitweb:     https://git.kernel.org/tip/cd01544a268ad8ee5b1dfe42c4393f1095f86879
Author:     Alistair Strachan <astrachan@google.com>
AuthorDate: Fri, 14 Dec 2018 14:36:37 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 15 Dec 2018 11:37:51 +0100

x86/vdso: Pass --eh-frame-hdr to the linker

Commit

  379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")

accidentally broke unwinding from userspace, because ld would strip the
.eh_frame sections when linking.

Originally, the compiler would implicitly add --eh-frame-hdr when
invoking the linker, but when this Makefile was converted from invoking
ld via the compiler, to invoking it directly (like vmlinux does),
the flag was missed. (The EH_FRAME section is important for the VDSO
shared libraries, but not for vmlinux.)

Fix the problem by explicitly specifying --eh-frame-hdr, which restores
parity with the old method.

See relevant bug reports for additional info:

  https://bugzilla.kernel.org/show_bug.cgi?id=201741
  https://bugzilla.redhat.com/show_bug.cgi?id=1659295

Fixes: 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
Reported-by: Florian Weimer <fweimer@redhat.com>
Reported-by: Carlos O'Donell <carlos@redhat.com>
Reported-by: "H. J. Lu" <hjl.tools@gmail.com>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: kernel-team@android.com
Cc: Laura Abbott <labbott@redhat.com>
Cc: stable <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181214223637.35954-1-astrachan@google.com
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0624bf2266fd..5bfe2243a08f 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -171,7 +171,8 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
-	$(call ld-option, --build-id) -Bsymbolic
+	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
+	-Bsymbolic
 GCOV_PROFILE := n
 
 #
