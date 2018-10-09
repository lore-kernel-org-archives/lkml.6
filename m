Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B5C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CFB21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K0PLEdHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CFB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJJFxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:53:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37925 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeJJFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:53:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so1512027pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NwVBvxLxnExW8Y+lohGiDTTSEx7kt3RXBm0dcq5Azr4=;
        b=K0PLEdHLkE371oIDFHdv6F8/JVPxj9tzXqw+vx0g7tG+cdecE8npNfh6om8DBgrlJI
         SvhKDoPvaR7S/E32obYtPIx+uHd6dR8xjx60M6T7nqBfArcUyTK980kW8iKDTDDI2u1+
         O3WSvRIvKD4rsOu8AbrQDZQdaQVGOucrOJ6V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NwVBvxLxnExW8Y+lohGiDTTSEx7kt3RXBm0dcq5Azr4=;
        b=gGU+pLflufJnuCqGGlTiJRMq9iNRoBIuVxJ6ELbfIEKdvjiIaG22QwvC0INeU87CU+
         ieZwiHlreQAUM5fj6pbH1IfbsPC0jtdBz/VrZyScNYCOfr0lWjQrPF8aaOpBGNdnyWmS
         MmAesapplerWuGv7nzXS6nm+v2r+dP2GQVrTqYx5qDNuLEmygf3bF+Q67z1TGiHak0yr
         s4jdz2N5tkIYnukodoDj0eUAuLWreU9DUXu7RP8K1KuoDYoAzy1XR19HBz9KIG4IuHTC
         m3CZMZDc5lQWzOe4xvYCEsp2Ahrbp/6Mwi77jNSDPAKlqkZyWDKFQNyi8FEbtCUyV7l3
         lgyQ==
X-Gm-Message-State: ABuFfogHDuppPqHzwM/KcDNLxMRB20l6QsUrT8NoNsxVxrWJlYvn/BhR
        xRb2oQ/Kc6Vy61BpD5lPD1mISbT5dNM=
X-Google-Smtp-Source: ACcGV63xH2v3yg7WUwnjgAWTRzC7b5quWc0qBgXHjVxJyLOVvW7zGCG0jlnr5aHOeAYoqx5V6LbYIQ==
X-Received: by 2002:a63:ea43:: with SMTP id l3-v6mr27556911pgk.427.1539124453705;
        Tue, 09 Oct 2018 15:34:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r25-v6sm23920355pgm.59.2018.10.09.15.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 15:34:12 -0700 (PDT)
Date:   Tue, 9 Oct 2018 15:34:11 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, dancol@google.com, minchan@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, john.stultz@linaro.org,
        jreck@google.com, Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, tkjos@google.com
Subject: Re: [PATCH v2 2/2] selftests/memfd: Add tests for F_SEAL_FS_WRITE
 seal
Message-ID: <20181009223411.GA13848@joelaf.mtv.corp.google.com>
References: <20181009222042.9781-1-joel@joelfernandes.org>
 <20181009222042.9781-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009222042.9781-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:20:42PM -0700, Joel Fernandes (Google) wrote:
> Add tests to verify sealing memfds with the F_SEAL_FS_WRITE works as
> expected.
> 
> Cc: dancol@google.com
> Cc: minchan@google.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 51 +++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 10baa1652fc2..4bd2b6c87bb4 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -27,7 +27,7 @@
>  
>  #define MFD_DEF_SIZE 8192
>  #define STACK_SIZE 65536
> -
> +#define F_SEAL_FS_WRITE         0x0010
>  /*
>   * Default is not to test hugetlbfs
>   */
> @@ -170,6 +170,24 @@ static void *mfd_assert_mmap_shared(int fd)
>  	return p;
>  }
>  
> +static void *mfd_fail_mmap_shared(int fd)
> +{
> +	void *p;
> +
> +	p = mmap(NULL,
> +		 mfd_def_size,
> +		 PROT_READ | PROT_WRITE,
> +		 MAP_SHARED,
> +		 fd,
> +		 0);
> +	if (p != MAP_FAILED) {
> +		printf("mmap() didn't fail as expected\n");
> +		abort();
> +	}
> +
> +	return p;
> +}
> +

Ah, this function is unused. I wrote it initially and used it but then
figured I didn't need it, and then forgot to remove it. It does not affect
the correctness of the patch. Anyway below is the updated patch.

thanks,

- Joel

------8<-----

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2.1] selftests/memfd: Add tests for F_SEAL_FS_WRITE seal

Add tests to verify sealing memfds with the F_SEAL_FS_WRITE works as
expected.

Cc: dancol@google.com
Cc: minchan@kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 33 +++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..d074de568ba0 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -27,7 +27,7 @@
 
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
-
+#define F_SEAL_FS_WRITE         0x0010
 /*
  * Default is not to test hugetlbfs
  */
@@ -692,6 +692,36 @@ static void test_seal_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_WRITE
+ * Test whether SEAL_WRITE actually prevents modifications.
+ */
+static void test_seal_fs_write(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-FS-WRITE\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_fs_write",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	p = mfd_assert_mmap_shared(fd);
+
+	/* FS_WRITE seal can be added even with existing
+	 * writeable mappings */
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_FS_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_FS_WRITE);
+
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
@@ -945,6 +975,7 @@ int main(int argc, char **argv)
 	test_basic();
 
 	test_seal_write();
+	test_seal_fs_write();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.19.0.605.g01d371f741-goog

