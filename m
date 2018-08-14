Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F054C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3BD21570
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3BD21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeHOCAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:00:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOCAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:00:33 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 508D9D10;
        Tue, 14 Aug 2018 23:11:07 +0000 (UTC)
Date:   Tue, 14 Aug 2018 16:11:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Message-Id: <20180814161106.67b835906381415843ddbab6@linux-foundation.org>
In-Reply-To: <20180813220950.194841-1-arnd@arndb.de>
References: <20180813220950.194841-1-arnd@arndb.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 00:09:34 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> Passing an enum into FIELD_GET() produces a long but harmless warning on
> newer compilers:
> 
>                  from include/linux/linkage.h:7,
>                  from include/linux/kernel.h:7,
>                  from include/linux/skbuff.h:17,
>                  from include/linux/if_ether.h:23,
>                  from include/linux/etherdevice.h:25,
>                  from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:63:
> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_rx_mpdu_mq':
> include/linux/bitfield.h:56:20: error: enum constant in boolean context [-Werror=int-in-bool-context]
>    BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero"); \
>                     ^
> ...
> include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
>    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
>    ^~~~~~~~~~~~~~~~
> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1025:21: note: in expansion of macro 'FIELD_GET'
>     le16_encode_bits(FIELD_GET(IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK,

Newer compilers will previously be used on older kernels, so I'll add a
cc:stable here.

> The problem here is that the caller has no idea how the macro gets
> expanding, leading to a false-positive. It can be trivially avoided
> by doing a comparison against zero.
> 
> This only recently started appearing as the iwlwifi driver was patched
> to use FIELD_GET.
> 
> Fixes: 514c30696fbc ("iwlwifi: add support for IEEE802.11ax")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/bitfield.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 65a6981eef7b..3f1ef4450a7c 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -53,7 +53,7 @@
>  	({								\
>  		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
>  				 _pfx "mask is not constant");		\
> -		BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero");	\
> +		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
>  		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
>  				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \

I'm not understanding how a switch from !x to x==0 can fix anything. 
Help!

