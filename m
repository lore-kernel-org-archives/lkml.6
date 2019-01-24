Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1405CC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1EA218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfAXAwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:52:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:37670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfAXAwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:52:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47763AFCB;
        Thu, 24 Jan 2019 00:52:08 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 6/6] perf script python: add Python3 support to tests/attr.py
Date:   Wed, 23 Jan 2019 16:52:29 -0800
Message-Id: <20190124005229.16146-7-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in tests/attr.py

The use of "except as" syntax implies the minimum supported Python2 version is
now v2.6

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc: Jiri Olsa <jolsa@redhat.com>
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

