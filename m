Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421AFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1C20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1C20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbeGJS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbeGJS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13016DB4;
        Tue, 10 Jul 2018 18:26:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, fenghua.yu@intel.com,
        yu-cheng.yu@intel.com, Ingo Molnar <mingo@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 03/23] x86/boot: Fix early command-line parsing when matching at end
Date:   Tue, 10 Jul 2018 20:24:36 +0200
Message-Id: <20180710182309.025696403@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 02afeaae9843733a39cd9b11053748b2d1dc5ae7 upstream.

The x86 early command line parsing in cmdline_find_option_bool() is
buggy. If it matches a specified 'option' all the way to the end of the
command-line, it will consider it a match.

For instance,

  cmdline = "foo";
  cmdline_find_option_bool(cmdline, "fool");

will return 1. This is particularly annoying since we have actual FPU
options like "noxsave" and "noxsaves" So, command-line "foo bar noxsave"
will match *BOTH* a "noxsave" and "noxsaves". (This turns out not to be
an actual problem because "noxsave" implies "noxsaves", but it's still
confusing.)

To fix this, we simplify the code and stop tracking 'len'. 'len'
was trying to indicate either the NULL terminator *OR* the end of a
non-NULL-terminated command line at 'COMMAND_LINE_SIZE'. But, each of the
three states is *already* checking 'cmdline' for a NULL terminator.

We _only_ need to check if we have overrun 'COMMAND_LINE_SIZE', and that
we can do without keeping 'len' around.

Also add some commends to clarify what is going on.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: yu-cheng.yu@intel.com
Link: http://lkml.kernel.org/r/20151222225238.9AEB560C@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/lib/cmdline.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -21,12 +21,14 @@ static inline int myisspace(u8 c)
  * @option: option string to look for
  *
  * Returns the position of that @option (starts counting with 1)
- * or 0 on not found.
+ * or 0 on not found.  @option will only be found if it is found
+ * as an entire word in @cmdline.  For instance, if @option="car"
+ * then a cmdline which contains "cart" will not match.
  */
 int cmdline_find_option_bool(const char *cmdline, const char *option)
 {
 	char c;
-	int len, pos = 0, wstart = 0;
+	int pos = 0, wstart = 0;
 	const char *opptr = NULL;
 	enum {
 		st_wordstart = 0,	/* Start of word/after whitespace */
@@ -37,11 +39,14 @@ int cmdline_find_option_bool(const char
 	if (!cmdline)
 		return -1;      /* No command line */
 
-	len = min_t(int, strlen(cmdline), COMMAND_LINE_SIZE);
-	if (!len)
+	if (!strlen(cmdline))
 		return 0;
 
-	while (len--) {
+	/*
+	 * This 'pos' check ensures we do not overrun
+	 * a non-NULL-terminated 'cmdline'
+	 */
+	while (pos < COMMAND_LINE_SIZE) {
 		c = *(char *)cmdline++;
 		pos++;
 
@@ -58,17 +63,26 @@ int cmdline_find_option_bool(const char
 			/* fall through */
 
 		case st_wordcmp:
-			if (!*opptr)
+			if (!*opptr) {
+				/*
+				 * We matched all the way to the end of the
+				 * option we were looking for.  If the
+				 * command-line has a space _or_ ends, then
+				 * we matched!
+				 */
 				if (!c || myisspace(c))
 					return wstart;
 				else
 					state = st_wordskip;
-			else if (!c)
+			} else if (!c) {
+				/*
+				 * Hit the NULL terminator on the end of
+				 * cmdline.
+				 */
 				return 0;
-			else if (c != *opptr++)
+			} else if (c != *opptr++) {
 				state = st_wordskip;
-			else if (!len)		/* last word and is matching */
-				return wstart;
+			}
 			break;
 
 		case st_wordskip:


