Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC3ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8FF2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DvIs5Aai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8FF2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeIQCh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 22:37:26 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:38768 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeIQChZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 22:37:25 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1537132384;
        bh=cGDDdjfYQ05YghVXadQrS3siG3+vlOrYileDnCJKo04=;
        h=From:To:Cc:Subject:Date:From;
        b=DvIs5AaiXZxTO/JEw5zZsQ3+pQgD6GvMsIe4xTJiYYBAEz8KRY7Ejws1eps+qjeR9
         IbWACWpJ3437FKzL+dCgwCyPH90QwzGwN4p0R5DtIH3vBlO/thK8A3GegRVL4LLfUH
         zO3WgfRG7YbRwb18sF1ljTZ5q+xHrtVnOzGRiaFo=
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] scripts/spdxcheck.py: improve Python 3 compat
Date:   Sun, 16 Sep 2018 23:12:41 +0200
Message-Id: <20180916211241.7836-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading lines from a text-mode fd strings are returned.
These can not be decoded again into strings, breaking the logic in
parser.
Just make sure all files are opened in binary mode on Python 3, so the
current logic keeps working.

This remains compatible with Python 2 and should have no functional
change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/spdxcheck.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 839e190bbd7a..8f472f995d70 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -250,12 +250,15 @@ if __name__ == '__main__':
 
     try:
         if len(args.path) and args.path[0] == '-':
-            parser.parse_lines(sys.stdin, args.maxlines, '-')
+            parser.parse_lines(
+                    # always get the binary fd
+                    getattr(sys.stdin, 'buffer', sys.stdin),
+                    args.maxlines, '-')
         else:
             if args.path:
                 for p in args.path:
                     if os.path.isfile(p):
-                        parser.parse_lines(open(p), args.maxlines, p)
+                        parser.parse_lines(open(p, 'rb'), args.maxlines, p)
                     elif os.path.isdir(p):
                         scan_git_subtree(repo.head.reference.commit.tree, p)
                     else:
-- 
2.18.0

