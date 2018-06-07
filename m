Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8KtdMKOhGVtkbQAAmS7hNA
	; Thu, 07 Jun 2018 21:21:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7310A608BA; Thu,  7 Jun 2018 21:21:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EEA5760115;
	Thu,  7 Jun 2018 21:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEA5760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeFGVVW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:21:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:28726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbeFGVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:21:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 14:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="48167652"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2018 14:21:19 -0700
Message-ID: <1528406288.5794.1.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 07 Jun 2018 14:18:08 -0700
In-Reply-To: <D1A84B62-E971-4ECD-A873-2072F2692382@gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-10-yu-cheng.yu@intel.com>
         <D1A84B62-E971-4ECD-A873-2072F2692382@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 14:09 -0700, Nadav Amit wrote:
> Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> > mm/madvise.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 4d3c922ea1a1..2a6988badd6b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -839,6 +839,14 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > 	if (vma && start > vma->vm_start)
> > 		prev = vma;
> > 
> > +	/*
> > +	 * Don't do anything on shadow stack.
> > +	 */
> > +	if (vma->vm_flags & VM_SHSTK) {
> > +		error = -EINVAL;
> > +		goto out_no_plug;
> > +	}
> > +
> > 	blk_start_plug(&plug);
> > 	for (;;) {
> > 		/* Still start < end. */
> 
> What happens if the madvise() revolves multiple VMAs, the first one is not
> VM_SHSTK, but the another one is? Shouldn’t the test be done inside the
> loop, potentially in madvise_vma() ?
> 

I will fix it.  Thanks!
