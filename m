Return-Path: <kernel-hardening-return-12784-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx482VDBPPSem2+8DAeEokfeVpWXfMpFkUcmVGtUXjp4QG8GAN0Lxi0o/XTFU3r6a4bZQWanZ
ARC-Seal: i=1; a=rsa-sha256; t=1522197069; cv=none;
        d=google.com; s=arc-20160816;
        b=ZnB9y7Zr8TM/3WfPvrActrp5MfVh8fGpzEG4u50fw5MfiZFt+jI4/fM1J/5QJkdzab
         8LjgGEyhxF3wTReFGJtZ12S9hZPJD0oW4qoN6ht6oBjYPK2J2WSIY5AWigvLVCpZMwCp
         kvjfPqrqYsNcRsopeuS2ymJJa3QMghnElxQYIRdSu5rCRMDUYxBeTKJp0fijt70obeR1
         NsVEpC9Rh7DINNAai1+N2+SxsUDD6A3zk+MDHvW6+Z0va/DbKFPvReDmtM864eufMy9/
         3a6U9jK5EeAHecOBdEtYwSiIGWucXJ/apUGiGJFPBnXTkdy7OvbkpM41VF7oe1BKP/uR
         Clig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=djlhmsx+ZJnrmqM5pOnG1ezzUMPY6yrv7E9KOgLxv0c=;
        b=r7jXIG3InNUUgyGMbalPB2VQ7NuplnmKEHBAZkyTEIDt1ggOoKl2c7L0tzUOakxNhG
         UHjO+eSsV+cy68G21hUVMBRAC/kH86Ny7kgCBeKuwBNA+bc0szlpQkjUxhNTpp/PAuMO
         ANJT7d+dEnj1lvxlmcJefoGRO0G295CtR6AiE/cvWp4/3Qf/Y6mYH9JOqbtadrDnrn9k
         hMGtAGRp9xfQLhzzmVfOejzJ13tX19g6HP94JKs7oOlwUQecyuYiFhxBA4gMc29ReYdB
         gPhjEnsZrmn/0SQi34K4QGLt4kkLkjkrfOI03qOry6etYOQ92GKRQg5kf7dqNug9n/ov
         TRxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YKALMnu1;
       dkim=pass header.i=@chromium.org header.s=google header.b=F1i9iPbb;
       spf=pass (google.com: domain of kernel-hardening-return-12784-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12784-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YKALMnu1;
       dkim=pass header.i=@chromium.org header.s=google header.b=F1i9iPbb;
       spf=pass (google.com: domain of kernel-hardening-return-12784-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12784-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
References: <20180327213609.GA2964@beast> <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 17:30:47 -0700
X-Google-Sender-Auth: gSJeLzXdACe2H3dyeLOUDjvPtCE
Message-ID: <CAGXu5j+an4OwLMCqGMqCN=dh1GH-_PQTDGFL_WhpbOSNXgYynA@mail.gmail.com>
Subject: Re: [PATCH] task_struct: Only use anon struct under randstruct plugin
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596139314172992261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 4:03 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 27 Mar 2018 14:36:09 -0700 Kees Cook <keescook@chromium.org> wrote:
>> Reported-by: Peter Zijlstra <peterz@infradead.org>
>> Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
>> Cc: stable@vger.kernel.org
>
> Why cc:stable?

Since the padding existed in all configs, it's kind of an ugly wart
and should likely be fixed up for 4.14 and 4.15 -stable.

> So the mysterious 40 byte bloat is still present in this case?

Given how insane[1] task_struct can end up under randstruct, these 40
bytes aren't too bad. I've added fixing this to the randstruct to-do
list, but I don't view it as high priority.

-Kees
[1] https://git.kernel.org/linus/ffa47aa678cfaa9b88e8a26cfb115b4768325121

-- 
Kees Cook
Pixel Security
