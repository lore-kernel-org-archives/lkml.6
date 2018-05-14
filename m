Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526282920; cv=none;
        d=google.com; s=arc-20160816;
        b=FJTMEtpEcg7PDuamcU+BFYj9tG8Zec/4/Yoqkn+NT+KSLKNESpvFk3NbQqF0rKy7fR
         FXDCoIesopiEvRqbFSnPSh8WduLaNCIh3SNnvzyZYtiR7RjtzzQwOpz09fz+98CnDM9o
         x8jMG9l4SgWyqGAdMLXQun4zJd883V7vZySiDiHKqQuNeI6tEMUJwFuno63HdUpFIlXk
         oW/R7YIszS0gtRQcjAEqufnsmpsJjOhenoVPZmIRw7nuMpgjxCDtFPmrcaMBD+rGaY4i
         0mgJCVnHVF+g3JIgz0QVIMc967cCX9b1F/gXcJo4bYJs7jIro2d5lz+8ax5ggaqxO2mz
         bJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=S0jw+DYfPIbmJJ4dZdi45krwiy1aqz177paBqUVYDH4=;
        b=c21JgIcdmWMGqd612OOTU9SgXdM+GDEWDfdhZV++G/nI+pCGaVpt2lZKNHSFkAUoKc
         VXifs0qi8My8/B/ANhP22Fr20N2qRGQaWNzRWAM7zH2kg5yeaOwFAICoxSCbAVqhK+n2
         GXTYFcuzQznZXCZ66f28uIijic1wPxmucE/Ig+gC183MeV95gxxONuHkVbSJFZaJdCbp
         UrnmLiLTIPmkr0/kawIZXYcT+sdgE2CfrATPh7vxZbjQc72sxiClLgVRhpBGwAcZkmNV
         r5y1bJV2jmrPVWCoBds6G4VWy1tTLdj3yxXfgvecvKrGjpG4fAQrDuAYWkTlkqQtWynJ
         w4sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SzdRbMlP;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SzdRbMlP;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZo5HTv8DK4w27lI+32V34vwWlraYN63WWiU/ulPf/AU3uEH1I7PO5/ad40Auf+CnmwX1o2jGmJa0BEI6lTzvE4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 May 2018 09:28:19 +0200
Message-ID: <CACT4Y+aUV5XoynuhCnNTUNveQQGBhD8iHeYSMXbp7U6SVBAckw@mail.gmail.com>
Subject: Re: for_each_cpu() is buggy for UP kernel?
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dexuan Cui <decui@microsoft.com>, Ingo Molnar <mingo@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rakib Mullick <rakib.mullick@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600423640208046050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 13, 2018 at 8:21 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 8, 2018 at 11:24 PM Dexuan Cui <decui@microsoft.com> wrote:
>
>> Should we fix the for_each_cpu() in include/linux/cpumask.h for UP?
>
> As Thomas points out, this has come up before.
>
> One of the issues is historical - we tried very hard to make the SMP code
> not cause code generation problems for UP, and part of that was just that
> all these loops were literally designed to entirely go away under UP. It
> still *looks* syntactically like a loop, but an optimizing compiler will
> see that there's nothing there, and "for_each_cpu(...) x" essentially just
> turns into "x" on UP.  An empty mask simply generally doesn't make sense,
> since opn UP you also don't have any masking of CPU ops, so the mask is
> ignored, and that helps the code generation immensely.
>
> If you have to load and test the mask, you immediately lose out badly in
> code generation.
>
> So honestly, I'd really prefer to keep our current behavior. Perhaps with a
> debug option that actually tests (on SMP - because that's what every
> developer is actually _using_ these days) that the mask isn't empty. But
> I'm not sure that would find this case, since presumably on SMP it might
> never be empty.

This looks like the problem automated testing traditionally and
effectively solves. If UP is an important config, there must be
automated pre/post commit checks for this.
