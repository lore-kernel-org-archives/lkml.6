Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523640889; cv=none;
        d=google.com; s=arc-20160816;
        b=BRYuCjpSPPljsPonXP1azOIXwWtr34IdzgVIBvooAn1RbgXJB6fi0LWQj8xGgqsjkV
         MdC2JrEcIwhC6cqNXypLvDiNVBzvrhB0eIzPAWo3m7j0X+NzE/3o/4oU7gfCWJU8wClj
         Mpk1PtJRitGj42Kaes70E+6FcUdtbVaqMpGrEr74RwIlYrEHgfBB7KUmpTOeoyHRmySB
         sL8hgazL49AptFMP1untOzRa0MHXPkbi3LAoFpbFMkUvlHKTKTFIadyRXNSSfIbq7C/0
         wzLwMz5wNwbqiUczYSIz1UgOV6aNeNlHgfnoi5P7TY7LL3pF3bvSQIfXYqCG+NIe+0Fu
         YTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3UfDrxPKUxRz4lfSlOTQ6YjRwnTh2vKglZs4ZSWpsiM=;
        b=jRHvV8mGs1RUCc0w9oQ40LtxjZdMR9cYLJ5pAzg61iXjQYD4Qyvjpjfh0MWjpex7lg
         8gHOvAblgLghlveAPpmr7ZvAriX50igc07OQU44z5NRWvuUcf81n6QSCTuH19CG2krk5
         fLwrbqzlaLfq6NnzDUoIsnLA7+NHyaya2Ul179PXG7Cm5LWuncY3wi47Ud01pOzlH9lR
         nHvj6rzgyMph1LyEa2i/ZnGEo1HghYw6g+Qy166VBR4gx8Zn+hAtGq2c/AbP/lDH/O30
         rC82dnsN2C48/xXt5Y/RZzXoo8NlyM8KDClkHkdC1/Lqmdj2hRnFBbuCDWnwKQ6+nAOi
         TUsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gK9QWrOa;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gK9QWrOa;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49sCc30eNLu9z8EMmukIdMTFxIEvm6+mlm3dnXoZJGtr+2uTQfCTt4IopkpuzJI2IXodAKguIcMXa5djjUGmas=
MIME-Version: 1.0
In-Reply-To: <b849e2ff-3693-9546-5850-1ddcea23ee29@virtuozzo.com>
References: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
 <b849e2ff-3693-9546-5850-1ddcea23ee29@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 13 Apr 2018 19:34:47 +0200
Message-ID: <CAAeHK+y18zU_PAS5KB82PNqtvGNex+S0Jk3bWaE19=YjThaNow@mail.gmail.com>
Subject: Re: [PATCH] kasan: add no_sanitize attribute for clang builds
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Will Deacon <will.deacon@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Lawrence <paullawrence@google.com>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
	Linux Memory Management List <linux-mm@kvack.org>, Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597562343326181438?=
X-GMAIL-MSGID: =?utf-8?q?1597653268916072523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 5:31 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 04/12/2018 08:29 PM, Andrey Konovalov wrote:
>> KASAN uses the __no_sanitize_address macro to disable instrumentation
>> of particular functions. Right now it's defined only for GCC build,
>> which causes false positives when clang is used.
>>
>> This patch adds a definition for clang.
>>
>> Note, that clang's revision 329612 or higher is required.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  include/linux/compiler-clang.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
>> index ceb96ecab96e..5a1d8580febe 100644
>> --- a/include/linux/compiler-clang.h
>> +++ b/include/linux/compiler-clang.h
>> @@ -25,6 +25,11 @@
>>  #define __SANITIZE_ADDRESS__
>>  #endif
>>
>> +#ifdef CONFIG_KASAN
>
> If, for whatever reason, developer decides to add __no_sanitize_address to some
> generic function, guess what will happen next when he/she will try to build CONFIG_KASAN=n kernel?

It's defined to nothing in compiler-gcc.h and redefined in
compiler-clang.h only if CONFIG_KASAN is enabled, so everything should
be fine. Am I missing something?

>
>> +#undef __no_sanitize_address
>> +#define __no_sanitize_address __attribute__((no_sanitize("address")))
>> +#endif
>> +
>>  /* Clang doesn't have a way to turn it off per-function, yet. */
>>  #ifdef __noretpoline
>>  #undef __noretpoline
>>
