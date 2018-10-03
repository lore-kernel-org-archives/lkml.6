Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51884C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A89213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A89213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJDCCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:02:22 -0400
Received: from namei.org ([65.99.196.166]:35472 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbeJDCCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:02:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w93JCeZc017052;
        Wed, 3 Oct 2018 19:12:40 GMT
Date:   Thu, 4 Oct 2018 05:12:40 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] KEYS: Make the X.509 and PKCS7 parsers supply the
 sig encoding type
In-Reply-To: <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1810040511390.16168@namei.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618448451.7946.79126788153992612.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, David Howells wrote:

> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index b6cabac4b62b..991f4d735a4e 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -199,35 +199,32 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>  
>  	case OID_md4WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "md4";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha1WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha1";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha256WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha256";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha384WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha384";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha512WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha512";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  
>  	case OID_sha224WithRSAEncryption:
>  		ctx->cert->sig->hash_algo = "sha224";
> -		ctx->cert->sig->pkey_algo = "rsa";
> -		break;
> +		goto rsa_pkcs1;
>  	}
>  
> +rsa_pkcs1:
> +	ctx->cert->sig->pkey_algo = "rsa";
> +	ctx->cert->sig->encoding = "pkcs1";
>  	ctx->algo_oid = ctx->last_oid;
>  	return 0;
>  }

Perhaps I'm missing something here but why do you need the gotos vs. just 
breaking to this code?


-- 
James Morris
<jmorris@namei.org>

