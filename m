Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE25C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD73120831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o3lrtmuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD73120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeKTPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:49:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKTPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:49:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so411763plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eR81rLySgIbDOhD8bNr9ndHHVi59qZndCmsNdWWRUlQ=;
        b=o3lrtmuznJQ69cKw2Zm19SroG4DVyNaUlDT0/Sob5PFF0C7I/USX1eBAnxxrXDke7p
         w0BYdYfVuFU7H3NMe0gnkqQQ81HTQjKC/COIp5mitnc399grM9MqqT3piCurPUBJ0MNL
         y8U6o6EJ9sFcGtxsGMtIjuKdras2AK5sNwWLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eR81rLySgIbDOhD8bNr9ndHHVi59qZndCmsNdWWRUlQ=;
        b=c0eEeMq/PqD4DI/s+fTuafQ0PDrGGj5k3smL5AqWpn1+gBysZBgW95bxO+44VZspmI
         vlTeowCAMgrUX+e9AD16rFBX8hLBlzwzx5Al1BRVq7VVBgdj4QeBvPFLA3T/N4IE5xzo
         IJ5vGVZmcG/Ty3cXTc8KvNFIMBYK+D+isuwc0d5YTzL7G3DXs81JS23OpQ6xElmx97zI
         OznbseJ5+UhTFZHfOTaMqfKMPuk4bc0qagUibRju/DikrYRermEYGV8VZxCbzd/2bekf
         6CJ0nTKDxmHGKfBRqAXbTfgpMGbqOPhojjXt1kzXBghrk29GjycpL6ooubpktWW3z5uX
         oABA==
X-Gm-Message-State: AA+aEWbL/C3MoGfDtD6qNDwuAh1McBBOFqV6K48SCbsFsFnEFPveQ5wH
        Z9f+eoC8AF+WJujwwEKtqcJ42ruXzq4=
X-Google-Smtp-Source: AFSGD/W6hBaX3uX6kwGz1b1Ho5J/1rdkjv+kXaTxehYbSVp1p3dkkt42U4BBV6zxLt9PpR28q9LKbw==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr749732plb.87.1542691318562;
        Mon, 19 Nov 2018 21:21:58 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q199sm34237451pfc.97.2018.11.19.21.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 21:21:57 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -next 2/2] selftests/memfd: modify tests for F_SEAL_FUTURE_WRITE seal
Date:   Mon, 19 Nov 2018 21:21:37 -0800
Message-Id: <20181120052137.74317-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120052137.74317-1-joel@joelfernandes.org>
References: <20181120052137.74317-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the tests for F_SEAL_FUTURE_WRITE based on the changes
introduced in previous patch.

Also add a test to make sure the reopen issue pointed by Jann Horn [1]
is fixed.

[1] https://lore.kernel.org/lkml/CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com/

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 88 +++++++++++-----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 32b207ca7372..c67d32eeb668 100644
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
@@ -698,7 +733,7 @@ static void test_seal_write(void)
  */
 static void test_seal_future_write(void)
 {
-	int fd;
+	int fd, fd2;
 	void *p;
 
 	printf("%s SEAL-FUTURE-WRITE\n", memfd_str);
@@ -710,58 +745,23 @@ static void test_seal_future_write(void)
 	p = mfd_assert_mmap_shared(fd);
 
 	mfd_assert_has_seals(fd, 0);
-	/* Not adding grow/shrink seals makes the future write
-	 * seal fail to get added
-	 */
-	mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
-
-	mfd_assert_add_seals(fd, F_SEAL_GROW);
-	mfd_assert_has_seals(fd, F_SEAL_GROW);
-
-	/* Should still fail since shrink seal has
-	 * not yet been added
-	 */
-	mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
-
-	mfd_assert_add_seals(fd, F_SEAL_SHRINK);
-	mfd_assert_has_seals(fd, F_SEAL_GROW |
-				 F_SEAL_SHRINK);
 
-	/* Now should succeed, also verifies that the seal
-	 * could be added with an existing writable mmap
-	 */
 	mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
-	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
-				 F_SEAL_GROW |
-				 F_SEAL_FUTURE_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_FUTURE_WRITE);
 
 	/* read should pass, writes should fail */
 	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
 	mfd_fail_write(fd);
 
-	munmap(p, mfd_def_size);
-	close(fd);
-
-	/* Test adding all seals (grow, shrink, future write) at once */
-	fd = mfd_assert_new("kern_memfd_seal_future_write2",
-			    mfd_def_size,
-			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
-
-	p = mfd_assert_mmap_shared(fd);
-
-	mfd_assert_has_seals(fd, 0);
-	mfd_assert_add_seals(fd, F_SEAL_SHRINK |
-				 F_SEAL_GROW |
-				 F_SEAL_FUTURE_WRITE);
-	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
-				 F_SEAL_GROW |
-				 F_SEAL_FUTURE_WRITE);
-
-	/* read should pass, writes should fail */
-	mfd_assert_read(fd);
-	mfd_fail_write(fd);
+	fd2 = mfd_assert_reopen_fd(fd);
+	/* read should pass, writes should still fail */
+	mfd_assert_read(fd2);
+	mfd_assert_read_shared(fd2);
+	mfd_fail_write(fd2);
 
 	munmap(p, mfd_def_size);
+	close(fd2);
 	close(fd);
 }
 
-- 
2.19.1.1215.g8438c0b245-goog

