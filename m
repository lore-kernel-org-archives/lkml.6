Return-Path: <mattst88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522982911; cv=none;
        d=google.com; s=arc-20160816;
        b=wXnjOErZx3SoJxA/Os+1mEpXL//GWEkbW0oDSthW8m7p+dJwBsrwk5D1QCR5ZmVHeK
         UAeTJHhvhs9ZISX1caVOVIrpph2mUNlSVEH/xd0ndzGHk6681Vf53ki1/OjfAOFv2+em
         bBibIQehRjPhaO+wwv0JbwUu/uy7S7nHs2mr7jNSOV8deRas/STgE8hug1WqLxN9y21U
         djOSklr1RfyS2nTXdHtZknHQ9Gl8n6QMy5lzuGa044RKgsgY3OSIGaEcbqwPbKTO/FX1
         g+9uaAYWbuSllt7fjpCEH1FzHBDfvcbarXXQl4vn6XOINg6CGndOmYI9itrKdxKRMMiG
         FeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GtELyCStUh+SeGJAp5V5A1QYyaK3cae4sEDbLq2+wQw=;
        b=SA51lrpHTwX29iUC8F9W1Z57RSB+meNf8NtESGgMdzRTF0Ar1/BN0/kCj1HcCSpshJ
         Qwmi85M0IENQLAqYuz2MA48XbqALFvDdbDJEHjGj9PwysaJhxNwxsZ4veDvdvx3LwLUc
         N34m6v88W5aJud7iclf3IrnQAS4Tpp/lX75kph0Q3pJoYKMfsq3Tzi12TfAmAQJ83XxQ
         +o9DuxxTogFBI1yNC1bskayOVFOssJ6cgI1HFsu2vL2EJCpDG+uUN0yOo+t7bAOhnhev
         IUlsPh3ilK9ec2cy1BsV8n18UaNMXrfa9vBqnhbZP5x/SpMknjVRStcmj/PHiqOsIwNC
         NGsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XM4TG9P9;
       spf=pass (google.com: domain of mattst88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mattst88@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XM4TG9P9;
       spf=pass (google.com: domain of mattst88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mattst88@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+QqwgWllPym9c6ITN+qe0qwNKfC5JeD9pzREZoMElFdfJumbh6m1MMthgWrk7fXJIrbmg23CvTlGhirZaMzBA=
MIME-Version: 1.0
In-Reply-To: <3c28281e-de52-abbe-36bc-06f5527da921@codeaurora.org>
References: <1522691281-21593-1-git-send-email-okaya@codeaurora.org> <3c28281e-de52-abbe-36bc-06f5527da921@codeaurora.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 5 Apr 2018 19:48:10 -0700
Message-ID: <CAEdQ38G9UAj4SCPXcG_gVPnPg+ceWze71E3HaA9StgEybn-Ruw@mail.gmail.com>
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-alpha <linux-alpha@vger.kernel.org>, timur@codeaurora.org,
	sulrich@codeaurora.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Kate Stewart <kstewart@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596657541952033644?=
X-GMAIL-MSGID: =?utf-8?q?1596963329107288786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 6:35 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/2/2018 1:48 PM, Sinan Kaya wrote:
>> memory-barriers.txt has been updated with the following requirement.
>>
>> "When using writel(), a prior wmb() is not needed to guarantee that the
>> cache coherent memory writes have completed before writing to the MMIO
>> region."
>>
>> Current writeX() and iowriteX() implementations on alpha are not
>> satisfying this requirement as the barrier is after the register write.
>>
>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>> observes memory changes before performing register operations.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/alpha/include/asm/io.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
>> index d123ff9..4c533fc 100644
>> --- a/arch/alpha/include/asm/io.h
>> +++ b/arch/alpha/include/asm/io.h
>> @@ -341,14 +341,14 @@ extern inline unsigned int ioread16(void __iomem *addr)
>>
>>  extern inline void iowrite8(u8 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite8)(b, addr);
>>  }
>>
>>  extern inline void iowrite16(u16 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite16)(b, addr);
>>  }
>>
>>  extern inline u8 inb(unsigned long port)
>> @@ -382,8 +382,8 @@ extern inline unsigned int ioread32(void __iomem *addr)
>>
>>  extern inline void iowrite32(u32 b, void __iomem *addr)
>>  {
>> -     IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
>>       mb();
>> +     IO_CONCAT(__IO_PREFIX, iowrite32)(b, addr);
>>  }
>>
>>  extern inline u32 inl(unsigned long port)
>> @@ -434,14 +434,14 @@ extern inline u16 readw(const volatile void __iomem *addr)
>>
>>  extern inline void writeb(u8 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writeb(b, addr);
>>       mb();
>> +     __raw_writeb(b, addr);
>>  }
>>
>>  extern inline void writew(u16 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writew(b, addr);
>>       mb();
>> +     __raw_writew(b, addr);
>>  }
>>  #endif
>>
>> @@ -482,14 +482,14 @@ extern inline u64 readq(const volatile void __iomem *addr)
>>
>>  extern inline void writel(u32 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writel(b, addr);
>>       mb();
>> +     __raw_writel(b, addr);
>>  }
>>
>>  extern inline void writeq(u64 b, volatile void __iomem *addr)
>>  {
>> -     __raw_writeq(b, addr);
>>       mb();
>> +     __raw_writeq(b, addr);
>>  }
>>  #endif
>>
>>
>
>
> Can we get these merged to 4.17?
>
> There was a consensus to fix the architectures having API violation issues.
> https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html

I expect so. Sorry I haven't had time to collect patches yet. I think
tomorrow or the next day I will.
