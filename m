Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58830C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291A2218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458391;
	bh=UhW/mLmojXICobc8Vz3+/Ias1yjPhM6vj8KFjHPvLPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zDEs3Hy3UQ7YHtv2C7+B/KunAO+a21a5amyR6fDLaXX/x0zJzSoHdegQPirZbMeim
	 t4K1a5VsYzp8YuENH1N1fRKq1NjmlPbjo6zYU4epXIr36bqn5uq10XUut6vnULW6M7
	 PuznuA1Sytx+7BzSYdYZD0A/gem+cMD5aHTXohvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfAYXTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfAYXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:42 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1E620844;
        Fri, 25 Jan 2019 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458381;
        bh=UhW/mLmojXICobc8Vz3+/Ias1yjPhM6vj8KFjHPvLPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFVmS+0ZqWXZZTqVOWDYamKG2HZiM/D1XsdPajndqXzAwHBvjywHwV5iCPC3KYdfr
         3hIRh7RHlE9zA/tdBB3ysSyFGMDdbLpl+coF5qksZNea9r9EVQr6E8pcNU5akAgppr
         e3kOy47iwy/YI2pp0UtCe9TgbCc7/dIZ5W+rv/HQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH 23/29] perf script python: Add Python3 support to tests/attr.py
Date:   Sat, 26 Jan 2019 00:18:37 +0100
Message-Id: <20190125231843.2895-24-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python 2 and Python 3 in tests/attr.py

The use of "except as" syntax implies the minimum supported Python2 version is
now v2.6

Committer testing:

  $ make -C tools/perf PYTHON3=python install-bin

Before:

  # perf test attr
  16: Setup struct perf_event_attr                          : FAILED!
  48: Synthesize attr update                                : Ok
  [root@quaco ~]# perf test -v attr
  16: Setup struct perf_event_attr                          :
  --- start ---
  test child forked, pid 3121
    File "/home/acme/libexec/perf-core/tests/attr.py", line 324
      except Unsup, obj:
                ^
  SyntaxError: invalid syntax
  test child finished with -1
  ---- end ----
  Setup struct perf_event_attr: FAILED!
  48: Synthesize attr update                                :
  --- start ---
  test child forked, pid 3124
  test child finished with 0
  ---- end ----
  Synthesize attr update: Ok
  #

After:

   # perf test attr
  16: Setup struct perf_event_attr                          : Ok
  48: Synthesize attr update                                : Ok
  #

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-7-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 3e07eee33b10..cb39ac46bc73 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 import glob
@@ -7,7 +9,11 @@ import optparse
 import tempfile
 import logging
 import shutil
-import ConfigParser
+
+try:
+    import configparser
+except ImportError:
+    import ConfigParser as configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
@@ -99,20 +105,20 @@ class Event(dict):
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s" % (t, self[t], other[t]));
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 return False
             if not data_equal(self[t], other[t]):
                 return False
         return True
 
     def optional(self):
-        if self.has_key('optional') and self['optional'] == '1':
+        if 'optional' in self and self['optional'] == '1':
             return True
         return False
 
     def diff(self, other):
         for t in Event.terms:
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 continue
             if not data_equal(self[t], other[t]):
                 log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
@@ -133,7 +139,7 @@ class Event(dict):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = ConfigParser.SafeConfigParser()
+        parser = configparser.SafeConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -192,7 +198,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = ConfigParser.SafeConfigParser()
+        parser_event = configparser.SafeConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -206,7 +212,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = ConfigParser.SafeConfigParser()
+                parser_base = configparser.SafeConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
@@ -321,9 +327,9 @@ def run_tests(options):
     for f in glob.glob(options.test_dir + '/' + options.test):
         try:
             Test(f, options).run()
-        except Unsup, obj:
+        except Unsup as obj:
             log.warning("unsupp  %s" % obj.getMsg())
-        except Notest, obj:
+        except Notest as obj:
             log.warning("skipped %s" % obj.getMsg())
 
 def setup_log(verbose):
@@ -362,7 +368,7 @@ def main():
     parser.add_option("-p", "--perf",
                       action="store", type="string", dest="perf")
     parser.add_option("-v", "--verbose",
-                      action="count", dest="verbose")
+                      default=0, action="count", dest="verbose")
 
     options, args = parser.parse_args()
     if args:
@@ -372,7 +378,7 @@ def main():
     setup_log(options.verbose)
 
     if not options.test_dir:
-        print 'FAILED no -d option specified'
+        print('FAILED no -d option specified')
         sys.exit(-1)
 
     if not options.test:
@@ -381,8 +387,8 @@ def main():
     try:
         run_tests(options)
 
-    except Fail, obj:
-        print "FAILED %s" % obj.getMsg();
+    except Fail as obj:
+        print("FAILED %s" % obj.getMsg())
         sys.exit(-1)
 
     sys.exit(0)
-- 
2.20.1

