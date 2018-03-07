Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520446429; cv=none;
        d=google.com; s=arc-20160816;
        b=P3YrCxeE4U/eJY5+LxEDTWyvFjMjGz+oIJ2SXMqBjruZt7QiJFID4g1vI49V+huotB
         HqYbVgF8W3kkMjhYR7+8Cvo8oLCRS11tRoGSugORjltjAYy92p2XPqsYC5jHGOOpQ11z
         BGMUoXNbR/aN/8bql4/VOYpgNrg7js3kixjjr/fUHbKXy3lfMb2aQcRAwqqqILO+U8/o
         ZxO7eM0crR/ruXhMpWrqHhRrirql0IilQ7UYbhZo7xdA2px/xxUioJ/RPG+eiSRpS4MN
         i48ufu5sZ4u7DUzl8Fu/ICJNzWuVDNnBedMzZ7bzF7MHJS27+90j493T5ARvDKQSBtiO
         vQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PLMOuw7Ihhr1qKAnAIRo/aaiRpzFQ7UPKsYKurkXH00=;
        b=mTs4G7IOIwF8Grgz7ZTqOzzgasN6fRjaVcHn6c3zXdcYpC2VDYybmm1EGZjwZFdxbR
         rrvUufGkg2slaXZ9XSnwGSiiZtxSHYjmaq2lQzSOowVeaopGtL1eu+tBSOyUN5QvjTDR
         TrU/O3IoIIFqdscEhMI5Im3iO9bxndzerLKmwN21mC29vpSvTRMHHuhsNpeqC1wmx7Hg
         zGNWAr2dmfEYHwga5ydC35wSCT/WyTbN6hKrmp5Csu/4phyBtUMl3pOCS/khK/8TKskL
         4tFLsmhOmkCWKjIytOpJIx2l5xPjnt9NgriEdGQ91ypfkEkikv3AeNXkkIkMWtpOKSLZ
         XC7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=LU9t8fJy;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=LU9t8fJy;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AG47ELuwCWoNXBM9CUskWD7udauy0ep6drEApx0eN8xmsmDp7AwublAszlJT8i3+D/026TVIL/6XWowZYBKOB+ivshk=
MIME-Version: 1.0
In-Reply-To: <20180215170104.GC25181@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de>
 <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk> <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <alpine.DEB.2.21.1802151550330.1296@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de> <20180215170104.GC25181@hirez.programming.kicks-ass.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Mar 2018 10:13:48 -0800
Message-ID: <CAPcyv4heWRhy4U23xGZ1-BzjWu5JNm1x=6nnnUeiSFZ4LbTQUA@mail.gmail.com>
Subject: Re: [PATCH V2] posix-timers: Protect posix clock array access against speculation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw@amazon.co.uk>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1594303635290712978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 9:01 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 15, 2018 at 05:21:55PM +0100, Thomas Gleixner wrote:
>> The clockid argument of clockid_to_kclock() comes straight from user space
>> via various syscalls and is used as index into the posix_clocks array.
>>
>> Protect it against spectre v1 array out of bounds speculation. Remove the
>> redundant check for !posix_clock[id] as this is another source for
>> speculation and does not provide any advantage over the return
>> posix_clock[id] path which returns NULL in that case anyway.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: stable@vger.kernel.org
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>

Curious where this ended up, I don't see it on tip/master. In any event:

Acked-by: Dan Williams <dan.j.williams@intel.com>
