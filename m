Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BAAC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F4218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfAXAvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:51:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:37564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbfAXAvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:51:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98A01AFCB;
        Thu, 24 Jan 2019 00:51:47 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>
Subject: [PATCH 1/6] perf script python: Add trace_context extension module to sys,modules
Date:   Wed, 23 Jan 2019 16:52:24 -0800
Message-Id: <20190124005229.16146-2-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Python3,  the result of PyModule_Create (called from
scripts/python/Perf-Trace-Util/Context.c) is not automatically added to
sys.modules.  See: https://bugs.python.org/issue4592

Below is the observed behavior without the fix:

# ldd /usr/bin/perf | grep -i python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

# perf record /bin/false
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.015 MB perf.data (17 samples) ]

# perf script -g python | cat
generated Python script: perf-script.py

# perf script -s ./perf-script.py
Traceback (most recent call last):
  File "./perf-script.py", line 18, in <module>
    from perf_trace_context import *
ModuleNotFoundError: No module named 'perf_trace_context'
Error running python script ./perf-script.py

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Fixes: 66dfdff03d196e51322c6a85c0d8db8bb2bdd655
---
 tools/perf/util/scripting-engines/trace-event-python.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 87ef16a1b17e..40300d8e80a7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1494,6 +1494,7 @@ static void _free_command_line(wchar_t **command_line, int num)
 static int python_start_script(const char *script, int argc, const char **argv)
 {
 	struct tables *tables = &tables_global;
+	PyMODINIT_FUNC (*initfunc)(void);
 #if PY_MAJOR_VERSION < 3
 	const char **command_line;
 #else
@@ -1504,24 +1505,25 @@ static int python_start_script(const char *script, int argc, const char **argv)
 	FILE *fp;
 
 #if PY_MAJOR_VERSION < 3
+	initfunc = initperf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(const char *));
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 #else
+	initfunc = PyInit_perf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
 #endif
 
+	PyImport_AppendInittab("perf_trace_context", initfunc);
 	Py_Initialize();
 
 #if PY_MAJOR_VERSION < 3
-	initperf_trace_context();
 	PySys_SetArgv(argc + 1, (char **)command_line);
 #else
-	PyInit_perf_trace_context();
 	PySys_SetArgv(argc + 1, command_line);
 #endif
 
-- 
2.20.1

