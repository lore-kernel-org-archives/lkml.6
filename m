Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A19ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472CA20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SBQ5ErAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472CA20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeKHNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:49:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46011 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeKHNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:49:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so7845168pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zofjVTOVPvsbdL80JX/HP6LiIlhioMiBlF9iJC67X1A=;
        b=SBQ5ErAQVg154oxgo1IKPG2CWLZdTmwK1NvBAE1iUbjJ4TcXTgKcnYo0eH1FraaYQT
         SgH2C35H57byF8/qsMv8oRQZpblfP6AT2pKA0f8uggC/86Y5OLcRHkV+SdBkmpUSu7QA
         dNo43cyRfnBQXyuLLmT5g20Gfvs7U5tV8FZuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zofjVTOVPvsbdL80JX/HP6LiIlhioMiBlF9iJC67X1A=;
        b=LGsjPeb+KaLyLB4xSoO60Fd/ocd3GdhDo4HEbpQp27IA6YyC2WA0vdS/Ij3R8wSh8O
         nUNuRWrzeDl5/DzU/GXn2MzSf+Vid+bwMvfW1DWqGYljXWXnTIPTDiVoMH6tGJ2+pHEG
         QqfXS7v55y6pTz8VpSvKzDqLea4fTiBd5c0emR66Kkhmd7tQn4kzNUyOwzONXaZFpRxF
         jGVdoyjaN/Nb05lKfax7CeslmLICZO5PpDfPlIjVOpGRidFEbn6/rRp2ZJ2xPL0rDgy5
         E1o0pOGWnM/1DF8rNzQcelMUmB2v4loRz3ZXSuxtkCaaCWn+oBqSv6FmWolkNqbbSK3J
         4a/w==
X-Gm-Message-State: AGRZ1gL+kDjvomgANELrInwJPUDFMs16HuFZeIxhy5soKvOJSffnQhrb
        KgTAtUI+H4O2ZyTPhPbPV5betNdDdJw=
X-Google-Smtp-Source: AJdET5cE1wbXz2O5YlQdpkJ5g7TcdQPHSjzv+EmXi/h5mbiW6JGajVv8Bw/OvVoEpV4KkgDTiTzX6A==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr2640249pgj.410.1541650577205;
        Wed, 07 Nov 2018 20:16:17 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id t77-v6sm3161096pfj.79.2018.11.07.20.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:16:16 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dancol@google.com, minchan@kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, hch@infradead.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, jreck@google.com,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Lei Yang <Lei.Yang@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, tkjos@google.com,
        valdis.kletnieks@vt.edu
Subject: [PATCH v3 resend 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_WRITE seal
Date:   Wed,  7 Nov 2018 20:15:37 -0800
Message-Id: <20181108041537.39694-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108041537.39694-1-joel@joelfernandes.org>
References: <20181108041537.39694-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests to verify sealing memfds with the F_SEAL_FUTURE_WRITE works as
expected.

Cc: dancol@google.com
Cc: minchan@kernel.org
Reviewed-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..32b207ca7372 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -692,6 +692,79 @@ static void test_seal_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_FUTURE_WRITE
+ * Test whether SEAL_FUTURE_WRITE actually prevents modifications.
+ */
+static void test_seal_future_write(void)
+{
+	int fd;
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
+	/* Not adding grow/shrink seals makes the future write
+	 * seal fail to get added
+	 */
+	mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
+
+	mfd_assert_add_seals(fd, F_SEAL_GROW);
+	mfd_assert_has_seals(fd, F_SEAL_GROW);
+
+	/* Should still fail since shrink seal has
+	 * not yet been added
+	 */
+	mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
+
+	mfd_assert_add_seals(fd, F_SEAL_SHRINK);
+	mfd_assert_has_seals(fd, F_SEAL_GROW |
+				 F_SEAL_SHRINK);
+
+	/* Now should succeed, also verifies that the seal
+	 * could be added with an existing writable mmap
+	 */
+	mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
+				 F_SEAL_GROW |
+				 F_SEAL_FUTURE_WRITE);
+
+	/* read should pass, writes should fail */
+	mfd_assert_read(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+
+	/* Test adding all seals (grow, shrink, future write) at once */
+	fd = mfd_assert_new("kern_memfd_seal_future_write2",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	p = mfd_assert_mmap_shared(fd);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_SHRINK |
+				 F_SEAL_GROW |
+				 F_SEAL_FUTURE_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_SHRINK |
+				 F_SEAL_GROW |
+				 F_SEAL_FUTURE_WRITE);
+
+	/* read should pass, writes should fail */
+	mfd_assert_read(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
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
2.19.1.930.g4563a0d9d0-goog

