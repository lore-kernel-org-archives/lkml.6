Return-Path: <eric.dumazet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525894601; cv=none;
        d=google.com; s=arc-20160816;
        b=vsrWQH+T+xFiG1h7t0nfRumLdC50oR3vACIlanpl9S7UCBspv9+PLMNK8I8sSBX95j
         6CtDWRtrdPMvPtkcB72YtNffQHePT8z8aajYfnCX9Eh4K9OmuECWRwUNrbXaRoTW9n+p
         RwQU6KjqZsbNIlN1OVZJHQ8SopZaqU6IbksuEu6uQPnEYULm6ExyBXKLy5okBZLRTxH/
         ZXoKTkkLwWqAjERKI1JJR/2mrkhyLrcXJTnYQNBJmWrrXCQsA8Lb+DWbfkKEMMS99QQp
         3DzwlPDD0RVa+S634hzkFuynIhJsGrSNU69Cdh/CwFim2/ht7/4zMg3MZjLTa/StXQZO
         a1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=7mMYyONXGOvVYGSZWBpHigjIu3Wo5pOHgfWyRR2AfZU=;
        b=YYHtfgWcUuNcOTNgYFT28h/5ZOCJ5M9k60zYZ0mRxeZ5DzpWP/M6S1IPuC2Sx8PC7A
         ghC2fuJUKcwSXQ66a3THGTBuDqZb6nYz5Xcn/Ra+td8fJSH3jvhlYP8qtrtvY7JeZ1XM
         7tKlHHR/kt3IJ5apNPQoUysj4BPqGph81u6//vPk3zoLmG9UvIqeEEbO58vdy2VJxFbC
         WX1PzDeGLkQyM2whdE4WgyfUJ3LB+PFWipxenuf/jWWVWr8vLAcAwXZVY13q3X8KX320
         wY+lNrt7EhEs6FF5sEO6qluZG5/4aj6gIX/N6VZi1qdpL9lL5CqesnV7KKpprw0cO7Ph
         l2RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bykN2bDC;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bykN2bDC;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp1mkQOxZS5QkxwXsChoI7AhX1mGsW09qxUXNh85iho9gSnqq7VDZZjAjbAE4/+nkJullixdA==
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Biggers <ebiggers3@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
 alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
 Anoob Soman <anoob.soman@citrix.com>, chris@chris-wilson.co.uk,
 David Miller <davem@davemloft.net>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 Mike Maloney <maloney@google.com>, mchehab@kernel.org,
 netdev <netdev@vger.kernel.org>, "Rosen, Rami" <rami.rosen@intel.com>,
 Sowmini Varadhan <sowmini.varadhan@oracle.com>,
 syzkaller-bugs@googlegroups.com, Willem de Bruijn <willemb@google.com>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com>
 <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com> <20180509073754.GG711@sol.localdomain>
 <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
 <CAF=yD-KGO=+=j3yTr4H8cF_WH3RGtnyMDgYRzd7da-r7D=U=GQ@mail.gmail.com>
 <CAF=yD-JPmU-q1iUoxtmyQa4BM=fU3CMR3BUDGNMg-4v8=2_deA@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e7be4d14-be04-c40d-82ad-2050876f9ce9@gmail.com>
Date: Wed, 9 May 2018 12:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JPmU-q1iUoxtmyQa4BM=fU3CMR3BUDGNMg-4v8=2_deA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1600016457147607766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/09/2018 12:21 PM, Willem de Bruijn wrote:

> Indeed. The skb shared info struct is zeroed by dev_validate_header
> as a result of dev->hard_header_len exceeding skb->end - skb->data.
> 
> Not exactly sure yet how this can happen. The hard header length space
> is accounted for during allocation as reserved memory. But,
> packet_alloc_skb does call skb_reserve(), moving skb->data
> effectively beyond this reserved region.
> 
> It may be incorrect to pass skb->data to dev_validate_header, as that
> does not point to the start of the ll_header anymore. Still figuring out what
> the right fix is..
> 

I believe the bug happens if the sock_wmalloc() call at line 1921 has to sleep.

device can change (or at lest dev->hard_header_len can change)

So we need to bailout if reserved/hhlen had changed.

Or revert some patches, since dev_hold() and dev_put() are no longer high cost,
since it is now using per cpu counter.

 
