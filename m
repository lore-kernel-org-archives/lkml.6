Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA74C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80221D6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oePMeU5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE80221D6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeHIOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:43:32 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39538 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeHIOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:43:31 -0400
Received: by mail-yw1-f66.google.com with SMTP id r184-v6so4039095ywg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=235R2Z2HUAMhiwaerFVujHvTdKPz36U06xTW02EYo9Q=;
        b=oePMeU5vcFyHYLLmicKUiwaZoBOW1ev+V4RszNVQK7ECyxF8mmjWDVcrddGpMUu5rG
         gwDwmrx7B3jqV7mVcNCvCWMN+QIALZpu+Z7F3OyY+tzFXCpPs7XnlY+NSk7IHy+aii3+
         ryyuoVAdbyKf5t62NCrBhkOX8dgjOOcctgCmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=235R2Z2HUAMhiwaerFVujHvTdKPz36U06xTW02EYo9Q=;
        b=EfsJqgWKRxA0jycn7gMhvHznF0MUxC/mniszX6xhWMpWpGxyEie9WznjVnrHAm4eHP
         HTQrQzB66neJGh76ojISKh629BSrMeVMyvE60U8gm3N1dajncPsoedkvjrHvLDhS/Hab
         /qQ6ifG8Jw3znPZAwPG7QO4fKSiAavg5bjaTAxa/wf3gXmC911LQYxxF+CQJu9/xDIHu
         Mg8wC/uAhSZHGbRyJ94aKH3BIs2lvzRA0s4St11tMGQHFk9Q/lr9khHpokxNd+jINRi1
         SUqnzNRaordV95vJwHhagNI61K0HFDtWG6PGAHn9l4RCVA5m3d9Ey1M1lDkDepdwhn7C
         CLog==
X-Gm-Message-State: AOUpUlH2jjcdJ7mODRNAgUMaTn+FCWi2EaBoI7CIJGfDOOLqg4XH/5PK
        DLAHUzEBAqJSAUPgVDFdkQevGQ==
X-Google-Smtp-Source: AA+uWPy3gKGztuqPYvSDSRiy1mlvy1vkJI8Q3ryvJEDuBXlslUSpHjGKxzTbHln6SYnU8gPt+VcYLA==
X-Received: by 2002:a25:a123:: with SMTP id z32-v6mr867172ybh.132.1533817133153;
        Thu, 09 Aug 2018 05:18:53 -0700 (PDT)
Received: from ?IPv6:2601:5c2:201:936:c82:33c8:d637:7bc8? ([2601:5c2:201:936:c82:33c8:d637:7bc8])
        by smtp.gmail.com with ESMTPSA id o204-v6sm3144730ywd.16.2018.08.09.05.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:18:52 -0700 (PDT)
Date:   Thu, 09 Aug 2018 08:18:50 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180808224716.GE24813@linux.vnet.ibm.com>
References: <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com> <20180807222856.3ede96e7@vmware.local.home> <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com> <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com> <20180808130041.GI24813@linux.vnet.ibm.com> <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com> <20180808144922.GN24813@linux.vnet.ibm.com> <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com> <20180808201852.GZ24813@linux.vnet.ibm.com> <CAJWu+op0H9vry70YXx6x3e37Sxsgb45go7B9MmE-y2O5wdLOYg@mail.gmail.com> <20180808224716.GE24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and unify their usage
To:     paulmck@linux.vnet.ibm.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joelaf@google.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
From:   joel@joelfernandes.org
Message-ID: <15F36BF3-DB5D-46F6-B4F2-E8A2525FC406@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 8, 2018 6:47:16 PM EDT, "Paul E=2E McKenney" <paulmck@linux=2Evn=
et=2Eibm=2Ecom> wrote:
>On Wed, Aug 08, 2018 at 03:15:31PM -0700, Joel Fernandes wrote:
>> On Wed, Aug 8, 2018 at 1:18 PM, Paul E=2E McKenney
>> <paulmck@linux=2Evnet=2Eibm=2Ecom> wrote:
>> [=2E=2E=2E]
>> >> >> >> It does start to seem like a show stopper :-(
>> >> >> >
>> >> >> > I suppose that an srcu_read_lock_nmi() and
>srcu_read_unlock_nmi() could
>> >> >> > be added, which would do atomic ops on
>sp->sda->srcu_lock_count=2E  Not sure
>> >> >> > whether this would be fast enough to be useful, but easy to
>provide:
>> >> >> >
>> >> >> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /*
>UNTESTED=2E */
>> >> >> > {
>> >> >> >         int idx;
>> >> >> >
>> >> >> >         idx =3D READ_ONCE(sp->srcu_idx) & 0x1;
>> >> >> >         atomic_inc(&sp->sda->srcu_lock_count[idx]);
>> >> >> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking
>critical section=2E */
>> >> >> >         return idx;
>> >> >> > }
>> >> >> >
>> >> >> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
>> >> >> > {
>> >> >> >         smp_mb__before_atomic(); /* C */  /* Avoid leaking
>critical section=2E */
>> >> >> >         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
>> >> >> > }
>> >> >> >
>> >> >> > With appropriate adjustments to also allow Tiny RCU to also
>work=2E
>> >> >> >
>> >> >> > Note that you have to use _nmi() everywhere, not just in NMI
>handlers=2E
>> >> >> > In fact, the NMI handlers are the one place you -don't- need
>to use
>> >> >> > _nmi(), strangely enough=2E
>> >> >> >
>> >> >> > Might be worth a try -- smp_mb__{before,after}_atomic() is a
>no-op on
>> >> >> > some architectures, for example=2E
>> >> >>
>> >> >> Continuing Steve's question on regular interrupts, do we need
>to use
>> >> >> this atomic_inc API for regular interrupts as well? So I guess
>> >> >
>> >> > If NMIs use one srcu_struct and non-NMI uses another, the
>current
>> >> > srcu_read_lock() and srcu_read_unlock() will work just fine=2E  If
>any given
>> >> > srcu_struct needs both NMI and non-NMI readers, then we really
>do need
>> >> > __srcu_read_lock_nmi() and __srcu_read_unlock_nmi() for that
>srcu_struct=2E
>> >>
>> >> Yes, I believe as long as in_nmi() works reliably, we can use the
>> >> right srcu_struct (NMI vs non-NMI) and it would be fine=2E
>> >>
>> >> Going through this thread, it sounds though that this_cpu_inc may
>not
>> >> be reliable on all architectures even for non-NMI interrupts and
>> >> local_inc may be the way to go=2E
>> >
>> > My understanding is that this_cpu_inc() is defined to handle
>interrupts,
>> > so any architecture on which it is unreliable needs to fix its bug=2E
> ;-)
>>=20
>> Yes that's my understanding as well=2E
>>=20
>> Then may be I'm missing something about yours/Steve's conversations
>in
>> the morning, about why we need bother with the local_inc then=2E So the
>> current SRCU code with the separate NMI handle should work fine (for
>> future merge windows) as long as we're using a separate srcu_struct
>> for NMI=2E :-)
>
>I do believe that to be true=2E  But only as long as that separate
>srcu_struct is -only- used for NMI=2E
>
>If this is what you have been pushing for all along, please accept my
>apologies for my being slow!
>

That's ok, sorry I initially didn't describe it well which may have caused=
 confusion, but yes that's what I was pushing for=2E

>That said, your approach does require you to have a perfect way to
>distinguish between NMI and not-NMI=2E  If the distinguishing is even
>in the slightest imperfect, then some sort of NMI-safe SRCU reader
>approach is of course required=2E
>

Thanks Paul, agreed with everything and we are on the same page=2E

- Joel



>							Thanx, Paul
>
>> >> For next merge window (not this one), lets do that then? Paul, if
>you
>> >> could provide me an SRCU API that uses local_inc, then I believe
>that
>> >> coupled with this patch should be all that's needed:
>> >> https://lore=2Ekernel=2Eorg/patchwork/patch/972657/
>> >>
>> >> Steve did express concern though if in_nmi() works reliably (i=2Ee=
=2E
>> >> tracepoint doesn't fire from "thunk" code before in_nmi() is
>> >> available)=2E Any thoughts on that Steve?
>> >
>> > Agreed, not the upcoming merge window=2E  But we do need to work out
>> > exactly what is the right way to do this=2E
>>=20
>> Agreed, thanks!
>>=20
>>  - Joel
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
