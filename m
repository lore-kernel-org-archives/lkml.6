Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0072089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0072089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIOMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:12:48 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39072 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:12:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5E7B472CA57;
        Tue,  9 Oct 2018 09:57:20 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 3F85D4A4A29;
        Tue,  9 Oct 2018 09:57:20 +0300 (MSK)
Date:   Tue, 9 Oct 2018 09:57:19 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Subject: Re: [PATCH 1/2] crypto: streebog - add Streebog hash function
Message-ID: <20181009065719.5cb2lk7fdulfcyvp@sole.flsd.net>
References: <20181007094114.16777-1-vt@altlinux.org>
 <20181007094114.16777-2-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181007094114.16777-2-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 12:41:10PM +0300, Vitaly Chikunov wrote:
> Add GOST/IETF Streebog hash function (GOST R 34.11-2012, RFC 6986)
> generic hash transformation.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  crypto/Kconfig            |   12 +
>  crypto/Makefile           |    1 +
>  crypto/streebog_generic.c | 1142 +++++++++++++++++++++++++++++++++++++++++++++
>  include/crypto/streebog.h |   34 ++
>  4 files changed, 1189 insertions(+)
>  create mode 100644 crypto/streebog_generic.c
>  create mode 100644 include/crypto/streebog.h
> 
> diff --git a/crypto/streebog_generic.c b/crypto/streebog_generic.c
> --- /dev/null
> +++ b/crypto/streebog_generic.c
> @@ -0,0 +1,1142 @@
>> ...
> +static inline void add512(const struct streebog_uint512 *x,
> +			  const struct streebog_uint512 *y,
> +			  struct streebog_uint512 *r)
> +{
> +	u64 carry = 0;
> +	int i;
> +
> +	for (i = 0; i < 8; i++) {
> +		const u64 left = le64_to_cpu(x->qword[i]);
> +		u64 sum;
> +
> +		sum = left + le64_to_cpu(y->qword[i]) + carry;
> +		if (sum != left)
> +			carry = (sum < left);
> +		r->qword[i] = sum;

Last assignment should be: r->qword[i] = cpu_to_le64(sum).

