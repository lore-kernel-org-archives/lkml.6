Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBDRpr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:45:47 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:57352 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeBDRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:45:41 -0500
From: Adam Borowski <kilobyte@angband.pl>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>
Date: Sun,  4 Feb 2018 18:45:21 +0100
Message-Id: <20180204174521.21383-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.15.1
X-SA-Exim-Connect-IP: 89.71.161.30
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH] vsprintf: avoid misleading "(null)" for %px
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like %pK already does, print "00000000" instead.

This confused people -- the convention is that "(null)" means you tried to
dereference a null pointer as opposed to printing the address.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 77ee6ced11b1..d7a708f82559 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 {
 	const int default_width = 2 * sizeof(void *);
 
-	if (!ptr && *fmt != 'K') {
+	if (!ptr && *fmt != 'K' && *fmt != 'x') {
 		/*
 		 * Print (null) with the same width as a pointer so it makes
 		 * tabular output look nice.
-- 
2.15.1
