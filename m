Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AG47ELvYysNxsahkfMjPgwHSKrp41/UeZYDaexcN0Ioas9Gj4MFEc3v5ReeUZDyS020hkANmpRi8
ARC-Seal: i=1; a=rsa-sha256; t=1521206590; cv=none;
        d=google.com; s=arc-20160816;
        b=oQdTGLhR30spwfDzyFdbdk2wNplMW9LWjix61NloihmrdrWeEVPr66m7qHaY4pmdCN
         C6zaN32hC3zmFzq0fsr+bK0MglWt2PDms0tetcRIHgzJ6hI+wmJtlDHy49rWLepDG+KA
         h4wNtz+ZXBlgaqkb6sBikw5UzNC7P6UuqW1yt5Ug6AqGfbmxJHs7tirY2QOp+HeC1El7
         pJb1rEg9aZsQfGIqzaMZqxkYEUZFf0SbCDUspG/DdQoM8qjreO7UB989aHzwMbyBW8wm
         WDG+RZvYgW6RhDve4SQqsCvAWAJCfw5UCWUDsZ07XMibixJmZMuR4Dx0nxJh6WAlsYrG
         k/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=f4U1pyPtgHUugBrNByrr2/BnWmmCn2HoUkKpGyce8Qg=;
        b=hvgBN6wgMk9z1phuhYGbIE/hW51EbrlUCrNMWfxsQ0iTcO1XmCOrtLiobu5dekD1Q5
         tYxfe90rblDOVnyg5Kf/vPUEh2zP8U6pWb/dgOyzueH3/vmguwwMUCzPKRWmZS8B6k2+
         J2TUtLraXJ0kyQuWiUW7MqlEQ63aZktaETQ4OIKOxVycR0WGPJnlepFA0DD7nwseo7c1
         OG6QZur6ZlF0ueNAOT2WSwP/s+0A5iKmt3Uri/H6c6jUYOXM2T7OipnwejUOZEiMpNyY
         YoP5yL5M3hAkk9vgCf86FFJQfOKDwe9K0Gw46Qq6md2J2qRoMFLZVK5LBOz/a94EwNSD
         6XCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Michal Suchanek <msuchanek@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Nicholas Piggin <npiggin@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Tobin C.
 Harding" <me@tobin.cc>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Al Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC rebase 2/9] powerpc: Use barrier_nospec in copy_from_user
In-Reply-To: <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net> <cover.1521141122.git.msuchanek@suse.de> <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de> <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
Date: Sat, 17 Mar 2018 00:22:54 +1100
Message-ID: <87605wi28h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347068746375?=
X-GMAIL-MSGID: =?utf-8?q?1595100721402213859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 15, 2018 at 12:15 PM, Michal Suchanek <msuchanek@suse.de> wrote:
>> This is based on x86 patch doing the same.
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -258,8 +259,10 @@ do {                                                               \
>>         long __gu_err = -EFAULT;                                        \
>>         unsigned long  __gu_val = 0;                                    \
>>         const __typeof__(*(ptr)) __user *__gu_addr = (ptr);             \
>> +       int can_access = access_ok(VERIFY_READ, __gu_addr, (size));     \
>>         might_fault();                                                  \
>> -       if (access_ok(VERIFY_READ, __gu_addr, (size)))                  \
>> +       barrier_nospec();                                               \
>> +       if (can_access)                                                 \
>>                 __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
>>         (x) = (__force __typeof__(*(ptr)))__gu_val;                             \
>>         __gu_err;                                                       \
>
> Is the above really correct? The barrier is *before* the conditional
> branch that might be mis-predicted.
>
> I don't know how the ppc barrier works, but that sounds completely bogus.

Yeah it should be after the branch.

I don't have a formal spec for the barrier yet, it should be defined in
a hopefully soon to be released revision of the ISA.

But the gist is it will stall execution until any older branches are no
longer speculating.

It doesn't order any two arbitrary instructions, such as a comparison
and a branch, which I suspect is how Michal was interpreting it.

cheers
