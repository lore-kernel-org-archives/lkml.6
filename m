Return-Path: <niveditas98@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518134415; cv=none;
        d=google.com; s=arc-20160816;
        b=YwwMNw2E67au0DurFG2jsZEX5Ez0rJqBmMiOWIaPB9aq5IAxZot1EF/dTItb0KC8xc
         +MccLMKrmLTXgR/9tzk2NVO3/cGJYM9QKAIC3ubvAAi1bUwI/50M+qyJl5JznvtpbeNS
         zyyuUZjAUW4oBo13zgYpQLCJi1qT+Vcy+ivhMi/hokA6laRgcX0wm0v2jjpGtZVXxKQw
         6NIlkEZf3G15IsP0yvG5Pea3fPBJrl2sdneS0DlrK1IH1Up6ii1ned+JBDddIit/w3tu
         MQY9XHa4zBAn4wmYULqxcJyh2DCt+7ciJW9kxs4OGtCTKsAqWwFVKcVVF0zYGjMeTt1W
         6JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ERoW/LoC8fOaRzaUh8Vm9rRUerr56NktfU4uEm3k+vw=;
        b=QKD/JwXwZDZO2j2COciXrhcfMbCtxVOU30krdyDKOQN7f3M8jzsUsfrF3ohjOc9lxF
         dL1Lja2wvzNJGx1NOYMhypYquT/KERR+glIW02+QOk8WhifCYj6PmCqH6koH/nyLbpPv
         bLYZKe79AOpEwv659U8b+4JiuJbbhPA1Oua4hxWIRYR/EKtemxhQCOTfjMsRUAt6U0+S
         8k9RAz06W2j7JZojMZjFqlAO78attae9p2cPPy8xvLfP2xuY+GiYrojSwA1bQz3NMBm6
         RkWMGlSE7jTogwQnKvoz0Zvr/MEqY8oWuy02cBkVpV5k81iKJNqyPGxBiFrXQ9rs1Kqt
         G12w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of niveditas98@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=niveditas98@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of niveditas98@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=niveditas98@gmail.com
X-Google-Smtp-Source: AH8x226yPaKx55BxNzEKJqj1oTxVSrt5L5SStHFJrwt6ubu43qfLW3YUwrF9ys2bGtH+Tt1HjugtdQ==
Date: Thu, 8 Feb 2018 19:00:10 -0500
From: Arvind Sankar <nivedita@alum.mit.edu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] tools: libsubcmd: Drop the less hack that was inherited
 from Git.
Message-ID: <20180209000009.GA54330@rani.riverdale>
References: <20180124003831.GA34667@rani.riverdale>
 <20180124205411.lpzcpqnuw3nlyg4n@treble>
 <20180125081652.GA23548@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125081652.GA23548@kernel.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432180841544172?=
X-GMAIL-MSGID: =?utf-8?q?1591879312939612300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We inherited this hack with the original code from the Git project. The
select call is invalid as the two fd_set pointers should not be aliased.

We could fix it, but the Git project removed this hack in 2012 in commit
e8320f3 (pager: drop "wait for output to run less" hack). The bug it
worked around was apparently fixed in less back in June 2007.

So remove the hack from here as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 - Merge with commit ad343a98 (tools/lib/subcmd/pager.c: do not alias
   select() params) by Sergey

 tools/lib/subcmd/pager.c       | 20 --------------------
 tools/lib/subcmd/run-command.c |  2 --
 tools/lib/subcmd/run-command.h |  1 -
 3 files changed, 23 deletions(-)

diff --git a/tools/lib/subcmd/pager.c b/tools/lib/subcmd/pager.c
index 9997a8805a82..94d61d9b511f 100644
--- a/tools/lib/subcmd/pager.c
+++ b/tools/lib/subcmd/pager.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <sys/select.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -23,24 +22,6 @@ void pager_init(const char *pager_env)
 	subcmd_config.pager_env = pager_env;
 }
 
-static void pager_preexec(void)
-{
-	/*
-	 * Work around bug in "less" by not starting it until we
-	 * have real input
-	 */
-	fd_set in;
-	fd_set exception;
-
-	FD_ZERO(&in);
-	FD_ZERO(&exception);
-	FD_SET(0, &in);
-	FD_SET(0, &exception);
-	select(1, &in, NULL, &exception, NULL);
-
-	setenv("LESS", "FRSX", 0);
-}
-
 static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
 static struct child_process pager_process;
 
@@ -87,7 +68,6 @@ void setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	pager_process.preexec_cb = pager_preexec;
 
 	if (start_command(&pager_process))
 		return;
diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..9e9dca717ed7 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -120,8 +120,6 @@ int start_command(struct child_process *cmd)
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->preexec_cb)
-			cmd->preexec_cb();
 		if (cmd->exec_cmd) {
 			execv_cmd(cmd->argv);
 		} else {
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..6256268802b5 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -46,7 +46,6 @@ struct child_process {
 	unsigned no_stderr:1;
 	unsigned exec_cmd:1; /* if this is to be external sub-command */
 	unsigned stdout_to_stderr:1;
-	void (*preexec_cb)(void);
 };
 
 int start_command(struct child_process *);
-- 
2.13.6
