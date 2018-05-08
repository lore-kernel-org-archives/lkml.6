Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525750629; cv=none;
        d=google.com; s=arc-20160816;
        b=zxkUQ/W5C+lLiZkUuPWBEp2+5TtNsOGu+jOa/dhLwwn7o7O7ineKxudFbGdzY2wkTQ
         8dMT5q3PG/sRyUJsruxbT7MgupQmzLdAvLMCvjODtwbUL+b86CvJUql9ATXFfVmtVR4L
         FLajiocqWNopbDyZFTVijWGf4mkNltOg6ORKmrJeYnvvIlNW+SnjwjNytdqref0ZhH4N
         hCKcuVN69SS324cLhxhu+kmGK9pSLaof1fgYIA94FpAj0i6bPqiSGBSjg19tR3vgdWi0
         MDv+r7dLDrL36nFue/hKK03CZHirDdZAN14Rk/t5gx9GADS4vQT+OUuo0UvUDjhErL46
         4aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=s8SfJ81sUZtkf/XL1tgQgJ/+e5xoA/1icGelLNyjoLs=;
        b=GbtfGupzHrRFJzzM5FCB+fWDzgiaHjBFEVfao6mNhMmY53KPY+hsSf/SW0XL2SF0fs
         O+aWxY0WC8fHrijScAVfDGFXsJYMPU8QvUIICqcM2wemPKVbZLPXvtANqvdk84HGEh5a
         N2AtHWGuwjsW0i/9lsZCH001l6J/fc4GQ3dZhnzkZgT9oTClv0540N+YE9pVT7EhSHTE
         9OkTl7L5saWEAEK1xYs2x0TcYQfAzM7yK4tPbjhhlTfVN93iGmiZ+kr6b6wO2DNarZn0
         GioLDAWJd24yeDKmIqKV2tX2Ef5iUTllF2tG1Rhvuf66IjlVlOs66m0i/8pvZyS6A3qE
         cuvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u+tUPFOF;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u+tUPFOF;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrim3s1L1upTcF6ZQz4vOW8lODrcyKdoi1D/HqfHefjzHW3+D8zkFMJ90hjDhOFuY8g897wxw==
Date: Tue, 8 May 2018 13:36:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
Message-ID: <20180508133656.5ad92847@roar.ozlabs.ibm.com>
In-Reply-To: <87zi1bbvnl.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
	<20180430145558.4308-9-npiggin@gmail.com>
	<1525168138.2325.100.camel@kernel.crashing.org>
	<20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
	<87zi1bbvnl.fsf@concordia.ellerman.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183467019394764?=
X-GMAIL-MSGID: =?utf-8?q?1599865491898368469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 07 May 2018 20:35:42 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Tue, 01 May 2018 19:48:58 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >  
> >> On Tue, 2018-05-01 at 00:55 +1000, Nicholas Piggin wrote:  
> >> > The RAW console does not need writes to be atomic, so relax
> >> > opal_put_chars to be able to do partial writes, and implement an
> >> > _atomic variant which does not take a spinlock. This API is used
> >> > in xmon, so the less locking that is used, the better chance there
> >> > is that a crash can be debugged.    
> >> 
> >> Same comment I already had :-) "atomic" in Linux tends to mean
> >> something else (ie, atomic context), so I'd rather have something
> >> like opal_put_chars_sync() or such...  
> >
> > Oh yeah, I didn't ignore you, just... I thought atomic was okay.
> > atomic *also* tends to mean happens atomically. I think the in
> > atomic context meaning actually tends to be inatomic.
> >
> > Sync I actually thought could be more easily confused with
> > synchronous vs asynchronous here.  
> 
> I think we probably want opal_put_chars() to stay as it is.
> 
> And then add a variant for the call (just xmon?) that want lock free
> behaviour.

No it's not the lock which is important here, it is whether the
message goes to the console atomically versus other writes. The
raw console does not require this, only one which sends some
control characters, which is the hvterm-protocol compatible variant
of the vio console, and I think FSP console.

BMC consoles for example always use raw.

> opal_put_chars_unlocked() or something?

I prefer the _atomic as the special case. Ordinarily we don't have
a special requirement, but with the control characters then we do.

Thanks,
Nick
