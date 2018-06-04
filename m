Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeFDHBj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbeFDHBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 30/52] kbuild: clang: disable unused variable warnings only when constant
Date: Mon,  4 Jun 2018 08:58:25 +0200
Message-Id: <20180604065607.775425030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sodagudi Prasad <psodagud@codeaurora.org>

commit 0a5f41767444cc3b4fc5573921ab914b4f78baaa upstream.

Currently, GCC disables -Wunused-const-variable, but not
-Wunused-variable, so warns unused variables if they are
non-constant.

While, Clang does not warn unused variables at all regardless of
the const qualifier because -Wno-unused-const-variable is implied
by the stronger option -Wno-unused-variable.

Disable -Wunused-const-variable instead of -Wunused-variable so that
GCC and Clang work in the same way.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -706,7 +706,6 @@ KBUILD_CFLAGS += $(stackp-flag)
 
 ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
@@ -724,9 +723,9 @@ else
 # These warnings generated too much noise in a regular build.
 # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 endif
 
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
