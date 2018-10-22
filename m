Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22328C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D61020651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aWvu7mLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D61020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeJWIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:09:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33708 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:09:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so18321488pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDtkWfJX6UOD3pDo61X4U4dXHBPp3rHlTaGgivs5jOQ=;
        b=aWvu7mLNfAVBbY1hY/XceAAANDRgy+a3Y+d4pv8GNPenyXA4/s4UQxx3vPRbpkG4dw
         IiJPhfR3ctTUU6iO3cC2Jtp3OMfilRD0l3t1H7zO8C2i6ibWDo7vhzlQTJ/56auDYfLW
         sCdLLKL1j8wn7iHHg9AW7WD3WqzlPIVhPvWtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDtkWfJX6UOD3pDo61X4U4dXHBPp3rHlTaGgivs5jOQ=;
        b=CulPVtbK/xkM7ypUJaU0wLub/ouL3/x3ldrAyDuRvCFL2lXwKn9A2dTzx9MxtuUaFO
         8EMdFe/Zu8Lm71ctSohdV8Wgl7DDtrR0wbzIRlSqsTrTrq2WYGtPeM6zO4qa+z5P1+Ch
         0eYbsqkO1zNFRA5WKrNsSIPEcFSkWsmxgk3PUcZqmfO3WtCffRMUsWp8z+KFEGL3Gbm9
         LDCGb8L19fFjY+F1K0DgB+hlQDVkFnRL4TN3XNf//FngkWma9BLNzitk8CXY4mxLwkAQ
         /dwYBk8L5g6tb2OlsqjBZHKyTh33+Jx8/FkIgoCPf62YpKukz+jGXnvRKtX+djuqzID2
         fbTw==
X-Gm-Message-State: ABuFfoiwVkus+hZXAgg1qUxS+bIZ7KpyHzoKfaYt/as7KvlgEkxVGfoL
        BdaKiKXxfPzw8DNpp17nm0XGVLPjI6s=
X-Google-Smtp-Source: ACcGV63KrfnEiVV0JOHMpv7SptBdQPmgooR6Ma0+0/BrzGV6sMdrMGQMbTWBJItf1STMX90HREo3Kw==
X-Received: by 2002:a62:4301:: with SMTP id q1-v6mr46658364pfa.163.1540252148829;
        Mon, 22 Oct 2018 16:49:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r76-v6sm42460515pgr.11.2018.10.22.16.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 16:49:07 -0700 (PDT)
Date:   Mon, 22 Oct 2018 16:49:06 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tkjos@google.com,
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
Subject: Re: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
Message-ID: <20181022234906.GA22110@joelaf.mtv.corp.google.com>
References: <20181018065908.254389-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018065908.254389-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:59:07PM -0700, Joel Fernandes (Google) wrote:
> Android uses ashmem for sharing memory regions. We are looking forward
> to migrating all usecases of ashmem to memfd so that we can possibly
> remove the ashmem driver in the future from staging while also
> benefiting from using memfd and contributing to it. Note staging drivers
> are also not ABI and generally can be removed at anytime.
> 
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then add protection against making any
> "future" writes while keeping the existing already mmap'ed
> writeable-region active.  This allows us to implement a usecase where
> receivers of the shared memory buffer can get a read-only view, while
> the sender continues to write to the buffer.
> See CursorWindow documentation in Android for more details:
> https://developer.android.com/reference/android/database/CursorWindow
> 
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:
> 
>  #include <stdio.h>
>  #include <errno.h>
>  #include <sys/mman.h>
>  #include <linux/memfd.h>
>  #include <linux/fcntl.h>
>  #include <asm/unistd.h>
>  #include <unistd.h>
>  #define F_SEAL_FUTURE_WRITE 0x0010
>  #define REGION_SIZE (5 * 1024 * 1024)
> 
> int memfd_create_region(const char *name, size_t size)
> {
>     int ret;
>     int fd = syscall(__NR_memfd_create, name, MFD_ALLOW_SEALING);
>     if (fd < 0) return fd;
>     ret = ftruncate(fd, size);
>     if (ret < 0) { close(fd); return ret; }
>     return fd;
> }
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
> 	    printf("map 0 failed\n");
>     else
> 	    printf("map 0 passed\n");
> 
>     if ((ret = write(fd, "test", 4)) != 4)
> 	    printf("write failed even though no future-write seal "
> 		   "(ret=%d errno =%d)\n", ret, errno);
>     else
> 	    printf("write passed\n");
> 
>     addr1 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>     if (addr1 == MAP_FAILED)
> 	    perror("map 1 prot-write failed even though no seal\n");
>     else
> 	    printf("map 1 prot-write passed as expected\n");
> 
>     ret = fcntl(fd, F_ADD_SEALS, F_SEAL_FUTURE_WRITE |
> 				 F_SEAL_GROW |
> 				 F_SEAL_SHRINK);
>     if (ret == -1)
> 	    printf("fcntl failed, errno: %d\n", errno);
>     else
> 	    printf("future-write seal now active\n");
> 
>     if ((ret = write(fd, "test", 4)) != 4)
> 	    printf("write failed as expected due to future-write seal\n");
>     else
> 	    printf("write passed (unexpected)\n");
> 
>     addr2 = mmap(0, REGION_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>     if (addr2 == MAP_FAILED)
> 	    perror("map 2 prot-write failed as expected due to seal\n");
>     else
> 	    printf("map 2 passed\n");
> 
>     addr3 = mmap(0, REGION_SIZE, PROT_READ, MAP_SHARED, fd, 0);
>     if (addr3 == MAP_FAILED)
> 	    perror("map 3 failed\n");
>     else
> 	    printf("map 3 prot-read passed as expected\n");
> }
> 
> The output of running this program is as follows:
> ret=3
> map 0 passed
> write passed
> map 1 prot-write passed as expected
> future-write seal now active
> write failed as expected due to future-write seal
> map 2 prot-write failed as expected due to seal
> : Permission denied
> map 3 prot-read passed as expected
> 
> Cc: jreck@google.com
> Cc: john.stultz@linaro.org
> Cc: tkjos@google.com
> Cc: gregkh@linuxfoundation.org
> Cc: hch@infradead.org
> Reviewed-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Apologies for the follow-up. Now that merge window has opened, just checking
if this patch (which IMO has been beaten to death) can make it for 4.20?  Its
pretty much completed and is well tested at this point (tests are in 2/2).
Then I can move onto other memfd enhancements I'm planning.

thanks,

 - Joel

