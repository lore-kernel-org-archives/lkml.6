Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F68FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200F2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeIGGcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:32:39 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59463 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbeIGGcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:32:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fy5yN-0006re-8z; Fri, 07 Sep 2018 02:54:11 +0100
Message-ID: <1536285250.3024.101.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 123/124] crypto: padlock-aes - Fix Nano workaround
 data corruption
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     stable@vger.kernel.org,
        Jamie Heilman <jamie@audible.transient.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Sep 2018 02:54:10 +0100
In-Reply-To: <20180804082707.056362975@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
         <20180804082707.056362975@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 11:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> commit 46d8c4b28652d35dc6cfb5adf7f54e102fc04384 upstream.
> 
> This was detected by the self-test thanks to Ard's chunking patch.
> 
> I finally got around to testing this out on my ancient Via box.  It
> turns out that the workaround got the assembly wrong and we end up
> doing count + initial cycles of the loop instead of just count.
> 
> This obviously causes corruption, either by overwriting the source
> that is yet to be processed, or writing over the end of the buffer.
> 
> On CPUs that don't require the workaround only ECB is affected.
> On Nano CPUs both ECB and CBC are affected.
> 
> This patch fixes it by doing the subtraction prior to the assembly.
[...]
> --- a/drivers/crypto/padlock-aes.c
> +++ b/drivers/crypto/padlock-aes.c
> @@ -266,6 +266,8 @@ static inline void padlock_xcrypt_ecb(co
> >  		return;
> >  	}
>  
> +	count -= initial;
> +
>  	if (initial)
>  		asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
>  			      : "+S"(input), "+D"(output)
> @@ -273,7 +275,7 @@ static inline void padlock_xcrypt_ecb(co
>  
>  	asm volatile (".byte 0xf3,0x0f,0xa7,0xc8"	/* rep xcryptecb */
>  		      : "+S"(input), "+D"(output)
> -		      : "d"(control_word), "b"(key), "c"(count - initial));
> +		      : "d"(control_word), "b"(key), "c"(count));
>  }
>  
>  static inline u8 *padlock_xcrypt_cbc(const u8 *input, u8 *output, void *key,
[...]

On the face of it, this change shouldn't make any difference.  But I
think what's going on is that the compiler stores "initial" in register
ecx and nowhere else, because it has no idea that the first inline
assembly block will update ecx.

This change evidently works around that problem for the specific
compiler and configuration you tested with, but it seems fragile.  I
think the assembly constraints should be updated to properly fix this.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
