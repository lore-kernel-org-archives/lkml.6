Return-Path: <kernellwp@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525348885; cv=none;
        d=google.com; s=arc-20160816;
        b=BYmRRoRVsp8d4UmguDk4RKVR+z8bm3jRUU1437YygRf4R4flK+/At+3liNoevZiLu9
         ia7SYtLIJgiIiLxl8VililvjewhRFZ1L6nsjSw5SxSAaQh8O5btwpqPjnYWDH2rNQ8NB
         ss59rrFKenYKZeeo/uaQTgAxRiapnmZfOKudINtrDKFCPcc5CmHWA4Qg89x78iWWJJn3
         phcBj0/fWDXbJO57MMZaVEVSsxKHkU0xlR/RtG7i7bR/zXuje+PlC65zNrveY6IBr6pL
         GuWT/Gia8mo/hTeAsqfk1aNvgLhYzZz6Z8M+qvHdutXrGE7sT3WyHb+j/mRzvUawtcdG
         kGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=e0qxxKRiv8qCo3yuzfRwsBKeVZmL9PNrhmn5+1ZVV1w=;
        b=pwcApZ/piKy0q7jW/lB182r94f1J94e8R8TwlJFF4cZTjGkoGJkSqxT+KGMyqHtHTY
         wmJNDgicEUY0QPpEw5R10/S7wEJsEjvo4Y2aZrVDzmjv7zspEisWahy0rNJQaN1fx2RA
         GD+bB+SAwpnaLbqetiP1j017fZ5HZOqF43fuOVcDvz6m9xr1CP1JzWBMoybZrHfmaPxL
         JcjpTQ3cO1I5hzCBTDhjjb9WZB/SfHHN23KCcCWdBRsFFKd+/k5Uy2ByrN6fBxZzilmF
         /OGbkjFVl5YVZvDNXzoYZIjIoCrmti+JVpcwDCMvyZ9GVO+CRKdRuK7HgwsXmMEcTAQq
         NGYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lUOmPCWM;
       spf=pass (google.com: domain of kernellwp@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kernellwp@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lUOmPCWM;
       spf=pass (google.com: domain of kernellwp@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kernellwp@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoKCI+YE3vCKltNU43P+Z8cfu3C7PMW45yGp1ZVkAFCVotwVporT8ooHL8kKGzQD6jrmrRaEOkBEeAsXbCEKOs=
MIME-Version: 1.0
In-Reply-To: <9c228512-33b8-0df6-0c3e-4d30140d6579@redhat.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de> <CANRm+CzKXA6ktG9fV4E-Q=+ZWZbS+ApUPXjogJJQErEZD2jHHQ@mail.gmail.com>
 <9c228512-33b8-0df6-0c3e-4d30140d6579@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 3 May 2018 20:01:24 +0800
Message-ID: <CANRm+CzXieWra9uyEuVpHF+5=Vq+JN4QY9BvJXRL3DEwqBGAag@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm <kvm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>, Asit Mallick <asit.k.mallick@intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>, Andy Lutomirski <luto@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1599444232878154627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-03 17:19 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 03/05/2018 03:27, Wanpeng Li wrote:
>> So for 1) guest->guest attacks 2) guest/ring3->host/ring3 attacks 3)
>> guest/ring0->host/ring0 attacks, if IBPB is enough to protect these
>> three scenarios and retpoline is not needed?
>
> In theory yes, in practice if you want to do that IBPB is much more
> expensive than retpolines, because you'd need an IBPB on vmexit or a
> cache flush on vmentry.

https://lkml.org/lkml/2018/1/4/615 Retpoline is not recommended on
Skylake, so we need to pay the penalty for IBPB flush on each vmexit I
think.

Regards,
Wanpeng Li
