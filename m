Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032202AbeEZQ1j (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:27:39 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39738 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032091AbeEZQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:27:38 -0400
Date: Sun, 27 May 2018 00:27:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Harsh Jain <harsh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Michael Werner <werner@chelsio.com>, Casey Leedom <leedom@chelsio.com>,
        "open list:CXGB4 CRYPTO DRIVER (chcr)" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: chtls - fix a missing-check bug
Message-ID: <20180526162729.vwxxnr6po36ipz7h@gondor.apana.org.au>
References: <1526673338-486-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526673338-486-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 02:55:35PM -0500, Wenwen Wang wrote:
> In do_chtls_setsockopt(), the tls crypto info is first copied from the
> poiner 'optval' in userspace and saved to 'tmp_crypto_info'. Then the
> 'version' of the crypto info is checked. If the version is not as expected,
> i.e., TLS_1_2_VERSION, error code -ENOTSUPP is returned to indicate that
> the provided crypto info is not supported yet. Then, the 'cipher_type'
> field of the 'tmp_crypto_info' is also checked to see if it is
> TLS_CIPHER_AES_GCM_128. If it is, the whole struct of
> tls12_crypto_info_aes_gcm_128 is copied from the pointer 'optval' and then
> the function chtls_setkey() is invoked to set the key.
> 
> Given that the 'optval' pointer resides in userspace, a malicious userspace
> process can race to change the data pointed by 'optval' between the two
> copies. For example, a user can provide a crypto info with TLS_1_2_VERSION
> and TLS_CIPHER_AES_GCM_128. After the first copy, the user can modify the
> 'version' and the 'cipher_type' fields to any versions and/or cipher types
> that are not allowed. This way, the user can bypass the checks, inject
> bad data to the kernel, cause chtls_setkey() to set a wrong key or other
> issues.
> 
> This patch reuses the data copied in the first try so as to ensure these
> checks will not be bypassed.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
