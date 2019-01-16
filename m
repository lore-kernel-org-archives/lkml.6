Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63064C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2603D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547620927;
	bh=nCjBvjWzlshzjVQ+JuboqlmQg60ggAfDKKYnEgegqu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KuSt9clao+tKTVfURLHPqZFsJwgsctvm82DFqkDzaZ+7u/uKSfjQid5naqkGvBHOb
	 5nDMdleyp4Oul8Pgu5IABfbnM9FcFA79YBxVS2eQGU9y0sfGO7kC5XuWiFu/d5GnhS
	 MC9KBvtXXzOwrMX5yX8SVKnX/PA/Vmv/IIOQ5LdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfAPGmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730938AbfAPGmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:42:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5715B20840;
        Wed, 16 Jan 2019 06:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547620924;
        bh=nCjBvjWzlshzjVQ+JuboqlmQg60ggAfDKKYnEgegqu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YS3tahL4R+Y8oL1p8JJBrPBV1F5lbNasJ4Enz35L87dWIzzaloOYJU8LFywrlqN0s
         Y3sNrsM5QvTSbONQGhJwwxXfXnLMOm9nLSOfTbF3+chaCE65O6b1PsnVkJQ17NAOJk
         unL99Tz/SShDcumZ+EFb06JFEA0d0uvT7+Dchf9c=
Date:   Wed, 16 Jan 2019 07:42:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix build error with Clang when
 inlining is disabled
Message-ID: <20190116064202.GA25498@kroah.com>
References: <20190116060302.8882-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116060302.8882-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:03:02PM -0700, Nathan Chancellor wrote:
> When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
> '-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
> Clang failed at the modpost stage:
> 
> ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
> 
> These functions were marked as extern inline, meaning that if inlining
> doesn't happen, the function will be undefined, as it is above.
> 
> This happens to work with GCC because the '-fno-inline-functions' option
> respects the __inline attribute so all instances of these functions are
> inlined as expected and the definition doesn't actually matter. However,
> with Clang and '-fno-inline-functions', a function has to be marked with
> the __always_inline attribute to be considered for inlining, which none
> of these functions are. Clang tries to find the symbol definition
> elsewhere as it was told and fails, which trickles down to modpost.
> 
> To make sure that this code compiles regardless of compiler and make the
> intention of the code clearer, use 'static __always_inline' to ensure
> that these functions are always inlined. Some alternative solutions
> included 'extern __always_inline' or converting these functions to
> macros (so the preprocessor deals with them) but I would argue this is
> the more "standard" solution.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> index bcc8dfa8e672..959e822315b5 100644
> --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> @@ -850,18 +850,18 @@ enum ieee80211_state {
>  #define IP_FMT "%pI4"
>  #define IP_ARG(x) (x)
>  
> -extern __inline int is_multicast_mac_addr(const u8 *addr)
> +static __always_inline int is_multicast_mac_addr(const u8 *addr)

Ick, really?  This is in a .h file, the .c file sees this, so why isn't
clang picking it up?  Worst case it just makes it a "normal" function
and doesn't inline it, right?

How about just replacing "extern" with "static", that should solve this,
adding "__always_inline" everywhere is not going to be fun and doesn't
make any sense.

thanks,

greg k-h
