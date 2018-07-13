Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294722077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NEz/zxfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294722077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGMTWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:22:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeGMTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:22:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id a9-v6so3484121wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJC2IfbNWYV+dXsYGTeEVEuIEQQOCKivIlUXiLQkFEs=;
        b=NEz/zxfA7v6JV44PxBAlXQdhbvoPxddyhlOilISJV6YC80eMOC8gSCQlNLkf3DvrgQ
         0+/qP0TxyEzOZ3apCm/RpYqWS8Tk411xlu7i7/fApFtOJJl1jDz7+fnssVUqfGZNDX2E
         UyD9cMn5ZjCHAWirBpcPQUbVYkxrH2mII/EWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJC2IfbNWYV+dXsYGTeEVEuIEQQOCKivIlUXiLQkFEs=;
        b=DA1FNlmGBDKtJvVcGzDcj5Z/zVLPZuslsXN4Dr3Sbo2gndl7HuszoEUb8h8Ge5MOnL
         5tV6hDQKtToDlv5ZI42tCowbFLl5UV4j3i3TWqhPvXq5sgNM9+LzxTrJgOTVFy6RAkQY
         zU74haRKzdmbHIb64N5kGf+3fcxyBNo5Q61myngNRT3Gs44AqkicmiqvC01113/UX//K
         9g+USrzUcTYyt4U5q+fIBgnHpF08Ptz7hYc31yv/cyNxolfYdtbp/v0OW+hSeB+fTrqY
         zcN9++HS4eQzyb3cTa7FCr4Wd4foyHzbhAXG00lwGNzr+/FqU2mzmousJQjbIXlPWmqg
         kEzg==
X-Gm-Message-State: AOUpUlEWTbGggf7l+ITRiQKy2oEWRjrwnzMdtuQGAAdduCZCTlANraVF
        ApoiI3gvikqWziSay7+OE1whkg==
X-Google-Smtp-Source: AAOMgpflIF/73pzpkJLOcTc+ggfXpNrZvqIztc1xBY231Ak4s0T9onkCXfhxbASXZuTfnJSFy7+B4Q==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr4895699wmd.9.1531508805158;
        Fri, 13 Jul 2018 12:06:45 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id o4-v6sm46620202wra.3.2018.07.13.12.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 12:06:44 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:06:38 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180713190638.GA4269@andrea>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
 <20180713090637.GA10601@andrea>
 <20180713093524.GC32020@arm.com>
 <CA+55aFznCVzoc07p2=eP_5NuTKybMm8-_7+gUMNsAoOP70aYtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFznCVzoc07p2=eP_5NuTKybMm8-_7+gUMNsAoOP70aYtw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:16:48AM -0700, Linus Torvalds wrote:
> On Fri, Jul 13, 2018 at 2:34 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > And, since we're stating preferences, I'll reiterate my preference towards:
> >
> >         * RCsc unlock/lock
> >         * RCpc release/acquire
> 
> Yes, I think this would be best. We *used* to have pretty heavy-weight
> locking rules for various reasons, and we relaxed them for reasons
> that weren't perhaps always the right ones.
> 
> Locking is pretty heavy-weight in general, and meant to be the "I
> don't really have to think about this very much" option. Then not
> being serializing enough to confuse people when it allows odd behavior
> (on _some_ architectures) does not sound like a great idea.
> 
> In contrast, when you do release/acquire or any of the other "I know
> what I'm doing" things, I think we want the minimal serialization
> implied by the very specialized op.

The changes under discussion are _not_ affecting uses such as:

  P0:
  spin_lock(s);
  UPDATE data_struct
  spin_unlock(s);

  P1:
  spin_lock(s);
  UPDATE data_struct
  spin_unlock(s);

  [...]

(most common use case for locking?):  these uses work just _fine_ with 
the current implementations and in LKMM.

OTOH, these changes are going to affect uses where threads interact by
"mixing" locking and _other_ synchronization primitives such as in:

  { x = 0; y = 0; }

  P0:
  spin_lock(s);
  WRITE_ONCE(x, 1);
  spin_unlock(s);

  P1:
  spin_lock(s);
  r0 = READ_ONCE(x);
  WRITE_ONCE(y, 1);
  spin_unlock(s);

  P2:
  r1 = smp_load_acquire(&y);
  r2 = READ_ONCE(x);

  BUG_ON(r0 == 1 && r1 == 1 && r2 == 0)

and

  { x = 0; y = 0; z = 0; }

  P0:
  spin_lock(s);
  WRITE_ONCE(x, 1);
  r0 = READ_ONCE(y);
  spin_unlock(s);

  P1:
  spin_lock(s);
  WRITE_ONCE(y, 1);
  r1 = READ_ONCE(z);
  spin_unlock(s);

  P2
  WRITE_ONCE(z, 1);
  smp_mb();
  r2 = READ_ONCE(x);

  BUG_ON(r0 == 0 && r1 == 0 && r2 == 0)

(inspired from __two__ uses in kernel/{sched,rcu}).  Even if someone were
to tell me that locks serialize enough, I'd still be prompted to say "yes,
but do / can my BUG_ON()s fire?".

Actually, my very first reaction, before starting what does appear to be
indeed a long and complex conversation, would probably be to run/check the
above snippets against the (latest) LKMM, by using the associated tool.

Once "checked" with both people and automated models, I'd probably remain
suspicious about my "magic" code so that I most likely will be prompted to
dig into each single arch. implementation / reference manual...

... Time's up!

  Andrea
