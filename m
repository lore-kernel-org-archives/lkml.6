Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeENVvC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:51:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:38085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeENVvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="55159479"
Date: Tue, 15 May 2018 00:50:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: Introduce 'no5lvl' kernel parameter
Message-ID: <20180514215057.yodhn3nk37fnsxui@black.fi.intel.com>
References: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
 <20180511120859.26375-3-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1805132339240.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805132339240.1582@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 09:55:00PM +0000, Thomas Gleixner wrote:
> On Fri, 11 May 2018, Kirill A. Shutemov wrote:
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -1008,6 +1008,12 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
> >  	 */
> >  	setup_clear_cpu_cap(X86_FEATURE_PCID);
> >  #endif
> > +
> > +#ifdef CONFIG_X86_5LEVEL
> > +	/* Clear the 5-level paging feature if user asked for 'no5lvl' */
> 
> no5lvl is only one reason why 5 level paging is not available.

The 5-level paging may not be available for few reasons:
 - CONFIG_X86_5LEVEL=n
 - Machine doesn't support X86_FEATURE_LA57 -- clearing is nop;
 - User asked for 'no5lvl'.

To me the one-line comment reflects the situation reasonably well.

Do you want more verbose comment here?

> > +	if (!__pgtable_l5_enabled)
> > +		setup_clear_cpu_cap(X86_FEATURE_LA57);
> > +#endif
> 
> And that #ifdeffery can be avoided by simply doing:
> 
> 	if (IS_ENABLED(CONFIG_X86_5LEVEL) && !pgtable_l5_enabled)
> 		setup_clear_cpu_cap(X86_FEATURE_LA57);
> 
> Hmm?

Unfortunately, no.

pgtable_l5_enabled is defined as cpu_feature_enabled(X86_FEATURE_LA57).
So with such change we would only clear the feature bit if it's already
clear.

-- 
 Kirill A. Shutemov
