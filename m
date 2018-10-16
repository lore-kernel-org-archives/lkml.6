Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AB8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE40721471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CK1Txqga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE40721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJQFtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:49:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJQFtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:49:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so27324175wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zGS25YocjFzs0rNN+PJEzpXfG8MY1k8ajW9x/zVmPzY=;
        b=CK1Txqga0cNAiFNQRHsEkuXDG1ki5RgYKTSpyLJxYpStdnzgvsZsg5PYeis/fYMa7m
         7U/0paNM3vVFQZAmc/LuOpi7Ain518Rsr9N1JAHLfUQWus7j+ms4p6d7/h9fMkYnSiGc
         xqc4ZyCFMq2aj2xC81AOMj6B0eQEoc7zJUmYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zGS25YocjFzs0rNN+PJEzpXfG8MY1k8ajW9x/zVmPzY=;
        b=SyU17ZcPex6c0gtTrSGFBYGO0UDPXf0XhBR4hWO9jFHptmwmR2oIoD7Vbzx2mQOZFJ
         ua3jLSM2CFESEUYoPZSUuo+zmLdwkrWZZW+X3txJZEvKFViv8720uTXdvV7mbHNchi/P
         y0201mOYrvTSBcYlgWzmNMa2jNhp7rQoksqgx7Gz7VUY7L5yK2JUtDVGUeguYOAeQGc2
         iFKUHNftYxixQlFd3SPq0MnxBWKdHn1QMWsQH/uYp412aLQMdCli7FD/H80J407EOQ7J
         FDeoTH6oXSZku9UyMe2+uZ5ma2ch/yjJoESGmvykGlze7hFkqvInnUIE8SpxAnSjgcVf
         tjbA==
X-Gm-Message-State: ABuFfojE13yAeQtlSuNYbHXt+JKe1t/1vX1drr3rM0CcOW3bT+F37Nlx
        wrI+r5m93T42bSa5G32KU2hpJ883agEjFg9aeuzlJQ==
X-Google-Smtp-Source: ACcGV61xUVerWldJEjV3b8Jlc28CPdxFkMKfctw50SAFunHXy2HzYpGpYY3v8RRfZxxUYmp8YqNvkUo91QnXhhsFD/8=
X-Received: by 2002:adf:a194:: with SMTP id u20-v6mr12799777wru.50.1539727033716;
 Tue, 16 Oct 2018 14:57:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 14:57:12
 -0700 (PDT)
In-Reply-To: <20181009222042.9781-1-joel@joelfernandes.org>
References: <20181009222042.9781-1-joel@joelfernandes.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Oct 2018 14:57:12 -0700
Message-ID: <CALAqxLXD-vghiMP51tVtL1Aw8OqT-QhCeNMdFSKiHpyq10-WCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        John Reck <jreck@google.com>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:20 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Android uses ashmem for sharing memory regions. We are looking forward
> to migrating all usecases of ashmem to memfd so that we can possibly
> remove the ashmem driver in the future from staging while also
> benefiting from using memfd and contributing to it. Note staging drivers
> are also not ABI and generally can be removed at anytime.
>
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then drop its protection for "future" writes
> while keeping the existing already mmap'ed writeable-region active.
> This allows us to implement a usecase where receivers of the shared
> memory buffer can get a read-only view, while the sender continues to
> write to the buffer. See CursorWindow in Android for more details:
> https://developer.android.com/reference/android/database/CursorWindow
>
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:
>
> int main() {
>     int ret, fd;
>     void *addr, *addr2, *addr3, *addr1;
>     ret = memfd_create_region("test_region", REGION_SIZE);
>     printf("ret=%d\n", ret);
>     fd = ret;
>
>     // Create map
>     addr = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>     if (addr == MAP_FAILED)
>             printf("map 0 failed\n");
>     else
>             printf("map 0 passed\n");
>
>     if ((ret = write(fd, "test", 4)) != 4)
>             printf("write failed even though no fs-write seal "
>                    "(ret=%d errno =%d)\n", ret, errno);
>     else
>             printf("write passed\n");
>
>     addr1 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>     if (addr1 == MAP_FAILED)
>             perror("map 1 prot-write failed even though no seal\n");
>     else
>             printf("map 1 prot-write passed as expected\n");
>
>     ret = fcntl(fd, F_ADD_SEALS, F_SEAL_FS_WRITE);
>     if (ret == -1)
>             printf("fcntl failed, errno: %d\n", errno);
>     else
>             printf("fs-write seal now active\n");
>
>     if ((ret = write(fd, "test", 4)) != 4)
>             printf("write failed as expected due to fs-write seal\n");
>     else
>             printf("write passed (unexpected)\n");
>
>     addr2 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>     if (addr2 == MAP_FAILED)
>             perror("map 2 prot-write failed as expected due to seal\n");
>     else
>             printf("map 2 passed\n");
>
>     addr3 = mmap(0, REGION_SIZE, PROT_READ, MAP_SHARED, fd, 0);
>     if (addr3 == MAP_FAILED)
>             perror("map 3 failed\n");
>     else
>             printf("map 3 prot-read passed as expected\n");
> }
>
> The output of running this program is as follows:
> ret=3
> map 0 passed
> write passed
> map 1 prot-write passed as expected
> fs-write seal now active
> write failed as expected due to fs-write seal
> map 2 prot-write failed as expected due to seal
> : Permission denied
> map 3 prot-read passed as expected
>
> Note: This seal will also prevent growing and shrinking of the memfd.
> This is not something we do in Android so it does not affect us, however
> I have mentioned this behavior of the seal in the manpage.
>
> Cc: jreck@google.com
> Cc: john.stultz@linaro.org
> Cc: tkjos@google.com
> Cc: gregkh@linuxfoundation.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: John Stultz <john.stultz@linaro.org>

thanks
-john
