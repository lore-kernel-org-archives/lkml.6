Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E278C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704821473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Wfm7WNtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3704821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJRO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:58:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46248 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:58:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so14414192pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xear+RLNnBEI0/eVpUZWOmlWkAdxU+7aAlsATSKFP7M=;
        b=Wfm7WNtnSe1mOFGfqKBdRntjsGjuttEpU10k9RKeog5WXJ4GJeEB8W4LkPkkB6p5qt
         m0VAfP1IGy9EfgWauzMhEfHkXjnITorsjoe5qct0+kAEb7FmQ6lrAFpoRbx0WKmmIbsv
         cBjHAtotUSQYxzv+ZijepTDA6aV5uMFoaR+FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xear+RLNnBEI0/eVpUZWOmlWkAdxU+7aAlsATSKFP7M=;
        b=QdV40fpl5/I0QOC81hovSy2zbEQJgRwGxNhpIUoZY6LkcaqgNsawVE4jD2xNGfL0XR
         Lj3o6rbzmnyLF4e6j/j6a+OLlmPpneSozA4yXa+gIJcCgtgDZ/d4z5vjPWdbTy1ze+O1
         Un2ocZxJSTfTQPwykyIe3K9AIXpjlBV5UzZHJQfSoGD9k5iDjzeMPxb2AXbXQROSFy38
         1InyNF60l+h6BM7amNekJQdzZrVE+ytbYgJQsqLagEGBPBLnwR60XXRp3bPpviZ340Yi
         2GelO6DNLTcYdLyqgrR0hcjwGJOm+dc+lnh1ciFB3hp9qgEL8wJ50FRxjAnK/2yrSBuq
         NHTA==
X-Gm-Message-State: ABuFfojeq+yQh7/gRaBIzNLdTzdWALh/Y7/rdK+G+5z+zVaunQNALjpp
        ro3Un32g+DXo2LQ15vDEFu7lGZJYG/k=
X-Google-Smtp-Source: ACcGV61xNVH+I+unnVa85HggpBCokX4PPakDnkgxaXbTohriKoGLxj+MmqZCLQw34fZ/oUzP7/SshA==
X-Received: by 2002:a63:f744:: with SMTP id f4-v6mr27668756pgk.410.1539845957462;
        Wed, 17 Oct 2018 23:59:17 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm21580750pfh.79.2018.10.17.23.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 23:59:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
Date:   Wed, 17 Oct 2018 23:59:07 -0700
Message-Id: <20181018065908.254389-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android uses ashmem for sharing memory regions. We are looking forward
to migrating all usecases of ashmem to memfd so that we can possibly
remove the ashmem driver in the future from staging while also
benefiting from using memfd and contributing to it. Note staging drivers
are also not ABI and generally can be removed at anytime.

One of the main usecases Android has is the ability to create a region
and mmap it as writeable, then add protection against making any
"future" writes while keeping the existing already mmap'ed
writeable-region active.  This allows us to implement a usecase where
receivers of the shared memory buffer can get a read-only view, while
the sender continues to write to the buffer.
See CursorWindow documentation in Android for more details:
https://developer.android.com/reference/android/database/CursorWindow

This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
which prevents any future mmap and write syscalls from succeeding while
keeping the existing mmap active. The following program shows the seal
working in action:

 #include <stdio.h>
 #include <errno.h>
 #include <sys/mman.h>
 #include <linux/memfd.h>
 #include <linux/fcntl.h>
 #include <asm/unistd.h>
 #include <unistd.h>
 #define F_SEAL_FUTURE_WRITE 0x0010
 #define REGION_SIZE (5 * 1024 * 1024)

int memfd_create_region(const char *name, size_t size)
{
    int ret;
    int fd = syscall(__NR_memfd_create, name, MFD_ALLOW_SEALING);
    if (fd < 0) return fd;
    ret = ftruncate(fd, size);
    if (ret < 0) { close(fd); return ret; }
    return fd;
}

int main() {
    int ret, fd;
    void *addr, *addr2, *addr3, *addr1;
    ret = memfd_create_region("test_region", REGION_SIZE);
    printf("ret=%d\n", ret);
    fd = ret;

    // Create map
    addr = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr == MAP_FAILED)
	    printf("map 0 failed\n");
    else
	    printf("map 0 passed\n");

    if ((ret = write(fd, "test", 4)) != 4)
	    printf("write failed even though no future-write seal "
		   "(ret=%d errno =%d)\n", ret, errno);
    else
	    printf("write passed\n");

    addr1 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr1 == MAP_FAILED)
	    perror("map 1 prot-write failed even though no seal\n");
    else
	    printf("map 1 prot-write passed as expected\n");

    ret = fcntl(fd, F_ADD_SEALS, F_SEAL_FUTURE_WRITE |
				 F_SEAL_GROW |
				 F_SEAL_SHRINK);
    if (ret == -1)
	    printf("fcntl failed, errno: %d\n", errno);
    else
	    printf("future-write seal now active\n");

    if ((ret = write(fd, "test", 4)) != 4)
	    printf("write failed as expected due to future-write seal\n");
    else
	    printf("write passed (unexpected)\n");

    addr2 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr2 == MAP_FAILED)
	    perror("map 2 prot-write failed as expected due to seal\n");
    else
	    printf("map 2 passed\n");

    addr3 = mmap(0, REGION_SIZE, PROT_READ, MAP_SHARED, fd, 0);
    if (addr3 == MAP_FAILED)
	    perror("map 3 failed\n");
    else
	    printf("map 3 prot-read passed as expected\n");
}

The output of running this program is as follows:
ret=3
map 0 passed
write passed
map 1 prot-write passed as expected
future-write seal now active
write failed as expected due to future-write seal
map 2 prot-write failed as expected due to seal
: Permission denied
map 3 prot-read passed as expected

Cc: jreck@google.com
Cc: john.stultz@linaro.org
Cc: tkjos@google.com
Cc: gregkh@linuxfoundation.org
Cc: hch@infradead.org
Reviewed-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: No change, just added selftests to the series. manpages are
ready and I'll submit them once the patches are accepted.

v2->v3: Updated commit message to have more support code (John Stultz)
 	Renamed seal from F_SEAL_FS_WRITE to F_SEAL_FUTURE_WRITE
						(Christoph Hellwig)
	Allow for this seal only if grow/shrink seals are also
	either previous set, or are requested along with this seal.
						(Christoph Hellwig)
	Added locking to synchronize access to file->f_mode.
						(Christoph Hellwig)

 include/uapi/linux/fcntl.h |  1 +
 mm/memfd.c                 | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd9a350..a2f8658f1c55 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -41,6 +41,7 @@
 #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
+#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 2bb5e257080e..5ba9804e9515 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -150,7 +150,8 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 #define F_ALL_SEALS (F_SEAL_SEAL | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
-		     F_SEAL_WRITE)
+		     F_SEAL_WRITE | \
+		     F_SEAL_FUTURE_WRITE)
 
 static int memfd_add_seals(struct file *file, unsigned int seals)
 {
@@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	if ((seals & F_SEAL_FUTURE_WRITE) &&
+	    !(*file_seals & F_SEAL_FUTURE_WRITE)) {
+		/*
+		 * The FUTURE_WRITE seal also prevents growing and shrinking
+		 * so we need them to be already set, or requested now.
+		 */
+		int test_seals = (seals | *file_seals) &
+				 (F_SEAL_GROW | F_SEAL_SHRINK);
+
+		if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
+			error = -EINVAL;
+			goto unlock;
+		}
+
+		spin_lock(&file->f_lock);
+		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
+		spin_unlock(&file->f_lock);
+	}
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.19.1.331.ge82ca0e54c-goog
