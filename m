Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710299-2-7099830946117846859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710298; b=q9n9oOe3okvwv7lm4aXRXBMKdWzKuCwmX4GCSjaRhn4QV8B
    uV5dEmu64zfhJ6bLbITox/XPx4sPiwHC8zrKaE/RFItI3f7HYM+lKG2QqIEOjsCF
    5eZ/eK4Xnpjh/beErjAXh+WzvK33OfVXJ5NlM9/3N0d1iXxGQRqCu8umGXWYQkLr
    f1dYjJI6tE31j/a3wjRYY11VR8iUaviY0weKjkSqwQyX3hGuq2mU0SlXKw0YQe0C
    guS3zHPl1Ro4y4wzA+WTL9VltjxeRAhzaejOtDX5auhELGPHu41FViT17KhIgyhK
    zHZQ3YKDP29aWJttnoyF7yvLlmkFXYhb+ELiPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710298; bh=I20OdIFS43CQN/pxdt9B5OIJHO
    rohRXz9I7I6kNdT0E=; b=GYh9GB/t//Zs1XEa8PqGuoM1gawJzQvVqMyx/z4spn
    uo0zSLb5yxt+XiZA7aOlwzaDFYQ+k2vRgJUM2sKMx/V2pA+QBnCYLHKORFn8Daav
    2m9XoFbiZT9S0pxbI1tjultxRVsIbjm+6oLAQHaJUF/4n/G/Dm3ElkXZsiDz+UwY
    gRnS6Er0dTzU9T000hh9WPsjZ3dSagNRnQGCI3Fe4UQR/LM7Kq4sOkgS6sx8e8AZ
    ac8nshDApGd74h2NpaFo8JvukUkz763gV/Mq8naTrM2ZV8fCTk2Wfa9wwi8npt+C
    y91a7AFfcgLbaCRQ4vnBPpMYtTDA9mCov66j73asg3tQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424838AbeBOPrL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424796AbeBOPrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 186/202] lib/ubsan: add type mismatch handler for new GCC/Clang
Date: Thu, 15 Feb 2018 16:18:06 +0100
Message-Id: <20180215151722.538682321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
