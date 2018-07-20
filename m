Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C14020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C14020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGTKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:17:39 -0400
Received: from www.osadl.org ([62.245.132.105]:47266 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbeGTKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:17:39 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6K9OWM9022331;
        Fri, 20 Jul 2018 11:24:32 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] kdb: use bool for binary state indicators
Date:   Fri, 20 Jul 2018 11:23:37 +0200
Message-Id: <1532078617-13767-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 defcmd_in_progress  is the state trace for command group processing
- within a command group or not -  usable  is an indicator if a command 
set is valid (allocated/non-empty) - so use a bool for those binary 
indication here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Found during code review.
Not a functional issue - just type correctness.

Patch was compile tested with: x86_64_defconfig + CONFIG_KGDB=y,
CONFIG_KGDB_KDB=y
(some sparse/smatch warnings not related to the proposed change though)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 kernel/debug/kdb/kdb_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index bb4fe4e..fda515a 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -658,7 +658,7 @@ static void kdb_cmderror(int diag)
  */
 struct defcmd_set {
 	int count;
-	int usable;
+	bool usable;
 	char *name;
 	char *usage;
 	char *help;
@@ -666,7 +666,7 @@ struct defcmd_set {
 };
 static struct defcmd_set *defcmd_set;
 static int defcmd_set_count;
-static int defcmd_in_progress;
+static bool defcmd_in_progress;
 
 /* Forward references */
 static int kdb_exec_defcmd(int argc, const char **argv);
@@ -676,9 +676,9 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
 	char **save_command = s->command;
 	if (strcmp(argv0, "endefcmd") == 0) {
-		defcmd_in_progress = 0;
+		defcmd_in_progress = false;
 		if (!s->count)
-			s->usable = 0;
+			s->usable = false;
 		if (s->usable)
 			/* macros are always safe because when executed each
 			 * internal command re-enters kdb_parse() and is
@@ -695,7 +695,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 	if (!s->command) {
 		kdb_printf("Could not allocate new kdb_defcmd table for %s\n",
 			   cmdstr);
-		s->usable = 0;
+		s->usable = false;
 		return KDB_NOTIMP;
 	}
 	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
@@ -737,7 +737,7 @@ static int kdb_defcmd(int argc, const char **argv)
 	       defcmd_set_count * sizeof(*defcmd_set));
 	s = defcmd_set + defcmd_set_count;
 	memset(s, 0, sizeof(*s));
-	s->usable = 1;
+	s->usable = true;
 	s->name = kdb_strdup(argv[1], GFP_KDB);
 	if (!s->name)
 		goto fail_name;
@@ -756,7 +756,7 @@ static int kdb_defcmd(int argc, const char **argv)
 		s->help[strlen(s->help)-1] = '\0';
 	}
 	++defcmd_set_count;
-	defcmd_in_progress = 1;
+	defcmd_in_progress = true;
 	kfree(save_defcmd_set);
 	return 0;
 fail_help:
-- 
2.1.4

