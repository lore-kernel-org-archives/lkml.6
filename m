Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C14206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C14206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407847AbeKWJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 04:42:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392559AbeKWJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 04:42:42 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPxxw-0005pQ-H6; Fri, 23 Nov 2018 00:00:56 +0100
Date:   Fri, 23 Nov 2018 00:00:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
In-Reply-To: <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Tim Chen wrote:

> On Wed, Nov 21, 2018 at 09:14:50PM +0100, Thomas Gleixner wrote:
> > +static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
> >  {
> >       bool update;
> >
> > +     if (on)
> > +             update = !test_and_set_tsk_thread_flag(tsk, tifbit);
> > +     else
> > +             update = test_and_clear_tsk_thread_flag(tsk, tifbit);
> > +
> > +     /*
> > +      * If being set on non-current task, delay setting the CPU
> > +	 * mitigation until it is scheduled next.
> > +	 */
> > +     if (tsk == current && update)
> > +             speculation_ctrl_update_current();
> 
> I think all the call paths from prctl and seccomp coming here
> has tsk == current.

We had that discussion before with SSBD:

seccomp_set_mode_filter()
   seccomp_attach_filter()
      seccomp_sync_threads()
         for_each_thread(t)
	    if (t == current)
              continue;
	    seccomp_assign_mode(t)
	      arch_seccomp_spec_mitigate(t);

seccomp_assign_mode(current...)
  arch_seccomp_spec_mitigate();

> But if task_update_spec_tif gets used in the future where tsk is running
> on a remote CPU, this could lead to the MSR getting out of sync with the
> running task's TIF flag. This will break either performance or security.

We also had that discussion with SSBD and decided that we won't chase
threads and send IPIs around. Yes, it's not perfect, but not the end of the
world either. For PRCTL it's a non issue.

Thanks,

	tglx
