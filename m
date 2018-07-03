Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47160C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CE823C19
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CE823C19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeGCQsA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:48:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:17109 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933992AbeGCQr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:47:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 09:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="69780405"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2018 09:47:54 -0700
Date:   Tue, 3 Jul 2018 10:47:54 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
Message-ID: <20180703164754.GB30451@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, mingo@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org
References: <20180702165803.GB19488@linux.intel.com>
 <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:16:10PM -0700, Dan Williams wrote:
> All copy_to_user() implementations need to be prepared to handle faults
> accessing userspace. The __memcpy_mcsafe() implementation handles both
> mmu-faults on the user destination and machine-check-exceptions on the
> source buffer. However, the memcpy_mcsafe() wrapper may silently
> fallback to memcpy() depending on build options and cpu-capabilities.
> 
> Force copy_to_user_mcsafe() to always use __memcpy_mcsafe() when
> available, and otherwise disable all of the copy_to_user_mcsafe()
> infrastructure when __memcpy_mcsafe() is not available, i.e.
> CONFIG_X86_MCE=n.
> 
> This fixes crashes of the form:
>     run fstests generic/323 at 2018-07-02 12:46:23
>     BUG: unable to handle kernel paging request at 00007f0d50001000
>     RIP: 0010:__memcpy+0x12/0x20
>     [..]
>     Call Trace:
>      copyout_mcsafe+0x3a/0x50
>      _copy_to_iter_mcsafe+0xa1/0x4a0
>      ? dax_alive+0x30/0x50
>      dax_iomap_actor+0x1f9/0x280
>      ? dax_iomap_rw+0x100/0x100
>      iomap_apply+0xba/0x130
>      ? dax_iomap_rw+0x100/0x100
>      dax_iomap_rw+0x95/0x100
>      ? dax_iomap_rw+0x100/0x100
>      xfs_file_dax_read+0x7b/0x1d0 [xfs]
>      xfs_file_read_iter+0xa7/0xc0 [xfs]
>      aio_read+0x11c/0x1a0
> 
> Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
