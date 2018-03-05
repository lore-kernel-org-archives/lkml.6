Return-Path: <hpa@zytor.com>
X-Google-Smtp-Source: AG47ELt5YwhatIv7COLNKsvdAd2WZnb3LlPA48+dzopXP/+KbXCgdQV98o4jldo8kCsa8hTB1KEc
ARC-Seal: i=1; a=rsa-sha256; t=1520287534; cv=none;
        d=google.com; s=arc-20160816;
        b=DQPTodo9PLZb3i0/dSB4EDTQfSDLAGm/33MGBrYUf5Eg/pNgtaFyRUiV/x/HfEl0gB
         fWAka7LNdxU5l51iCTeqozf42CGVx2yMpMKQNmuhJ3vf35vVTNfXtu7eUhmKleipwuHa
         INJug0GTT+o+Pqz6RlgCVSEHcWtKWZDI9F+WmRIsRbVZw4QPwBSLGrJoW/vyYkTyK9JI
         YLaZdtQZeBy5aMRu6ltNfZTFFEKnqZMsBizqDSAjL6ZN02kl6btynkIew/pwwpE2/C9C
         3FCQeJNSYoKRX5gEH5KyCj/PoUA8w3EgkF1IdwdAdSBnccjRTng9qKJQwHrdFxQyO/GL
         KzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=w4JdNVpVsABRvqE0ppguRRdKYI9Z+Z9UJfxVRuWA4p4=;
        b=ABtuywpRC3AvDhTvRsIIHhOmRo1ZF+7xNmMBLpcM1Ez/L0HEszCvDZL1sTpgJ4TDAV
         wBbzA22HAe3CKNI+R4BqppwTZrRQqBKM9UNdxehy8nLZqgIBO5oL2F7Zm0NTfb6VFJI3
         ynkDPjKU/+tq2LSQrb+d15Af5xWke+Mw8CrZxnFzK02U/x6L/qMI52CvA71b1H1BS+Fa
         Wzz0lV5nQ3wz5HKnEuFRUxBg7GM9UDkUAEMUJrxZ50v33s9IMqP4HtRafF7qjOPgpHt6
         z/3KqGwpG1eJdz8C7hsvYdNP0O0rWWLXUzazqfCqoStgKbPQeI/MS7AArTqF1/xg5AR9
         WlMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hpa@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=hpa@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hpa@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=hpa@zytor.com
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>
Cc: Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko
 <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org>
 <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
 <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
 <20180305213550.GV16484@8bytes.org>
 <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <12c11262-5e0f-2987-0a74-3bde4b66c352@zytor.com>
Date: Mon, 5 Mar 2018 14:03:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594137022101512190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/18 13:58, Linus Torvalds wrote:
> On Mon, Mar 5, 2018 at 1:35 PM, Joerg Roedel <joro@8bytes.org> wrote:
>> On Mon, Mar 05, 2018 at 12:50:33PM -0800, Linus Torvalds wrote:
>>>
>>> Ahh, good. So presumably Joerg actually did check it, just didn't even notice ;)
>>
>> Yeah, sort of. I ran the test, but it didn't catch the failure case in
>> previous versions which was return to user with kernel-cr3 :)
> 
> Ahh. Yes, that's bad. The NX protection to guarantee that you don't
> return to user mode was really good on x86-64.
> 
> So some other case could slip through, because user code can happily
> run with the kernel page tables.
> 
>> I could probably add some debug instrumentation to check for that in my
>> future testing, as there is no NX protection in the user address-range
>> for the kernel-cr3.
> 
> Does not NX work with PAE?
> 
> Oh, it looks like the NX bit is marked as "RSVD (must be 0)" in the
> PDPDT. Oh well.
> 

On NX-enabled hardware NX works with PDE, but the PDPDT in general
doesn't have permission bits (it's really more of a set of four CR3s
than a page table level.)

	-hpa
