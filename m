Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDZJo6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:44:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45352 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbeDZJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:44:56 -0400
Date: Thu, 26 Apr 2018 17:44:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Dey, Megha" <megha.dey@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Message-ID: <20180426094445.4jiwondmtbenepo2@gondor.apana.org.au>
References: <1515542948-24041-1-git-send-email-megha.dey@linux.intel.com>
 <1515542948-24041-2-git-send-email-megha.dey@linux.intel.com>
 <20180118113905.GA19904@gondor.apana.org.au>
 <1516322661.2526.3.camel@megha-Z97X-UD7-TH>
 <20180316145351.GA6231@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13267@ORSMSX111.amr.corp.intel.com>
 <20180418110115.v2w3o5yfv4u3gc4r@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13DDE@ORSMSX111.amr.corp.intel.com>
 <20180419032525.6csodbz6lrksyudd@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C270FC@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C440BA31B54DCD4AAC682D2365C8FEE738C270FC@ORSMSX111.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 01:14:26AM +0000, Dey, Megha wrote:
> 
> Is there any existing implementation of async crypto algorithm that uses the above approach? The ones I could find are either sync, have an outer and inner algorithm or use cryptd.
> 
> I tried removing the mcryptd layer and the outer algorithm and some plumbing to pass the correct structures, but see crashes.(obviously some errors in the plumbing)

OK, you can't just remove it because the inner algorithm requires
kernel_fpu_begin/kernel_fpu_end.  So we do need two layers but I
don't think we need cryptd or mcryptd.

The existing simd wrapper should work just fine on the inner
algorithm, provided that we add hash support to it.

> I am not sure if we remove mcryptd, how would we queue work, flush partially completed jobs or call completions (currently done by mcryptd) if we simply call the inner algorithm.

I don't think mcryptd is providing any real facility to the flushing
apart from a helper.  That same helper can live anywhere.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
