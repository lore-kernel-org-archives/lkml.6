Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C170C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347ED21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeLROGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:06:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLROGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:06:14 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZG0f-0002fd-Cp; Tue, 18 Dec 2018 15:06:09 +0100
Date:   Tue, 18 Dec 2018 15:06:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        yang.shi@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        sergey.senozhatsky.work@gmail.com, dima@arista.com, bp@alien8.de
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical
 sections
In-Reply-To: <20181218135153.GA101957@gmail.com>
Message-ID: <alpine.DEB.2.21.1812181504590.14031@nanos.tec.linutronix.de>
References: <1544738377-3848-1-git-send-email-longman@redhat.com> <20181217181712.GA5114@gmail.com> <CAHk-=wjhqBYmzOyg7LPjvZhoXr3Tr+k9+caG2ScdCtZeO6oJcQ@mail.gmail.com> <20181218135153.GA101957@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > So thinking that early_printk is any better is just puting your head in 
> > the sand.
> 
> ... at my own feet. ;-) Apologies to the syslog folks!
> 
> early_printk should still in principle be more robust: it tries to use as 
> little (no) locking as possible, and definitely tries to do no 
> allocations. It doesn't use syslog, nor any console locking, nor any 
> regular console drivers.
> 
> Which results in usability trade-offs: trashed screen output, mangled 
> lines. It's a superior debug facility when debugging particularly hairy 
> low level code - which most of the kernel isn't where it turns into an 
> inferior debugging method.
> 
> I thing a good solution would be PeterZ's force_early_printk boot knob, 
> for those low level folks who absolutely want to rely on printk always 
> working in some fashion.
> 
> ( I think it might even be possible to add a non-locked feature to 
>   early-printk that actually adds the messages to the syslog ring-buffer 
>   - without any notification/wakeup/serialization features. 'dmesg' is 
>   handy and its lack is the primary usability disadvantage of 
>   earlyprintk. )

There is work in progress on that... Should be in your inbox early next
year.

Thanks,

	tglx
