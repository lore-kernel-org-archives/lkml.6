Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522153251; cv=none;
        d=google.com; s=arc-20160816;
        b=lYYOigxjgk/uA2ej+dnSDFQy3AzVXtUdwWc5r1CvRLhNgG9hvd8SZGUCBhg/zYpeqY
         iMb4XaEbgmkyn5U31NR3fBOJP/N4RqhXZIIxKaVjgE6BYqvoLiR2HHInyKSVbSge5/HB
         HhZxmVzYM424cr+yyw5Lups7RScZAMiHKGNjdSakub8h2Y5OGpNw6ffAiSgWFDNFmEH1
         0IqmrN/4q8bMKnNTozmUGBm4vE/4iXnqDuio0TP8q0GTK+BKZqFjDjvbGCrV2XFvqIn3
         LIbehD09aeJRs00+IQInAZ3p4qJEh+uuxkoUwgiF0UkbAgXEfQ0RWYvWhetXRnGe6JbC
         8MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kbz+jEbPkTM4pOp6wyzVvp3AXXM8VtV6UfiqNweAR6w=;
        b=EYVOj4rMdBs/a0kreq09P8+nxhP3rASmgbAQB9csx7H6cb1ukIiVamNGoAUPOwBfEi
         J/cbm01JdUgs8M5kGAEmN1/+vL/t4T7MPHbvytLlAaoPrgrZ9ywg3shtcDYSyj6+A5xY
         DyoJEb8Q3NAN8QjiCWEXbFLE8/tVvpwdfa4xYoC3KxZxMJOUWp9Y6aIedOBor1J6INKl
         vKDVvE32O/bjuFHDZcqaNIXAWmVGtfXmrLlZnVCcI/h43F8IqxKItSryzRnSNoCiSziV
         MSJNSO/gd8eTySwGkSjpg80B+VPqqyszeiPapqVlDkXQNu61yhFr2pCkdE3/t6bsYmNB
         2aLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r/n7Hk4H;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r/n7Hk4H;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvAS2Eid1q4j+egeOiRJPetjX37g3YyX6n7BPBOpDbJAxkdtDYxoqUY7rdatsXFOw+0WLX5zfpujf6Za7gz4Ps=
MIME-Version: 1.0
In-Reply-To: <20180324082947.3isostkpsjraefqt@gmail.com>
References: <cover.1521828273.git.andreyknvl@google.com> <6eb08c160ae23eb890bd937ddf8346ba211df09f.1521828274.git.andreyknvl@google.com>
 <20180324082947.3isostkpsjraefqt@gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 27 Mar 2018 14:20:49 +0200
Message-ID: <CAAeHK+xUBOt0hh-r5JhjVFcjYDOOyjUKGeN8OxSfnMpOnaWvFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/15] khwasan, mm: perform untagged pointers
 comparison in krealloc
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>,
	Paul Lawrence <paullawrence@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752716297382191?=
X-GMAIL-MSGID: =?utf-8?q?1596093367572688645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 9:29 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> The krealloc function checks where the same buffer was reused or a new one
>> allocated by comparing kernel pointers. KHWASAN changes memory tag on the
>> krealloc'ed chunk of memory and therefore also changes the pointer tag of
>> the returned pointer. Therefore we need to perform comparison on untagged
>> (with tags reset) pointers to check whether it's the same memory region or
>> not.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  mm/slab_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index a33e61315ca6..5911f2194cf7 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1494,7 +1494,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>>       }
>>
>>       ret = __do_krealloc(p, new_size, flags);
>> -     if (ret && p != ret)
>> +     if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
>>               kfree(p);
>
> Small nit:
>
> If 'reset' here means an all zeroes tag (upper byte) then khwasan_clear_tag()
> might be a slightly easier to read primitive?

'Reset' means to set the upper byte to the value that is native for
kernel pointers, and that is 0xFF. So it sets the tag to all ones, not
all zeroes. I can still rename it to khwasan_clear_tag(), if you think
that makes sense in this case as well.
