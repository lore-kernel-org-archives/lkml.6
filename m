Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162AEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82A021473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DfksOTMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82A021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJRO6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:58:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40534 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeJRO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:58:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so7428913pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VyGfWQacueEUHTGPoQ3uFdYU/4GyGaHaoBL4dBXqp8=;
        b=DfksOTMPnGLSt+/RZVbtrmZH+aUqtKZ9anz+d0UFot8eCfcdCf686Kgfs2EwSZu5tI
         /paN5Ys1hMjJp+YCZH1bFHtPB2OgWbeFXPV3FmFTN9aWRdsDYc5RgLoKzciA+gXwfIw/
         JIgYuws1P9Eb1SydvkYErc+X99w9lMAz/+IyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VyGfWQacueEUHTGPoQ3uFdYU/4GyGaHaoBL4dBXqp8=;
        b=YhtpNtKD/8MvvtZN2GOPSRSmMfBeV8ZG2MWjhEgu2SGwnljtsEvOrv4WNAq4b57fW9
         igHFlevp8i5AMf55v488WymMCTdh3vSO3vEgcLGr/gUh3uVT+IewlSAA8ftmNMW4/iDo
         5HSovoD/897CSgaRBe8P8epEjKzV/jo7MLrdRjQL21TRgVmoBRgAy2c9q188yvM0bDUO
         bErpZMEQyruJyrq/EAO5K4oIjvFEq4SE6SLBoXkjtD3Nd0jys+D8xmLeqRPAFOkv0lXd
         XQr069mB2nC7jEUrmtLAh5SprMTDh6jR3FUZnOLlP4m5Cp8BQIRO3KS2YvgW4HmFYny8
         tUdA==
X-Gm-Message-State: ABuFfoj25B6b8webtbWW3eV0UhaaxQgjXHsa4yqZCRL6H8aMxI1bdjBz
        gk7rEV+rutwHpQr3TDycYEdwr5Ni90s=
X-Google-Smtp-Source: ACcGV61MVMwfFrq1iY6mCNrXqt8vwRjugldQxLhW5AVm7ZVRL/BogArhefTux89TWrApAiEACQS/Uw==
X-Received: by 2002:a63:7044:: with SMTP id a4-v6mr27475186pgn.63.1539845959538;
        Wed, 17 Oct 2018 23:59:19 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm21580750pfh.79.2018.10.17.23.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 23:59:18 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dancol@google.com, minchan@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        John Stultz <john.stultz@linaro.org>, jreck@google.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com
Subject: [PATCH v3 2/2] selftests/memfd: Add tests for F_SEAL_FS_WRITE seal
Date:   Wed, 17 Oct 2018 23:59:08 -0700
Message-Id: <20181018065908.254389-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181018065908.254389-1-joel@joelfernandes.org>
References: <20181018065908.254389-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests to verify sealing memfds with the F_SEAL_FS_WRITE works as
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
2.19.1.331.ge82ca0e54c-goog

