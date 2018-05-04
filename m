Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZrSIea/lgYk7kD6Vm9vO2c00IrnFieB+7MKyhYs30ZngsWnHbt5h65Fuj6VDERnD468vruQ
ARC-Seal: i=1; a=rsa-sha256; t=1525448386; cv=none;
        d=google.com; s=arc-20160816;
        b=zG6LSVrjO4Ot1hPbJLyKQLN6ScI74pjMlF/AOvRW0mKtvJ7y8I9ifLjy1VlWnZkl72
         hKVl1cv4cHTB7Jd2L4MQTBs2G7i4xUoG+DsTI10Vr7RXIF8EamOt58DGJSiv9EVCDP0Y
         QyusDtOKTZxSOrpTJ1gmRZIqw25a4Xmn/jwXc9zSL4r9UJ458FiAph0hgQrQhoJjSMOy
         wQ6j8zstRTVoxW6D5W3pfDsIVXVcEmlupUTeyBXjV3TNJbIB4/XZnld8+WNfYGs3SNSE
         UYpJDzgc2Kkm5TDaJN/WGYTOhcogUU2/BBekjyh7As1YcbyIw0HDLMYDCKRsft8k0R3M
         h75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=2iLIgvSAHzvuLNjX3rAZGoR3rHzLa0ya8WFk87saRbA=;
        b=e0a6HbqNAmifPswclvV4IJmvvDC7moj1cvLXmJDU8NBB2EYCNze48Ya3GVb0UvIErq
         fiIng9Kbd0ssXa3sb65vaBCBVH0BchzpfA14CGuZ7QfeZoSxak/E2v3nh5kdFOrgtnOJ
         wrxaUofTrfMBQxVRb/Pmf2LbGdusyXiFD77IMhehDGWPzZhgOdfg0IiOTQi8k25f7f3y
         T2pTynHTf0Ap70sztSpp0d6EaUksFs1SSZjWNxUB8PY/kpmw2PUZN7D0UL21ZZgiqi9e
         b/irW9Af1/Xf/0A3WeNKIQQ3Jopt4B62UdzQlNcRO76XouI9WMLP2GLDx2KKmvBfDi7y
         xMUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VuT8xn2p;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VuT8xn2p;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180504141756.670dc3f3@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4fb39549-8902-950d-3076-82a11b1c5102@infradead.org>
Date: Fri, 4 May 2018 08:39:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504141756.670dc3f3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599505695773381278?=
X-GMAIL-MSGID: =?utf-8?q?1599548567788999273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/2018 09:17 PM, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm-current tree, today's linux-next build
> (x86_64_allmodconfig) produced this warning:
> 
> drivers/block/zram/zram_drv.c: In function 'read_block_state':
> drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
>     "%12lu %12llu.%06lu %c%c%c\n",
>            ~~~~~^
>            %12lu
>     (unsigned long)index, ts.tv_sec,
>                           ~~~~~~~~~
> 
> Introduced by commit
> 
>   827c7dbda8eb ("zram-introduce-zram-memory-tracking-update-fix-fix")
> 

typedef __s64 time64_t;

struct timespec64 {
	time64_t	tv_sec;			/* seconds */
	long		tv_nsec;		/* nanoseconds */
};

time64_t is signed. Also, %lu on i386 et al is for 32-bit longs.
I guess that "we" will need to cast ts.tv_sec to (s64) and use %lld to print it
in order to satisfy other $arch.

Andrew, want to add a fix-fix-fix patch?

-- 
~Randy
