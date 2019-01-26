Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9FC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF31218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfAZKHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:07:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:07:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA76dp513316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:07:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA75RY513313;
        Sat, 26 Jan 2019 02:07:05 -0800
Date:   Sat, 26 Jan 2019 02:07:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-72e0b15cb24a497d7d0d4707cf51ff40c185ae8c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, tonyj@suse.de,
        s1seetee@linux.vnet.ibm.com, mingo@kernel.org, corbet@lwn.net,
        hpa@zytor.com, ravi.bangoria@linux.ibm.com, jolsa@kernel.org,
        jskarvad@redhat.com, acme@redhat.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          tonyj@suse.de, mingo@kernel.org, s1seetee@linux.vnet.ibm.com,
          corbet@lwn.net, acme@redhat.com, jskarvad@redhat.com,
          ravi.bangoria@linux.ibm.com, jolsa@kernel.org
In-Reply-To: <20190124005229.16146-3-tonyj@suse.de>
References: <20190124005229.16146-3-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Use PyBytes for attr in
 trace-event-python
Git-Commit-ID: 72e0b15cb24a497d7d0d4707cf51ff40c185ae8c
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

Commit-ID:  72e0b15cb24a497d7d0d4707cf51ff40c185ae8c
Gitweb:     https://git.kernel.org/tip/72e0b15cb24a497d7d0d4707cf51ff40c185ae8c
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Wed, 23 Jan 2019 16:52:25 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf script python: Use PyBytes for attr in trace-event-python

With Python3.  PyUnicode_FromStringAndSize is unsafe to call on attr and will
return NULL.  Use _PyBytes_FromStringAndSize (as with raw_buf).

Below is the observed behavior without the fix.  Note it is first necessary
to apply the prior fix (Add trace_context extension module to sys,modules):

  # ldd /usr/bin/perf | grep -i python
          libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

  # perf record -e raw_syscalls:sys_enter /bin/false
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (21 samples) ]

  # perf script -g python | cat
  generated Python script: perf-script.py

  # perf script -s ./perf-script.py
  in trace_begin
  Segmentation fault (core dumped)

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20190124005229.16146-3-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 315905c748fa..7059d1be2d09 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -733,8 +733,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 		Py_FatalError("couldn't create Python dictionary");
 
 	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
-	pydict_set_item_string_decref(dict, "attr", _PyUnicode_FromStringAndSize(
-			(const char *)&evsel->attr, sizeof(evsel->attr)));
+	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->attr, sizeof(evsel->attr)));
 
 	pydict_set_item_string_decref(dict_sample, "pid",
 			_PyLong_FromLong(sample->pid));
