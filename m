Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MLXhAmjDX+VInjAZMyltjyNj0pUsfjabx9H1O170K5BUWShZTskPiG1kQ32Oxo+QHEGcv
ARC-Seal: i=1; a=rsa-sha256; t=1518709072; cv=none;
        d=google.com; s=arc-20160816;
        b=oKibGouZQaEAjwaPB+YGRxhHRO/tbsKW2sWdGt+mGyFCaTGo0SysoMOTYF12dJ4fHw
         9kippDdTKHNzxyiXw5TgaZmwmZmQFrN2DZppqju+u1mdd6SGKECK2AzVTCU+KNGJGxS2
         /1EZCbd3Za8sYcfbYA2nw3jRd4+VI7WA7ZHFbTr4O2K/2GdSRQnflgOVuQD8AfupIyjF
         tquOPR0tWFExRwXeKxxZdfeEB6CkDWfz8rAkGJ+xuf/u6dc1PgKNKVas0j0sjY1XgEZy
         ehxqQxBftZhL5zdXzB1W+RZ7MeuBzK0IPri0CnTdp4C+8j9UBb4+XfYAZLkwpygYqOmo
         8wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TvLKUlogMlW6DMGtj18Q8+qgHDrgoqB0xdik92qrDhc=;
        b=hx1+jX5oWuFQDDx9DaB5CTmONeh9UgCA4GIkhQJb4Kn7kvJHurLZKb3pxxeX7lTySl
         Z63sSFQgzEDFUBmwPJdsl+yI+F2Lzb/U/yes1WJE3BbgTO1dEoF7/lnhViu1AmgPx1ge
         agr1V9cBcNWlEmajCzvK7vZJUX0fhEw2od57Ft3dbR+EYPNdPMK8cozeb3ZQy9PnSe4L
         LXlus8hU/cqYMfmYObDHYNoqttMMbgiW2AW33e5upfZRcaMreUF4zPgP3GeQd70x4vzL
         nTWIQBYXnv+zobUr3xQvan69ymWnKL3DXOjKHOGHLLXWOJkrovUyl216JlNwjb7hZ5Uv
         ni3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Sodagudi Prasad <psodagud@codeaurora.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 181/195] lib/ubsan: add type mismatch handler for new GCC/Clang
Date: Thu, 15 Feb 2018 16:17:52 +0100
Message-Id: <20180215151715.285772702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481334818391977?=
X-GMAIL-MSGID: =?utf-8?q?1592481884359308398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 42440c1f9911b4b7b8ba3dc4e90c1197bc561211 upstream.

UBSAN=y fails to build with new GCC/clang:

    arch/x86/kernel/head64.o: In function `sanitize_boot_params':
    arch/x86/include/asm/bootparam_utils.h:37: undefined reference to `__ubsan_handle_type_mismatch_v1'

because Clang and GCC 8 slightly changed ABI for 'type mismatch' errors.
Compiler now uses new __ubsan_handle_type_mismatch_v1() function with
slightly modified 'struct type_mismatch_data'.

Let's add new 'struct type_mismatch_data_common' which is independent from
compiler's layout of 'struct type_mismatch_data'.  And make
__ubsan_handle_type_mismatch[_v1]() functions transform compiler-dependent
type mismatch data to our internal representation.  This way, we can
support both old and new compilers with minimal amount of change.

Link: http://lkml.kernel.org/r/20180119152853.16806-1-aryabinin@virtuozzo.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Sodagudi Prasad <psodagud@codeaurora.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/ubsan.c |   48 ++++++++++++++++++++++++++++++++++++++----------
 lib/ubsan.h |   14 ++++++++++++++
 2 files changed, 52 insertions(+), 10 deletions(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -265,14 +265,14 @@ void __ubsan_handle_divrem_overflow(stru
 }
 EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
 
-static void handle_null_ptr_deref(struct type_mismatch_data *data)
+static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
 {
 	unsigned long flags;
 
-	if (suppress_report(&data->location))
+	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(data->location, &flags);
 
 	pr_err("%s null pointer of type %s\n",
 		type_check_kinds[data->type_check_kind],
@@ -281,15 +281,15 @@ static void handle_null_ptr_deref(struct
 	ubsan_epilogue(&flags);
 }
 
-static void handle_misaligned_access(struct type_mismatch_data *data,
+static void handle_misaligned_access(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
 	unsigned long flags;
 
-	if (suppress_report(&data->location))
+	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(data->location, &flags);
 
 	pr_err("%s misaligned address %p for type %s\n",
 		type_check_kinds[data->type_check_kind],
@@ -299,15 +299,15 @@ static void handle_misaligned_access(str
 	ubsan_epilogue(&flags);
 }
 
-static void handle_object_size_mismatch(struct type_mismatch_data *data,
+static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 					unsigned long ptr)
 {
 	unsigned long flags;
 
-	if (suppress_report(&data->location))
+	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(data->location, &flags);
 	pr_err("%s address %p with insufficient space\n",
 		type_check_kinds[data->type_check_kind],
 		(void *) ptr);
@@ -315,7 +315,7 @@ static void handle_object_size_mismatch(
 	ubsan_epilogue(&flags);
 }
 
-void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
+static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
 
@@ -326,8 +326,36 @@ void __ubsan_handle_type_mismatch(struct
 	else
 		handle_object_size_mismatch(data, ptr);
 }
+
+void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
+				unsigned long ptr)
+{
+	struct type_mismatch_data_common common_data = {
+		.location = &data->location,
+		.type = data->type,
+		.alignment = data->alignment,
+		.type_check_kind = data->type_check_kind
+	};
+
+	ubsan_type_mismatch_common(&common_data, ptr);
+}
 EXPORT_SYMBOL(__ubsan_handle_type_mismatch);
 
+void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
+				unsigned long ptr)
+{
+
+	struct type_mismatch_data_common common_data = {
+		.location = &data->location,
+		.type = data->type,
+		.alignment = 1UL << data->log_alignment,
+		.type_check_kind = data->type_check_kind
+	};
+
+	ubsan_type_mismatch_common(&common_data, ptr);
+}
+EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
+
 void __ubsan_handle_nonnull_return(struct nonnull_return_data *data)
 {
 	unsigned long flags;
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -37,6 +37,20 @@ struct type_mismatch_data {
 	unsigned char type_check_kind;
 };
 
+struct type_mismatch_data_v1 {
+	struct source_location location;
+	struct type_descriptor *type;
+	unsigned char log_alignment;
+	unsigned char type_check_kind;
+};
+
+struct type_mismatch_data_common {
+	struct source_location *location;
+	struct type_descriptor *type;
+	unsigned long alignment;
+	unsigned char type_check_kind;
+};
+
 struct nonnull_arg_data {
 	struct source_location location;
 	struct source_location attr_location;
