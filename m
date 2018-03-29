Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeC2MoR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:44:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35968 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeC2MoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:44:15 -0400
X-Google-Smtp-Source: AIpwx4+fjt9WWDRA3N/RGpk4MaoQs3mSBl7OZA3Mxc+KEM3bEsP6X6n+5DE7J079mOfILQOc7TvqDA==
Date: Thu, 29 Mar 2018 15:43:38 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 12/14] x86/mm: Implement page_keyid() using page_ext
Message-ID: <20180329124338.vxzjpkz3ecyor5uc@node.shutemov.name>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-13-kirill.shutemov@linux.intel.com>
 <b4498b2b-5092-b347-e92d-6ebd375fd947@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4498b2b-5092-b347-e92d-6ebd375fd947@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 09:59:23AM -0700, Dave Hansen wrote:
> On 03/28/2018 09:55 AM, Kirill A. Shutemov wrote:
> > +static inline int page_keyid(struct page *page)
> > +{
> > +	if (!mktme_nr_keyids)
> > +		return 0;
> > +
> > +	return lookup_page_ext(page)->keyid;
> > +}
> 
> This doesn't look very optimized.  Don't we normally try to use
> X86_FEATURE_* for these checks so that we get the runtime patching *and*
> compile-time optimizations?

I didn't go to micro optimization just yet. I would like to see whole
stack functioning first.

It doesn't make sense to use cpu_feature_enabledX86_FEATURE_TME) as it
would produce false-positives: MKTME enumeration requires MSR read.

We may change mktme_nr_keyids check to a static key here. But this is not
urgent.

-- 
 Kirill A. Shutemov
