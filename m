Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934088AbeE1Utb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50569 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932451AbeE1Uta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:49:30 -0400
Date: Mon, 28 May 2018 22:49:23 +0200
From: Borislav Petkov <bp@suse.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/mce: Fix incorrect "Machine check from unknown
 source" message
Message-ID: <20180528204923.GB30792@zn.tnic>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 02:41:55PM -0700, Tony Luck wrote:
> @@ -1287,12 +1292,17 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  			no_way_out = worst >= MCE_PANIC_SEVERITY;
>  	} else {
>  		/*
> -		 * Local MCE skipped calling mce_reign()
> -		 * If we found a fatal error, we need to panic here.
> +		 * If there was a fatal machine check we should have
> +		 * already called mce_panic earlier in this function.
> +		 * Since we re-read the banks, we might have found
> +		 * something new. Check again to see if we found a
> +		 * fatal error. We call "mce_severity()" again to
> +		 * make sure we have the right "msg".
>  		 */
> -		 if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
> -			mce_panic("Machine check from unknown source",
> -				NULL, NULL);
> +		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
> +			severity = mce_severity(&m, cfg->tolerant, &msg, true);
> +			mce_panic("Local fatal machine check!", &m, msg);

Haha, this would still make you look at the code to remember was it
"fatal local" or "local fatal" the second one. Yeah, there's the "!" but
still.

How about:

	"Fatal local machine check after banks scan"

or so.

Btw, the code in do_machine_check() has become one helluva spaghetti
mess. It could use some clean up a bit... :)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
