Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15576C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C840620693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C840620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeFLKDX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:03:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeFLKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:03:21 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fSg8x-0004I7-K1; Tue, 12 Jun 2018 12:03:15 +0200
Date:   Tue, 12 Jun 2018 12:03:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow
 stack
In-Reply-To: <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com> <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com> <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018, H.J. Lu wrote:
> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > Why is the lockout necessary?  If user code enables CET and tries to
> > run code that doesn't support CET, it will crash.  I don't see why we
> > need special code in the kernel to prevent a user program from calling
> > arch_prctl() and crashing itself.  There are already plenty of ways to
> > do that :)
> 
> On CET enabled machine, not all programs nor shared libraries are
> CET enabled.  But since ld.so is CET enabled, all programs start
> as CET enabled.  ld.so will disable CET if a program or any of its shared
> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
> checking so that CET can't no longer be disabled afterwards.

That works for stuff which loads all libraries at start time, but what
happens if the program uses dlopen() later on? If CET is force locked and
the library is not CET enabled, it will fail.

I don't see the point of trying to support CET by magic. It adds complexity
and you'll never be able to handle all corner cases correctly. dlopen() is
not even a corner case.

Occasionally stuff needs to be recompiled to utilize new mechanisms, see
retpoline ...

Thanks,

	tglx

