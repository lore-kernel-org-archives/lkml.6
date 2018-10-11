Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C209CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857372098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857372098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeJKWuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:50:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:21585 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbeJKWto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:49:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="77271630"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2018 08:21:44 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 05/11] x86/cet/ibt: ELF header parsing for IBT
Date:   Thu, 11 Oct 2018 08:16:48 -0700
Message-Id: <20181011151654.27221-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011151654.27221-1-yu-cheng.yu@intel.com>
References: <20181011151654.27221-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look in .note.gnu.property of an ELF file and check if Indirect
Branch Tracking needs to be enabled for the task.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/uapi/asm/elf_property.h | 1 +
 arch/x86/kernel/elf.c                    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/elf_property.h b/arch/x86/include/uapi/asm/elf_property.h
index af361207718c..343a871b8fc1 100644
--- a/arch/x86/include/uapi/asm/elf_property.h
+++ b/arch/x86/include/uapi/asm/elf_property.h
@@ -11,5 +11,6 @@
  * Bits for GNU_PROPERTY_X86_FEATURE_1_AND
  */
 #define GNU_PROPERTY_X86_FEATURE_1_SHSTK	(0x00000002)
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		(0x00000001)
 
 #endif /* _UAPI_ASM_X86_ELF_PROPERTY_H */
diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
index 2e2030a0462b..177b5144fdf4 100644
--- a/arch/x86/kernel/elf.c
+++ b/arch/x86/kernel/elf.c
@@ -336,6 +336,11 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
 		}
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
+		if (feature & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			err = cet_setup_ibt();
+	}
+
 out:
 	return err;
 }
-- 
2.17.1

