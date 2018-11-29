Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7286C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E48213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoP8TsNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E48213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeK3FWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeK3FWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:22:43 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EC52082F;
        Thu, 29 Nov 2018 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543515388;
        bh=Dp0LkS6uE745iociusXPwE5zgfLXhHTt6w5mU3m6KCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoP8TsNAJTtdsBou2xP6GObI9WUWgUoYe7Jv3UzA28Gg6Xra+Qz1+LLqkj57Jb4BA
         eMf8KTX2rXyDsBIyWqXeK3WoA0HSMXCEmMNf7B0SSxYBY3g8ldWJ7kCZCPcUpYIv7t
         GOLvgV7asNw8HmOqR+vwcqJ0NcHaB5webf9ba/+s=
Date:   Thu, 29 Nov 2018 10:16:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] crypto: crypto_user_stat: misc enhancement
Message-ID: <20181129181625.GA168705@gmail.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:42:15PM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes all reported problem by Eric biggers.
> 
> Regards
> 
> Changes since v4:
> - Inlined functions when !CRYPTO_STATS
> 
> Changes since v3:
> - Added a crypto_stats_init as asked vy Neil Horman
> - Fixed some checkpatch complaints
> 
> Changes since v2:
> - moved all crypto_stats functions from header to algapi.c for using
>   crypto_alg_get/put
> 
> Changes since v1:
> - Better locking of crypto_alg via crypto_alg_get/crypto_alg_put
> - remove all intermediate variables in crypto/crypto_user_stat.c
> - splited all internal stats variables into different structures
> 
> Corentin Labbe (11):
>   crypto: crypto_user_stat: made crypto_user_stat optional
>   crypto: CRYPTO_STATS should depend on CRYPTO_USER
>   crypto: crypto_user_stat: convert all stats from u32 to u64
>   crypto: crypto_user_stat: split user space crypto stat structures
>   crypto: tool: getstat: convert user space example to the new
>     crypto_user_stat uapi
>   crypto: crypto_user_stat: fix use_after_free of struct xxx_request
>   crypto: crypto_user_stat: Fix invalid stat reporting
>   crypto: crypto_user_stat: remove intermediate variable
>   crypto: crypto_user_stat: Split stats in multiple structures
>   crypto: crypto_user_stat: rename err_cnt parameter
>   crypto: crypto_user_stat: Add crypto_stats_init
> 
>  crypto/Kconfig                       |   1 +
>  crypto/Makefile                      |   3 +-
>  crypto/ahash.c                       |  17 +-
>  crypto/algapi.c                      | 247 ++++++++++++++++++++++-
>  crypto/crypto_user_stat.c            | 160 +++++----------
>  crypto/rng.c                         |   4 +-
>  include/crypto/acompress.h           |  38 +---
>  include/crypto/aead.h                |  38 +---
>  include/crypto/akcipher.h            |  74 ++-----
>  include/crypto/hash.h                |  32 +--
>  include/crypto/internal/cryptouser.h |  17 ++
>  include/crypto/kpp.h                 |  48 +----
>  include/crypto/rng.h                 |  27 +--
>  include/crypto/skcipher.h            |  36 +---
>  include/linux/crypto.h               | 290 ++++++++++++++++++---------
>  include/uapi/linux/cryptouser.h      | 102 ++++++----
>  tools/crypto/getstat.c               |  72 +++----
>  17 files changed, 676 insertions(+), 530 deletions(-)
> 
> -- 
> 2.18.1
> 

Thanks Corentin, it looks like this addresses the biggest problems.

(Though I haven't checked everything full detail, like whether every stats value
actually provides something meaningful and correct.  Note also that successful
asynchronous operations are not being counted, but that can be fixed later...)

Herbert, can you send this series to Linus for v4.20 after reviewing it?
We don't want to be stuck with a bad UAPI, and the use-after-free needs to be
fixed anyway too.

- Eric
