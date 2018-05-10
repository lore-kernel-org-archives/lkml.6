Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZoyjUMdj8xcFk1JaYwMMjOi9m62IhuIQltH4a0qG55XO3eL2jouy+n26vg1B7Xgm57h8wap
ARC-Seal: i=1; a=rsa-sha256; t=1525923581; cv=none;
        d=google.com; s=arc-20160816;
        b=wuXXl3zyxmO7UI3qgOFMo9412EfzisslymCyyc1niFImmHw2F4IFGNpqvAklO9wtnp
         Jh4+9nmw/UWwEzq7TaUwfg30B+hbilaWbJdOlvN8NwxtMgW3f5eo4Pchpel6m25EMrJz
         xr0Kd4VqniRV2gnnJDQdBntA+nIUzVKzt3/wRT853qSvwUXCiyAWV8uQrHSk4CjCX2a+
         AMy0qmk7LH/MbYT4fvI6aZwr1NxjjX9ZyMZk592GNbMvCdZgwzpTLsY6C9Ubf68Lb3CV
         EJiarOr8yYG65i+/Do/LWz+cYbgaGrhd1iwcUBUCpHL9/iP1OsXINCKpsGhFPzKAvA++
         0hlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wveKsZEOfx8HStfcNqzeGbrrLvp41ngTET1wGW6fnA0=;
        b=dj8tIKZRBX2C3sIqE+h+iXpEIUy4JY3uRMkOW5JoCK3HFKbPZcxUeaVzk/CSR1lI0C
         pBXIW0UpDgbpMmOtCdRAUmMntIa97aU3hJNHLwXy434n4d8G3CRojioXKtGJG08+l0wt
         QsFU2UVQq2tGFi4wW65lyW8ztYFFUhmsqCRUVoUlvBVj4rG659cpS5X7mvnMRZozHuQG
         BPGLL+5FRveGJp6bpv9yQuF/ccz9kXSmP8rJkJ1LDPQBrEtmh4d1ISU9PMP7B4yky3IF
         iIad8Z2aPofXyKbwmhYh1px8iR6DhhJkwp28B/a7AIhlv3dvGA7Xj3tLV4cJUaely6M3
         cGOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH 1/3] objtool: Fix "noreturn" detection for recursive sibling calls
Date: Wed,  9 May 2018 22:39:14 -0500
Message-Id: <7cc156408c5781a1f62085d352ced1fe39fe2f91.1525923412.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1525923412.git.jpoimboe@redhat.com>
References: <cover.1525923412.git.jpoimboe@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046845024948230?=
X-GMAIL-MSGID: =?utf-8?q?1600046845024948230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Objtool has some crude logic for detecting static "noreturn" functions
(aka "dead ends").  This is necessary for being able to correctly follow
GCC code flow when such functions are called.

It's remotely possible for two functions to call each other via sibling
calls.  If they don't have RET instructions, objtool's noreturn
detection logic goes into a recursive loop:

  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)

Instead of reporting an error in this case, consider the functions to be
non-dead-ends.

Reported-and-tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f6c48d..264522d4e4af 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -190,9 +190,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					continue;
 
 				if (recursion == 5) {
-					WARN_FUNC("infinite recursion (objtool bug!)",
-						  dest->sec, dest->offset);
-					return -1;
+					/*
+					 * Infinite recursion: two functions
+					 * have sibling calls to each other.
+					 * This is a very rare case.  It means
+					 * they aren't dead ends.
+					 */
+					return 0;
 				}
 
 				return __dead_end_function(file, dest_func,
-- 
2.17.0
