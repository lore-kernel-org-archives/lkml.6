Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75E20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfBFSNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:13:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:13:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x16ID7Ib1391439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Feb 2019 10:13:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x16ID7L51391435;
        Wed, 6 Feb 2019 10:13:07 -0800
Date:   Wed, 6 Feb 2019 10:13:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-82434d23f36de42f70925f70d645ed3b1394361b@git.kernel.org>
Cc:     wei@redhat.com, bp@suse.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
        kyle.d.pelton@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org
Reply-To: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kyle.d.pelton@intel.com, hpa@zytor.com, mingo@kernel.org,
          mingo@redhat.com, kirill.shutemov@linux.intel.com, bp@suse.de,
          wei@redhat.com
In-Reply-To: <20190206154756.matwldebbxkmlnae@black.fi.intel.com>
References: <20190206154756.matwldebbxkmlnae@black.fi.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/boot/compressed/64: Explain
 paging_prepare()'s return value
Git-Commit-ID: 82434d23f36de42f70925f70d645ed3b1394361b
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

Commit-ID:  82434d23f36de42f70925f70d645ed3b1394361b
Gitweb:     https://git.kernel.org/tip/82434d23f36de42f70925f70d645ed3b1394361b
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 6 Feb 2019 18:29:08 +0300
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 6 Feb 2019 19:08:34 +0100

x86/boot/compressed/64: Explain paging_prepare()'s return value

paging_prepare() returns a two-quadword structure which lands
into RDX:RAX:

  - Address of the trampoline is returned in RAX.
  - Non zero RDX means trampoline needs to enable 5-level paging.

Document that explicitly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: dave.hansen@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kyle D Pelton <kyle.d.pelton@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190206154756.matwldebbxkmlnae@black.fi.intel.com
---
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b27b338d2f6d..73b9d7e91a9c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -358,8 +358,11 @@ ENTRY(startup_64)
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
 	 *
-	 * Address of the trampoline is returned in RAX.
-	 * Non zero RDX on return means we need to enable 5-level paging.
+	 * paging_prepare() returns a two-quadword structure which lands
+	 * into RDX:RAX:
+	 *   - Address of the trampoline is returned in RAX.
+	 *   - Non zero RDX means trampoline needs to enable 5-level
+	 *     paging.
 	 *
 	 * RSI holds real mode data and needs to be preserved across
 	 * this function call.
@@ -565,7 +568,7 @@ adjust_got:
  *
  * RDI contains the return address (might be above 4G).
  * ECX contains the base address of the trampoline memory.
- * Non zero RDX on return means we need to enable 5-level paging.
+ * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 ENTRY(trampoline_32bit_src)
 	/* Set up data and stack segments */
