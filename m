Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZpcnRRY9+R9WfTVjFtVxvFxzJb0SQgZv3w1nBpsvgbMaH4g3IeXlhQHq34NgL7xRogrxlu2
ARC-Seal: i=1; a=rsa-sha256; t=1526415792; cv=none;
        d=google.com; s=arc-20160816;
        b=DbswGULmhs/U6FfIXR/YtyKJCcW0QBoXrx7AX9SEdEaG8RIOM2MouKKFdBNHFipuSF
         lBkv7APUoEIa8lt75PqY7cyUhwqb0mJefCb1OtwAcpxomZOeCwznto8oLAcJsow4cIGB
         jtU4scI3lWM0C+1z0d8A3XzFa6GYNgCR0UPn3nzBQcfHALNipXNY+EwcN6Jnc4bGn4/j
         pZzTdJTtt/YWNQ9dy65y6Trt0TVH/fz3aI3ilzgi4HKIwFnvWhpuTq2TpZebpGeJ6BE5
         VwuxOVyF1dDLJ1aSPJaF1YHGHA/yRezdd36DegQC/MCLaZRgx7XLi5I7AXmWO9t9mRgY
         OqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=oDh03Jqs41dasKqqesiHQtOHhJjbCIJ6m47lO+YHOts=;
        b=FAE3x/UNvaS6s8PcVy7pr4pofsRx0ORwYEACIGwrzspi/vHlWsoUMXGBRNYocHXuIn
         sQLbiigsdCznIS17ekWK0PZWdjFLkY+DTZL461k4OVo/D35VDUl7abWUze0bwESTSJu1
         KbwmmOKrnnMqXlNQMa1A64/p/bvGZfODVeCaqf2xwT/Jg/6BIU2QPR8dWuvVLxaOJoak
         kW0VETkP1kQEC+uXM9Reboa5586cnctDFlYAGd6G7ADcdgiGhY/IaXQfxcAMMQ8tHEz5
         YfoGbl24okhLZjqs3eQHQIu9cyvEGYorJXQs+ZBNz8XVqfKfBge6oqR+SxydPnz10thk
         0GyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftest: intel_pstate: More accurate error message and
 also a debug support message from aperf.c
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180514220154.9507-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f84c3812-8c4f-fa4a-962e-256dbc6d66df@kernel.org>
Date: Tue, 15 May 2018 14:22:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514220154.9507-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600478158436689024?=
X-GMAIL-MSGID: =?utf-8?q?1600562966674987423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 04:01 PM, Jeffrin Jose T wrote:
> Fix for  aperf.c to produce the path of the file which is in mention
> during error report.CONFIG_X86_MSR=m support requirement is also mentioned.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/intel_pstate/aperf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
> index d21edea9c560..da98c1673f08 100644
> --- a/tools/testing/selftests/intel_pstate/aperf.c
> +++ b/tools/testing/selftests/intel_pstate/aperf.c
> @@ -41,7 +41,9 @@ int main(int argc, char **argv) {
>  	fd = open(msr_file_name, O_RDONLY);
>  
>  	if (fd == -1) {
> -		perror("Failed to open")> +		printf("Failed to open /dev/cpu/%d/msr:", cpu);

Why are you deleting perror() and add a printf() for the error message perror()
printf()?

Why not collapse these messages into one and use strerror() to include the
error string? 
> +		printf(" No such file or directory:")

Not necessarily. open(0 could fail due to insufficient permissions. That is why
using strerror() or perror() is the correct way so the real error message gets
printed.

> +		printf(" Make sure CONFIG_X86_MSR=m support is Enabled\n");

Might not be the real reason why the opeN() failed.

>  		return 1;
>  	}

The return should be KSFT_SKIP instead of 1
>  
> 

thanks,
-- Shuah
