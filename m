Return-Path: <dvlasenk@redhat.com>
X-Google-Smtp-Source: AH8x2260IAwc5Y64qZWknsxyzyI4hD3p6PspCHI64Okwmqbmysvz2KLFdHVIKjLZE/CWlBKdQCGM
ARC-Seal: i=1; a=rsa-sha256; t=1518204661; cv=none;
        d=google.com; s=arc-20160816;
        b=ttvhWnJg0KFsJu5wUbMvcTN4xf2jeUfOwXyOirzVeCZnUaA6F1or2IsrDpBCadgywG
         j8vssi/SFfW2E6MwuRDztd79/s0JfqtHqoivjyGPhGX9V2x1jnEqwV2HsrrCxsQOQdX/
         Yr+s4Ve+cgL2o0XwU63h5200GEEZMegcjVCey7TDwOKhb0HsdZLfn2vRenQsWZi0LIVH
         1y3vgmpHhTCdH6Ce/vPCNRCzhBsx4AAQW9vHktSWNqCol3IN0UrB7rcdiOsTQg3zNmsz
         76YJwfs6h2cxZjoPVaWiMNu/Ym5GnmEaUfW/p0rYTRau9T8OXubWupAJHQImhRyoow2V
         lMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=23adVBBkUNSiD70uO5DoUs4J9YYD/Oc0ixpW79NxSXc=;
        b=knnh/7wq7lAf2GnZuAM7EHkt2Xr/v627bBbjkxnDfRCtp97XCdXE4UyfTALpNMn9ul
         /dWMsGSynID0fZzGxCUYDHktCJLvV0rESqvcCt+d9wmVaOlqmJCtRipVFRkP8dHMNIhF
         aLMHxtaWD6aPThGz/Cmnbeh57Qw00VGUVtx4pPd0rh1Z9UxDMyfHoc2yoZt3q0auG1zc
         pigCCdxIRAG+Vda9oFZvfCTy1QpcDfgDWfs/ps9LYYKUChUxe3Q5qVlX3TPf+uz89627
         sy/KyfVFEO4VKsO0OpN9GDKzl2VkQKwE4w7eqWgcDfxFpDmxhngZazie0bjZ7fAbG/Um
         Q7Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Joerg Roedel <jroedel@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst
 <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <20180209190226.lqh6twf7thfg52cq@suse.de>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <4a047ea5-7717-d089-48bf-597434be7c4c@redhat.com>
Date: Fri, 9 Feb 2018 20:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180209190226.lqh6twf7thfg52cq@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591952970371370656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 08:02 PM, Joerg Roedel wrote:
> On Fri, Feb 09, 2018 at 09:05:02AM -0800, Linus Torvalds wrote:
>> On Fri, Feb 9, 2018 at 1:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>> +
>>> +       /* Copy over the stack-frame */
>>> +       cld
>>> +       rep movsb
>>
>> Ugh. This is going to be horrendous. Maybe not noticeable on modern
>> CPU's, but the whole 32-bit code is kind of pointless on a modern CPU.
>>
>> At least use "rep movsl". If the kernel stack isn't 4-byte aligned,
>> you have issues.
>
> Okay, I used movsb because I remembered that being the recommendation
> for the most efficient memcpy, and it safes me an instruction. But that
> is probably only true on modern CPUs.

It's fast (copies data with full-width loads and stores,
up to 64-byte wide on latest Intel CPUs), but this kicks in only for
largish blocks. In your case, you are copying less than 100 bytes.
