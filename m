Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225GEWK0UHRQpldbfOj9fqmT57IQmUy3jK7e3/ptSFc5SZo9eMbD/yBNDswZWd6EoX8jIgg/
ARC-Seal: i=1; a=rsa-sha256; t=1519217658; cv=none;
        d=google.com; s=arc-20160816;
        b=LbtLuBkkDngDOC+JhKpg2SEgud092UG+zteeb0rvzviXq29+3LLGFvisEEpMha2XjQ
         47AB4BVS5onyYakqtCIww+X308MJ9zoj23vCm5uHe6t+Kk2frBCC5XAaDsebdVdOJJsN
         bP7aSwdCuzw4zFTLSQMtQMFXVvyU8iguzj+mhCWEqYd8+gdsHT/HhINt0Jon1xKQHi9z
         P/R0jHgbNSnvVQrk6JLIwGsuCFHxn5VKQxTCmj6JgAI4KfuEg1Giy/r0i0FtD/GEIaga
         11Fwq4p+Nb+qRoFU57deL4lSAFcNLzY79x28wm7L9hzWpJ/aMPuyQgt4bTEuyqvLMPMH
         UBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=HF2BIsBrZGZrbPmRg+h0tIkrhsZC8kBISduPYdzrkFQ=;
        b=RUJ8/RRVsb/092YRqxhcOoaenjy/AOpH9W4gqfFceuUCkWXe8dgEmkzSBsg+3gdVum
         gzAk9suCUExHQ+NSYVSNCpfWicjtBjhuM+mhzuachChflCwy7aD12a2G5f+jWJS6s7al
         32SJ9eVZOM/7ETpk43eKZ9jYd0RdzWSmpGkRiZqG50NU9SKK6W/kO/Br7vq8BAelYNa9
         jkn+wtY7a4LHamcUd3BBpwlz7FOsuzLfAm5tMZ21eeo/ElCEsFR33fYPGtkIQWCScR3P
         euBRwqh3BR3kdtLfg9AsilhiLKaPKA1955QpC/EvYzJpuezP7+9x1zcuMLTb/fXDWy9R
         vqjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=RwgQsnFk;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=RwgQsnFk;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 21 Feb 2018 13:53:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: hpa@zytor.com, luto@kernel.org, arjan@linux.intel.com,
	tglx@linutronix.de, dan.j.williams@intel.com,
	torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
	mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] objtool, retpolines: Integrate objtool with
 retpoline support more closely
Message-ID: <20180221125357.GJ25201@hirez.programming.kicks-ass.net>
References: <tip-b4879c9b99a43e6c580d563f292a569a016af2a4@git.kernel.org>
 <1519210754.6482.43.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519210754.6482.43.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007031866628709?=
X-GMAIL-MSGID: =?utf-8?q?1593015174903272818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:59:14AM +0000, David Woodhouse wrote:
> On Wed, 2018-02-21 at 02:34 -0800, tip-bot for Peter Zijlstra wrote:
> > 
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -489,6 +489,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> >  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> >  endif
> >  
> > +ifneq ($(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register),)
> > +  CC_HAS_RETPOLINE := 1
> > +endif
> > +export CC_HAS_RETPOLINE
> > +
> 
> That isn't the same as the check in arch/x86/Makefile.

That's because this crossed with the llvm cruft, right? I'll have a
look.
