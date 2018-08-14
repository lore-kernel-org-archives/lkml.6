Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA27921711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA27921711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeHNKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:43:52 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:33882 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeHNKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:43:52 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fpUD2-0004X4-QE; Tue, 14 Aug 2018 09:57:44 +0200
Message-ID: <1534233405.3547.4.camel@sipsolutions.net>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Aug 2018 09:56:45 +0200
In-Reply-To: <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
References: <20180813220950.194841-1-arnd@arndb.de>
         <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 08:57 +0900, Masahiro Yamada wrote:
> 2018-08-14 7:09 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > Passing an enum into FIELD_GET() produces a long but harmless warning on
> > newer compilers:
> > 
> >                  from include/linux/linkage.h:7,
> >                  from include/linux/kernel.h:7,
> >                  from include/linux/skbuff.h:17,
> >                  from include/linux/if_ether.h:23,
> >                  from include/linux/etherdevice.h:25,
> >                  from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:63:
> > drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_rx_mpdu_mq':
> > include/linux/bitfield.h:56:20: error: enum constant in boolean context [-Werror=int-in-bool-context]
> >    BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero"); \
> >                     ^
> > ...
> > include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
> >    __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
> >    ^~~~~~~~~~~~~~~~
> > drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1025:21: note: in expansion of macro 'FIELD_GET'
> >     le16_encode_bits(FIELD_GET(IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK,
> 
> 
> How about fixing the root cause
> in drivers/net/wireless/intel/iwlwifi/fw/api/rx.h ?
> 
> 
> #define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL
> 
> 
> enum iwl_rx_he_phy looks really strange.

Why? I don't think this is a problem, the enum is used here to get
constants so that we can also have documentation for them. That's a
common and accepted technique.


> Passing enum to FIELD_GET is odd,
> so I prefer keeping this warned.

What for?

I think we should go with Arend's patch, and I hope Andrew will pick it
up, but otherwise I guess we can also put it through any other tree.

johannes
