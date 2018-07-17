Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A708ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5AA20673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5AA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:41:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36366 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbeGQTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:41:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so1113058qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LbCNtMp3ZsfgI8UnlAz44oYqZ/1Nmg9HG+G+ZrVYfUc=;
        b=oUu3efYWOZxWQfUiBN5RJgigWCeabkUoVVESGDJWKiOQqaoczF6ylmwKxCHOGhHs/X
         g9iB6Yix28HxAwidwvoTx4dHoIcGXVU8hpYGLCtfzgQVvco/l/Xel9JWZQPDzB3Sut26
         S1zrE26S9907Qe8nvdYPtLXuIuyzg/jDzpOtq2B8I+ZK7xRrPcKWiH4gQEm+EScgcAn9
         vMqLDFtuTxv7QTLqHmTpMuhehFH2DsBdfA9Do8jv7EifkZ51zwcEP/SJNTBaPm+70uUa
         9LBtpLCB4Q/88/enx7EZC17knFMHBGhMeJ9XraQ5WcWU7Y6h6VG/Xdt2ZE/5pjImiWoC
         GVxw==
X-Gm-Message-State: AOUpUlGvatxDdjZVzffn2RdmuimdusI52NZ8xtwgnZc2pj8jvRrKeBEp
        o/ZiFv+Ruf5r2AysHey9IkBK+Q==
X-Google-Smtp-Source: AAOMgpf3QLToKDQu6PKGg0qp8SL9jRQsgjDkLBrpvowY8egvYY/qIUuBnoumyDsDrzW7SyIU9UGrQQ==
X-Received: by 2002:a37:1741:: with SMTP id i62-v6mr2674011qkh.147.1531854430186;
        Tue, 17 Jul 2018 12:07:10 -0700 (PDT)
Received: from laptop.jcline.org.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id u8-v6sm1581080qtc.76.2018.07.17.12.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 12:07:09 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] scripts: Add Python 3 compatibility to spdxcheck.py
Date:   Tue, 17 Jul 2018 15:06:35 -0400
Message-Id: <20180717190635.29467-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"dict.has_key(key)" on dictionaries has been replaced with "key in
dict". Additionally, when run under Python 3 some files don't decode
with the default encoding (tested with UTF-8). To handle that, don't
open the file in text mode and decode text line-by-line, ignoring
encoding errors.

This remains compatible with Python 2 and should have no functional
change.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 scripts/spdxcheck.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index a6041f29b18e..839e190bbd7a 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -4,6 +4,7 @@
 
 from argparse import ArgumentParser
 from ply import lex, yacc
+import locale
 import traceback
 import sys
 import git
@@ -102,7 +103,7 @@ class id_parser(object):
                 raise ParserException(tok, 'Invalid License ID')
             self.lastid = id
         elif tok.type == 'EXC':
-            if not self.spdx.exceptions.has_key(id):
+            if id not in self.spdx.exceptions:
                 raise ParserException(tok, 'Invalid Exception ID')
             if self.lastid not in self.spdx.exceptions[id]:
                 raise ParserException(tok, 'Exception not valid for license %s' %self.lastid)
@@ -167,6 +168,7 @@ class id_parser(object):
         self.curline = 0
         try:
             for line in fd:
+                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
                 self.curline += 1
                 if self.curline > maxlines:
                     break
@@ -201,7 +203,8 @@ def scan_git_tree(tree):
             continue
         if not os.path.isfile(el.path):
             continue
-        parser.parse_lines(open(el.path), args.maxlines, el.path)
+        with open(el.path, 'rb') as fd:
+            parser.parse_lines(fd, args.maxlines, el.path)
 
 def scan_git_subtree(tree, path):
     for p in path.strip('/').split('/'):
-- 
2.17.1

