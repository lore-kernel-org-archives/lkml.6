Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42807C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1B52087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvRRzD6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1B52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJOPYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:24:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48534 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:24:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9F7cjcO097336;
        Mon, 15 Oct 2018 07:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tWquGZC6Vj2OTgZwo0jlvbM45EB+h7NpM3nI9mEzztc=;
 b=hvRRzD6NUdAZqduEMaALFHGmHVhm3XWM2PHngIijwNV4ogHD0Cl/dnR6atpjT+wtp7dp
 PR/gNsu4rVEEhJs1LxAgTtBT3yG7vvwHUKMCxNeH1+vZt37N/a1AZLJaEGOltpWJp/UL
 xGyT/+YMH9peOdDs5UwQ3OkDYylPEmVRwZnWgOIssZUvzPG7gwxGRg4RuIsA3QtQjKX4
 U1hbcACN/l9xMSAuINWGzR5J6jsbZ69Z35zyMT+B6gdFps3uUGbZevUM7V95nIyBQIHI
 tHfsgCRZeIDxKakqRCRUeFMc25cx6qN79yKiumZS17/QLc+1pi2u/wjM3jWsHNHujnW6 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38nprpw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 07:39:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9F7dakc022981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 07:39:37 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9F7dZZh020763;
        Mon, 15 Oct 2018 07:39:35 GMT
Received: from [10.191.235.38] (/10.191.235.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 00:39:35 -0700
Subject: Re: [PATCH] selftests/vm: Add a test for MAP_FIXED_NOREPLACE
To:     Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jannh@google.com, mhocko@suse.com,
        linux-mm@kvack.org, aarcange@redhat.com, fweimer@redhat.com,
        jhubbard@nvidia.com, willy@infradead.org,
        abdhalee@linux.vnet.ibm.com, joel@jms.id.au, keescook@chromium.org,
        jasone@google.com, davidtgoldblatt@gmail.com, trasz@freebsd.org,
        danielmicay@gmail.com
References: <20181013133929.28653-1-mpe@ellerman.id.au>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <eb618206-4343-6c95-4db4-91bee48dc4b2@oracle.com>
Date:   Mon, 15 Oct 2018 01:39:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013133929.28653-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9046 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2018 07:39 AM, Michael Ellerman wrote:
> Add a test for MAP_FIXED_NOREPLACE, based on some code originally by
> Jann Horn. This would have caught the overlap bug reported by Daniel Micay.
> 
> I originally suggested to Michal that we create MAP_FIXED_NOREPLACE, but
> instead of writing a selftest I spent my time bike-shedding whether it
> should be called MAP_FIXED_SAFE/NOCLOBBER/WEAK/NEW .. mea culpa.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

--
Khalid

>   tools/testing/selftests/vm/.gitignore         |   1 +
>   tools/testing/selftests/vm/Makefile           |   1 +
>   .../selftests/vm/map_fixed_noreplace.c        | 206 ++++++++++++++++++
>   3 files changed, 208 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/map_fixed_noreplace.c
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index af5ff83f6d7f..31b3c98b6d34 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -13,3 +13,4 @@ mlock-random-test
>   virtual_address_range
>   gup_benchmark
>   va_128TBswitch
> +map_fixed_noreplace
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index e94b7b14bcb2..6e67e726e5a5 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -12,6 +12,7 @@ TEST_GEN_FILES += gup_benchmark
>   TEST_GEN_FILES += hugepage-mmap
>   TEST_GEN_FILES += hugepage-shm
>   TEST_GEN_FILES += map_hugetlb
> +TEST_GEN_FILES += map_fixed_noreplace
>   TEST_GEN_FILES += map_populate
>   TEST_GEN_FILES += mlock-random-test
>   TEST_GEN_FILES += mlock2-tests
> diff --git a/tools/testing/selftests/vm/map_fixed_noreplace.c b/tools/testing/selftests/vm/map_fixed_noreplace.c
> new file mode 100644
> index 000000000000..d91bde511268
> --- /dev/null
> +++ b/tools/testing/selftests/vm/map_fixed_noreplace.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test that MAP_FIXED_NOREPLACE works.
> + *
> + * Copyright 2018, Jann Horn <jannh@google.com>
> + * Copyright 2018, Michael Ellerman, IBM Corporation.
> + */
> +
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#ifndef MAP_FIXED_NOREPLACE
> +#define MAP_FIXED_NOREPLACE 0x100000
> +#endif
> +
> +#define BASE_ADDRESS	(256ul * 1024 * 1024)
> +
> +
> +static void dump_maps(void)
> +{
> +	char cmd[32];
> +
> +	snprintf(cmd, sizeof(cmd), "cat /proc/%d/maps", getpid());
> +	system(cmd);
> +}
> +
> +int main(void)
> +{
> +	unsigned long flags, addr, size, page_size;
> +	char *p;
> +
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +
> +	flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE;
> +
> +	// Check we can map all the areas we need below
> +	errno = 0;
> +	addr = BASE_ADDRESS;
> +	size = 5 * page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p == MAP_FAILED) {
> +		dump_maps();
> +		printf("Error: couldn't map the space we need for the test\n");
> +		return 1;
> +	}
> +
> +	errno = 0;
> +	if (munmap((void *)addr, 5 * page_size) != 0) {
> +		dump_maps();
> +		printf("Error: munmap failed!?\n");
> +		return 1;
> +	}
> +	printf("unmap() successful\n");
> +
> +	errno = 0;
> +	addr = BASE_ADDRESS + page_size;
> +	size = 3 * page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p == MAP_FAILED) {
> +		dump_maps();
> +		printf("Error: first mmap() failed unexpectedly\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Exact same mapping again:
> +	 *   base |  free  | new
> +	 *     +1 | mapped | new
> +	 *     +2 | mapped | new
> +	 *     +3 | mapped | new
> +	 *     +4 |  free  | new
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS;
> +	size = 5 * page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p != MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:1: mmap() succeeded when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Second mapping contained within first:
> +	 *
> +	 *   base |  free  |
> +	 *     +1 | mapped |
> +	 *     +2 | mapped | new
> +	 *     +3 | mapped |
> +	 *     +4 |  free  |
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS + (2 * page_size);
> +	size = page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p != MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:2: mmap() succeeded when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Overlap end of existing mapping:
> +	 *   base |  free  |
> +	 *     +1 | mapped |
> +	 *     +2 | mapped |
> +	 *     +3 | mapped | new
> +	 *     +4 |  free  | new
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS + (3 * page_size);
> +	size = 2 * page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p != MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:3: mmap() succeeded when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Overlap start of existing mapping:
> +	 *   base |  free  | new
> +	 *     +1 | mapped | new
> +	 *     +2 | mapped |
> +	 *     +3 | mapped |
> +	 *     +4 |  free  |
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS;
> +	size = 2 * page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p != MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:4: mmap() succeeded when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Adjacent to start of existing mapping:
> +	 *   base |  free  | new
> +	 *     +1 | mapped |
> +	 *     +2 | mapped |
> +	 *     +3 | mapped |
> +	 *     +4 |  free  |
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS;
> +	size = page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p == MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:5: mmap() failed when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Adjacent to end of existing mapping:
> +	 *   base |  free  |
> +	 *     +1 | mapped |
> +	 *     +2 | mapped |
> +	 *     +3 | mapped |
> +	 *     +4 |  free  |  new
> +	 */
> +	errno = 0;
> +	addr = BASE_ADDRESS + (4 * page_size);
> +	size = page_size;
> +	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
> +	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +
> +	if (p == MAP_FAILED) {
> +		dump_maps();
> +		printf("Error:6: mmap() failed when it shouldn't have\n");
> +		return 1;
> +	}
> +
> +	addr = BASE_ADDRESS;
> +	size = 5 * page_size;
> +	if (munmap((void *)addr, size) != 0) {
> +		dump_maps();
> +		printf("Error: munmap failed!?\n");
> +		return 1;
> +	}
> +	printf("unmap() successful\n");
> +
> +	printf("OK\n");
> +	return 0;
> +}
> 

