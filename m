Return-Path: <dvacek@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521644698; cv=none;
        d=google.com; s=arc-20160816;
        b=XE+g5czFCfvg4XDZ0+JNIoxOesYsSipIMzN6VKiURk37nvzVe9tHE4/jwGLPqEtQBw
         EsQpRkIxe/paa7maJOyzWPu/0UF+Lp7wCtm5TDyPJEPs6xkyREZAGAYbjXfLC7ldRXKc
         ZFDJCf+pejUqMpwK0BJMWTjJ4FQHaIQOdR8NzYpG4XlOT6XnaQUdmvaR7wnsMQ5176tK
         /LE+1ZdbwP24Mvy+WR81eShH8ypw/iVFDMhgZwsQCzYrxsA3oTadU13ZekL65OikZPK4
         YKipHEygmQYcV47eSFrAY/Ed01X4Pxku1SYF318DLZUHXnEkITzTKGQ089svvBGsJyGF
         2wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=Ox2U4KIcjn0iuF8e2uZhL10roxGPbbLhl6hCpn8OGOE=;
        b=eWBh1a5g3nHcFrjWMzIhaXb1DowOOdmBChBgdn1w9kJKgB7HYSM/82lGtNVGOl006T
         qG5fqs1jAbYwd4uMnrbGO9hEm31in7+ipxyW0+5S/0mCZ7qktuKSmLCZ5mJ9CC+UM+ei
         NM+BLdqvCOiD08yH5u5MiTJf3nNFLJ8aXi2JMH3/MyKBnqdvawwLPujzUZvmSxgBEWU3
         Hs0IbUOS2OYxKSnz//QFmJJNiF3domwHvUK13yQCvqoPjXEosgO4izelchM5C535ayOa
         ds9sZm7XarjHJjldOGpntI55G8YZ9Br7xi8HwBQZpnn4Ff38w2MtkRjZipvTg4ZP4xHi
         zKYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELua9isEhwoUK8LbuVcrmv/tD+VQth0xrGaePlGigbP5JqLbOFi9MGy1wyYLOyZjp6h4B/NoB/XkqgB+FpHfVmE=
MIME-Version: 1.0
In-Reply-To: <3f208ebe-572f-f2f6-003e-5a9cf49bb92f@gmail.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
 <1521619796-3846-2-git-send-email-hejianet@gmail.com> <CACjP9X92M3izDD-1s1vY6n6Hx3mxqNqeM4f+T3RNnBo8kjP4Qg@mail.gmail.com>
 <3f208ebe-572f-f2f6-003e-5a9cf49bb92f@gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Wed, 21 Mar 2018 16:04:57 +0100
Message-ID: <CACjP9X_aU1P78JLhLBXwJHVKwJE7B8x7xruKK=vA8joji-990w@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn()
To: Jia He <hejianet@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>, open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>, Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534036182363270?=
X-GMAIL-MSGID: =?utf-8?q?1595560111426602779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 1:28 PM, Jia He <hejianet@gmail.com> wrote:
>
> On 3/21/2018 6:14 PM, Daniel Vacek Wrote:
>>
>> On Wed, Mar 21, 2018 at 9:09 AM, Jia He <hejianet@gmail.com> wrote:
>>>
>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>> where possible") optimized the loop in memmap_init_zone(). But there is
>>> still some room for improvement. E.g. if pfn and pfn+1 are in the same
>>> memblock region, we can simply pfn++ instead of doing the binary search
>>> in memblock_next_valid_pfn.
>>
>> There is a
>> revert-mm-page_alloc-skip-over-regions-of-invalid-pfns-where-possible.patch
>> in -mm reverting b92df1de5d289c0b as it is fundamentally wrong by
>> design causing system panics on some machines with rare but still
>> valid mappings. Basically it skips valid pfns which are outside of
>> usable memory ranges (outside of memblock memory regions).
>
> Thanks for the infomation.
> quote from you patch description:
>>But given some specific memory mapping on x86_64 (or more generally
>> theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID) > the
>> implementation also skips valid pfns which is plain wrong and causes >
>> 'kernel BUG at mm/page_alloc.c:1389!'
>
> Do you think memblock_next_valid_pfn can remain to be not reverted on arm64
> with CONFIG_HAVE_ARCH_PFN_VALID? Arm64 can benefit from this optimization.

I guess this is a question for maintainers. I am really not sure about
arm(64) but if this function is correct at least for arm(64) with arch
pfn_valid(), which is likely, then I'd say it should be moved
somewhere to arch/arm{,64}/mm/ (init.c maybe?) and #ifdefed properly.

Ard?

> Cheers,
> Jia
