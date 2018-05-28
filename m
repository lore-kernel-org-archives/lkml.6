Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeE1Brp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:47:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32815 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753009AbeE1BrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:47:16 -0400
X-ME-Proxy: <xmx:pF8LW-I0A2wWNCb6QPGhGOJoWdwOiF6bdRf5h_cWUbz5buD3aZ8Ovw>
X-ME-Proxy: <xmx:pF8LW0HZEsMBgtO_t1nhzGlGH9mopW0FTqfQg7dChfdVaPIrhgtkiQ>
X-ME-Proxy: <xmx:pF8LW2Rk6Y1dpI0cMno218CG4KKPdnTBVI55wp8V7-6nYfM7b8DRQA>
X-ME-Proxy: <xmx:pF8LWwGCWf7p2ieRaXvs58Z2lixHHeuES0JLsPj1_RZ8fUJeLdSyZQ>
X-ME-Proxy: <xmx:pF8LWy_zaUl_o3LNwneHsm-IVY8wKxow2fK6mgN0-d8F-NRXayk_lQ>
X-ME-Proxy: <xmx:pF8LW1blhTU2jWUo7S7TIDSyB2LUZao6DmhoihnMBVoY2DJ8wD7S9A>
X-ME-Sender: <xms:pF8LW0Is2a4_0KMCweHsJOXjwsLjPcthD3FuV2LJAng4Lf4zhq8f3w>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] vsprintf: Use hw RNG for ptr_key
Date: Mon, 28 May 2018 11:46:41 +1000
Message-Id: <1527472002-11571-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 23920c5ff728..1545a8aa26a9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1693,8 +1693,16 @@ static struct random_ready_callback random_ready = {
 
 static int __init initialize_ptr_random(void)
 {
-	int ret = add_random_ready_callback(&random_ready);
+	int key_size = sizeof(ptr_key);
+	int ret;
+
+	/* Use hw RNG if available */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		static_branch_disable(&not_filled_random_ptr_key);
+		return 0;
+	}
 
+	ret = add_random_ready_callback(&random_ready);
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-- 
2.7.4
