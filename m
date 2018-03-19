Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031823AbeCSTD4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970633AbeCSTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5CA21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/14] perf tools: Fix python extension build for gcc 8
Date: Mon, 19 Mar 2018 16:01:31 -0300
Message-Id: <20180319190136.7441-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.3
