Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755968AbeEHV2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:28:54 -0400
Received: from a8-61.smtp-out.amazonses.com ([54.240.8.61]:51214 "EHLO
        a8-61.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756049AbeEHV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:51 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 8/8] perf tests: Add Python 3 support to attr.py
Date: Tue, 8 May 2018 21:27:50 +0000
Message-ID: <0100016341a7413b-a8e15991-fe45-42e9-9209-8143734f0511-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.61
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in attr.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 tools/perf/tests/attr.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index ff9b60b99f52..15fbf38450fe 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,6 +1,8 @@
 #! /usr/bin/python
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 import glob
@@ -8,7 +10,11 @@ import optparse
 import tempfile
 import logging
 import shutil
-import ConfigParser
+try:
+    import ConfigParser as configparser
+except ImportError:
+    # Python 3 renamed ConfigParser to configparser
+    import configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
@@ -100,23 +106,23 @@ class Event(dict):
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
-		log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
+                log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
 
 # Test file description needs to have following sections:
 # [config]
@@ -134,7 +140,7 @@ class Event(dict):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = ConfigParser.SafeConfigParser()
+        parser = configparser.SafeConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -193,7 +199,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = ConfigParser.SafeConfigParser()
+        parser_event = configparser.SafeConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -207,7 +213,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = ConfigParser.SafeConfigParser()
+                parser_base = configparser.SafeConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
@@ -322,9 +328,9 @@ def run_tests(options):
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
@@ -373,7 +379,7 @@ def main():
     setup_log(options.verbose)
 
     if not options.test_dir:
-        print 'FAILED no -d option specified'
+        print('FAILED no -d option specified')
         sys.exit(-1)
 
     if not options.test:
@@ -382,8 +388,8 @@ def main():
     try:
         run_tests(options)
 
-    except Fail, obj:
-        print "FAILED %s" % obj.getMsg();
+    except Fail as obj:
+        print("FAILED %s" % obj.getMsg())
         sys.exit(-1)
 
     sys.exit(0)
-- 
2.17.0
