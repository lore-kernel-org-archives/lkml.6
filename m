Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FEBC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2A20E20
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S8V+RVYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD2A20E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbeGGUKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 16:10:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50509 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeGGUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 16:10:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so17663315wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XqMzAm+XcOKx02bKhnu4nkl3n3rW6S/mXcuAgvYzmLk=;
        b=S8V+RVYlcRcSAqtcUkMR0FVk/RVVQCrpd1mAOAO/XoJKtHqe+i2Y21Ju4HTC0vNShJ
         eGM8xPUH2x8JvvUWaZKv+vzPH8LLX3eBewQnN1ICxrTZ6wRybTu/FAat1W9irduaeuBp
         nwG+ZFhFwxDmRbP9Ayw8wz0OB9kazJitXfN/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XqMzAm+XcOKx02bKhnu4nkl3n3rW6S/mXcuAgvYzmLk=;
        b=hKbp5H9WXnxsKHloF4Fnjc+0Rl201azJMBY/XEJf7eYQxQD7Pk0tOq0gqsX+fVJBPg
         UGPZTQKLcYQBdAxjKd+ac5lcEDAQCvH+zOjekfOPM+crGtaS0v8+ACr6+nGN7CQzDtZG
         s0hZbOBUMG+MQ+6k4RN5jXDtNeR5RjXejzcyjJhq6+424Ef5IA+2IgoMT8Jp9peOrUqm
         1vnGoCU0qDSJ5nPez+V7LLKaY6foqY40pOCkSSyTDQHDbD1ofsoAQlGqa0QkxzD2BSKh
         iErtx05s06sr7vbDvT1dLYOUssICDLjZ8WdovltV1aA04CDMkaD6y4XMeHjRyaTZ2uzZ
         hiYw==
X-Gm-Message-State: APt69E1PWAR9BsLVBuuI1+221XBYu+li8QFDMoz1kmfI3LMTEbk1ju8+
        KIefq9Lfb3LdSf7SVGPXCf4kUA==
X-Google-Smtp-Source: AAOMgpdcAoCDeII2JyKfhvxJ2Q7GW/yI/Q2WhyU1tszekNfLASKJEAH9NYEjW7/T8+Q+9DLhm0b25w==
X-Received: by 2002:a1c:4004:: with SMTP id n4-v6mr8540740wma.83.1530994227210;
        Sat, 07 Jul 2018 13:10:27 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id s184-v6sm9623616wmf.5.2018.07.07.13.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 13:10:26 -0700 (PDT)
Date:   Sat, 7 Jul 2018 22:10:24 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180707201024.GB3225@andrea>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180706121716.GO2512@hirez.programming.kicks-ass.net>
 <20180707080845.GA346@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707080845.GA346@guoren>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 04:08:47PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 02:17:16PM +0200, Peter Zijlstra wrote:

> 	CPU0			CPU1
> 
> 	WRITE_ONCE(x, 1)	WRITE_ONCE(y, 1)
> 	r0 = xchg(&y, 2)	r1 = xchg(&x, 2)
> 
> must not allow: r0==0 && r1==0
> So we must add a smp_mb between WRITE_ONCE() and xchg(), right?

The state (r0==0 && r1==0) _must_ not be allowed in the above snippet (so,
even without the additional smp_mb() between WRITE_ONCE() and xchg()).  In
informal terms, xchg() provides the smp_mb().

Compare implementations of xchg() and xchg_relaxed().  The following could
also be helpful (in addition to the references pointed out earlier):

  Documentation/atomic_t.txt

  Andrea


> 
>  Guo Ren
> 
