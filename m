Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeEBUd7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:33:59 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39450 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeEBUdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:33:33 -0400
X-Google-Smtp-Source: AB8JxZqhzqEF5YH1ET8/AlzN806/mAsphVQM0xk7iSFPQFe7Alo3fRza+THnjjU4hxWsHN9JDv6k2A==
From: Laura Abbott <labbott@redhat.com>
To: Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stackleak: Update for arm64
Date: Wed,  2 May 2018 13:33:25 -0700
Message-Id: <20180502203326.9491-2-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502203326.9491-1-labbott@redhat.com>
References: <20180502203326.9491-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 has another layer of indirection in the RTL.
Account for this in the plugin.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Fixed from previous version to be a vector expression.
---
 scripts/gcc-plugins/stackleak_plugin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 6ac2a055ec61..0a55ecaf44df 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -253,6 +253,10 @@ static unsigned int stackleak_cleanup_execute(void)
 		 * that insn.
 		 */
 		body = PATTERN(insn);
+		/* arm64 is different */
+		if (GET_CODE(body) == PARALLEL)
+			body = XVECEXP(body, 0, 0);
+
 		if (GET_CODE(body) != CALL)
 			continue;
 
-- 
2.14.3
