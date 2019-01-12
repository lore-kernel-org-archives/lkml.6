Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BCF20835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lmKUV/dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfALUih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:38:37 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35999 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfALUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:38:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so22659421qtn.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 12:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MWo8Mkvt471260EQpjgHwB7ntQEkhWkiuroZZqGz7Q=;
        b=lmKUV/dUsPcqBbfMgv9BdXHViFVQX4L9qEX5mzBe6yCJ3IgEoApudENEMiWX9PcSia
         78dwptQY2hD/6JHzCY7HMGBemp+tgjZhQ05kPp4parsICyeHICoGCaoIMK0aQJFKc8sR
         h8iqwys+YBCWX9ip/qKIEogwazXSfSq605vN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MWo8Mkvt471260EQpjgHwB7ntQEkhWkiuroZZqGz7Q=;
        b=gSNkje1FGQY8ELbrmRGwqWReMJpID88vktvq+hAf0Ka9eQI+GRCfFZZq2DfQ+A9pN4
         9r3MIt2VNjZY0h+gl0dORZEslexnRoKzWA+5AmzOUcqKJbPmWUtcJOYD5AJfEPcGwx1w
         cWJrE5jR+kEvVAgF78bmH9RpH6GDkafZ7Uza/sADEyNcM21GaLd4wzKXal3AAwVcY0zQ
         ulLcW71rqV69SbaoDM/KkGn4vC+5JeoL4uNIMNuASXiL8bn7VKYt05JgjVMBnHFCiYYu
         zsse11C2+TV558xCmBIfJcU6meNbAOVdifKatfcUeU0z1X4PP76sYhljjZQpd9m+nDVa
         BCMQ==
X-Gm-Message-State: AJcUukeXLuM0kDjVGze63S6gSjFAfstdc5fUKibjmwpCzsHFmfVKrxhW
        GC7ZSkE3kA3e2kIUGgOjMjn3FKo7u1Q=
X-Google-Smtp-Source: ALg8bN4EPzx3WrCu4lodXwGRW7peAjqqjPCeB/57bYpl+61/kVhWIFRuqh/Sb/FiGO3i6UC8/M6CjA==
X-Received: by 2002:a0c:e751:: with SMTP id g17mr18871160qvn.160.1547325514848;
        Sat, 12 Jan 2019 12:38:34 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id c12sm55883402qka.42.2019.01.12.12.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 12:38:34 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dancol@google.com, minchan@kernel.org,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_WRITE seal
Date:   Sat, 12 Jan 2019 15:38:16 -0500
Message-Id: <20190112203816.85534-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190112203816.85534-1-joel@joelfernandes.org>
References: <20190112203816.85534-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Add tests to verify sealing memfds with the F_SEAL_FUTURE_WRITE works as
expected.

Cc: dancol@google.com
Cc: minchan@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..c67d32eeb668 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -54,6 +54,22 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 	return fd;
 }
 
+static int mfd_assert_reopen_fd(int fd_in)
+{
+	int r, fd;
+	char path[100];
+
+	sprintf(path, "/proc/self/fd/%d", fd_in);
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		printf("re-open of existing fd %d failed\n", fd_in);
+		abort();
+	}
+
+	return fd;
+}
+
 static void mfd_fail_new(const char *name, unsigned int flags)
 {
 	int r;
@@ -255,6 +271,25 @@ static void mfd_assert_read(int fd)
 	munmap(p, mfd_def_size);
 }
 
+/* Test that PROT_READ + MAP_SHARED mappings work. */
+static void mfd_assert_read_shared(int fd)
+{
+	void *p;
+
+	/* verify PROT_READ and MAP_SHARED *is* allowed */
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+	munmap(p, mfd_def_size);
+}
+
 static void mfd_assert_write(int fd)
 {
 	ssize_t l;
@@ -692,6 +727,44 @@ static void test_seal_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_FUTURE_WRITE
+ * Test whether SEAL_FUTURE_WRITE actually prevents modifications.
+ */
+static void test_seal_future_write(void)
+{
+	int fd, fd2;
+	void *p;
+
+	printf("%s SEAL-FUTURE-WRITE\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_future_write",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	p = mfd_assert_mmap_shared(fd);
+
+	mfd_assert_has_seals(fd, 0);
+
+	mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_FUTURE_WRITE);
+
+	/* read should pass, writes should fail */
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	fd2 = mfd_assert_reopen_fd(fd);
+	/* read should pass, writes should still fail */
+	mfd_assert_read(fd2);
+	mfd_assert_read_shared(fd2);
+	mfd_fail_write(fd2);
+
+	munmap(p, mfd_def_size);
+	close(fd2);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -945,6 +1018,7 @@ int main(int argc, char **argv)
 	test_basic();
 
 	test_seal_write();
+	test_seal_future_write();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.20.1.97.g81188d93c3-goog

