Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517949475; cv=none;
        d=google.com; s=arc-20160816;
        b=RG/D0ohXlftX8D7gnW6sFk+anPx0MSI/JRvBhscal7eCxbEAbbfYSvP8lbpZLCxmP9
         jnVZ/Ko8G+hJHyKbLThL5n9Ts9TVa+plWkls+qIoY55+Iy6VKu/iqs2oah82m33xeDMB
         CiHUSjwue4EuOlElI7cqYGO7ZMJ/5dv8hbEvBumO/m1QgMV4m899JucgeLhuLPJqC6wU
         4KDdWXxTdCNdMpXzNH/YTLFzgKxVbwD6N0XggV9YjUXyHTdXitci359MLRKEkQcf3OsL
         sGyd8XrSddzuOtfe1OIVYnsBi85DiUfbusoxuUJqxmnqH38ddcCo4iiki9o+pxQD33Dj
         m6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Rxy08JbyKtC7xlgnpg2Kf/+M+z0wpW92HzSevrixELk=;
        b=WvzjJKnefXdckWpTHiOWKBtxpbvtjU5D7HMH0HH0j/Ck5XbdmddmuSPrqsg1JWjhEt
         2sGXKPgLIENGN/rcY5HBJUo7c/IjDeBYtppP7JBFDtUGiZDLWojx4AhTi+FPPZlPBYwi
         pnIt9UGGAnlDuA2tmR0PBntZOEfYa9AxgKXCIVUI01KCvKvVGGC9o+9dxbgPP+x0XJn8
         1dETE05s0+jIP/p2ZVwdVKgxXBpRCLC+VT+8KscAYSt1874XWjFanRNfwM1i3DA5XnoR
         G/5vK5l8q4/lMOpwGmGbUAjqWMLlA/vjKa+GYLqtyf6/vkfS3gfcqlYDfJpk/zfpbeOn
         RV0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=nrX5CXux;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=nrX5CXux;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AH8x225Ok0i4p/stXI0X7TJfKTvIb6k2b/GYLXqtIHuoqm6sN0cUArJZF+TWSZusmcKwKHd//QMef3nShuQi3L0zitQ=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Feb 2018 12:37:54 -0800
Message-ID: <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Henriques <lhenriques@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>,
	X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591685388892296071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 12:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 11:48 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Just to clarify, when you say "this patch" you mean:
>>
>>      2fbd7af5af86 x86/syscall: Sanitize syscall table de-references
>> under speculation
>>
>> ...not this early MASK_NOSPEC version of the patch, right?
>
> I suspect not. If that patch is broken, the system wouldn't even boot.
>
> That said, looking at 2fbd7af5af86, I do note that the code generation
> is horribly stupid.
>
> It's due to two different issues:
>
>  (a) the x86 asm constraints for that inline asm is nasty, and
> requires a register for 'size', even though an immediate works just
> fine.
>
>  (b) the "cmp" is inside the asm, so gcc can't combine it with the
> *other* cmp in the C code.
>
> Fixing (a) is easy:
>
>   +++ b/arch/x86/include/asm/barrier.h
>   @@ -43 +43 @@ static inline unsigned long
> array_index_mask_nospec(unsigned long index,
>   -                       :"r"(size),"r" (index)
>   +                       :"ir"(size),"r" (index)
>
> but fixing (b) looks fundamentally hard. Gcc generates (for do_syscall()):
>
>         cmpq    $332, %rbp      #, nr
>         ja      .L295   #,
>         cmp $333,%rbp
>         sbb %rax,%rax;   #, nr, mask
>
> note how it completely pointlessly does the comparison twice, even
> though it could have just done
>
>         cmp $333,%rbp
>         jae      .L295   #,
>         sbb %rax,%rax;   #, nr, mask
>
> Ho humm. Sad.

Are there any compilers that would miscompile:

    mask = 0 - (index < size);

That might be a way to improve the assembly.
