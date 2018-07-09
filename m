Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E8DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15BC20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15BC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeGIIUL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:20:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:30012 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbeGIIUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 01:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="55030422"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2018 01:20:07 -0700
Message-ID: <2b13ea726e792c0bc57a6b341d401311e8a7667b.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Jul 2018 11:20:06 +0300
In-Reply-To: <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
References: <20180706215003.156702-1-jannh@google.com>
         <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
         <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 09:41 +0200, Jann Horn wrote:
> On Mon, Jul 9, 2018 at 8:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > On Fri, 2018-07-06 at 23:50 +0200, Jann Horn wrote:
> > > Don't access the provided buffer out of bounds - this can cause a
> > > kernel
> > > out-of-bounds read when invoked through sys_splice() or other
> > > things
> > > that
> > > use kernel_write()/__kernel_write().
> > > 
> > 
> > Can you elaborate a bit this change?
> > 
> > Only few places in the kernel do this way and I would like to
> > understand
> >  why in most of the cases it's okay to supply maximum available
> > length
> > and here is not the one.
> 
> In many contexts, it is fine to do something like strncpy_from_user()
> with a fixed length without further checks - for example, in normal
> syscall handlers, or in ioctl handlers, because invocation of these
> implies an intent by the calling code to trigger specifically this
> behavior. ->read() and ->write() handlers are special exceptions that
> have to adhere to stricter rules because, in essence, reads and writes
> on files can be performed by one security context on a file that was
> maliciously supplied by another security context. In other words,
> invocation of ->read() and ->write() doesn't imply caller intent
> beyond "I want to move this many bytes between that file and this
> buffer". Specifically, this can happen in two ways:
> 
>  - A malicious user can pass an arbitrary file to a setuid binary as
> stdin/stdout/stderr. When the setuid binary (expecting stdin/stdout to
> be something normal, like a proper file or a pipe) then calls read(0,
> <buf>, <len>), if the kernel disregards the length argument and writes
> beyond the end of the buffer, it can corrupt adjacent userspace data,
> potentially allowing a user to escalate their privileges; a write
> handler is somewhat less interesting because it can probably (as in
> this case) only leak out-of-bounds data from the caller, not corrupt
> it, but it's still a concern in theory.
>  - Almost any ->read() and ->write() handler can be invoked by the
> kernel with a buffer argument that points at a *kernel* buffer; when
> this happens, *the address limit checks are disabled*, allowing the
> ->read() or ->write() handler to read and write *kernel memory* using
> copy_from_user()/copy_to_user() and other "userspace" accessor
> functions. The easiest way to trigger this behavior from userspace is
> to use sys_splice().
> 
> It's not a big deal in this case because if you can open the mtrr
> device, you're probably very highly privileged already, and it's just
> a read, not a write, and the data has to adhere to a rather specific
> format to be parsed to a point where an attacker could grab the parsed
> data - but it's still wrong.

Thanks for the above explanation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
