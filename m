Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F3C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00D4217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfAZKGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:06:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:06:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA6QsT513247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:06:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA6PXt513244;
        Sat, 26 Jan 2019 02:06:25 -0800
Date:   Sat, 26 Jan 2019 02:06:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-cc437642255224e4140fed1f3e3156fc8ad91903@git.kernel.org>
Cc:     corbet@lwn.net, s1seetee@linux.vnet.ibm.com, tglx@linutronix.de,
        jskarvad@redhat.com, tonyj@suse.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, ravi.bangoria@linux.ibm.com, mingo@kernel.org,
        hpa@zytor.com, jolsa@kernel.org
Reply-To: ravi.bangoria@linux.ibm.com, hpa@zytor.com,
          s1seetee@linux.vnet.ibm.com, jskarvad@redhat.com,
          acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          corbet@lwn.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          tonyj@suse.de
In-Reply-To: <20190124005229.16146-2-tonyj@suse.de>
References: <20190124005229.16146-2-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add trace_context extension
 module to sys.modules
Git-Commit-ID: cc437642255224e4140fed1f3e3156fc8ad91903
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cc437642255224e4140fed1f3e3156fc8ad91903
Gitweb:     https://git.kernel.org/tip/cc437642255224e4140fed1f3e3156fc8ad91903
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Wed, 23 Jan 2019 16:52:24 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf script python: Add trace_context extension module to sys.modules

In Python3, the result of PyModule_Create (called from
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
  #

Committer notes:

To build with python3 use:

  $ make -C tools/perf PYTHON=python3

Use a non-const variable to pass the 'name' arg to
PyImport_AppendInittab(), as python2.6 has that as 'char *', which ends
up trowing this in some environments:

   CC       /tmp/build/perf/util/parse-branch-options.o
  util/scripting-engines/trace-event-python.c: In function 'python_start_script':
  util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
    PyImport_AppendInittab("perf_trace_context", initfunc);
    ^
  In file included from /usr/include/python2.6/Python.h:130:0,
                   from util/scripting-engines/trace-event-python.c:22:
  /usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
   PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
                   ^
  cc1: all warnings being treated as errors

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20190124005229.16146-2-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 87ef16a1b17e..315905c748fa 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1494,34 +1494,40 @@ static void _free_command_line(wchar_t **command_line, int num)
 static int python_start_script(const char *script, int argc, const char **argv)
 {
 	struct tables *tables = &tables_global;
+	PyMODINIT_FUNC (*initfunc)(void);
 #if PY_MAJOR_VERSION < 3
 	const char **command_line;
 #else
 	wchar_t **command_line;
 #endif
-	char buf[PATH_MAX];
+	/*
+	 * Use a non-const name variable to cope with python 2.6's
+	 * PyImport_AppendInittab prototype
+	 */
+	char buf[PATH_MAX], name[19] = "perf_trace_context";
 	int i, err = 0;
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
 
+	PyImport_AppendInittab(name, initfunc);
 	Py_Initialize();
 
 #if PY_MAJOR_VERSION < 3
-	initperf_trace_context();
 	PySys_SetArgv(argc + 1, (char **)command_line);
 #else
-	PyInit_perf_trace_context();
 	PySys_SetArgv(argc + 1, command_line);
 #endif
 
