Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeEHAV1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:21:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753705AbeEHAVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:21:24 -0400
Subject: Re: [PATCH v2 21/24] selftests: memfd: return Kselftest Skip code for
 skipped tests
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        akpm@linux-foundation.org, marcandre.lureau@redhat.com,
        lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180507230116.27652-1-shuah@kernel.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c1ad2960-7294-4370-a7b6-06a709bf247d@oracle.com>
Date: Mon, 7 May 2018 17:20:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180507230116.27652-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 04:01 PM, Shuah Khan (Samsung OSG) wrote:
> When memfd test is skipped because of unmet dependencies and/or unsupported
> configuration, it returns non-zero value which is treated as a fail by the
> Kselftest framework. This leads to false negative result even when the test
> could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to clearly
> report that the test could not be run.
> 
> Added an explicit check for root user at the start of memfd hugetlbfs test
> and return skip code if a non-root user attempts to run it.
> 
> In addition, return skip code when not enough huge pages are available to
> run the test.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Thanks for making the changes!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
> ---
> 
> Changes since v1:
> -- addressed review comments on v1
> -- Fixed a regression in v1 that changed the behavior to require root
>    for all tests not just the hugetlbfs test.
> 
>  tools/testing/selftests/memfd/run_tests.sh | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
> index c2d41ed81b24..2013f195e623 100755
> --- a/tools/testing/selftests/memfd/run_tests.sh
> +++ b/tools/testing/selftests/memfd/run_tests.sh
> @@ -1,6 +1,9 @@
>  #!/bin/bash
>  # please run as root
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  #
>  # Normal tests requiring no special resources
>  #
> @@ -29,12 +32,13 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
>  	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
>  	hpages_needed=`expr $hpages_test - $freepgs`
>  
> +	if [ $UID != 0 ]; then
> +		echo "Please run memfd with hugetlbfs test as root"
> +		exit $ksft_skip
> +	fi
> +
>  	echo 3 > /proc/sys/vm/drop_caches
>  	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
> -	if [ $? -ne 0 ]; then
> -		echo "Please run this test as root"
> -		exit 1
> -	fi
>  	while read name size unit; do
>  		if [ "$name" = "HugePages_Free:" ]; then
>  			freepgs=$size
> @@ -53,7 +57,7 @@ if [ $freepgs -lt $hpages_test ]; then
>  	fi
>  	printf "Not enough huge pages available (%d < %d)\n" \
>  		$freepgs $needpgs
> -	exit 1
> +	exit $ksft_skip
>  fi
>  
>  #
> 
