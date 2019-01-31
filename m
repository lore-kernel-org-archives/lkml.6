Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14D2218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548963796;
	bh=4wBe6aFgZPk0Ev2EkzzYgkz/JYio51OvMPTEFAljdCI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wPr9Inn/BXfwxukBXk35ifuTh/Bqq6DZs2UQ1LHNsEnj3Dr/GA/DwTd22nZGwhGxY
	 1JdvdAem8auQCK+3mShx1MKAwMpl0Wyts1TGrsvx9UkMeJHZHJI1lKrOTaZUGVlZP1
	 yngZ1v30LcWe+agAwgjZnYe+Uv7EoIKwW3PRJJ6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfAaTnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfAaTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:43:14 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA34218EA;
        Thu, 31 Jan 2019 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548963793;
        bh=4wBe6aFgZPk0Ev2EkzzYgkz/JYio51OvMPTEFAljdCI=;
        h=From:To:Cc:Subject:Date:From;
        b=K6KIWRhlNkUevvJLQ4hziRedyap0PGh16MJM1sHKru4WfNnzM8hL9SU5jRdgHq8Hp
         SaaUsS3SlPhtE3W7OLW9jvtiW/PBIqS1lLd24O5+xQWaQGbdYcYyKgBxLQQitiMnAP
         vAiIH/rMBTgCZ7WULLGYEOvBt8Oz2i36pmdwMFzk=
From:   Shuah Khan <shuah@kernel.org>
To:     shuah@kernel.org, sean@mess.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?selftests:=20ir:=20fix=20warning:=20=E2=80=98%s?= =?UTF-8?q?=E2=80=99=20directive=20output=20may=20be=20truncated?=
Date:   Thu, 31 Jan 2019 12:43:12 -0700
Message-Id: <20190131194312.19060-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning by sizing the buffer to max. of sysfs
path max. size + d_name max. size.

gcc -Wall -O2 -I../../../include/uapi ir_loopback.c  -o ../tools/testing/selftests/ir/ir_loopback
ir_loopback.c: In function ‘lirc_open’:
ir_loopback.c:71:37: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size 95 [-Wformat-truncation=]
    snprintf(buf, sizeof(buf), "/dev/%s", dent->d_name);
                                     ^~
In file included from /usr/include/stdio.h:862:0,
                 from ir_loopback.c:14:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 6 and 261 bytes into a destination of size 100
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 858c19caf224..8cdf1b89ac9c 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -27,6 +27,8 @@
 
 #define TEST_SCANCODES	10
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define SYSFS_PATH_MAX 256
+#define DNAME_PATH_MAX 256
 
 static const struct {
 	enum rc_proto proto;
@@ -56,7 +58,7 @@ static const struct {
 int lirc_open(const char *rc)
 {
 	struct dirent *dent;
-	char buf[100];
+	char buf[SYSFS_PATH_MAX + DNAME_PATH_MAX];
 	DIR *d;
 	int fd;
 
-- 
2.17.1

