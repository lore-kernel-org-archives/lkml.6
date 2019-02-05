Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD444C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72700217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379267;
	bh=v6sJ01/xUDmVRWta9d6TYCoSX3XXz2i0lLDBRXVcAUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=csus8LLSPUB5E8dquYf+ChofhD8nRdcOhu9wixTp05jSs+PFcJVy/MTcOAuypcKcm
	 4m9AXaTT+1XimnRPtGcKefLfKkLtU0ttGgjcG873ebmxUiWKU3FB6XUsuL+CsK9iH8
	 t8k7MgOQpKnTBlRtGARFI1XWa4GuEU50LIKFMuGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfBEPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfBEPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:44 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01815217FA;
        Tue,  5 Feb 2019 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379263;
        bh=v6sJ01/xUDmVRWta9d6TYCoSX3XXz2i0lLDBRXVcAUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zom011P8zF/JkdTVTLMKo3yYi/2rthGCWO5AdI/PHVYrewhWMMkg1GS1MTzdDkfDH
         BoHsBb5BGcuPL0WH/OqfD7Q1lew9fXJFHZF9tvbvArNVEWnnzQSX2VX5Ng9wMzpAgl
         1kmziXv1WndPM9siHpydx5WZpr+6lacgBeXL3f24=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH 8/8] perf script python: Add Python3 support to tests/attr.py
Date:   Tue,  5 Feb 2019 12:07:08 -0300
Message-Id: <20190205150708.9012-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
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
index 44090a9a19f3..e952127e4fb0 100644
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
+
+try:
+    import configparser
+except ImportError:
+    import ConfigParser as configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
@@ -100,20 +106,20 @@ class Event(dict):
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
@@ -363,7 +369,7 @@ def main():
     parser.add_option("-p", "--perf",
                       action="store", type="string", dest="perf")
     parser.add_option("-v", "--verbose",
-                      action="count", dest="verbose")
+                      default=0, action="count", dest="verbose")
 
     options, args = parser.parse_args()
     if args:
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
2.20.1

