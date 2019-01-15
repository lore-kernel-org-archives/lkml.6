Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A7A20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbfAOTTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:19:37 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:58236 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfAOTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:19:36 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-102-108-nat.elisa-mobile.fi [85.76.102.108])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id BFF74B0045;
        Tue, 15 Jan 2019 21:19:33 +0200 (EET)
Date:   Tue, 15 Jan 2019 21:19:33 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: user: Align the payload buffer
Message-ID: <20190115191933.GA27799@darkstar.musicnaut.iki.fi>
References: <20190115033716.18380-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115033716.18380-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 14, 2019 at 07:37:16PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Align the payload of "user" and "logon" keys so that users of the
> keyrings service can access it as a struct that requires more than
> 2-byte alignment.  fscrypt currently does this which results in the read
> of fscrypt_key::size being misaligned as it needs 4-byte alignment.
> 
> Align to __alignof__(u64) rather than __alignof__(long) since in the
> future it's conceivable that people would use structs beginning with
> u64, which on some platforms would require more than 'long' alignment.
> 
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
> Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This fixes the "unaligned access" dmesg spam on SPARC when using ext4
encryption.

Thanks,

A.

> ---
>  include/keys/user-type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index e098cbe27db54..12babe9915944 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -31,7 +31,7 @@
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
>  	unsigned short	datalen;	/* length of this data */
> -	char		data[0];	/* actual data */
> +	char		data[0] __aligned(__alignof__(u64)); /* actual data */
>  };
>  
>  extern struct key_type key_type_user;
> -- 
> 2.20.1
> 
