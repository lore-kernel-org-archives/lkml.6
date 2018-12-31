Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C5CC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CFB21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeLaHU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:58 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:41029 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbeLaHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:56 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 9B41240BCA;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 2/6] objtool: ignore instructions
Date:   Sun, 30 Dec 2018 23:21:08 -0800
Message-ID: <20181231072112.21051-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain cases there is a need to suppress objtool warnings on
specific instructions. Provide an interface to achieve this goal.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 tools/objtool/check.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..c890d714fb73 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -431,10 +431,11 @@ static int add_dead_ends(struct objtool_file *file)
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
-static void add_ignores(struct objtool_file *file)
+static int add_ignores(struct objtool_file *file)
 {
 	struct instruction *insn;
 	struct section *sec;
+	struct rela *rela;
 	struct symbol *func;
 
 	for_each_sec(file, sec) {
@@ -449,6 +450,20 @@ static void add_ignores(struct objtool_file *file)
 				insn->ignore = true;
 		}
 	}
+
+	sec = find_section_by_name(file->elf, ".rela.discard.ignore");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.ignore entry");
+			return -1;
+		}
+		insn->ignore = true;
+	}
+	return 0;
 }
 
 /*
@@ -1237,7 +1252,9 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	add_ignores(file);
+	ret = add_ignores(file);
+	if (ret)
+		return ret;
 
 	ret = add_nospec_ignores(file);
 	if (ret)
-- 
2.17.1

