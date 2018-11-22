Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3165C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F7C20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j0fvkVfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F7C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439078AbeKWKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:03:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33994 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392635AbeKWKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:03:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so9802622plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGnK2W1fNMNjJUmjzBmpHixfeOx8rrinn/2HUMu/9ms=;
        b=j0fvkVfrNDaJKqlIhqgDQc1aP197LuKByPQV8a9DCZW1HRro7pTxuMIczzZQiG8oqh
         gNBaBd34G52KLw+pH1iyYtDWawdrUfxTOgOKM/H5qNieaLDn9eauJZtjtPVGRf9Javhh
         h5IDF+/WxrdZLwXhKMSQ9T5ci+fTguXrMiQL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGnK2W1fNMNjJUmjzBmpHixfeOx8rrinn/2HUMu/9ms=;
        b=QK96ylShZgdq3Tk5THKfgkvx1iuO35ucAiiAcQIao2f/+lDVj2hkU1uEfxYWTEifSK
         DNp2q4iHk3igEWOgXc7Yr75gkmgvJY351Upp+zpgSrWNeX/y4WZxX4l1hvS8HX0a0TcE
         Oy8f4fikQfUXHlLP79YD76nndYoayjFSLkN45JKJ2VEhAeBnhqc7GzhTVk+doTvaLzL1
         x1lnIPXNxWjEoLPU3xcEkj4sVWOr43GGmz56p06sVNJ5jZTaMCiBpdCSSM/8Ika2Jn2F
         kKlztUE3HOTdVk7Mlcupd6zbCg9amhN6yPwvXKj0+k6pOCsfJHFhgNI+tRSfxnb8M1nI
         RRpA==
X-Gm-Message-State: AA+aEWaszMuGCT2a1NhwgzN20587DEEoV/k/12cdFoxIeaCjfXkZHuTQ
        HhWw9VfChLnLuY1Opbu5am+00CgneYk=
X-Google-Smtp-Source: AFSGD/XfEZTIpG//Te8YOdDUWEzHKhMIec+FJ4M9+kro35NtdeBr61zHDLD0zfeUeYgv2HLy1yYJ+g==
X-Received: by 2002:a17:902:50e:: with SMTP id 14mr5074980plf.141.1542928914652;
        Thu, 22 Nov 2018 15:21:54 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id d3sm73232160pgl.64.2018.11.22.15.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 15:21:53 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:21:52 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next 2/2] selftests/memfd: modify tests for
 F_SEAL_FUTURE_WRITE seal
Message-ID: <20181122232152.GA17060@google.com>
References: <20181120052137.74317-1-joel@joelfernandes.org>
 <20181120052137.74317-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120052137.74317-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:21:37PM -0800, Joel Fernandes (Google) wrote:
> Modify the tests for F_SEAL_FUTURE_WRITE based on the changes
> introduced in previous patch.
> 
> Also add a test to make sure the reopen issue pointed by Jann Horn [1]
> is fixed.
> 
> [1] https://lore.kernel.org/lkml/CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com/
> 
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 88 +++++++++++-----------
>  1 file changed, 44 insertions(+), 44 deletions(-)

Since we squashed [1] the mm/memfd patch modifications suggested by Andy into
the original patch, I also squashed the selftests modifications and appended
the patch inline below if you want to take this instead:

[1] https://lore.kernel.org/lkml/20181122230906.GA198127@google.com/T/#m8ba68f67f3ec24913a977b62bcaeafc4b194b8c8

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v4] selftests/memfd: add tests for F_SEAL_FUTURE_WRITE seal

Add tests to verify sealing memfds with the F_SEAL_FUTURE_WRITE works as
expected.

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
2.19.1.1215.g8438c0b245-goog

