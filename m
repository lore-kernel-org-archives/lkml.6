Return-Path: <nick.lowe@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518786907; cv=none;
        d=google.com; s=arc-20160816;
        b=dxWvnUR0r08qZTnMG7/ioASfUZZvgnaJXND3dB+YdQMgYvXyu4Ok2o3qeUMNEInDc/
         Flzj9l7O3F8NhHq64CU9wvgpJ8BuoVTUHHNRdTOCmzXhzKpvqBiBieyawVmbxXdguL3w
         MBF/zoE4bUQAUX2EhJR2z+NbRE6S531n6VRezAxiTl7wvh+cg6RKl04xKlvI/AC3bGSh
         TXhQgRY03it+h/FqVIBNicmzpjxzccIvva5ujTA55X4F0+JBMPaojM0WDZ3C6uB2QRJd
         fBKrIrfHMw68DKQmVslw/OG2p3skQCQnDudqjENumnshx2H0cG+XNrl+BhzqO95h2wRx
         Eazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=s9lIdfzXecQHd6JiNj308e9WsQdtaz2ZsqkqA02Qsi4=;
        b=VBLyrDAidUa3OvtbrkP4VhrdD0NS60jpVcKmZGu62G2LeYru825d9oJmlXRz09k9p9
         +rzxJn2Ci4Jbu0VMuBmGExu03fQwA91fvAyhv8PQtqEXZEuooDL2F3RM+G92AqXywlGv
         l3vQ/hHCqjB5kd/J24k7A8wzbxw7J9kVyrHHJzHDP8L3hplcv2so/PgJEHUGNcn0vsJJ
         AkPSiQ6/+hcsFDqlFoaKLzNeSczljRkbOqf6MF6OquFzEhUEf2Ikrq59nzTzQhi3FVWF
         Bj0I5yipXDBRhRAtcGiOhh6VP8y9pIKkcM1RKk1WQYM4aWgU4y/GrTqsyigwfGp22WhH
         +L/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sC6iMouB;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sC6iMouB;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226JAaqP1XID06I46f36KmeWAHq9xS+z8zU5DyDjlQEhd/O/XCPM8lYaBQ/9wnd44v+/Ccu0Gm9NtWDH7TuoyqM=
MIME-Version: 1.0
In-Reply-To: <20180213163239.GA17101@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com> <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <CADSoG1sv4-YmRh8AwD7A93_eDLn4ZTwD0Y7C9jyRyh6nOvwqjQ@mail.gmail.com> <20180213163239.GA17101@kroah.com>
From: Nick Lowe <nick.lowe@gmail.com>
Date: Fri, 16 Feb 2018 13:15:06 +0000
Message-ID: <CADSoG1uW5PuT9dr+w3npf6LiLvBL5=2x=uN98+JVNTR3KQbH5w@mail.gmail.com>
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@intel.com>,
	gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com, ashok.raj@intel.com,
	karahmed@amazon.de, torvalds@linux-foundation.org, peterz@infradead.org,
	Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931030693871871?=
X-GMAIL-MSGID: =?utf-8?q?1592563500758446306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

I do not have a tested patch, but I expect the change would be something like:

skip:
-       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+       if (!static_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
               goto disable;

Cheers,

Nick


On Tue, Feb 13, 2018 at 4:32 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 13, 2018 at 03:27:47PM +0000, Nick Lowe wrote:
>> Hi Arjan and Greg,
>>
>> Sorry if I am not being clear enough.
>>
>> My point is that there is a check for X86_VENDOR_AMD now in two places.
>>
>> It is still hardcoded for the auto boot option which I think should
>> not be there. The patch on that basis looked incomplete to me.
>>
>> Put another way, there is no effect to the auto option where the
>> contents of cpu_no_meltdown[] are changed and
>> cpu_vulnerable_to_meltdown returns differently.
>>
>> The auto option does not make use of a determination of the
>> X86_BUG_CPU_MELTDOWN state.
>>
>> This seems wrong to me. It does not seem correct to me for the auto
>> option to have this duplication with a check for just X86_VENDOR_AMD.
>
> Do you have a patch that reflects what you want to see changed here?
>
> And can you test it?  :)
>
> I don't have any AMD hardware, sorry.
>
> thanks,
>
> greg k-h
