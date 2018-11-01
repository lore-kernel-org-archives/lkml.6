Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA79C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0761204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I8sNO71V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0761204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeKBG32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:29:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34333 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeKBG32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:29:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so3046363ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6l0oXKTWmF6192MGpX+vILDY+h+riejuNP24DHkSMWM=;
        b=I8sNO71VG7+Std248CcLp382Pq6vk7t03j5Y8qjTm5RhyHYruHMZNnaak081W3c180
         NqOO57k44MhEq1DIrVf/Db6Otw1p3LYTskn+xJCzc3fpKqsnoG9urVzDtDpCiftuXqfD
         7G/pPHstYrW9uUpSAG2ZvNZHa6/wH/SDVX0IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6l0oXKTWmF6192MGpX+vILDY+h+riejuNP24DHkSMWM=;
        b=T+PIx0m7Z6tiAEbhzvC/vS+PsgjLR2zLQ69Vk/obRuqF3vX6HI4KZiXFrxNg0CIz33
         MaW3b4Pa+Rc5xqG6ca7WGzNIrkwfwiGlMsooZs8LeFK/5LjOypPOYHeSzBHiAiDKa4gs
         ZSYLcq82JWTw29I1aVaBBmEY06LX1PPVRGYawb8PQRMK+6nETdL1uPgwf+VVrzdo9I6H
         kV2YJ5EfUpIVkoUOOw3NlF3Y8JMzArGgWeJ3fR0JLNkyon6UG+Zqs//jZxi9h96E/77Z
         hjnTSWX1XpLqrKaRDaFp4hwfj6+vJlTxDt8fDkrhAAT71PttLbFR0P29oZNJ8wsts8bk
         4tqQ==
X-Gm-Message-State: AGRZ1gLMEGhAgV7Bxh/jJ3w0NBg0j77/w9mwV0RYtA1fHTwIuNNMnrAq
        PWi8YXyNhv76e9AzmoZ9V8+deToLLOGZhw==
X-Google-Smtp-Source: AJdET5d3vx6XQwX4jzdS4vkmb4sBiJDNO4CKDISSyGS3LwhDe3i8Mpv9iYUr6OfGLr/WuapR5wZvNA==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr5219874lja.24.1541107484573;
        Thu, 01 Nov 2018 14:24:44 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w21-v6sm595099lfe.73.2018.11.01.14.24.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:24:43 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id c4-v6so19384565lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:24:43 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr6043318ljh.118.1541107482506;
 Thu, 01 Nov 2018 14:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <CAG48ez0vBqL0tyfWwmuc_cq+OAUoEi88=r+t6h64a-Fw8z59zA@mail.gmail.com>
 <20181101185225.GC5150@brightrain.aerifal.cx> <CAHk-=wgFo8tuZX5gzCfWGdAwGyn_Ar9JFnnMFNuwr9=vtfDV1g@mail.gmail.com>
 <20181101193107.GE5150@brightrain.aerifal.cx>
In-Reply-To: <20181101193107.GE5150@brightrain.aerifal.cx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 14:24:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com>
Message-ID: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
To:     dalias@libc.org
Cc:     Jann Horn <jannh@google.com>, luto@kernel.org,
        dave.hansen@linux.intel.com, sean.j.christopherson@intel.com,
        jethro@fortanix.com, jarkko.sakkinen@linux.intel.com,
        fweimer@redhat.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        carlos@redhat.com, adhemerval.zanella@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:31 PM Rich Felker <dalias@libc.org> wrote:
>
> See my other emails in this thread. You would register the *address*
> (in TLS) of a function pointer object pointing to the handler, rather
> than the function address of the handler. Then switching handler is
> just a single store in userspace, no syscalls involved.

Yes.

And for just EENTER, maybe that's the right model.

If we want to generalize it to other thread-synchronous faults, it
needs way more information and a list of handlers, but if we limit the
thing to _only_ EENTER getting an SGX fault, then a single "this is
the fault handler" address is probably the right thing to do.

                     Linus
