Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeCSI30 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:29:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932510AbeCSI3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:29:07 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 2/2] perf tools: Fix python extension build for gcc 8
Date: Mon, 19 Mar 2018 09:29:02 +0100
Message-Id: <20180319082902.4518-2-jolsa@kernel.org>
In-Reply-To: <20180319082902.4518-1-jolsa@kernel.org>
References: <20180319082902.4518-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <root@riddick.tpb.lab.eng.brq.redhat.com>

The gcc 8 won't compile python extension code with
following errors (one example):

  python.c:830:15: error: cast between incompatible  function types from              \
  ‘PyObject * (*)(struct pyrf_evsel *, PyObject *, PyObject *)’                       \
  uct _object * (*)(struct pyrf_evsel *, struct _object *, struct _object *)’} to     \
  ‘PyObject * (*)(PyObject *, PyObject *)’ {aka ‘struct _object * (*)(struct _objeuct \
  _object *)’} [-Werror=cast-function-type]
     .ml_meth  = (PyCFunction)pyrf_evsel__open,

The problem with PyMethodDef::ml_meth callback is that
its type is determined based on PyMethodDef::ml_flags
value, which we set as METH_VARARGS | METH_KEYWORDS.

That indicates that the callback is expecting extra PyObject* arg,
and is actually PyCFunctionWithKeywords type, but the base
PyMethodDef::ml_meth type stays PyCFunction.

Previous gccs did not find this, gcc8 now does. Fixing
this by silencing this warning for python.c build.

Link: http://lkml.kernel.org/n/tip-gyl1jq6b27e9ad0wm9x4v1vr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 6891635b50c3..1a3fac37112d 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -27,7 +27,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-cast-function-type' ]
 
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
-- 
2.13.6
