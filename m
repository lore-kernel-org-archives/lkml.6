Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CCC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F487214FE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DqgZgnQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F487214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJJFkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:40:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41489 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeJJFkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:40:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so1494098pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zE/nAc/JVnWc4CMHOs76nC5pBisapw03s96G8eS2xeQ=;
        b=DqgZgnQzBHyIneOhD1h4aX7Xyu4gvvYOv+Vk54QCfHuLo0vCFlRbhsT9KfXoGwGe20
         pD0AS4uwoDw40u3H6LbfVxJ9WcCPTcJck4wiCPzTNxQ8eyB/POuCYpno94TiBdgJ6cuq
         N2SId8NAkSqk3T7Td+BFsEbrFN7Q8PFvGvKdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zE/nAc/JVnWc4CMHOs76nC5pBisapw03s96G8eS2xeQ=;
        b=saeA8GDYmPKDWttWLIY/ZdDGJXF7kXH3g62Qg2LU/uVqOXFohA/SWn4z/3CN70eWne
         H8MC31kKlUWHlky4Nl3WOP3LAonbI4es6pUcr0Hxs05tN5Z7z31D3LldC4slBRRMnE06
         HmZRflDuOfIOGoVg7WtnbXB+96e/WYqyuK1CZegmyZlGsb8f9P8jbv+a1Dsrs6r2QgHL
         3kfGC3S5zPXVE2r3phf1rfVF69fSqqFkGQQO/JTW5W9C2VzNsJDOC8HOGtQaUsm/njyt
         pE35hFsx3X0PLFm6buC8celAXHnv11dPZTC4GtLpqqPiHiky98bf9k/sMaY+CoHdq/De
         b5Iw==
X-Gm-Message-State: ABuFfoj5um9qRZ5Lcat0b+uKRG1CnK7IreUy6EexPlmPkaaM2FQQjuNc
        45lrrPzYWEEF3+yMgQx0iP1vI4yiKwc=
X-Google-Smtp-Source: ACcGV61RXAN2jDLnDPfW2F40XM1mwAwHFEHxP3Mu2de0YVywOd11qePJX02C+LZ4ZjNTcmH4lZpKdQ==
X-Received: by 2002:a62:8891:: with SMTP id l139-v6mr31867512pfd.198.1539123663946;
        Tue, 09 Oct 2018 15:21:03 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z15-v6sm26900856pfn.170.2018.10.09.15.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:21:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        minchan@google.com, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
Date:   Tue,  9 Oct 2018 15:20:41 -0700
Message-Id: <20181009222042.9781-1-joel@joelfernandes.org>
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

Note: This seal will also prevent growing and shrinking of the memfd.
This is not something we do in Android so it does not affect us, however
I have mentioned this behavior of the seal in the manpage.

Cc: jreck@google.com
Cc: john.stultz@linaro.org
Cc: tkjos@google.com
Cc: gregkh@linuxfoundation.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: No change, just added selftests to the series. manpages are
ready and I'll submit them once the patches are accepted.

 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c98312fa78a5..fe44a2035edf 100644
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
index 27069518e3c5..9b8855b80de9 100644
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

