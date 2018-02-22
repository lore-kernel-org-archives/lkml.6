Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeBVPNc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:13:32 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:57130 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932861AbeBVPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:13:31 -0500
Date: Thu, 22 Feb 2018 23:13:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dave Watson <davejwatson@fb.com>
Cc: Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: Re: [PATCH v2 00/14] x86/crypto gcmaes SSE scatter/gather support
Message-ID: <20180222151303.GI29815@gondor.apana.org.au>
References: <20180214173751.GA61573@davejwatson-mba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214173751.GA61573@davejwatson-mba>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 09:37:51AM -0800, Dave Watson wrote:
> This patch set refactors the x86 aes/gcm SSE crypto routines to
> support true scatter/gather by adding gcm_enc/dec_update methods.
> 
> The layout is:
> 
> * First 5 patches refactor the code to use macros, so changes only
>   need to be applied once for encode and decode.  There should be no
>   functional changes.
> 
> * The next 6 patches introduce a gcm_context structure to be passed
>   between scatter/gather calls to maintain state.  The struct is also
>   used as scratch space for the existing enc/dec routines.
> 
> * The last 2 set up the asm function entry points for scatter gather
>   support, and then call the new routines per buffer in the passed in
>   sglist in aesni-intel_glue.
> 
> Testing: 
> asm itself fuzz tested vs. existing code and isa-l asm.
> Ran libkcapi test suite, passes.
> 
> perf of a large (16k messages) TLS sends sg vs. no sg:
> 
> no-sg
> 
> 33287255597      cycles  
> 53702871176      instructions
> 
> 43.47%   _crypt_by_4
> 17.83%   memcpy
> 16.36%   aes_loop_par_enc_done
> 
> sg
> 
> 27568944591      cycles 
> 54580446678      instructions
> 
> 49.87%   _crypt_by_4
> 17.40%   aes_loop_par_enc_done
> 1.79%    aes_loop_initial_5416
> 1.52%    aes_loop_initial_4974
> 1.27%    gcmaes_encrypt_sg.constprop.15
> 
> V1 -> V2:
> 
> patch 14: merge enc/dec
>           also use new routine if cryptlen < AVX_GEN2_OPTSIZE
>           optimize case if assoc is already linear
> 
> Dave Watson (14):
>   x86/crypto: aesni: Merge INITIAL_BLOCKS_ENC/DEC
>   x86/crypto: aesni: Macro-ify func save/restore
>   x86/crypto: aesni: Add GCM_INIT macro
>   x86/crypto: aesni: Add GCM_COMPLETE macro
>   x86/crypto: aesni: Merge encode and decode to GCM_ENC_DEC macro
>   x86/crypto: aesni: Introduce gcm_context_data
>   x86/crypto: aesni: Split AAD hash calculation to separate macro
>   x86/crypto: aesni: Fill in new context data structures
>   x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
>   x86/crypto: aesni: Move HashKey computation from stack to gcm_context
>   x86/crypto: aesni: Introduce partial block macro
>   x86/crypto: aesni: Add fast path for > 16 byte update
>   x86/crypto: aesni: Introduce scatter/gather asm function stubs
>   x86/crypto: aesni: Update aesni-intel_glue to use scatter/gather
> 
>  arch/x86/crypto/aesni-intel_asm.S  | 1414 ++++++++++++++++++------------------
>  arch/x86/crypto/aesni-intel_glue.c |  230 +++++-
>  2 files changed, 899 insertions(+), 745 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
