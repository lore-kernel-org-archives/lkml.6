Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D520861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhsCrcY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502373AbeKWSUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:20:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbeKWSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:20:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11305780wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsOhaFFbqBb50c7n1/YGzp0ZTroYYFhwz0y+O6vOw8k=;
        b=QhsCrcY33BS/IdsnSxfLI6csdoppe9eU3Irf0qjCdcDtIFe0PiJ17484jeo5fwRJx3
         Eq/QClN6hwcJwezSejey2beVGACTfipxjbYVENwh0SXaw2BUOtXelc3kE8TW8ttyxhx1
         xrIKJaEsZZq5fRrSpuXSFU5zm7MRpJ3WFG3bNOZOFeXoHIr78cyN25s9DCYtTUjDVFA0
         U2+nJesw5FAt+QF5t/c6woMzia2VjSeQnHlwV2HWDnFfVT6GErUWj12ili7FyJ902W01
         HIr8ExNYr1ZK/XavfIXKO52GNZwKwAMP+SXiPnnawOaTRt2ihk1aAci/SbFzxOgSs9Hg
         2lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsOhaFFbqBb50c7n1/YGzp0ZTroYYFhwz0y+O6vOw8k=;
        b=AUSlSPJEamr1eLPLj6tR2/V7VLlHjjF9/2IvDnAzNYeoWb642fcivC4kecouLAX4a3
         4EcqAQwFsYG4PWj/TpXrHd43WJD0y7xIwvihf9jm5qeUmC7SLPpxgdSOUCb/Zy0I11R5
         PVqxJ71xEZ8Mx6F4lBoumusfooctubNRfC6+mTk6BihmCUWFpiIZlHIHbbLlLIbtXuT8
         3zadwFG0jGKb1JMAK8wH11fT8RA7XPRl9wNb1eJAgpLeNxrek9J16d2u+5V0+INPVo9C
         2PLntUgJQPR2Q2IQXn2H8peqWQS5p1hN3NuOf2/vl3ZDTuJqdm00QuTJPuI2WevskiW0
         1b9Q==
X-Gm-Message-State: AA+aEWYQyD4Vxo5B8LJinkk+bo5kyhtwM8+uc69Ktpwf/ud5ukoGupHs
        BTTG6x/XSY9alHU8wUk+T5s=
X-Google-Smtp-Source: AFSGD/V8Twfg0PvSxjujIBlRF3v4C7dmq7Hlp4u8zySDUXuegq6AAmIov2LDa0+XlfSxc8GJyv6q5Q==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr13237565wri.138.1542958659137;
        Thu, 22 Nov 2018 23:37:39 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q14sm11490741wrw.39.2018.11.22.23.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:37:38 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:37:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
Message-ID: <20181123073735.GA12959@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.227260385@linutronix.de>
 <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com>
 <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 21 Nov 2018, Tim Chen wrote:
> 
> > On Wed, Nov 21, 2018 at 09:14:50PM +0100, Thomas Gleixner wrote:
> > > +static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
> > >  {
> > >       bool update;
> > >
> > > +     if (on)
> > > +             update = !test_and_set_tsk_thread_flag(tsk, tifbit);
> > > +     else
> > > +             update = test_and_clear_tsk_thread_flag(tsk, tifbit);
> > > +
> > > +     /*
> > > +      * If being set on non-current task, delay setting the CPU
> > > +	 * mitigation until it is scheduled next.
> > > +	 */
> > > +     if (tsk == current && update)
> > > +             speculation_ctrl_update_current();
> > 
> > I think all the call paths from prctl and seccomp coming here
> > has tsk == current.
> 
> We had that discussion before with SSBD:
> 
> seccomp_set_mode_filter()
>    seccomp_attach_filter()
>       seccomp_sync_threads()
>          for_each_thread(t)
> 	    if (t == current)
>               continue;
> 	    seccomp_assign_mode(t)
> 	      arch_seccomp_spec_mitigate(t);
> 
> seccomp_assign_mode(current...)
>   arch_seccomp_spec_mitigate();
> 
> > But if task_update_spec_tif gets used in the future where tsk is running
> > on a remote CPU, this could lead to the MSR getting out of sync with the
> > running task's TIF flag. This will break either performance or security.
> 
> We also had that discussion with SSBD and decided that we won't chase
> threads and send IPIs around. Yes, it's not perfect, but not the end of the
> world either. For PRCTL it's a non issue.

Fair enough and agreed - but please add a comment for all this, as it's a 
non-trivial and rare call context and a non-trivial implementation 
trade-off as a result.

Thanks,

	Ingo
