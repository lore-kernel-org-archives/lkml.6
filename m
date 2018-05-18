Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqYXujJtQtjTIud/lwgNCNJ6UVL+7h3LCGQwcfreEy8zbbgb1xLEMJzdkTk4g/G4G+oqZQY
ARC-Seal: i=1; a=rsa-sha256; t=1526671166; cv=none;
        d=google.com; s=arc-20160816;
        b=WdCzW8SRaUiJkEv9vJbRbOivf7xzha6OB4fBNJz2cYbkknSEGVDaUMAqB69o1cVQ9j
         QSmXDhqJrgj7g5H/4MSthunGCaluOPpmqbwAdsLy7hADpXBkDY3Q4qnDezUwyWfm03py
         5ZVf7+8PmI85NexT3zdLKuBaEPVOYavBKVuu9cUwi9PCSHw9frmISpb+XQiK8Di7V7k0
         aUoNubDIsdL+jXNPz7i2QRisTqTALamUdYxazayzulJnsnOi/V2wX5VrXiDP61AaI28I
         AFS887KwpGCM2YPI/Dstb+SRBKtMB9lhJHwwuibmKZMuWiW5cBVy5gz6X3cHa0E1uq3X
         iZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=dWlJdaJTyVnIWE4AnDjvjatRYylD9Wc/foC/xnzvAbM=;
        b=rsbPZU4mwbtYUqKh56lwGMcl/LWYyzeMu7oMH+T2JCpIMUL7lWpdswVAVsmObVUX0o
         r5Zu/kr9NEIiwCHipY7UfZnGvDYX9WXijSFXmd9qBT//qOG3630li/bsS/DvE0gZ1H3+
         HKRdBPCidRaZCOUvfA+Uz0oDzB/+fRp3QuTA2x5dZKhtcFNoc34bCupbvhpQ/04M3Fff
         205sWW3Rn0mpdsZVn81sVlcKsk6FBHoaL0hMsMqzA3Kp1Xema9rPu3PqIJseCTAQKrpH
         DIP6lOSrAUFTUIs9vhKDrCG5htD3SEwnLlucVrbWAgKQWmQ1XGNdFOui7ThBRM0dpMRd
         /PEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftest: intel_pstate: debug support message from
 aperf.c and return value fix.
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180518140550.2280-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <4f51f365-705a-211f-cccb-c634ea750dc6@kernel.org>
Date: Fri, 18 May 2018 13:19:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518140550.2280-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600811069911886051?=
X-GMAIL-MSGID: =?utf-8?q?1600830745581758102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 08:05 AM, Jeffrin Jose T wrote:
> Additional message along with an error message which is more
> verbose for debug support from aperf.c and updated with the
> new return value "KSFT_SKIP".
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/intel_pstate/aperf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
> index d21edea9c560..f6cd03a87493 100644
> --- a/tools/testing/selftests/intel_pstate/aperf.c
> +++ b/tools/testing/selftests/intel_pstate/aperf.c
> @@ -9,6 +9,8 @@
>  #include <sys/timeb.h>
>  #include <sched.h>
>  #include <errno.h>
> +#include <string.h>
> +#include "../kselftest.h"
>  
>  void usage(char *name) {
>  	printf ("Usage: %s cpunum\n", name);
> @@ -41,8 +43,8 @@ int main(int argc, char **argv) {
>  	fd = open(msr_file_name, O_RDONLY);
>  
>  	if (fd == -1) {
> -		perror("Failed to open");
> -		return 1;
> +		printf("/dev/cpu/%d/msr: %s\n", cpu, strerror(errno));
> +		return KSFT_SKIP;
>  	}
>  
>  	CPU_ZERO(&cpuset);
> 

Thanks. I will queue this up for 4.18-rc1

thanks,
-- Shuah
