Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521635323; cv=none;
        d=google.com; s=arc-20160816;
        b=SLX1K/a2tnJOuOr7AUJlwexCJykKSQ9sdlIbzYn+O6Ux2zSOifdp1KJulhYamGJWm6
         CE2L+E8wTXMyFf//TizZsYJuXkTlTeUmnIEbROId7tFzMb/rJAcfgXA8LgMNrq4bB+M+
         eaZiRdPRw5bK7n+C3AKjGwaR+qp9n6lYsYyVQoXttOiY2IEi9hmtoqMyqWU4HqXj6/3+
         Ad16Cj3BcvssvE50JLieJU2qUwoBOSu4tDs9RxOn6zrk3y9KF2XplBMDzg4JFZSLU9Rj
         YtVfqgb683kracvM6w2/9MArUZQdMIejAkRGGgnQa+Dv+97zoG80aK+9szH0vXV1x0/0
         U8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Z0iOMD9i4edqrrmvhSsjQXG+p28W6hi/olcqmaI2gVw=;
        b=j+9wEqD2Cl8bpnUFg3p6gff5mDbkQ6OQ4oYYonfOFPMSIjWXsnlarwNvkCrFIPzFSS
         0Bj+bTArYPOzbu22OftU2vXG3a2TNomcrC1aK/+1pkCU4zePw+qQ00gz/1PhFZ3E8/7h
         e4FhTG2vFUvn4w3jUGta0CeApcw/b3TSVMij5eXlxbzJ9SoxFr5684QLtxsN73HOP6fu
         RfPMCj6BWamhcdqxgGT1L1VxSLmI7aXdcMwVZ5e9sMO3qBs9S0H6/LXRzPNbQ+iC62bV
         vR2O5YwLDwVTN06I5gpwNlZXhwkLa/lqiUbizOu2msg0U1nLijL7bLH5Z41edRohzYEX
         /ppw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QfgrlDWs;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QfgrlDWs;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvwSxo79oIKwaG7g6Qdqii+IQQokve+mdbgJMFfNwrai+yFsoxWzzAFTRLzfkc9DlNnMNu18g==
Subject: Re: [PATCH 1/4] mm: page_alloc: reduce unnecessary binary search in
 memblock_next_valid_pfn()
To: Daniel Vacek <neelx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Gioh Kim <gi-oh.kim@profitbricks.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Vlastimil Babka <vbabka@suse.cz>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
 Petr Tesarik <ptesarik@suse.com>, YASUAKI ISHIMATSU
 <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
 <1521619796-3846-2-git-send-email-hejianet@gmail.com>
 <CACjP9X92M3izDD-1s1vY6n6Hx3mxqNqeM4f+T3RNnBo8kjP4Qg@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <3f208ebe-572f-f2f6-003e-5a9cf49bb92f@gmail.com>
Date: Wed, 21 Mar 2018 20:28:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X92M3izDD-1s1vY6n6Hx3mxqNqeM4f+T3RNnBo8kjP4Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534036182363270?=
X-GMAIL-MSGID: =?utf-8?q?1595550280717735970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/21/2018 6:14 PM, Daniel Vacek Wrote:
> On Wed, Mar 21, 2018 at 9:09 AM, Jia He <hejianet@gmail.com> wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. if pfn and pfn+1 are in the same
>> memblock region, we can simply pfn++ instead of doing the binary search
>> in memblock_next_valid_pfn.
> There is a revert-mm-page_alloc-skip-over-regions-of-invalid-pfns-where-possible.patch
> in -mm reverting b92df1de5d289c0b as it is fundamentally wrong by
> design causing system panics on some machines with rare but still
> valid mappings. Basically it skips valid pfns which are outside of
> usable memory ranges (outside of memblock memory regions).
Thanks for the infomation.
quote from you patch description:
 >But given some specific memory mapping on x86_64 (or more generally 
theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID) > the 
implementation also skips valid pfns which is plain wrong and causes > 
'kernel BUG at mm/page_alloc.c:1389!'

Do you think memblock_next_valid_pfn can remain to be not reverted on 
arm64 with CONFIG_HAVE_ARCH_PFN_VALID? Arm64 can benifit from this 
optimization.

Cheers,
Jia
