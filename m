Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227ngnYlaVJe/kNFGVS4WyeO2yauEwGxlXPlu3B8+Ok1Zk7RGGUmiNJYd2nWXkyfsA4Z+t1M
ARC-Seal: i=1; a=rsa-sha256; t=1518714080; cv=none;
        d=google.com; s=arc-20160816;
        b=PwZ7ReJa/laZ9+t59oI9h18aRtrlrDf6RkDyfZ/sA4DL+Jb7aqfqvMP1f2vOf+QDNM
         suwq0uA0E7WKEjpuCu+EAGTvVYu4X2uYVCBH/9EL/N7n8AEwGp44xL58+jL+NP3NfL2L
         b8ehEkDZjLGEl3Gfl6zinuwATmKXYKGUkp+1kXlR77y3TmsBs9yHE8zwNGjBbIKs9MJu
         3u0Q6H50tkZmMHtmu22xQ+H7EZdmdHG7M5wPreg8USOp3QfEbISEmq24l9+OD+XPZCa3
         R8RClOAp202NTYv7fWnZ9Ie0d39bT4g+1VcsdpB+8jQeXgLO5nglf+I7QTBvk/9xIGXq
         /31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4YXxPWfjuq+KyuzQJXqWPMl2McDtaA/udlsBN82meo0=;
        b=Vbb2QVMfdG2F9C9Oyx35zrdg1ZMx1MYT1WbYKEY4KSuN0GM7PpYbx8typjPqxGsEPU
         DXnjRIFmZRA9kz+D2tT0gKdPA23eW//8Jt2DEIXr2bcjvNXH+BpIN0GlVallRv3YPUdn
         z1w3CvtdKzPGeqx8o3HpL7U/T2OoujBf/dxUtyjTGsTtYbNjiJKZvPYTj6GcrGILqv6u
         QekJaWavgbQ91OMOb1wDSxYvTF5SIczFOZxdMINMn79axVgS4h5o8R9YIEQevpFuR/Ml
         qIVN0m4dzwejuPguRXgesxkzMI6rwM5/vNutI1mT5LZ/q4WHkpgug9Zko6gNA8t1Asz6
         6YqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=TVjzbFkA;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=TVjzbFkA;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 15 Feb 2018 18:01:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] posix-timers: Protect posix clock array access
 against speculation
Message-ID: <20180215170104.GC25181@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de>
 <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk>
 <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <alpine.DEB.2.21.1802151550330.1296@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592487135274150752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 05:21:55PM +0100, Thomas Gleixner wrote:
> The clockid argument of clockid_to_kclock() comes straight from user space
> via various syscalls and is used as index into the posix_clocks array.
> 
> Protect it against spectre v1 array out of bounds speculation. Remove the
> redundant check for !posix_clock[id] as this is another source for
> speculation and does not provide any advantage over the return
> posix_clock[id] path which returns NULL in that case anyway.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It might also be useful to figure out why the automation didn't flag
this one, its about as trivial as it gets.
