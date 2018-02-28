Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeB1IIP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:08:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750846AbeB1IIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:08:14 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/vm: Update max va test to check for high address return.
In-Reply-To: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 13:38:05 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022808-0040-0000-0000-00000438B362
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022808-0041-0000-0000-000020DAE37A
Message-Id: <87vaeha656.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280096
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> mmap(-1,..) is expected to search from max supported VA top down. It should find
> an address above ADDR_SWITCH_HINT. Explicitly check for this.
>
> Also derefer the address even if we failed the addr check.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

One issue I noticed is how to make this conditional so that we can still
run the test on x86 with 4 level page table?

> ---
>  tools/testing/selftests/vm/va_128TBswitch.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
> index e7fe734c374f..f68fa4bd8179 100644
> --- a/tools/testing/selftests/vm/va_128TBswitch.c
> +++ b/tools/testing/selftests/vm/va_128TBswitch.c
> @@ -44,6 +44,7 @@ struct testcase {
>  	unsigned long flags;
>  	const char *msg;
>  	unsigned int low_addr_required:1;
> +	unsigned int high_addr_required:1;
>  	unsigned int keep_mapped:1;
>  };
>  
> @@ -108,6 +109,7 @@ static struct testcase testcases[] = {
>  		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(HIGH_ADDR)",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = HIGH_ADDR,
> @@ -115,12 +117,14 @@ static struct testcase testcases[] = {
>  		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(HIGH_ADDR) again",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = HIGH_ADDR,
>  		.size = 2 * PAGE_SIZE,
>  		.flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
>  		.msg = "mmap(HIGH_ADDR, MAP_FIXED)",
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = (void *) -1,
> @@ -128,12 +132,14 @@ static struct testcase testcases[] = {
>  		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(-1)",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = (void *) -1,
>  		.size = 2 * PAGE_SIZE,
>  		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(-1) again",
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = ((void *)(ADDR_SWITCH_HINT - PAGE_SIZE)),
> @@ -193,6 +199,7 @@ static struct testcase hugetlb_testcases[] = {
>  		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB)",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = HIGH_ADDR,
> @@ -200,12 +207,14 @@ static struct testcase hugetlb_testcases[] = {
>  		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB) again",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = HIGH_ADDR,
>  		.size = HUGETLB_SIZE,
>  		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
>  		.msg = "mmap(HIGH_ADDR, MAP_FIXED | MAP_HUGETLB)",
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = (void *) -1,
> @@ -213,12 +222,14 @@ static struct testcase hugetlb_testcases[] = {
>  		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(-1, MAP_HUGETLB)",
>  		.keep_mapped = 1,
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = (void *) -1,
>  		.size = HUGETLB_SIZE,
>  		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
>  		.msg = "mmap(-1, MAP_HUGETLB) again",
> +		.high_addr_required = 1,
>  	},
>  	{
>  		.addr = (void *)(ADDR_SWITCH_HINT - PAGE_SIZE),
> @@ -257,14 +268,16 @@ static int run_test(struct testcase *test, int count)
>  		if (t->low_addr_required && p >= (void *)(ADDR_SWITCH_HINT)) {
>  			printf("FAILED\n");
>  			ret = 1;
> -		} else {
> -			/*
> -			 * Do a dereference of the address returned so that we catch
> -			 * bugs in page fault handling
> -			 */
> -			memset(p, 0, t->size);
> +		} else if (t->high_addr_required && p < (void *)(ADDR_SWITCH_HINT)) {
> +			printf("FAILED\n");
> +			ret = 1;
> +		} else
>  			printf("OK\n");
> -		}
> +		/*
> +		 * Do a dereference of the address returned so that we catch
> +		 * bugs in page fault handling
> +		 */
> +		memset(p, 0, t->size);
>  		if (!t->keep_mapped)
>  			munmap(p, t->size);
>  	}
> -- 
> 2.14.3
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
