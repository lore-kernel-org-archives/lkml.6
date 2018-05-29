Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966240AbeE2SWY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:22:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:3432 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965971AbeE2SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:22:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="228285740"
Date: Tue, 29 May 2018 11:22:21 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/3] x86/mce: Fix incorrect "Machine check from unknown
 source" message
Message-ID: <20180529182221.GA7847@otc-nc-03>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528204923.GB30792@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:49:23PM +0200, Borislav Petkov wrote:
> On Fri, May 25, 2018 at 02:41:55PM -0700, Tony Luck wrote:
> > @@ -1287,12 +1292,17 @@ void do_machine_check(struct pt_regs *regs, long error_code)
> >  			no_way_out = worst >= MCE_PANIC_SEVERITY;
> >  	} else {
> >  		/*
> > -		 * Local MCE skipped calling mce_reign()
> > -		 * If we found a fatal error, we need to panic here.
> > +		 * If there was a fatal machine check we should have
> > +		 * already called mce_panic earlier in this function.
> > +		 * Since we re-read the banks, we might have found
> > +		 * something new. Check again to see if we found a
> > +		 * fatal error. We call "mce_severity()" again to
> > +		 * make sure we have the right "msg".
> >  		 */
> > -		 if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
> > -			mce_panic("Machine check from unknown source",
> > -				NULL, NULL);
> > +		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
> > +			severity = mce_severity(&m, cfg->tolerant, &msg, true);
> > +			mce_panic("Local fatal machine check!", &m, msg);

If this doesn't affect mcelog parsing, would it make sense to change this from
"fatal" -> "Unrecoverable".. Fatal typically screams PCC=1 for x86, but
some of these cases are its Software recoverable, but just that Kernel 
isn't able to perform recovery.


> 
> Haha, this would still make you look at the code to remember was it
> "fatal local" or "local fatal" the second one. Yeah, there's the "!" but
> still.
> 
> How about:
> 
> 	"Fatal local machine check after banks scan"
> 
> or so.
> 
> Btw, the code in do_machine_check() has become one helluva spaghetti
> mess. It could use some clean up a bit... :)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
