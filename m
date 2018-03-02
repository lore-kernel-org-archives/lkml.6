Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbeCBXPa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:15:30 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:59754 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934228AbeCBXP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:15:29 -0500
Subject: Re: [PATCH 2/3] crypto: ccp - return an actual key size from RSA
 max_size callback
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
 <20180302164451.GJ21579@gondor.apana.org.au>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <087e7b27-f839-8d4b-8da8-5d0fa2f8caf1@maciej.szmigiero.name>
Date: Sat, 3 Mar 2018 00:15:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302164451.GJ21579@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.2018 17:44, Herbert Xu wrote:
> On Sat, Feb 24, 2018 at 05:03:21PM +0100, Maciej S. Szmigiero wrote:
>> rsa-pkcs1pad uses a value returned from a RSA implementation max_size
>> callback as a size of an input buffer passed to the RSA implementation for
>> encrypt and sign operations.
>>
>> CCP RSA implementation uses a hardware input buffer which size depends only
>> on the current RSA key length, so it should return this key length in
>> the max_size callback, too.
>> This also matches what the kernel software RSA implementation does.
>>
>> Previously, the value returned from this callback was always the maximum
>> RSA key size the CCP hardware supports.
>> This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
>> for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
>> tried to copy this large input buffer into a RSA key length-sized hardware
>> input buffer.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
>> Cc: stable@vger.kernel.org
> 
> Patch applied.  Thanks.

Thanks.

However, what about the first patch from this series?
Without it, while it no longer should cause a buffer overflow, in-kernel
X.509 certificate verification will still fail with CCP driver loaded
(since CCP RSA implementation has a higher priority than the software
RSA implementation).

Maciej
