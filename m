Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeEVRli (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:41:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32970 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeEVRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:41:37 -0400
X-Google-Smtp-Source: AB8JxZrX8xzPB2q2hb/FxhnQbzJ18LgHqIQ1jLft5uEei/Grm1CpzGvw83QnQ5nj+zP5/MjlaQYV8A==
From: Thierry Escande <thierry.escande@linaro.org>
To: "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lib/test_printf.c: call wait_for_random_bytes() before plain %p tests
Date: Tue, 22 May 2018 19:41:14 +0200
Message-Id: <20180522174114.9197-1-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the test_printf module is loaded before the crng is initialized, the
plain 'p' tests will fail because the printed address will not be hashed
and the buffer will contain '(ptrval)' instead.
This patch adds a call to wait_for_random_bytes() before plain 'p' tests
to make sure the crng is initialized.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---
 lib/test_printf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 71ebfa43ad05..839be9385a8a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -260,6 +260,13 @@ plain(void)
 {
 	int err;
 
+	/*
+	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
+	 * of a hashed address when printing '%p' in plain_hash() and
+	 * plain_format().
+	 */
+	wait_for_random_bytes();
+
 	err = plain_hash();
 	if (err) {
 		pr_warn("plain 'p' does not appear to be hashed\n");
-- 
2.14.1
