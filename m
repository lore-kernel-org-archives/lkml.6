Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B952084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="LWTdsita"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B952084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGRJxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:53:19 -0400
Received: from services.gouders.net ([141.101.32.176]:33092 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbeGRJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:53:19 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6I9DuD7028581
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 18 Jul 2018 11:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531905247; bh=Ttig7I4bBJY7gQ+/MLdt4XgYmszpqezZ2QsOmkEC3UU=;
        h=From:To:Cc:Subject:Date;
        b=LWTdsitapnQ9qUkw6IhTbQ/YZa+DcUs7dJSLL5Ce13Z3k8dVXuv+hP9dhQSfevtoX
         Dv7tWF1xQdX7M7NBg1OJ01m2hycSBRf3Z/17ENRExqMBwI7pBefjIPPN8HMBgRPAoV
         Jg08S+PAcD/hR6x19MiwLDiuz+B5k+cYlsQm1YYo=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dirk Gouders <dirk@gouders.net>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: if_changed: document single use per target limitation
Date:   Wed, 18 Jul 2018 11:13:36 +0200
Message-Id: <20180718091336.4540-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of if_changed could easily feel invited to use it to divide a
recipe into parts like:

a: prereq FORCE
	$(call if_changed,do_a)
	$(call if_changed,do_b)

But this is problematic, because if_changed should not be used more
than once per target: in the above example, if_changed stores the
command-line of the given command in .a.cmd and when a is up-to-date
with respect to prereq, the file .a.cmd contains the command-line for
the last command executed, i.e. do_b.

When the recipe is then executed again, without any change of
prerequisites, the command-line check for do_a will fail, do_a will be
executed and stored in .a.cmd.  The next check, however, will still see
the old content (the file isn't re-read) and if_changed will skip
do_b, because the command-line test will not recognize a change.  On
the next execution of the recipe the roles will flip: do_a is OK but
do_b not and it will be executed.  And so on...

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/kbuild/makefiles.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 048fc39a6b91..01fae5a01ce7 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1105,6 +1105,12 @@ When kbuild executes, the following steps are followed (roughly):
 		target: source(s) FORCE
 	#WRONG!#	$(call if_changed, ld/objcopy/gzip/...)
 
+        Note: if_changed should not be used more than once per target.
+              It stores the executed command in a corresponding .cmd
+        file and multiple calls would result in overwrites and
+        unwanted results when the target is up to date and only the
+        tests on changed commands trigger execution of commands.
+
     ld
 	Link target. Often, LDFLAGS_$@ is used to set specific options to ld.
 
-- 
2.16.1

