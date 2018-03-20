Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCTGhG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:37:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeCTGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:37:01 -0400
Date: Mon, 19 Mar 2018 23:36:44 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-854e55ad289ef8888e7991f0ada85d5846f5afb9@git.kernel.org>
Cc: wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        jpoimboe@redhat.com, jolsa@kernel.org, labbott@redhat.com,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org
Reply-To: wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        jpoimboe@redhat.com, labbott@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com
In-Reply-To: <20180316031154.juk2uncs7baffctp@treble>
References: <20180316031154.juk2uncs7baffctp@treble>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] objtool, perf: Fix GCC 8 -Wrestrict error
Git-Commit-ID: 854e55ad289ef8888e7991f0ada85d5846f5afb9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  854e55ad289ef8888e7991f0ada85d5846f5afb9
Gitweb:     https://git.kernel.org/tip/854e55ad289ef8888e7991f0ada85d5846f5afb9
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 15 Mar 2018 22:11:54 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:51:54 -0300

objtool, perf: Fix GCC 8 -Wrestrict error

Starting with recent GCC 8 builds, objtool and perf fail to build with
the following error:

  ../str_error_r.c: In function ‘str_error_r’:
  ../str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
     snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);

The code seems harmless, but there's probably no benefit in printing the
'buf' pointer in this situation anyway, so just remove it to make GCC
happy.

Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180316031154.juk2uncs7baffctp@treble
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/str_error_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
index d6d65537b0d9..6aad8308a0ac 100644
--- a/tools/lib/str_error_r.c
+++ b/tools/lib/str_error_r.c
@@ -22,6 +22,6 @@ char *str_error_r(int errnum, char *buf, size_t buflen)
 {
 	int err = strerror_r(errnum, buf, buflen);
 	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
+		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
 	return buf;
 }
