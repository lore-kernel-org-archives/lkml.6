Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC073C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3F8208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F8208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHBBvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:51:00 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48120 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHBBvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:51:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 165C2218EA;
        Thu,  2 Aug 2018 00:02:39 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P8stdrra272r; Thu,  2 Aug 2018 00:02:39 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 72BD5218E4;
        Thu,  2 Aug 2018 00:02:28 +0000 (UTC)
Subject: Re: [PATCH] mm/selftest: Add MAP_POPULATE test
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hua Zhong <hzhong@arista.com>,
        Stuart Ritchie <sritchie@arista.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180801233636.29354-1-dima@arista.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <84c3da30-f4fc-b82a-e8fc-49e365e4ac50@kernel.org>
Date:   Wed, 1 Aug 2018 18:02:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801233636.29354-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for the test. A few comments below.

On 08/01/2018 05:36 PM, Dmitry Safonov wrote:
> As many other projects, we use some shmalloc allocator.
> At some point we need to make a part of allocated pages back private to
> process. And it should be populated straight away.
> Check that (MAP_PRIVATE | MAP_POPULATE) actually copies the private page.

It is not clear from this commit log what this test is doing? It would
be helpful to rephrase.

"MAP_POPULATE | MAP_PRIVATE memory maps should COW VMA pages. This test is
for verifying that it does" something along the lines??

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Hua Zhong <hzhong@arista.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Stuart Ritchie <sritchie@arista.com>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  tools/testing/selftests/vm/.gitignore     |   1 +
>  tools/testing/selftests/vm/Makefile       |   1 +
>  tools/testing/selftests/vm/map_populate.c | 113 ++++++++++++++++++++++++++++++
>  tools/testing/selftests/vm/run_vmtests    |  11 +++
>  4 files changed, 126 insertions(+)
>  create mode 100644 tools/testing/selftests/vm/map_populate.c
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 342c7bc9dc8c..af5ff83f6d7f 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -1,6 +1,7 @@
>  hugepage-mmap
>  hugepage-shm
>  map_hugetlb
> +map_populate
>  thuge-gen
>  compaction_test
>  mlock2-tests
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index fdefa2295ddc..9881876d2aa0 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -12,6 +12,7 @@ TEST_GEN_FILES += gup_benchmark
>  TEST_GEN_FILES += hugepage-mmap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += map_hugetlb
> +TEST_GEN_FILES += map_populate
>  TEST_GEN_FILES += mlock-random-test
>  TEST_GEN_FILES += mlock2-tests
>  TEST_GEN_FILES += on-fault-limit
> diff --git a/tools/testing/selftests/vm/map_populate.c b/tools/testing/selftests/vm/map_populate.c
> new file mode 100644
> index 000000000000..df3eacc8eecb
> --- /dev/null
> +++ b/tools/testing/selftests/vm/map_populate.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Dmitry Safonov, Arista Networks
> + *
> + * MAP_POPULATE | MAP_PRIVATE should COW VMA pages.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#ifndef MMAP_SZ
> +#define MMAP_SZ		4096
> +#endif
> +
> +#define BUG_ON(condition, description)					\
> +	do {								\
> +		if (condition) {					\
> +			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
> +				__LINE__, (description), strerror(errno)); \
> +			exit(1);					\
> +		}							\
> +	} while (0)
> +
> +static int parent_f(int sock, unsigned long *smap, int child)
> +{
> +	int status, ret;
> +
> +	ret = read(sock, &status, sizeof(int));
> +	BUG_ON(ret <= 0, "read(sock)");
> +
> +	*smap = 0x22222BAD;
> +	ret = msync(smap, MMAP_SZ, MS_SYNC);
> +	BUG_ON(ret, "msync()");
> +
> +	ret = write(sock, &status, sizeof(int));
> +	BUG_ON(ret <= 0, "write(sock)");
> +
> +	waitpid(child, &status, 0);
> +	BUG_ON(!WIFEXITED(status), "child hasn't suicide by own will");

What does this mean? Could you rephrase this please?

> +
> +	return WEXITSTATUS(status);
> +}
> +
> +static int child_f(int sock, unsigned long *smap, int fd)
> +{
> +	int ret, buf = 0;
> +
> +	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_POPULATE, fd, 0);
> +	BUG_ON(smap == MAP_FAILED, "mmap()");
> +
> +	BUG_ON(*smap != 0xdeadbabe, "MAP_PRIVATE | MAP_POPULATE changed file");

What is expected here? What is expected?

> +
> +	ret = write(sock, &buf, sizeof(int));
> +	BUG_ON(ret <= 0, "write(sock)");
> +
> +	ret = read(sock, &buf, sizeof(int));
> +	BUG_ON(ret <= 0, "read(sock)");
> +
> +	BUG_ON(*smap == 0x22222BAD, "MAP_POPULATE didn't COW private page");
> +	BUG_ON(*smap != 0xdeadbabe, "mapping was corrupted");
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int sock[2], child, ret;
> +	FILE *ftmp;
> +	unsigned long *smap;
> +
> +	ftmp = tmpfile();
> +	BUG_ON(ftmp == 0, "tmpfile()");
> +
> +	ret = ftruncate(fileno(ftmp), MMAP_SZ);
> +	BUG_ON(ret, "ftruncate()");
> +
> +	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fileno(ftmp), 0);
> +	BUG_ON(smap == MAP_FAILED, "mmap()");
> +
> +	*smap = 0xdeadbabe;
> +	/* Probably unnecessary, but let it be. */
> +	ret = msync(smap, MMAP_SZ, MS_SYNC);
> +	BUG_ON(ret, "msync()");
> +
> +	ret = socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sock);
> +	BUG_ON(ret, "socketpair()");
> +
> +	child = fork();
> +	BUG_ON(child == -1, "fork()");
> +
> +	if (child) {
> +		ret = close(sock[0]);
> +		BUG_ON(ret, "close()");
> +
> +		return parent_f(sock[1], smap, child);
> +	}
> +
> +	ret = close(sock[1]);
> +	BUG_ON(ret, "close()");
> +
> +	return child_f(sock[0], smap, fileno(ftmp));
> +}
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
> index 88cbe5575f0c..584a91ae4a8f 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -168,6 +168,17 @@ else
>  fi
>  
>  echo "--------------------"
> +echo "running map_populate"
> +echo "--------------------"
> +./map_populate
> +if [ $? -ne 0 ]; then
> +	echo "[FAIL]"
> +	exitcode=1
> +else
> +	echo "[PASS]"
> +fi
> +
> +echo "--------------------"
>  echo "running mlock2-tests"
>  echo "--------------------"
>  ./mlock2-tests
> 

thanks,
-- Shuah
