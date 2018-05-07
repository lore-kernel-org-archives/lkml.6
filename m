Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeEGSpn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:45:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:59730 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeEGSpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:45:41 -0400
Subject: Re: [PATCH 21/24] selftests: memfd: return Kselftest Skip code for
 skipped tests
To: Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        marcandre.lureau@redhat.com, lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-21-shuah@kernel.org>
 <a5fff7b0-f308-25bc-909b-8579f6f14546@oracle.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f2b3f38a-7c7a-43ec-9c2d-94bbb7d56eb7@kernel.org>
Date: Mon, 7 May 2018 12:45:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a5fff7b0-f308-25bc-909b-8579f6f14546@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 07:52 PM, Mike Kravetz wrote:
> On 05/04/2018 06:13 PM, Shuah Khan (Samsung OSG) wrote:
>> When memfd test is skipped because of unmet dependencies and/or unsupported
>> configuration, it returns non-zero value which is treated as a fail by the
>> Kselftest framework. This leads to false negative result even when the test
>> could not be run.
>>
>> Change it to return kselftest skip code when a test gets skipped to
>> clearly report that the test could not be run.
>>
>> Added an explicit check for root user and return skip code.
>>
>> Kselftest framework SKIP code is 4 and the framework prints appropriate
>> messages to indicate that the test is skipped.
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>> ---
>>  tools/testing/selftests/memfd/run_tests.sh | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
>> index c2d41ed81b24..88dc206a69b7 100755
>> --- a/tools/testing/selftests/memfd/run_tests.sh
>> +++ b/tools/testing/selftests/memfd/run_tests.sh
>> @@ -1,6 +1,14 @@
>>  #!/bin/bash
>>  # please run as root
>>  
>> +# Kselftest framework requirement - SKIP code is 4.
>> +ksft_skip=4
>> +
>> +if [ $UID != 0 ]; then
>> +	echo "Please run this test as root"
>> +	exit $ksft_skip
>> +fi
>> +
>>  #
>>  # Normal tests requiring no special resources
>>  #
>> @@ -33,7 +41,7 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
>>  	echo $(( $hpages_needed + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
>>  	if [ $? -ne 0 ]; then
>>  		echo "Please run this test as root"
>> -		exit 1
>> +		exit $ksft_skip
> 
> We now KNOW that we are running as root because of the check above.  We
> can delete this test, and rely on the later check to determine if the
> number of huge pages was actually increased.

Thanks for the review. Yesh this check can go away.

> 
> How about this instead (untested)?
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
> index c2d41ed81b24..99a265a84e1d 100755
> --- a/tools/testing/selftests/memfd/run_tests.sh
> +++ b/tools/testing/selftests/memfd/run_tests.sh
> @@ -1,6 +1,14 @@
>  #!/bin/bash
>  # please run as root
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if [ $UID != 0 ]; then
> +	echo "Please run this test as root"
> +	exit $ksft_skip
> +fi
> +
>  #
>  # Normal tests requiring no special resources
>  #
> @@ -31,10 +39,6 @@ if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
>  
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

I thought about changing this to skip and wasn't sure since the test did
run partially. Good to know this case can be classified as skip. I will
make the suggested changes and send v2.

thanks,
-- Shuah
