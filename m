Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A94218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151253;
	bh=STkCaeaoLUKKC1GqLXE4k0ArwE86MXG11+5KJXlFiB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Elds7p1uwImjvk+gu6guZKK6kO+/KLWPAUE2J9acy7vBXV61KsXVMzLMEs37/w6Sp
	 QoD4fXgB2O/gsvaM/J3ArZktQxs3itydZBqkpobFvspEVXy2VmAkrKhVxc+FXth4tK
	 ZKqL6+GuKM+1V5R6Tom+IH7p0tJK3SY4ULJpEPt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeLRQkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeLRQkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D9A21873;
        Tue, 18 Dec 2018 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151247;
        bh=STkCaeaoLUKKC1GqLXE4k0ArwE86MXG11+5KJXlFiB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TccdewbIwcR3EA36DgE8EhrNwYPSiCnygEr9S3B5DWX3pTWqSAK52+thL8HgDRLMw
         U5MpmFwEzqVNi4A2G3KlyV7UvmxvbW66A0w3m1ZHCXyk7AxSUpzILWZq0Ws5dIoB7a
         h+eia8cL6oVSY5973eoEz0LCnKKoSermOpTzXuOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Jeremy Cline <jcline@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 10/44] scripts/spdxcheck.py: always open files in binary mode
Date:   Tue, 18 Dec 2018 17:39:22 +0100
Message-Id: <20181218163928.707844067@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

commit 3a6ab5c7dc114057fd67750e308e1745dafc0e6a upstream.

The spdxcheck script currently falls over when confronted with a binary
file (such as Documentation/logo.gif).  To avoid that, always open files
in binary mode and decode line-by-line, ignoring encoding errors.

One tricky case is when piping data into the script and reading it from
standard input.  By default, standard input will be opened in text mode,
so we need to reopen it in binary mode.

The breakage only happens with python3 and results in a
UnicodeDecodeError (according to Uwe).

Link: http://lkml.kernel.org/r/20181212131210.28024-1-thierry.reding@gmail.com
Fixes: 6f4d29df66ac ("scripts/spdxcheck.py: make python3 compliant")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Jeremy Cline <jcline@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Joe Perches <joe@perches.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/spdxcheck.py |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -168,6 +168,7 @@ class id_parser(object):
         self.curline = 0
         try:
             for line in fd:
+                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
                 self.curline += 1
                 if self.curline > maxlines:
                     break
@@ -249,12 +250,13 @@ if __name__ == '__main__':
 
     try:
         if len(args.path) and args.path[0] == '-':
-            parser.parse_lines(sys.stdin, args.maxlines, '-')
+            stdin = os.fdopen(sys.stdin.fileno(), 'rb')
+            parser.parse_lines(stdin, args.maxlines, '-')
         else:
             if args.path:
                 for p in args.path:
                     if os.path.isfile(p):
-                        parser.parse_lines(open(p), args.maxlines, p)
+                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
                     elif os.path.isdir(p):
                         scan_git_subtree(repo.head.reference.commit.tree, p)
                     else:


