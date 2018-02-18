Return-Path: <rientjes@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518996025; cv=none;
        d=google.com; s=arc-20160816;
        b=dq/wBjiCJNdoMnaLVUl2vEI1WGAk+cF44lMvvQA1u21zxZtZuoLWCS3/ylfMgGBT/4
         lEMUM+7KWsOW7u2HAX40yfVImBpVYC4z/8NsCMxKYmnbUfmqEmsvPqQhrWxqdVGea5N3
         WjL8yXUIEHRPUaEFjs9PbCtHM35X9zMR/tvyqqZRfrOUzm0BTbcIT8pW1aQkV7aDqcOe
         XApulAOPxwMSirgArTDKSh6tGDELgAHlR89iLETwHq7nrfwEk7jZMDFx8CgaOH7vB7ss
         dxm/60vepffxIcUDcx/MZNWPbeBsNJiiqnioryEWRw5QTI6PrxKxk/hxrDrY+/9VJewc
         0znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=8Vcs4oUCl13hzwYFZArR84tDNwtQ4fXRFs8Y1ZZkkC0=;
        b=cufnCkCSoFrvpXaDsD/2stxiENo7VRaUnu4h+GjkOzbe3Cz6ePE9suVy6BIaTKo3Q1
         Cd3qNB0HBhfov7zhQUKOOeE3MjaVUn95V2iugSYf77j/iCDvpcDhg3BRc7xZo4xArKIz
         0t6wUiCNlEoj8JB4dhYn53tSHgFLPGFx6jUTkmYJlfTwk8+hLlICW01mJqxPtieEn4lI
         a52N0G663QM+Cb2YYNK5f73IUe9Tpw/3MMc6JDfayVy1Q4UWdx9uLN5UKtZ8HQJ5Q4Wc
         dNsDuBSJtEJ5BaF3Ykdy4fa2VW3t5Za/i/tDdZP3K70rOvoJAFvTaKljgks/QXvhEYbR
         zgCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aCSFyx2J;
       spf=pass (google.com: domain of rientjes@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rientjes@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aCSFyx2J;
       spf=pass (google.com: domain of rientjes@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rientjes@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x2259DuJQaESA1Ki4atpmNpLuzAtoFyFAGh1IHSWVuIKDaP1hhJam7MYRYry1MTtTB/bwdGsyUQ==
Date: Sun, 18 Feb 2018 15:20:22 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
cc: mingo@kernel.org, jpoimboe@redhat.com, keescook@chromium.org,
    akpm@linux-foundation.org, tglx@linutronix.de, geert@linux-m68k.org,
    gregkh@linuxfoundation.org, thomas.lendacky@amd.com, will.deacon@arm.com,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
In-Reply-To: <20180217191035.gol4woxsgzpo4bfq@gmail.com>
Message-ID: <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1592782776165502691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Feb 2018, Miguel Ojeda wrote:

> From the GCC manual:
> 
> The nonstring variable attribute specifies that an object or member
> declaration with type array of char or pointer to char is intended to
> store character arrays that do not necessarily contain a terminating NUL
> character. This is useful in detecting uses of such arrays or pointers
> with functions that expect NUL-terminated strings, and to avoid warnings
> when such an array or pointer is used as an argument to a bounded string
> manipulation function such as strncpy.
> 
>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
> 
> Some reports are already coming to the LKML regarding these
> warnings. When they are false positives, we can use __nonstring to let
> gcc know a NUL character is not required; like in this case:
> 
>   https://lkml.org/lkml/2018/1/16/135
> 
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David Rientjes <rientjes@google.com>

I would have expected to have seen __nonstring used somewhere as part of 
this patch.
