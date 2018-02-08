Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeBHPqm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:46:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36738 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHPql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:46:41 -0500
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] UBSAN: support __ubsan_handle_type_mismatch_v1
Date: Thu,  8 Feb 2018 15:46:36 +0000
Message-Id: <20180208154636.21320-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, UBSAN's __ubsan_handle_type_mismatch took a struct
type_mismatch_data, as defined in lib/ubsan.h. This has an unsigned long
alignment field.

New versions of UBSAN call __ubsan_handle_type_mismatch_v1, which is
similar to __ubsan_handle_type_mismatch, but takes a different struct
where the alignment is stored in an unsigned char (as log2 of the
alignment). All other fields are unchanged.

As we don't implement __ubsan_handle_type_mismatch_v1, the kernel will
fail to link when compiled with compilers using the new ABI (e.g. clang
form the LLVM 5.0.0 release).

This patch adds support for the new ABI. To keep things simple, we
simply convert the new data format into the old format, and hand it on
to the existing handlers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/ubsan.c | 14 ++++++++++++++
 lib/ubsan.h |  7 +++++++
 2 files changed, 21 insertions(+)

Andrey, does this look correct to you? Are there any other new ABI bits
that need to be plumbed in?

Mark.

diff --git a/lib/ubsan.c b/lib/ubsan.c
index fb0409df1bcf..b7af7d3478a9 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -328,6 +328,20 @@ void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
 }
 EXPORT_SYMBOL(__ubsan_handle_type_mismatch);
 
+void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data_v1,
+				     unsigned long ptr)
+{
+	struct type_mismatch_data data = {
+		.location = data_v1->location,
+		.type = data_v1->type,
+		.alignment = 1UL << data_v1->log_alignment,
+		.type_check_kind = data_v1->type_check_kind,
+	};
+
+	__ubsan_handle_type_mismatch(&data, ptr);
+}
+EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
+
 void __ubsan_handle_nonnull_return(struct nonnull_return_data *data)
 {
 	unsigned long flags;
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 88f23557edbe..dc0b8cbc7f57 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -37,6 +37,13 @@ struct type_mismatch_data {
 	unsigned char type_check_kind;
 };
 
+struct type_mismatch_data_v1 {
+	struct source_location location;
+	struct type_descriptor *type;
+	unsigned char log_alignment;
+	unsigned char type_check_kind;
+};
+
 struct nonnull_arg_data {
 	struct source_location location;
 	struct source_location attr_location;
-- 
2.11.0
