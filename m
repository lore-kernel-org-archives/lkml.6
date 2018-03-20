Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCTGfU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:35:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCTGfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:35:17 -0400
Date: Mon, 19 Mar 2018 23:34:54 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b7a313d84e853049062011d78cb04b6decd12f5c@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        sergey.senozhatsky.work@gmail.com, hpa@zytor.com, acme@redhat.com,
        dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
        sergey.senozhatsky.work@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jpoimboe@redhat.com, peterz@infradead.org, jolsa@kernel.org,
        acme@redhat.com, dsahern@gmail.com, namhyung@kernel.org
In-Reply-To: <20180319082902.4518-2-jolsa@kernel.org>
References: <20180319082902.4518-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix python extension build for gcc 8
Git-Commit-ID: b7a313d84e853049062011d78cb04b6decd12f5c
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

Commit-ID:  b7a313d84e853049062011d78cb04b6decd12f5c
Gitweb:     https://git.kernel.org/tip/b7a313d84e853049062011d78cb04b6decd12f5c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 19 Mar 2018 09:29:02 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Mar 2018 13:39:46 -0300

perf tools: Fix python extension build for gcc 8

The gcc 8 compiler won't compile the python extension code with the
following errors (one example):

  python.c:830:15: error: cast between incompatible  function types from              \
  ‘PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)’                       \
  uct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object *)’} to     \
  ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _objeuct \
  _object *)’} [-Werror=cast-function-type]
     .ml_meth  = (PyCFunction)pyrf_evsel__open,

The problem with the PyMethodDef::ml_meth callback is that its type is
determined based on the PyMethodDef::ml_flags value, which we set as
METH_VARARGS | METH_KEYWORDS.

That indicates that the callback is expecting an extra PyObject* arg, and is
actually PyCFunctionWithKeywords type, but the base PyMethodDef::ml_meth type
stays PyCFunction.

Previous gccs did not find this, gcc8 now does. Fixing this by silencing this
warning for python.c build.

Commiter notes:

Do not do that for CC=clang, as it breaks the build in some clang
versions, like the ones in fedora up to fedora27:

  fedora:25:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  fedora:26:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  fedora:27:error: unknown warning option '-Wno-cast-function-type'; did you mean '-Wno-bad-function-cast'? [-Werror,-Wunknown-warning-option]
  #

those have:

  clang version 3.9.1 (tags/RELEASE_391/final)

The one in rawhide accepts that:

  clang version 6.0.0 (tags/RELEASE_600/final)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Link: http://lkml.kernel.org/r/20180319082902.4518-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 6891635b50c3..001be4f9d3b9 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -28,6 +28,8 @@ class install_lib(_install_lib):
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+if cc != "clang":
+    cflags += ['-Wno-cast-function-type' ]
 
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
