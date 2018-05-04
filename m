Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZrkBVw0aDSL32+uA+tu6s5MALpor6D12oCB20zRoVG27fHSo8buE8wIDgdQ9t1sTXEMrdn6
ARC-Seal: i=1; a=rsa-sha256; t=1525463289; cv=none;
        d=google.com; s=arc-20160816;
        b=v61AwH9R1p+p3hBXvVJlx/wy+lml3hscEmbRfQBkwJ3vHmYPBp+mC9qNuTqCHVJ47e
         qhQT9CUpKczynBqx06ib2axiS0mdyZnoq/lTAu/8vuLW3RmCoQ1NsdglVaK4sEPQAp6i
         MHr7VQNFpuuru/pl6FTmdBlc+w5MusF10j8OqkgAq9rs9gs15Vh6OHdWrt8gM/vbOAzw
         TZ5qEFVe9nrYQSmmG+e8mA6C9nEG60P468dThEQodZhDFKQsa+TPPWsOlUG0VeQzSjut
         4f9mhSko1WgsuILAexn45lK8BnmW4I4ksr4l+lP7kmLBZm/7Ih5ejIon7ILB1QQIWLUU
         kBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=FuVoqYN8z6kCbqfdBr0GTUYil3FiMNzHifg8CkTSZNc=;
        b=w190wBEVqV3vzdVcRZsvErqDEjq/DiyZGpnpji0EOxNQufXDGgmQ7PwZtwDMLLfP9X
         ohnBSjGVVETWYS0ygyA4IDw7Y/OXrbzm2b8C4fVHEyGA8wmSkbmRHo7nuJzOKc6nc+RY
         EXZHfGbnTISbbEWSc7BX1CZlquUWynC6h592NkN2W46BDXw7PhfyqELxC26mj9FcszqW
         QQRNP423EYmW+AB+C2Iujyi/3Lu0G8gnYPStlPjgR7iN8/EkaJ60lFq5Y5s9C4LnaLLS
         bdAnIWX6chXRjWHWR+z4kyqs/JPv+OFqB2a9/lTFoygMl9z4ZRjhtg8jmeadQa3UXJCU
         KUKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftests:intel_pstate: fixes typical crash of a testing
 script for Intel P-State driver
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
 daniel.diaz@linaro.org, pombredanne@nexb.com, gregkh@linuxfoundation.org,
 thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180429191226.14242-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <62c2484a-b8fe-513c-a9c7-dff1f3f3979a@kernel.org>
Date: Fri, 4 May 2018 13:47:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429191226.14242-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599109031684062016?=
X-GMAIL-MSGID: =?utf-8?q?1599564193861056648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/29/2018 01:12 PM, Jeffrin Jose T wrote:
>  Testing script for Intel P-State driver crashes during
>  the run.  this patch fixes that crash and produce typical results.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> 
> ---
>  tools/testing/selftests/intel_pstate/run.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index c670359becc6..cd32aca8806f 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -27,6 +27,7 @@
>  # and the test will error out in those cases.  The result.X file can be checked
>  # for consistency and modified to remove the extra MHz values.  The result.X
>  # files can be re-evaluated by setting EVALUATE_ONLY to 1 below.
> +#set -xv
>  
>  EVALUATE_ONLY=0
>  
> @@ -101,12 +102,13 @@ cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
>  echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
>  for freq in `seq $max_freq -100 $min_freq`
>  do
> -	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
> +       result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" \
>         | awk '{print $4}' | awk -F "." '{print $1}')
> +	result_freq=$(echo $result_freq | head -n1 | cut -d " " -f1)
>  	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
>  	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
> -	if [ $result_freq -eq $freq ]; then
> +	if (( "$result_freq" == "$freq" ))
> +	then
>  		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
>  	else
>  		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
> 

Thanks. I will get this into 4.17-rc5

-- Shuah
