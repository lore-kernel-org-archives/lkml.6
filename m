Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C60C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81284207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfBDL62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:58:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:23151 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfBDL62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:58:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 03:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="113533776"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2019 03:58:23 -0800
Date:   Mon, 4 Feb 2019 13:58:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190204115823.GC26799@linux.intel.com>
References: <20190123153638.GA8727@linux.intel.com>
 <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <20190131204510.GA354@linux.intel.com>
 <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:04:35AM -0800, Linus Torvalds wrote:
> On Thu, Jan 31, 2019 at 12:45 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > I understand what you mean. Just surprised that this hasn't failed
> > before to anyone (the same driver has been even successfully used
> > on ARM64 with TrustZone based fTPM implementation). It has been in
> > for three years now.
> 
> Just to finish this thread off: it turns out that both ARM and ARM64
> worked fine, because neither did a memcpy(), but had explicit IO copy
> routines.
> 
> And in those explicit routines, 32-bit ARM did only byte accesses, and
> 64-bit ARM did 8-byte accesses for the bulk transfer part, but byte
> accesses for the unaligned head and tail of the IO area.
> 
> So I think it's all good. x86 used to work by luck (either because all
> machines that used that TPM chip always had ERMS, or because the
> people who didn't have it never cared), and ARM just worked because it
> would never do unaligned IO accesses anyway (well, I guess you can
> force them with "readl()" on an unaligned address, but then you just
> have yourself to blame).
> 
>            Linus

OK, thanks for the summary. This kind of answered to my question. Should
be sufficient to include the tpm_crb fix to the 5.1 PR.

/Jarkko
