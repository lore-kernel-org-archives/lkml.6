Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeA3EBz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:01:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752596AbeA3EB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:01:27 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] objtool: Warn on stripped section symbol
Date: Mon, 29 Jan 2018 22:00:41 -0600
Message-Id: <dc4585a70d6b975c99fc51d1957ccdde7bd52f3a.1517284349.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1517284349.git.jpoimboe@redhat.com>
References: <cover.1517284349.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following fix:

  2a0098d70640 ("objtool: Fix seg fault with gold linker")

... a seg fault was avoided, but the original seg fault condition in
objtool wasn't fixed.  Replace the seg fault with an error message.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/orc_gen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index e61fe703197b..18384d9be4e1 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -98,6 +98,11 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
 	struct orc_entry *orc;
 	struct rela *rela;
 
+	if (!insn_sec->sym) {
+		WARN("missing symbol for section %s", insn_sec->name);
+		return -1;
+	}
+
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
-- 
2.14.3
