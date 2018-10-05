Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C2D21477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TyGED5py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C2D21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:27:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeJFC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:27:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so444703pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8MUoMdyZp7VnFk86cz/bxEv7KcxO90a6K0fUhGYRKA=;
        b=TyGED5pyaQZWWBdVUycfsGP3LhusgFUJp+EHbH6ZUBs8OYQhY+LDyCi36QgONUT/OE
         epxlgl1k5wW3Sqr4sf1RhIbzjF21B3QsuLSet6ognNUqOWjcKtrN2+YwY0U6H915YVLc
         OLMH6fniWBFsmSzTcdCGtblCqe+LqgcccbJ00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8MUoMdyZp7VnFk86cz/bxEv7KcxO90a6K0fUhGYRKA=;
        b=MbnO3steZe2jibT0IkILVHwTkAcjeAtVBiXJip/klTNeKcdtLRawxAmPrjj+OoCqZz
         x+HqIuh5pBRuedmyu9rhSdXVKyY/gTEDld0TByHWRwvWZwfqQMbnlAZzCaVJGP8JsEJV
         ueqZIxBxitXY3jCCuKPk0wF7J3Fdp87DHFiS8AS5hLYokEJJ1+MjyYGteb2MT0E4Lul1
         lfa6IAW/tJaZd4l76u7DAX6pa7N2xCaXdVX2fOTrSr8gYB+AJJG3y69KRN1Z97DKGudK
         VR/Qbc3xGTtO5AQ4fG85UM0sMBlCzUpM8FiiNfiMKyjXMtqTQh6Pn51wMx49geDo8nME
         O7Xw==
X-Gm-Message-State: ABuFfogzSbA6Il0Q1DoZ2paS53EdJnRSHNLQaxFSuv1J3n8p9u3O4FHt
        CMVrAIyu1t1ZLdYc2vkpC97vNCVIUYQ=
X-Google-Smtp-Source: ACcGV637nbvtU1/IOfHQBe0ZOxC4LT6wSr5iQYENxkPw88+Kap9FfbHNNYbfx2Q/1MyJP5ytiF079A==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr13202004pfk.191.1538767660352;
        Fri, 05 Oct 2018 12:27:40 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z15-v6sm11469300pfn.170.2018.10.05.12.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:27:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC] mm: Add an fs-write seal to memfd
Date:   Fri,  5 Oct 2018 12:27:27 -0700
Message-Id: <20181005192727.167933-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
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
and mmap it as writeable, then drop its protection for "future" writes
while keeping the existing already mmap'ed writeable-region active.
This allows us to implement a usecase where receivers of the shared
memory buffer can get a read-only view, while the sender continues to
write to the buffer. See CursorWindow in Android for more details:
https://developer.android.com/reference/android/database/CursorWindow

This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
prevents any future mmap and write syscalls from succeeding while
keeping the existing mmap active. The following program shows the seal
working in action:

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
	    printf("write failed even though no fs-write seal "
		   "(ret=%d errno =%d)\n", ret, errno);
    else
	    printf("write passed\n");

    addr1 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr1 == MAP_FAILED)
	    perror("map 1 prot-write failed even though no seal\n");
    else
	    printf("map 1 prot-write passed as expected\n");

    ret = fcntl(fd, F_ADD_SEALS, F_SEAL_FS_WRITE);
    if (ret == -1)
	    printf("fcntl failed, errno: %d\n", errno);
    else
	    printf("fs-write seal now active\n");

    if ((ret = write(fd, "test", 4)) != 4)
	    printf("write failed as expected due to fs-write seal\n");
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
fs-write seal now active
write failed as expected due to fs-write seal
map 2 prot-write failed as expected due to seal
: Permission denied
map 3 prot-read passed as expected

Cc: jreck@google.com
Cc: john.stultz@linaro.org
Cc: tkjos@google.com
Cc: gregkh@linuxfoundation.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd9a350..bafd1233b6a8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -41,6 +41,7 @@
 #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
+#define F_SEAL_FS_WRITE	0x0010  /* prevent all write-related syscalls */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 2bb5e257080e..4b09f446c2d2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -150,7 +150,8 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 #define F_ALL_SEALS (F_SEAL_SEAL | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
-		     F_SEAL_WRITE)
+		     F_SEAL_WRITE | \
+		     F_SEAL_FS_WRITE)
 
 static int memfd_add_seals(struct file *file, unsigned int seals)
 {
@@ -219,6 +220,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	if ((seals & F_SEAL_FS_WRITE) && !(*file_seals & F_SEAL_FS_WRITE))
+		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.19.0.605.g01d371f741-goog

