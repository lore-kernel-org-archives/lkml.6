Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91831C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079262172E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Z1YoVViE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079262172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeHNCnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:43:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41866 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:43:04 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7DNwFZK011875
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 08:58:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7DNwFZK011875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534204696;
        bh=NSrioI0575TzdBcRUH5l6DKgXQsJUPVySx8iXtvC/zQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Z1YoVViEnnplo6KmNY+T5u53g8c63rMSDQ2cww591YjAf7Va2iq7AVYy79dZncatf
         QoLHE1j9cB6+stSIUzkTKPA5M7/AZkDrF7TRAiwbaBC5g+ZdNY7Rg5XiYIRxwmJ6hl
         iLPQEDvL+//KlEDwSARX8KqxstvwYXXnTFm5+mm0TylbcIjyC7x5+bxIrRpKhSJ4Xe
         2hRB1tHFlh7Yf2/PK379v9rM/vs+jw79IreJmwt9rISrx7aRgpH3FUAqzCBe3hQp4Y
         MPHAfQ/l8xL3ezpdSn14/pkRwYGtO4tq/A9hKnHzrk65XWWb582+PzFwG4n3nl9FVI
         rnAXhUBwev6sA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id y10-v6so11238205uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:58:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlF0/p2j0QBY8hrBY08KtnndQZscSif5vELSgtfWc6xkfFKYHWy0
        i35ILxgYiMpoom8+iFPVlcfZqgGkohCaycnuU/M=
X-Google-Smtp-Source: AA+uWPy2H6iV9zyiQEMWBPxWSxkPD0NOlizVFwIrlWC/28LMYI6uoe3/WSibrudvzQPNsEewgTCVbIEBYk9eANdqPDI=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr12729488ual.141.1534204695042;
 Mon, 13 Aug 2018 16:58:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 16:57:34
 -0700 (PDT)
In-Reply-To: <20180813220950.194841-1-arnd@arndb.de>
References: <20180813220950.194841-1-arnd@arndb.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 08:57:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
Message-ID: <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 7:09 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
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


How about fixing the root cause
in drivers/net/wireless/intel/iwlwifi/fw/api/rx.h ?


#define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL


enum iwl_rx_he_phy looks really strange.



Passing enum to FIELD_GET is odd,
so I prefer keeping this warned.



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
>         ({                                                              \
>                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>                                  _pfx "mask is not constant");          \
> -               BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero");        \
> +               BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
>                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>                                  ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
>                                  _pfx "value too large for the field"); \
> --
> 2.18.0
>



-- 
Best Regards
Masahiro Yamada
