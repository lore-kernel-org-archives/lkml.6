Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A5A21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EZ1hglX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfA3Ddm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:33:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35890 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfA3Ddm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:33:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so17837072edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKxogaXrSX2My+MZ86bWjV23x1KXve7ZA5eu/yxYnRo=;
        b=EZ1hglX031U+6FiDV8hTHjPvPlT3Lwypddzp4x/B5qYtqdIyYZiOlHIl6gn9FBOnzB
         q/vGTnT5IyLArbb/alvWu09BzpRRNYlJKmwqbvZ6akJZk0TT1LpJoHRUoAsnEAt47wW5
         4zx1ndeh5rQ+UoJn7VQELhNgGTiIVHAHR8gRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKxogaXrSX2My+MZ86bWjV23x1KXve7ZA5eu/yxYnRo=;
        b=jKtPGwb/iD6iKNahSwHzbvk+ToKGxPMaaS3Y+eheJmL4+zjPgFRIIkbCQX0uiekhnN
         8E8Y0O/oBF3L3xZybd7PPCioS1IVVRvm3++5MORiekMeCj5W2kAMh5lztMf0sGcqPfxN
         bVdMh9I7fzxWoYqyutiV3x7IPFn8grCcbJqXZBmyGL8Rovh/kuxcMmrumQTyc8CkiKSa
         052/3OkBp61dulKnFvuyREJ6CvnMs7d7V5PWx931nf883FlrsNpxnoNxgS3d94HVbNQO
         w+LmsirOGEU5EABoR3Sp2QiAGxxxVqGLsgcEOpvV0nNX2vVerfAKFckQ6gO9igCFKUn0
         7p6A==
X-Gm-Message-State: AJcUuke2kj85R8Rre6aki0tQgXeKTIOyHGZJmxVRdlH/XLWW+vGCOrhH
        GTF+W/iAzeyBWga3Ajz/rtadKA==
X-Google-Smtp-Source: ALg8bN44uhtSxLkW6Kd9tW85PPw6oV2ZcDlCqkRMZOUV+E2ovfGtoyGO8fuIYpAisT0mTDOuoH0PKw==
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr28426523edx.208.1548819219925;
        Tue, 29 Jan 2019 19:33:39 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id b9sm182317ede.12.2019.01.29.19.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 19:33:38 -0800 (PST)
Date:   Wed, 30 Jan 2019 04:33:33 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Message-ID: <20190130032701.GA3739@andrea>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B99139@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B99139@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, you are saying that ACQUIRE does not guarantee that "po-later stores
> on the same CPU and all propagated stores from other CPUs
> must propagate to all other CPUs after the acquire operation "? 
> I was reading about acquire before posting this and trying to understand,
> and this was my conclusion that it should provide this, but I can easily be wrong
> on this. 
> 
> Andrea, Peter, could you please comment?

Short version:  I am not convinced by the above sentence, and I suggest
to remove it (as done in

  http://lkml.kernel.org/r/20190128142910.GA7232@andrea ).

---
To elaborate:  I think that we should first discuss the meaning of that
"[...] after the acquire operation (does)",  because there is no notion
of "ACQUIRE (or more generally, load) propagation" in the LKMM:

Stores propagate (after being executed) to other CPUs.  Loads _execute_
(possibly multiple times /speculatively, but this is irrelevant for the
discussion below).

A detailed, but still informal, description of these concepts is in:

  tools/memory-model/Documentation/explanation.txt

(c.f., in particular, section "AN OPERATIONAL MODEL"); I can illustrate
them with an example:

	{ initially: x=0, y=0; }

	CPU0			CPU1
	--------------------------------------
	LOAD-ACQUIRE x=0	LOAD y=1
	STORE y=1

In this scenario,

  a) CPU0's "LOAD-ACQUIRE x=0" executes before CPU0's "STORE y=1"
     executes (this is guaranteed by the ACQUIRE),

  b) CPU0's "STORE y=1" executes before "STORE y=1" propagates to
     CPU1 (a store cannot be propagated before being executed),

  c) CPU0's "STORE y=1" propagates to CPU1 before CPU1's "LOAD y=1"
     executes (since CPU1 "sees the store"). 

The example also illustrates the following property:

  ACQUIRE guarantees that po-later stores on the same CPU must
  propagate to all other CPUs after the acquire _executes_.

(combine (a) and (b) ).

OTOH, please notice that:

  ACQUIRE does _NOT_ guarantee that all propagated stores from
  other CPUs (to the CPU executing the ACQUIRE) must propagate
  to all other CPUs after the acquire operation _executes_.

In fact, we've already seen how full barriers can be used to break such
"guarantee"; for example, in

	{ initially: x=0, y=0; }

	CPU0			CPU1			...
	---------------------------------------------------
	STORE x=1		LOAD x=1	
				FULL-BARRIER
				LOAD-ACQUIRE y=0

the full barrier forces CPU0's "STORE x=1" (seen by/propagated to CPU1)
to be propagated to all CPUs _before_ "LOAD-ACQUIRE y=0" is executed.

Does this make sense?


> > Is ACQUIRE strictly stronger than control dependency?
> 
> In my understanding yes.

+1 (or we have a problem)


>
> > It generally looks so unless there is something very subtle that I am
> > missing. If so, should we replace it with just "RELEASE ordering +
> > ACQUIRE ordering on success"? Looks simpler with less magic trickery.
> 
> I was just trying to mention all the applicable orderings/guarantees. 
> I can remove "control dependency" part if it is easier for people to understand
> (the main goal of documentation).

This sounds like a good idea; thank you, Dmitry, for pointing this out.

  Andrea


> 
> Best Regards,
> Elena.
